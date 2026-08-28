# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 574: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 588: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormNfl.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (11095 linhas total):

*-- Linhas 33 a 41:
33:         loc_lSucesso = .F.
34: 
35:         TRY
36:             THIS.Caption = "Configura" + CHR(231) + CHR(227) + "o de Nota Fiscal"
37: 
38:             THIS.this_oBusinessObject = CREATEOBJECT("NflBO")
39: 
40:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
41:                 MsgErro("Erro ao criar NflBO.", "FormNfl")

*-- Linhas 91 a 107:
91:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
92:         WITH THIS.pgf_4c_Paginas
93:             .PageCount   = 2
94:             .Top         = -29
95:             .Left        = 0
96:             .Width       = THIS.Width
97:             .Height      = THIS.Height + 29
98:             .Tabs        = .F.
99:             .Visible     = .T.
100:             .Page1.Caption = "Lista"
101:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page2.Caption = "Dados"
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page1.BackColor = RGB(255, 255, 255)
105:             .Page2.BackColor = RGB(255, 255, 255)
106:         ENDWITH
107:     ENDPROC

*-- Linhas 117 a 148:
117:         *-- Cabecalho (faixa escura com titulo shadow + titulo principal)
118:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
119:         WITH loc_oPagina.cnt_4c_Cabecalho
120:             .Top       = 2
121:             .Left      = 0
122:             .Width     = THIS.Width
123:             .Height    = 80
124:             .BackColor = RGB(100, 100, 100)
125:             .Visible   = .T.
126:             .AddObject("lbl_4c_Sombra", "Label")
127:             WITH .lbl_4c_Sombra
128:                 .Caption   = "Configura" + CHR(231) + CHR(227) + "o de Nota Fiscal"
129:                 .Top       = 35
130:                 .Left      = 22
131:                 .Width     = THIS.Width
132:                 .Height    = 28
133:                 .FontName  = "Tahoma"
134:                 .FontSize  = 16
135:                 .ForeColor = RGB(0, 0, 0)
136:                 .BackStyle = 0
137:                 .Visible   = .T.
138:             ENDWITH
139:             .AddObject("lbl_4c_Titulo", "Label")
140:             WITH .lbl_4c_Titulo
141:                 .Caption   = "Configura" + CHR(231) + CHR(227) + "o de Nota Fiscal"
142:                 .Top       = 33
143:                 .Left      = 20
144:                 .Width     = THIS.Width
145:                 .Height    = 28
146:                 .FontName  = "Tahoma"
147:                 .FontSize  = 16
148:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 154 a 279:
154:         *-- Container CRUD (Left=542 canonico)
155:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
156:         WITH loc_oPagina.cnt_4c_Botoes
157:             .Top         = 0
158:             .Left        = 542
159:             .Width       = 375
160:             .Height      = 85
161:             .BackStyle   = 0
162:             .BorderWidth = 0
163:             .Visible     = .T.
164:             .AddObject("cmd_4c_Incluir", "CommandButton")
165:             WITH .cmd_4c_Incluir
166:                 .Top     = 5
167:                 .Left    =  542
168:                 .Width   = 70
169:                 .Height  = 70
170:                 .Caption = "Incluir"
171:                 .Picture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
172:                 .Visible = .T.
173:             ENDWITH
174:             .AddObject("cmd_4c_Visualizar", "CommandButton")
175:             WITH .cmd_4c_Visualizar
176:                 .Top     = 5
177:                 .Left    =  542
178:                 .Width   = 70
179:                 .Height  = 70
180:                 .Caption = "Visualizar"
181:                 .Picture = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
182:                 .Visible = .T.
183:             ENDWITH
184:             .AddObject("cmd_4c_Alterar", "CommandButton")
185:             WITH .cmd_4c_Alterar
186:                 .Top     = 5
187:                 .Left    =  542
188:                 .Width   = 70
189:                 .Height  = 70
190:                 .Caption = "Alterar"
191:                 .Picture = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
192:                 .Visible = .T.
193:             ENDWITH
194:             .AddObject("cmd_4c_Excluir", "CommandButton")
195:             WITH .cmd_4c_Excluir
196:                 .Top     = 5
197:                 .Left    =  542
198:                 .Width   = 70
199:                 .Height  = 70
200:                 .Caption = "Excluir"
201:                 .Picture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
202:                 .Visible = .T.
203:             ENDWITH
204:             .AddObject("cmd_4c_Buscar", "CommandButton")
205:             WITH .cmd_4c_Buscar
206:                 .Top     = 5
207:                 .Left    =  542
208:                 .Width   = 70
209:                 .Height  = 70
210:                 .Caption = "Buscar"
211:                 .Picture = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
212:                 .Visible = .T.
213:             ENDWITH
214:         ENDWITH
215: 
216:         *-- Botao Copia (especifico SIGCDNFL, entre CRUD e ExpXML)
217:         loc_oPagina.AddObject("cmd_4c_Copia", "CommandButton")
218:         WITH loc_oPagina.cmd_4c_Copia
219:             .Top     = 5
220:             .Left    = 471
221:             .Width   = 70
222:             .Height  = 70
223:             .Caption = "Copia"
224:             .Visible = .T.
225:         ENDWITH
226: 
227:         *-- Container Saida (canonico Left=917, Width=90)
228:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
229:         WITH loc_oPagina.cnt_4c_Saida
230:             .Top         = 0
231:             .Left        = 917
232:             .Width       = 90
233:             .Height      = 85
234:             .BackStyle   = 0
235:             .BorderWidth = 0
236:             .Visible     = .T.
237:             .AddObject("cmd_4c_Encerrar", "CommandButton")
238:             WITH .cmd_4c_Encerrar
239:                 .Top     = 5
240:                 .Left    = 917
241:                 .Width   = 90
242:                 .Height  = 75
243:                 .Caption = "Encerrar"
244:                 .Picture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
245:                 .Visible = .T.
246:             ENDWITH
247:         ENDWITH
248: 
249:         *-- Botoes XML especificos (Top=82+29=111 compensado)
250:         loc_oPagina.AddObject("cmd_4c_BtnExpXML", "CommandButton")
251:         WITH loc_oPagina.cmd_4c_BtnExpXML
252:             .Top     = 111
253:             .Left    = 682
254:             .Width   = 120
255:             .Height  = 45
256:             .Caption = "Exportar XML"
257:             .Visible = .T.
258:         ENDWITH
259: 
260:         loc_oPagina.AddObject("cmd_4c_BtnImpXML", "CommandButton")
261:         WITH loc_oPagina.cmd_4c_BtnImpXML
262:             .Top     = 111
263:             .Left    = 804
264:             .Width   = 120
265:             .Height  = 45
266:             .Caption = "Importar XML"
267:             .Visible = .T.
268:         ENDWITH
269: 
270:         *-- Grid Lista (Top=135+29=164 compensado; Width=971 original)
271:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
272:         WITH loc_oPagina.grd_4c_Lista
273:             .Top          = 164
274:             .Left         = 12
275:             .Width        = 971
276:             .Height       = 450
277:             .FontName     = "Tahoma"
278:             .FontSize     = 8
279:             .ColumnCount  = 4

*-- Linhas 287 a 396:
287:                 .ControlSource   = "cursor_4c_Dados.emps"
288:                 .Width           = 55
289:                 .ReadOnly        = .T.
290:                 .Header1.Caption = "Empr."
291:             ENDWITH
292:             WITH .Column2
293:                 .ControlSource   = "cursor_4c_Dados.Razas"
294:                 .Width           = 220
295:                 .ReadOnly        = .T.
296:                 .Header1.Caption = "Empresa"
297:             ENDWITH
298:             WITH .Column3
299:                 .ControlSource   = "cursor_4c_Dados.series"
300:                 .Width           = 55
301:                 .ReadOnly        = .T.
302:                 .Header1.Caption = "S" + CHR(233) + "rie"
303:             ENDWITH
304:             WITH .Column4
305:                 .ControlSource   = "cursor_4c_Dados.cidchaves"
306:                 .Width           = 641
307:                 .ReadOnly        = .T.
308:                 .Header1.Caption = "Chave"
309:             ENDWITH
310:         ENDWITH
311:         THIS.FormatarGridLista(loc_oPagina.grd_4c_Lista)
312: 
313:         *-- Container cntcopia (flutuante, inicialmente oculto)
314:         *-- Top=244+29=273 compensado; Left=257 como no legado
315:         loc_oPagina.AddObject("cnt_4c_copia", "Container")
316:         WITH loc_oPagina.cnt_4c_copia
317:             .Top         = 273
318:             .Left        = 257
319:             .Width       = 484
320:             .Height      = 116
321:             .BackColor   = RGB(240, 240, 240)
322:             .BorderWidth = 1
323:             .Visible     = .F.
324:             .AddObject("lbl_4c_CopSerie", "Label")
325:             WITH .lbl_4c_CopSerie
326:                 .Caption   = "S" + CHR(233) + "rie Dest.:"
327:                 .Top       = 8
328:                 .Left      = 5
329:                 .Width     = 100
330:                 .Height    = 20
331:                 .Visible   = .T.
332:             ENDWITH
333:             .AddObject("txt_4c_nomedest", "TextBox")
334:             WITH .txt_4c_nomedest
335:                 .Top       = 5
336:                 .Left      = 110
337:                 .Width     = 80
338:                 .Height    = 22
339:                 .MaxLength = 3
340:                 .Visible   = .T.
341:             ENDWITH
342:             .AddObject("lbl_4c_CopEmp", "Label")
343:             WITH .lbl_4c_CopEmp
344:                 .Caption   = "Empresa Dest.:"
345:                 .Top       = 38
346:                 .Left      = 5
347:                 .Width     = 100
348:                 .Height    = 20
349:                 .Visible   = .T.
350:             ENDWITH
351:             .AddObject("txt_4c_empDest", "TextBox")
352:             WITH .txt_4c_empDest
353:                 .Top       = 35
354:                 .Left      = 110
355:                 .Width     = 50
356:                 .Height    = 22
357:                 .MaxLength = 2
358:                 .Visible   = .T.
359:             ENDWITH
360:             .AddObject("cmd_4c_OK", "CommandButton")
361:             WITH .cmd_4c_OK
362:                 .Top     = 83
363:                 .Left    = 310
364:                 .Width   = 70
365:                 .Height  = 25
366:                 .Caption = "OK"
367:                 .Visible = .T.
368:             ENDWITH
369:             .AddObject("cmd_4c_Cancela", "CommandButton")
370:             WITH .cmd_4c_Cancela
371:                 .Top     = 83
372:                 .Left    = 390
373:                 .Width   = 85
374:                 .Height  = 25
375:                 .Caption = "Cancelar"
376:                 .Visible = .T.
377:             ENDWITH
378:         ENDWITH
379: 
380:         *-- BINDEVENTs (handlers PUBLIC obrigatorio para BINDEVENT funcionar)
381:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
382:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
383:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
384:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
385:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
386:         BINDEVENT(loc_oPagina.cmd_4c_Copia,                    "Click", THIS, "BtnCopiaClick")
387:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
388:         BINDEVENT(loc_oPagina.cmd_4c_BtnExpXML,                "Click", THIS, "BtnExpXMLClick")
389:         BINDEVENT(loc_oPagina.cmd_4c_BtnImpXML,                "Click", THIS, "BtnImpXMLClick")
390:         BINDEVENT(loc_oPagina.cnt_4c_copia.cmd_4c_OK,          "Click",    THIS, "CntCopiaOKClick")
391:         BINDEVENT(loc_oPagina.cnt_4c_copia.cmd_4c_Cancela,     "Click",    THIS, "CntCopiaCancelaClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_copia.txt_4c_nomedest,    "KeyPress", THIS, "NomedestKeyPress")
393:         BINDEVENT(loc_oPagina.cnt_4c_copia.txt_4c_nomedest,    "DblClick", THIS, "NomedestDblClick")
394:         BINDEVENT(loc_oPagina.cnt_4c_copia.txt_4c_empDest,     "KeyPress", THIS, "EmpDestKeyPress")
395:         BINDEVENT(loc_oPagina.cnt_4c_copia.txt_4c_empDest,     "DblClick", THIS, "EmpDestDblClick")
396:     ENDPROC

*-- Linhas 404 a 621:
404:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
405: 
406:         *-- Serie (Top original=27/23, +29 comp)
407:         loc_oPagina.AddObject("lbl_4c_LblSerie", "Label")
408:         WITH loc_oPagina.lbl_4c_LblSerie
409:             .Caption   = "S" + CHR(233) + "rie :"
410:             .Top       = 56
411:             .Left      = 23
412:             .Height    = 15
413:             .Width     = 45
414:             .FontName  = "Tahoma"
415:             .FontSize  = 8
416:             .BackStyle = 0
417:             .ForeColor = RGB(90, 90, 90)
418:             .Visible   = .T.
419:         ENDWITH
420:         loc_oPagina.AddObject("txt_4c_Series", "TextBox")
421:         WITH loc_oPagina.txt_4c_Series
422:             .Top           = 52
423:             .Left          = 65
424:             .Width         = 31
425:             .Height        = 24
426:             .MaxLength     = 3
427:             .FontName      = "Tahoma"
428:             .FontSize      = 8
429:             .SpecialEffect = 1
430:             .Visible       = .T.
431:         ENDWITH
432: 
433:         *-- Proxima Nota Fiscal (Top original=25/21, +29 comp)
434:         loc_oPagina.AddObject("lbl_4c_LblProxNota", "Label")
435:         WITH loc_oPagina.lbl_4c_LblProxNota
436:             .Caption   = "Pr" + CHR(243) + "xima Nota Fiscal :"
437:             .Top       = 54
438:             .Left      = 132
439:             .Width     = 105
440:             .Height    = 15
441:             .FontName  = "Tahoma"
442:             .FontSize  = 8
443:             .BackStyle = 0
444:             .ForeColor = RGB(90, 90, 90)
445:             .Visible   = .T.
446:         ENDWITH
447:         loc_oPagina.AddObject("txt_4c_ProxNota", "TextBox")
448:         WITH loc_oPagina.txt_4c_ProxNota
449:             .Top           = 50
450:             .Left          = 245
451:             .Width         = 89
452:             .Height        = 21
453:             .FontName      = "Tahoma"
454:             .FontSize      = 8
455:             .SpecialEffect = 1
456:             .Visible       = .T.
457:         ENDWITH
458: 
459:         *-- Proximo Selo (Top original=49/45, +29 comp)
460:         loc_oPagina.AddObject("lbl_4c_LblProxSelo", "Label")
461:         WITH loc_oPagina.lbl_4c_LblProxSelo
462:             .Caption   = "Pr" + CHR(243) + "ximo Selo :"
463:             .Top       = 78
464:             .Left      = 164
465:             .Width     = 73
466:             .Height    = 15
467:             .FontName  = "Tahoma"
468:             .FontSize  = 8
469:             .BackStyle = 0
470:             .ForeColor = RGB(90, 90, 90)
471:             .Visible   = .T.
472:         ENDWITH
473:         loc_oPagina.AddObject("txt_4c_ProxSelo", "TextBox")
474:         WITH loc_oPagina.txt_4c_ProxSelo
475:             .Top           = 74
476:             .Left          = 245
477:             .Width         = 89
478:             .Height        = 21
479:             .FontName      = "Tahoma"
480:             .FontSize      = 8
481:             .SpecialEffect = 1
482:             .Visible       = .T.
483:         ENDWITH
484: 
485:         *-- Proximo Selo Transporte (Top original=73/69, +29 comp)
486:         loc_oPagina.AddObject("lbl_4c_LblProxSeloTrans", "Label")
487:         WITH loc_oPagina.lbl_4c_LblProxSeloTrans
488:             .Caption   = "Pr" + CHR(243) + "ximo Selo Transporte :"
489:             .Top       = 102
490:             .Left      = 108
491:             .Width     = 129
492:             .Height    = 15
493:             .FontName  = "Tahoma"
494:             .FontSize  = 8
495:             .BackStyle = 0
496:             .ForeColor = RGB(90, 90, 90)
497:             .Visible   = .T.
498:         ENDWITH
499:         loc_oPagina.AddObject("txt_4c_ProxSeloTrans", "TextBox")
500:         WITH loc_oPagina.txt_4c_ProxSeloTrans
501:             .Top           = 98
502:             .Left          = 245
503:             .Width         = 89
504:             .Height        = 21
505:             .FontName      = "Tahoma"
506:             .FontSize      = 8
507:             .SpecialEffect = 1
508:             .Visible       = .T.
509:         ENDWITH
510: 
511:         *-- Casas Decimais dos Itens (Top original=98/96, +29 comp)
512:         loc_oPagina.AddObject("lbl_4c_LblCasas", "Label")
513:         WITH loc_oPagina.lbl_4c_LblCasas
514:             .Caption   = "No. de Casas Decimais dos Itens :"
515:             .Top       = 127
516:             .Left      = 72
517:             .Height    = 15
518:             .Width     = 165
519:             .FontName  = "Tahoma"
520:             .FontSize  = 8
521:             .BackStyle = 0
522:             .ForeColor = RGB(90, 90, 90)
523:             .Visible   = .T.
524:         ENDWITH
525:         loc_oPagina.AddObject("obj_4c_Op_ItCasas", "OptionGroup")
526:         WITH loc_oPagina.obj_4c_Op_ItCasas
527:             .Top         = 125
528:             .Left        = 242
529:             .Width       = 126
530:             .Height      = 20
531:             .BackStyle   = 0
532:             .BorderStyle = 0
533:             .Value       = 1
534:             .Visible     = .T.
535:             WITH .Buttons(1)
536:                 .Caption   = "2 Casas"
537:                 .Left      = 5
538:                 .Top       = 2
539:                 .AutoSize  = .T.
540:                 .BackStyle = 0
541:                 .ForeColor = RGB(90, 90, 90)
542:             ENDWITH
543:             WITH .Buttons(2)
544:                 .Caption   = "4 Casas"
545:                 .Left      = 68
546:                 .Top       = 2
547:                 .AutoSize  = .T.
548:                 .BackStyle = 0
549:                 .FontName  = "Tahoma"
550:                 .FontSize  = 8
551:                 .ForeColor = RGB(90, 90, 90)
552:             ENDWITH
553:         ENDWITH
554: 
555:         *-- Grupo_Salva (Confirmar + Cancelar), Top original=7, +29 comp
556:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
557:         WITH loc_oPagina.cnt_4c_Salva
558:             .Top         = 36
559:             .Left        = 819
560:             .Width       = 161
561:             .Height      = 85
562:             .BackStyle   = 0
563:             .BorderWidth = 0
564:             .Visible     = .T.
565:             .AddObject("cmd_4c_Confirmar", "CommandButton")
566:             WITH .cmd_4c_Confirmar
567:                 .Top        = 5
568:                 .Left       = 5
569:                 .Width      = 75
570:                 .Height     = 75
571:                 .Caption    = "Confirmar"
572:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
573:                 .FontBold   = .T.
574:                 .FontItalic = .T.
575:                 .FontName   = "Comic Sans MS"
576:                 .FontSize   = 8
577:                 .Visible    = .T.
578:             ENDWITH
579:             .AddObject("cmd_4c_Cancelar", "CommandButton")
580:             WITH .cmd_4c_Cancelar
581:                 .Top        = 5
582:                 .Left       = 81
583:                 .Width      = 75
584:                 .Height     = 75
585:                 .Caption    = "Encerrar"
586:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
587:                 .FontBold   = .T.
588:                 .FontItalic = .T.
589:                 .FontName   = "Comic Sans MS"
590:                 .FontSize   = 8
591:                 .Visible    = .T.
592:             ENDWITH
593:         ENDWITH
594: 
595:         *-- Inner PageFrame com 10 abas (Top original=124, +29 comp=153)
596:         loc_oPagina.AddObject("pgf_4c_Abas", "PageFrame")
597:         WITH loc_oPagina.pgf_4c_Abas
598:             .PageCount  = 10
599:             .Top        = 153
600:             .Left       = 8
601:             .Width      = 982
602:             .Height     = 472
603:             .Tabs       = .T.
604:             .FontName   = "Tahoma"
605:             .FontSize   = 7
606:             .Visible    = .T.
607:             .Page1.Caption  = "Cabe" + CHR(231) + "alho"
608:             .Page2.Caption  = "Empresa"
609:             .Page3.Caption  = "Desdobramento"
610:             .Page4.Caption  = "Produtos"
611:             .Page5.Caption  = "Impostos"
612:             .Page6.Caption  = "Transporte"
613:             .Page7.Caption  = "Rodap" + CHR(233)
614:             .Page8.Caption  = "Dados Fatura"
615:             .Page9.Caption  = "Servi" + CHR(231) + "os"
616:             .Page10.Caption = "Outros"
617:         ENDWITH
618: 
619:         THIS.ConfigurarCabecalhoTab()
620:         THIS.ConfigurarEmpresaTab()
621:         THIS.ConfigurarDesdobramentoTab()

*-- Linhas 631 a 640:
631:         BINDEVENT(loc_oPagina.txt_4c_Series,                 "LostFocus",    THIS, "SeriesDadosValid")
632:         BINDEVENT(loc_oPagina.txt_4c_Series,                 "KeyPress", THIS, "SeriesKeyPress")
633:         BINDEVENT(loc_oPagina.txt_4c_Series,                 "DblClick", THIS, "SeriesDblClick")
634:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click",   THIS, "ConfirmarClick")
635:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click",   THIS, "CancelarClick")
636: 
637:         *-- BINDEVENTs lookups nas abas internas
638:         LOCAL loc_oAbas, loc_oRdp, loc_nBI, loc_cBI
639:         loc_oAbas = loc_oPagina.pgf_4c_Abas
640: 

*-- Linhas 694 a 705:
694:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.Razas"
695:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.series"
696:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.cidchaves"
697:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "Empr."
698:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = "Empresa"
699:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.Header1.Caption = "S" + CHR(233) + "rie"
700:                         THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.Header1.Caption = "Chave"
701:                     ENDIF
702:                 ENDIF
703:             ENDIF
704:         CATCH TO loc_oErro
705:             MsgErro(loc_oErro.Message, "FormNfl.CarregarLista")

*-- Linhas 878 a 886:
878:                     IF PEMSTATUS(loc_oCtrl, "ControlCount", 5)
879:                         THIS.AplicarEnabledRecursivo(loc_oCtrl, par_lEnabled)
880:                     ENDIF
881:                 CASE INLIST(loc_cBase, "TEXTBOX", "EDITBOX", "COMBOBOX", "CHECKBOX", "OPTIONGROUP", "SPINNER")
882:                     IF PEMSTATUS(loc_oCtrl, "Enabled", 5)
883:                         loc_oCtrl.Enabled = par_lEnabled
884:                     ENDIF
885:             ENDCASE
886:         ENDFOR

*-- Linhas 904 a 945:
904:                 *-- Botoes CRUD Page1
905:                 IF PEMSTATUS(loc_oPag1, "cnt_4c_Botoes", 5)
906:                     loc_oBot = loc_oPag1.cnt_4c_Botoes
907:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Incluir", 5)
908:                         loc_oBot.cmd_4c_Incluir.Enabled    = loc_lLista
909:                     ENDIF
910:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Visualizar", 5)
911:                         loc_oBot.cmd_4c_Visualizar.Enabled = loc_lLista
912:                     ENDIF
913:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Alterar", 5)
914:                         loc_oBot.cmd_4c_Alterar.Enabled    = loc_lLista
915:                     ENDIF
916:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Excluir", 5)
917:                         loc_oBot.cmd_4c_Excluir.Enabled    = loc_lLista
918:                     ENDIF
919:                     IF PEMSTATUS(loc_oBot, "cmd_4c_Buscar", 5)
920:                         loc_oBot.cmd_4c_Buscar.Enabled     = loc_lLista
921:                     ENDIF
922:                 ENDIF
923:                 IF PEMSTATUS(loc_oPag1, "cmd_4c_Copia", 5)
924:                     loc_oPag1.cmd_4c_Copia.Enabled       = loc_lLista
925:                 ENDIF
926:                 IF PEMSTATUS(loc_oPag1, "cmd_4c_BtnExpXML", 5)
927:                     loc_oPag1.cmd_4c_BtnExpXML.Enabled   = loc_lLista
928:                 ENDIF
929:                 IF PEMSTATUS(loc_oPag1, "cmd_4c_BtnImpXML", 5)
930:                     loc_oPag1.cmd_4c_BtnImpXML.Enabled   = loc_lLista
931:                 ENDIF
932: 
933:                 *-- Botoes Confirmar/Cancelar Page2
934:                 IF PEMSTATUS(loc_oPag2, "cnt_4c_Salva", 5)
935:                     loc_oSal = loc_oPag2.cnt_4c_Salva
936:                     IF PEMSTATUS(loc_oSal, "cmd_4c_Confirmar", 5)
937:                         loc_oSal.cmd_4c_Confirmar.Enabled = loc_lEditando
938:                     ENDIF
939:                     IF PEMSTATUS(loc_oSal, "cmd_4c_Cancelar", 5)
940:                         loc_oSal.cmd_4c_Cancelar.Enabled  = (loc_lEditando OR loc_lVisualiza)
941:                     ENDIF
942:                 ENDIF
943:             ENDIF
944:         CATCH TO loc_oErro
945:             MsgErro(loc_oErro.Message, "FormNfl.AjustarBotoesPorModo")

*-- Linhas 1058 a 1069:
1058:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.Razas"
1059:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.ControlSource = "cursor_4c_Dados.series"
1060:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.ControlSource = "cursor_4c_Dados.cidchaves"
1061:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = "Empr."
1062:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = "Empresa"
1063:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column3.Header1.Caption = "S" + CHR(233) + "rie"
1064:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column4.Header1.Caption = "Chave"
1065:             ENDIF
1066:         CATCH TO loc_oErro
1067:             MsgErro(loc_oErro.Message, "FormNfl.BtnBuscarClick")
1068:         ENDTRY
1069:         RETURN loc_lResultado

*-- Linhas 1163 a 1572:
1163:         *-- Shape decorativo (painel impressora)
1164:         loc_oAba.AddObject("shp_4c_Shape1", "Shape")
1165:         WITH loc_oAba.shp_4c_Shape1
1166:             .Top           = 41
1167:             .Left          = 381
1168:             .Height        = 139
1169:             .Width         = 265
1170:             .BackStyle     = 0
1171:             .SpecialEffect = 0
1172:             .Visible       = .T.
1173:         ENDWITH
1174: 
1175:         *===== Coluna esquerda: dimensoes de impressao NF =====
1176: 
1177:         *-- No NF (l1nf x c1nf)
1178:         loc_oAba.AddObject("lbl_4c_Label1", "Label")
1179:         WITH loc_oAba.lbl_4c_Label1
1180:             .Caption   = "N" + CHR(186) + " NF"
1181:             .Top       = 33
1182:             .Left      = 41
1183:             .Width     = 29
1184:             .Height    = 13
1185:             .FontName  = "Tahoma"
1186:             .FontSize  = 7
1187:             .BackStyle = 0
1188:             .ForeColor = RGB(90, 90, 90)
1189:             .Visible   = .T.
1190:         ENDWITH
1191:         loc_oAba.AddObject("txt_4c_Text1", "TextBox")
1192:         WITH loc_oAba.txt_4c_Text1
1193:             .ControlSource = "crSigCnFNf.l1nf"
1194:             .Top           = 46
1195:             .Left          = 41
1196:             .Width         = 41
1197:             .Height        = 18
1198:             .FontName      = "Tahoma"
1199:             .FontSize      = 8
1200:             .Format        = "K"
1201:             .InputMask     = "999.99"
1202:             .SpecialEffect = 1
1203:             .Margin        = 0
1204:             .Visible       = .T.
1205:         ENDWITH
1206:         loc_oAba.AddObject("lbl_4c_Label2", "Label")
1207:         WITH loc_oAba.lbl_4c_Label2
1208:             .Caption   = "x"
1209:             .Top       = 48
1210:             .Left      = 84
1211:             .Width     = 6
1212:             .Height    = 13
1213:             .FontName  = "Tahoma"
1214:             .FontSize  = 7
1215:             .BackStyle = 0
1216:             .ForeColor = RGB(90, 90, 90)
1217:             .Visible   = .T.
1218:         ENDWITH
1219:         loc_oAba.AddObject("txt_4c_Text2", "TextBox")
1220:         WITH loc_oAba.txt_4c_Text2
1221:             .ControlSource = "crSigCnFNf.c1nf"
1222:             .Top           = 46
1223:             .Left          = 90
1224:             .Width         = 41
1225:             .Height        = 18
1226:             .FontName      = "Tahoma"
1227:             .FontSize      = 8
1228:             .Format        = "K"
1229:             .InputMask     = "999.99"
1230:             .SpecialEffect = 1
1231:             .Margin        = 0
1232:             .Visible       = .T.
1233:         ENDWITH
1234: 
1235:         *-- NF Saida (lnfsai x cnfsai)
1236:         loc_oAba.AddObject("lbl_4c_Label3", "Label")
1237:         WITH loc_oAba.lbl_4c_Label3
1238:             .Caption   = "NF Sa" + CHR(237) + "da"
1239:             .Top       = 65
1240:             .Left      = 41
1241:             .Width     = 41
1242:             .Height    = 13
1243:             .FontName  = "Tahoma"
1244:             .FontSize  = 7
1245:             .BackStyle = 0
1246:             .ForeColor = RGB(90, 90, 90)
1247:             .Visible   = .T.
1248:         ENDWITH
1249:         loc_oAba.AddObject("txt_4c_Text3", "TextBox")
1250:         WITH loc_oAba.txt_4c_Text3
1251:             .ControlSource = "crSigCnFNf.lnfsai"
1252:             .Top           = 78
1253:             .Left          = 41
1254:             .Width         = 41
1255:             .Height        = 18
1256:             .FontName      = "Tahoma"
1257:             .FontSize      = 8
1258:             .Format        = "K"
1259:             .InputMask     = "999.99"
1260:             .SpecialEffect = 1
1261:             .Margin        = 0
1262:             .Visible       = .T.
1263:         ENDWITH
1264:         loc_oAba.AddObject("lbl_4c_Label4", "Label")
1265:         WITH loc_oAba.lbl_4c_Label4
1266:             .Caption   = "x"
1267:             .Top       = 80
1268:             .Left      = 84
1269:             .Width     = 6
1270:             .Height    = 13
1271:             .FontName  = "Tahoma"
1272:             .FontSize  = 7
1273:             .BackStyle = 0
1274:             .ForeColor = RGB(90, 90, 90)
1275:             .Visible   = .T.
1276:         ENDWITH
1277:         loc_oAba.AddObject("txt_4c_Text4", "TextBox")
1278:         WITH loc_oAba.txt_4c_Text4
1279:             .ControlSource = "crSigCnFNf.cnfsai"
1280:             .Top           = 78
1281:             .Left          = 90
1282:             .Width         = 41
1283:             .Height        = 18
1284:             .FontName      = "Tahoma"
1285:             .FontSize      = 8
1286:             .Format        = "K"
1287:             .InputMask     = "999.99"
1288:             .SpecialEffect = 1
1289:             .Margin        = 0
1290:             .Visible       = .T.
1291:         ENDWITH
1292: 
1293:         *-- NF Entrada (lnfent x cnfent)
1294:         loc_oAba.AddObject("lbl_4c_Label5", "Label")
1295:         WITH loc_oAba.lbl_4c_Label5
1296:             .Caption   = "NF Entrada"
1297:             .Top       = 97
1298:             .Left      = 41
1299:             .Width     = 50
1300:             .Height    = 13
1301:             .FontName  = "Tahoma"
1302:             .FontSize  = 7
1303:             .BackStyle = 0
1304:             .ForeColor = RGB(90, 90, 90)
1305:             .Visible   = .T.
1306:         ENDWITH
1307:         loc_oAba.AddObject("txt_4c_Text5", "TextBox")
1308:         WITH loc_oAba.txt_4c_Text5
1309:             .ControlSource = "crSigCnFNf.lnfent"
1310:             .Top           = 110
1311:             .Left          = 41
1312:             .Width         = 41
1313:             .Height        = 18
1314:             .FontName      = "Tahoma"
1315:             .FontSize      = 8
1316:             .Format        = "K"
1317:             .InputMask     = "999.99"
1318:             .SpecialEffect = 1
1319:             .Margin        = 0
1320:             .Visible       = .T.
1321:         ENDWITH
1322:         loc_oAba.AddObject("lbl_4c_Label6", "Label")
1323:         WITH loc_oAba.lbl_4c_Label6
1324:             .Caption   = "x"
1325:             .Top       = 112
1326:             .Left      = 84
1327:             .Width     = 6
1328:             .Height    = 13
1329:             .FontName  = "Tahoma"
1330:             .FontSize  = 7
1331:             .BackStyle = 0
1332:             .ForeColor = RGB(90, 90, 90)
1333:             .Visible   = .T.
1334:         ENDWITH
1335:         loc_oAba.AddObject("txt_4c_Text6", "TextBox")
1336:         WITH loc_oAba.txt_4c_Text6
1337:             .ControlSource = "crSigCnFNf.cnfent"
1338:             .Top           = 110
1339:             .Left          = 90
1340:             .Width         = 41
1341:             .Height        = 18
1342:             .FontName      = "Tahoma"
1343:             .FontSize      = 8
1344:             .Format        = "K"
1345:             .InputMask     = "999.99"
1346:             .SpecialEffect = 1
1347:             .Margin        = 0
1348:             .Visible       = .T.
1349:         ENDWITH
1350: 
1351:         *-- Nat. Operacao (lnatop x cnatop)
1352:         loc_oAba.AddObject("lbl_4c_Label7", "Label")
1353:         WITH loc_oAba.lbl_4c_Label7
1354:             .Caption   = "Nat. Opera" + CHR(231) + CHR(227) + "o"
1355:             .Top       = 129
1356:             .Left      = 41
1357:             .Width     = 63
1358:             .Height    = 13
1359:             .FontName  = "Tahoma"
1360:             .FontSize  = 7
1361:             .BackStyle = 0
1362:             .ForeColor = RGB(90, 90, 90)
1363:             .Visible   = .T.
1364:         ENDWITH
1365:         loc_oAba.AddObject("txt_4c_Text7", "TextBox")
1366:         WITH loc_oAba.txt_4c_Text7
1367:             .ControlSource = "crSigCnFNf.lnatop"
1368:             .Top           = 142
1369:             .Left          = 41
1370:             .Width         = 41
1371:             .Height        = 18
1372:             .FontName      = "Tahoma"
1373:             .FontSize      = 8
1374:             .Format        = "K"
1375:             .InputMask     = "999.99"
1376:             .SpecialEffect = 1
1377:             .Margin        = 0
1378:             .Visible       = .T.
1379:         ENDWITH
1380:         loc_oAba.AddObject("lbl_4c_Label8", "Label")
1381:         WITH loc_oAba.lbl_4c_Label8
1382:             .Caption   = "x"
1383:             .Top       = 144
1384:             .Left      = 84
1385:             .Width     = 6
1386:             .Height    = 13
1387:             .FontName  = "Tahoma"
1388:             .FontSize  = 7
1389:             .BackStyle = 0
1390:             .ForeColor = RGB(90, 90, 90)
1391:             .Visible   = .T.
1392:         ENDWITH
1393:         loc_oAba.AddObject("txt_4c_Text8", "TextBox")
1394:         WITH loc_oAba.txt_4c_Text8
1395:             .ControlSource = "crSigCnFNf.cnatop"
1396:             .Top           = 142
1397:             .Left          = 90
1398:             .Width         = 41
1399:             .Height        = 18
1400:             .FontName      = "Tahoma"
1401:             .FontSize      = 8
1402:             .Format        = "K"
1403:             .InputMask     = "999.99"
1404:             .SpecialEffect = 1
1405:             .Margin        = 0
1406:             .Visible       = .T.
1407:         ENDWITH
1408: 
1409:         *-- CFOP (lcfop x ccfop)
1410:         loc_oAba.AddObject("lbl_4c_Label9", "Label")
1411:         WITH loc_oAba.lbl_4c_Label9
1412:             .Caption   = "CFOP"
1413:             .Top       = 161
1414:             .Left      = 41
1415:             .Width     = 29
1416:             .Height    = 13
1417:             .FontName  = "Tahoma"
1418:             .FontSize  = 7
1419:             .BackStyle = 0
1420:             .ForeColor = RGB(90, 90, 90)
1421:             .Visible   = .T.
1422:         ENDWITH
1423:         loc_oAba.AddObject("txt_4c_Text9", "TextBox")
1424:         WITH loc_oAba.txt_4c_Text9
1425:             .ControlSource = "crSigCnFNf.lcfop"
1426:             .Top           = 174
1427:             .Left          = 41
1428:             .Width         = 41
1429:             .Height        = 18
1430:             .FontName      = "Tahoma"
1431:             .FontSize      = 8
1432:             .Format        = "K"
1433:             .InputMask     = "999.99"
1434:             .SpecialEffect = 1
1435:             .Margin        = 0
1436:             .Visible       = .T.
1437:         ENDWITH
1438:         loc_oAba.AddObject("lbl_4c_Label10", "Label")
1439:         WITH loc_oAba.lbl_4c_Label10
1440:             .Caption   = "x"
1441:             .Top       = 176
1442:             .Left      = 84
1443:             .Width     = 6
1444:             .Height    = 13
1445:             .FontName  = "Tahoma"
1446:             .FontSize  = 7
1447:             .BackStyle = 0
1448:             .ForeColor = RGB(90, 90, 90)
1449:             .Visible   = .T.
1450:         ENDWITH
1451:         loc_oAba.AddObject("txt_4c_Text10", "TextBox")
1452:         WITH loc_oAba.txt_4c_Text10
1453:             .ControlSource = "crSigCnFNf.ccfop"
1454:             .Top           = 174
1455:             .Left          = 90
1456:             .Width         = 41
1457:             .Height        = 18
1458:             .FontName      = "Tahoma"
1459:             .FontSize      = 8
1460:             .Format        = "K"
1461:             .InputMask     = "999.99"
1462:             .SpecialEffect = 1
1463:             .Margin        = 0
1464:             .Visible       = .T.
1465:         ENDWITH
1466: 
1467:         *-- Razao Social (LRAZEMP x CRAZEMP, sem ControlSource)
1468:         loc_oAba.AddObject("lbl_4c_Label11", "Label")
1469:         WITH loc_oAba.lbl_4c_Label11
1470:             .Caption   = "Raz" + CHR(227) + "o Social"
1471:             .Top       = 193
1472:             .Left      = 41
1473:             .Width     = 54
1474:             .Height    = 13
1475:             .FontName  = "Tahoma"
1476:             .FontSize  = 7
1477:             .BackStyle = 0
1478:             .ForeColor = RGB(90, 90, 90)
1479:             .Visible   = .T.
1480:         ENDWITH
1481:         loc_oAba.AddObject("txt_4c_LRAZEMP", "TextBox")
1482:         WITH loc_oAba.txt_4c_LRAZEMP
1483:             .Top           = 206
1484:             .Left          = 41
1485:             .Width         = 42
1486:             .Height        = 18
1487:             .FontName      = "Tahoma"
1488:             .FontSize      = 8
1489:             .Format        = "K"
1490:             .InputMask     = "999.99"
1491:             .SpecialEffect = 1
1492:             .Margin        = 0
1493:             .Visible       = .T.
1494:         ENDWITH
1495:         loc_oAba.AddObject("lbl_4c_Label12", "Label")
1496:         WITH loc_oAba.lbl_4c_Label12
1497:             .Caption   = "x"
1498:             .Top       = 209
1499:             .Left      = 85
1500:             .Width     = 6
1501:             .Height    = 13
1502:             .FontName  = "Tahoma"
1503:             .FontSize  = 7
1504:             .BackStyle = 0
1505:             .ForeColor = RGB(90, 90, 90)
1506:             .Visible   = .T.
1507:         ENDWITH
1508:         loc_oAba.AddObject("txt_4c_CRAZEMP", "TextBox")
1509:         WITH loc_oAba.txt_4c_CRAZEMP
1510:             .Top           = 208
1511:             .Left          = 92
1512:             .Width         = 41
1513:             .Height        = 18
1514:             .FontName      = "Tahoma"
1515:             .FontSize      = 8
1516:             .Format        = "K"
1517:             .InputMask     = "999.99"
1518:             .SpecialEffect = 1
1519:             .Margin        = 0
1520:             .Visible       = .T.
1521:         ENDWITH
1522: 
1523:         *-- Endereco (LENDEMP x CENDEMP, sem ControlSource)
1524:         loc_oAba.AddObject("lbl_4c_Label16", "Label")
1525:         WITH loc_oAba.lbl_4c_Label16
1526:             .Caption   = "Endere" + CHR(231) + "o"
1527:             .Top       = 226
1528:             .Left      = 43
1529:             .Width     = 40
1530:             .Height    = 13
1531:             .FontName  = "Tahoma"
1532:             .FontSize  = 7
1533:             .BackStyle = 0
1534:             .ForeColor = RGB(90, 90, 90)
1535:             .Visible   = .T.
1536:         ENDWITH
1537:         loc_oAba.AddObject("txt_4c_LENDEMP", "TextBox")
1538:         WITH loc_oAba.txt_4c_LENDEMP
1539:             .Top           = 241
1540:             .Left          = 42
1541:             .Width         = 43
1542:             .Height        = 18
1543:             .FontName      = "Tahoma"
1544:             .FontSize      = 8
1545:             .Format        = "K"
1546:             .InputMask     = "999.99"
1547:             .SpecialEffect = 1
1548:             .Margin        = 0
1549:             .Visible       = .T.
1550:         ENDWITH
1551:         loc_oAba.AddObject("lbl_4c_Label17", "Label")
1552:         WITH loc_oAba.lbl_4c_Label17
1553:             .Caption   = "x"
1554:             .Top       = 244
1555:             .Left      = 86
1556:             .Width     = 6
1557:             .Height    = 13
1558:             .FontName  = "Tahoma"
1559:             .FontSize  = 7
1560:             .BackStyle = 0
1561:             .ForeColor = RGB(90, 90, 90)
1562:             .Visible   = .T.
1563:         ENDWITH
1564:         loc_oAba.AddObject("txt_4c_CENDEMP", "TextBox")
1565:         WITH loc_oAba.txt_4c_CENDEMP
1566:             .Top           = 241
1567:             .Left          = 91
1568:             .Width         = 41
1569:             .Height        = 18
1570:             .FontName      = "Tahoma"
1571:             .FontSize      = 8
1572:             .Format        = "K"

*-- Linhas 1579 a 1718:
1579:         *===== Coluna central: sequencia X, SAC, Nat.Op.Sub, CFOP Sub =====
1580: 
1581:         *-- Sequencia de X (lxinc x cxinc x lenxinc)
1582:         loc_oAba.AddObject("lbl_4c_Label19", "Label")
1583:         WITH loc_oAba.lbl_4c_Label19
1584:             .Caption   = "Seq" + CHR(252) + CHR(234) + "ncia de X     (Quant)"
1585:             .Top       = 33
1586:             .Left      = 165
1587:             .Width     = 112
1588:             .Height    = 13
1589:             .FontName  = "Tahoma"
1590:             .FontSize  = 7
1591:             .BackStyle = 0
1592:             .ForeColor = RGB(90, 90, 90)
1593:             .Visible   = .T.
1594:         ENDWITH
1595:         loc_oAba.AddObject("txt_4c_Text12", "TextBox")
1596:         WITH loc_oAba.txt_4c_Text12
1597:             .ControlSource = "crSigCnFN2.lxinc"
1598:             .Top           = 46
1599:             .Left          = 165
1600:             .Width         = 41
1601:             .Height        = 18
1602:             .FontName      = "Tahoma"
1603:             .FontSize      = 8
1604:             .Format        = "K"
1605:             .InputMask     = "999.99"
1606:             .SpecialEffect = 1
1607:             .Margin        = 0
1608:             .Visible       = .T.
1609:         ENDWITH
1610:         loc_oAba.AddObject("lbl_4c_Label20", "Label")
1611:         WITH loc_oAba.lbl_4c_Label20
1612:             .Caption   = "x"
1613:             .Top       = 48
1614:             .Left      = 208
1615:             .Width     = 6
1616:             .Height    = 13
1617:             .FontName  = "Tahoma"
1618:             .FontSize  = 7
1619:             .BackStyle = 0
1620:             .ForeColor = RGB(90, 90, 90)
1621:             .Visible   = .T.
1622:         ENDWITH
1623:         loc_oAba.AddObject("txt_4c_Text16", "TextBox")
1624:         WITH loc_oAba.txt_4c_Text16
1625:             .ControlSource = "crSigCnFN2.cxinc"
1626:             .Top           = 46
1627:             .Left          = 214
1628:             .Width         = 41
1629:             .Height        = 18
1630:             .FontName      = "Tahoma"
1631:             .FontSize      = 8
1632:             .Format        = "K"
1633:             .InputMask     = "999.99"
1634:             .SpecialEffect = 1
1635:             .Margin        = 0
1636:             .Visible       = .T.
1637:         ENDWITH
1638:         loc_oAba.AddObject("lbl_4c_Label21", "Label")
1639:         WITH loc_oAba.lbl_4c_Label21
1640:             .Caption   = "x"
1641:             .Top       = 48
1642:             .Left      = 255
1643:             .Width     = 6
1644:             .Height    = 13
1645:             .FontName  = "Tahoma"
1646:             .FontSize  = 7
1647:             .BackStyle = 0
1648:             .ForeColor = RGB(90, 90, 90)
1649:             .Visible   = .T.
1650:         ENDWITH
1651:         loc_oAba.AddObject("txt_4c_Text17", "TextBox")
1652:         WITH loc_oAba.txt_4c_Text17
1653:             .ControlSource = "crSigCnFN2.lenxinc"
1654:             .Top           = 46
1655:             .Left          = 261
1656:             .Width         = 41
1657:             .Height        = 18
1658:             .FontName      = "Tahoma"
1659:             .FontSize      = 8
1660:             .Format        = "K"
1661:             .InputMask     = "99999"
1662:             .SpecialEffect = 1
1663:             .Margin        = 0
1664:             .Visible       = .T.
1665:         ENDWITH
1666: 
1667:         *-- SAC (lsac x csac + contsac)
1668:         loc_oAba.AddObject("lbl_4c_Label22", "Label")
1669:         WITH loc_oAba.lbl_4c_Label22
1670:             .Caption   = "SAC:"
1671:             .Top       = 65
1672:             .Left      = 164
1673:             .Width     = 25
1674:             .Height    = 13
1675:             .FontName  = "Tahoma"
1676:             .FontSize  = 7
1677:             .BackStyle = 0
1678:             .ForeColor = RGB(90, 90, 90)
1679:             .Visible   = .T.
1680:         ENDWITH
1681:         loc_oAba.AddObject("txt_4c_Text18", "TextBox")
1682:         WITH loc_oAba.txt_4c_Text18
1683:             .ControlSource = "crSigCnFN2.lsac"
1684:             .Top           = 78
1685:             .Left          = 164
1686:             .Width         = 41
1687:             .Height        = 18
1688:             .FontName      = "Tahoma"
1689:             .FontSize      = 8
1690:             .Format        = "K"
1691:             .InputMask     = "999.99"
1692:             .SpecialEffect = 1
1693:             .Margin        = 0
1694:             .Visible       = .T.
1695:         ENDWITH
1696:         loc_oAba.AddObject("lbl_4c_Label23", "Label")
1697:         WITH loc_oAba.lbl_4c_Label23
1698:             .Caption   = "x"
1699:             .Top       = 80
1700:             .Left      = 207
1701:             .Width     = 6
1702:             .Height    = 13
1703:             .FontName  = "Tahoma"
1704:             .FontSize  = 7
1705:             .BackStyle = 0
1706:             .ForeColor = RGB(90, 90, 90)
1707:             .Visible   = .T.
1708:         ENDWITH
1709:         loc_oAba.AddObject("txt_4c_Text19", "TextBox")
1710:         WITH loc_oAba.txt_4c_Text19
1711:             .ControlSource = "crSigCnFN2.csac"
1712:             .Top           = 78
1713:             .Left          = 213
1714:             .Width         = 41
1715:             .Height        = 18
1716:             .FontName      = "Tahoma"
1717:             .FontSize      = 8
1718:             .Format        = "K"

*-- Linhas 1724 a 1849:
1724:         loc_oAba.AddObject("txt_4c_Text20", "TextBox")
1725:         WITH loc_oAba.txt_4c_Text20
1726:             .ControlSource = "crSigCnFN2.contsac"
1727:             .Top           = 97
1728:             .Left          = 164
1729:             .Width         = 137
1730:             .Height        = 18
1731:             .MaxLength     = 20
1732:             .FontName      = "Tahoma"
1733:             .FontSize      = 8
1734:             .Format        = "K"
1735:             .SpecialEffect = 1
1736:             .Margin        = 0
1737:             .Visible       = .T.
1738:         ENDWITH
1739: 
1740:         *-- Nat. Operacao Substituicao Tributaria (lnatopsub x cnatopsub)
1741:         loc_oAba.AddObject("lbl_4c_Label24", "Label")
1742:         WITH loc_oAba.lbl_4c_Label24
1743:             .Caption   = "Nat. Opera" + CHR(231) + CHR(227) + "o Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria"
1744:             .Top       = 129
1745:             .Left      = 164
1746:             .Width     = 157
1747:             .Height    = 13
1748:             .FontName  = "Tahoma"
1749:             .FontSize  = 7
1750:             .BackStyle = 0
1751:             .ForeColor = RGB(90, 90, 90)
1752:             .Visible   = .T.
1753:         ENDWITH
1754:         loc_oAba.AddObject("txt_4c_Text21", "TextBox")
1755:         WITH loc_oAba.txt_4c_Text21
1756:             .ControlSource = "crSigCnFN2.lnatopsub"
1757:             .Top           = 142
1758:             .Left          = 164
1759:             .Width         = 41
1760:             .Height        = 18
1761:             .FontName      = "Tahoma"
1762:             .FontSize      = 8
1763:             .Format        = "K"
1764:             .InputMask     = "999.99"
1765:             .SpecialEffect = 1
1766:             .Margin        = 0
1767:             .Visible       = .T.
1768:         ENDWITH
1769:         loc_oAba.AddObject("lbl_4c_Label25", "Label")
1770:         WITH loc_oAba.lbl_4c_Label25
1771:             .Caption   = "x"
1772:             .Top       = 144
1773:             .Left      = 207
1774:             .Width     = 6
1775:             .Height    = 13
1776:             .FontName  = "Tahoma"
1777:             .FontSize  = 7
1778:             .BackStyle = 0
1779:             .ForeColor = RGB(90, 90, 90)
1780:             .Visible   = .T.
1781:         ENDWITH
1782:         loc_oAba.AddObject("txt_4c_Text22", "TextBox")
1783:         WITH loc_oAba.txt_4c_Text22
1784:             .ControlSource = "crSigCnFN2.cnatopsub"
1785:             .Top           = 142
1786:             .Left          = 213
1787:             .Width         = 41
1788:             .Height        = 18
1789:             .FontName      = "Tahoma"
1790:             .FontSize      = 8
1791:             .Format        = "K"
1792:             .InputMask     = "999.99"
1793:             .SpecialEffect = 1
1794:             .Margin        = 0
1795:             .Visible       = .T.
1796:         ENDWITH
1797: 
1798:         *-- CFOP Substituicao Tributaria (lcfopsub x ccfopsub)
1799:         loc_oAba.AddObject("lbl_4c_Label26", "Label")
1800:         WITH loc_oAba.lbl_4c_Label26
1801:             .Caption   = "CFOP Substitui" + CHR(231) + CHR(227) + "o Tribut" + CHR(225) + "ria"
1802:             .Top       = 161
1803:             .Left      = 164
1804:             .Width     = 123
1805:             .Height    = 13
1806:             .FontName  = "Tahoma"
1807:             .FontSize  = 7
1808:             .BackStyle = 0
1809:             .ForeColor = RGB(90, 90, 90)
1810:             .Visible   = .T.
1811:         ENDWITH
1812:         loc_oAba.AddObject("txt_4c_Text23", "TextBox")
1813:         WITH loc_oAba.txt_4c_Text23
1814:             .ControlSource = "crSigCnFN2.lcfopsub"
1815:             .Top           = 174
1816:             .Left          = 164
1817:             .Width         = 41
1818:             .Height        = 18
1819:             .FontName      = "Tahoma"
1820:             .FontSize      = 8
1821:             .Format        = "K"
1822:             .InputMask     = "999.99"
1823:             .SpecialEffect = 1
1824:             .Margin        = 0
1825:             .Visible       = .T.
1826:         ENDWITH
1827:         loc_oAba.AddObject("lbl_4c_Label27", "Label")
1828:         WITH loc_oAba.lbl_4c_Label27
1829:             .Caption   = "x"
1830:             .Top       = 176
1831:             .Left      = 207
1832:             .Width     = 6
1833:             .Height    = 13
1834:             .FontName  = "Tahoma"
1835:             .FontSize  = 7
1836:             .BackStyle = 0
1837:             .ForeColor = RGB(90, 90, 90)
1838:             .Visible   = .T.
1839:         ENDWITH
1840:         loc_oAba.AddObject("txt_4c_Text24", "TextBox")
1841:         WITH loc_oAba.txt_4c_Text24
1842:             .ControlSource = "crSigCnFN2.ccfopsub"
1843:             .Top           = 174
1844:             .Left          = 213
1845:             .Width         = 41
1846:             .Height        = 18
1847:             .FontName      = "Tahoma"
1848:             .FontSize      = 8
1849:             .Format        = "K"

*-- Linhas 1856 a 1965:
1856:         *===== Coluna direita: impressora (dentro do Shape1) =====
1857: 
1858:         *-- Nome da Impressora (imppads)
1859:         loc_oAba.AddObject("lbl_4c_Label13", "Label")
1860:         WITH loc_oAba.lbl_4c_Label13
1861:             .Caption   = "Nome da Impressora"
1862:             .Top       = 49
1863:             .Left      = 393
1864:             .Width     = 89
1865:             .Height    = 13
1866:             .FontName  = "Tahoma"
1867:             .FontSize  = 7
1868:             .BackStyle = 0
1869:             .ForeColor = RGB(90, 90, 90)
1870:             .Visible   = .T.
1871:         ENDWITH
1872:         loc_oAba.AddObject("txt_4c_Text13", "TextBox")
1873:         WITH loc_oAba.txt_4c_Text13
1874:             .ControlSource = "crSigCnFNf.imppads"
1875:             .Top           = 61
1876:             .Left          = 393
1877:             .Width         = 240
1878:             .Height        = 18
1879:             .FontName      = "Tahoma"
1880:             .FontSize      = 8
1881:             .Format        = "K"
1882:             .SpecialEffect = 1
1883:             .Margin        = 0
1884:             .Visible       = .T.
1885:         ENDWITH
1886: 
1887:         *-- Fonte Padrao + Tamanho (sem ControlSource; Text14 abre dialogo fonte)
1888:         loc_oAba.AddObject("lbl_4c_Label14", "Label")
1889:         WITH loc_oAba.lbl_4c_Label14
1890:             .Caption   = "Fonte Padr" + CHR(227) + "o"
1891:             .Top       = 81
1892:             .Left      = 393
1893:             .Width     = 58
1894:             .Height    = 13
1895:             .FontName  = "Tahoma"
1896:             .FontSize  = 7
1897:             .BackStyle = 0
1898:             .ForeColor = RGB(90, 90, 90)
1899:             .Visible   = .T.
1900:         ENDWITH
1901:         loc_oAba.AddObject("txt_4c_Text14", "TextBox")
1902:         WITH loc_oAba.txt_4c_Text14
1903:             .Top           = 93
1904:             .Left          = 393
1905:             .Width         = 192
1906:             .Height        = 18
1907:             .FontName      = "Tahoma"
1908:             .FontSize      = 8
1909:             .Format        = "K"
1910:             .SpecialEffect = 1
1911:             .Margin        = 0
1912:             .Visible       = .T.
1913:         ENDWITH
1914:         loc_oAba.AddObject("lbl_4c_Label15", "Label")
1915:         WITH loc_oAba.lbl_4c_Label15
1916:             .Caption   = "Tamanho"
1917:             .Top       = 81
1918:             .Left      = 591
1919:             .Width     = 41
1920:             .Height    = 13
1921:             .FontName  = "Tahoma"
1922:             .FontSize  = 7
1923:             .BackStyle = 0
1924:             .ForeColor = RGB(90, 90, 90)
1925:             .Visible   = .T.
1926:         ENDWITH
1927:         loc_oAba.AddObject("txt_4c_Text15", "TextBox")
1928:         WITH loc_oAba.txt_4c_Text15
1929:             .ControlSource = "crSigCnFNf.tamanhos"
1930:             .Top           = 93
1931:             .Left          = 592
1932:             .Width         = 41
1933:             .Height        = 18
1934:             .FontName      = "Tahoma"
1935:             .FontSize      = 8
1936:             .Format        = "K"
1937:             .InputMask     = "999"
1938:             .SpecialEffect = 1
1939:             .Margin        = 0
1940:             .Visible       = .T.
1941:         ENDWITH
1942: 
1943:         *-- Tamanho da Folha (Text11, sem ControlSource; abre dialogo)
1944:         loc_oAba.AddObject("lbl_4c_Label18", "Label")
1945:         WITH loc_oAba.lbl_4c_Label18
1946:             .Caption   = "Tamanho da Folha"
1947:             .Top       = 114
1948:             .Left      = 394
1949:             .Width     = 80
1950:             .Height    = 13
1951:             .FontName  = "Tahoma"
1952:             .FontSize  = 7
1953:             .BackStyle = 0
1954:             .ForeColor = RGB(90, 90, 90)
1955:             .Visible   = .T.
1956:         ENDWITH
1957:         loc_oAba.AddObject("txt_4c_Text11", "TextBox")
1958:         WITH loc_oAba.txt_4c_Text11
1959:             .Top           = 127
1960:             .Left          = 393
1961:             .Width         = 240
1962:             .Height        = 18
1963:             .MaxLength     = 50
1964:             .FontName      = "Tahoma"
1965:             .FontSize      = 8

*-- Linhas 1973 a 2000:
1973:         loc_oAba.AddObject("obj_4c_OptTpMargem", "OptionGroup")
1974:         WITH loc_oAba.obj_4c_OptTpMargem
1975:             .ControlSource = "crSigCnFN2.ntpmargems"
1976:             .Top           = 149
1977:             .Left          = 389
1978:             .Width         = 202
1979:             .Height        = 27
1980:             .BackStyle     = 0
1981:             .BorderStyle   = 0
1982:             .Value         = 1
1983:             .Visible       = .T.
1984:             WITH .Buttons(1)
1985:                 .Caption   = "Sem Margem"
1986:                 .Left      = 5
1987:                 .Top       = 5
1988:                 .AutoSize  = .T.
1989:                 .BackStyle = 0
1990:                 .ForeColor = RGB(90, 90, 90)
1991:             ENDWITH
1992:             WITH .Buttons(2)
1993:                 .Caption   = "Com Margem"
1994:                 .Left      = 105
1995:                 .Top       = 5
1996:                 .AutoSize  = .T.
1997:                 .BackStyle = 0
1998:                 .FontName  = "Tahoma"
1999:                 .FontSize  = 8
2000:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 2624 a 2648:
2624:             loc_lLetras = (loc_oAba.obj_4c_ClsFisTp.Value = 1)
2625:             FOR loc_nI = 1 TO 7
2626:                 loc_cN  = ALLTRIM(STR(loc_nI))
2627:                 loc_oLbl = THIS.ObterControle(loc_oAba, "lbl_4c_Cod" + loc_cN)
2628:                 IF VARTYPE(loc_oLbl) = "O"
2629:                     IF loc_lLetras
2630:                         loc_oLbl.Caption = CHR(64 + loc_nI)
2631:                     ELSE
2632:                         loc_oLbl.Caption = "C" + CHR(243) + "digo " + loc_cN
2633:                     ENDIF
2634:                 ENDIF
2635:             ENDFOR
2636:             FOR loc_nI = 8 TO 12
2637:                 loc_cN  = ALLTRIM(STR(loc_nI))
2638:                 loc_oLbl = THIS.ObterControle(loc_oAba, "lbl_4c_CodB" + loc_cN)
2639:                 IF VARTYPE(loc_oLbl) = "O"
2640:                     IF loc_lLetras
2641:                         loc_oLbl.Caption = CHR(64 + loc_nI)
2642:                     ELSE
2643:                         loc_oLbl.Caption = "C" + CHR(243) + "digo " + loc_cN
2644:                     ENDIF
2645:                 ENDIF
2646:             ENDFOR
2647:         CATCH TO loc_oErro
2648:             MsgErro(loc_oErro.Message, "FormNfl.ClsFisTpClick")

*-- Linhas 2840 a 3374:
2840:         *-- Secao: Dados/Endereco - Empresa (top=7, shape+header)
2841:         loc_oAba.AddObject("shp_4c_Shape3", "Shape")
2842:         WITH loc_oAba.shp_4c_Shape3
2843:             .Top           = 7
2844:             .Left          = 42
2845:             .Height        = 3
2846:             .Width         = 414
2847:             .BackStyle     = 1
2848:             .SpecialEffect = 1
2849:             .BackColor     = RGB(136, 189, 188)
2850:             .Visible       = .T.
2851:         ENDWITH
2852: 
2853:         loc_oAba.AddObject("lbl_4c_Label57", "Label")
2854:         WITH loc_oAba.lbl_4c_Label57
2855:             .Caption   = "Dados / Endere" + CHR(231) + "o - Empresa"
2856:             .Top       = 11
2857:             .Left      = 50
2858:             .FontBold  = .T.
2859:             .FontName  = "Tahoma"
2860:             .FontSize  = 8
2861:             .BackStyle = 0
2862:             .ForeColor = RGB(90, 90, 90)
2863:             .AutoSize  = .T.
2864:             .Visible   = .T.
2865:         ENDWITH
2866: 
2867:         *-- Empresa - Nome/Razao Social (top=26)
2868:         loc_oAba.AddObject("lbl_4c_Label41", "Label")
2869:         WITH loc_oAba.lbl_4c_Label41
2870:             .Caption   = "Nome / Raz" + CHR(227) + "o Social"
2871:             .Top       = 26
2872:             .Left      = 42
2873:             .FontName  = "Tahoma"
2874:             .FontSize  = 7
2875:             .BackStyle = 0
2876:             .ForeColor = RGB(90, 90, 90)
2877:             .AutoSize  = .T.
2878:             .Visible   = .T.
2879:         ENDWITH
2880: 
2881:         loc_oAba.AddObject("txt_4c_EmpNomeL", "TextBox")
2882:         WITH loc_oAba.txt_4c_EmpNomeL
2883:             .ControlSource = "crSigCnFN2.lempnome"
2884:             .Top           = 38
2885:             .Left          = 42
2886:             .Width         = 41
2887:             .Height        = 18
2888:             .FontName      = "Tahoma"
2889:             .FontSize      = 8
2890:             .SpecialEffect = 1
2891:             .Format        = "K"
2892:             .InputMask     = "999.99"
2893:             .Visible       = .T.
2894:         ENDWITH
2895: 
2896:         loc_oAba.AddObject("lbl_4c_Label42", "Label")
2897:         WITH loc_oAba.lbl_4c_Label42
2898:             .Caption   = "x"
2899:             .Top       = 40
2900:             .Left      = 85
2901:             .FontName  = "Tahoma"
2902:             .FontSize  = 7
2903:             .BackStyle = 0
2904:             .ForeColor = RGB(90, 90, 90)
2905:             .AutoSize  = .T.
2906:             .Visible   = .T.
2907:         ENDWITH
2908: 
2909:         loc_oAba.AddObject("txt_4c_EmpNomeC", "TextBox")
2910:         WITH loc_oAba.txt_4c_EmpNomeC
2911:             .ControlSource = "crSigCnFN2.cempnome"
2912:             .Top           = 38
2913:             .Left          = 91
2914:             .Width         = 41
2915:             .Height        = 18
2916:             .FontName      = "Tahoma"
2917:             .FontSize      = 8
2918:             .SpecialEffect = 1
2919:             .Format        = "K"
2920:             .InputMask     = "999.99"
2921:             .Visible       = .T.
2922:         ENDWITH
2923: 
2924:         *-- Empresa - CGC/CPF (top=26)
2925:         loc_oAba.AddObject("lbl_4c_Label43", "Label")
2926:         WITH loc_oAba.lbl_4c_Label43
2927:             .Caption   = "C.G.C. / C.P.F."
2928:             .Top       = 26
2929:             .Left      = 150
2930:             .FontName  = "Tahoma"
2931:             .FontSize  = 7
2932:             .BackStyle = 0
2933:             .ForeColor = RGB(90, 90, 90)
2934:             .AutoSize  = .T.
2935:             .Visible   = .T.
2936:         ENDWITH
2937: 
2938:         loc_oAba.AddObject("txt_4c_EmpCgcL", "TextBox")
2939:         WITH loc_oAba.txt_4c_EmpCgcL
2940:             .ControlSource = "crSigCnFN2.lempcgc"
2941:             .Top           = 38
2942:             .Left          = 150
2943:             .Width         = 41
2944:             .Height        = 18
2945:             .FontName      = "Tahoma"
2946:             .FontSize      = 8
2947:             .SpecialEffect = 1
2948:             .Format        = "K"
2949:             .InputMask     = "999.99"
2950:             .Visible       = .T.
2951:         ENDWITH
2952: 
2953:         loc_oAba.AddObject("lbl_4c_Label44", "Label")
2954:         WITH loc_oAba.lbl_4c_Label44
2955:             .Caption   = "x"
2956:             .Top       = 40
2957:             .Left      = 193
2958:             .FontName  = "Tahoma"
2959:             .FontSize  = 7
2960:             .BackStyle = 0
2961:             .ForeColor = RGB(90, 90, 90)
2962:             .AutoSize  = .T.
2963:             .Visible   = .T.
2964:         ENDWITH
2965: 
2966:         loc_oAba.AddObject("txt_4c_EmpCgcC", "TextBox")
2967:         WITH loc_oAba.txt_4c_EmpCgcC
2968:             .ControlSource = "crSigCnFN2.cempcgc"
2969:             .Top           = 38
2970:             .Left          = 199
2971:             .Width         = 41
2972:             .Height        = 18
2973:             .FontName      = "Tahoma"
2974:             .FontSize      = 8
2975:             .SpecialEffect = 1
2976:             .Format        = "K"
2977:             .InputMask     = "999.99"
2978:             .Visible       = .T.
2979:         ENDWITH
2980: 
2981:         *-- Empresa - Insc.Estadual (top=26)
2982:         loc_oAba.AddObject("lbl_4c_Label55", "Label")
2983:         WITH loc_oAba.lbl_4c_Label55
2984:             .Caption   = "Insc. Estadual"
2985:             .Top       = 26
2986:             .Left      = 258
2987:             .FontName  = "Tahoma"
2988:             .FontSize  = 7
2989:             .BackStyle = 0
2990:             .ForeColor = RGB(90, 90, 90)
2991:             .AutoSize  = .T.
2992:             .Visible   = .T.
2993:         ENDWITH
2994: 
2995:         loc_oAba.AddObject("txt_4c_EmpIestL", "TextBox")
2996:         WITH loc_oAba.txt_4c_EmpIestL
2997:             .ControlSource = "crSigCnFN2.lempiest"
2998:             .Top           = 38
2999:             .Left          = 258
3000:             .Width         = 41
3001:             .Height        = 18
3002:             .FontName      = "Tahoma"
3003:             .FontSize      = 8
3004:             .SpecialEffect = 1
3005:             .Format        = "K"
3006:             .InputMask     = "999.99"
3007:             .Visible       = .T.
3008:         ENDWITH
3009: 
3010:         loc_oAba.AddObject("lbl_4c_Label56", "Label")
3011:         WITH loc_oAba.lbl_4c_Label56
3012:             .Caption   = "x"
3013:             .Top       = 40
3014:             .Left      = 301
3015:             .FontName  = "Tahoma"
3016:             .FontSize  = 7
3017:             .BackStyle = 0
3018:             .ForeColor = RGB(90, 90, 90)
3019:             .AutoSize  = .T.
3020:             .Visible   = .T.
3021:         ENDWITH
3022: 
3023:         loc_oAba.AddObject("txt_4c_EmpIestC", "TextBox")
3024:         WITH loc_oAba.txt_4c_EmpIestC
3025:             .ControlSource = "crSigCnFN2.cempiest"
3026:             .Top           = 38
3027:             .Left          = 307
3028:             .Width         = 41
3029:             .Height        = 18
3030:             .FontName      = "Tahoma"
3031:             .FontSize      = 8
3032:             .SpecialEffect = 1
3033:             .Format        = "K"
3034:             .InputMask     = "999.99"
3035:             .Visible       = .T.
3036:         ENDWITH
3037: 
3038:         *-- Empresa - Endereco (top=56)
3039:         loc_oAba.AddObject("lbl_4c_Label45", "Label")
3040:         WITH loc_oAba.lbl_4c_Label45
3041:             .Caption   = "Endere" + CHR(231) + "o"
3042:             .Top       = 56
3043:             .Left      = 42
3044:             .FontName  = "Tahoma"
3045:             .FontSize  = 7
3046:             .BackStyle = 0
3047:             .ForeColor = RGB(90, 90, 90)
3048:             .AutoSize  = .T.
3049:             .Visible   = .T.
3050:         ENDWITH
3051: 
3052:         loc_oAba.AddObject("txt_4c_EmpEnderL", "TextBox")
3053:         WITH loc_oAba.txt_4c_EmpEnderL
3054:             .ControlSource = "crSigCnFN2.lempender"
3055:             .Top           = 68
3056:             .Left          = 42
3057:             .Width         = 41
3058:             .Height        = 18
3059:             .FontName      = "Tahoma"
3060:             .FontSize      = 8
3061:             .SpecialEffect = 1
3062:             .Format        = "K"
3063:             .InputMask     = "999.99"
3064:             .Visible       = .T.
3065:         ENDWITH
3066: 
3067:         loc_oAba.AddObject("lbl_4c_Label46", "Label")
3068:         WITH loc_oAba.lbl_4c_Label46
3069:             .Caption   = "x"
3070:             .Top       = 70
3071:             .Left      = 85
3072:             .FontName  = "Tahoma"
3073:             .FontSize  = 7
3074:             .BackStyle = 0
3075:             .ForeColor = RGB(90, 90, 90)
3076:             .AutoSize  = .T.
3077:             .Visible   = .T.
3078:         ENDWITH
3079: 
3080:         loc_oAba.AddObject("txt_4c_EmpEnderC", "TextBox")
3081:         WITH loc_oAba.txt_4c_EmpEnderC
3082:             .ControlSource = "crSigCnFN2.cempender"
3083:             .Top           = 68
3084:             .Left          = 91
3085:             .Width         = 41
3086:             .Height        = 18
3087:             .FontName      = "Tahoma"
3088:             .FontSize      = 8
3089:             .SpecialEffect = 1
3090:             .Format        = "K"
3091:             .InputMask     = "999.99"
3092:             .Visible       = .T.
3093:         ENDWITH
3094: 
3095:         *-- Empresa - Bairro (top=56)
3096:         loc_oAba.AddObject("lbl_4c_Label47", "Label")
3097:         WITH loc_oAba.lbl_4c_Label47
3098:             .Caption   = "Bairro"
3099:             .Top       = 56
3100:             .Left      = 149
3101:             .FontName  = "Tahoma"
3102:             .FontSize  = 7
3103:             .BackStyle = 0
3104:             .ForeColor = RGB(90, 90, 90)
3105:             .AutoSize  = .T.
3106:             .Visible   = .T.
3107:         ENDWITH
3108: 
3109:         loc_oAba.AddObject("txt_4c_EmpBairL", "TextBox")
3110:         WITH loc_oAba.txt_4c_EmpBairL
3111:             .ControlSource = "crSigCnFN2.lempbair"
3112:             .Top           = 68
3113:             .Left          = 149
3114:             .Width         = 41
3115:             .Height        = 18
3116:             .FontName      = "Tahoma"
3117:             .FontSize      = 8
3118:             .SpecialEffect = 1
3119:             .Format        = "K"
3120:             .InputMask     = "999.99"
3121:             .Visible       = .T.
3122:         ENDWITH
3123: 
3124:         loc_oAba.AddObject("lbl_4c_Label48", "Label")
3125:         WITH loc_oAba.lbl_4c_Label48
3126:             .Caption   = "x"
3127:             .Top       = 70
3128:             .Left      = 192
3129:             .FontName  = "Tahoma"
3130:             .FontSize  = 7
3131:             .BackStyle = 0
3132:             .ForeColor = RGB(90, 90, 90)
3133:             .AutoSize  = .T.
3134:             .Visible   = .T.
3135:         ENDWITH
3136: 
3137:         loc_oAba.AddObject("txt_4c_EmpBairC", "TextBox")
3138:         WITH loc_oAba.txt_4c_EmpBairC
3139:             .ControlSource = "crSigCnFN2.cempbair"
3140:             .Top           = 68
3141:             .Left          = 198
3142:             .Width         = 41
3143:             .Height        = 18
3144:             .FontName      = "Tahoma"
3145:             .FontSize      = 8
3146:             .SpecialEffect = 1
3147:             .Format        = "K"
3148:             .InputMask     = "999.99"
3149:             .Visible       = .T.
3150:         ENDWITH
3151: 
3152:         *-- Empresa - Municipio (top=56)
3153:         loc_oAba.AddObject("lbl_4c_Label51", "Label")
3154:         WITH loc_oAba.lbl_4c_Label51
3155:             .Caption   = "Munic" + CHR(237) + "pio"
3156:             .Top       = 56
3157:             .Left      = 257
3158:             .FontName  = "Tahoma"
3159:             .FontSize  = 7
3160:             .BackStyle = 0
3161:             .ForeColor = RGB(90, 90, 90)
3162:             .AutoSize  = .T.
3163:             .Visible   = .T.
3164:         ENDWITH
3165: 
3166:         loc_oAba.AddObject("txt_4c_EmpMuniL", "TextBox")
3167:         WITH loc_oAba.txt_4c_EmpMuniL
3168:             .ControlSource = "crSigCnFN2.lempmuni"
3169:             .Top           = 68
3170:             .Left          = 257
3171:             .Width         = 41
3172:             .Height        = 18
3173:             .FontName      = "Tahoma"
3174:             .FontSize      = 8
3175:             .SpecialEffect = 1
3176:             .Format        = "K"
3177:             .InputMask     = "999.99"
3178:             .Visible       = .T.
3179:         ENDWITH
3180: 
3181:         loc_oAba.AddObject("lbl_4c_Label52", "Label")
3182:         WITH loc_oAba.lbl_4c_Label52
3183:             .Caption   = "x"
3184:             .Top       = 70
3185:             .Left      = 300
3186:             .FontName  = "Tahoma"
3187:             .FontSize  = 7
3188:             .BackStyle = 0
3189:             .ForeColor = RGB(90, 90, 90)
3190:             .AutoSize  = .T.
3191:             .Visible   = .T.
3192:         ENDWITH
3193: 
3194:         loc_oAba.AddObject("txt_4c_EmpMuniC", "TextBox")
3195:         WITH loc_oAba.txt_4c_EmpMuniC
3196:             .ControlSource = "crSigCnFN2.cempmuni"
3197:             .Top           = 68
3198:             .Left          = 306
3199:             .Width         = 41
3200:             .Height        = 18
3201:             .FontName      = "Tahoma"
3202:             .FontSize      = 8
3203:             .SpecialEffect = 1
3204:             .Format        = "K"
3205:             .InputMask     = "999.99"
3206:             .Visible       = .T.
3207:         ENDWITH
3208: 
3209:         *-- Empresa - CEP (top=86)
3210:         loc_oAba.AddObject("lbl_4c_Label49", "Label")
3211:         WITH loc_oAba.lbl_4c_Label49
3212:             .Caption   = "CEP"
3213:             .Top       = 86
3214:             .Left      = 41
3215:             .FontName  = "Tahoma"
3216:             .FontSize  = 7
3217:             .BackStyle = 0
3218:             .ForeColor = RGB(90, 90, 90)
3219:             .AutoSize  = .T.
3220:             .Visible   = .T.
3221:         ENDWITH
3222: 
3223:         loc_oAba.AddObject("txt_4c_EmpCepL", "TextBox")
3224:         WITH loc_oAba.txt_4c_EmpCepL
3225:             .ControlSource = "crSigCnFN2.lempcep"
3226:             .Top           = 98
3227:             .Left          = 41
3228:             .Width         = 41
3229:             .Height        = 18
3230:             .FontName      = "Tahoma"
3231:             .FontSize      = 8
3232:             .SpecialEffect = 1
3233:             .Format        = "K"
3234:             .InputMask     = "999.99"
3235:             .Visible       = .T.
3236:         ENDWITH
3237: 
3238:         loc_oAba.AddObject("lbl_4c_Label50", "Label")
3239:         WITH loc_oAba.lbl_4c_Label50
3240:             .Caption   = "x"
3241:             .Top       = 100
3242:             .Left      = 84
3243:             .FontName  = "Tahoma"
3244:             .FontSize  = 7
3245:             .BackStyle = 0
3246:             .ForeColor = RGB(90, 90, 90)
3247:             .AutoSize  = .T.
3248:             .Visible   = .T.
3249:         ENDWITH
3250: 
3251:         loc_oAba.AddObject("txt_4c_EmpCepC", "TextBox")
3252:         WITH loc_oAba.txt_4c_EmpCepC
3253:             .ControlSource = "crSigCnFN2.cempcep"
3254:             .Top           = 98
3255:             .Left          = 90
3256:             .Width         = 41
3257:             .Height        = 18
3258:             .FontName      = "Tahoma"
3259:             .FontSize      = 8
3260:             .SpecialEffect = 1
3261:             .Format        = "K"
3262:             .InputMask     = "999.99"
3263:             .Visible       = .T.
3264:         ENDWITH
3265: 
3266:         *-- Empresa - Fone/Fax (top=86)
3267:         loc_oAba.AddObject("lbl_4c_Label53", "Label")
3268:         WITH loc_oAba.lbl_4c_Label53
3269:             .Caption   = "Fone / Fax"
3270:             .Top       = 86
3271:             .Left      = 149
3272:             .FontName  = "Tahoma"
3273:             .FontSize  = 7
3274:             .BackStyle = 0
3275:             .ForeColor = RGB(90, 90, 90)
3276:             .AutoSize  = .T.
3277:             .Visible   = .T.
3278:         ENDWITH
3279: 
3280:         loc_oAba.AddObject("txt_4c_EmpFoneL", "TextBox")
3281:         WITH loc_oAba.txt_4c_EmpFoneL
3282:             .ControlSource = "crSigCnFN2.lempfone"
3283:             .Top           = 98
3284:             .Left          = 149
3285:             .Width         = 41
3286:             .Height        = 18
3287:             .FontName      = "Tahoma"
3288:             .FontSize      = 8
3289:             .SpecialEffect = 1
3290:             .Format        = "K"
3291:             .InputMask     = "999.99"
3292:             .Visible       = .T.
3293:         ENDWITH
3294: 
3295:         loc_oAba.AddObject("lbl_4c_Label54", "Label")
3296:         WITH loc_oAba.lbl_4c_Label54
3297:             .Caption   = "x"
3298:             .Top       = 100
3299:             .Left      = 192
3300:             .FontName  = "Tahoma"
3301:             .FontSize  = 7
3302:             .BackStyle = 0
3303:             .ForeColor = RGB(90, 90, 90)
3304:             .AutoSize  = .T.
3305:             .Visible   = .T.
3306:         ENDWITH
3307: 
3308:         loc_oAba.AddObject("txt_4c_EmpFoneC", "TextBox")
3309:         WITH loc_oAba.txt_4c_EmpFoneC
3310:             .ControlSource = "crSigCnFN2.cempfone"
3311:             .Top           = 98
3312:             .Left          = 198
3313:             .Width         = 41
3314:             .Height        = 18
3315:             .FontName      = "Tahoma"
3316:             .FontSize      = 8
3317:             .SpecialEffect = 1
3318:             .Format        = "K"
3319:             .InputMask     = "999.99"
3320:             .Visible       = .T.
3321:         ENDWITH
3322: 
3323:         *-- Empresa - Estado (top=86)
3324:         loc_oAba.AddObject("lbl_4c_Label58", "Label")
3325:         WITH loc_oAba.lbl_4c_Label58
3326:             .Caption   = "Estado"
3327:             .Top       = 86
3328:             .Left      = 257
3329:             .FontName  = "Tahoma"
3330:             .FontSize  = 7
3331:             .BackStyle = 0
3332:             .ForeColor = RGB(90, 90, 90)
3333:             .AutoSize  = .T.
3334:             .Visible   = .T.
3335:         ENDWITH
3336: 
3337:         loc_oAba.AddObject("txt_4c_EmpEstaL", "TextBox")
3338:         WITH loc_oAba.txt_4c_EmpEstaL
3339:             .ControlSource = "crSigCnFN2.lempesta"
3340:             .Top           = 98
3341:             .Left          = 257
3342:             .Width         = 41
3343:             .Height        = 18
3344:             .FontName      = "Tahoma"
3345:             .FontSize      = 8
3346:             .SpecialEffect = 1
3347:             .Format        = "K"
3348:             .InputMask     = "999.99"
3349:             .Visible       = .T.
3350:         ENDWITH
3351: 
3352:         loc_oAba.AddObject("lbl_4c_Label59", "Label")
3353:         WITH loc_oAba.lbl_4c_Label59
3354:             .Caption   = "x"
3355:             .Top       = 100
3356:             .Left      = 300
3357:             .FontName  = "Tahoma"
3358:             .FontSize  = 7
3359:             .BackStyle = 0
3360:             .ForeColor = RGB(90, 90, 90)
3361:             .AutoSize  = .T.
3362:             .Visible   = .T.
3363:         ENDWITH
3364: 
3365:         loc_oAba.AddObject("txt_4c_EmpEstaC", "TextBox")
3366:         WITH loc_oAba.txt_4c_EmpEstaC
3367:             .ControlSource = "crSigCnFN2.cempesta"
3368:             .Top           = 98
3369:             .Left          = 306
3370:             .Width         = 41
3371:             .Height        = 18
3372:             .FontName      = "Tahoma"
3373:             .FontSize      = 8
3374:             .SpecialEffect = 1

*-- Linhas 3380 a 3971:
3380:         *-- Secao: Dados/Endereco - Empresa/Cliente (top=120 shape + top=127 header)
3381:         loc_oAba.AddObject("shp_4c_Shape1", "Shape")
3382:         WITH loc_oAba.shp_4c_Shape1
3383:             .Top           = 120
3384:             .Left          = 42
3385:             .Height        = 3
3386:             .Width         = 414
3387:             .BackStyle     = 1
3388:             .SpecialEffect = 1
3389:             .BackColor     = RGB(136, 189, 188)
3390:             .Visible       = .T.
3391:         ENDWITH
3392: 
3393:         loc_oAba.AddObject("lbl_4c_Label37", "Label")
3394:         WITH loc_oAba.lbl_4c_Label37
3395:             .Caption   = "Dados / Endere" + CHR(231) + "o - Empresa / Cliente"
3396:             .Top       = 127
3397:             .Left      = 50
3398:             .FontBold  = .T.
3399:             .FontName  = "Tahoma"
3400:             .FontSize  = 8
3401:             .BackStyle = 0
3402:             .ForeColor = RGB(90, 90, 90)
3403:             .AutoSize  = .T.
3404:             .Visible   = .T.
3405:         ENDWITH
3406: 
3407:         *-- Nome/Razao Social (cliente, top=141)
3408:         loc_oAba.AddObject("lbl_4c_Label1", "Label")
3409:         WITH loc_oAba.lbl_4c_Label1
3410:             .Caption   = "Nome / Raz" + CHR(227) + "o Social"
3411:             .Top       = 141
3412:             .Left      = 42
3413:             .FontName  = "Tahoma"
3414:             .FontSize  = 7
3415:             .BackStyle = 0
3416:             .ForeColor = RGB(90, 90, 90)
3417:             .AutoSize  = .T.
3418:             .Visible   = .T.
3419:         ENDWITH
3420: 
3421:         loc_oAba.AddObject("txt_4c_CliNomeL", "TextBox")
3422:         WITH loc_oAba.txt_4c_CliNomeL
3423:             .ControlSource = "crSigCnFNf.lnome"
3424:             .Top           = 153
3425:             .Left          = 42
3426:             .Width         = 41
3427:             .Height        = 18
3428:             .FontName      = "Tahoma"
3429:             .FontSize      = 8
3430:             .SpecialEffect = 1
3431:             .Format        = "K"
3432:             .InputMask     = "999.99"
3433:             .Visible       = .T.
3434:         ENDWITH
3435: 
3436:         loc_oAba.AddObject("lbl_4c_Label2", "Label")
3437:         WITH loc_oAba.lbl_4c_Label2
3438:             .Caption   = "x"
3439:             .Top       = 155
3440:             .Left      = 85
3441:             .FontName  = "Tahoma"
3442:             .FontSize  = 7
3443:             .BackStyle = 0
3444:             .ForeColor = RGB(90, 90, 90)
3445:             .AutoSize  = .T.
3446:             .Visible   = .T.
3447:         ENDWITH
3448: 
3449:         loc_oAba.AddObject("txt_4c_CliNomeC", "TextBox")
3450:         WITH loc_oAba.txt_4c_CliNomeC
3451:             .ControlSource = "crSigCnFNf.cnome"
3452:             .Top           = 153
3453:             .Left          = 91
3454:             .Width         = 41
3455:             .Height        = 18
3456:             .FontName      = "Tahoma"
3457:             .FontSize      = 8
3458:             .SpecialEffect = 1
3459:             .Format        = "K"
3460:             .InputMask     = "999.99"
3461:             .Visible       = .T.
3462:         ENDWITH
3463: 
3464:         *-- CGC/CPF (cliente, top=141)
3465:         loc_oAba.AddObject("lbl_4c_Label3", "Label")
3466:         WITH loc_oAba.lbl_4c_Label3
3467:             .Caption   = "C.G.C. / C.P.F."
3468:             .Top       = 141
3469:             .Left      = 150
3470:             .FontName  = "Tahoma"
3471:             .FontSize  = 7
3472:             .BackStyle = 0
3473:             .ForeColor = RGB(90, 90, 90)
3474:             .AutoSize  = .T.
3475:             .Visible   = .T.
3476:         ENDWITH
3477: 
3478:         loc_oAba.AddObject("txt_4c_CliCgcL", "TextBox")
3479:         WITH loc_oAba.txt_4c_CliCgcL
3480:             .ControlSource = "crSigCnFNf.lcgc"
3481:             .Top           = 153
3482:             .Left          = 150
3483:             .Width         = 41
3484:             .Height        = 18
3485:             .FontName      = "Tahoma"
3486:             .FontSize      = 8
3487:             .SpecialEffect = 1
3488:             .Format        = "K"
3489:             .InputMask     = "999.99"
3490:             .Visible       = .T.
3491:         ENDWITH
3492: 
3493:         loc_oAba.AddObject("lbl_4c_Label4", "Label")
3494:         WITH loc_oAba.lbl_4c_Label4
3495:             .Caption   = "x"
3496:             .Top       = 155
3497:             .Left      = 193
3498:             .FontName  = "Tahoma"
3499:             .FontSize  = 7
3500:             .BackStyle = 0
3501:             .ForeColor = RGB(90, 90, 90)
3502:             .AutoSize  = .T.
3503:             .Visible   = .T.
3504:         ENDWITH
3505: 
3506:         loc_oAba.AddObject("txt_4c_CliCgcC", "TextBox")
3507:         WITH loc_oAba.txt_4c_CliCgcC
3508:             .ControlSource = "crSigCnFNf.ccgc"
3509:             .Top           = 153
3510:             .Left          = 199
3511:             .Width         = 41
3512:             .Height        = 18
3513:             .FontName      = "Tahoma"
3514:             .FontSize      = 8
3515:             .SpecialEffect = 1
3516:             .Format        = "K"
3517:             .InputMask     = "999.99"
3518:             .Visible       = .T.
3519:         ENDWITH
3520: 
3521:         *-- Insc.Estadual (cliente, top=141)
3522:         loc_oAba.AddObject("lbl_4c_Label21", "Label")
3523:         WITH loc_oAba.lbl_4c_Label21
3524:             .Caption   = "Insc. Estadual"
3525:             .Top       = 141
3526:             .Left      = 258
3527:             .FontName  = "Tahoma"
3528:             .FontSize  = 7
3529:             .BackStyle = 0
3530:             .ForeColor = RGB(90, 90, 90)
3531:             .AutoSize  = .T.
3532:             .Visible   = .T.
3533:         ENDWITH
3534: 
3535:         loc_oAba.AddObject("txt_4c_CliIestL", "TextBox")
3536:         WITH loc_oAba.txt_4c_CliIestL
3537:             .ControlSource = "crSigCnFNf.liest"
3538:             .Top           = 153
3539:             .Left          = 258
3540:             .Width         = 41
3541:             .Height        = 18
3542:             .FontName      = "Tahoma"
3543:             .FontSize      = 8
3544:             .SpecialEffect = 1
3545:             .Format        = "K"
3546:             .InputMask     = "999.99"
3547:             .Visible       = .T.
3548:         ENDWITH
3549: 
3550:         loc_oAba.AddObject("lbl_4c_Label22", "Label")
3551:         WITH loc_oAba.lbl_4c_Label22
3552:             .Caption   = "x"
3553:             .Top       = 155
3554:             .Left      = 301
3555:             .FontName  = "Tahoma"
3556:             .FontSize  = 7
3557:             .BackStyle = 0
3558:             .ForeColor = RGB(90, 90, 90)
3559:             .AutoSize  = .T.
3560:             .Visible   = .T.
3561:         ENDWITH
3562: 
3563:         loc_oAba.AddObject("txt_4c_CliIestC", "TextBox")
3564:         WITH loc_oAba.txt_4c_CliIestC
3565:             .ControlSource = "crSigCnFNf.ciest"
3566:             .Top           = 153
3567:             .Left          = 307
3568:             .Width         = 41
3569:             .Height        = 18
3570:             .FontName      = "Tahoma"
3571:             .FontSize      = 8
3572:             .SpecialEffect = 1
3573:             .Format        = "K"
3574:             .InputMask     = "999.99"
3575:             .Visible       = .T.
3576:         ENDWITH
3577: 
3578:         *-- Data de Emissao (cliente, top=141)
3579:         loc_oAba.AddObject("lbl_4c_Label5", "Label")
3580:         WITH loc_oAba.lbl_4c_Label5
3581:             .Caption   = "Data de Emiss" + CHR(227) + "o"
3582:             .Top       = 141
3583:             .Left      = 366
3584:             .FontName  = "Tahoma"
3585:             .FontSize  = 7
3586:             .BackStyle = 0
3587:             .ForeColor = RGB(90, 90, 90)
3588:             .AutoSize  = .T.
3589:             .Visible   = .T.
3590:         ENDWITH
3591: 
3592:         loc_oAba.AddObject("txt_4c_CliDtEmiL", "TextBox")
3593:         WITH loc_oAba.txt_4c_CliDtEmiL
3594:             .ControlSource = "crSigCnFNf.ldtemi"
3595:             .Top           = 153
3596:             .Left          = 366
3597:             .Width         = 41
3598:             .Height        = 18
3599:             .FontName      = "Tahoma"
3600:             .FontSize      = 8
3601:             .SpecialEffect = 1
3602:             .Format        = "K"
3603:             .InputMask     = "999.99"
3604:             .Visible       = .T.
3605:         ENDWITH
3606: 
3607:         loc_oAba.AddObject("lbl_4c_Label6", "Label")
3608:         WITH loc_oAba.lbl_4c_Label6
3609:             .Caption   = "x"
3610:             .Top       = 155
3611:             .Left      = 409
3612:             .FontName  = "Tahoma"
3613:             .FontSize  = 7
3614:             .BackStyle = 0
3615:             .ForeColor = RGB(90, 90, 90)
3616:             .AutoSize  = .T.
3617:             .Visible   = .T.
3618:         ENDWITH
3619: 
3620:         loc_oAba.AddObject("txt_4c_CliDtEmiC", "TextBox")
3621:         WITH loc_oAba.txt_4c_CliDtEmiC
3622:             .ControlSource = "crSigCnFNf.cdtemi"
3623:             .Top           = 153
3624:             .Left          = 415
3625:             .Width         = 41
3626:             .Height        = 18
3627:             .FontName      = "Tahoma"
3628:             .FontSize      = 8
3629:             .SpecialEffect = 1
3630:             .Format        = "K"
3631:             .InputMask     = "999.99"
3632:             .Visible       = .T.
3633:         ENDWITH
3634: 
3635:         *-- Endereco (cliente, top=171)
3636:         loc_oAba.AddObject("lbl_4c_Label7", "Label")
3637:         WITH loc_oAba.lbl_4c_Label7
3638:             .Caption   = "Endere" + CHR(231) + "o"
3639:             .Top       = 171
3640:             .Left      = 42
3641:             .FontName  = "Tahoma"
3642:             .FontSize  = 7
3643:             .BackStyle = 0
3644:             .ForeColor = RGB(90, 90, 90)
3645:             .AutoSize  = .T.
3646:             .Visible   = .T.
3647:         ENDWITH
3648: 
3649:         loc_oAba.AddObject("txt_4c_CliEnderL", "TextBox")
3650:         WITH loc_oAba.txt_4c_CliEnderL
3651:             .ControlSource = "crSigCnFNf.lender"
3652:             .Top           = 183
3653:             .Left          = 42
3654:             .Width         = 41
3655:             .Height        = 18
3656:             .FontName      = "Tahoma"
3657:             .FontSize      = 8
3658:             .SpecialEffect = 1
3659:             .Format        = "K"
3660:             .InputMask     = "999.99"
3661:             .Visible       = .T.
3662:         ENDWITH
3663: 
3664:         loc_oAba.AddObject("lbl_4c_Label8", "Label")
3665:         WITH loc_oAba.lbl_4c_Label8
3666:             .Caption   = "x"
3667:             .Top       = 185
3668:             .Left      = 85
3669:             .FontName  = "Tahoma"
3670:             .FontSize  = 7
3671:             .BackStyle = 0
3672:             .ForeColor = RGB(90, 90, 90)
3673:             .AutoSize  = .T.
3674:             .Visible   = .T.
3675:         ENDWITH
3676: 
3677:         loc_oAba.AddObject("txt_4c_CliEnderC", "TextBox")
3678:         WITH loc_oAba.txt_4c_CliEnderC
3679:             .ControlSource = "crSigCnFNf.cender"
3680:             .Top           = 183
3681:             .Left          = 91
3682:             .Width         = 41
3683:             .Height        = 18
3684:             .FontName      = "Tahoma"
3685:             .FontSize      = 8
3686:             .SpecialEffect = 1
3687:             .Format        = "K"
3688:             .InputMask     = "999.99"
3689:             .Visible       = .T.
3690:         ENDWITH
3691: 
3692:         *-- Bairro (cliente, top=171)
3693:         loc_oAba.AddObject("lbl_4c_Label9", "Label")
3694:         WITH loc_oAba.lbl_4c_Label9
3695:             .Caption   = "Bairro"
3696:             .Top       = 171
3697:             .Left      = 149
3698:             .FontName  = "Tahoma"
3699:             .FontSize  = 7
3700:             .BackStyle = 0
3701:             .ForeColor = RGB(90, 90, 90)
3702:             .AutoSize  = .T.
3703:             .Visible   = .T.
3704:         ENDWITH
3705: 
3706:         loc_oAba.AddObject("txt_4c_CliBairrL", "TextBox")
3707:         WITH loc_oAba.txt_4c_CliBairrL
3708:             .ControlSource = "crSigCnFNf.lbairr"
3709:             .Top           = 183
3710:             .Left          = 149
3711:             .Width         = 41
3712:             .Height        = 18
3713:             .FontName      = "Tahoma"
3714:             .FontSize      = 8
3715:             .SpecialEffect = 1
3716:             .Format        = "K"
3717:             .InputMask     = "999.99"
3718:             .Visible       = .T.
3719:         ENDWITH
3720: 
3721:         loc_oAba.AddObject("lbl_4c_Label10", "Label")
3722:         WITH loc_oAba.lbl_4c_Label10
3723:             .Caption   = "x"
3724:             .Top       = 185
3725:             .Left      = 192
3726:             .FontName  = "Tahoma"
3727:             .FontSize  = 7
3728:             .BackStyle = 0
3729:             .ForeColor = RGB(90, 90, 90)
3730:             .AutoSize  = .T.
3731:             .Visible   = .T.
3732:         ENDWITH
3733: 
3734:         loc_oAba.AddObject("txt_4c_CliBairrC", "TextBox")
3735:         WITH loc_oAba.txt_4c_CliBairrC
3736:             .ControlSource = "crSigCnFNf.cbairr"
3737:             .Top           = 183
3738:             .Left          = 198
3739:             .Width         = 41
3740:             .Height        = 18
3741:             .FontName      = "Tahoma"
3742:             .FontSize      = 8
3743:             .SpecialEffect = 1
3744:             .Format        = "K"
3745:             .InputMask     = "999.99"
3746:             .Visible       = .T.
3747:         ENDWITH
3748: 
3749:         *-- Municipio (cliente, top=171)
3750:         loc_oAba.AddObject("lbl_4c_Label15", "Label")
3751:         WITH loc_oAba.lbl_4c_Label15
3752:             .Caption   = "Munic" + CHR(237) + "pio"
3753:             .Top       = 171
3754:             .Left      = 257
3755:             .FontName  = "Tahoma"
3756:             .FontSize  = 7
3757:             .BackStyle = 0
3758:             .ForeColor = RGB(90, 90, 90)
3759:             .AutoSize  = .T.
3760:             .Visible   = .T.
3761:         ENDWITH
3762: 
3763:         loc_oAba.AddObject("txt_4c_CliMuniL", "TextBox")
3764:         WITH loc_oAba.txt_4c_CliMuniL
3765:             .ControlSource = "crSigCnFNf.lmuni"
3766:             .Top           = 183
3767:             .Left          = 257
3768:             .Width         = 41
3769:             .Height        = 18
3770:             .FontName      = "Tahoma"
3771:             .FontSize      = 8
3772:             .SpecialEffect = 1
3773:             .Format        = "K"
3774:             .InputMask     = "999.99"
3775:             .Visible       = .T.
3776:         ENDWITH
3777: 
3778:         loc_oAba.AddObject("lbl_4c_Label16", "Label")
3779:         WITH loc_oAba.lbl_4c_Label16
3780:             .Caption   = "x"
3781:             .Top       = 185
3782:             .Left      = 300
3783:             .FontName  = "Tahoma"
3784:             .FontSize  = 7
3785:             .BackStyle = 0
3786:             .ForeColor = RGB(90, 90, 90)
3787:             .AutoSize  = .T.
3788:             .Visible   = .T.
3789:         ENDWITH
3790: 
3791:         loc_oAba.AddObject("txt_4c_CliMuniC", "TextBox")
3792:         WITH loc_oAba.txt_4c_CliMuniC
3793:             .ControlSource = "crSigCnFNf.cmuni"
3794:             .Top           = 183
3795:             .Left          = 306
3796:             .Width         = 41
3797:             .Height        = 18
3798:             .FontName      = "Tahoma"
3799:             .FontSize      = 8
3800:             .SpecialEffect = 1
3801:             .Format        = "K"
3802:             .InputMask     = "999.99"
3803:             .Visible       = .T.
3804:         ENDWITH
3805: 
3806:         *-- Estado (cliente, top=171)
3807:         loc_oAba.AddObject("lbl_4c_Label17", "Label")
3808:         WITH loc_oAba.lbl_4c_Label17
3809:             .Caption   = "Estado"
3810:             .Top       = 171
3811:             .Left      = 365
3812:             .FontName  = "Tahoma"
3813:             .FontSize  = 7
3814:             .BackStyle = 0
3815:             .ForeColor = RGB(90, 90, 90)
3816:             .AutoSize  = .T.
3817:             .Visible   = .T.
3818:         ENDWITH
3819: 
3820:         loc_oAba.AddObject("txt_4c_CliEstaL", "TextBox")
3821:         WITH loc_oAba.txt_4c_CliEstaL
3822:             .ControlSource = "crSigCnFNf.lesta"
3823:             .Top           = 183
3824:             .Left          = 365
3825:             .Width         = 41
3826:             .Height        = 18
3827:             .FontName      = "Tahoma"
3828:             .FontSize      = 8
3829:             .SpecialEffect = 1
3830:             .Format        = "K"
3831:             .InputMask     = "999.99"
3832:             .Visible       = .T.
3833:         ENDWITH
3834: 
3835:         loc_oAba.AddObject("lbl_4c_Label18", "Label")
3836:         WITH loc_oAba.lbl_4c_Label18
3837:             .Caption   = "x"
3838:             .Top       = 185
3839:             .Left      = 408
3840:             .FontName  = "Tahoma"
3841:             .FontSize  = 7
3842:             .BackStyle = 0
3843:             .ForeColor = RGB(90, 90, 90)
3844:             .AutoSize  = .T.
3845:             .Visible   = .T.
3846:         ENDWITH
3847: 
3848:         loc_oAba.AddObject("txt_4c_CliEstaC", "TextBox")
3849:         WITH loc_oAba.txt_4c_CliEstaC
3850:             .ControlSource = "crSigCnFNf.cesta"
3851:             .Top           = 183
3852:             .Left          = 414
3853:             .Width         = 41
3854:             .Height        = 18
3855:             .FontName      = "Tahoma"
3856:             .FontSize      = 8
3857:             .SpecialEffect = 1
3858:             .Format        = "K"
3859:             .InputMask     = "999.99"
3860:             .Visible       = .T.
3861:         ENDWITH
3862: 
3863:         *-- CEP (cliente, top=201)
3864:         loc_oAba.AddObject("lbl_4c_Label13", "Label")
3865:         WITH loc_oAba.lbl_4c_Label13
3866:             .Caption   = "CEP"
3867:             .Top       = 201
3868:             .Left      = 41
3869:             .FontName  = "Tahoma"
3870:             .FontSize  = 7
3871:             .BackStyle = 0
3872:             .ForeColor = RGB(90, 90, 90)
3873:             .AutoSize  = .T.
3874:             .Visible   = .T.
3875:         ENDWITH
3876: 
3877:         loc_oAba.AddObject("txt_4c_CliCepL", "TextBox")
3878:         WITH loc_oAba.txt_4c_CliCepL
3879:             .ControlSource = "crSigCnFNf.lcep"
3880:             .Top           = 213
3881:             .Left          = 41
3882:             .Width         = 41
3883:             .Height        = 18
3884:             .FontName      = "Tahoma"
3885:             .FontSize      = 8
3886:             .SpecialEffect = 1
3887:             .Format        = "K"
3888:             .InputMask     = "999.99"
3889:             .Visible       = .T.
3890:         ENDWITH
3891: 
3892:         loc_oAba.AddObject("lbl_4c_Label14", "Label")
3893:         WITH loc_oAba.lbl_4c_Label14
3894:             .Caption   = "x"
3895:             .Top       = 215
3896:             .Left      = 84
3897:             .FontName  = "Tahoma"
3898:             .FontSize  = 7
3899:             .BackStyle = 0
3900:             .ForeColor = RGB(90, 90, 90)
3901:             .AutoSize  = .T.
3902:             .Visible   = .T.
3903:         ENDWITH
3904: 
3905:         loc_oAba.AddObject("txt_4c_CliCepC", "TextBox")
3906:         WITH loc_oAba.txt_4c_CliCepC
3907:             .ControlSource = "crSigCnFNf.ccep"
3908:             .Top           = 213
3909:             .Left          = 90
3910:             .Width         = 41
3911:             .Height        = 18
3912:             .FontName      = "Tahoma"
3913:             .FontSize      = 8
3914:             .SpecialEffect = 1
3915:             .Format        = "K"
3916:             .InputMask     = "999.99"
3917:             .Visible       = .T.
3918:         ENDWITH
3919: 
3920:         *-- Fone/Fax (cliente, top=201)
3921:         loc_oAba.AddObject("lbl_4c_Label19", "Label")
3922:         WITH loc_oAba.lbl_4c_Label19
3923:             .Caption   = "Fone / Fax"
3924:             .Top       = 201
3925:             .Left      = 149
3926:             .FontName  = "Tahoma"
3927:             .FontSize  = 7
3928:             .BackStyle = 0
3929:             .ForeColor = RGB(90, 90, 90)
3930:             .AutoSize  = .T.
3931:             .Visible   = .T.
3932:         ENDWITH
3933: 
3934:         loc_oAba.AddObject("txt_4c_CliFoneL", "TextBox")
3935:         WITH loc_oAba.txt_4c_CliFoneL
3936:             .ControlSource = "crSigCnFNf.lfone"
3937:             .Top           = 213
3938:             .Left          = 149
3939:             .Width         = 41
3940:             .Height        = 18
3941:             .FontName      = "Tahoma"
3942:             .FontSize      = 8
3943:             .SpecialEffect = 1
3944:             .Format        = "K"
3945:             .InputMask     = "999.99"
3946:             .Visible       = .T.
3947:         ENDWITH
3948: 
3949:         loc_oAba.AddObject("lbl_4c_Label20", "Label")
3950:         WITH loc_oAba.lbl_4c_Label20
3951:             .Caption   = "x"
3952:             .Top       = 215
3953:             .Left      = 192
3954:             .FontName  = "Tahoma"
3955:             .FontSize  = 7
3956:             .BackStyle = 0
3957:             .ForeColor = RGB(90, 90, 90)
3958:             .AutoSize  = .T.
3959:             .Visible   = .T.
3960:         ENDWITH
3961: 
3962:         loc_oAba.AddObject("txt_4c_CliFoneC", "TextBox")
3963:         WITH loc_oAba.txt_4c_CliFoneC
3964:             .ControlSource = "crSigCnFNf.cfone"
3965:             .Top           = 213
3966:             .Left          = 198
3967:             .Width         = 41
3968:             .Height        = 18
3969:             .FontName      = "Tahoma"
3970:             .FontSize      = 8
3971:             .SpecialEffect = 1

*-- Linhas 3977 a 4397:
3977:         *-- Secao: Endereco de Entrega - Empresa/Cliente (top=234 shape + top=238 header)
3978:         loc_oAba.AddObject("shp_4c_Shape2", "Shape")
3979:         WITH loc_oAba.shp_4c_Shape2
3980:             .Top           = 234
3981:             .Left          = 42
3982:             .Height        = 3
3983:             .Width         = 414
3984:             .BackStyle     = 1
3985:             .SpecialEffect = 1
3986:             .BackColor     = RGB(136, 189, 188)
3987:             .Visible       = .T.
3988:         ENDWITH
3989: 
3990:         loc_oAba.AddObject("lbl_4c_Label38", "Label")
3991:         WITH loc_oAba.lbl_4c_Label38
3992:             .Caption   = "Endere" + CHR(231) + "o de Entrega - Empresa / Cliente"
3993:             .Top       = 238
3994:             .Left      = 52
3995:             .FontBold  = .T.
3996:             .FontName  = "Tahoma"
3997:             .FontSize  = 8
3998:             .BackStyle = 0
3999:             .ForeColor = RGB(90, 90, 90)
4000:             .AutoSize  = .T.
4001:             .Visible   = .T.
4002:         ENDWITH
4003: 
4004:         *-- Entrega - Endereco (top=252)
4005:         loc_oAba.AddObject("lbl_4c_Label25", "Label")
4006:         WITH loc_oAba.lbl_4c_Label25
4007:             .Caption   = "Endere" + CHR(231) + "o"
4008:             .Top       = 252
4009:             .Left      = 42
4010:             .FontName  = "Tahoma"
4011:             .FontSize  = 7
4012:             .BackStyle = 0
4013:             .ForeColor = RGB(90, 90, 90)
4014:             .AutoSize  = .T.
4015:             .Visible   = .T.
4016:         ENDWITH
4017: 
4018:         loc_oAba.AddObject("txt_4c_EntEnderL", "TextBox")
4019:         WITH loc_oAba.txt_4c_EntEnderL
4020:             .ControlSource = "crSigCnFN2.lendent"
4021:             .Top           = 264
4022:             .Left          = 42
4023:             .Width         = 41
4024:             .Height        = 18
4025:             .FontName      = "Tahoma"
4026:             .FontSize      = 8
4027:             .SpecialEffect = 1
4028:             .Format        = "K"
4029:             .InputMask     = "999.99"
4030:             .Visible       = .T.
4031:         ENDWITH
4032: 
4033:         loc_oAba.AddObject("lbl_4c_Label26", "Label")
4034:         WITH loc_oAba.lbl_4c_Label26
4035:             .Caption   = "x"
4036:             .Top       = 266
4037:             .Left      = 85
4038:             .FontName  = "Tahoma"
4039:             .FontSize  = 7
4040:             .BackStyle = 0
4041:             .ForeColor = RGB(90, 90, 90)
4042:             .AutoSize  = .T.
4043:             .Visible   = .T.
4044:         ENDWITH
4045: 
4046:         loc_oAba.AddObject("txt_4c_EntEnderC", "TextBox")
4047:         WITH loc_oAba.txt_4c_EntEnderC
4048:             .ControlSource = "crSigCnFN2.cendent"
4049:             .Top           = 264
4050:             .Left          = 91
4051:             .Width         = 41
4052:             .Height        = 18
4053:             .FontName      = "Tahoma"
4054:             .FontSize      = 8
4055:             .SpecialEffect = 1
4056:             .Format        = "K"
4057:             .InputMask     = "999.99"
4058:             .Visible       = .T.
4059:         ENDWITH
4060: 
4061:         *-- Entrega - Bairro (top=252)
4062:         loc_oAba.AddObject("lbl_4c_Label27", "Label")
4063:         WITH loc_oAba.lbl_4c_Label27
4064:             .Caption   = "Bairro"
4065:             .Top       = 252
4066:             .Left      = 149
4067:             .FontName  = "Tahoma"
4068:             .FontSize  = 7
4069:             .BackStyle = 0
4070:             .ForeColor = RGB(90, 90, 90)
4071:             .AutoSize  = .T.
4072:             .Visible   = .T.
4073:         ENDWITH
4074: 
4075:         loc_oAba.AddObject("txt_4c_EntBairL", "TextBox")
4076:         WITH loc_oAba.txt_4c_EntBairL
4077:             .ControlSource = "crSigCnFN2.lbaient"
4078:             .Top           = 264
4079:             .Left          = 149
4080:             .Width         = 41
4081:             .Height        = 18
4082:             .FontName      = "Tahoma"
4083:             .FontSize      = 8
4084:             .SpecialEffect = 1
4085:             .Format        = "K"
4086:             .InputMask     = "999.99"
4087:             .Visible       = .T.
4088:         ENDWITH
4089: 
4090:         loc_oAba.AddObject("lbl_4c_Label28", "Label")
4091:         WITH loc_oAba.lbl_4c_Label28
4092:             .Caption   = "x"
4093:             .Top       = 266
4094:             .Left      = 192
4095:             .FontName  = "Tahoma"
4096:             .FontSize  = 7
4097:             .BackStyle = 0
4098:             .ForeColor = RGB(90, 90, 90)
4099:             .AutoSize  = .T.
4100:             .Visible   = .T.
4101:         ENDWITH
4102: 
4103:         loc_oAba.AddObject("txt_4c_EntBairC", "TextBox")
4104:         WITH loc_oAba.txt_4c_EntBairC
4105:             .ControlSource = "crSigCnFN2.cbaient"
4106:             .Top           = 264
4107:             .Left          = 198
4108:             .Width         = 41
4109:             .Height        = 18
4110:             .FontName      = "Tahoma"
4111:             .FontSize      = 8
4112:             .SpecialEffect = 1
4113:             .Format        = "K"
4114:             .InputMask     = "999.99"
4115:             .Visible       = .T.
4116:         ENDWITH
4117: 
4118:         *-- Entrega - Municipio (top=252)
4119:         loc_oAba.AddObject("lbl_4c_Label31", "Label")
4120:         WITH loc_oAba.lbl_4c_Label31
4121:             .Caption   = "Munic" + CHR(237) + "pio"
4122:             .Top       = 252
4123:             .Left      = 257
4124:             .FontName  = "Tahoma"
4125:             .FontSize  = 7
4126:             .BackStyle = 0
4127:             .ForeColor = RGB(90, 90, 90)
4128:             .AutoSize  = .T.
4129:             .Visible   = .T.
4130:         ENDWITH
4131: 
4132:         loc_oAba.AddObject("txt_4c_EntMuniL", "TextBox")
4133:         WITH loc_oAba.txt_4c_EntMuniL
4134:             .ControlSource = "crSigCnFN2.lmunent"
4135:             .Top           = 264
4136:             .Left          = 257
4137:             .Width         = 41
4138:             .Height        = 18
4139:             .FontName      = "Tahoma"
4140:             .FontSize      = 8
4141:             .SpecialEffect = 1
4142:             .Format        = "K"
4143:             .InputMask     = "999.99"
4144:             .Visible       = .T.
4145:         ENDWITH
4146: 
4147:         loc_oAba.AddObject("lbl_4c_Label32", "Label")
4148:         WITH loc_oAba.lbl_4c_Label32
4149:             .Caption   = "x"
4150:             .Top       = 266
4151:             .Left      = 300
4152:             .FontName  = "Tahoma"
4153:             .FontSize  = 7
4154:             .BackStyle = 0
4155:             .ForeColor = RGB(90, 90, 90)
4156:             .AutoSize  = .T.
4157:             .Visible   = .T.
4158:         ENDWITH
4159: 
4160:         loc_oAba.AddObject("txt_4c_EntMuniC", "TextBox")
4161:         WITH loc_oAba.txt_4c_EntMuniC
4162:             .ControlSource = "crSigCnFN2.cmunent"
4163:             .Top           = 264
4164:             .Left          = 306
4165:             .Width         = 41
4166:             .Height        = 18
4167:             .FontName      = "Tahoma"
4168:             .FontSize      = 8
4169:             .SpecialEffect = 1
4170:             .Format        = "K"
4171:             .InputMask     = "999.99"
4172:             .Visible       = .T.
4173:         ENDWITH
4174: 
4175:         *-- Entrega - Estado (top=252)
4176:         loc_oAba.AddObject("lbl_4c_Label33", "Label")
4177:         WITH loc_oAba.lbl_4c_Label33
4178:             .Caption   = "Estado"
4179:             .Top       = 252
4180:             .Left      = 365
4181:             .FontName  = "Tahoma"
4182:             .FontSize  = 7
4183:             .BackStyle = 0
4184:             .ForeColor = RGB(90, 90, 90)
4185:             .AutoSize  = .T.
4186:             .Visible   = .T.
4187:         ENDWITH
4188: 
4189:         loc_oAba.AddObject("txt_4c_EntEstaL", "TextBox")
4190:         WITH loc_oAba.txt_4c_EntEstaL
4191:             .ControlSource = "crSigCnFN2.lestent"
4192:             .Top           = 264
4193:             .Left          = 365
4194:             .Width         = 41
4195:             .Height        = 18
4196:             .FontName      = "Tahoma"
4197:             .FontSize      = 8
4198:             .SpecialEffect = 1
4199:             .Format        = "K"
4200:             .InputMask     = "999.99"
4201:             .Visible       = .T.
4202:         ENDWITH
4203: 
4204:         loc_oAba.AddObject("lbl_4c_Label34", "Label")
4205:         WITH loc_oAba.lbl_4c_Label34
4206:             .Caption   = "x"
4207:             .Top       = 266
4208:             .Left      = 408
4209:             .FontName  = "Tahoma"
4210:             .FontSize  = 7
4211:             .BackStyle = 0
4212:             .ForeColor = RGB(90, 90, 90)
4213:             .AutoSize  = .T.
4214:             .Visible   = .T.
4215:         ENDWITH
4216: 
4217:         loc_oAba.AddObject("txt_4c_EntEstaC", "TextBox")
4218:         WITH loc_oAba.txt_4c_EntEstaC
4219:             .ControlSource = "crSigCnFN2.cestent"
4220:             .Top           = 264
4221:             .Left          = 414
4222:             .Width         = 41
4223:             .Height        = 18
4224:             .FontName      = "Tahoma"
4225:             .FontSize      = 8
4226:             .SpecialEffect = 1
4227:             .Format        = "K"
4228:             .InputMask     = "999.99"
4229:             .Visible       = .T.
4230:         ENDWITH
4231: 
4232:         *-- Entrega - CEP (top=282)
4233:         loc_oAba.AddObject("lbl_4c_Label29", "Label")
4234:         WITH loc_oAba.lbl_4c_Label29
4235:             .Caption   = "CEP"
4236:             .Top       = 282
4237:             .Left      = 41
4238:             .FontName  = "Tahoma"
4239:             .FontSize  = 7
4240:             .BackStyle = 0
4241:             .ForeColor = RGB(90, 90, 90)
4242:             .AutoSize  = .T.
4243:             .Visible   = .T.
4244:         ENDWITH
4245: 
4246:         loc_oAba.AddObject("txt_4c_EntCepL", "TextBox")
4247:         WITH loc_oAba.txt_4c_EntCepL
4248:             .ControlSource = "crSigCnFN2.lcepent"
4249:             .Top           = 294
4250:             .Left          = 41
4251:             .Width         = 41
4252:             .Height        = 18
4253:             .FontName      = "Tahoma"
4254:             .FontSize      = 8
4255:             .SpecialEffect = 1
4256:             .Format        = "K"
4257:             .InputMask     = "999.99"
4258:             .Visible       = .T.
4259:         ENDWITH
4260: 
4261:         loc_oAba.AddObject("lbl_4c_Label30", "Label")
4262:         WITH loc_oAba.lbl_4c_Label30
4263:             .Caption   = "x"
4264:             .Top       = 296
4265:             .Left      = 84
4266:             .FontName  = "Tahoma"
4267:             .FontSize  = 7
4268:             .BackStyle = 0
4269:             .ForeColor = RGB(90, 90, 90)
4270:             .AutoSize  = .T.
4271:             .Visible   = .T.
4272:         ENDWITH
4273: 
4274:         loc_oAba.AddObject("txt_4c_EntCepC", "TextBox")
4275:         WITH loc_oAba.txt_4c_EntCepC
4276:             .ControlSource = "crSigCnFN2.ccepent"
4277:             .Top           = 294
4278:             .Left          = 90
4279:             .Width         = 41
4280:             .Height        = 18
4281:             .FontName      = "Tahoma"
4282:             .FontSize      = 8
4283:             .SpecialEffect = 1
4284:             .Format        = "K"
4285:             .InputMask     = "999.99"
4286:             .Visible       = .T.
4287:         ENDWITH
4288: 
4289:         *-- Entrega - Fone/Fax (top=282)
4290:         loc_oAba.AddObject("lbl_4c_Label35", "Label")
4291:         WITH loc_oAba.lbl_4c_Label35
4292:             .Caption   = "Fone / Fax"
4293:             .Top       = 282
4294:             .Left      = 149
4295:             .FontName  = "Tahoma"
4296:             .FontSize  = 7
4297:             .BackStyle = 0
4298:             .ForeColor = RGB(90, 90, 90)
4299:             .AutoSize  = .T.
4300:             .Visible   = .T.
4301:         ENDWITH
4302: 
4303:         loc_oAba.AddObject("txt_4c_EntFoneL", "TextBox")
4304:         WITH loc_oAba.txt_4c_EntFoneL
4305:             .ControlSource = "crSigCnFN2.lfoneent"
4306:             .Top           = 294
4307:             .Left          = 149
4308:             .Width         = 41
4309:             .Height        = 18
4310:             .FontName      = "Tahoma"
4311:             .FontSize      = 8
4312:             .SpecialEffect = 1
4313:             .Format        = "K"
4314:             .InputMask     = "999.99"
4315:             .Visible       = .T.
4316:         ENDWITH
4317: 
4318:         loc_oAba.AddObject("lbl_4c_Label36", "Label")
4319:         WITH loc_oAba.lbl_4c_Label36
4320:             .Caption   = "x"
4321:             .Top       = 296
4322:             .Left      = 192
4323:             .FontName  = "Tahoma"
4324:             .FontSize  = 7
4325:             .BackStyle = 0
4326:             .ForeColor = RGB(90, 90, 90)
4327:             .AutoSize  = .T.
4328:             .Visible   = .T.
4329:         ENDWITH
4330: 
4331:         loc_oAba.AddObject("txt_4c_EntFoneC", "TextBox")
4332:         WITH loc_oAba.txt_4c_EntFoneC
4333:             .ControlSource = "crSigCnFN2.cfoneent"
4334:             .Top           = 294
4335:             .Left          = 198
4336:             .Width         = 41
4337:             .Height        = 18
4338:             .FontName      = "Tahoma"
4339:             .FontSize      = 8
4340:             .SpecialEffect = 1
4341:             .Format        = "K"
4342:             .InputMask     = "999.99"
4343:             .Visible       = .T.
4344:         ENDWITH
4345: 
4346:         *-- Entrega - Titulo de Impressao (top=282)
4347:         loc_oAba.AddObject("lbl_4c_Label39", "Label")
4348:         WITH loc_oAba.lbl_4c_Label39
4349:             .Caption   = "Titulo de Impress" + CHR(227) + "o (Enrdere" + CHR(231) + "o Entrega)"
4350:             .Top       = 282
4351:             .Left      = 257
4352:             .FontName  = "Tahoma"
4353:             .FontSize  = 7
4354:             .BackStyle = 0
4355:             .ForeColor = RGB(90, 90, 90)
4356:             .AutoSize  = .T.
4357:             .Visible   = .T.
4358:         ENDWITH
4359: 
4360:         loc_oAba.AddObject("txt_4c_EntTitEndL", "TextBox")
4361:         WITH loc_oAba.txt_4c_EntTitEndL
4362:             .ControlSource = "crSigCnFN2.lendtite"
4363:             .Top           = 294
4364:             .Left          = 257
4365:             .Width         = 41
4366:             .Height        = 18
4367:             .FontName      = "Tahoma"
4368:             .FontSize      = 8
4369:             .SpecialEffect = 1
4370:             .Format        = "K"
4371:             .InputMask     = "999.99"
4372:             .Visible       = .T.
4373:         ENDWITH
4374: 
4375:         loc_oAba.AddObject("lbl_4c_Label40", "Label")
4376:         WITH loc_oAba.lbl_4c_Label40
4377:             .Caption   = "x"
4378:             .Top       = 296
4379:             .Left      = 300
4380:             .FontName  = "Tahoma"
4381:             .FontSize  = 7
4382:             .BackStyle = 0
4383:             .ForeColor = RGB(90, 90, 90)
4384:             .AutoSize  = .T.
4385:             .Visible   = .T.
4386:         ENDWITH
4387: 
4388:         loc_oAba.AddObject("txt_4c_EntTitEndC", "TextBox")
4389:         WITH loc_oAba.txt_4c_EntTitEndC
4390:             .ControlSource = "crSigCnFN2.cendtite"
4391:             .Top           = 294
4392:             .Left          = 306
4393:             .Width         = 41
4394:             .Height        = 18
4395:             .FontName      = "Tahoma"
4396:             .FontSize      = 8
4397:             .SpecialEffect = 1

*-- Linhas 4403 a 4526:
4403:         loc_oAba.AddObject("txt_4c_EntTitulo", "TextBox")
4404:         WITH loc_oAba.txt_4c_EntTitulo
4405:             .ControlSource = "crSigCnFN2.ctitent"
4406:             .Top           = 294
4407:             .Left          = 353
4408:             .Width         = 150
4409:             .Height        = 18
4410:             .MaxLength     = 20
4411:             .FontName      = "Tahoma"
4412:             .FontSize      = 8
4413:             .SpecialEffect = 1
4414:             .Format        = "K"
4415:             .InputMask     = ""
4416:             .Visible       = .T.
4417:         ENDWITH
4418: 
4419:         *-- Secao: Codigo Posto Fiscal / Codigo Suframa (top=313)
4420:         loc_oAba.AddObject("lbl_4c_Label11", "Label")
4421:         WITH loc_oAba.lbl_4c_Label11
4422:             .Caption   = "C" + CHR(243) + "digo Posto Fiscal"
4423:             .Top       = 313
4424:             .Left      = 41
4425:             .FontName  = "Tahoma"
4426:             .FontSize  = 7
4427:             .BackStyle = 0
4428:             .ForeColor = RGB(90, 90, 90)
4429:             .AutoSize  = .T.
4430:             .Visible   = .T.
4431:         ENDWITH
4432: 
4433:         loc_oAba.AddObject("txt_4c_PosFisL", "TextBox")
4434:         WITH loc_oAba.txt_4c_PosFisL
4435:             .ControlSource = "crSigCnFNf.lposfis"
4436:             .Top           = 325
4437:             .Left          = 41
4438:             .Width         = 41
4439:             .Height        = 18
4440:             .FontName      = "Tahoma"
4441:             .FontSize      = 8
4442:             .SpecialEffect = 1
4443:             .Format        = "K"
4444:             .InputMask     = "999.99"
4445:             .Visible       = .T.
4446:         ENDWITH
4447: 
4448:         loc_oAba.AddObject("lbl_4c_Label12", "Label")
4449:         WITH loc_oAba.lbl_4c_Label12
4450:             .Caption   = "x"
4451:             .Top       = 327
4452:             .Left      = 84
4453:             .FontName  = "Tahoma"
4454:             .FontSize  = 7
4455:             .BackStyle = 0
4456:             .ForeColor = RGB(90, 90, 90)
4457:             .AutoSize  = .T.
4458:             .Visible   = .T.
4459:         ENDWITH
4460: 
4461:         loc_oAba.AddObject("txt_4c_PosFisC", "TextBox")
4462:         WITH loc_oAba.txt_4c_PosFisC
4463:             .ControlSource = "crSigCnFNf.cposfis"
4464:             .Top           = 325
4465:             .Left          = 90
4466:             .Width         = 41
4467:             .Height        = 18
4468:             .FontName      = "Tahoma"
4469:             .FontSize      = 8
4470:             .SpecialEffect = 1
4471:             .Format        = "K"
4472:             .InputMask     = "999.99"
4473:             .Visible       = .T.
4474:         ENDWITH
4475: 
4476:         loc_oAba.AddObject("lbl_4c_Label23", "Label")
4477:         WITH loc_oAba.lbl_4c_Label23
4478:             .Caption   = "C" + CHR(243) + "digo Suframa"
4479:             .Top       = 313
4480:             .Left      = 149
4481:             .FontName  = "Tahoma"
4482:             .FontSize  = 7
4483:             .BackStyle = 0
4484:             .ForeColor = RGB(90, 90, 90)
4485:             .AutoSize  = .T.
4486:             .Visible   = .T.
4487:         ENDWITH
4488: 
4489:         loc_oAba.AddObject("txt_4c_SuframaL", "TextBox")
4490:         WITH loc_oAba.txt_4c_SuframaL
4491:             .ControlSource = "crSigCnFNf.lsufras"
4492:             .Top           = 325
4493:             .Left          = 149
4494:             .Width         = 41
4495:             .Height        = 18
4496:             .FontName      = "Tahoma"
4497:             .FontSize      = 8
4498:             .SpecialEffect = 1
4499:             .Format        = "K"
4500:             .InputMask     = "999.99"
4501:             .Visible       = .T.
4502:         ENDWITH
4503: 
4504:         loc_oAba.AddObject("lbl_4c_Label24", "Label")
4505:         WITH loc_oAba.lbl_4c_Label24
4506:             .Caption   = "x"
4507:             .Top       = 327
4508:             .Left      = 192
4509:             .FontName  = "Tahoma"
4510:             .FontSize  = 7
4511:             .BackStyle = 0
4512:             .ForeColor = RGB(90, 90, 90)
4513:             .AutoSize  = .T.
4514:             .Visible   = .T.
4515:         ENDWITH
4516: 
4517:         loc_oAba.AddObject("txt_4c_SuframaC", "TextBox")
4518:         WITH loc_oAba.txt_4c_SuframaC
4519:             .ControlSource = "crSigCnFNf.csufras"
4520:             .Top           = 325
4521:             .Left          = 198
4522:             .Width         = 41
4523:             .Height        = 18
4524:             .FontName      = "Tahoma"
4525:             .FontSize      = 8
4526:             .SpecialEffect = 1

*-- Linhas 4536 a 6198:
4536:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3
4537: 
4538:         *-- Cabecalho de colunas (top=25)
4539:         loc_oAba.AddObject("lbl_4c_LblNumero", "Label")
4540:         WITH loc_oAba.lbl_4c_LblNumero
4541:             .Caption   = "N" + CHR(250) + "mero"
4542:             .Top       = 25
4543:             .Left      = 87
4544:             .FontName  = "Tahoma"
4545:             .FontSize  = 7
4546:             .BackStyle = 0
4547:             .ForeColor = RGB(90, 90, 90)
4548:             .AutoSize  = .T.
4549:             .Visible   = .T.
4550:         ENDWITH
4551: 
4552:         loc_oAba.AddObject("lbl_4c_LblValor", "Label")
4553:         WITH loc_oAba.lbl_4c_LblValor
4554:             .Caption   = "Valor"
4555:             .Top       = 25
4556:             .Left      = 200
4557:             .FontName  = "Tahoma"
4558:             .FontSize  = 7
4559:             .BackStyle = 0
4560:             .ForeColor = RGB(90, 90, 90)
4561:             .AutoSize  = .T.
4562:             .Visible   = .T.
4563:         ENDWITH
4564: 
4565:         loc_oAba.AddObject("lbl_4c_LblVecto", "Label")
4566:         WITH loc_oAba.lbl_4c_LblVecto
4567:             .Caption   = "Vencimento"
4568:             .Top       = 25
4569:             .Left      = 294
4570:             .FontName  = "Tahoma"
4571:             .FontSize  = 7
4572:             .BackStyle = 0
4573:             .ForeColor = RGB(90, 90, 90)
4574:             .AutoSize  = .T.
4575:             .Visible   = .T.
4576:         ENDWITH
4577: 
4578:         *-- Faturas 1 a 10 - cada fatura tem: Label[Fat N], txt[num L], x, txt[num C], txt[val L], x, txt[val C], txt[vec L], x, txt[vec C]
4579:         *-- Fatura 1 (top=37/39, fat-label at top=39)
4580:         loc_oAba.AddObject("lbl_4c_Fat1", "Label")
4581:         WITH loc_oAba.lbl_4c_Fat1
4582:             .Caption   = "Fatura 1"
4583:             .Top       = 39
4584:             .Left      = 13
4585:             .FontName  = "Tahoma"
4586:             .FontSize  = 7
4587:             .BackStyle = 0
4588:             .ForeColor = RGB(90, 90, 90)
4589:             .AutoSize  = .T.
4590:             .Visible   = .T.
4591:         ENDWITH
4592:         loc_oAba.AddObject("txt_4c_Fat1NumL", "TextBox")
4593:         WITH loc_oAba.txt_4c_Fat1NumL
4594:             .ControlSource = "crSigCnFNf.lfat1num"
4595:             .Top = 37
4596:             .Left = 58
4597:             .Width = 41
4598:             .Height = 18
4599:             .FontName = "Tahoma"
4600:             .FontSize = 8
4601:             .SpecialEffect = 1
4602:             .Format = "K"
4603:             .InputMask = "999.99"
4604:             .Visible = .T.
4605:         ENDWITH
4606:         loc_oAba.AddObject("lbl_4c_F1NX", "Label")
4607:         WITH loc_oAba.lbl_4c_F1NX
4608:             .Caption = "x"
4609:             .Top = 39
4610:             .Left = 101
4611:             .FontName = "Tahoma"
4612:             .FontSize = 7
4613:             .BackStyle = 0
4614:             .ForeColor = RGB(90,90,90)
4615:             .AutoSize = .T.
4616:             .Visible = .T.
4617:         ENDWITH
4618:         loc_oAba.AddObject("txt_4c_Fat1NumC", "TextBox")
4619:         WITH loc_oAba.txt_4c_Fat1NumC
4620:             .ControlSource = "crSigCnFNf.cfat1num"
4621:             .Top = 37
4622:             .Left = 107
4623:             .Width = 41
4624:             .Height = 18
4625:             .FontName = "Tahoma"
4626:             .FontSize = 8
4627:             .SpecialEffect = 1
4628:             .Format = "K"
4629:             .InputMask = "999.99"
4630:             .Visible = .T.
4631:         ENDWITH
4632:         loc_oAba.AddObject("txt_4c_Fat1ValL", "TextBox")
4633:         WITH loc_oAba.txt_4c_Fat1ValL
4634:             .ControlSource = "crSigCnFNf.lfat1val"
4635:             .Top = 37
4636:             .Left = 165
4637:             .Width = 41
4638:             .Height = 18
4639:             .FontName = "Tahoma"
4640:             .FontSize = 8
4641:             .SpecialEffect = 1
4642:             .Format = "K"
4643:             .InputMask = "999.99"
4644:             .Visible = .T.
4645:         ENDWITH
4646:         loc_oAba.AddObject("lbl_4c_F1VX", "Label")
4647:         WITH loc_oAba.lbl_4c_F1VX
4648:             .Caption = "x"
4649:             .Top = 39
4650:             .Left = 208
4651:             .FontName = "Tahoma"
4652:             .FontSize = 7
4653:             .BackStyle = 0
4654:             .ForeColor = RGB(90,90,90)
4655:             .AutoSize = .T.
4656:             .Visible = .T.
4657:         ENDWITH
4658:         loc_oAba.AddObject("txt_4c_Fat1ValC", "TextBox")
4659:         WITH loc_oAba.txt_4c_Fat1ValC
4660:             .ControlSource = "crSigCnFNf.cfat1val"
4661:             .Top = 37
4662:             .Left = 214
4663:             .Width = 41
4664:             .Height = 18
4665:             .FontName = "Tahoma"
4666:             .FontSize = 8
4667:             .SpecialEffect = 1
4668:             .Format = "K"
4669:             .InputMask = "999.99"
4670:             .Visible = .T.
4671:         ENDWITH
4672:         loc_oAba.AddObject("txt_4c_Fat1VecL", "TextBox")
4673:         WITH loc_oAba.txt_4c_Fat1VecL
4674:             .ControlSource = "crSigCnFNf.lfat1vec"
4675:             .Top = 37
4676:             .Left = 273
4677:             .Width = 41
4678:             .Height = 18
4679:             .FontName = "Tahoma"
4680:             .FontSize = 8
4681:             .SpecialEffect = 1
4682:             .Format = "K"
4683:             .InputMask = "999.99"
4684:             .Visible = .T.
4685:         ENDWITH
4686:         loc_oAba.AddObject("lbl_4c_F1EX", "Label")
4687:         WITH loc_oAba.lbl_4c_F1EX
4688:             .Caption = "x"
4689:             .Top = 39
4690:             .Left = 316
4691:             .FontName = "Tahoma"
4692:             .FontSize = 7
4693:             .BackStyle = 0
4694:             .ForeColor = RGB(90,90,90)
4695:             .AutoSize = .T.
4696:             .Visible = .T.
4697:         ENDWITH
4698:         loc_oAba.AddObject("txt_4c_Fat1VecC", "TextBox")
4699:         WITH loc_oAba.txt_4c_Fat1VecC
4700:             .ControlSource = "crSigCnFNf.cfat1vec"
4701:             .Top = 37
4702:             .Left = 322
4703:             .Width = 41
4704:             .Height = 18
4705:             .FontName = "Tahoma"
4706:             .FontSize = 8
4707:             .SpecialEffect = 1
4708:             .Format = "K"
4709:             .InputMask = "999.99"
4710:             .Visible = .T.
4711:         ENDWITH
4712: 
4713:         *-- Fatura 2 (top=56/58)
4714:         loc_oAba.AddObject("lbl_4c_Fat2", "Label")
4715:         WITH loc_oAba.lbl_4c_Fat2
4716:             .Caption = "Fatura 2"
4717:             .Top = 58
4718:             .Left = 13
4719:             .FontName = "Tahoma"
4720:             .FontSize = 7
4721:             .BackStyle = 0
4722:             .ForeColor = RGB(90,90,90)
4723:             .AutoSize = .T.
4724:             .Visible = .T.
4725:         ENDWITH
4726:         loc_oAba.AddObject("txt_4c_Fat2NumL", "TextBox")
4727:         WITH loc_oAba.txt_4c_Fat2NumL
4728:             .ControlSource = "crSigCnFNf.lfat2num"
4729:             .Top = 56
4730:             .Left = 58
4731:             .Width = 41
4732:             .Height = 18
4733:             .FontName = "Tahoma"
4734:             .FontSize = 8
4735:             .SpecialEffect = 1
4736:             .Format = "K"
4737:             .InputMask = "999.99"
4738:             .Visible = .T.
4739:         ENDWITH
4740:         loc_oAba.AddObject("lbl_4c_F2NX", "Label")
4741:         WITH loc_oAba.lbl_4c_F2NX
4742:             .Caption = "x"
4743:             .Top = 58
4744:             .Left = 101
4745:             .FontName = "Tahoma"
4746:             .FontSize = 7
4747:             .BackStyle = 0
4748:             .ForeColor = RGB(90,90,90)
4749:             .AutoSize = .T.
4750:             .Visible = .T.
4751:         ENDWITH
4752:         loc_oAba.AddObject("txt_4c_Fat2NumC", "TextBox")
4753:         WITH loc_oAba.txt_4c_Fat2NumC
4754:             .ControlSource = "crSigCnFNf.cfat2num"
4755:             .Top = 56
4756:             .Left = 107
4757:             .Width = 41
4758:             .Height = 18
4759:             .FontName = "Tahoma"
4760:             .FontSize = 8
4761:             .SpecialEffect = 1
4762:             .Format = "K"
4763:             .InputMask = "999.99"
4764:             .Visible = .T.
4765:         ENDWITH
4766:         loc_oAba.AddObject("txt_4c_Fat2ValL", "TextBox")
4767:         WITH loc_oAba.txt_4c_Fat2ValL
4768:             .ControlSource = "crSigCnFNf.lfat2val"
4769:             .Top = 56
4770:             .Left = 165
4771:             .Width = 41
4772:             .Height = 18
4773:             .FontName = "Tahoma"
4774:             .FontSize = 8
4775:             .SpecialEffect = 1
4776:             .Format = "K"
4777:             .InputMask = "999.99"
4778:             .Visible = .T.
4779:         ENDWITH
4780:         loc_oAba.AddObject("lbl_4c_F2VX", "Label")
4781:         WITH loc_oAba.lbl_4c_F2VX
4782:             .Caption = "x"
4783:             .Top = 58
4784:             .Left = 208
4785:             .FontName = "Tahoma"
4786:             .FontSize = 7
4787:             .BackStyle = 0
4788:             .ForeColor = RGB(90,90,90)
4789:             .AutoSize = .T.
4790:             .Visible = .T.
4791:         ENDWITH
4792:         loc_oAba.AddObject("txt_4c_Fat2ValC", "TextBox")
4793:         WITH loc_oAba.txt_4c_Fat2ValC
4794:             .ControlSource = "crSigCnFNf.cfat2val"
4795:             .Top = 56
4796:             .Left = 214
4797:             .Width = 41
4798:             .Height = 18
4799:             .FontName = "Tahoma"
4800:             .FontSize = 8
4801:             .SpecialEffect = 1
4802:             .Format = "K"
4803:             .InputMask = "999.99"
4804:             .Visible = .T.
4805:         ENDWITH
4806:         loc_oAba.AddObject("txt_4c_Fat2VecL", "TextBox")
4807:         WITH loc_oAba.txt_4c_Fat2VecL
4808:             .ControlSource = "crSigCnFNf.lfat2vec"
4809:             .Top = 56
4810:             .Left = 273
4811:             .Width = 41
4812:             .Height = 18
4813:             .FontName = "Tahoma"
4814:             .FontSize = 8
4815:             .SpecialEffect = 1
4816:             .Format = "K"
4817:             .InputMask = "999.99"
4818:             .Visible = .T.
4819:         ENDWITH
4820:         loc_oAba.AddObject("lbl_4c_F2EX", "Label")
4821:         WITH loc_oAba.lbl_4c_F2EX
4822:             .Caption = "x"
4823:             .Top = 58
4824:             .Left = 316
4825:             .FontName = "Tahoma"
4826:             .FontSize = 7
4827:             .BackStyle = 0
4828:             .ForeColor = RGB(90,90,90)
4829:             .AutoSize = .T.
4830:             .Visible = .T.
4831:         ENDWITH
4832:         loc_oAba.AddObject("txt_4c_Fat2VecC", "TextBox")
4833:         WITH loc_oAba.txt_4c_Fat2VecC
4834:             .ControlSource = "crSigCnFNf.cfat2vec"
4835:             .Top = 56
4836:             .Left = 322
4837:             .Width = 41
4838:             .Height = 18
4839:             .FontName = "Tahoma"
4840:             .FontSize = 8
4841:             .SpecialEffect = 1
4842:             .Format = "K"
4843:             .InputMask = "999.99"
4844:             .Visible = .T.
4845:         ENDWITH
4846: 
4847:         *-- Fatura 3 (top=75/77)
4848:         loc_oAba.AddObject("lbl_4c_Fat3", "Label")
4849:         WITH loc_oAba.lbl_4c_Fat3
4850:             .Caption = "Fatura 3"
4851:             .Top = 77
4852:             .Left = 13
4853:             .FontName = "Tahoma"
4854:             .FontSize = 7
4855:             .BackStyle = 0
4856:             .ForeColor = RGB(90,90,90)
4857:             .AutoSize = .T.
4858:             .Visible = .T.
4859:         ENDWITH
4860:         loc_oAba.AddObject("txt_4c_Fat3NumL", "TextBox")
4861:         WITH loc_oAba.txt_4c_Fat3NumL
4862:             .ControlSource = "crSigCnFNf.lfat3num"
4863:             .Top = 75
4864:             .Left = 58
4865:             .Width = 41
4866:             .Height = 18
4867:             .FontName = "Tahoma"
4868:             .FontSize = 8
4869:             .SpecialEffect = 1
4870:             .Format = "K"
4871:             .InputMask = "999.99"
4872:             .Visible = .T.
4873:         ENDWITH
4874:         loc_oAba.AddObject("lbl_4c_F3NX", "Label")
4875:         WITH loc_oAba.lbl_4c_F3NX
4876:             .Caption = "x"
4877:             .Top = 77
4878:             .Left = 101
4879:             .FontName = "Tahoma"
4880:             .FontSize = 7
4881:             .BackStyle = 0
4882:             .ForeColor = RGB(90,90,90)
4883:             .AutoSize = .T.
4884:             .Visible = .T.
4885:         ENDWITH
4886:         loc_oAba.AddObject("txt_4c_Fat3NumC", "TextBox")
4887:         WITH loc_oAba.txt_4c_Fat3NumC
4888:             .ControlSource = "crSigCnFNf.cfat3num"
4889:             .Top = 75
4890:             .Left = 107
4891:             .Width = 41
4892:             .Height = 18
4893:             .FontName = "Tahoma"
4894:             .FontSize = 8
4895:             .SpecialEffect = 1
4896:             .Format = "K"
4897:             .InputMask = "999.99"
4898:             .Visible = .T.
4899:         ENDWITH
4900:         loc_oAba.AddObject("txt_4c_Fat3ValL", "TextBox")
4901:         WITH loc_oAba.txt_4c_Fat3ValL
4902:             .ControlSource = "crSigCnFNf.lfat3val"
4903:             .Top = 75
4904:             .Left = 165
4905:             .Width = 41
4906:             .Height = 18
4907:             .FontName = "Tahoma"
4908:             .FontSize = 8
4909:             .SpecialEffect = 1
4910:             .Format = "K"
4911:             .InputMask = "999.99"
4912:             .Visible = .T.
4913:         ENDWITH
4914:         loc_oAba.AddObject("lbl_4c_F3VX", "Label")
4915:         WITH loc_oAba.lbl_4c_F3VX
4916:             .Caption = "x"
4917:             .Top = 77
4918:             .Left = 208
4919:             .FontName = "Tahoma"
4920:             .FontSize = 7
4921:             .BackStyle = 0
4922:             .ForeColor = RGB(90,90,90)
4923:             .AutoSize = .T.
4924:             .Visible = .T.
4925:         ENDWITH
4926:         loc_oAba.AddObject("txt_4c_Fat3ValC", "TextBox")
4927:         WITH loc_oAba.txt_4c_Fat3ValC
4928:             .ControlSource = "crSigCnFNf.cfat3val"
4929:             .Top = 75
4930:             .Left = 214
4931:             .Width = 41
4932:             .Height = 18
4933:             .FontName = "Tahoma"
4934:             .FontSize = 8
4935:             .SpecialEffect = 1
4936:             .Format = "K"
4937:             .InputMask = "999.99"
4938:             .Visible = .T.
4939:         ENDWITH
4940:         loc_oAba.AddObject("txt_4c_Fat3VecL", "TextBox")
4941:         WITH loc_oAba.txt_4c_Fat3VecL
4942:             .ControlSource = "crSigCnFNf.lfat3vec"
4943:             .Top = 75
4944:             .Left = 273
4945:             .Width = 41
4946:             .Height = 18
4947:             .FontName = "Tahoma"
4948:             .FontSize = 8
4949:             .SpecialEffect = 1
4950:             .Format = "K"
4951:             .InputMask = "999.99"
4952:             .Visible = .T.
4953:         ENDWITH
4954:         loc_oAba.AddObject("lbl_4c_F3EX", "Label")
4955:         WITH loc_oAba.lbl_4c_F3EX
4956:             .Caption = "x"
4957:             .Top = 77
4958:             .Left = 316
4959:             .FontName = "Tahoma"
4960:             .FontSize = 7
4961:             .BackStyle = 0
4962:             .ForeColor = RGB(90,90,90)
4963:             .AutoSize = .T.
4964:             .Visible = .T.
4965:         ENDWITH
4966:         loc_oAba.AddObject("txt_4c_Fat3VecC", "TextBox")
4967:         WITH loc_oAba.txt_4c_Fat3VecC
4968:             .ControlSource = "crSigCnFNf.cfat3vec"
4969:             .Top = 75
4970:             .Left = 322
4971:             .Width = 41
4972:             .Height = 18
4973:             .FontName = "Tahoma"
4974:             .FontSize = 8
4975:             .SpecialEffect = 1
4976:             .Format = "K"
4977:             .InputMask = "999.99"
4978:             .Visible = .T.
4979:         ENDWITH
4980: 
4981:         *-- Fatura 4 (top=94/96)
4982:         loc_oAba.AddObject("lbl_4c_Fat4", "Label")
4983:         WITH loc_oAba.lbl_4c_Fat4
4984:             .Caption = "Fatura 4"
4985:             .Top = 96
4986:             .Left = 13
4987:             .FontName = "Tahoma"
4988:             .FontSize = 7
4989:             .BackStyle = 0
4990:             .ForeColor = RGB(90,90,90)
4991:             .AutoSize = .T.
4992:             .Visible = .T.
4993:         ENDWITH
4994:         loc_oAba.AddObject("txt_4c_Fat4NumL", "TextBox")
4995:         WITH loc_oAba.txt_4c_Fat4NumL
4996:             .ControlSource = "crSigCnFNf.lfat4num"
4997:             .Top = 94
4998:             .Left = 58
4999:             .Width = 41
5000:             .Height = 18
5001:             .FontName = "Tahoma"
5002:             .FontSize = 8
5003:             .SpecialEffect = 1
5004:             .Format = "K"
5005:             .InputMask = "999.99"
5006:             .Visible = .T.
5007:         ENDWITH
5008:         loc_oAba.AddObject("lbl_4c_F4NX", "Label")
5009:         WITH loc_oAba.lbl_4c_F4NX
5010:             .Caption = "x"
5011:             .Top = 96
5012:             .Left = 101
5013:             .FontName = "Tahoma"
5014:             .FontSize = 7
5015:             .BackStyle = 0
5016:             .ForeColor = RGB(90,90,90)
5017:             .AutoSize = .T.
5018:             .Visible = .T.
5019:         ENDWITH
5020:         loc_oAba.AddObject("txt_4c_Fat4NumC", "TextBox")
5021:         WITH loc_oAba.txt_4c_Fat4NumC
5022:             .ControlSource = "crSigCnFNf.cfat4num"
5023:             .Top = 94
5024:             .Left = 107
5025:             .Width = 41
5026:             .Height = 18
5027:             .FontName = "Tahoma"
5028:             .FontSize = 8
5029:             .SpecialEffect = 1
5030:             .Format = "K"
5031:             .InputMask = "999.99"
5032:             .Visible = .T.
5033:         ENDWITH
5034:         loc_oAba.AddObject("txt_4c_Fat4ValL", "TextBox")
5035:         WITH loc_oAba.txt_4c_Fat4ValL
5036:             .ControlSource = "crSigCnFNf.lfat4val"
5037:             .Top = 94
5038:             .Left = 165
5039:             .Width = 41
5040:             .Height = 18
5041:             .FontName = "Tahoma"
5042:             .FontSize = 8
5043:             .SpecialEffect = 1
5044:             .Format = "K"
5045:             .InputMask = "999.99"
5046:             .Visible = .T.
5047:         ENDWITH
5048:         loc_oAba.AddObject("lbl_4c_F4VX", "Label")
5049:         WITH loc_oAba.lbl_4c_F4VX
5050:             .Caption = "x"
5051:             .Top = 96
5052:             .Left = 208
5053:             .FontName = "Tahoma"
5054:             .FontSize = 7
5055:             .BackStyle = 0
5056:             .ForeColor = RGB(90,90,90)
5057:             .AutoSize = .T.
5058:             .Visible = .T.
5059:         ENDWITH
5060:         loc_oAba.AddObject("txt_4c_Fat4ValC", "TextBox")
5061:         WITH loc_oAba.txt_4c_Fat4ValC
5062:             .ControlSource = "crSigCnFNf.cfat4val"
5063:             .Top = 94
5064:             .Left = 214
5065:             .Width = 41
5066:             .Height = 18
5067:             .FontName = "Tahoma"
5068:             .FontSize = 8
5069:             .SpecialEffect = 1
5070:             .Format = "K"
5071:             .InputMask = "999.99"
5072:             .Visible = .T.
5073:         ENDWITH
5074:         loc_oAba.AddObject("txt_4c_Fat4VecL", "TextBox")
5075:         WITH loc_oAba.txt_4c_Fat4VecL
5076:             .ControlSource = "crSigCnFNf.lfat4vec"
5077:             .Top = 94
5078:             .Left = 273
5079:             .Width = 41
5080:             .Height = 18
5081:             .FontName = "Tahoma"
5082:             .FontSize = 8
5083:             .SpecialEffect = 1
5084:             .Format = "K"
5085:             .InputMask = "999.99"
5086:             .Visible = .T.
5087:         ENDWITH
5088:         loc_oAba.AddObject("lbl_4c_F4EX", "Label")
5089:         WITH loc_oAba.lbl_4c_F4EX
5090:             .Caption = "x"
5091:             .Top = 96
5092:             .Left = 316
5093:             .FontName = "Tahoma"
5094:             .FontSize = 7
5095:             .BackStyle = 0
5096:             .ForeColor = RGB(90,90,90)
5097:             .AutoSize = .T.
5098:             .Visible = .T.
5099:         ENDWITH
5100:         loc_oAba.AddObject("txt_4c_Fat4VecC", "TextBox")
5101:         WITH loc_oAba.txt_4c_Fat4VecC
5102:             .ControlSource = "crSigCnFNf.cfat4vec"
5103:             .Top = 94
5104:             .Left = 322
5105:             .Width = 41
5106:             .Height = 18
5107:             .FontName = "Tahoma"
5108:             .FontSize = 8
5109:             .SpecialEffect = 1
5110:             .Format = "K"
5111:             .InputMask = "999.99"
5112:             .Visible = .T.
5113:         ENDWITH
5114: 
5115:         *-- Fatura 5 (top=113/115)
5116:         loc_oAba.AddObject("lbl_4c_Fat5", "Label")
5117:         WITH loc_oAba.lbl_4c_Fat5
5118:             .Caption = "Fatura 5"
5119:             .Top = 115
5120:             .Left = 13
5121:             .FontName = "Tahoma"
5122:             .FontSize = 7
5123:             .BackStyle = 0
5124:             .ForeColor = RGB(90,90,90)
5125:             .AutoSize = .T.
5126:             .Visible = .T.
5127:         ENDWITH
5128:         loc_oAba.AddObject("txt_4c_Fat5NumL", "TextBox")
5129:         WITH loc_oAba.txt_4c_Fat5NumL
5130:             .ControlSource = "crSigCnFNf.lfat5num"
5131:             .Top = 113
5132:             .Left = 58
5133:             .Width = 41
5134:             .Height = 18
5135:             .FontName = "Tahoma"
5136:             .FontSize = 8
5137:             .SpecialEffect = 1
5138:             .Format = "K"
5139:             .InputMask = "999.99"
5140:             .Visible = .T.
5141:         ENDWITH
5142:         loc_oAba.AddObject("lbl_4c_F5NX", "Label")
5143:         WITH loc_oAba.lbl_4c_F5NX
5144:             .Caption = "x"
5145:             .Top = 115
5146:             .Left = 101
5147:             .FontName = "Tahoma"
5148:             .FontSize = 7
5149:             .BackStyle = 0
5150:             .ForeColor = RGB(90,90,90)
5151:             .AutoSize = .T.
5152:             .Visible = .T.
5153:         ENDWITH
5154:         loc_oAba.AddObject("txt_4c_Fat5NumC", "TextBox")
5155:         WITH loc_oAba.txt_4c_Fat5NumC
5156:             .ControlSource = "crSigCnFNf.cfat5num"
5157:             .Top = 113
5158:             .Left = 107
5159:             .Width = 41
5160:             .Height = 18
5161:             .FontName = "Tahoma"
5162:             .FontSize = 8
5163:             .SpecialEffect = 1
5164:             .Format = "K"
5165:             .InputMask = "999.99"
5166:             .Visible = .T.
5167:         ENDWITH
5168:         loc_oAba.AddObject("txt_4c_Fat5ValL", "TextBox")
5169:         WITH loc_oAba.txt_4c_Fat5ValL
5170:             .ControlSource = "crSigCnFNf.lfat5val"
5171:             .Top = 113
5172:             .Left = 165
5173:             .Width = 41
5174:             .Height = 18
5175:             .FontName = "Tahoma"
5176:             .FontSize = 8
5177:             .SpecialEffect = 1
5178:             .Format = "K"
5179:             .InputMask = "999.99"
5180:             .Visible = .T.
5181:         ENDWITH
5182:         loc_oAba.AddObject("lbl_4c_F5VX", "Label")
5183:         WITH loc_oAba.lbl_4c_F5VX
5184:             .Caption = "x"
5185:             .Top = 115
5186:             .Left = 208
5187:             .FontName = "Tahoma"
5188:             .FontSize = 7
5189:             .BackStyle = 0
5190:             .ForeColor = RGB(90,90,90)
5191:             .AutoSize = .T.
5192:             .Visible = .T.
5193:         ENDWITH
5194:         loc_oAba.AddObject("txt_4c_Fat5ValC", "TextBox")
5195:         WITH loc_oAba.txt_4c_Fat5ValC
5196:             .ControlSource = "crSigCnFNf.cfat5val"
5197:             .Top = 113
5198:             .Left = 214
5199:             .Width = 41
5200:             .Height = 18
5201:             .FontName = "Tahoma"
5202:             .FontSize = 8
5203:             .SpecialEffect = 1
5204:             .Format = "K"
5205:             .InputMask = "999.99"
5206:             .Visible = .T.
5207:         ENDWITH
5208:         loc_oAba.AddObject("txt_4c_Fat5VecL", "TextBox")
5209:         WITH loc_oAba.txt_4c_Fat5VecL
5210:             .ControlSource = "crSigCnFNf.lfat5vec"
5211:             .Top = 113
5212:             .Left = 273
5213:             .Width = 41
5214:             .Height = 18
5215:             .FontName = "Tahoma"
5216:             .FontSize = 8
5217:             .SpecialEffect = 1
5218:             .Format = "K"
5219:             .InputMask = "999.99"
5220:             .Visible = .T.
5221:         ENDWITH
5222:         loc_oAba.AddObject("lbl_4c_F5EX", "Label")
5223:         WITH loc_oAba.lbl_4c_F5EX
5224:             .Caption = "x"
5225:             .Top = 115
5226:             .Left = 316
5227:             .FontName = "Tahoma"
5228:             .FontSize = 7
5229:             .BackStyle = 0
5230:             .ForeColor = RGB(90,90,90)
5231:             .AutoSize = .T.
5232:             .Visible = .T.
5233:         ENDWITH
5234:         loc_oAba.AddObject("txt_4c_Fat5VecC", "TextBox")
5235:         WITH loc_oAba.txt_4c_Fat5VecC
5236:             .ControlSource = "crSigCnFNf.cfat5vec"
5237:             .Top = 113
5238:             .Left = 322
5239:             .Width = 41
5240:             .Height = 18
5241:             .FontName = "Tahoma"
5242:             .FontSize = 8
5243:             .SpecialEffect = 1
5244:             .Format = "K"
5245:             .InputMask = "999.99"
5246:             .Visible = .T.
5247:         ENDWITH
5248: 
5249:         *-- Fatura 6 (top=132/134)
5250:         loc_oAba.AddObject("lbl_4c_Fat6", "Label")
5251:         WITH loc_oAba.lbl_4c_Fat6
5252:             .Caption = "Fatura 6"
5253:             .Top = 134
5254:             .Left = 13
5255:             .FontName = "Tahoma"
5256:             .FontSize = 7
5257:             .BackStyle = 0
5258:             .ForeColor = RGB(90,90,90)
5259:             .AutoSize = .T.
5260:             .Visible = .T.
5261:         ENDWITH
5262:         loc_oAba.AddObject("txt_4c_Fat6NumL", "TextBox")
5263:         WITH loc_oAba.txt_4c_Fat6NumL
5264:             .ControlSource = "crSigCnFNf.lfat6num"
5265:             .Top = 132
5266:             .Left = 58
5267:             .Width = 41
5268:             .Height = 18
5269:             .FontName = "Tahoma"
5270:             .FontSize = 8
5271:             .SpecialEffect = 1
5272:             .Format = "K"
5273:             .InputMask = "999.99"
5274:             .Visible = .T.
5275:         ENDWITH
5276:         loc_oAba.AddObject("lbl_4c_F6NX", "Label")
5277:         WITH loc_oAba.lbl_4c_F6NX
5278:             .Caption = "x"
5279:             .Top = 134
5280:             .Left = 101
5281:             .FontName = "Tahoma"
5282:             .FontSize = 7
5283:             .BackStyle = 0
5284:             .ForeColor = RGB(90,90,90)
5285:             .AutoSize = .T.
5286:             .Visible = .T.
5287:         ENDWITH
5288:         loc_oAba.AddObject("txt_4c_Fat6NumC", "TextBox")
5289:         WITH loc_oAba.txt_4c_Fat6NumC
5290:             .ControlSource = "crSigCnFNf.cfat6num"
5291:             .Top = 132
5292:             .Left = 107
5293:             .Width = 41
5294:             .Height = 18
5295:             .FontName = "Tahoma"
5296:             .FontSize = 8
5297:             .SpecialEffect = 1
5298:             .Format = "K"
5299:             .InputMask = "999.99"
5300:             .Visible = .T.
5301:         ENDWITH
5302:         loc_oAba.AddObject("txt_4c_Fat6ValL", "TextBox")
5303:         WITH loc_oAba.txt_4c_Fat6ValL
5304:             .ControlSource = "crSigCnFNf.lfat6val"
5305:             .Top = 132
5306:             .Left = 165
5307:             .Width = 41
5308:             .Height = 18
5309:             .FontName = "Tahoma"
5310:             .FontSize = 8
5311:             .SpecialEffect = 1
5312:             .Format = "K"
5313:             .InputMask = "999.99"
5314:             .Visible = .T.
5315:         ENDWITH
5316:         loc_oAba.AddObject("lbl_4c_F6VX", "Label")
5317:         WITH loc_oAba.lbl_4c_F6VX
5318:             .Caption = "x"
5319:             .Top = 134
5320:             .Left = 208
5321:             .FontName = "Tahoma"
5322:             .FontSize = 7
5323:             .BackStyle = 0
5324:             .ForeColor = RGB(90,90,90)
5325:             .AutoSize = .T.
5326:             .Visible = .T.
5327:         ENDWITH
5328:         loc_oAba.AddObject("txt_4c_Fat6ValC", "TextBox")
5329:         WITH loc_oAba.txt_4c_Fat6ValC
5330:             .ControlSource = "crSigCnFNf.cfat6val"
5331:             .Top = 132
5332:             .Left = 214
5333:             .Width = 41
5334:             .Height = 18
5335:             .FontName = "Tahoma"
5336:             .FontSize = 8
5337:             .SpecialEffect = 1
5338:             .Format = "K"
5339:             .InputMask = "999.99"
5340:             .Visible = .T.
5341:         ENDWITH
5342:         loc_oAba.AddObject("txt_4c_Fat6VecL", "TextBox")
5343:         WITH loc_oAba.txt_4c_Fat6VecL
5344:             .ControlSource = "crSigCnFNf.lfat6vec"
5345:             .Top = 132
5346:             .Left = 273
5347:             .Width = 41
5348:             .Height = 18
5349:             .FontName = "Tahoma"
5350:             .FontSize = 8
5351:             .SpecialEffect = 1
5352:             .Format = "K"
5353:             .InputMask = "999.99"
5354:             .Visible = .T.
5355:         ENDWITH
5356:         loc_oAba.AddObject("lbl_4c_F6EX", "Label")
5357:         WITH loc_oAba.lbl_4c_F6EX
5358:             .Caption = "x"
5359:             .Top = 134
5360:             .Left = 316
5361:             .FontName = "Tahoma"
5362:             .FontSize = 7
5363:             .BackStyle = 0
5364:             .ForeColor = RGB(90,90,90)
5365:             .AutoSize = .T.
5366:             .Visible = .T.
5367:         ENDWITH
5368:         loc_oAba.AddObject("txt_4c_Fat6VecC", "TextBox")
5369:         WITH loc_oAba.txt_4c_Fat6VecC
5370:             .ControlSource = "crSigCnFNf.cfat6vec"
5371:             .Top = 132
5372:             .Left = 322
5373:             .Width = 41
5374:             .Height = 18
5375:             .FontName = "Tahoma"
5376:             .FontSize = 8
5377:             .SpecialEffect = 1
5378:             .Format = "K"
5379:             .InputMask = "999.99"
5380:             .Visible = .T.
5381:         ENDWITH
5382: 
5383:         *-- Fatura 7 (top=151/153)
5384:         loc_oAba.AddObject("lbl_4c_Fat7", "Label")
5385:         WITH loc_oAba.lbl_4c_Fat7
5386:             .Caption = "Fatura 7"
5387:             .Top = 153
5388:             .Left = 13
5389:             .FontName = "Tahoma"
5390:             .FontSize = 7
5391:             .BackStyle = 0
5392:             .ForeColor = RGB(90,90,90)
5393:             .AutoSize = .T.
5394:             .Visible = .T.
5395:         ENDWITH
5396:         loc_oAba.AddObject("txt_4c_Fat7NumL", "TextBox")
5397:         WITH loc_oAba.txt_4c_Fat7NumL
5398:             .ControlSource = "crSigCnFNf.lfat7num"
5399:             .Top = 151
5400:             .Left = 58
5401:             .Width = 41
5402:             .Height = 18
5403:             .FontName = "Tahoma"
5404:             .FontSize = 8
5405:             .SpecialEffect = 1
5406:             .Format = "K"
5407:             .InputMask = "999.99"
5408:             .Visible = .T.
5409:         ENDWITH
5410:         loc_oAba.AddObject("lbl_4c_F7NX", "Label")
5411:         WITH loc_oAba.lbl_4c_F7NX
5412:             .Caption = "x"
5413:             .Top = 153
5414:             .Left = 101
5415:             .FontName = "Tahoma"
5416:             .FontSize = 7
5417:             .BackStyle = 0
5418:             .ForeColor = RGB(90,90,90)
5419:             .AutoSize = .T.
5420:             .Visible = .T.
5421:         ENDWITH
5422:         loc_oAba.AddObject("txt_4c_Fat7NumC", "TextBox")
5423:         WITH loc_oAba.txt_4c_Fat7NumC
5424:             .ControlSource = "crSigCnFNf.cfat7num"
5425:             .Top = 151
5426:             .Left = 107
5427:             .Width = 41
5428:             .Height = 18
5429:             .FontName = "Tahoma"
5430:             .FontSize = 8
5431:             .SpecialEffect = 1
5432:             .Format = "K"
5433:             .InputMask = "999.99"
5434:             .Visible = .T.
5435:         ENDWITH
5436:         loc_oAba.AddObject("txt_4c_Fat7ValL", "TextBox")
5437:         WITH loc_oAba.txt_4c_Fat7ValL
5438:             .ControlSource = "crSigCnFNf.lfat7val"
5439:             .Top = 151
5440:             .Left = 165
5441:             .Width = 41
5442:             .Height = 18
5443:             .FontName = "Tahoma"
5444:             .FontSize = 8
5445:             .SpecialEffect = 1
5446:             .Format = "K"
5447:             .InputMask = "999.99"
5448:             .Visible = .T.
5449:         ENDWITH
5450:         loc_oAba.AddObject("lbl_4c_F7VX", "Label")
5451:         WITH loc_oAba.lbl_4c_F7VX
5452:             .Caption = "x"
5453:             .Top = 153
5454:             .Left = 208
5455:             .FontName = "Tahoma"
5456:             .FontSize = 7
5457:             .BackStyle = 0
5458:             .ForeColor = RGB(90,90,90)
5459:             .AutoSize = .T.
5460:             .Visible = .T.
5461:         ENDWITH
5462:         loc_oAba.AddObject("txt_4c_Fat7ValC", "TextBox")
5463:         WITH loc_oAba.txt_4c_Fat7ValC
5464:             .ControlSource = "crSigCnFNf.cfat7val"
5465:             .Top = 151
5466:             .Left = 214
5467:             .Width = 41
5468:             .Height = 18
5469:             .FontName = "Tahoma"
5470:             .FontSize = 8
5471:             .SpecialEffect = 1
5472:             .Format = "K"
5473:             .InputMask = "999.99"
5474:             .Visible = .T.
5475:         ENDWITH
5476:         loc_oAba.AddObject("txt_4c_Fat7VecL", "TextBox")
5477:         WITH loc_oAba.txt_4c_Fat7VecL
5478:             .ControlSource = "crSigCnFNf.lfat7vec"
5479:             .Top = 151
5480:             .Left = 273
5481:             .Width = 41
5482:             .Height = 18
5483:             .FontName = "Tahoma"
5484:             .FontSize = 8
5485:             .SpecialEffect = 1
5486:             .Format = "K"
5487:             .InputMask = "999.99"
5488:             .Visible = .T.
5489:         ENDWITH
5490:         loc_oAba.AddObject("lbl_4c_F7EX", "Label")
5491:         WITH loc_oAba.lbl_4c_F7EX
5492:             .Caption = "x"
5493:             .Top = 153
5494:             .Left = 316
5495:             .FontName = "Tahoma"
5496:             .FontSize = 7
5497:             .BackStyle = 0
5498:             .ForeColor = RGB(90,90,90)
5499:             .AutoSize = .T.
5500:             .Visible = .T.
5501:         ENDWITH
5502:         loc_oAba.AddObject("txt_4c_Fat7VecC", "TextBox")
5503:         WITH loc_oAba.txt_4c_Fat7VecC
5504:             .ControlSource = "crSigCnFNf.cfat7vec"
5505:             .Top = 151
5506:             .Left = 322
5507:             .Width = 41
5508:             .Height = 18
5509:             .FontName = "Tahoma"
5510:             .FontSize = 8
5511:             .SpecialEffect = 1
5512:             .Format = "K"
5513:             .InputMask = "999.99"
5514:             .Visible = .T.
5515:         ENDWITH
5516: 
5517:         *-- Fatura 8 (top=170/172)
5518:         loc_oAba.AddObject("lbl_4c_Fat8", "Label")
5519:         WITH loc_oAba.lbl_4c_Fat8
5520:             .Caption = "Fatura 8"
5521:             .Top = 172
5522:             .Left = 13
5523:             .FontName = "Tahoma"
5524:             .FontSize = 7
5525:             .BackStyle = 0
5526:             .ForeColor = RGB(90,90,90)
5527:             .AutoSize = .T.
5528:             .Visible = .T.
5529:         ENDWITH
5530:         loc_oAba.AddObject("txt_4c_Fat8NumL", "TextBox")
5531:         WITH loc_oAba.txt_4c_Fat8NumL
5532:             .ControlSource = "crSigCnFNf.lfat8num"
5533:             .Top = 170
5534:             .Left = 58
5535:             .Width = 41
5536:             .Height = 18
5537:             .FontName = "Tahoma"
5538:             .FontSize = 8
5539:             .SpecialEffect = 1
5540:             .Format = "K"
5541:             .InputMask = "999.99"
5542:             .Visible = .T.
5543:         ENDWITH
5544:         loc_oAba.AddObject("lbl_4c_F8NX", "Label")
5545:         WITH loc_oAba.lbl_4c_F8NX
5546:             .Caption = "x"
5547:             .Top = 172
5548:             .Left = 101
5549:             .FontName = "Tahoma"
5550:             .FontSize = 7
5551:             .BackStyle = 0
5552:             .ForeColor = RGB(90,90,90)
5553:             .AutoSize = .T.
5554:             .Visible = .T.
5555:         ENDWITH
5556:         loc_oAba.AddObject("txt_4c_Fat8NumC", "TextBox")
5557:         WITH loc_oAba.txt_4c_Fat8NumC
5558:             .ControlSource = "crSigCnFNf.cfat8num"
5559:             .Top = 170
5560:             .Left = 107
5561:             .Width = 41
5562:             .Height = 18
5563:             .FontName = "Tahoma"
5564:             .FontSize = 8
5565:             .SpecialEffect = 1
5566:             .Format = "K"
5567:             .InputMask = "999.99"
5568:             .Visible = .T.
5569:         ENDWITH
5570:         loc_oAba.AddObject("txt_4c_Fat8ValL", "TextBox")
5571:         WITH loc_oAba.txt_4c_Fat8ValL
5572:             .ControlSource = "crSigCnFNf.lfat8val"
5573:             .Top = 170
5574:             .Left = 165
5575:             .Width = 41
5576:             .Height = 18
5577:             .FontName = "Tahoma"
5578:             .FontSize = 8
5579:             .SpecialEffect = 1
5580:             .Format = "K"
5581:             .InputMask = "999.99"
5582:             .Visible = .T.
5583:         ENDWITH
5584:         loc_oAba.AddObject("lbl_4c_F8VX", "Label")
5585:         WITH loc_oAba.lbl_4c_F8VX
5586:             .Caption = "x"
5587:             .Top = 172
5588:             .Left = 208
5589:             .FontName = "Tahoma"
5590:             .FontSize = 7
5591:             .BackStyle = 0
5592:             .ForeColor = RGB(90,90,90)
5593:             .AutoSize = .T.
5594:             .Visible = .T.
5595:         ENDWITH
5596:         loc_oAba.AddObject("txt_4c_Fat8ValC", "TextBox")
5597:         WITH loc_oAba.txt_4c_Fat8ValC
5598:             .ControlSource = "crSigCnFNf.cfat8val"
5599:             .Top = 170
5600:             .Left = 214
5601:             .Width = 41
5602:             .Height = 18
5603:             .FontName = "Tahoma"
5604:             .FontSize = 8
5605:             .SpecialEffect = 1
5606:             .Format = "K"
5607:             .InputMask = "999.99"
5608:             .Visible = .T.
5609:         ENDWITH
5610:         loc_oAba.AddObject("txt_4c_Fat8VecL", "TextBox")
5611:         WITH loc_oAba.txt_4c_Fat8VecL
5612:             .ControlSource = "crSigCnFNf.lfat8vec"
5613:             .Top = 170
5614:             .Left = 273
5615:             .Width = 41
5616:             .Height = 18
5617:             .FontName = "Tahoma"
5618:             .FontSize = 8
5619:             .SpecialEffect = 1
5620:             .Format = "K"
5621:             .InputMask = "999.99"
5622:             .Visible = .T.
5623:         ENDWITH
5624:         loc_oAba.AddObject("lbl_4c_F8EX", "Label")
5625:         WITH loc_oAba.lbl_4c_F8EX
5626:             .Caption = "x"
5627:             .Top = 172
5628:             .Left = 316
5629:             .FontName = "Tahoma"
5630:             .FontSize = 7
5631:             .BackStyle = 0
5632:             .ForeColor = RGB(90,90,90)
5633:             .AutoSize = .T.
5634:             .Visible = .T.
5635:         ENDWITH
5636:         loc_oAba.AddObject("txt_4c_Fat8VecC", "TextBox")
5637:         WITH loc_oAba.txt_4c_Fat8VecC
5638:             .ControlSource = "crSigCnFNf.cfat8vec"
5639:             .Top = 170
5640:             .Left = 322
5641:             .Width = 41
5642:             .Height = 18
5643:             .FontName = "Tahoma"
5644:             .FontSize = 8
5645:             .SpecialEffect = 1
5646:             .Format = "K"
5647:             .InputMask = "999.99"
5648:             .Visible = .T.
5649:         ENDWITH
5650: 
5651:         *-- Fatura 9 (top=189/191)
5652:         loc_oAba.AddObject("lbl_4c_Fat9", "Label")
5653:         WITH loc_oAba.lbl_4c_Fat9
5654:             .Caption = "Fatura 9"
5655:             .Top = 191
5656:             .Left = 13
5657:             .FontName = "Tahoma"
5658:             .FontSize = 7
5659:             .BackStyle = 0
5660:             .ForeColor = RGB(90,90,90)
5661:             .AutoSize = .T.
5662:             .Visible = .T.
5663:         ENDWITH
5664:         loc_oAba.AddObject("txt_4c_Fat9NumL", "TextBox")
5665:         WITH loc_oAba.txt_4c_Fat9NumL
5666:             .ControlSource = "crSigCnFNf.lfat9num"
5667:             .Top = 189
5668:             .Left = 58
5669:             .Width = 41
5670:             .Height = 18
5671:             .FontName = "Tahoma"
5672:             .FontSize = 8
5673:             .SpecialEffect = 1
5674:             .Format = "K"
5675:             .InputMask = "999.99"
5676:             .Visible = .T.
5677:         ENDWITH
5678:         loc_oAba.AddObject("lbl_4c_F9NX", "Label")
5679:         WITH loc_oAba.lbl_4c_F9NX
5680:             .Caption = "x"
5681:             .Top = 191
5682:             .Left = 101
5683:             .FontName = "Tahoma"
5684:             .FontSize = 7
5685:             .BackStyle = 0
5686:             .ForeColor = RGB(90,90,90)
5687:             .AutoSize = .T.
5688:             .Visible = .T.
5689:         ENDWITH
5690:         loc_oAba.AddObject("txt_4c_Fat9NumC", "TextBox")
5691:         WITH loc_oAba.txt_4c_Fat9NumC
5692:             .ControlSource = "crSigCnFNf.cfat9num"
5693:             .Top = 189
5694:             .Left = 107
5695:             .Width = 41
5696:             .Height = 18
5697:             .FontName = "Tahoma"
5698:             .FontSize = 8
5699:             .SpecialEffect = 1
5700:             .Format = "K"
5701:             .InputMask = "999.99"
5702:             .Visible = .T.
5703:         ENDWITH
5704:         loc_oAba.AddObject("txt_4c_Fat9ValL", "TextBox")
5705:         WITH loc_oAba.txt_4c_Fat9ValL
5706:             .ControlSource = "crSigCnFNf.lfat9val"
5707:             .Top = 189
5708:             .Left = 165
5709:             .Width = 41
5710:             .Height = 18
5711:             .FontName = "Tahoma"
5712:             .FontSize = 8
5713:             .SpecialEffect = 1
5714:             .Format = "K"
5715:             .InputMask = "999.99"
5716:             .Visible = .T.
5717:         ENDWITH
5718:         loc_oAba.AddObject("lbl_4c_F9VX", "Label")
5719:         WITH loc_oAba.lbl_4c_F9VX
5720:             .Caption = "x"
5721:             .Top = 191
5722:             .Left = 208
5723:             .FontName = "Tahoma"
5724:             .FontSize = 7
5725:             .BackStyle = 0
5726:             .ForeColor = RGB(90,90,90)
5727:             .AutoSize = .T.
5728:             .Visible = .T.
5729:         ENDWITH
5730:         loc_oAba.AddObject("txt_4c_Fat9ValC", "TextBox")
5731:         WITH loc_oAba.txt_4c_Fat9ValC
5732:             .ControlSource = "crSigCnFNf.cfat9val"
5733:             .Top = 189
5734:             .Left = 214
5735:             .Width = 41
5736:             .Height = 18
5737:             .FontName = "Tahoma"
5738:             .FontSize = 8
5739:             .SpecialEffect = 1
5740:             .Format = "K"
5741:             .InputMask = "999.99"
5742:             .Visible = .T.
5743:         ENDWITH
5744:         loc_oAba.AddObject("txt_4c_Fat9VecL", "TextBox")
5745:         WITH loc_oAba.txt_4c_Fat9VecL
5746:             .ControlSource = "crSigCnFNf.lfat9vec"
5747:             .Top = 189
5748:             .Left = 273
5749:             .Width = 41
5750:             .Height = 18
5751:             .FontName = "Tahoma"
5752:             .FontSize = 8
5753:             .SpecialEffect = 1
5754:             .Format = "K"
5755:             .InputMask = "999.99"
5756:             .Visible = .T.
5757:         ENDWITH
5758:         loc_oAba.AddObject("lbl_4c_F9EX", "Label")
5759:         WITH loc_oAba.lbl_4c_F9EX
5760:             .Caption = "x"
5761:             .Top = 191
5762:             .Left = 316
5763:             .FontName = "Tahoma"
5764:             .FontSize = 7
5765:             .BackStyle = 0
5766:             .ForeColor = RGB(90,90,90)
5767:             .AutoSize = .T.
5768:             .Visible = .T.
5769:         ENDWITH
5770:         loc_oAba.AddObject("txt_4c_Fat9VecC", "TextBox")
5771:         WITH loc_oAba.txt_4c_Fat9VecC
5772:             .ControlSource = "crSigCnFNf.cfat9vec"
5773:             .Top = 189
5774:             .Left = 322
5775:             .Width = 41
5776:             .Height = 18
5777:             .FontName = "Tahoma"
5778:             .FontSize = 8
5779:             .SpecialEffect = 1
5780:             .Format = "K"
5781:             .InputMask = "999.99"
5782:             .Visible = .T.
5783:         ENDWITH
5784: 
5785:         *-- Fatura 10 (top=208/210)
5786:         loc_oAba.AddObject("lbl_4c_Fat10", "Label")
5787:         WITH loc_oAba.lbl_4c_Fat10
5788:             .Caption = "Fatura 10"
5789:             .Top = 210
5790:             .Left = 8
5791:             .FontName = "Tahoma"
5792:             .FontSize = 7
5793:             .BackStyle = 0
5794:             .ForeColor = RGB(90,90,90)
5795:             .AutoSize = .T.
5796:             .Visible = .T.
5797:         ENDWITH
5798:         loc_oAba.AddObject("txt_4c_Fat10NumL", "TextBox")
5799:         WITH loc_oAba.txt_4c_Fat10NumL
5800:             .ControlSource = "crSigCnFNf.lfat10num"
5801:             .Top = 208
5802:             .Left = 58
5803:             .Width = 41
5804:             .Height = 18
5805:             .FontName = "Tahoma"
5806:             .FontSize = 8
5807:             .SpecialEffect = 1
5808:             .Format = "K"
5809:             .InputMask = "999.99"
5810:             .Visible = .T.
5811:         ENDWITH
5812:         loc_oAba.AddObject("lbl_4c_F10NX", "Label")
5813:         WITH loc_oAba.lbl_4c_F10NX
5814:             .Caption = "x"
5815:             .Top = 210
5816:             .Left = 101
5817:             .FontName = "Tahoma"
5818:             .FontSize = 7
5819:             .BackStyle = 0
5820:             .ForeColor = RGB(90,90,90)
5821:             .AutoSize = .T.
5822:             .Visible = .T.
5823:         ENDWITH
5824:         loc_oAba.AddObject("txt_4c_Fat10NumC", "TextBox")
5825:         WITH loc_oAba.txt_4c_Fat10NumC
5826:             .ControlSource = "crSigCnFNf.cfat10num"
5827:             .Top = 208
5828:             .Left = 107
5829:             .Width = 41
5830:             .Height = 18
5831:             .FontName = "Tahoma"
5832:             .FontSize = 8
5833:             .SpecialEffect = 1
5834:             .Format = "K"
5835:             .InputMask = "999.99"
5836:             .Visible = .T.
5837:         ENDWITH
5838:         loc_oAba.AddObject("txt_4c_Fat10ValL", "TextBox")
5839:         WITH loc_oAba.txt_4c_Fat10ValL
5840:             .ControlSource = "crSigCnFNf.lfat10val"
5841:             .Top = 208
5842:             .Left = 165
5843:             .Width = 41
5844:             .Height = 18
5845:             .FontName = "Tahoma"
5846:             .FontSize = 8
5847:             .SpecialEffect = 1
5848:             .Format = "K"
5849:             .InputMask = "999.99"
5850:             .Visible = .T.
5851:         ENDWITH
5852:         loc_oAba.AddObject("lbl_4c_F10VX", "Label")
5853:         WITH loc_oAba.lbl_4c_F10VX
5854:             .Caption = "x"
5855:             .Top = 210
5856:             .Left = 208
5857:             .FontName = "Tahoma"
5858:             .FontSize = 7
5859:             .BackStyle = 0
5860:             .ForeColor = RGB(90,90,90)
5861:             .AutoSize = .T.
5862:             .Visible = .T.
5863:         ENDWITH
5864:         loc_oAba.AddObject("txt_4c_Fat10ValC", "TextBox")
5865:         WITH loc_oAba.txt_4c_Fat10ValC
5866:             .ControlSource = "crSigCnFNf.cfat10val"
5867:             .Top = 208
5868:             .Left = 214
5869:             .Width = 41
5870:             .Height = 18
5871:             .FontName = "Tahoma"
5872:             .FontSize = 8
5873:             .SpecialEffect = 1
5874:             .Format = "K"
5875:             .InputMask = "999.99"
5876:             .Visible = .T.
5877:         ENDWITH
5878:         loc_oAba.AddObject("txt_4c_Fat10VecL", "TextBox")
5879:         WITH loc_oAba.txt_4c_Fat10VecL
5880:             .ControlSource = "crSigCnFNf.lfat10vec"
5881:             .Top = 208
5882:             .Left = 273
5883:             .Width = 41
5884:             .Height = 18
5885:             .FontName = "Tahoma"
5886:             .FontSize = 8
5887:             .SpecialEffect = 1
5888:             .Format = "K"
5889:             .InputMask = "999.99"
5890:             .Visible = .T.
5891:         ENDWITH
5892:         loc_oAba.AddObject("lbl_4c_F10EX", "Label")
5893:         WITH loc_oAba.lbl_4c_F10EX
5894:             .Caption = "x"
5895:             .Top = 210
5896:             .Left = 316
5897:             .FontName = "Tahoma"
5898:             .FontSize = 7
5899:             .BackStyle = 0
5900:             .ForeColor = RGB(90,90,90)
5901:             .AutoSize = .T.
5902:             .Visible = .T.
5903:         ENDWITH
5904:         loc_oAba.AddObject("txt_4c_Fat10VecC", "TextBox")
5905:         WITH loc_oAba.txt_4c_Fat10VecC
5906:             .ControlSource = "crSigCnFNf.cfat10vec"
5907:             .Top = 208
5908:             .Left = 322
5909:             .Width = 41
5910:             .Height = 18
5911:             .FontName = "Tahoma"
5912:             .FontSize = 8
5913:             .SpecialEffect = 1
5914:             .Format = "K"
5915:             .InputMask = "999.99"
5916:             .Visible = .T.
5917:         ENDWITH
5918: 
5919:         *-- Endereco de Cobranca (right side, top=25 label at left=395)
5920:         loc_oAba.AddObject("lbl_4c_LblEndCob", "Label")
5921:         WITH loc_oAba.lbl_4c_LblEndCob
5922:             .Caption   = "Endere" + CHR(231) + "o Cobran" + CHR(231) + "a"
5923:             .Top       = 25
5924:             .Left      = 395
5925:             .FontName  = "Tahoma"
5926:             .FontSize  = 7
5927:             .BackStyle = 0
5928:             .ForeColor = RGB(90, 90, 90)
5929:             .AutoSize  = .T.
5930:             .Visible   = .T.
5931:         ENDWITH
5932: 
5933:         loc_oAba.AddObject("txt_4c_CobEnderL", "TextBox")
5934:         WITH loc_oAba.txt_4c_CobEnderL
5935:             .ControlSource = "crSigCnFNf.lendcob"
5936:             .Top = 37
5937:             .Left = 395
5938:             .Width = 41
5939:             .Height = 18
5940:             .FontName = "Tahoma"
5941:             .FontSize = 8
5942:             .SpecialEffect = 1
5943:             .Format = "K"
5944:             .InputMask = "999.99"
5945:             .Visible = .T.
5946:         ENDWITH
5947: 
5948:         loc_oAba.AddObject("lbl_4c_CobEX1", "Label")
5949:         WITH loc_oAba.lbl_4c_CobEX1
5950:             .Caption = "x"
5951:             .Top = 39
5952:             .Left = 438
5953:             .FontName = "Tahoma"
5954:             .FontSize = 7
5955:             .BackStyle = 0
5956:             .ForeColor = RGB(90,90,90)
5957:             .AutoSize = .T.
5958:             .Visible = .T.
5959:         ENDWITH
5960: 
5961:         loc_oAba.AddObject("txt_4c_CobEnderC", "TextBox")
5962:         WITH loc_oAba.txt_4c_CobEnderC
5963:             .ControlSource = "crSigCnFNf.cendcob"
5964:             .Top = 37
5965:             .Left = 444
5966:             .Width = 41
5967:             .Height = 18
5968:             .FontName = "Tahoma"
5969:             .FontSize = 8
5970:             .SpecialEffect = 1
5971:             .Format = "K"
5972:             .InputMask = "999.99"
5973:             .Visible = .T.
5974:         ENDWITH
5975: 
5976:         *-- Cobranca - Bairro (top=25, left=495)
5977:         loc_oAba.AddObject("lbl_4c_LblCobBai", "Label")
5978:         WITH loc_oAba.lbl_4c_LblCobBai
5979:             .Caption = "Bairro"
5980:             .Top = 25
5981:             .Left = 495
5982:             .FontName = "Tahoma"
5983:             .FontSize = 7
5984:             .BackStyle = 0
5985:             .ForeColor = RGB(90,90,90)
5986:             .AutoSize = .T.
5987:             .Visible = .T.
5988:         ENDWITH
5989: 
5990:         loc_oAba.AddObject("txt_4c_CobBairL", "TextBox")
5991:         WITH loc_oAba.txt_4c_CobBairL
5992:             .ControlSource = "crSigCnFNf.lbaicob"
5993:             .Top = 37
5994:             .Left = 495
5995:             .Width = 41
5996:             .Height = 18
5997:             .FontName = "Tahoma"
5998:             .FontSize = 8
5999:             .SpecialEffect = 1
6000:             .Format = "K"
6001:             .InputMask = "999.99"
6002:             .Visible = .T.
6003:         ENDWITH
6004: 
6005:         loc_oAba.AddObject("lbl_4c_CobBX", "Label")
6006:         WITH loc_oAba.lbl_4c_CobBX
6007:             .Caption = "x"
6008:             .Top = 39
6009:             .Left = 538
6010:             .FontName = "Tahoma"
6011:             .FontSize = 7
6012:             .BackStyle = 0
6013:             .ForeColor = RGB(90,90,90)
6014:             .AutoSize = .T.
6015:             .Visible = .T.
6016:         ENDWITH
6017: 
6018:         loc_oAba.AddObject("txt_4c_CobBairC", "TextBox")
6019:         WITH loc_oAba.txt_4c_CobBairC
6020:             .ControlSource = "crSigCnFNf.cbaicob"
6021:             .Top = 37
6022:             .Left = 544
6023:             .Width = 41
6024:             .Height = 18
6025:             .FontName = "Tahoma"
6026:             .FontSize = 8
6027:             .SpecialEffect = 1
6028:             .Format = "K"
6029:             .InputMask = "999.99"
6030:             .Visible = .T.
6031:         ENDWITH
6032: 
6033:         *-- Cobranca - Municipio (top=61, left=394)
6034:         loc_oAba.AddObject("lbl_4c_LblCobMun", "Label")
6035:         WITH loc_oAba.lbl_4c_LblCobMun
6036:             .Caption = "Munic" + CHR(237) + "pio"
6037:             .Top = 61
6038:             .Left = 394
6039:             .FontName = "Tahoma"
6040:             .FontSize = 7
6041:             .BackStyle = 0
6042:             .ForeColor = RGB(90,90,90)
6043:             .AutoSize = .T.
6044:             .Visible = .T.
6045:         ENDWITH
6046: 
6047:         loc_oAba.AddObject("txt_4c_CobMuniL", "TextBox")
6048:         WITH loc_oAba.txt_4c_CobMuniL
6049:             .ControlSource = "crSigCnFNf.lmuncob"
6050:             .Top = 73
6051:             .Left = 394
6052:             .Width = 41
6053:             .Height = 18
6054:             .FontName = "Tahoma"
6055:             .FontSize = 8
6056:             .SpecialEffect = 1
6057:             .Format = "K"
6058:             .InputMask = "999.99"
6059:             .Visible = .T.
6060:         ENDWITH
6061: 
6062:         loc_oAba.AddObject("lbl_4c_CobMX", "Label")
6063:         WITH loc_oAba.lbl_4c_CobMX
6064:             .Caption = "x"
6065:             .Top = 75
6066:             .Left = 437
6067:             .FontName = "Tahoma"
6068:             .FontSize = 7
6069:             .BackStyle = 0
6070:             .ForeColor = RGB(90,90,90)
6071:             .AutoSize = .T.
6072:             .Visible = .T.
6073:         ENDWITH
6074: 
6075:         loc_oAba.AddObject("txt_4c_CobMuniC", "TextBox")
6076:         WITH loc_oAba.txt_4c_CobMuniC
6077:             .ControlSource = "crSigCnFNf.cmuncob"
6078:             .Top = 73
6079:             .Left = 443
6080:             .Width = 41
6081:             .Height = 18
6082:             .FontName = "Tahoma"
6083:             .FontSize = 8
6084:             .SpecialEffect = 1
6085:             .Format = "K"
6086:             .InputMask = "999.99"
6087:             .Visible = .T.
6088:         ENDWITH
6089: 
6090:         *-- Cobranca - Estado (top=61, left=495)
6091:         loc_oAba.AddObject("lbl_4c_LblCobEst", "Label")
6092:         WITH loc_oAba.lbl_4c_LblCobEst
6093:             .Caption = "Estado"
6094:             .Top = 61
6095:             .Left = 495
6096:             .FontName = "Tahoma"
6097:             .FontSize = 7
6098:             .BackStyle = 0
6099:             .ForeColor = RGB(90,90,90)
6100:             .AutoSize = .T.
6101:             .Visible = .T.
6102:         ENDWITH
6103: 
6104:         loc_oAba.AddObject("txt_4c_CobEstL", "TextBox")
6105:         WITH loc_oAba.txt_4c_CobEstL
6106:             .ControlSource = "crSigCnFNf.lestcob"
6107:             .Top = 73
6108:             .Left = 495
6109:             .Width = 41
6110:             .Height = 18
6111:             .FontName = "Tahoma"
6112:             .FontSize = 8
6113:             .SpecialEffect = 1
6114:             .Format = "K"
6115:             .InputMask = "999.99"
6116:             .Visible = .T.
6117:         ENDWITH
6118: 
6119:         loc_oAba.AddObject("lbl_4c_CobEstX", "Label")
6120:         WITH loc_oAba.lbl_4c_CobEstX
6121:             .Caption = "x"
6122:             .Top = 75
6123:             .Left = 538
6124:             .FontName = "Tahoma"
6125:             .FontSize = 7
6126:             .BackStyle = 0
6127:             .ForeColor = RGB(90,90,90)
6128:             .AutoSize = .T.
6129:             .Visible = .T.
6130:         ENDWITH
6131: 
6132:         loc_oAba.AddObject("txt_4c_CobEstC", "TextBox")
6133:         WITH loc_oAba.txt_4c_CobEstC
6134:             .ControlSource = "crSigCnFNf.cestcob"
6135:             .Top = 73
6136:             .Left = 544
6137:             .Width = 41
6138:             .Height = 18
6139:             .FontName = "Tahoma"
6140:             .FontSize = 8
6141:             .SpecialEffect = 1
6142:             .Format = "K"
6143:             .InputMask = "999.99"
6144:             .Visible = .T.
6145:         ENDWITH
6146: 
6147:         *-- Cobranca - CEP (top=97, left=394)
6148:         loc_oAba.AddObject("lbl_4c_LblCobCep", "Label")
6149:         WITH loc_oAba.lbl_4c_LblCobCep
6150:             .Caption = "CEP"
6151:             .Top = 97
6152:             .Left = 394
6153:             .FontName = "Tahoma"
6154:             .FontSize = 7
6155:             .BackStyle = 0
6156:             .ForeColor = RGB(90,90,90)
6157:             .AutoSize = .T.
6158:             .Visible = .T.
6159:         ENDWITH
6160: 
6161:         loc_oAba.AddObject("txt_4c_CobCepL", "TextBox")
6162:         WITH loc_oAba.txt_4c_CobCepL
6163:             .ControlSource = "crSigCnFNf.lcepcob"
6164:             .Top = 109
6165:             .Left = 394
6166:             .Width = 41
6167:             .Height = 18
6168:             .FontName = "Tahoma"
6169:             .FontSize = 8
6170:             .SpecialEffect = 1
6171:             .Format = "K"
6172:             .InputMask = "999.99"
6173:             .Visible = .T.
6174:         ENDWITH
6175: 
6176:         loc_oAba.AddObject("lbl_4c_CobCepX", "Label")
6177:         WITH loc_oAba.lbl_4c_CobCepX
6178:             .Caption = "x"
6179:             .Top = 111
6180:             .Left = 437
6181:             .FontName = "Tahoma"
6182:             .FontSize = 7
6183:             .BackStyle = 0
6184:             .ForeColor = RGB(90,90,90)
6185:             .AutoSize = .T.
6186:             .Visible = .T.
6187:         ENDWITH
6188: 
6189:         loc_oAba.AddObject("txt_4c_CobCepC", "TextBox")
6190:         WITH loc_oAba.txt_4c_CobCepC
6191:             .ControlSource = "crSigCnFNf.ccepcob"
6192:             .Top = 109
6193:             .Left = 443
6194:             .Width = 41
6195:             .Height = 18
6196:             .FontName = "Tahoma"
6197:             .FontSize = 8
6198:             .SpecialEffect = 1

*-- Linhas 6208 a 6755:
6208:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page4
6209: 
6210:         *-- Linha inicial dos produtos (top=28)
6211:         loc_oAba.AddObject("lbl_4c_LblLinIni", "Label")
6212:         WITH loc_oAba.lbl_4c_LblLinIni
6213:             .Caption   = "Linha Inicial dos Produtos"
6214:             .Top       = 28
6215:             .Left      = 18
6216:             .FontName  = "Tahoma"
6217:             .FontSize  = 7
6218:             .BackStyle = 0
6219:             .ForeColor = RGB(90, 90, 90)
6220:             .AutoSize  = .T.
6221:             .Visible   = .T.
6222:         ENDWITH
6223: 
6224:         loc_oAba.AddObject("txt_4c_LinIni", "TextBox")
6225:         WITH loc_oAba.txt_4c_LinIni
6226:             .ControlSource = "crSigCnFNf.linprod"
6227:             .Top           = 24
6228:             .Left          = 153
6229:             .Width         = 41
6230:             .Height        = 18
6231:             .FontName      = "Tahoma"
6232:             .FontSize      = 8
6233:             .SpecialEffect = 1
6234:             .Format        = "K"
6235:             .InputMask     = "999.99"
6236:             .Visible       = .T.
6237:         ENDWITH
6238: 
6239:         *-- Codigo (top=50)
6240:         loc_oAba.AddObject("lbl_4c_LblCodigo", "Label")
6241:         WITH loc_oAba.lbl_4c_LblCodigo
6242:             .Caption   = "C" + CHR(243) + "digo"
6243:             .Top       = 50
6244:             .Left      = 34
6245:             .FontName  = "Tahoma"
6246:             .FontSize  = 7
6247:             .BackStyle = 0
6248:             .ForeColor = RGB(90, 90, 90)
6249:             .AutoSize  = .T.
6250:             .Visible   = .T.
6251:         ENDWITH
6252: 
6253:         loc_oAba.AddObject("txt_4c_ProdCodL", "TextBox")
6254:         WITH loc_oAba.txt_4c_ProdCodL
6255:             .ControlSource = "crSigCnFNf.lcodpro"
6256:             .Top           = 62
6257:             .Left          = 32
6258:             .Width         = 38
6259:             .Height        = 18
6260:             .FontName      = "Tahoma"
6261:             .FontSize      = 8
6262:             .SpecialEffect = 1
6263:             .Format        = "K"
6264:             .InputMask     = "999.99"
6265:             .Visible       = .T.
6266:         ENDWITH
6267: 
6268:         *-- Descricao (top=50)
6269:         loc_oAba.AddObject("lbl_4c_LblDescr", "Label")
6270:         WITH loc_oAba.lbl_4c_LblDescr
6271:             .Caption   = "Descr"
6272:             .Top       = 50
6273:             .Left      = 77
6274:             .FontName  = "Tahoma"
6275:             .FontSize  = 7
6276:             .BackStyle = 0
6277:             .ForeColor = RGB(90, 90, 90)
6278:             .AutoSize  = .T.
6279:             .Visible   = .T.
6280:         ENDWITH
6281: 
6282:         loc_oAba.AddObject("txt_4c_ProdDescL", "TextBox")
6283:         WITH loc_oAba.txt_4c_ProdDescL
6284:             .ControlSource = "crSigCnFNf.ldescpro"
6285:             .Top           = 62
6286:             .Left          = 75
6287:             .Width         = 38
6288:             .Height        = 18
6289:             .FontName      = "Tahoma"
6290:             .FontSize      = 8
6291:             .SpecialEffect = 1
6292:             .Format        = "K"
6293:             .InputMask     = "999.99"
6294:             .Visible       = .T.
6295:         ENDWITH
6296: 
6297:         *-- Peso (top=50)
6298:         loc_oAba.AddObject("lbl_4c_LblPeso", "Label")
6299:         WITH loc_oAba.lbl_4c_LblPeso
6300:             .Caption   = "Peso"
6301:             .Top       = 50
6302:             .Left      = 121
6303:             .FontName  = "Tahoma"
6304:             .FontSize  = 7
6305:             .BackStyle = 0
6306:             .ForeColor = RGB(90, 90, 90)
6307:             .AutoSize  = .T.
6308:             .Visible   = .T.
6309:         ENDWITH
6310: 
6311:         loc_oAba.AddObject("txt_4c_ProdPesoL", "TextBox")
6312:         WITH loc_oAba.txt_4c_ProdPesoL
6313:             .ControlSource = "crSigCnFNf.cpespro"
6314:             .Top           = 62
6315:             .Left          = 118
6316:             .Width         = 38
6317:             .Height        = 18
6318:             .FontName      = "Tahoma"
6319:             .FontSize      = 8
6320:             .SpecialEffect = 1
6321:             .Format        = "K"
6322:             .InputMask     = "999.99"
6323:             .Visible       = .T.
6324:         ENDWITH
6325: 
6326:         *-- Tipo (top=50)
6327:         loc_oAba.AddObject("lbl_4c_LblTipo", "Label")
6328:         WITH loc_oAba.lbl_4c_LblTipo
6329:             .Caption   = "Tipo"
6330:             .Top       = 50
6331:             .Left      = 164
6332:             .FontName  = "Tahoma"
6333:             .FontSize  = 7
6334:             .BackStyle = 0
6335:             .ForeColor = RGB(90, 90, 90)
6336:             .AutoSize  = .T.
6337:             .Visible   = .T.
6338:         ENDWITH
6339: 
6340:         loc_oAba.AddObject("txt_4c_ProdTipoL", "TextBox")
6341:         WITH loc_oAba.txt_4c_ProdTipoL
6342:             .ControlSource = "crSigCnFNf.ltprod"
6343:             .Top           = 62
6344:             .Left          = 161
6345:             .Width         = 38
6346:             .Height        = 18
6347:             .FontName      = "Tahoma"
6348:             .FontSize      = 8
6349:             .SpecialEffect = 1
6350:             .Format        = "K"
6351:             .InputMask     = "999.99"
6352:             .Visible       = .T.
6353:         ENDWITH
6354: 
6355:         *-- Metal (top=50)
6356:         loc_oAba.AddObject("lbl_4c_LblMetal", "Label")
6357:         WITH loc_oAba.lbl_4c_LblMetal
6358:             .Caption   = "Metal"
6359:             .Top       = 50
6360:             .Left      = 206
6361:             .FontName  = "Tahoma"
6362:             .FontSize  = 7
6363:             .BackStyle = 0
6364:             .ForeColor = RGB(90, 90, 90)
6365:             .AutoSize  = .T.
6366:             .Visible   = .T.
6367:         ENDWITH
6368: 
6369:         loc_oAba.AddObject("txt_4c_ProdMetalL", "TextBox")
6370:         WITH loc_oAba.txt_4c_ProdMetalL
6371:             .ControlSource = "crSigCnFNf.cmarca"
6372:             .Top           = 62
6373:             .Left          = 204
6374:             .Width         = 38
6375:             .Height        = 18
6376:             .FontName      = "Tahoma"
6377:             .FontSize      = 8
6378:             .SpecialEffect = 1
6379:             .Format        = "K"
6380:             .InputMask     = "999.99"
6381:             .Visible       = .T.
6382:         ENDWITH
6383: 
6384:         *-- Teor (top=50)
6385:         loc_oAba.AddObject("lbl_4c_LblTeor", "Label")
6386:         WITH loc_oAba.lbl_4c_LblTeor
6387:             .Caption   = "Teor"
6388:             .Top       = 50
6389:             .Left      = 248
6390:             .FontName  = "Tahoma"
6391:             .FontSize  = 7
6392:             .BackStyle = 0
6393:             .ForeColor = RGB(90, 90, 90)
6394:             .AutoSize  = .T.
6395:             .Visible   = .T.
6396:         ENDWITH
6397: 
6398:         loc_oAba.AddObject("txt_4c_ProdTeorL", "TextBox")
6399:         WITH loc_oAba.txt_4c_ProdTeorL
6400:             .ControlSource = "crSigCnFNf.cticm"
6401:             .Top           = 62
6402:             .Left          = 247
6403:             .Width         = 41
6404:             .Height        = 18
6405:             .FontName      = "Tahoma"
6406:             .FontSize      = 8
6407:             .SpecialEffect = 1
6408:             .Format        = "K"
6409:             .InputMask     = "999.99"
6410:             .Visible       = .T.
6411:         ENDWITH
6412: 
6413:         *-- Cl.Fiscal (top=50)
6414:         loc_oAba.AddObject("lbl_4c_LblClFis", "Label")
6415:         WITH loc_oAba.lbl_4c_LblClFis
6416:             .Caption   = "Cl. Fiscal"
6417:             .Top       = 50
6418:             .Left      = 287
6419:             .FontName  = "Tahoma"
6420:             .FontSize  = 7
6421:             .BackStyle = 0
6422:             .ForeColor = RGB(90, 90, 90)
6423:             .AutoSize  = .T.
6424:             .Visible   = .T.
6425:         ENDWITH
6426: 
6427:         loc_oAba.AddObject("txt_4c_ProdClFisL", "TextBox")
6428:         WITH loc_oAba.txt_4c_ProdClFisL
6429:             .ControlSource = "crSigCnFNf.lcclas1"
6430:             .Top           = 62
6431:             .Left          = 293
6432:             .Width         = 38
6433:             .Height        = 18
6434:             .FontName      = "Tahoma"
6435:             .FontSize      = 8
6436:             .SpecialEffect = 1
6437:             .Format        = "K"
6438:             .InputMask     = "999.99"
6439:             .Visible       = .T.
6440:         ENDWITH
6441: 
6442:         *-- Sit.Trib (top=50)
6443:         loc_oAba.AddObject("lbl_4c_LblSitTrib", "Label")
6444:         WITH loc_oAba.lbl_4c_LblSitTrib
6445:             .Caption   = "Sit. Trib."
6446:             .Top       = 50
6447:             .Left      = 335
6448:             .FontName  = "Tahoma"
6449:             .FontSize  = 7
6450:             .BackStyle = 0
6451:             .ForeColor = RGB(90, 90, 90)
6452:             .AutoSize  = .T.
6453:             .Visible   = .T.
6454:         ENDWITH
6455: 
6456:         loc_oAba.AddObject("txt_4c_ProdSitTribL", "TextBox")
6457:         WITH loc_oAba.txt_4c_ProdSitTribL
6458:             .ControlSource = "crSigCnFNf.lstrib"
6459:             .Top           = 62
6460:             .Left          = 336
6461:             .Width         = 38
6462:             .Height        = 18
6463:             .FontName      = "Tahoma"
6464:             .FontSize      = 8
6465:             .SpecialEffect = 1
6466:             .Format        = "K"
6467:             .InputMask     = "999.99"
6468:             .Visible       = .T.
6469:         ENDWITH
6470: 
6471:         *-- Origem (top=50)
6472:         loc_oAba.AddObject("lbl_4c_LblOrigem", "Label")
6473:         WITH loc_oAba.lbl_4c_LblOrigem
6474:             .Caption   = "Origem"
6475:             .Top       = 50
6476:             .Left      = 379
6477:             .FontName  = "Tahoma"
6478:             .FontSize  = 7
6479:             .BackStyle = 0
6480:             .ForeColor = RGB(90, 90, 90)
6481:             .AutoSize  = .T.
6482:             .Visible   = .T.
6483:         ENDWITH
6484: 
6485:         loc_oAba.AddObject("txt_4c_ProdOrigemL", "TextBox")
6486:         WITH loc_oAba.txt_4c_ProdOrigemL
6487:             .ControlSource = "crSigCnFNf.corigem"
6488:             .Top           = 62
6489:             .Left          = 379
6490:             .Width         = 38
6491:             .Height        = 18
6492:             .FontName      = "Tahoma"
6493:             .FontSize      = 8
6494:             .SpecialEffect = 1
6495:             .Format        = "K"
6496:             .InputMask     = "999.99"
6497:             .Visible       = .T.
6498:         ENDWITH
6499: 
6500:         *-- Unidade (top=50)
6501:         loc_oAba.AddObject("lbl_4c_LblUnid", "Label")
6502:         WITH loc_oAba.lbl_4c_LblUnid
6503:             .Caption   = "Unidade"
6504:             .Top       = 50
6505:             .Left      = 422
6506:             .FontName  = "Tahoma"
6507:             .FontSize  = 7
6508:             .BackStyle = 0
6509:             .ForeColor = RGB(90, 90, 90)
6510:             .AutoSize  = .T.
6511:             .Visible   = .T.
6512:         ENDWITH
6513: 
6514:         loc_oAba.AddObject("txt_4c_ProdUnidL", "TextBox")
6515:         WITH loc_oAba.txt_4c_ProdUnidL
6516:             .ControlSource = "crSigCnFNf.lunid"
6517:             .Top           = 62
6518:             .Left          = 422
6519:             .Width         = 38
6520:             .Height        = 18
6521:             .FontName      = "Tahoma"
6522:             .FontSize      = 8
6523:             .SpecialEffect = 1
6524:             .Format        = "K"
6525:             .InputMask     = "999.99"
6526:             .Visible       = .T.
6527:         ENDWITH
6528: 
6529:         *-- Quant (top=50)
6530:         loc_oAba.AddObject("lbl_4c_LblQtde", "Label")
6531:         WITH loc_oAba.lbl_4c_LblQtde
6532:             .Caption   = "Quant"
6533:             .Top       = 50
6534:             .Left      = 470
6535:             .FontName  = "Tahoma"
6536:             .FontSize  = 7
6537:             .BackStyle = 0
6538:             .ForeColor = RGB(90, 90, 90)
6539:             .AutoSize  = .T.
6540:             .Visible   = .T.
6541:         ENDWITH
6542: 
6543:         loc_oAba.AddObject("txt_4c_ProdQtdeL", "TextBox")
6544:         WITH loc_oAba.txt_4c_ProdQtdeL
6545:             .ControlSource = "crSigCnFNf.lqtde"
6546:             .Top           = 62
6547:             .Left          = 466
6548:             .Width         = 38
6549:             .Height        = 18
6550:             .FontName      = "Tahoma"
6551:             .FontSize      = 8
6552:             .SpecialEffect = 1
6553:             .Format        = "K"
6554:             .InputMask     = "999.99"
6555:             .Visible       = .T.
6556:         ENDWITH
6557: 
6558:         *-- Vlr Unit (top=85)
6559:         loc_oAba.AddObject("lbl_4c_LblVlUnit", "Label")
6560:         WITH loc_oAba.lbl_4c_LblVlUnit
6561:             .Caption   = "Vlr Unit"
6562:             .Top       = 85
6563:             .Left      = 30
6564:             .FontName  = "Tahoma"
6565:             .FontSize  = 7
6566:             .BackStyle = 0
6567:             .ForeColor = RGB(90, 90, 90)
6568:             .AutoSize  = .T.
6569:             .Visible   = .T.
6570:         ENDWITH
6571: 
6572:         loc_oAba.AddObject("txt_4c_ProdVlUnitL", "TextBox")
6573:         WITH loc_oAba.txt_4c_ProdVlUnitL
6574:             .ControlSource = "crSigCnFNf.lvluni"
6575:             .Top           = 97
6576:             .Left          = 32
6577:             .Width         = 38
6578:             .Height        = 18
6579:             .FontName      = "Tahoma"
6580:             .FontSize      = 8
6581:             .SpecialEffect = 1
6582:             .Format        = "K"
6583:             .InputMask     = "999.99"
6584:             .Visible       = .T.
6585:         ENDWITH
6586: 
6587:         *-- Vlr Total (top=85)
6588:         loc_oAba.AddObject("lbl_4c_LblVlTot", "Label")
6589:         WITH loc_oAba.lbl_4c_LblVlTot
6590:             .Caption   = "Vlr Total"
6591:             .Top       = 85
6592:             .Left      = 71
6593:             .FontName  = "Tahoma"
6594:             .FontSize  = 7
6595:             .BackStyle = 0
6596:             .ForeColor = RGB(90, 90, 90)
6597:             .AutoSize  = .T.
6598:             .Visible   = .T.
6599:         ENDWITH
6600: 
6601:         loc_oAba.AddObject("txt_4c_ProdVlTotL", "TextBox")
6602:         WITH loc_oAba.txt_4c_ProdVlTotL
6603:             .ControlSource = "crSigCnFNf.lvltot"
6604:             .Top           = 97
6605:             .Left          = 75
6606:             .Width         = 38
6607:             .Height        = 18
6608:             .FontName      = "Tahoma"
6609:             .FontSize      = 8
6610:             .SpecialEffect = 1
6611:             .Format        = "K"
6612:             .InputMask     = "999.99"
6613:             .Visible       = .T.
6614:         ENDWITH
6615: 
6616:         *-- Al ICMS (top=85)
6617:         loc_oAba.AddObject("lbl_4c_LblAlICMS", "Label")
6618:         WITH loc_oAba.lbl_4c_LblAlICMS
6619:             .Caption   = "Al ICMS"
6620:             .Top       = 85
6621:             .Left      = 116
6622:             .FontName  = "Tahoma"
6623:             .FontSize  = 7
6624:             .BackStyle = 0
6625:             .ForeColor = RGB(90, 90, 90)
6626:             .AutoSize  = .T.
6627:             .Visible   = .T.
6628:         ENDWITH
6629: 
6630:         loc_oAba.AddObject("txt_4c_ProdAlICMSL", "TextBox")
6631:         WITH loc_oAba.txt_4c_ProdAlICMSL
6632:             .ControlSource = "crSigCnFNf.lbicm"
6633:             .Top           = 97
6634:             .Left          = 118
6635:             .Width         = 38
6636:             .Height        = 18
6637:             .FontName      = "Tahoma"
6638:             .FontSize      = 8
6639:             .SpecialEffect = 1
6640:             .Format        = "K"
6641:             .InputMask     = "999.99"
6642:             .Visible       = .T.
6643:         ENDWITH
6644: 
6645:         *-- Al IPI (top=85)
6646:         loc_oAba.AddObject("lbl_4c_LblAlIPI", "Label")
6647:         WITH loc_oAba.lbl_4c_LblAlIPI
6648:             .Caption   = "Al IPI"
6649:             .Top       = 85
6650:             .Left      = 165
6651:             .FontName  = "Tahoma"
6652:             .FontSize  = 7
6653:             .BackStyle = 0
6654:             .ForeColor = RGB(90, 90, 90)
6655:             .AutoSize  = .T.
6656:             .Visible   = .T.
6657:         ENDWITH
6658: 
6659:         loc_oAba.AddObject("txt_4c_ProdAlIPIL", "TextBox")
6660:         WITH loc_oAba.txt_4c_ProdAlIPIL
6661:             .ControlSource = "crSigCnFNf.ltipi"
6662:             .Top           = 97
6663:             .Left          = 161
6664:             .Width         = 38
6665:             .Height        = 18
6666:             .FontName      = "Tahoma"
6667:             .FontSize      = 8
6668:             .SpecialEffect = 1
6669:             .Format        = "K"
6670:             .InputMask     = "999.99"
6671:             .Visible       = .T.
6672:         ENDWITH
6673: 
6674:         *-- Valor IPI (top=85)
6675:         loc_oAba.AddObject("lbl_4c_LblValIPI", "Label")
6676:         WITH loc_oAba.lbl_4c_LblValIPI
6677:             .Caption   = "Valor IPI"
6678:             .Top       = 85
6679:             .Left      = 201
6680:             .FontName  = "Tahoma"
6681:             .FontSize  = 7
6682:             .BackStyle = 0
6683:             .ForeColor = RGB(90, 90, 90)
6684:             .AutoSize  = .T.
6685:             .Visible   = .T.
6686:         ENDWITH
6687: 
6688:         loc_oAba.AddObject("txt_4c_ProdValIPIL", "TextBox")
6689:         WITH loc_oAba.txt_4c_ProdValIPIL
6690:             .ControlSource = "crSigCnFNf.cvipi"
6691:             .Top           = 97
6692:             .Left          = 203
6693:             .Width         = 41
6694:             .Height        = 18
6695:             .FontName      = "Tahoma"
6696:             .FontSize      = 8
6697:             .SpecialEffect = 1
6698:             .Format        = "K"
6699:             .InputMask     = "999.99"
6700:             .Visible       = .T.
6701:         ENDWITH
6702: 
6703:         *-- CFOP (top=85)
6704:         loc_oAba.AddObject("lbl_4c_LblCFOP", "Label")
6705:         WITH loc_oAba.lbl_4c_LblCFOP
6706:             .Caption   = "CFOP"
6707:             .Top       = 85
6708:             .Left      = 253
6709:             .FontName  = "Tahoma"
6710:             .FontSize  = 7
6711:             .BackStyle = 0
6712:             .ForeColor = RGB(90, 90, 90)
6713:             .AutoSize  = .T.
6714:             .Visible   = .T.
6715:         ENDWITH
6716: 
6717:         loc_oAba.AddObject("txt_4c_ProdCFOPL", "TextBox")
6718:         WITH loc_oAba.txt_4c_ProdCFOPL
6719:             .ControlSource = "crSigCnFNf.lcfop"
6720:             .Top           = 97
6721:             .Left          = 248
6722:             .Width         = 41
6723:             .Height        = 18
6724:             .FontName      = "Tahoma"
6725:             .FontSize      = 8
6726:             .SpecialEffect = 1
6727:             .Format        = "K"
6728:             .InputMask     = "999.99"
6729:             .Visible       = .T.
6730:         ENDWITH
6731: 
6732:         *-- Peso Metal (top=85)
6733:         loc_oAba.AddObject("lbl_4c_LblPesoMet", "Label")
6734:         WITH loc_oAba.lbl_4c_LblPesoMet
6735:             .Caption   = "Peso Metal"
6736:             .Top       = 85
6737:             .Left      = 289
6738:             .FontName  = "Tahoma"
6739:             .FontSize  = 7
6740:             .BackStyle = 0
6741:             .ForeColor = RGB(90, 90, 90)
6742:             .AutoSize  = .T.
6743:             .Visible   = .T.
6744:         ENDWITH
6745: 
6746:         loc_oAba.AddObject("txt_4c_ProdPesoMetL", "TextBox")
6747:         WITH loc_oAba.txt_4c_ProdPesoMetL
6748:             .ControlSource = "crSigCnFNf.cpbru"
6749:             .Top           = 97
6750:             .Left          = 293
6751:             .Width         = 41
6752:             .Height        = 18
6753:             .FontName      = "Tahoma"
6754:             .FontSize      = 8
6755:             .SpecialEffect = 1

*-- Linhas 6761 a 7163:
6761:         *-- Config. Descricao Produto (shape + labels, top=125-248)
6762:         loc_oAba.AddObject("shp_4c_Shape1", "Shape")
6763:         WITH loc_oAba.shp_4c_Shape1
6764:             .Top           = 125
6765:             .Left          = 29
6766:             .Width         = 150
6767:             .Height        = 128
6768:             .Visible       = .T.
6769:         ENDWITH
6770: 
6771:         loc_oAba.AddObject("lbl_4c_LblCfgDesc", "Label")
6772:         WITH loc_oAba.lbl_4c_LblCfgDesc
6773:             .Caption   = " Config. Descri" + CHR(231) + CHR(227) + "o Produto "
6774:             .Top       = 127
6775:             .Left      = 32
6776:             .FontName  = "Tahoma"
6777:             .FontSize  = 7
6778:             .BackStyle = 0
6779:             .ForeColor = RGB(90, 90, 90)
6780:             .AutoSize  = .T.
6781:             .Visible   = .T.
6782:         ENDWITH
6783: 
6784:         *-- Separador interno (top=157)
6785:         loc_oAba.AddObject("shp_4c_Shape2", "Shape")
6786:         WITH loc_oAba.shp_4c_Shape2
6787:             .Top     = 157
6788:             .Left    = 29
6789:             .Width   = 150
6790:             .Height  = 2
6791:             .Visible = .T.
6792:         ENDWITH
6793: 
6794:         *-- Qt.Max.Caracteres (top=142)
6795:         loc_oAba.AddObject("lbl_4c_LblQtMax", "Label")
6796:         WITH loc_oAba.lbl_4c_LblQtMax
6797:             .Caption   = "Qt.M" + CHR(225) + "x.Caracteres"
6798:             .Top       = 142
6799:             .Left      = 38
6800:             .FontName  = "Tahoma"
6801:             .FontSize  = 7
6802:             .BackStyle = 0
6803:             .ForeColor = RGB(90, 90, 90)
6804:             .AutoSize  = .T.
6805:             .Visible   = .T.
6806:         ENDWITH
6807: 
6808:         loc_oAba.AddObject("txt_4c_QtMaxCarL", "TextBox")
6809:         WITH loc_oAba.txt_4c_QtMaxCarL
6810:             .ControlSource = "crSigCnFNf.tamdesc"
6811:             .Top           = 138
6812:             .Left          = 143
6813:             .Width         = 27
6814:             .Height        = 18
6815:             .FontName      = "Tahoma"
6816:             .FontSize      = 8
6817:             .SpecialEffect = 1
6818:             .Format        = "K"
6819:             .InputMask     = "999.99"
6820:             .Visible       = .T.
6821:         ENDWITH
6822: 
6823:         *-- Descricao Original (top=162)
6824:         loc_oAba.AddObject("lbl_4c_LblDescOrig", "Label")
6825:         WITH loc_oAba.lbl_4c_LblDescOrig
6826:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Original"
6827:             .Top       = 162
6828:             .Left      = 38
6829:             .FontName  = "Tahoma"
6830:             .FontSize  = 7
6831:             .BackStyle = 0
6832:             .ForeColor = RGB(90, 90, 90)
6833:             .AutoSize  = .T.
6834:             .Visible   = .T.
6835:         ENDWITH
6836: 
6837:         loc_oAba.AddObject("txt_4c_DescOrigL", "TextBox")
6838:         WITH loc_oAba.txt_4c_DescOrigL
6839:             .ControlSource = "crSigCnFNf.ldescpro"
6840:             .Top           = 159
6841:             .Left          = 143
6842:             .Width         = 27
6843:             .Height        = 18
6844:             .FontName      = "Tahoma"
6845:             .FontSize      = 8
6846:             .SpecialEffect = 1
6847:             .Format        = "K"
6848:             .InputMask     = "999.99"
6849:             .Visible       = .T.
6850:         ENDWITH
6851: 
6852:         *-- Adendo Tp. Fatura (top=180)
6853:         loc_oAba.AddObject("lbl_4c_LblAdendo", "Label")
6854:         WITH loc_oAba.lbl_4c_LblAdendo
6855:             .Caption   = "Adendo Tp. Fatura"
6856:             .Top       = 180
6857:             .Left      = 38
6858:             .FontName  = "Tahoma"
6859:             .FontSize  = 7
6860:             .BackStyle = 0
6861:             .ForeColor = RGB(90, 90, 90)
6862:             .AutoSize  = .T.
6863:             .Visible   = .T.
6864:         ENDWITH
6865: 
6866:         loc_oAba.AddObject("txt_4c_AdendoL", "TextBox")
6867:         WITH loc_oAba.txt_4c_AdendoL
6868:             .ControlSource = "crSigCnFNf.ltipi"
6869:             .Top           = 177
6870:             .Left          = 143
6871:             .Width         = 27
6872:             .Height        = 18
6873:             .FontName      = "Tahoma"
6874:             .FontSize      = 8
6875:             .SpecialEffect = 1
6876:             .Format        = "K"
6877:             .InputMask     = "999.99"
6878:             .Visible       = .T.
6879:         ENDWITH
6880: 
6881:         *-- Cor (top=198)
6882:         loc_oAba.AddObject("lbl_4c_LblCor", "Label")
6883:         WITH loc_oAba.lbl_4c_LblCor
6884:             .Caption   = "Cor"
6885:             .Top       = 198
6886:             .Left      = 38
6887:             .FontName  = "Tahoma"
6888:             .FontSize  = 7
6889:             .BackStyle = 0
6890:             .ForeColor = RGB(90, 90, 90)
6891:             .AutoSize  = .T.
6892:             .Visible   = .T.
6893:         ENDWITH
6894: 
6895:         loc_oAba.AddObject("txt_4c_CorL", "TextBox")
6896:         WITH loc_oAba.txt_4c_CorL
6897:             .ControlSource = "crSigCnFNf.ocor"
6898:             .Top           = 195
6899:             .Left          = 143
6900:             .Width         = 27
6901:             .Height        = 18
6902:             .FontName      = "Tahoma"
6903:             .FontSize      = 8
6904:             .SpecialEffect = 1
6905:             .Format        = "K"
6906:             .InputMask     = "999.99"
6907:             .Visible       = .T.
6908:         ENDWITH
6909: 
6910:         *-- Embalagem (top=216)
6911:         loc_oAba.AddObject("lbl_4c_LblEmb", "Label")
6912:         WITH loc_oAba.lbl_4c_LblEmb
6913:             .Caption   = "Embalagem"
6914:             .Top       = 216
6915:             .Left      = 38
6916:             .FontName  = "Tahoma"
6917:             .FontSize  = 7
6918:             .BackStyle = 0
6919:             .ForeColor = RGB(90, 90, 90)
6920:             .AutoSize  = .T.
6921:             .Visible   = .T.
6922:         ENDWITH
6923: 
6924:         loc_oAba.AddObject("txt_4c_EmbL", "TextBox")
6925:         WITH loc_oAba.txt_4c_EmbL
6926:             .ControlSource = "crSigCnFNf.oemb"
6927:             .Top           = 213
6928:             .Left          = 143
6929:             .Width         = 27
6930:             .Height        = 18
6931:             .FontName      = "Tahoma"
6932:             .FontSize      = 8
6933:             .SpecialEffect = 1
6934:             .Format        = "K"
6935:             .InputMask     = "999.99"
6936:             .Visible       = .T.
6937:         ENDWITH
6938: 
6939:         *-- Tamanho (top=234)
6940:         loc_oAba.AddObject("lbl_4c_LblTamanho", "Label")
6941:         WITH loc_oAba.lbl_4c_LblTamanho
6942:             .Caption   = "Tamanho"
6943:             .Top       = 234
6944:             .Left      = 38
6945:             .FontName  = "Tahoma"
6946:             .FontSize  = 7
6947:             .BackStyle = 0
6948:             .ForeColor = RGB(90, 90, 90)
6949:             .AutoSize  = .T.
6950:             .Visible   = .T.
6951:         ENDWITH
6952: 
6953:         loc_oAba.AddObject("txt_4c_TamL", "TextBox")
6954:         WITH loc_oAba.txt_4c_TamL
6955:             .ControlSource = "crSigCnFNf.otam"
6956:             .Top           = 231
6957:             .Left          = 143
6958:             .Width         = 27
6959:             .Height        = 18
6960:             .FontName      = "Tahoma"
6961:             .FontSize      = 8
6962:             .SpecialEffect = 1
6963:             .Format        = "K"
6964:             .InputMask     = "999.99"
6965:             .Visible       = .T.
6966:         ENDWITH
6967: 
6968:         *-- Coluna Obs (top=137, right side)
6969:         loc_oAba.AddObject("lbl_4c_LblColObs", "Label")
6970:         WITH loc_oAba.lbl_4c_LblColObs
6971:             .Caption   = "Coluna Obs"
6972:             .Top       = 137
6973:             .Left      = 199
6974:             .FontName  = "Tahoma"
6975:             .FontSize  = 7
6976:             .BackStyle = 0
6977:             .ForeColor = RGB(90, 90, 90)
6978:             .AutoSize  = .T.
6979:             .Visible   = .T.
6980:         ENDWITH
6981: 
6982:         loc_oAba.AddObject("txt_4c_ColObsL", "TextBox")
6983:         WITH loc_oAba.txt_4c_ColObsL
6984:             .ControlSource = "crSigCnFNf.tamcolobs"
6985:             .Top           = 149
6986:             .Left          = 207
6987:             .Width         = 41
6988:             .Height        = 18
6989:             .FontName      = "Tahoma"
6990:             .FontSize      = 8
6991:             .SpecialEffect = 1
6992:             .Format        = "K"
6993:             .InputMask     = "999.99"
6994:             .Visible       = .T.
6995:         ENDWITH
6996: 
6997:         *-- No. Colunas (top=137)
6998:         loc_oAba.AddObject("lbl_4c_LblNoCols", "Label")
6999:         WITH loc_oAba.lbl_4c_LblNoCols
7000:             .Caption   = "No. Colunas"
7001:             .Top       = 137
7002:             .Left      = 268
7003:             .FontName  = "Tahoma"
7004:             .FontSize  = 7
7005:             .BackStyle = 0
7006:             .ForeColor = RGB(90, 90, 90)
7007:             .AutoSize  = .T.
7008:             .Visible   = .T.
7009:         ENDWITH
7010: 
7011:         loc_oAba.AddObject("txt_4c_NoColsL", "TextBox")
7012:         WITH loc_oAba.txt_4c_NoColsL
7013:             .ControlSource = "crSigCnFNf.nldser"
7014:             .Top           = 149
7015:             .Left          = 279
7016:             .Width         = 41
7017:             .Height        = 18
7018:             .FontName      = "Tahoma"
7019:             .FontSize      = 8
7020:             .SpecialEffect = 1
7021:             .Format        = "K"
7022:             .InputMask     = "999.99"
7023:             .Visible       = .T.
7024:         ENDWITH
7025: 
7026:         *-- No. Linhas (top=137)
7027:         loc_oAba.AddObject("lbl_4c_LblNoLins", "Label")
7028:         WITH loc_oAba.lbl_4c_LblNoLins
7029:             .Caption   = "No. Linhas"
7030:             .Top       = 137
7031:             .Left      = 341
7032:             .FontName  = "Tahoma"
7033:             .FontSize  = 7
7034:             .BackStyle = 0
7035:             .ForeColor = RGB(90, 90, 90)
7036:             .AutoSize  = .T.
7037:             .Visible   = .T.
7038:         ENDWITH
7039: 
7040:         loc_oAba.AddObject("txt_4c_NoLinsL", "TextBox")
7041:         WITH loc_oAba.txt_4c_NoLinsL
7042:             .ControlSource = "crSigCnFNf.ncdser"
7043:             .Top           = 149
7044:             .Left          = 348
7045:             .Width         = 41
7046:             .Height        = 18
7047:             .FontName      = "Tahoma"
7048:             .FontSize      = 8
7049:             .SpecialEffect = 1
7050:             .Format        = "K"
7051:             .InputMask     = "999.99"
7052:             .Visible       = .T.
7053:         ENDWITH
7054: 
7055:         *-- Total de Quantidade (top=136)
7056:         loc_oAba.AddObject("lbl_4c_LblTotQtd", "Label")
7057:         WITH loc_oAba.lbl_4c_LblTotQtd
7058:             .Caption   = "Total de Quantidade"
7059:             .Top       = 136
7060:             .Left      = 415
7061:             .FontName  = "Tahoma"
7062:             .FontSize  = 7
7063:             .BackStyle = 0
7064:             .ForeColor = RGB(90, 90, 90)
7065:             .AutoSize  = .T.
7066:             .Visible   = .T.
7067:         ENDWITH
7068: 
7069:         loc_oAba.AddObject("txt_4c_TotQtdL", "TextBox")
7070:         WITH loc_oAba.txt_4c_TotQtdL
7071:             .ControlSource = "crSigCnFNf.ltqtde"
7072:             .Top           = 148
7073:             .Left          = 419
7074:             .Width         = 41
7075:             .Height        = 18
7076:             .FontName      = "Tahoma"
7077:             .FontSize      = 8
7078:             .SpecialEffect = 1
7079:             .Format        = "K"
7080:             .InputMask     = "999.99"
7081:             .Visible       = .T.
7082:         ENDWITH
7083: 
7084:         loc_oAba.AddObject("lbl_4c_TotQtdX", "Label")
7085:         WITH loc_oAba.lbl_4c_TotQtdX
7086:             .Caption   = "x"
7087:             .Top       = 150
7088:             .Left      = 462
7089:             .FontName  = "Tahoma"
7090:             .FontSize  = 7
7091:             .BackStyle = 0
7092:             .ForeColor = RGB(90, 90, 90)
7093:             .AutoSize  = .T.
7094:             .Visible   = .T.
7095:         ENDWITH
7096: 
7097:         loc_oAba.AddObject("txt_4c_TotQtdC", "TextBox")
7098:         WITH loc_oAba.txt_4c_TotQtdC
7099:             .ControlSource = "crSigCnFNf.ctqtde"
7100:             .Top           = 148
7101:             .Left          = 468
7102:             .Width         = 41
7103:             .Height        = 18
7104:             .FontName      = "Tahoma"
7105:             .FontSize      = 8
7106:             .SpecialEffect = 1
7107:             .Format        = "K"
7108:             .InputMask     = "999.99"
7109:             .Visible       = .T.
7110:         ENDWITH
7111: 
7112:         *-- Desconto/Acrescimo (top=193)
7113:         loc_oAba.AddObject("lbl_4c_LblDescAcr", "Label")
7114:         WITH loc_oAba.lbl_4c_LblDescAcr
7115:             .Caption   = "Desconto / Acr" + CHR(233) + "scimo"
7116:             .Top       = 193
7117:             .Left      = 241
7118:             .FontName  = "Tahoma"
7119:             .FontSize  = 7
7120:             .BackStyle = 0
7121:             .ForeColor = RGB(90, 90, 90)
7122:             .AutoSize  = .T.
7123:             .Visible   = .T.
7124:         ENDWITH
7125: 
7126:         loc_oAba.AddObject("txt_4c_DescAcrL", "TextBox")
7127:         WITH loc_oAba.txt_4c_DescAcrL
7128:             .ControlSource = "crSigCnFNf.cdesconto"
7129:             .Top           = 205
7130:             .Left          = 250
7131:             .Width         = 41
7132:             .Height        = 18
7133:             .FontName      = "Tahoma"
7134:             .FontSize      = 8
7135:             .SpecialEffect = 1
7136:             .Format        = "K"
7137:             .InputMask     = "999.99"
7138:             .Visible       = .T.
7139:         ENDWITH
7140: 
7141:         loc_oAba.AddObject("lbl_4c_DescAcrX", "Label")
7142:         WITH loc_oAba.lbl_4c_DescAcrX
7143:             .Caption   = "x"
7144:             .Top       = 207
7145:             .Left      = 293
7146:             .FontName  = "Tahoma"
7147:             .FontSize  = 7
7148:             .BackStyle = 0
7149:             .ForeColor = RGB(90, 90, 90)
7150:             .AutoSize  = .T.
7151:             .Visible   = .T.
7152:         ENDWITH
7153: 
7154:         loc_oAba.AddObject("txt_4c_DescAcrC", "TextBox")
7155:         WITH loc_oAba.txt_4c_DescAcrC
7156:             .ControlSource = "crSigCnFNf.cdesconto"
7157:             .Top           = 205
7158:             .Left          = 299
7159:             .Width         = 41
7160:             .Height        = 18
7161:             .FontName      = "Tahoma"
7162:             .FontSize      = 8
7163:             .SpecialEffect = 1

*-- Linhas 7169 a 7835:
7169:         *-- Shape para Descricao 3D border (top=134)
7170:         loc_oAba.AddObject("shp_4c_Shape3", "Shape")
7171:         WITH loc_oAba.shp_4c_Shape3
7172:             .Top     = 134
7173:             .Left    = 193
7174:             .Width   = 217
7175:             .Height  = 37
7176:             .Visible = .T.
7177:         ENDWITH
7178:     ENDPROC
7179: 
7180:     *--------------------------------------------------------------------------
7181:     PROTECTED PROCEDURE ConfigurarImpostosTab()
7182:         LOCAL loc_oAba
7183:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page5
7184: 
7185:         *-- Base de Calculo ICMS (top=19)
7186:         loc_oAba.AddObject("lbl_4c_LblBcICMS", "Label")
7187:         WITH loc_oAba.lbl_4c_LblBcICMS
7188:             .Caption   = "Base de C" + CHR(225) + "lculo ICMS"
7189:             .Top       = 19
7190:             .Left      = 28
7191:             .FontName  = "Tahoma"
7192:             .FontSize  = 7
7193:             .BackStyle = 0
7194:             .ForeColor = RGB(90, 90, 90)
7195:             .AutoSize  = .T.
7196:             .Visible   = .T.
7197:         ENDWITH
7198: 
7199:         loc_oAba.AddObject("txt_4c_BcICMSL", "TextBox")
7200:         WITH loc_oAba.txt_4c_BcICMSL
7201:             .ControlSource = "crSigCnFNf.lbicm"
7202:             .Top = 31
7203:             .Left = 39
7204:             .Width = 41
7205:             .Height = 18
7206:             .FontName = "Tahoma"
7207:             .FontSize = 8
7208:             .SpecialEffect = 1
7209:             .Format = "K"
7210:             .InputMask = "999.99"
7211:             .Visible = .T.
7212:         ENDWITH
7213: 
7214:         loc_oAba.AddObject("lbl_4c_BcICMSX", "Label")
7215:         WITH loc_oAba.lbl_4c_BcICMSX
7216:             .Caption = "x"
7217:             .Top = 33
7218:             .Left = 82
7219:             .FontName = "Tahoma"
7220:             .FontSize = 7
7221:             .BackStyle = 0
7222:             .ForeColor = RGB(90,90,90)
7223:             .AutoSize = .T.
7224:             .Visible = .T.
7225:         ENDWITH
7226: 
7227:         loc_oAba.AddObject("txt_4c_BcICMSC", "TextBox")
7228:         WITH loc_oAba.txt_4c_BcICMSC
7229:             .ControlSource = "crSigCnFNf.cbicm"
7230:             .Top = 31
7231:             .Left = 88
7232:             .Width = 41
7233:             .Height = 18
7234:             .FontName = "Tahoma"
7235:             .FontSize = 8
7236:             .SpecialEffect = 1
7237:             .Format = "K"
7238:             .InputMask = "999.99"
7239:             .Visible = .T.
7240:         ENDWITH
7241: 
7242:         *-- Valor do ICMS (top=19)
7243:         loc_oAba.AddObject("lbl_4c_LblValICMS", "Label")
7244:         WITH loc_oAba.lbl_4c_LblValICMS
7245:             .Caption = "Valor do ICMS"
7246:             .Top = 19
7247:             .Left = 155
7248:             .FontName = "Tahoma"
7249:             .FontSize = 7
7250:             .BackStyle = 0
7251:             .ForeColor = RGB(90,90,90)
7252:             .AutoSize = .T.
7253:             .Visible = .T.
7254:         ENDWITH
7255: 
7256:         loc_oAba.AddObject("txt_4c_ValICMSL", "TextBox")
7257:         WITH loc_oAba.txt_4c_ValICMSL
7258:             .ControlSource = "crSigCnFNf.lticm"
7259:             .Top = 31
7260:             .Left = 147
7261:             .Width = 41
7262:             .Height = 18
7263:             .FontName = "Tahoma"
7264:             .FontSize = 8
7265:             .SpecialEffect = 1
7266:             .Format = "K"
7267:             .InputMask = "999.99"
7268:             .Visible = .T.
7269:         ENDWITH
7270: 
7271:         loc_oAba.AddObject("lbl_4c_ValICMSX", "Label")
7272:         WITH loc_oAba.lbl_4c_ValICMSX
7273:             .Caption = "x"
7274:             .Top = 33
7275:             .Left = 190
7276:             .FontName = "Tahoma"
7277:             .FontSize = 7
7278:             .BackStyle = 0
7279:             .ForeColor = RGB(90,90,90)
7280:             .AutoSize = .T.
7281:             .Visible = .T.
7282:         ENDWITH
7283: 
7284:         loc_oAba.AddObject("txt_4c_ValICMSC", "TextBox")
7285:         WITH loc_oAba.txt_4c_ValICMSC
7286:             .ControlSource = "crSigCnFNf.cticm"
7287:             .Top = 31
7288:             .Left = 196
7289:             .Width = 41
7290:             .Height = 18
7291:             .FontName = "Tahoma"
7292:             .FontSize = 8
7293:             .SpecialEffect = 1
7294:             .Format = "K"
7295:             .InputMask = "999.99"
7296:             .Visible = .T.
7297:         ENDWITH
7298: 
7299:         *-- Valor do Frete (top=53)
7300:         loc_oAba.AddObject("lbl_4c_LblValFret", "Label")
7301:         WITH loc_oAba.lbl_4c_LblValFret
7302:             .Caption = "Valor do Frete"
7303:             .Top = 53
7304:             .Left = 39
7305:             .FontName = "Tahoma"
7306:             .FontSize = 7
7307:             .BackStyle = 0
7308:             .ForeColor = RGB(90,90,90)
7309:             .AutoSize = .T.
7310:             .Visible = .T.
7311:         ENDWITH
7312: 
7313:         loc_oAba.AddObject("txt_4c_ValFretL", "TextBox")
7314:         WITH loc_oAba.txt_4c_ValFretL
7315:             .ControlSource = "crSigCnFNf.lfrete"
7316:             .Top = 65
7317:             .Left = 39
7318:             .Width = 41
7319:             .Height = 18
7320:             .FontName = "Tahoma"
7321:             .FontSize = 8
7322:             .SpecialEffect = 1
7323:             .Format = "K"
7324:             .InputMask = "999.99"
7325:             .Visible = .T.
7326:         ENDWITH
7327: 
7328:         loc_oAba.AddObject("lbl_4c_ValFretX", "Label")
7329:         WITH loc_oAba.lbl_4c_ValFretX
7330:             .Caption = "x"
7331:             .Top = 67
7332:             .Left = 82
7333:             .FontName = "Tahoma"
7334:             .FontSize = 7
7335:             .BackStyle = 0
7336:             .ForeColor = RGB(90,90,90)
7337:             .AutoSize = .T.
7338:             .Visible = .T.
7339:         ENDWITH
7340: 
7341:         loc_oAba.AddObject("txt_4c_ValFretC", "TextBox")
7342:         WITH loc_oAba.txt_4c_ValFretC
7343:             .ControlSource = "crSigCnFNf.cfrete"
7344:             .Top = 65
7345:             .Left = 88
7346:             .Width = 41
7347:             .Height = 18
7348:             .FontName = "Tahoma"
7349:             .FontSize = 8
7350:             .SpecialEffect = 1
7351:             .Format = "K"
7352:             .InputMask = "999.99"
7353:             .Visible = .T.
7354:         ENDWITH
7355: 
7356:         *-- Valor do Seguro (top=53)
7357:         loc_oAba.AddObject("lbl_4c_LblValSeg", "Label")
7358:         WITH loc_oAba.lbl_4c_LblValSeg
7359:             .Caption = "Valor do Seguro"
7360:             .Top = 53
7361:             .Left = 147
7362:             .FontName = "Tahoma"
7363:             .FontSize = 7
7364:             .BackStyle = 0
7365:             .ForeColor = RGB(90,90,90)
7366:             .AutoSize = .T.
7367:             .Visible = .T.
7368:         ENDWITH
7369: 
7370:         loc_oAba.AddObject("txt_4c_ValSegL", "TextBox")
7371:         WITH loc_oAba.txt_4c_ValSegL
7372:             .ControlSource = "crSigCnFNf.lseguro"
7373:             .Top = 65
7374:             .Left = 147
7375:             .Width = 41
7376:             .Height = 18
7377:             .FontName = "Tahoma"
7378:             .FontSize = 8
7379:             .SpecialEffect = 1
7380:             .Format = "K"
7381:             .InputMask = "999.99"
7382:             .Visible = .T.
7383:         ENDWITH
7384: 
7385:         loc_oAba.AddObject("lbl_4c_ValSegX", "Label")
7386:         WITH loc_oAba.lbl_4c_ValSegX
7387:             .Caption = "x"
7388:             .Top = 67
7389:             .Left = 190
7390:             .FontName = "Tahoma"
7391:             .FontSize = 7
7392:             .BackStyle = 0
7393:             .ForeColor = RGB(90,90,90)
7394:             .AutoSize = .T.
7395:             .Visible = .T.
7396:         ENDWITH
7397: 
7398:         loc_oAba.AddObject("txt_4c_ValSegC", "TextBox")
7399:         WITH loc_oAba.txt_4c_ValSegC
7400:             .ControlSource = "crSigCnFNf.cseguro"
7401:             .Top = 65
7402:             .Left = 196
7403:             .Width = 41
7404:             .Height = 18
7405:             .FontName = "Tahoma"
7406:             .FontSize = 8
7407:             .SpecialEffect = 1
7408:             .Format = "K"
7409:             .InputMask = "999.99"
7410:             .Visible = .T.
7411:         ENDWITH
7412: 
7413:         *-- Outras Despesas (top=53)
7414:         loc_oAba.AddObject("lbl_4c_LblOutDesp", "Label")
7415:         WITH loc_oAba.lbl_4c_LblOutDesp
7416:             .Caption = "Outras Despesas"
7417:             .Top = 53
7418:             .Left = 255
7419:             .FontName = "Tahoma"
7420:             .FontSize = 7
7421:             .BackStyle = 0
7422:             .ForeColor = RGB(90,90,90)
7423:             .AutoSize = .T.
7424:             .Visible = .T.
7425:         ENDWITH
7426: 
7427:         loc_oAba.AddObject("txt_4c_OutDespL", "TextBox")
7428:         WITH loc_oAba.txt_4c_OutDespL
7429:             .ControlSource = "crSigCnFNf.coutras"
7430:             .Top = 65
7431:             .Left = 255
7432:             .Width = 41
7433:             .Height = 18
7434:             .FontName = "Tahoma"
7435:             .FontSize = 8
7436:             .SpecialEffect = 1
7437:             .Format = "K"
7438:             .InputMask = "999.99"
7439:             .Visible = .T.
7440:         ENDWITH
7441: 
7442:         loc_oAba.AddObject("lbl_4c_OutDespX", "Label")
7443:         WITH loc_oAba.lbl_4c_OutDespX
7444:             .Caption = "x"
7445:             .Top = 67
7446:             .Left = 298
7447:             .FontName = "Tahoma"
7448:             .FontSize = 7
7449:             .BackStyle = 0
7450:             .ForeColor = RGB(90,90,90)
7451:             .AutoSize = .T.
7452:             .Visible = .T.
7453:         ENDWITH
7454: 
7455:         loc_oAba.AddObject("txt_4c_OutDespC", "TextBox")
7456:         WITH loc_oAba.txt_4c_OutDespC
7457:             .ControlSource = "crSigCnFNf.coutras"
7458:             .Top = 65
7459:             .Left = 304
7460:             .Width = 41
7461:             .Height = 18
7462:             .FontName = "Tahoma"
7463:             .FontSize = 8
7464:             .SpecialEffect = 1
7465:             .Format = "K"
7466:             .InputMask = "999.99"
7467:             .Visible = .T.
7468:         ENDWITH
7469: 
7470:         *-- Valor dos Produtos (top=89)
7471:         loc_oAba.AddObject("lbl_4c_LblValProd", "Label")
7472:         WITH loc_oAba.lbl_4c_LblValProd
7473:             .Caption = "Valor dos Produtos"
7474:             .Top = 89
7475:             .Left = 35
7476:             .FontName = "Tahoma"
7477:             .FontSize = 7
7478:             .BackStyle = 0
7479:             .ForeColor = RGB(90,90,90)
7480:             .AutoSize = .T.
7481:             .Visible = .T.
7482:         ENDWITH
7483: 
7484:         loc_oAba.AddObject("txt_4c_ValProdL", "TextBox")
7485:         WITH loc_oAba.txt_4c_ValProdL
7486:             .ControlSource = "crSigCnFNf.lvltot"
7487:             .Top = 101
7488:             .Left = 39
7489:             .Width = 41
7490:             .Height = 18
7491:             .FontName = "Tahoma"
7492:             .FontSize = 8
7493:             .SpecialEffect = 1
7494:             .Format = "K"
7495:             .InputMask = "999.99"
7496:             .Visible = .T.
7497:         ENDWITH
7498: 
7499:         loc_oAba.AddObject("lbl_4c_ValProdX", "Label")
7500:         WITH loc_oAba.lbl_4c_ValProdX
7501:             .Caption = "x"
7502:             .Top = 103
7503:             .Left = 82
7504:             .FontName = "Tahoma"
7505:             .FontSize = 7
7506:             .BackStyle = 0
7507:             .ForeColor = RGB(90,90,90)
7508:             .AutoSize = .T.
7509:             .Visible = .T.
7510:         ENDWITH
7511: 
7512:         loc_oAba.AddObject("txt_4c_ValProdC", "TextBox")
7513:         WITH loc_oAba.txt_4c_ValProdC
7514:             .ControlSource = "crSigCnFNf.cvltot"
7515:             .Top = 101
7516:             .Left = 88
7517:             .Width = 41
7518:             .Height = 18
7519:             .FontName = "Tahoma"
7520:             .FontSize = 8
7521:             .SpecialEffect = 1
7522:             .Format = "K"
7523:             .InputMask = "999.99"
7524:             .Visible = .T.
7525:         ENDWITH
7526: 
7527:         *-- Base de Calculo do IPI (top=89)
7528:         loc_oAba.AddObject("lbl_4c_LblBcIPI", "Label")
7529:         WITH loc_oAba.lbl_4c_LblBcIPI
7530:             .Caption = "Base de C" + CHR(225) + "lculo do IPI"
7531:             .Top = 89
7532:             .Left = 137
7533:             .FontName = "Tahoma"
7534:             .FontSize = 7
7535:             .BackStyle = 0
7536:             .ForeColor = RGB(90,90,90)
7537:             .AutoSize = .T.
7538:             .Visible = .T.
7539:         ENDWITH
7540: 
7541:         loc_oAba.AddObject("txt_4c_BcIPIL", "TextBox")
7542:         WITH loc_oAba.txt_4c_BcIPIL
7543:             .ControlSource = "crSigCnFNf.lbicm"
7544:             .Top = 101
7545:             .Left = 147
7546:             .Width = 41
7547:             .Height = 18
7548:             .FontName = "Tahoma"
7549:             .FontSize = 8
7550:             .SpecialEffect = 1
7551:             .Format = "K"
7552:             .InputMask = "999.99"
7553:             .Visible = .T.
7554:         ENDWITH
7555: 
7556:         loc_oAba.AddObject("lbl_4c_BcIPIX", "Label")
7557:         WITH loc_oAba.lbl_4c_BcIPIX
7558:             .Caption = "x"
7559:             .Top = 104
7560:             .Left = 190
7561:             .FontName = "Tahoma"
7562:             .FontSize = 7
7563:             .BackStyle = 0
7564:             .ForeColor = RGB(90,90,90)
7565:             .AutoSize = .T.
7566:             .Visible = .T.
7567:         ENDWITH
7568: 
7569:         loc_oAba.AddObject("txt_4c_BcIPIC", "TextBox")
7570:         WITH loc_oAba.txt_4c_BcIPIC
7571:             .ControlSource = "crSigCnFNf.cbicm"
7572:             .Top = 101
7573:             .Left = 196
7574:             .Width = 41
7575:             .Height = 18
7576:             .FontName = "Tahoma"
7577:             .FontSize = 8
7578:             .SpecialEffect = 1
7579:             .Format = "K"
7580:             .InputMask = "999.99"
7581:             .Visible = .T.
7582:         ENDWITH
7583: 
7584:         *-- Valor Total do IPI (top=89)
7585:         loc_oAba.AddObject("lbl_4c_LblVlTIPI", "Label")
7586:         WITH loc_oAba.lbl_4c_LblVlTIPI
7587:             .Caption = "Valor Total do IPI"
7588:             .Top = 89
7589:             .Left = 255
7590:             .FontName = "Tahoma"
7591:             .FontSize = 7
7592:             .BackStyle = 0
7593:             .ForeColor = RGB(90,90,90)
7594:             .AutoSize = .T.
7595:             .Visible = .T.
7596:         ENDWITH
7597: 
7598:         loc_oAba.AddObject("txt_4c_VlTIPIL", "TextBox")
7599:         WITH loc_oAba.txt_4c_VlTIPIL
7600:             .ControlSource = "crSigCnFNf.ctipi"
7601:             .Top = 101
7602:             .Left = 255
7603:             .Width = 41
7604:             .Height = 18
7605:             .FontName = "Tahoma"
7606:             .FontSize = 8
7607:             .SpecialEffect = 1
7608:             .Format = "K"
7609:             .InputMask = "999.99"
7610:             .Visible = .T.
7611:         ENDWITH
7612: 
7613:         loc_oAba.AddObject("lbl_4c_VlTIPIX", "Label")
7614:         WITH loc_oAba.lbl_4c_VlTIPIX
7615:             .Caption = "x"
7616:             .Top = 103
7617:             .Left = 298
7618:             .FontName = "Tahoma"
7619:             .FontSize = 7
7620:             .BackStyle = 0
7621:             .ForeColor = RGB(90,90,90)
7622:             .AutoSize = .T.
7623:             .Visible = .T.
7624:         ENDWITH
7625: 
7626:         loc_oAba.AddObject("txt_4c_VlTIPIC", "TextBox")
7627:         WITH loc_oAba.txt_4c_VlTIPIC
7628:             .ControlSource = "crSigCnFNf.ctipi"
7629:             .Top = 101
7630:             .Left = 304
7631:             .Width = 41
7632:             .Height = 18
7633:             .FontName = "Tahoma"
7634:             .FontSize = 8
7635:             .SpecialEffect = 1
7636:             .Format = "K"
7637:             .InputMask = "999.99"
7638:             .Visible = .T.
7639:         ENDWITH
7640: 
7641:         *-- Valor Total da Nota (top=89)
7642:         loc_oAba.AddObject("lbl_4c_LblVlTNota", "Label")
7643:         WITH loc_oAba.lbl_4c_LblVlTNota
7644:             .Caption = "Valor Total da Nota"
7645:             .Top = 89
7646:             .Left = 357
7647:             .FontName = "Tahoma"
7648:             .FontSize = 7
7649:             .BackStyle = 0
7650:             .ForeColor = RGB(90,90,90)
7651:             .AutoSize = .T.
7652:             .Visible = .T.
7653:         ENDWITH
7654: 
7655:         loc_oAba.AddObject("txt_4c_VlTNotaL", "TextBox")
7656:         WITH loc_oAba.txt_4c_VlTNotaL
7657:             .ControlSource = "crSigCnFNf.ltnota"
7658:             .Top = 101
7659:             .Left = 363
7660:             .Width = 41
7661:             .Height = 18
7662:             .FontName = "Tahoma"
7663:             .FontSize = 8
7664:             .SpecialEffect = 1
7665:             .Format = "K"
7666:             .InputMask = "999.99"
7667:             .Visible = .T.
7668:         ENDWITH
7669: 
7670:         loc_oAba.AddObject("lbl_4c_VlTNotaX", "Label")
7671:         WITH loc_oAba.lbl_4c_VlTNotaX
7672:             .Caption = "x"
7673:             .Top = 103
7674:             .Left = 406
7675:             .FontName = "Tahoma"
7676:             .FontSize = 7
7677:             .BackStyle = 0
7678:             .ForeColor = RGB(90,90,90)
7679:             .AutoSize = .T.
7680:             .Visible = .T.
7681:         ENDWITH
7682: 
7683:         loc_oAba.AddObject("txt_4c_VlTNotaC", "TextBox")
7684:         WITH loc_oAba.txt_4c_VlTNotaC
7685:             .ControlSource = "crSigCnFNf.ctnota"
7686:             .Top = 101
7687:             .Left = 412
7688:             .Width = 41
7689:             .Height = 18
7690:             .FontName = "Tahoma"
7691:             .FontSize = 8
7692:             .SpecialEffect = 1
7693:             .Format = "K"
7694:             .InputMask = "999.99"
7695:             .Visible = .T.
7696:         ENDWITH
7697: 
7698:         *-- Fonte (top=89)
7699:         loc_oAba.AddObject("lbl_4c_LblFonte", "Label")
7700:         WITH loc_oAba.lbl_4c_LblFonte
7701:             .Caption = "Fonte"
7702:             .Top = 89
7703:             .Left = 461
7704:             .FontName = "Tahoma"
7705:             .FontSize = 7
7706:             .BackStyle = 0
7707:             .ForeColor = RGB(90,90,90)
7708:             .AutoSize = .T.
7709:             .Visible = .T.
7710:         ENDWITH
7711: 
7712:         loc_oAba.AddObject("txt_4c_FonteL", "TextBox")
7713:         WITH loc_oAba.txt_4c_FonteL
7714:             .ControlSource = "crSigCnFNf.ltpfrete"
7715:             .Top = 101
7716:             .Left = 461
7717:             .Width = 23
7718:             .Height = 18
7719:             .FontName = "Tahoma"
7720:             .FontSize = 8
7721:             .SpecialEffect = 1
7722:             .Format = "K"
7723:             .InputMask = "999.99"
7724:             .Visible = .T.
7725:         ENDWITH
7726: 
7727:         *-- Base do ICMS ST (top=125)
7728:         loc_oAba.AddObject("lbl_4c_LblBcST", "Label")
7729:         WITH loc_oAba.lbl_4c_LblBcST
7730:             .Caption = "Base do ICMS ST"
7731:             .Top = 125
7732:             .Left = 38
7733:             .FontName = "Tahoma"
7734:             .FontSize = 7
7735:             .BackStyle = 0
7736:             .ForeColor = RGB(90,90,90)
7737:             .AutoSize = .T.
7738:             .Visible = .T.
7739:         ENDWITH
7740: 
7741:         loc_oAba.AddObject("txt_4c_BcSTL", "TextBox")
7742:         WITH loc_oAba.txt_4c_BcSTL
7743:             .ControlSource = "crSigCnFNf.lbicm"
7744:             .Top = 137
7745:             .Left = 39
7746:             .Width = 41
7747:             .Height = 18
7748:             .FontName = "Tahoma"
7749:             .FontSize = 8
7750:             .SpecialEffect = 1
7751:             .Format = "K"
7752:             .InputMask = "999.99"
7753:             .Visible = .T.
7754:         ENDWITH
7755: 
7756:         loc_oAba.AddObject("lbl_4c_BcSTX", "Label")
7757:         WITH loc_oAba.lbl_4c_BcSTX
7758:             .Caption = "x"
7759:             .Top = 139
7760:             .Left = 82
7761:             .FontName = "Tahoma"
7762:             .FontSize = 7
7763:             .BackStyle = 0
7764:             .ForeColor = RGB(90,90,90)
7765:             .AutoSize = .T.
7766:             .Visible = .T.
7767:         ENDWITH
7768: 
7769:         loc_oAba.AddObject("txt_4c_BcSTC", "TextBox")
7770:         WITH loc_oAba.txt_4c_BcSTC
7771:             .ControlSource = "crSigCnFNf.cbicm"
7772:             .Top = 137
7773:             .Left = 88
7774:             .Width = 41
7775:             .Height = 18
7776:             .FontName = "Tahoma"
7777:             .FontSize = 8
7778:             .SpecialEffect = 1
7779:             .Format = "K"
7780:             .InputMask = "999.99"
7781:             .Visible = .T.
7782:         ENDWITH
7783: 
7784:         *-- Valor do ICMS ST (top=125)
7785:         loc_oAba.AddObject("lbl_4c_LblValST", "Label")
7786:         WITH loc_oAba.lbl_4c_LblValST
7787:             .Caption = "Valor do ICMS ST"
7788:             .Top = 125
7789:             .Left = 146
7790:             .FontName = "Tahoma"
7791:             .FontSize = 7
7792:             .BackStyle = 0
7793:             .ForeColor = RGB(90,90,90)
7794:             .AutoSize = .T.
7795:             .Visible = .T.
7796:         ENDWITH
7797: 
7798:         loc_oAba.AddObject("txt_4c_ValSTL", "TextBox")
7799:         WITH loc_oAba.txt_4c_ValSTL
7800:             .ControlSource = "crSigCnFNf.lticm"
7801:             .Top = 137
7802:             .Left = 147
7803:             .Width = 41
7804:             .Height = 18
7805:             .FontName = "Tahoma"
7806:             .FontSize = 8
7807:             .SpecialEffect = 1
7808:             .Format = "K"
7809:             .InputMask = "999.99"
7810:             .Visible = .T.
7811:         ENDWITH
7812: 
7813:         loc_oAba.AddObject("lbl_4c_ValSTX", "Label")
7814:         WITH loc_oAba.lbl_4c_ValSTX
7815:             .Caption = "x"
7816:             .Top = 139
7817:             .Left = 190
7818:             .FontName = "Tahoma"
7819:             .FontSize = 7
7820:             .BackStyle = 0
7821:             .ForeColor = RGB(90,90,90)
7822:             .AutoSize = .T.
7823:             .Visible = .T.
7824:         ENDWITH
7825: 
7826:         loc_oAba.AddObject("txt_4c_ValSTC", "TextBox")
7827:         WITH loc_oAba.txt_4c_ValSTC
7828:             .ControlSource = "crSigCnFNf.cticm"
7829:             .Top = 137
7830:             .Left = 196
7831:             .Width = 41
7832:             .Height = 18
7833:             .FontName = "Tahoma"
7834:             .FontSize = 8
7835:             .SpecialEffect = 1

*-- Linhas 7841 a 7914:
7841:         *-- IR e ISS (top=180 shape, top=166 %, top=180 labels)
7842:         loc_oAba.AddObject("shp_4c_IRShape", "Shape")
7843:         WITH loc_oAba.shp_4c_IRShape
7844:             .Top = 171
7845:             .Left = 39
7846:             .Width = 105
7847:             .Height = 45
7848:             .Visible = .T.
7849:         ENDWITH
7850: 
7851:         loc_oAba.AddObject("lbl_4c_LblPct", "Label")
7852:         WITH loc_oAba.lbl_4c_LblPct
7853:             .Caption = "%"
7854:             .Top = 166
7855:             .Left = 44
7856:             .FontName = "Tahoma"
7857:             .FontSize = 7
7858:             .BackStyle = 0
7859:             .ForeColor = RGB(90,90,90)
7860:             .AutoSize = .T.
7861:             .Visible = .T.
7862:         ENDWITH
7863: 
7864:         loc_oAba.AddObject("lbl_4c_LblIR", "Label")
7865:         WITH loc_oAba.lbl_4c_LblIR
7866:             .Caption = "I.R."
7867:             .Top = 180
7868:             .Left = 44
7869:             .FontName = "Tahoma"
7870:             .FontSize = 7
7871:             .BackStyle = 0
7872:             .ForeColor = RGB(90,90,90)
7873:             .AutoSize = .T.
7874:             .Visible = .T.
7875:         ENDWITH
7876: 
7877:         loc_oAba.AddObject("txt_4c_IRVal", "TextBox")
7878:         WITH loc_oAba.txt_4c_IRVal
7879:             .ControlSource = "crSigCnFNf.pirs"
7880:             .Top = 193
7881:             .Left = 44
7882:             .Width = 46
7883:             .Height = 18
7884:             .FontName = "Tahoma"
7885:             .FontSize = 8
7886:             .SpecialEffect = 1
7887:             .Format = "K"
7888:             .InputMask = "999.99"
7889:             .Visible = .T.
7890:         ENDWITH
7891: 
7892:         loc_oAba.AddObject("lbl_4c_LblISS", "Label")
7893:         WITH loc_oAba.lbl_4c_LblISS
7894:             .Caption = "I.S.S."
7895:             .Top = 180
7896:             .Left = 93
7897:             .FontName = "Tahoma"
7898:             .FontSize = 7
7899:             .BackStyle = 0
7900:             .ForeColor = RGB(90,90,90)
7901:             .AutoSize = .T.
7902:             .Visible = .T.
7903:         ENDWITH
7904: 
7905:         loc_oAba.AddObject("txt_4c_ISSVal", "TextBox")
7906:         WITH loc_oAba.txt_4c_ISSVal
7907:             .ControlSource = "crSigCnFNf.piss"
7908:             .Top = 193
7909:             .Left = 93
7910:             .Width = 46
7911:             .Height = 18
7912:             .FontName = "Tahoma"
7913:             .FontSize = 8
7914:             .SpecialEffect = 1

*-- Linhas 7926 a 8456:
7926:         *-- Shape Transportador (top=7)
7927:         loc_oAba.AddObject("shp_4c_Transp", "Shape")
7928:         WITH loc_oAba.shp_4c_Transp
7929:             .Top = 7
7930:             .Left = 12
7931:             .Width = 315
7932:             .Height = 119
7933:             .Visible = .T.
7934:         ENDWITH
7935: 
7936:         loc_oAba.AddObject("lbl_4c_LblTransp", "Label")
7937:         WITH loc_oAba.lbl_4c_LblTransp
7938:             .Caption = " Transportador "
7939:             .Top = 10
7940:             .Left = 19
7941:             .FontName = "Tahoma"
7942:             .FontSize = 7
7943:             .BackStyle = 0
7944:             .ForeColor = RGB(90,90,90)
7945:             .AutoSize = .T.
7946:             .Visible = .T.
7947:         ENDWITH
7948: 
7949:         *-- Nome/Razao Social transportador (top=24)
7950:         loc_oAba.AddObject("lbl_4c_LblTrNome", "Label")
7951:         WITH loc_oAba.lbl_4c_LblTrNome
7952:             .Caption = "Nome / Raz" + CHR(227) + "o Social"
7953:             .Top = 24
7954:             .Left = 17
7955:             .FontName = "Tahoma"
7956:             .FontSize = 7
7957:             .BackStyle = 0
7958:             .ForeColor = RGB(90,90,90)
7959:             .AutoSize = .T.
7960:             .Visible = .T.
7961:         ENDWITH
7962: 
7963:         loc_oAba.AddObject("txt_4c_TrNomeL", "TextBox")
7964:         WITH loc_oAba.txt_4c_TrNomeL
7965:             .ControlSource = "crSigCnFNf.ltrnome"
7966:             .Top = 36
7967:             .Left = 17
7968:             .Width = 41
7969:             .Height = 18
7970:             .FontName = "Tahoma"
7971:             .FontSize = 8
7972:             .SpecialEffect = 1
7973:             .Format = "K"
7974:             .InputMask = "999.99"
7975:             .Visible = .T.
7976:         ENDWITH
7977: 
7978:         loc_oAba.AddObject("lbl_4c_TrNomeX", "Label")
7979:         WITH loc_oAba.lbl_4c_TrNomeX
7980:             .Caption = "x"
7981:             .Top = 38
7982:             .Left = 60
7983:             .FontName = "Tahoma"
7984:             .FontSize = 7
7985:             .BackStyle = 0
7986:             .ForeColor = RGB(90,90,90)
7987:             .AutoSize = .T.
7988:             .Visible = .T.
7989:         ENDWITH
7990: 
7991:         loc_oAba.AddObject("txt_4c_TrNomeC", "TextBox")
7992:         WITH loc_oAba.txt_4c_TrNomeC
7993:             .ControlSource = "crSigCnFNf.ctrnome"
7994:             .Top = 36
7995:             .Left = 66
7996:             .Width = 41
7997:             .Height = 18
7998:             .FontName = "Tahoma"
7999:             .FontSize = 8
8000:             .SpecialEffect = 1
8001:             .Format = "K"
8002:             .InputMask = "999.99"
8003:             .Visible = .T.
8004:         ENDWITH
8005: 
8006:         *-- CGC/CPF transportador (top=24)
8007:         loc_oAba.AddObject("lbl_4c_LblTrCgc", "Label")
8008:         WITH loc_oAba.lbl_4c_LblTrCgc
8009:             .Caption = "C.G.C. / C.P.F."
8010:             .Top = 24
8011:             .Left = 128
8012:             .FontName = "Tahoma"
8013:             .FontSize = 7
8014:             .BackStyle = 0
8015:             .ForeColor = RGB(90,90,90)
8016:             .AutoSize = .T.
8017:             .Visible = .T.
8018:         ENDWITH
8019: 
8020:         loc_oAba.AddObject("txt_4c_TrCgcL", "TextBox")
8021:         WITH loc_oAba.txt_4c_TrCgcL
8022:             .ControlSource = "crSigCnFNf.ltrcgc"
8023:             .Top = 36
8024:             .Left = 125
8025:             .Width = 41
8026:             .Height = 18
8027:             .FontName = "Tahoma"
8028:             .FontSize = 8
8029:             .SpecialEffect = 1
8030:             .Format = "K"
8031:             .InputMask = "999.99"
8032:             .Visible = .T.
8033:         ENDWITH
8034: 
8035:         loc_oAba.AddObject("lbl_4c_TrCgcX", "Label")
8036:         WITH loc_oAba.lbl_4c_TrCgcX
8037:             .Caption = "x"
8038:             .Top = 38
8039:             .Left = 168
8040:             .FontName = "Tahoma"
8041:             .FontSize = 7
8042:             .BackStyle = 0
8043:             .ForeColor = RGB(90,90,90)
8044:             .AutoSize = .T.
8045:             .Visible = .T.
8046:         ENDWITH
8047: 
8048:         loc_oAba.AddObject("txt_4c_TrCgcC", "TextBox")
8049:         WITH loc_oAba.txt_4c_TrCgcC
8050:             .ControlSource = "crSigCnFNf.ctrcgc"
8051:             .Top = 36
8052:             .Left = 174
8053:             .Width = 41
8054:             .Height = 18
8055:             .FontName = "Tahoma"
8056:             .FontSize = 8
8057:             .SpecialEffect = 1
8058:             .Format = "K"
8059:             .InputMask = "999.99"
8060:             .Visible = .T.
8061:         ENDWITH
8062: 
8063:         *-- Insc.Estadual transportador (top=24)
8064:         loc_oAba.AddObject("lbl_4c_LblTrIest", "Label")
8065:         WITH loc_oAba.lbl_4c_LblTrIest
8066:             .Caption = "Insc. Estadual"
8067:             .Top = 24
8068:             .Left = 233
8069:             .FontName = "Tahoma"
8070:             .FontSize = 7
8071:             .BackStyle = 0
8072:             .ForeColor = RGB(90,90,90)
8073:             .AutoSize = .T.
8074:             .Visible = .T.
8075:         ENDWITH
8076: 
8077:         loc_oAba.AddObject("txt_4c_TrIestL", "TextBox")
8078:         WITH loc_oAba.txt_4c_TrIestL
8079:             .ControlSource = "crSigCnFNf.ltrie"
8080:             .Top = 36
8081:             .Left = 233
8082:             .Width = 41
8083:             .Height = 18
8084:             .FontName = "Tahoma"
8085:             .FontSize = 8
8086:             .SpecialEffect = 1
8087:             .Format = "K"
8088:             .InputMask = "999.99"
8089:             .Visible = .T.
8090:         ENDWITH
8091: 
8092:         loc_oAba.AddObject("lbl_4c_TrIestX", "Label")
8093:         WITH loc_oAba.lbl_4c_TrIestX
8094:             .Caption = "x"
8095:             .Top = 38
8096:             .Left = 276
8097:             .FontName = "Tahoma"
8098:             .FontSize = 7
8099:             .BackStyle = 0
8100:             .ForeColor = RGB(90,90,90)
8101:             .AutoSize = .T.
8102:             .Visible = .T.
8103:         ENDWITH
8104: 
8105:         loc_oAba.AddObject("txt_4c_TrIestC", "TextBox")
8106:         WITH loc_oAba.txt_4c_TrIestC
8107:             .ControlSource = "crSigCnFNf.ctrie"
8108:             .Top = 36
8109:             .Left = 282
8110:             .Width = 41
8111:             .Height = 18
8112:             .FontName = "Tahoma"
8113:             .FontSize = 8
8114:             .SpecialEffect = 1
8115:             .Format = "K"
8116:             .InputMask = "999.99"
8117:             .Visible = .T.
8118:         ENDWITH
8119: 
8120:         *-- Endereco transportador (top=57)
8121:         loc_oAba.AddObject("lbl_4c_LblTrEnder", "Label")
8122:         WITH loc_oAba.lbl_4c_LblTrEnder
8123:             .Caption = "Endere" + CHR(231) + "o"
8124:             .Top = 57
8125:             .Left = 17
8126:             .FontName = "Tahoma"
8127:             .FontSize = 7
8128:             .BackStyle = 0
8129:             .ForeColor = RGB(90,90,90)
8130:             .AutoSize = .T.
8131:             .Visible = .T.
8132:         ENDWITH
8133: 
8134:         loc_oAba.AddObject("txt_4c_TrEnderL", "TextBox")
8135:         WITH loc_oAba.txt_4c_TrEnderL
8136:             .ControlSource = "crSigCnFNf.ltrend"
8137:             .Top = 69
8138:             .Left = 17
8139:             .Width = 41
8140:             .Height = 18
8141:             .FontName = "Tahoma"
8142:             .FontSize = 8
8143:             .SpecialEffect = 1
8144:             .Format = "K"
8145:             .InputMask = "999.99"
8146:             .Visible = .T.
8147:         ENDWITH
8148: 
8149:         loc_oAba.AddObject("lbl_4c_TrEnderX", "Label")
8150:         WITH loc_oAba.lbl_4c_TrEnderX
8151:             .Caption = "x"
8152:             .Top = 71
8153:             .Left = 60
8154:             .FontName = "Tahoma"
8155:             .FontSize = 7
8156:             .BackStyle = 0
8157:             .ForeColor = RGB(90,90,90)
8158:             .AutoSize = .T.
8159:             .Visible = .T.
8160:         ENDWITH
8161: 
8162:         loc_oAba.AddObject("txt_4c_TrEnderC", "TextBox")
8163:         WITH loc_oAba.txt_4c_TrEnderC
8164:             .ControlSource = "crSigCnFNf.ctrend"
8165:             .Top = 69
8166:             .Left = 66
8167:             .Width = 41
8168:             .Height = 18
8169:             .FontName = "Tahoma"
8170:             .FontSize = 8
8171:             .SpecialEffect = 1
8172:             .Format = "K"
8173:             .InputMask = "999.99"
8174:             .Visible = .T.
8175:         ENDWITH
8176: 
8177:         *-- Municipio transportador (top=57)
8178:         loc_oAba.AddObject("lbl_4c_LblTrMuni", "Label")
8179:         WITH loc_oAba.lbl_4c_LblTrMuni
8180:             .Caption = "Munic" + CHR(237) + "pio"
8181:             .Top = 57
8182:             .Left = 124
8183:             .FontName = "Tahoma"
8184:             .FontSize = 7
8185:             .BackStyle = 0
8186:             .ForeColor = RGB(90,90,90)
8187:             .AutoSize = .T.
8188:             .Visible = .T.
8189:         ENDWITH
8190: 
8191:         loc_oAba.AddObject("txt_4c_TrMuniL", "TextBox")
8192:         WITH loc_oAba.txt_4c_TrMuniL
8193:             .ControlSource = "crSigCnFNf.ltrmun"
8194:             .Top = 69
8195:             .Left = 124
8196:             .Width = 41
8197:             .Height = 18
8198:             .FontName = "Tahoma"
8199:             .FontSize = 8
8200:             .SpecialEffect = 1
8201:             .Format = "K"
8202:             .InputMask = "999.99"
8203:             .Visible = .T.
8204:         ENDWITH
8205: 
8206:         loc_oAba.AddObject("lbl_4c_TrMuniX", "Label")
8207:         WITH loc_oAba.lbl_4c_TrMuniX
8208:             .Caption = "x"
8209:             .Top = 71
8210:             .Left = 167
8211:             .FontName = "Tahoma"
8212:             .FontSize = 7
8213:             .BackStyle = 0
8214:             .ForeColor = RGB(90,90,90)
8215:             .AutoSize = .T.
8216:             .Visible = .T.
8217:         ENDWITH
8218: 
8219:         loc_oAba.AddObject("txt_4c_TrMuniC", "TextBox")
8220:         WITH loc_oAba.txt_4c_TrMuniC
8221:             .ControlSource = "crSigCnFNf.ctrmun"
8222:             .Top = 69
8223:             .Left = 173
8224:             .Width = 41
8225:             .Height = 18
8226:             .FontName = "Tahoma"
8227:             .FontSize = 8
8228:             .SpecialEffect = 1
8229:             .Format = "K"
8230:             .InputMask = "999.99"
8231:             .Visible = .T.
8232:         ENDWITH
8233: 
8234:         *-- Estado transportador (top=57)
8235:         loc_oAba.AddObject("lbl_4c_LblTrEst", "Label")
8236:         WITH loc_oAba.lbl_4c_LblTrEst
8237:             .Caption = "Estado"
8238:             .Top = 57
8239:             .Left = 232
8240:             .FontName = "Tahoma"
8241:             .FontSize = 7
8242:             .BackStyle = 0
8243:             .ForeColor = RGB(90,90,90)
8244:             .AutoSize = .T.
8245:             .Visible = .T.
8246:         ENDWITH
8247: 
8248:         loc_oAba.AddObject("txt_4c_TrEstL", "TextBox")
8249:         WITH loc_oAba.txt_4c_TrEstL
8250:             .ControlSource = "crSigCnFNf.ltrest"
8251:             .Top = 69
8252:             .Left = 232
8253:             .Width = 41
8254:             .Height = 18
8255:             .FontName = "Tahoma"
8256:             .FontSize = 8
8257:             .SpecialEffect = 1
8258:             .Format = "K"
8259:             .InputMask = "999.99"
8260:             .Visible = .T.
8261:         ENDWITH
8262: 
8263:         loc_oAba.AddObject("lbl_4c_TrEstX", "Label")
8264:         WITH loc_oAba.lbl_4c_TrEstX
8265:             .Caption = "x"
8266:             .Top = 71
8267:             .Left = 275
8268:             .FontName = "Tahoma"
8269:             .FontSize = 7
8270:             .BackStyle = 0
8271:             .ForeColor = RGB(90,90,90)
8272:             .AutoSize = .T.
8273:             .Visible = .T.
8274:         ENDWITH
8275: 
8276:         loc_oAba.AddObject("txt_4c_TrEstC", "TextBox")
8277:         WITH loc_oAba.txt_4c_TrEstC
8278:             .ControlSource = "crSigCnFNf.ctrest"
8279:             .Top = 69
8280:             .Left = 281
8281:             .Width = 41
8282:             .Height = 18
8283:             .FontName = "Tahoma"
8284:             .FontSize = 8
8285:             .SpecialEffect = 1
8286:             .Format = "K"
8287:             .InputMask = "999.99"
8288:             .Visible = .T.
8289:         ENDWITH
8290: 
8291:         *-- Tipo de Frete (top=91)
8292:         loc_oAba.AddObject("lbl_4c_LblTpFret", "Label")
8293:         WITH loc_oAba.lbl_4c_LblTpFret
8294:             .Caption = "Tipo de Frete"
8295:             .Top = 91
8296:             .Left = 17
8297:             .FontName = "Tahoma"
8298:             .FontSize = 7
8299:             .BackStyle = 0
8300:             .ForeColor = RGB(90,90,90)
8301:             .AutoSize = .T.
8302:             .Visible = .T.
8303:         ENDWITH
8304: 
8305:         loc_oAba.AddObject("txt_4c_TpFretL", "TextBox")
8306:         WITH loc_oAba.txt_4c_TpFretL
8307:             .ControlSource = "crSigCnFNf.ltpfrete"
8308:             .Top = 103
8309:             .Left = 17
8310:             .Width = 41
8311:             .Height = 18
8312:             .FontName = "Tahoma"
8313:             .FontSize = 8
8314:             .SpecialEffect = 1
8315:             .Format = "K"
8316:             .InputMask = "999.99"
8317:             .Visible = .T.
8318:         ENDWITH
8319: 
8320:         loc_oAba.AddObject("lbl_4c_TpFretX", "Label")
8321:         WITH loc_oAba.lbl_4c_TpFretX
8322:             .Caption = "x"
8323:             .Top = 105
8324:             .Left = 60
8325:             .FontName = "Tahoma"
8326:             .FontSize = 7
8327:             .BackStyle = 0
8328:             .ForeColor = RGB(90,90,90)
8329:             .AutoSize = .T.
8330:             .Visible = .T.
8331:         ENDWITH
8332: 
8333:         loc_oAba.AddObject("txt_4c_TpFretC", "TextBox")
8334:         WITH loc_oAba.txt_4c_TpFretC
8335:             .ControlSource = "crSigCnFNf.ctpfrete"
8336:             .Top = 103
8337:             .Left = 66
8338:             .Width = 41
8339:             .Height = 18
8340:             .FontName = "Tahoma"
8341:             .FontSize = 8
8342:             .SpecialEffect = 1
8343:             .Format = "K"
8344:             .InputMask = "999.99"
8345:             .Visible = .T.
8346:         ENDWITH
8347: 
8348:         *-- Placa do Veiculo (top=91)
8349:         loc_oAba.AddObject("lbl_4c_LblPlaca", "Label")
8350:         WITH loc_oAba.lbl_4c_LblPlaca
8351:             .Caption = "Placa do Ve" + CHR(237) + "culo"
8352:             .Top = 91
8353:             .Left = 124
8354:             .FontName = "Tahoma"
8355:             .FontSize = 7
8356:             .BackStyle = 0
8357:             .ForeColor = RGB(90,90,90)
8358:             .AutoSize = .T.
8359:             .Visible = .T.
8360:         ENDWITH
8361: 
8362:         loc_oAba.AddObject("txt_4c_PlacaL", "TextBox")
8363:         WITH loc_oAba.txt_4c_PlacaL
8364:             .ControlSource = "crSigCnFNf.lplaca"
8365:             .Top = 103
8366:             .Left = 124
8367:             .Width = 41
8368:             .Height = 18
8369:             .FontName = "Tahoma"
8370:             .FontSize = 8
8371:             .SpecialEffect = 1
8372:             .Format = "K"
8373:             .InputMask = "999.99"
8374:             .Visible = .T.
8375:         ENDWITH
8376: 
8377:         loc_oAba.AddObject("lbl_4c_PlacaX", "Label")
8378:         WITH loc_oAba.lbl_4c_PlacaX
8379:             .Caption = "x"
8380:             .Top = 105
8381:             .Left = 167
8382:             .FontName = "Tahoma"
8383:             .FontSize = 7
8384:             .BackStyle = 0
8385:             .ForeColor = RGB(90,90,90)
8386:             .AutoSize = .T.
8387:             .Visible = .T.
8388:         ENDWITH
8389: 
8390:         loc_oAba.AddObject("txt_4c_PlacaC", "TextBox")
8391:         WITH loc_oAba.txt_4c_PlacaC
8392:             .ControlSource = "crSigCnFNf.cplaca"
8393:             .Top = 103
8394:             .Left = 173
8395:             .Width = 41
8396:             .Height = 18
8397:             .FontName = "Tahoma"
8398:             .FontSize = 8
8399:             .SpecialEffect = 1
8400:             .Format = "K"
8401:             .InputMask = "999.99"
8402:             .Visible = .T.
8403:         ENDWITH
8404: 
8405:         *-- Estado do Veiculo (top=91)
8406:         loc_oAba.AddObject("lbl_4c_LblEstVeic", "Label")
8407:         WITH loc_oAba.lbl_4c_LblEstVeic
8408:             .Caption = "Estado do Ve" + CHR(237) + "culo"
8409:             .Top = 91
8410:             .Left = 232
8411:             .FontName = "Tahoma"
8412:             .FontSize = 7
8413:             .BackStyle = 0
8414:             .ForeColor = RGB(90,90,90)
8415:             .AutoSize = .T.
8416:             .Visible = .T.
8417:         ENDWITH
8418: 
8419:         loc_oAba.AddObject("txt_4c_EstVeicL", "TextBox")
8420:         WITH loc_oAba.txt_4c_EstVeicL
8421:             .ControlSource = "crSigCnFNf.lplacauf"
8422:             .Top = 103
8423:             .Left = 232
8424:             .Width = 41
8425:             .Height = 18
8426:             .FontName = "Tahoma"
8427:             .FontSize = 8
8428:             .SpecialEffect = 1
8429:             .Format = "K"
8430:             .InputMask = "999.99"
8431:             .Visible = .T.
8432:         ENDWITH
8433: 
8434:         loc_oAba.AddObject("lbl_4c_EstVeicX", "Label")
8435:         WITH loc_oAba.lbl_4c_EstVeicX
8436:             .Caption = "x"
8437:             .Top = 105
8438:             .Left = 275
8439:             .FontName = "Tahoma"
8440:             .FontSize = 7
8441:             .BackStyle = 0
8442:             .ForeColor = RGB(90,90,90)
8443:             .AutoSize = .T.
8444:             .Visible = .T.
8445:         ENDWITH
8446: 
8447:         loc_oAba.AddObject("txt_4c_EstVeicC", "TextBox")
8448:         WITH loc_oAba.txt_4c_EstVeicC
8449:             .ControlSource = "crSigCnFNf.cplacauf"
8450:             .Top = 103
8451:             .Left = 281
8452:             .Width = 41
8453:             .Height = 18
8454:             .FontName = "Tahoma"
8455:             .FontSize = 8
8456:             .SpecialEffect = 1

*-- Linhas 8462 a 8850:
8462:         *-- Shape Volumes Transportados (top=132)
8463:         loc_oAba.AddObject("shp_4c_Vols", "Shape")
8464:         WITH loc_oAba.shp_4c_Vols
8465:             .Top = 132
8466:             .Left = 12
8467:             .Width = 315
8468:             .Height = 114
8469:             .Visible = .T.
8470:         ENDWITH
8471: 
8472:         loc_oAba.AddObject("lbl_4c_LblVols", "Label")
8473:         WITH loc_oAba.lbl_4c_LblVols
8474:             .Caption = " Volumes Transportados "
8475:             .Top = 136
8476:             .Left = 19
8477:             .FontName = "Tahoma"
8478:             .FontSize = 7
8479:             .BackStyle = 0
8480:             .ForeColor = RGB(90,90,90)
8481:             .AutoSize = .T.
8482:             .Visible = .T.
8483:         ENDWITH
8484: 
8485:         *-- Quantidade (top=149)
8486:         loc_oAba.AddObject("lbl_4c_LblQtVol", "Label")
8487:         WITH loc_oAba.lbl_4c_LblQtVol
8488:             .Caption = "Quantidade"
8489:             .Top = 149
8490:             .Left = 17
8491:             .FontName = "Tahoma"
8492:             .FontSize = 7
8493:             .BackStyle = 0
8494:             .ForeColor = RGB(90,90,90)
8495:             .AutoSize = .T.
8496:             .Visible = .T.
8497:         ENDWITH
8498: 
8499:         loc_oAba.AddObject("txt_4c_QtVolL", "TextBox")
8500:         WITH loc_oAba.txt_4c_QtVolL
8501:             .ControlSource = "crSigCnFNf.lqtvol"
8502:             .Top = 161
8503:             .Left = 17
8504:             .Width = 41
8505:             .Height = 18
8506:             .FontName = "Tahoma"
8507:             .FontSize = 8
8508:             .SpecialEffect = 1
8509:             .Format = "K"
8510:             .InputMask = "999.99"
8511:             .Visible = .T.
8512:         ENDWITH
8513: 
8514:         loc_oAba.AddObject("lbl_4c_QtVolX", "Label")
8515:         WITH loc_oAba.lbl_4c_QtVolX
8516:             .Caption = "x"
8517:             .Top = 163
8518:             .Left = 60
8519:             .FontName = "Tahoma"
8520:             .FontSize = 7
8521:             .BackStyle = 0
8522:             .ForeColor = RGB(90,90,90)
8523:             .AutoSize = .T.
8524:             .Visible = .T.
8525:         ENDWITH
8526: 
8527:         loc_oAba.AddObject("txt_4c_QtVolC", "TextBox")
8528:         WITH loc_oAba.txt_4c_QtVolC
8529:             .ControlSource = "crSigCnFNf.cqtvol"
8530:             .Top = 161
8531:             .Left = 66
8532:             .Width = 41
8533:             .Height = 18
8534:             .FontName = "Tahoma"
8535:             .FontSize = 8
8536:             .SpecialEffect = 1
8537:             .Format = "K"
8538:             .InputMask = "999.99"
8539:             .Visible = .T.
8540:         ENDWITH
8541: 
8542:         *-- Especie (top=149)
8543:         loc_oAba.AddObject("lbl_4c_LblEsp", "Label")
8544:         WITH loc_oAba.lbl_4c_LblEsp
8545:             .Caption = "Esp" + CHR(233) + "cie"
8546:             .Top = 149
8547:             .Left = 124
8548:             .FontName = "Tahoma"
8549:             .FontSize = 7
8550:             .BackStyle = 0
8551:             .ForeColor = RGB(90,90,90)
8552:             .AutoSize = .T.
8553:             .Visible = .T.
8554:         ENDWITH
8555: 
8556:         loc_oAba.AddObject("txt_4c_EspL", "TextBox")
8557:         WITH loc_oAba.txt_4c_EspL
8558:             .ControlSource = "crSigCnFNf.lesp"
8559:             .Top = 161
8560:             .Left = 124
8561:             .Width = 41
8562:             .Height = 18
8563:             .FontName = "Tahoma"
8564:             .FontSize = 8
8565:             .SpecialEffect = 1
8566:             .Format = "K"
8567:             .InputMask = "999.99"
8568:             .Visible = .T.
8569:         ENDWITH
8570: 
8571:         loc_oAba.AddObject("lbl_4c_EspX", "Label")
8572:         WITH loc_oAba.lbl_4c_EspX
8573:             .Caption = "x"
8574:             .Top = 163
8575:             .Left = 167
8576:             .FontName = "Tahoma"
8577:             .FontSize = 7
8578:             .BackStyle = 0
8579:             .ForeColor = RGB(90,90,90)
8580:             .AutoSize = .T.
8581:             .Visible = .T.
8582:         ENDWITH
8583: 
8584:         loc_oAba.AddObject("txt_4c_EspC", "TextBox")
8585:         WITH loc_oAba.txt_4c_EspC
8586:             .ControlSource = "crSigCnFNf.cesp"
8587:             .Top = 161
8588:             .Left = 173
8589:             .Width = 41
8590:             .Height = 18
8591:             .FontName = "Tahoma"
8592:             .FontSize = 8
8593:             .SpecialEffect = 1
8594:             .Format = "K"
8595:             .InputMask = "999.99"
8596:             .Visible = .T.
8597:         ENDWITH
8598: 
8599:         *-- Marca (top=149)
8600:         loc_oAba.AddObject("lbl_4c_LblMarca", "Label")
8601:         WITH loc_oAba.lbl_4c_LblMarca
8602:             .Caption = "Marca"
8603:             .Top = 149
8604:             .Left = 232
8605:             .FontName = "Tahoma"
8606:             .FontSize = 7
8607:             .BackStyle = 0
8608:             .ForeColor = RGB(90,90,90)
8609:             .AutoSize = .T.
8610:             .Visible = .T.
8611:         ENDWITH
8612: 
8613:         loc_oAba.AddObject("txt_4c_MarcaL", "TextBox")
8614:         WITH loc_oAba.txt_4c_MarcaL
8615:             .ControlSource = "crSigCnFNf.lmarca"
8616:             .Top = 161
8617:             .Left = 232
8618:             .Width = 41
8619:             .Height = 18
8620:             .FontName = "Tahoma"
8621:             .FontSize = 8
8622:             .SpecialEffect = 1
8623:             .Format = "K"
8624:             .InputMask = "999.99"
8625:             .Visible = .T.
8626:         ENDWITH
8627: 
8628:         loc_oAba.AddObject("lbl_4c_MarcaX", "Label")
8629:         WITH loc_oAba.lbl_4c_MarcaX
8630:             .Caption = "x"
8631:             .Top = 163
8632:             .Left = 275
8633:             .FontName = "Tahoma"
8634:             .FontSize = 7
8635:             .BackStyle = 0
8636:             .ForeColor = RGB(90,90,90)
8637:             .AutoSize = .T.
8638:             .Visible = .T.
8639:         ENDWITH
8640: 
8641:         loc_oAba.AddObject("txt_4c_MarcaC", "TextBox")
8642:         WITH loc_oAba.txt_4c_MarcaC
8643:             .ControlSource = "crSigCnFNf.cmarca"
8644:             .Top = 161
8645:             .Left = 281
8646:             .Width = 41
8647:             .Height = 18
8648:             .FontName = "Tahoma"
8649:             .FontSize = 8
8650:             .SpecialEffect = 1
8651:             .Format = "K"
8652:             .InputMask = "999.99"
8653:             .Visible = .T.
8654:         ENDWITH
8655: 
8656:         *-- Numero (top=183)
8657:         loc_oAba.AddObject("lbl_4c_LblNumVol", "Label")
8658:         WITH loc_oAba.lbl_4c_LblNumVol
8659:             .Caption = "N" + CHR(250) + "mero"
8660:             .Top = 183
8661:             .Left = 17
8662:             .FontName = "Tahoma"
8663:             .FontSize = 7
8664:             .BackStyle = 0
8665:             .ForeColor = RGB(90,90,90)
8666:             .AutoSize = .T.
8667:             .Visible = .T.
8668:         ENDWITH
8669: 
8670:         loc_oAba.AddObject("txt_4c_NumVolL", "TextBox")
8671:         WITH loc_oAba.txt_4c_NumVolL
8672:             .ControlSource = "crSigCnFNf.lnumero"
8673:             .Top = 195
8674:             .Left = 17
8675:             .Width = 41
8676:             .Height = 18
8677:             .FontName = "Tahoma"
8678:             .FontSize = 8
8679:             .SpecialEffect = 1
8680:             .Format = "K"
8681:             .InputMask = "999.99"
8682:             .Visible = .T.
8683:         ENDWITH
8684: 
8685:         loc_oAba.AddObject("lbl_4c_NumVolX", "Label")
8686:         WITH loc_oAba.lbl_4c_NumVolX
8687:             .Caption = "x"
8688:             .Top = 197
8689:             .Left = 60
8690:             .FontName = "Tahoma"
8691:             .FontSize = 7
8692:             .BackStyle = 0
8693:             .ForeColor = RGB(90,90,90)
8694:             .AutoSize = .T.
8695:             .Visible = .T.
8696:         ENDWITH
8697: 
8698:         loc_oAba.AddObject("txt_4c_NumVolC", "TextBox")
8699:         WITH loc_oAba.txt_4c_NumVolC
8700:             .ControlSource = "crSigCnFNf.cnumero"
8701:             .Top = 195
8702:             .Left = 66
8703:             .Width = 41
8704:             .Height = 18
8705:             .FontName = "Tahoma"
8706:             .FontSize = 8
8707:             .SpecialEffect = 1
8708:             .Format = "K"
8709:             .InputMask = "999.99"
8710:             .Visible = .T.
8711:         ENDWITH
8712: 
8713:         *-- Peso Bruto (top=183)
8714:         loc_oAba.AddObject("lbl_4c_LblPBru", "Label")
8715:         WITH loc_oAba.lbl_4c_LblPBru
8716:             .Caption = "Peso Bruto"
8717:             .Top = 183
8718:             .Left = 124
8719:             .FontName = "Tahoma"
8720:             .FontSize = 7
8721:             .BackStyle = 0
8722:             .ForeColor = RGB(90,90,90)
8723:             .AutoSize = .T.
8724:             .Visible = .T.
8725:         ENDWITH
8726: 
8727:         loc_oAba.AddObject("txt_4c_PBruL", "TextBox")
8728:         WITH loc_oAba.txt_4c_PBruL
8729:             .ControlSource = "crSigCnFNf.lpbru"
8730:             .Top = 195
8731:             .Left = 124
8732:             .Width = 41
8733:             .Height = 18
8734:             .FontName = "Tahoma"
8735:             .FontSize = 8
8736:             .SpecialEffect = 1
8737:             .Format = "K"
8738:             .InputMask = "999.99"
8739:             .Visible = .T.
8740:         ENDWITH
8741: 
8742:         loc_oAba.AddObject("lbl_4c_PBruX", "Label")
8743:         WITH loc_oAba.lbl_4c_PBruX
8744:             .Caption = "x"
8745:             .Top = 197
8746:             .Left = 167
8747:             .FontName = "Tahoma"
8748:             .FontSize = 7
8749:             .BackStyle = 0
8750:             .ForeColor = RGB(90,90,90)
8751:             .AutoSize = .T.
8752:             .Visible = .T.
8753:         ENDWITH
8754: 
8755:         loc_oAba.AddObject("txt_4c_PBruC", "TextBox")
8756:         WITH loc_oAba.txt_4c_PBruC
8757:             .ControlSource = "crSigCnFNf.cpbru"
8758:             .Top = 195
8759:             .Left = 173
8760:             .Width = 41
8761:             .Height = 18
8762:             .FontName = "Tahoma"
8763:             .FontSize = 8
8764:             .SpecialEffect = 1
8765:             .Format = "K"
8766:             .InputMask = "999.99"
8767:             .Visible = .T.
8768:         ENDWITH
8769: 
8770:         *-- Peso Liquido (top=183)
8771:         loc_oAba.AddObject("lbl_4c_LblPLiq", "Label")
8772:         WITH loc_oAba.lbl_4c_LblPLiq
8773:             .Caption = "Peso L" + CHR(237) + "quido"
8774:             .Top = 183
8775:             .Left = 232
8776:             .FontName = "Tahoma"
8777:             .FontSize = 7
8778:             .BackStyle = 0
8779:             .ForeColor = RGB(90,90,90)
8780:             .AutoSize = .T.
8781:             .Visible = .T.
8782:         ENDWITH
8783: 
8784:         loc_oAba.AddObject("txt_4c_PLiqL", "TextBox")
8785:         WITH loc_oAba.txt_4c_PLiqL
8786:             .ControlSource = "crSigCnFNf.lpliq"
8787:             .Top = 195
8788:             .Left = 232
8789:             .Width = 41
8790:             .Height = 18
8791:             .FontName = "Tahoma"
8792:             .FontSize = 8
8793:             .SpecialEffect = 1
8794:             .Format = "K"
8795:             .InputMask = "999.99"
8796:             .Visible = .T.
8797:         ENDWITH
8798: 
8799:         loc_oAba.AddObject("lbl_4c_PLiqX", "Label")
8800:         WITH loc_oAba.lbl_4c_PLiqX
8801:             .Caption = "x"
8802:             .Top = 197
8803:             .Left = 275
8804:             .FontName = "Tahoma"
8805:             .FontSize = 7
8806:             .BackStyle = 0
8807:             .ForeColor = RGB(90,90,90)
8808:             .AutoSize = .T.
8809:             .Visible = .T.
8810:         ENDWITH
8811: 
8812:         loc_oAba.AddObject("txt_4c_PLiqC", "TextBox")
8813:         WITH loc_oAba.txt_4c_PLiqC
8814:             .ControlSource = "crSigCnFNf.cpliq"
8815:             .Top = 195
8816:             .Left = 281
8817:             .Width = 41
8818:             .Height = 18
8819:             .FontName = "Tahoma"
8820:             .FontSize = 8
8821:             .SpecialEffect = 1
8822:             .Format = "K"
8823:             .InputMask = "999.99"
8824:             .Visible = .T.
8825:         ENDWITH
8826: 
8827:         *-- Un Pesos (top=221)
8828:         loc_oAba.AddObject("lbl_4c_LblUnPesos", "Label")
8829:         WITH loc_oAba.lbl_4c_LblUnPesos
8830:             .Caption = "Un Pesos"
8831:             .Top = 221
8832:             .Left = 19
8833:             .FontName = "Tahoma"
8834:             .FontSize = 7
8835:             .BackStyle = 0
8836:             .ForeColor = RGB(90,90,90)
8837:             .AutoSize = .T.
8838:             .Visible = .T.
8839:         ENDWITH
8840: 
8841:         loc_oAba.AddObject("txt_4c_UnPesos", "TextBox")
8842:         WITH loc_oAba.txt_4c_UnPesos
8843:             .ControlSource = "crSigCnFNf.pesovols"
8844:             .Top = 219
8845:             .Left = 66
8846:             .Width = 41
8847:             .Height = 18
8848:             .FontName = "Tahoma"
8849:             .FontSize = 8
8850:             .SpecialEffect = 1

*-- Linhas 8860 a 8966:
8860:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page7
8861: 
8862:         *-- Classificacao Fiscal header (top=21)
8863:         loc_oAba.AddObject("lbl_4c_LblClsFis", "Label")
8864:         WITH loc_oAba.lbl_4c_LblClsFis
8865:             .Caption   = "Class. Fiscal : "
8866:             .Top       = 21
8867:             .Left      = 38
8868:             .FontName  = "Tahoma"
8869:             .FontSize  = 7
8870:             .BackStyle = 0
8871:             .ForeColor = RGB(90, 90, 90)
8872:             .AutoSize  = .T.
8873:             .Visible   = .T.
8874:         ENDWITH
8875: 
8876:         *-- OptionGroup para classificacao fiscal (top=22)
8877:         loc_oAba.AddObject("obj_4c_ClsFisTp", "OptionGroup")
8878:         WITH loc_oAba.obj_4c_ClsFisTp
8879:             .Top         = 22
8880:             .Left        = 115
8881:             .Width       = 149
8882:             .Height      = 19
8883:             .BackStyle   = 0
8884:             .BorderStyle = 0
8885:             .Value       = 1
8886:             .Visible     = .T.
8887:             WITH .Buttons(1)
8888:                 .Caption = "Impressa"
8889:                 .Left    = 2
8890:                 .Top = 2
8891:                 .AutoSize = .T.
8892:                 .BackStyle = 0
8893:                 .ForeColor = RGB(90,90,90)
8894:             ENDWITH
8895:             WITH .Buttons(2)
8896:                 .Caption = "Calculada"
8897:                 .Left    = 60
8898:                 .Top = 2
8899:                 .AutoSize = .T.
8900:                 .BackStyle = 0
8901:                 .FontName = "Tahoma"
8902:                 .FontSize = 7
8903:                 .ForeColor = RGB(90,90,90)
8904:             ENDWITH
8905:         ENDWITH
8906: 
8907:         *-- Shape bloco Codigos 1-7 (top=39, left=17)
8908:         loc_oAba.AddObject("shp_4c_CodBl1", "Shape")
8909:         WITH loc_oAba.shp_4c_CodBl1
8910:             .Top = 39
8911:             .Left = 17
8912:             .Width = 345
8913:             .Height = 155
8914:             .Visible = .T.
8915:         ENDWITH
8916: 
8917:         *-- Cabecalhos do bloco 1-7
8918:         loc_oAba.AddObject("lbl_4c_LblClsFis2", "Label")
8919:         WITH loc_oAba.lbl_4c_LblClsFis2
8920:             .Caption = "Class. Fiscal"
8921:             .Top = 42
8922:             .Left = 94
8923:             .FontName = "Tahoma"
8924:             .FontSize = 7
8925:             .BackStyle = 0
8926:             .ForeColor = RGB(90,90,90)
8927:             .AutoSize = .T.
8928:             .Visible = .T.
8929:         ENDWITH
8930: 
8931:         loc_oAba.AddObject("lbl_4c_LblCodImp", "Label")
8932:         WITH loc_oAba.lbl_4c_LblCodImp
8933:             .Caption = "C" + CHR(243) + "digo Impresso"
8934:             .Top = 41
8935:             .Left = 222
8936:             .FontName = "Tahoma"
8937:             .FontSize = 7
8938:             .BackStyle = 0
8939:             .ForeColor = RGB(90,90,90)
8940:             .AutoSize = .T.
8941:             .Visible = .T.
8942:         ENDWITH
8943: 
8944:         loc_oAba.AddObject("lbl_4c_LblImpDir", "Label")
8945:         WITH loc_oAba.lbl_4c_LblImpDir
8946:             .Caption = "Imprimir"
8947:             .Top = 41
8948:             .Left = 314
8949:             .FontName = "Tahoma"
8950:             .FontSize = 7
8951:             .BackStyle = 0
8952:             .ForeColor = RGB(90,90,90)
8953:             .AutoSize = .T.
8954:             .Visible = .T.
8955:         ENDWITH
8956: 
8957:         loc_oAba.AddObject("lbl_4c_LblAngulo1", "Label")
8958:         WITH loc_oAba.lbl_4c_LblAngulo1
8959:             .Caption = CHR(226) + "ngulo"
8960:             .Top = 42
8961:             .Left = 177
8962:             .FontName = "Tahoma"
8963:             .FontSize = 7
8964:             .BackStyle = 0
8965:             .ForeColor = RGB(90,90,90)
8966:             .AutoSize = .T.

*-- Linhas 8974 a 9071:
8974:         FOR loc_nTop = 54 TO 168 STEP 19
8975:                         loc_cFat = ALLTRIM(STR(loc_nFat))
8976: 
8977:             loc_oAba.AddObject("lbl_4c_Cod" + loc_cFat, "Label")
8978:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
8979:                 .Caption = "C" + CHR(243) + "digo " + loc_cFat
8980:                 .Top = loc_nTop + 2
8981:                 .Left = 39
8982:                 .FontName = "Tahoma"
8983:                 .FontSize = 7
8984:                 .BackStyle = 0
8985:                 .ForeColor = RGB(90,90,90)
8986:                 .AutoSize = .T.
8987:                 .Visible = .T.
8988:             ENDWITH
8989: 
8990:             loc_oAba.AddObject("txt_4c_ClsL" + loc_cFat, "TextBox")
8991:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
8992:                 .ControlSource = "crSigCnFNf.lclas" + loc_cFat
8993:                 .Top = loc_nTop
8994:                 .Left = 80
8995:                 .Width = 41
8996:                 .Height = 18
8997:                 .FontName = "Tahoma"
8998:                 .FontSize = 8
8999:                 .SpecialEffect = 1
9000:                 .Format = "K"
9001:                 .InputMask = "999.99"
9002:                 .Visible = .T.
9003:             ENDWITH
9004: 
9005:             loc_oAba.AddObject("lbl_4c_ClsX" + loc_cFat, "Label")
9006:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9007:                 .Caption = "x"
9008:                 .Top = loc_nTop + 2
9009:                 .Left = 123
9010:                 .FontName = "Tahoma"
9011:                 .FontSize = 7
9012:                 .BackStyle = 0
9013:                 .ForeColor = RGB(90,90,90)
9014:                 .AutoSize = .T.
9015:                 .Visible = .T.
9016:             ENDWITH
9017: 
9018:             loc_oAba.AddObject("txt_4c_ClsC" + loc_cFat, "TextBox")
9019:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9020:                 .ControlSource = "crSigCnFNf.cclas" + loc_cFat
9021:                 .Top = loc_nTop
9022:                 .Left = 129
9023:                 .Width = 41
9024:                 .Height = 18
9025:                 .FontName = "Tahoma"
9026:                 .FontSize = 8
9027:                 .SpecialEffect = 1
9028:                 .Format = "K"
9029:                 .InputMask = "999.99"
9030:                 .Visible = .T.
9031:             ENDWITH
9032: 
9033:             loc_oAba.AddObject("cbo_4c_Ang" + loc_cFat, "ComboBox")
9034:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9035:                 .Top = loc_nTop
9036:                 .Left = 172
9037:                 .Width = 46
9038:                 .Height = 18
9039:                 .FontName = "Tahoma"
9040:                 .FontSize = 8
9041:                 .Visible = .T.
9042:                 .RowSourceType = 1
9043:                 .RowSource = "0,90,180,270"
9044:             ENDWITH
9045: 
9046:             loc_oAba.AddObject("txt_4c_CodImp" + loc_cFat, "TextBox")
9047:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9048:                 .ControlSource = "crSigCnFNf.impclas" + loc_cFat
9049:                 .Top = loc_nTop
9050:                 .Left = 221
9051:                 .Width = 100
9052:                 .Height = 18
9053:                 .FontName = "Tahoma"
9054:                 .FontSize = 8
9055:                 .SpecialEffect = 1
9056:                 .Format = "K"
9057:                 .InputMask = ""
9058:                 .Visible = .T.
9059:             ENDWITH
9060: 
9061:             loc_oAba.AddObject("chk_4c_Imp" + loc_cFat, "CheckBox")
9062:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9063:                 .ControlSource = "crSigCnFNf.impc" + loc_cFat
9064:                 .Caption = ""
9065:                 .Top = loc_nTop
9066:                 .Left = 329
9067:                 .Width = 19
9068:                 .Height = 16
9069:                 .FontName = "Tahoma"
9070:                 .FontSize = 7
9071:                 .Visible = .T.

*-- Linhas 9080 a 9138:
9080:         *-- Shape bloco Codigos 8-12 (top=39, left=374)
9081:         loc_oAba.AddObject("shp_4c_CodBl2", "Shape")
9082:         WITH loc_oAba.shp_4c_CodBl2
9083:             .Top = 39
9084:             .Left = 374
9085:             .Width = 345
9086:             .Height = 155
9087:             .Visible = .T.
9088:         ENDWITH
9089: 
9090:         loc_oAba.AddObject("lbl_4c_LblClsFis3", "Label")
9091:         WITH loc_oAba.lbl_4c_LblClsFis3
9092:             .Caption = "Class. Fiscal"
9093:             .Top = 42
9094:             .Left = 448
9095:             .FontName = "Tahoma"
9096:             .FontSize = 7
9097:             .BackStyle = 0
9098:             .ForeColor = RGB(90,90,90)
9099:             .AutoSize = .T.
9100:             .Visible = .T.
9101:         ENDWITH
9102: 
9103:         loc_oAba.AddObject("lbl_4c_LblCodImp2", "Label")
9104:         WITH loc_oAba.lbl_4c_LblCodImp2
9105:             .Caption = "C" + CHR(243) + "digo Impresso"
9106:             .Top = 41
9107:             .Left = 577
9108:             .FontName = "Tahoma"
9109:             .FontSize = 7
9110:             .BackStyle = 0
9111:             .ForeColor = RGB(90,90,90)
9112:             .AutoSize = .T.
9113:             .Visible = .T.
9114:         ENDWITH
9115: 
9116:         loc_oAba.AddObject("lbl_4c_LblImpDir2", "Label")
9117:         WITH loc_oAba.lbl_4c_LblImpDir2
9118:             .Caption = "Imprimir"
9119:             .Top = 41
9120:             .Left = 672
9121:             .FontName = "Tahoma"
9122:             .FontSize = 7
9123:             .BackStyle = 0
9124:             .ForeColor = RGB(90,90,90)
9125:             .AutoSize = .T.
9126:             .Visible = .T.
9127:         ENDWITH
9128: 
9129:         loc_oAba.AddObject("lbl_4c_LblAngulo2", "Label")
9130:         WITH loc_oAba.lbl_4c_LblAngulo2
9131:             .Caption = CHR(226) + "ngulo"
9132:             .Top = 42
9133:             .Left = 533
9134:             .FontName = "Tahoma"
9135:             .FontSize = 7
9136:             .BackStyle = 0
9137:             .ForeColor = RGB(90,90,90)
9138:             .AutoSize = .T.

*-- Linhas 9145 a 9243:
9145:         FOR loc_nTopB = 54 TO 130 STEP 19
9146:                         loc_cFatB = ALLTRIM(STR(loc_nFatB))
9147: 
9148:             loc_oAba.AddObject("lbl_4c_CodB" + loc_cFatB, "Label")
9149:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9150:                 .Caption = "C" + CHR(243) + "digo " + loc_cFatB
9151:                 .Top = loc_nTopB + 2
9152:                 .Left = 395
9153:                 .FontName = "Tahoma"
9154:                 .FontSize = 7
9155:                 .BackStyle = 0
9156:                 .ForeColor = RGB(90,90,90)
9157:                 .AutoSize = .T.
9158:                 .Visible = .T.
9159:             ENDWITH
9160: 
9161:             loc_oAba.AddObject("txt_4c_ClsLB" + loc_cFatB, "TextBox")
9162:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9163:                 .ControlSource = "crSigCnFN2.lclas" + loc_cFatB
9164:                 .Top = loc_nTopB
9165:                 .Left = 436
9166:                 .Width = 41
9167:                 .Height = 18
9168:                 .FontName = "Tahoma"
9169:                 .FontSize = 8
9170:                 .SpecialEffect = 1
9171:                 .Format = "K"
9172:                 .InputMask = "999.99"
9173:                 .Visible = .T.
9174:             ENDWITH
9175: 
9176:             loc_oAba.AddObject("lbl_4c_ClsXB" + loc_cFatB, "Label")
9177:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9178:                 .Caption = "x"
9179:                 .Top = loc_nTopB + 2
9180:                 .Left = 479
9181:                 .FontName = "Tahoma"
9182:                 .FontSize = 7
9183:                 .BackStyle = 0
9184:                 .ForeColor = RGB(90,90,90)
9185:                 .AutoSize = .T.
9186:                 .Visible = .T.
9187:             ENDWITH
9188: 
9189:             loc_oAba.AddObject("txt_4c_ClsCB" + loc_cFatB, "TextBox")
9190:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9191:                 .ControlSource = "crSigCnFN2.cclas" + loc_cFatB
9192:                 .Top = loc_nTopB
9193:                 .Left = 485
9194:                 .Width = 41
9195:                 .Height = 18
9196:                 .FontName = "Tahoma"
9197:                 .FontSize = 8
9198:                 .SpecialEffect = 1
9199:                 .Format = "K"
9200:                 .InputMask = "999.99"
9201:                 .Visible = .T.
9202:             ENDWITH
9203: 
9204:             loc_oAba.AddObject("cbo_4c_AngB" + loc_cFatB, "ComboBox")
9205:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9206:                 .Top = loc_nTopB
9207:                 .Left = 528
9208:                 .Width = 46
9209:                 .Height = 18
9210:                 .FontName = "Tahoma"
9211:                 .FontSize = 8
9212:                 .Visible = .T.
9213:                 .RowSourceType = 1
9214:                 .RowSource = "0,90,180,270"
9215:             ENDWITH
9216: 
9217:             loc_oAba.AddObject("txt_4c_CodImpB" + loc_cFatB, "TextBox")
9218:             WITH loc_oAba.Controls(loc_oAba.ControlCount)
9219:                 .ControlSource = "crSigCnFN2.impclas" + loc_cFatB
9220:                 .Top = loc_nTopB
9221:                 .Left = 577
9222:                 .Width = 100
9223:                 .Height = 18
9224:                 .FontName = "Tahoma"
9225:                 .FontSize = 8
9226:                 .SpecialEffect = 1
9227:                 .Format = "K"
9228:                 .InputMask = ""
9229:                 .Visible = .T.
9230:             ENDWITH
9231: 
9232:             IF loc_nFatB <= 12
9233:                 loc_oAba.AddObject("chk_4c_ImpB" + loc_cFatB, "CheckBox")
9234:                 WITH loc_oAba.Controls(loc_oAba.ControlCount)
9235:                     .ControlSource = "crSigCnFN2.impc" + loc_cFatB
9236:                     .Caption = ""
9237:                     .Top = loc_nTopB
9238:                     .Left = 687
9239:                     .Width = 19
9240:                     .Height = 16
9241:                     .FontName = "Tahoma"
9242:                     .FontSize = 7
9243:                     .Visible = .T.

*-- Linhas 9251 a 9304:
9251:         ENDFOR
9252: 
9253:         *-- No NF (top=202)
9254:         loc_oAba.AddObject("lbl_4c_LblNoNF", "Label")
9255:         WITH loc_oAba.lbl_4c_LblNoNF
9256:             .Caption = "N" + CHR(186) + " NF"
9257:             .Top = 202
9258:             .Left = 68
9259:             .FontName = "Tahoma"
9260:             .FontSize = 7
9261:             .BackStyle = 0
9262:             .ForeColor = RGB(90,90,90)
9263:             .AutoSize = .T.
9264:             .Visible = .T.
9265:         ENDWITH
9266: 
9267:         loc_oAba.AddObject("txt_4c_NoNFL", "TextBox")
9268:         WITH loc_oAba.txt_4c_NoNFL
9269:             .ControlSource = "crSigCnFNf.lnfsai"
9270:             .Top = 213
9271:             .Left = 36
9272:             .Width = 41
9273:             .Height = 18
9274:             .FontName = "Tahoma"
9275:             .FontSize = 8
9276:             .SpecialEffect = 1
9277:             .Format = "K"
9278:             .InputMask = "999.99"
9279:             .Visible = .T.
9280:         ENDWITH
9281: 
9282:         loc_oAba.AddObject("lbl_4c_NoNFX", "Label")
9283:         WITH loc_oAba.lbl_4c_NoNFX
9284:             .Caption = "x"
9285:             .Top = 215
9286:             .Left = 79
9287:             .FontName = "Tahoma"
9288:             .FontSize = 7
9289:             .BackStyle = 0
9290:             .ForeColor = RGB(90,90,90)
9291:             .AutoSize = .T.
9292:             .Visible = .T.
9293:         ENDWITH
9294: 
9295:         loc_oAba.AddObject("txt_4c_NoNFC", "TextBox")
9296:         WITH loc_oAba.txt_4c_NoNFC
9297:             .ControlSource = "crSigCnFNf.cnfsai"
9298:             .Top = 213
9299:             .Left = 85
9300:             .Width = 41
9301:             .Height = 18
9302:             .FontName = "Tahoma"
9303:             .FontSize = 8
9304:             .SpecialEffect = 1

*-- Linhas 9310 a 9702:
9310:         *-- Angulo NF (top=202)
9311:         loc_oAba.AddObject("cbo_4c_AngNF", "ComboBox")
9312:         WITH loc_oAba.cbo_4c_AngNF
9313:             .Top = 213
9314:             .Left = 128
9315:             .Width = 46
9316:             .Height = 18
9317:             .FontName = "Tahoma"
9318:             .FontSize = 8
9319:             .Visible = .T.
9320:             .RowSourceType = 1
9321:             .RowSource = "0,90,180,270"
9322:         ENDWITH
9323: 
9324:         loc_oAba.AddObject("lbl_4c_LblAngNF", "Label")
9325:         WITH loc_oAba.lbl_4c_LblAngNF
9326:             .Caption = CHR(226) + "ngulo"
9327:             .Top = 202
9328:             .Left = 134
9329:             .FontName = "Tahoma"
9330:             .FontSize = 7
9331:             .BackStyle = 0
9332:             .ForeColor = RGB(90,90,90)
9333:             .AutoSize = .T.
9334:             .Visible = .T.
9335:         ENDWITH
9336: 
9337:         *-- Valor Total da Nota (top=202)
9338:         loc_oAba.AddObject("lbl_4c_LblVlNotaR", "Label")
9339:         WITH loc_oAba.lbl_4c_LblVlNotaR
9340:             .Caption = "Valor Total da Nota"
9341:             .Top = 202
9342:             .Left = 183
9343:             .FontName = "Tahoma"
9344:             .FontSize = 7
9345:             .BackStyle = 0
9346:             .ForeColor = RGB(90,90,90)
9347:             .AutoSize = .T.
9348:             .Visible = .T.
9349:         ENDWITH
9350: 
9351:         loc_oAba.AddObject("txt_4c_VlNotaRL", "TextBox")
9352:         WITH loc_oAba.txt_4c_VlNotaRL
9353:             .ControlSource = "crSigCnFNf.ltnota"
9354:             .Top = 213
9355:             .Left = 186
9356:             .Width = 41
9357:             .Height = 18
9358:             .FontName = "Tahoma"
9359:             .FontSize = 8
9360:             .SpecialEffect = 1
9361:             .Format = "K"
9362:             .InputMask = "999.99"
9363:             .Visible = .T.
9364:         ENDWITH
9365: 
9366:         loc_oAba.AddObject("lbl_4c_VlNotaRX", "Label")
9367:         WITH loc_oAba.lbl_4c_VlNotaRX
9368:             .Caption = "x"
9369:             .Top = 215
9370:             .Left = 229
9371:             .FontName = "Tahoma"
9372:             .FontSize = 7
9373:             .BackStyle = 0
9374:             .ForeColor = RGB(90,90,90)
9375:             .AutoSize = .T.
9376:             .Visible = .T.
9377:         ENDWITH
9378: 
9379:         loc_oAba.AddObject("txt_4c_VlNotaRC", "TextBox")
9380:         WITH loc_oAba.txt_4c_VlNotaRC
9381:             .ControlSource = "crSigCnFNf.ctnota"
9382:             .Top = 213
9383:             .Left = 235
9384:             .Width = 41
9385:             .Height = 18
9386:             .FontName = "Tahoma"
9387:             .FontSize = 8
9388:             .SpecialEffect = 1
9389:             .Format = "K"
9390:             .InputMask = "999.99"
9391:             .Visible = .T.
9392:         ENDWITH
9393: 
9394:         loc_oAba.AddObject("cbo_4c_AngVlNota", "ComboBox")
9395:         WITH loc_oAba.cbo_4c_AngVlNota
9396:             .Top = 213
9397:             .Left = 281
9398:             .Width = 46
9399:             .Height = 18
9400:             .FontName = "Tahoma"
9401:             .FontSize = 8
9402:             .Visible = .T.
9403:             .RowSourceType = 1
9404:             .RowSource = "0,90,180,270"
9405:         ENDWITH
9406: 
9407:         loc_oAba.AddObject("lbl_4c_LblAngVlNota", "Label")
9408:         WITH loc_oAba.lbl_4c_LblAngVlNota
9409:             .Caption = CHR(226) + "ngulo"
9410:             .Top = 202
9411:             .Left = 286
9412:             .FontName = "Tahoma"
9413:             .FontSize = 7
9414:             .BackStyle = 0
9415:             .ForeColor = RGB(90,90,90)
9416:             .AutoSize = .T.
9417:             .Visible = .T.
9418:         ENDWITH
9419: 
9420:         *-- No Selo (top=202)
9421:         loc_oAba.AddObject("lbl_4c_LblNoSelo", "Label")
9422:         WITH loc_oAba.lbl_4c_LblNoSelo
9423:             .Caption = "N" + CHR(186) + " Selo"
9424:             .Top = 202
9425:             .Left = 374
9426:             .FontName = "Tahoma"
9427:             .FontSize = 7
9428:             .BackStyle = 0
9429:             .ForeColor = RGB(90,90,90)
9430:             .AutoSize = .T.
9431:             .Visible = .T.
9432:         ENDWITH
9433: 
9434:         loc_oAba.AddObject("txt_4c_NoSeloL", "TextBox")
9435:         WITH loc_oAba.txt_4c_NoSeloL
9436:             .ControlSource = "crSigCnFNf.lcnfselo"
9437:             .Top = 213
9438:             .Left = 343
9439:             .Width = 41
9440:             .Height = 18
9441:             .FontName = "Tahoma"
9442:             .FontSize = 8
9443:             .SpecialEffect = 1
9444:             .Format = "K"
9445:             .InputMask = "999.99"
9446:             .Visible = .T.
9447:         ENDWITH
9448: 
9449:         loc_oAba.AddObject("lbl_4c_NoSeloX", "Label")
9450:         WITH loc_oAba.lbl_4c_NoSeloX
9451:             .Caption = "x"
9452:             .Top = 215
9453:             .Left = 386
9454:             .FontName = "Tahoma"
9455:             .FontSize = 7
9456:             .BackStyle = 0
9457:             .ForeColor = RGB(90,90,90)
9458:             .AutoSize = .T.
9459:             .Visible = .T.
9460:         ENDWITH
9461: 
9462:         loc_oAba.AddObject("txt_4c_NoSeloC", "TextBox")
9463:         WITH loc_oAba.txt_4c_NoSeloC
9464:             .ControlSource = "crSigCnFNf.lcselo"
9465:             .Top = 213
9466:             .Left = 392
9467:             .Width = 41
9468:             .Height = 18
9469:             .FontName = "Tahoma"
9470:             .FontSize = 8
9471:             .SpecialEffect = 1
9472:             .Format = "K"
9473:             .InputMask = "999.99"
9474:             .Visible = .T.
9475:         ENDWITH
9476: 
9477:         loc_oAba.AddObject("cbo_4c_AngSelo", "ComboBox")
9478:         WITH loc_oAba.cbo_4c_AngSelo
9479:             .Top = 213
9480:             .Left = 435
9481:             .Width = 46
9482:             .Height = 18
9483:             .FontName = "Tahoma"
9484:             .FontSize = 8
9485:             .Visible = .T.
9486:             .RowSourceType = 1
9487:             .RowSource = "0,90,180,270"
9488:         ENDWITH
9489: 
9490:         loc_oAba.AddObject("lbl_4c_LblAngSelo", "Label")
9491:         WITH loc_oAba.lbl_4c_LblAngSelo
9492:             .Caption = CHR(226) + "ngulo"
9493:             .Top = 202
9494:             .Left = 440
9495:             .FontName = "Tahoma"
9496:             .FontSize = 7
9497:             .BackStyle = 0
9498:             .ForeColor = RGB(90,90,90)
9499:             .AutoSize = .T.
9500:             .Visible = .T.
9501:         ENDWITH
9502: 
9503:         *-- No NF no Selo (top=202)
9504:         loc_oAba.AddObject("lbl_4c_LblNFSelo", "Label")
9505:         WITH loc_oAba.lbl_4c_LblNFSelo
9506:             .Caption = "N" + CHR(186) + " NF no Selo"
9507:             .Top = 202
9508:             .Left = 510
9509:             .FontName = "Tahoma"
9510:             .FontSize = 7
9511:             .BackStyle = 0
9512:             .ForeColor = RGB(90,90,90)
9513:             .AutoSize = .T.
9514:             .Visible = .T.
9515:         ENDWITH
9516: 
9517:         loc_oAba.AddObject("txt_4c_NFSeloL", "TextBox")
9518:         WITH loc_oAba.txt_4c_NFSeloL
9519:             .ControlSource = "crSigCnFNf.lnfsai"
9520:             .Top = 213
9521:             .Left = 499
9522:             .Width = 41
9523:             .Height = 18
9524:             .FontName = "Tahoma"
9525:             .FontSize = 8
9526:             .SpecialEffect = 1
9527:             .Format = "K"
9528:             .InputMask = "999.99"
9529:             .Visible = .T.
9530:         ENDWITH
9531: 
9532:         loc_oAba.AddObject("lbl_4c_NFSeloX", "Label")
9533:         WITH loc_oAba.lbl_4c_NFSeloX
9534:             .Caption = "x"
9535:             .Top = 215
9536:             .Left = 542
9537:             .FontName = "Tahoma"
9538:             .FontSize = 7
9539:             .BackStyle = 0
9540:             .ForeColor = RGB(90,90,90)
9541:             .AutoSize = .T.
9542:             .Visible = .T.
9543:         ENDWITH
9544: 
9545:         loc_oAba.AddObject("txt_4c_NFSeloC", "TextBox")
9546:         WITH loc_oAba.txt_4c_NFSeloC
9547:             .ControlSource = "crSigCnFNf.cnfsai"
9548:             .Top = 213
9549:             .Left = 548
9550:             .Width = 41
9551:             .Height = 18
9552:             .FontName = "Tahoma"
9553:             .FontSize = 8
9554:             .SpecialEffect = 1
9555:             .Format = "K"
9556:             .InputMask = "999.99"
9557:             .Visible = .T.
9558:         ENDWITH
9559: 
9560:         loc_oAba.AddObject("cbo_4c_AngNFSelo", "ComboBox")
9561:         WITH loc_oAba.cbo_4c_AngNFSelo
9562:             .Top = 213
9563:             .Left = 599
9564:             .Width = 46
9565:             .Height = 18
9566:             .FontName = "Tahoma"
9567:             .FontSize = 8
9568:             .Visible = .T.
9569:             .RowSourceType = 1
9570:             .RowSource = "0,90,180,270"
9571:         ENDWITH
9572: 
9573:         loc_oAba.AddObject("lbl_4c_LblAngNFSelo", "Label")
9574:         WITH loc_oAba.lbl_4c_LblAngNFSelo
9575:             .Caption = CHR(226) + "ngulo"
9576:             .Top = 202
9577:             .Left = 603
9578:             .FontName = "Tahoma"
9579:             .FontSize = 7
9580:             .BackStyle = 0
9581:             .ForeColor = RGB(90,90,90)
9582:             .AutoSize = .T.
9583:             .Visible = .T.
9584:         ENDWITH
9585: 
9586:         *-- Observacoes Shape (top=239)
9587:         loc_oAba.AddObject("shp_4c_ObsShape", "Shape")
9588:         WITH loc_oAba.shp_4c_ObsShape
9589:             .Top = 239
9590:             .Left = 34
9591:             .Width = 277
9592:             .Height = 37
9593:             .Visible = .T.
9594:         ENDWITH
9595: 
9596:         loc_oAba.AddObject("lbl_4c_LblObs", "Label")
9597:         WITH loc_oAba.lbl_4c_LblObs
9598:             .Caption = "Observa" + CHR(231) + CHR(245) + "es"
9599:             .Top = 242
9600:             .Left = 44
9601:             .FontName = "Tahoma"
9602:             .FontSize = 7
9603:             .BackStyle = 0
9604:             .ForeColor = RGB(90,90,90)
9605:             .AutoSize = .T.
9606:             .Visible = .T.
9607:         ENDWITH
9608: 
9609:         loc_oAba.AddObject("txt_4c_ObsL", "TextBox")
9610:         WITH loc_oAba.txt_4c_ObsL
9611:             .ControlSource = "crSigCnFNf.tamlinobs"
9612:             .Top = 254
9613:             .Left = 44
9614:             .Width = 41
9615:             .Height = 18
9616:             .FontName = "Tahoma"
9617:             .FontSize = 8
9618:             .SpecialEffect = 1
9619:             .Format = "K"
9620:             .InputMask = "999.99"
9621:             .Visible = .T.
9622:         ENDWITH
9623: 
9624:         loc_oAba.AddObject("lbl_4c_ObsX", "Label")
9625:         WITH loc_oAba.lbl_4c_ObsX
9626:             .Caption = "x"
9627:             .Top = 256
9628:             .Left = 87
9629:             .FontName = "Tahoma"
9630:             .FontSize = 7
9631:             .BackStyle = 0
9632:             .ForeColor = RGB(90,90,90)
9633:             .AutoSize = .T.
9634:             .Visible = .T.
9635:         ENDWITH
9636: 
9637:         loc_oAba.AddObject("txt_4c_ObsC", "TextBox")
9638:         WITH loc_oAba.txt_4c_ObsC
9639:             .ControlSource = "crSigCnFNf.tamcolobs"
9640:             .Top = 254
9641:             .Left = 93
9642:             .Width = 41
9643:             .Height = 18
9644:             .FontName = "Tahoma"
9645:             .FontSize = 8
9646:             .SpecialEffect = 1
9647:             .Format = "K"
9648:             .InputMask = "999.99"
9649:             .Visible = .T.
9650:         ENDWITH
9651: 
9652:         loc_oAba.AddObject("lbl_4c_LblNoCols2", "Label")
9653:         WITH loc_oAba.lbl_4c_LblNoCols2
9654:             .Caption = "No. Colunas"
9655:             .Top = 242
9656:             .Left = 185
9657:             .FontName = "Tahoma"
9658:             .FontSize = 7
9659:             .BackStyle = 0
9660:             .ForeColor = RGB(90,90,90)
9661:             .AutoSize = .T.
9662:             .Visible = .T.
9663:         ENDWITH
9664: 
9665:         loc_oAba.AddObject("txt_4c_ObsNoCol", "TextBox")
9666:         WITH loc_oAba.txt_4c_ObsNoCol
9667:             .ControlSource = "crSigCnFNf.nldser"
9668:             .Top = 254
9669:             .Left = 194
9670:             .Width = 41
9671:             .Height = 18
9672:             .FontName = "Tahoma"
9673:             .FontSize = 8
9674:             .SpecialEffect = 1
9675:             .Format = "K"
9676:             .InputMask = "999.99"
9677:             .Visible = .T.
9678:         ENDWITH
9679: 
9680:         loc_oAba.AddObject("lbl_4c_LblNoLins2", "Label")
9681:         WITH loc_oAba.lbl_4c_LblNoLins2
9682:             .Caption = "No. Linhas"
9683:             .Top = 242
9684:             .Left = 251
9685:             .FontName = "Tahoma"
9686:             .FontSize = 7
9687:             .BackStyle = 0
9688:             .ForeColor = RGB(90,90,90)
9689:             .AutoSize = .T.
9690:             .Visible = .T.
9691:         ENDWITH
9692: 
9693:         loc_oAba.AddObject("txt_4c_ObsNoLin", "TextBox")
9694:         WITH loc_oAba.txt_4c_ObsNoLin
9695:             .ControlSource = "crSigCnFNf.ncdser"
9696:             .Top = 254
9697:             .Left = 256
9698:             .Width = 41
9699:             .Height = 18
9700:             .FontName = "Tahoma"
9701:             .FontSize = 8
9702:             .SpecialEffect = 1

*-- Linhas 9708 a 9870:
9708:         *-- Angulo obs
9709:         loc_oAba.AddObject("cbo_4c_AngObs", "ComboBox")
9710:         WITH loc_oAba.cbo_4c_AngObs
9711:             .Top = 254
9712:             .Left = 137
9713:             .Width = 46
9714:             .Height = 18
9715:             .FontName = "Tahoma"
9716:             .FontSize = 8
9717:             .Visible = .T.
9718:             .RowSourceType = 1
9719:             .RowSource = "0,90,180,270"
9720:         ENDWITH
9721: 
9722:         loc_oAba.AddObject("lbl_4c_LblAngObs", "Label")
9723:         WITH loc_oAba.lbl_4c_LblAngObs
9724:             .Caption = CHR(226) + "ngulo"
9725:             .Top = 243
9726:             .Left = 143
9727:             .FontName = "Tahoma"
9728:             .FontSize = 7
9729:             .BackStyle = 0
9730:             .ForeColor = RGB(90,90,90)
9731:             .AutoSize = .T.
9732:             .Visible = .T.
9733:         ENDWITH
9734: 
9735:         *-- N Pedidos SubNivel (top=242, left=321 e left=486)
9736:         loc_oAba.AddObject("lbl_4c_LblNPedSub1", "Label")
9737:         WITH loc_oAba.lbl_4c_LblNPedSub1
9738:             .Caption = "N" + CHR(186) + " Pedidos (SubNivel)"
9739:             .Top = 242
9740:             .Left = 321
9741:             .FontName = "Tahoma"
9742:             .FontSize = 7
9743:             .BackStyle = 0
9744:             .ForeColor = RGB(90,90,90)
9745:             .AutoSize = .T.
9746:             .Visible = .T.
9747:         ENDWITH
9748: 
9749:         loc_oAba.AddObject("txt_4c_NPedSubL1", "TextBox")
9750:         WITH loc_oAba.txt_4c_NPedSubL1
9751:             .ControlSource = "crSigCnFNf.ldupnum"
9752:             .Top = 254
9753:             .Left = 332
9754:             .Width = 41
9755:             .Height = 18
9756:             .FontName = "Tahoma"
9757:             .FontSize = 8
9758:             .SpecialEffect = 1
9759:             .Format = "K"
9760:             .InputMask = "999.99"
9761:             .Visible = .T.
9762:         ENDWITH
9763: 
9764:         loc_oAba.AddObject("lbl_4c_NPedSubX1", "Label")
9765:         WITH loc_oAba.lbl_4c_NPedSubX1
9766:             .Caption = "x"
9767:             .Top = 256
9768:             .Left = 375
9769:             .FontName = "Tahoma"
9770:             .FontSize = 7
9771:             .BackStyle = 0
9772:             .ForeColor = RGB(90,90,90)
9773:             .AutoSize = .T.
9774:             .Visible = .T.
9775:         ENDWITH
9776: 
9777:         loc_oAba.AddObject("txt_4c_NPedSubC1", "TextBox")
9778:         WITH loc_oAba.txt_4c_NPedSubC1
9779:             .ControlSource = "crSigCnFNf.cdupnum"
9780:             .Top = 254
9781:             .Left = 381
9782:             .Width = 41
9783:             .Height = 18
9784:             .FontName = "Tahoma"
9785:             .FontSize = 8
9786:             .SpecialEffect = 1
9787:             .Format = "K"
9788:             .InputMask = "999.99"
9789:             .Visible = .T.
9790:         ENDWITH
9791: 
9792:         loc_oAba.AddObject("lbl_4c_LblNPedSub2", "Label")
9793:         WITH loc_oAba.lbl_4c_LblNPedSub2
9794:             .Caption = "N" + CHR(186) + " Pedidos (SubNivel)"
9795:             .Top = 242
9796:             .Left = 486
9797:             .FontName = "Tahoma"
9798:             .FontSize = 7
9799:             .BackStyle = 0
9800:             .ForeColor = RGB(90,90,90)
9801:             .AutoSize = .T.
9802:             .Visible = .T.
9803:         ENDWITH
9804: 
9805:         loc_oAba.AddObject("txt_4c_NPedSubL2", "TextBox")
9806:         WITH loc_oAba.txt_4c_NPedSubL2
9807:             .ControlSource = "crSigCnFNf.ldupnum"
9808:             .Top = 254
9809:             .Left = 499
9810:             .Width = 41
9811:             .Height = 18
9812:             .FontName = "Tahoma"
9813:             .FontSize = 8
9814:             .SpecialEffect = 1
9815:             .Format = "K"
9816:             .InputMask = "999.99"
9817:             .Visible = .T.
9818:         ENDWITH
9819: 
9820:         loc_oAba.AddObject("lbl_4c_NPedSubX2", "Label")
9821:         WITH loc_oAba.lbl_4c_NPedSubX2
9822:             .Caption = "x"
9823:             .Top = 256
9824:             .Left = 542
9825:             .FontName = "Tahoma"
9826:             .FontSize = 7
9827:             .BackStyle = 0
9828:             .ForeColor = RGB(90,90,90)
9829:             .AutoSize = .T.
9830:             .Visible = .T.
9831:         ENDWITH
9832: 
9833:         loc_oAba.AddObject("txt_4c_NPedSubC2", "TextBox")
9834:         WITH loc_oAba.txt_4c_NPedSubC2
9835:             .ControlSource = "crSigCnFNf.cdupnum"
9836:             .Top = 254
9837:             .Left = 548
9838:             .Width = 41
9839:             .Height = 18
9840:             .FontName = "Tahoma"
9841:             .FontSize = 8
9842:             .SpecialEffect = 1
9843:             .Format = "K"
9844:             .InputMask = "999.99"
9845:             .Visible = .T.
9846:         ENDWITH
9847: 
9848:         loc_oAba.AddObject("cbo_4c_AngNPed2", "ComboBox")
9849:         WITH loc_oAba.cbo_4c_AngNPed2
9850:             .Top = 254
9851:             .Left = 599
9852:             .Width = 46
9853:             .Height = 18
9854:             .FontName = "Tahoma"
9855:             .FontSize = 8
9856:             .Visible = .T.
9857:             .RowSourceType = 1
9858:             .RowSource = "0,90,180,270"
9859:         ENDWITH
9860: 
9861:         loc_oAba.AddObject("lbl_4c_LblAngNPed2", "Label")
9862:         WITH loc_oAba.lbl_4c_LblAngNPed2
9863:             .Caption = CHR(226) + "ngulo"
9864:             .Top = 243
9865:             .Left = 603
9866:             .FontName = "Tahoma"
9867:             .FontSize = 7
9868:             .BackStyle = 0
9869:             .ForeColor = RGB(90,90,90)
9870:             .AutoSize = .T.

*-- Linhas 9878 a 10273:
9878:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page8
9879: 
9880:         *-- Data de Emissao (top=31)
9881:         loc_oAba.AddObject("lbl_4c_LblFatDtEmi", "Label")
9882:         WITH loc_oAba.lbl_4c_LblFatDtEmi
9883:             .Caption   = "Data de Emiss" + CHR(227) + "o"
9884:             .Top       = 31
9885:             .Left      = 99
9886:             .FontName  = "Tahoma"
9887:             .FontSize  = 7
9888:             .BackStyle = 0
9889:             .ForeColor = RGB(90, 90, 90)
9890:             .AutoSize  = .T.
9891:             .Visible   = .T.
9892:         ENDWITH
9893: 
9894:         loc_oAba.AddObject("txt_4c_FatDtEmiL", "TextBox")
9895:         WITH loc_oAba.txt_4c_FatDtEmiL
9896:             .ControlSource = "crSigCnFNf.ldtemi"
9897:             .Top = 43
9898:             .Left = 99
9899:             .Width = 41
9900:             .Height = 18
9901:             .FontName = "Tahoma"
9902:             .FontSize = 8
9903:             .SpecialEffect = 1
9904:             .Format = "K"
9905:             .InputMask = "999.99"
9906:             .Visible = .T.
9907:         ENDWITH
9908: 
9909:         loc_oAba.AddObject("lbl_4c_FatDtEmiX", "Label")
9910:         WITH loc_oAba.lbl_4c_FatDtEmiX
9911:             .Caption = "x"
9912:             .Top = 45
9913:             .Left = 142
9914:             .FontName = "Tahoma"
9915:             .FontSize = 7
9916:             .BackStyle = 0
9917:             .ForeColor = RGB(90,90,90)
9918:             .AutoSize = .T.
9919:             .Visible = .T.
9920:         ENDWITH
9921: 
9922:         loc_oAba.AddObject("txt_4c_FatDtEmiC", "TextBox")
9923:         WITH loc_oAba.txt_4c_FatDtEmiC
9924:             .ControlSource = "crSigCnFNf.cdtemi"
9925:             .Top = 43
9926:             .Left = 148
9927:             .Width = 41
9928:             .Height = 18
9929:             .FontName = "Tahoma"
9930:             .FontSize = 8
9931:             .SpecialEffect = 1
9932:             .Format = "K"
9933:             .InputMask = "999.99"
9934:             .Visible = .T.
9935:         ENDWITH
9936: 
9937:         *-- No NF Fatura (top=31)
9938:         loc_oAba.AddObject("lbl_4c_LblNFatNum", "Label")
9939:         WITH loc_oAba.lbl_4c_LblNFatNum
9940:             .Caption = "N" + CHR(250) + "mero N.F. Fatura"
9941:             .Top = 31
9942:             .Left = 231
9943:             .FontName = "Tahoma"
9944:             .FontSize = 7
9945:             .BackStyle = 0
9946:             .ForeColor = RGB(90,90,90)
9947:             .AutoSize = .T.
9948:             .Visible = .T.
9949:         ENDWITH
9950: 
9951:         loc_oAba.AddObject("txt_4c_NFatNumL", "TextBox")
9952:         WITH loc_oAba.txt_4c_NFatNumL
9953:             .ControlSource = "crSigCnFNf.lfatnum"
9954:             .Top = 43
9955:             .Left = 231
9956:             .Width = 41
9957:             .Height = 18
9958:             .FontName = "Tahoma"
9959:             .FontSize = 8
9960:             .SpecialEffect = 1
9961:             .Format = "K"
9962:             .InputMask = "999.99"
9963:             .Visible = .T.
9964:         ENDWITH
9965: 
9966:         loc_oAba.AddObject("lbl_4c_NFatNumX", "Label")
9967:         WITH loc_oAba.lbl_4c_NFatNumX
9968:             .Caption = "x"
9969:             .Top = 45
9970:             .Left = 274
9971:             .FontName = "Tahoma"
9972:             .FontSize = 7
9973:             .BackStyle = 0
9974:             .ForeColor = RGB(90,90,90)
9975:             .AutoSize = .T.
9976:             .Visible = .T.
9977:         ENDWITH
9978: 
9979:         loc_oAba.AddObject("txt_4c_NFatNumC", "TextBox")
9980:         WITH loc_oAba.txt_4c_NFatNumC
9981:             .ControlSource = "crSigCnFNf.cfatnum"
9982:             .Top = 43
9983:             .Left = 280
9984:             .Width = 41
9985:             .Height = 18
9986:             .FontName = "Tahoma"
9987:             .FontSize = 8
9988:             .SpecialEffect = 1
9989:             .Format = "K"
9990:             .InputMask = "999.99"
9991:             .Visible = .T.
9992:         ENDWITH
9993: 
9994:         *-- Data de Saida (top=67)
9995:         loc_oAba.AddObject("lbl_4c_LblFatDtSai", "Label")
9996:         WITH loc_oAba.lbl_4c_LblFatDtSai
9997:             .Caption = "Data de Sa" + CHR(237) + "da"
9998:             .Top = 67
9999:             .Left = 98
10000:             .FontName = "Tahoma"
10001:             .FontSize = 7
10002:             .BackStyle = 0
10003:             .ForeColor = RGB(90,90,90)
10004:             .AutoSize = .T.
10005:             .Visible = .T.
10006:         ENDWITH
10007: 
10008:         loc_oAba.AddObject("txt_4c_FatDtSaiL", "TextBox")
10009:         WITH loc_oAba.txt_4c_FatDtSaiL
10010:             .ControlSource = "crSigCnFNf.ldtsaidas"
10011:             .Top = 79
10012:             .Left = 98
10013:             .Width = 41
10014:             .Height = 18
10015:             .FontName = "Tahoma"
10016:             .FontSize = 8
10017:             .SpecialEffect = 1
10018:             .Format = "K"
10019:             .InputMask = "999.99"
10020:             .Visible = .T.
10021:         ENDWITH
10022: 
10023:         loc_oAba.AddObject("lbl_4c_FatDtSaiX", "Label")
10024:         WITH loc_oAba.lbl_4c_FatDtSaiX
10025:             .Caption = "x"
10026:             .Top = 81
10027:             .Left = 141
10028:             .FontName = "Tahoma"
10029:             .FontSize = 7
10030:             .BackStyle = 0
10031:             .ForeColor = RGB(90,90,90)
10032:             .AutoSize = .T.
10033:             .Visible = .T.
10034:         ENDWITH
10035: 
10036:         loc_oAba.AddObject("txt_4c_FatDtSaiC", "TextBox")
10037:         WITH loc_oAba.txt_4c_FatDtSaiC
10038:             .ControlSource = "crSigCnFNf.cdtsaidas"
10039:             .Top = 79
10040:             .Left = 147
10041:             .Width = 41
10042:             .Height = 18
10043:             .FontName = "Tahoma"
10044:             .FontSize = 8
10045:             .SpecialEffect = 1
10046:             .Format = "K"
10047:             .InputMask = "999.99"
10048:             .Visible = .T.
10049:         ENDWITH
10050: 
10051:         *-- Numero Duplicata (top=67)
10052:         loc_oAba.AddObject("lbl_4c_LblDuplNum", "Label")
10053:         WITH loc_oAba.lbl_4c_LblDuplNum
10054:             .Caption = "N" + CHR(250) + "mero Duplicata"
10055:             .Top = 67
10056:             .Left = 231
10057:             .FontName = "Tahoma"
10058:             .FontSize = 7
10059:             .BackStyle = 0
10060:             .ForeColor = RGB(90,90,90)
10061:             .AutoSize = .T.
10062:             .Visible = .T.
10063:         ENDWITH
10064: 
10065:         loc_oAba.AddObject("txt_4c_DuplNumL", "TextBox")
10066:         WITH loc_oAba.txt_4c_DuplNumL
10067:             .ControlSource = "crSigCnFNf.ldupnum"
10068:             .Top = 79
10069:             .Left = 231
10070:             .Width = 41
10071:             .Height = 18
10072:             .FontName = "Tahoma"
10073:             .FontSize = 8
10074:             .SpecialEffect = 1
10075:             .Format = "K"
10076:             .InputMask = "999.99"
10077:             .Visible = .T.
10078:         ENDWITH
10079: 
10080:         loc_oAba.AddObject("lbl_4c_DuplNumX", "Label")
10081:         WITH loc_oAba.lbl_4c_DuplNumX
10082:             .Caption = "x"
10083:             .Top = 81
10084:             .Left = 274
10085:             .FontName = "Tahoma"
10086:             .FontSize = 7
10087:             .BackStyle = 0
10088:             .ForeColor = RGB(90,90,90)
10089:             .AutoSize = .T.
10090:             .Visible = .T.
10091:         ENDWITH
10092: 
10093:         loc_oAba.AddObject("txt_4c_DuplNumC", "TextBox")
10094:         WITH loc_oAba.txt_4c_DuplNumC
10095:             .ControlSource = "crSigCnFNf.cdupnum"
10096:             .Top = 79
10097:             .Left = 280
10098:             .Width = 41
10099:             .Height = 18
10100:             .FontName = "Tahoma"
10101:             .FontSize = 8
10102:             .SpecialEffect = 1
10103:             .Format = "K"
10104:             .InputMask = "999.99"
10105:             .Visible = .T.
10106:         ENDWITH
10107: 
10108:         *-- Valor Total da Nota (top=103)
10109:         loc_oAba.AddObject("lbl_4c_LblFatVlNota", "Label")
10110:         WITH loc_oAba.lbl_4c_LblFatVlNota
10111:             .Caption = "Valor Total da Nota"
10112:             .Top = 103
10113:             .Left = 99
10114:             .FontName = "Tahoma"
10115:             .FontSize = 7
10116:             .BackStyle = 0
10117:             .ForeColor = RGB(90,90,90)
10118:             .AutoSize = .T.
10119:             .Visible = .T.
10120:         ENDWITH
10121: 
10122:         loc_oAba.AddObject("txt_4c_FatVlNotaL", "TextBox")
10123:         WITH loc_oAba.txt_4c_FatVlNotaL
10124:             .ControlSource = "crSigCnFNf.ltnota"
10125:             .Top = 115
10126:             .Left = 99
10127:             .Width = 41
10128:             .Height = 18
10129:             .FontName = "Tahoma"
10130:             .FontSize = 8
10131:             .SpecialEffect = 1
10132:             .Format = "K"
10133:             .InputMask = "999.99"
10134:             .Visible = .T.
10135:         ENDWITH
10136: 
10137:         loc_oAba.AddObject("lbl_4c_FatVlNotaX", "Label")
10138:         WITH loc_oAba.lbl_4c_FatVlNotaX
10139:             .Caption = "x"
10140:             .Top = 117
10141:             .Left = 142
10142:             .FontName = "Tahoma"
10143:             .FontSize = 7
10144:             .BackStyle = 0
10145:             .ForeColor = RGB(90,90,90)
10146:             .AutoSize = .T.
10147:             .Visible = .T.
10148:         ENDWITH
10149: 
10150:         loc_oAba.AddObject("txt_4c_FatVlNotaC", "TextBox")
10151:         WITH loc_oAba.txt_4c_FatVlNotaC
10152:             .ControlSource = "crSigCnFNf.ctnota"
10153:             .Top = 115
10154:             .Left = 148
10155:             .Width = 41
10156:             .Height = 18
10157:             .FontName = "Tahoma"
10158:             .FontSize = 8
10159:             .SpecialEffect = 1
10160:             .Format = "K"
10161:             .InputMask = "999.99"
10162:             .Visible = .T.
10163:         ENDWITH
10164: 
10165:         *-- Valor por Extenso (top=103)
10166:         loc_oAba.AddObject("lbl_4c_LblValExt", "Label")
10167:         WITH loc_oAba.lbl_4c_LblValExt
10168:             .Caption = "Valor por Extenso"
10169:             .Top = 103
10170:             .Left = 231
10171:             .FontName = "Tahoma"
10172:             .FontSize = 7
10173:             .BackStyle = 0
10174:             .ForeColor = RGB(90,90,90)
10175:             .AutoSize = .T.
10176:             .Visible = .T.
10177:         ENDWITH
10178: 
10179:         loc_oAba.AddObject("txt_4c_ValExtL", "TextBox")
10180:         WITH loc_oAba.txt_4c_ValExtL
10181:             .ControlSource = "crSigCnFNf.lvalext"
10182:             .Top = 115
10183:             .Left = 231
10184:             .Width = 41
10185:             .Height = 18
10186:             .FontName = "Tahoma"
10187:             .FontSize = 8
10188:             .SpecialEffect = 1
10189:             .Format = "K"
10190:             .InputMask = "999.99"
10191:             .Visible = .T.
10192:         ENDWITH
10193: 
10194:         loc_oAba.AddObject("lbl_4c_ValExtX", "Label")
10195:         WITH loc_oAba.lbl_4c_ValExtX
10196:             .Caption = "x"
10197:             .Top = 117
10198:             .Left = 274
10199:             .FontName = "Tahoma"
10200:             .FontSize = 7
10201:             .BackStyle = 0
10202:             .ForeColor = RGB(90,90,90)
10203:             .AutoSize = .T.
10204:             .Visible = .T.
10205:         ENDWITH
10206: 
10207:         loc_oAba.AddObject("txt_4c_ValExtC", "TextBox")
10208:         WITH loc_oAba.txt_4c_ValExtC
10209:             .ControlSource = "crSigCnFNf.cvalext"
10210:             .Top = 115
10211:             .Left = 280
10212:             .Width = 41
10213:             .Height = 18
10214:             .FontName = "Tahoma"
10215:             .FontSize = 8
10216:             .SpecialEffect = 1
10217:             .Format = "K"
10218:             .InputMask = "999.99"
10219:             .Visible = .T.
10220:         ENDWITH
10221: 
10222:         *-- Vencimento (top=138)
10223:         loc_oAba.AddObject("lbl_4c_LblFatVecto", "Label")
10224:         WITH loc_oAba.lbl_4c_LblFatVecto
10225:             .Caption = "Vencimento "
10226:             .Top = 138
10227:             .Left = 99
10228:             .FontName = "Tahoma"
10229:             .FontSize = 7
10230:             .BackStyle = 0
10231:             .ForeColor = RGB(90,90,90)
10232:             .AutoSize = .T.
10233:             .Visible = .T.
10234:         ENDWITH
10235: 
10236:         loc_oAba.AddObject("txt_4c_FatVectoL", "TextBox")
10237:         WITH loc_oAba.txt_4c_FatVectoL
10238:             .ControlSource = "crSigCnFNf.lfatvec"
10239:             .Top = 150
10240:             .Left = 99
10241:             .Width = 41
10242:             .Height = 18
10243:             .FontName = "Tahoma"
10244:             .FontSize = 8
10245:             .SpecialEffect = 1
10246:             .Format = "K"
10247:             .InputMask = "999.99"
10248:             .Visible = .T.
10249:         ENDWITH
10250: 
10251:         loc_oAba.AddObject("lbl_4c_FatVectoX", "Label")
10252:         WITH loc_oAba.lbl_4c_FatVectoX
10253:             .Caption = "x"
10254:             .Top = 152
10255:             .Left = 142
10256:             .FontName = "Tahoma"
10257:             .FontSize = 7
10258:             .BackStyle = 0
10259:             .ForeColor = RGB(90,90,90)
10260:             .AutoSize = .T.
10261:             .Visible = .T.
10262:         ENDWITH
10263: 
10264:         loc_oAba.AddObject("txt_4c_FatVectoC", "TextBox")
10265:         WITH loc_oAba.txt_4c_FatVectoC
10266:             .ControlSource = "crSigCnFNf.cfatvec"
10267:             .Top = 150
10268:             .Left = 148
10269:             .Width = 41
10270:             .Height = 18
10271:             .FontName = "Tahoma"
10272:             .FontSize = 8
10273:             .SpecialEffect = 1

*-- Linhas 10283 a 10508:
10283:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page9
10284: 
10285:         *-- Descricao Servicos (top=30)
10286:         loc_oAba.AddObject("lbl_4c_LblSrvDesc", "Label")
10287:         WITH loc_oAba.lbl_4c_LblSrvDesc
10288:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o Servi" + CHR(231) + "os"
10289:             .Top       = 30
10290:             .Left      = 105
10291:             .FontName  = "Tahoma"
10292:             .FontSize  = 7
10293:             .BackStyle = 0
10294:             .ForeColor = RGB(90, 90, 90)
10295:             .AutoSize  = .T.
10296:             .Visible   = .T.
10297:         ENDWITH
10298: 
10299:         loc_oAba.AddObject("txt_4c_SrvDescL", "TextBox")
10300:         WITH loc_oAba.txt_4c_SrvDescL
10301:             .ControlSource = "crSigCnFNf.ldescser"
10302:             .Top = 43
10303:             .Left = 107
10304:             .Width = 41
10305:             .Height = 18
10306:             .FontName = "Tahoma"
10307:             .FontSize = 8
10308:             .SpecialEffect = 1
10309:             .Format = "K"
10310:             .InputMask = "999.99"
10311:             .Visible = .T.
10312:         ENDWITH
10313: 
10314:         loc_oAba.AddObject("lbl_4c_SrvDescX", "Label")
10315:         WITH loc_oAba.lbl_4c_SrvDescX
10316:             .Caption = "x"
10317:             .Top = 45
10318:             .Left = 150
10319:             .FontName = "Tahoma"
10320:             .FontSize = 7
10321:             .BackStyle = 0
10322:             .ForeColor = RGB(90,90,90)
10323:             .AutoSize = .T.
10324:             .Visible = .T.
10325:         ENDWITH
10326: 
10327:         loc_oAba.AddObject("txt_4c_SrvDescC", "TextBox")
10328:         WITH loc_oAba.txt_4c_SrvDescC
10329:             .ControlSource = "crSigCnFNf.cdescser"
10330:             .Top = 43
10331:             .Left = 156
10332:             .Width = 41
10333:             .Height = 18
10334:             .FontName = "Tahoma"
10335:             .FontSize = 8
10336:             .SpecialEffect = 1
10337:             .Format = "K"
10338:             .InputMask = "999.99"
10339:             .Visible = .T.
10340:         ENDWITH
10341: 
10342:         *-- No. Colunas (top=31)
10343:         loc_oAba.AddObject("lbl_4c_LblSrvNoCols", "Label")
10344:         WITH loc_oAba.lbl_4c_LblSrvNoCols
10345:             .Caption = "No. Colunas"
10346:             .Top = 31
10347:             .Left = 206
10348:             .FontName = "Tahoma"
10349:             .FontSize = 7
10350:             .BackStyle = 0
10351:             .ForeColor = RGB(90,90,90)
10352:             .AutoSize = .T.
10353:             .Visible = .T.
10354:         ENDWITH
10355: 
10356:         loc_oAba.AddObject("txt_4c_SrvNoCols", "TextBox")
10357:         WITH loc_oAba.txt_4c_SrvNoCols
10358:             .ControlSource = "crSigCnFNf.nldser"
10359:             .Top = 43
10360:             .Left = 214
10361:             .Width = 41
10362:             .Height = 18
10363:             .FontName = "Tahoma"
10364:             .FontSize = 8
10365:             .SpecialEffect = 1
10366:             .Format = "K"
10367:             .InputMask = "999.99"
10368:             .Visible = .T.
10369:         ENDWITH
10370: 
10371:         *-- No. Linhas (top=31)
10372:         loc_oAba.AddObject("lbl_4c_LblSrvNoLins", "Label")
10373:         WITH loc_oAba.lbl_4c_LblSrvNoLins
10374:             .Caption = "No. Linhas"
10375:             .Top = 31
10376:             .Left = 273
10377:             .FontName = "Tahoma"
10378:             .FontSize = 7
10379:             .BackStyle = 0
10380:             .ForeColor = RGB(90,90,90)
10381:             .AutoSize = .T.
10382:             .Visible = .T.
10383:         ENDWITH
10384: 
10385:         loc_oAba.AddObject("txt_4c_SrvNoLins", "TextBox")
10386:         WITH loc_oAba.txt_4c_SrvNoLins
10387:             .ControlSource = "crSigCnFNf.ncdser"
10388:             .Top = 43
10389:             .Left = 273
10390:             .Width = 41
10391:             .Height = 18
10392:             .FontName = "Tahoma"
10393:             .FontSize = 8
10394:             .SpecialEffect = 1
10395:             .Format = "K"
10396:             .InputMask = "999.99"
10397:             .Visible = .T.
10398:         ENDWITH
10399: 
10400:         *-- Valor I.S.S (top=81)
10401:         loc_oAba.AddObject("lbl_4c_LblValISS", "Label")
10402:         WITH loc_oAba.lbl_4c_LblValISS
10403:             .Caption = "Valor I.S.S"
10404:             .Top = 81
10405:             .Left = 107
10406:             .FontName = "Tahoma"
10407:             .FontSize = 7
10408:             .BackStyle = 0
10409:             .ForeColor = RGB(90,90,90)
10410:             .AutoSize = .T.
10411:             .Visible = .T.
10412:         ENDWITH
10413: 
10414:         loc_oAba.AddObject("txt_4c_ValISSL", "TextBox")
10415:         WITH loc_oAba.txt_4c_ValISSL
10416:             .ControlSource = "crSigCnFNf.lvaliss"
10417:             .Top = 93
10418:             .Left = 107
10419:             .Width = 41
10420:             .Height = 18
10421:             .FontName = "Tahoma"
10422:             .FontSize = 8
10423:             .SpecialEffect = 1
10424:             .Format = "K"
10425:             .InputMask = "999.99"
10426:             .Visible = .T.
10427:         ENDWITH
10428: 
10429:         loc_oAba.AddObject("lbl_4c_ValISSX", "Label")
10430:         WITH loc_oAba.lbl_4c_ValISSX
10431:             .Caption = "x"
10432:             .Top = 95
10433:             .Left = 150
10434:             .FontName = "Tahoma"
10435:             .FontSize = 7
10436:             .BackStyle = 0
10437:             .ForeColor = RGB(90,90,90)
10438:             .AutoSize = .T.
10439:             .Visible = .T.
10440:         ENDWITH
10441: 
10442:         loc_oAba.AddObject("txt_4c_ValISSC", "TextBox")
10443:         WITH loc_oAba.txt_4c_ValISSC
10444:             .ControlSource = "crSigCnFNf.cvaliss"
10445:             .Top = 93
10446:             .Left = 156
10447:             .Width = 41
10448:             .Height = 18
10449:             .FontName = "Tahoma"
10450:             .FontSize = 8
10451:             .SpecialEffect = 1
10452:             .Format = "K"
10453:             .InputMask = "999.99"
10454:             .Visible = .T.
10455:         ENDWITH
10456: 
10457:         *-- Valor Total Servicos (top=113)
10458:         loc_oAba.AddObject("lbl_4c_LblValSrv", "Label")
10459:         WITH loc_oAba.lbl_4c_LblValSrv
10460:             .Caption = "Valor Total Servi" + CHR(231) + "os"
10461:             .Top = 113
10462:             .Left = 107
10463:             .FontName = "Tahoma"
10464:             .FontSize = 7
10465:             .BackStyle = 0
10466:             .ForeColor = RGB(90,90,90)
10467:             .AutoSize = .T.
10468:             .Visible = .T.
10469:         ENDWITH
10470: 
10471:         loc_oAba.AddObject("txt_4c_ValSrvL", "TextBox")
10472:         WITH loc_oAba.txt_4c_ValSrvL
10473:             .ControlSource = "crSigCnFNf.lvalser"
10474:             .Top = 125
10475:             .Left = 107
10476:             .Width = 41
10477:             .Height = 18
10478:             .FontName = "Tahoma"
10479:             .FontSize = 8
10480:             .SpecialEffect = 1
10481:             .Format = "K"
10482:             .InputMask = "999.99"
10483:             .Visible = .T.
10484:         ENDWITH
10485: 
10486:         loc_oAba.AddObject("lbl_4c_ValSrvX", "Label")
10487:         WITH loc_oAba.lbl_4c_ValSrvX
10488:             .Caption = "x"
10489:             .Top = 127
10490:             .Left = 150
10491:             .FontName = "Tahoma"
10492:             .FontSize = 7
10493:             .BackStyle = 0
10494:             .ForeColor = RGB(90,90,90)
10495:             .AutoSize = .T.
10496:             .Visible = .T.
10497:         ENDWITH
10498: 
10499:         loc_oAba.AddObject("txt_4c_ValSrvC", "TextBox")
10500:         WITH loc_oAba.txt_4c_ValSrvC
10501:             .ControlSource = "crSigCnFNf.cvalser"
10502:             .Top = 125
10503:             .Left = 156
10504:             .Width = 41
10505:             .Height = 18
10506:             .FontName = "Tahoma"
10507:             .FontSize = 8
10508:             .SpecialEffect = 1

*-- Linhas 10520 a 11055:
10520:         *-- Shape (top=37, left=399 -- Dados da Operacao)
10521:         loc_oAba.AddObject("shp_4c_OutShape", "Shape")
10522:         WITH loc_oAba.shp_4c_OutShape
10523:             .Top = 37
10524:             .Left = 399
10525:             .Width = 226
10526:             .Height = 119
10527:             .Visible = .T.
10528:         ENDWITH
10529: 
10530:         loc_oAba.AddObject("lbl_4c_LblDadosOp", "Label")
10531:         WITH loc_oAba.lbl_4c_LblDadosOp
10532:             .Caption   = "Dados da Opera" + CHR(231) + CHR(227) + "o"
10533:             .Top       = 39
10534:             .Left      = 405
10535:             .FontName  = "Tahoma"
10536:             .FontSize  = 7
10537:             .BackStyle = 0
10538:             .ForeColor = RGB(90, 90, 90)
10539:             .AutoSize  = .T.
10540:             .Visible   = .T.
10541:         ENDWITH
10542: 
10543:         *-- Especie Padrao (top=67)
10544:         loc_oAba.AddObject("lbl_4c_LblEspPad", "Label")
10545:         WITH loc_oAba.lbl_4c_LblEspPad
10546:             .Caption = "Esp" + CHR(233) + "cie Padr" + CHR(227) + "o : "
10547:             .Top = 67
10548:             .Left = 156
10549:             .FontName = "Tahoma"
10550:             .FontSize = 7
10551:             .BackStyle = 0
10552:             .ForeColor = RGB(90,90,90)
10553:             .AutoSize = .T.
10554:             .Visible = .T.
10555:         ENDWITH
10556: 
10557:         loc_oAba.AddObject("txt_4c_EspPad", "TextBox")
10558:         WITH loc_oAba.txt_4c_EspPad
10559:             .ControlSource = "crSigCnFNf.esppads"
10560:             .Top = 65
10561:             .Left = 243
10562:             .Width = 92
10563:             .Height = 18
10564:             .FontName = "Tahoma"
10565:             .FontSize = 8
10566:             .SpecialEffect = 1
10567:             .Format = "K"
10568:             .InputMask = ""
10569:             .Visible = .T.
10570:         ENDWITH
10571: 
10572:         *-- Marca Padrao (top=42)
10573:         loc_oAba.AddObject("lbl_4c_LblMarPad", "Label")
10574:         WITH loc_oAba.lbl_4c_LblMarPad
10575:             .Caption = "Marca Padr" + CHR(227) + "o : "
10576:             .Top = 42
10577:             .Left = 163
10578:             .FontName = "Tahoma"
10579:             .FontSize = 7
10580:             .BackStyle = 0
10581:             .ForeColor = RGB(90,90,90)
10582:             .AutoSize = .T.
10583:             .Visible = .T.
10584:         ENDWITH
10585: 
10586:         loc_oAba.AddObject("txt_4c_MarPad", "TextBox")
10587:         WITH loc_oAba.txt_4c_MarPad
10588:             .ControlSource = "crSigCnFNf.marpads"
10589:             .Top = 40
10590:             .Left = 243
10591:             .Width = 92
10592:             .Height = 18
10593:             .FontName = "Tahoma"
10594:             .FontSize = 8
10595:             .SpecialEffect = 1
10596:             .Format = "K"
10597:             .InputMask = ""
10598:             .Visible = .T.
10599:         ENDWITH
10600: 
10601:         *-- Fator de Peso Bruto (top=93)
10602:         loc_oAba.AddObject("lbl_4c_LblFatPBru", "Label")
10603:         WITH loc_oAba.lbl_4c_LblFatPBru
10604:             .Caption = "Fator de Peso Bruto : "
10605:             .Top = 93
10606:             .Left = 133
10607:             .FontName = "Tahoma"
10608:             .FontSize = 7
10609:             .BackStyle = 0
10610:             .ForeColor = RGB(90,90,90)
10611:             .AutoSize = .T.
10612:             .Visible = .T.
10613:         ENDWITH
10614: 
10615:         loc_oAba.AddObject("txt_4c_FatPBru", "TextBox")
10616:         WITH loc_oAba.txt_4c_FatPBru
10617:             .ControlSource = "crSigCnFNf.fatbrutos"
10618:             .Top = 91
10619:             .Left = 243
10620:             .Width = 58
10621:             .Height = 18
10622:             .FontName = "Tahoma"
10623:             .FontSize = 8
10624:             .SpecialEffect = 1
10625:             .Format = "K"
10626:             .InputMask = "999.99"
10627:             .Visible = .T.
10628:         ENDWITH
10629: 
10630:         *-- Peso por Volume (top=117)
10631:         loc_oAba.AddObject("lbl_4c_LblPesVol", "Label")
10632:         WITH loc_oAba.lbl_4c_LblPesVol
10633:             .Caption = "Peso por Volume : "
10634:             .Top = 117
10635:             .Left = 150
10636:             .FontName = "Tahoma"
10637:             .FontSize = 7
10638:             .BackStyle = 0
10639:             .ForeColor = RGB(90,90,90)
10640:             .AutoSize = .T.
10641:             .Visible = .T.
10642:         ENDWITH
10643: 
10644:         loc_oAba.AddObject("txt_4c_PesVol", "TextBox")
10645:         WITH loc_oAba.txt_4c_PesVol
10646:             .ControlSource = "crSigCnFNf.pesovols"
10647:             .Top = 115
10648:             .Left = 243
10649:             .Width = 66
10650:             .Height = 18
10651:             .FontName = "Tahoma"
10652:             .FontSize = 8
10653:             .SpecialEffect = 1
10654:             .Format = "K"
10655:             .InputMask = "999.99"
10656:             .Visible = .T.
10657:         ENDWITH
10658: 
10659:         loc_oAba.AddObject("lbl_4c_LblGrs", "Label")
10660:         WITH loc_oAba.lbl_4c_LblGrs
10661:             .Caption = "( grs )"
10662:             .Top = 117
10663:             .Left = 314
10664:             .FontName = "Tahoma"
10665:             .FontSize = 7
10666:             .BackStyle = 0
10667:             .ForeColor = RGB(90,90,90)
10668:             .AutoSize = .T.
10669:             .Visible = .T.
10670:         ENDWITH
10671: 
10672:         *-- Empresa (top=140)
10673:         loc_oAba.AddObject("lbl_4c_LblEmpOpc", "Label")
10674:         WITH loc_oAba.lbl_4c_LblEmpOpc
10675:             .Caption = "Empresa  : "
10676:             .Top = 143
10677:             .Left = 185
10678:             .FontName = "Tahoma"
10679:             .FontSize = 7
10680:             .BackStyle = 0
10681:             .ForeColor = RGB(90,90,90)
10682:             .AutoSize = .T.
10683:             .Visible = .T.
10684:         ENDWITH
10685: 
10686:         loc_oAba.AddObject("txt_4c_EmpPad", "TextBox")
10687:         WITH loc_oAba.txt_4c_EmpPad
10688:             .ControlSource = "crSigCnFNf.emps"
10689:             .Top = 140
10690:             .Left = 243
10691:             .Width = 31
10692:             .Height = 18
10693:             .FontName = "Tahoma"
10694:             .FontSize = 8
10695:             .SpecialEffect = 1
10696:             .Format = "K"
10697:             .InputMask = ""
10698:             .Visible = .T.
10699:         ENDWITH
10700: 
10701:         *-- Validar Sequencia de Notas (top=162)
10702:         loc_oAba.AddObject("chk_4c_ValidSeqNota", "CheckBox")
10703:         WITH loc_oAba.chk_4c_ValidSeqNota
10704:             .ControlSource = "crSigCnFNf.vseqnota"
10705:             .Caption = "Validar Sequ" + CHR(234) + "ncia de Notas :"
10706:             .Top = 162
10707:             .Left = 88
10708:             .Width = 155
10709:             .Height = 15
10710:             .FontName = "Tahoma"
10711:             .FontSize = 7
10712:             .Visible = .T.
10713:             .Sparse = .F.
10714:             .Alignment = 0
10715:             .ReadOnly = .F.
10716:         ENDWITH
10717: 
10718:         *-- Dados da Operacao - Localizacao (top=53, left=405)
10719:         loc_oAba.AddObject("lbl_4c_LblLoc", "Label")
10720:         WITH loc_oAba.lbl_4c_LblLoc
10721:             .Caption = "Localiza" + CHR(231) + CHR(227) + "o"
10722:             .Top = 53
10723:             .Left = 405
10724:             .FontName = "Tahoma"
10725:             .FontSize = 7
10726:             .BackStyle = 0
10727:             .ForeColor = RGB(90,90,90)
10728:             .AutoSize = .T.
10729:             .Visible = .T.
10730:         ENDWITH
10731: 
10732:         loc_oAba.AddObject("txt_4c_LocL", "TextBox")
10733:         WITH loc_oAba.txt_4c_LocL
10734:             .ControlSource = "crSigCnFNf.loploc"
10735:             .Top = 65
10736:             .Left = 405
10737:             .Width = 41
10738:             .Height = 18
10739:             .FontName = "Tahoma"
10740:             .FontSize = 8
10741:             .SpecialEffect = 1
10742:             .Format = "K"
10743:             .InputMask = "999.99"
10744:             .Visible = .T.
10745:         ENDWITH
10746: 
10747:         loc_oAba.AddObject("lbl_4c_LocX", "Label")
10748:         WITH loc_oAba.lbl_4c_LocX
10749:             .Caption = "x"
10750:             .Top = 67
10751:             .Left = 448
10752:             .FontName = "Tahoma"
10753:             .FontSize = 7
10754:             .BackStyle = 0
10755:             .ForeColor = RGB(90,90,90)
10756:             .AutoSize = .T.
10757:             .Visible = .T.
10758:         ENDWITH
10759: 
10760:         loc_oAba.AddObject("txt_4c_LocC", "TextBox")
10761:         WITH loc_oAba.txt_4c_LocC
10762:             .ControlSource = "crSigCnFNf.coploc"
10763:             .Top = 65
10764:             .Left = 454
10765:             .Width = 41
10766:             .Height = 18
10767:             .FontName = "Tahoma"
10768:             .FontSize = 8
10769:             .SpecialEffect = 1
10770:             .Format = "K"
10771:             .InputMask = "999.99"
10772:             .Visible = .T.
10773:         ENDWITH
10774: 
10775:         *-- Vendedor (top=85, left=405)
10776:         loc_oAba.AddObject("lbl_4c_LblVend", "Label")
10777:         WITH loc_oAba.lbl_4c_LblVend
10778:             .Caption = "Vendedor"
10779:             .Top = 85
10780:             .Left = 405
10781:             .FontName = "Tahoma"
10782:             .FontSize = 7
10783:             .BackStyle = 0
10784:             .ForeColor = RGB(90,90,90)
10785:             .AutoSize = .T.
10786:             .Visible = .T.
10787:         ENDWITH
10788: 
10789:         loc_oAba.AddObject("txt_4c_VendL", "TextBox")
10790:         WITH loc_oAba.txt_4c_VendL
10791:             .ControlSource = "crSigCnFNf.lopnvd"
10792:             .Top = 97
10793:             .Left = 405
10794:             .Width = 41
10795:             .Height = 18
10796:             .FontName = "Tahoma"
10797:             .FontSize = 8
10798:             .SpecialEffect = 1
10799:             .Format = "K"
10800:             .InputMask = "999.99"
10801:             .Visible = .T.
10802:         ENDWITH
10803: 
10804:         loc_oAba.AddObject("lbl_4c_VendX", "Label")
10805:         WITH loc_oAba.lbl_4c_VendX
10806:             .Caption = "x"
10807:             .Top = 99
10808:             .Left = 448
10809:             .FontName = "Tahoma"
10810:             .FontSize = 7
10811:             .BackStyle = 0
10812:             .ForeColor = RGB(90,90,90)
10813:             .AutoSize = .T.
10814:             .Visible = .T.
10815:         ENDWITH
10816: 
10817:         loc_oAba.AddObject("txt_4c_VendC", "TextBox")
10818:         WITH loc_oAba.txt_4c_VendC
10819:             .ControlSource = "crSigCnFNf.copnvd"
10820:             .Top = 97
10821:             .Left = 454
10822:             .Width = 41
10823:             .Height = 18
10824:             .FontName = "Tahoma"
10825:             .FontSize = 8
10826:             .SpecialEffect = 1
10827:             .Format = "K"
10828:             .InputMask = "999.99"
10829:             .Visible = .T.
10830:         ENDWITH
10831: 
10832:         *-- Nome do Vendedor (top=85, left=507)
10833:         loc_oAba.AddObject("lbl_4c_LblNomeVend", "Label")
10834:         WITH loc_oAba.lbl_4c_LblNomeVend
10835:             .Caption = "Nome do Vendedor"
10836:             .Top = 85
10837:             .Left = 507
10838:             .FontName = "Tahoma"
10839:             .FontSize = 7
10840:             .BackStyle = 0
10841:             .ForeColor = RGB(90,90,90)
10842:             .AutoSize = .T.
10843:             .Visible = .T.
10844:         ENDWITH
10845: 
10846:         loc_oAba.AddObject("txt_4c_NomeVendL", "TextBox")
10847:         WITH loc_oAba.txt_4c_NomeVendL
10848:             .ControlSource = "crSigCnFNf.lopcvd"
10849:             .Top = 97
10850:             .Left = 507
10851:             .Width = 41
10852:             .Height = 18
10853:             .FontName = "Tahoma"
10854:             .FontSize = 8
10855:             .SpecialEffect = 1
10856:             .Format = "K"
10857:             .InputMask = "999.99"
10858:             .Visible = .T.
10859:         ENDWITH
10860: 
10861:         loc_oAba.AddObject("lbl_4c_NomeVendX", "Label")
10862:         WITH loc_oAba.lbl_4c_NomeVendX
10863:             .Caption = "x"
10864:             .Top = 99
10865:             .Left = 550
10866:             .FontName = "Tahoma"
10867:             .FontSize = 7
10868:             .BackStyle = 0
10869:             .ForeColor = RGB(90,90,90)
10870:             .AutoSize = .T.
10871:             .Visible = .T.
10872:         ENDWITH
10873: 
10874:         loc_oAba.AddObject("txt_4c_NomeVendC", "TextBox")
10875:         WITH loc_oAba.txt_4c_NomeVendC
10876:             .ControlSource = "crSigCnFNf.copcvd"
10877:             .Top = 97
10878:             .Left = 556
10879:             .Width = 41
10880:             .Height = 18
10881:             .FontName = "Tahoma"
10882:             .FontSize = 8
10883:             .SpecialEffect = 1
10884:             .Format = "K"
10885:             .InputMask = "999.99"
10886:             .Visible = .T.
10887:         ENDWITH
10888: 
10889:         *-- Responsavel (top=117, left=405)
10890:         loc_oAba.AddObject("lbl_4c_LblResp", "Label")
10891:         WITH loc_oAba.lbl_4c_LblResp
10892:             .Caption = "Respons" + CHR(225) + "vel"
10893:             .Top = 117
10894:             .Left = 405
10895:             .FontName = "Tahoma"
10896:             .FontSize = 7
10897:             .BackStyle = 0
10898:             .ForeColor = RGB(90,90,90)
10899:             .AutoSize = .T.
10900:             .Visible = .T.
10901:         ENDWITH
10902: 
10903:         loc_oAba.AddObject("txt_4c_RespL", "TextBox")
10904:         WITH loc_oAba.txt_4c_RespL
10905:             .ControlSource = "crSigCnFNf.lopnrp"
10906:             .Top = 129
10907:             .Left = 405
10908:             .Width = 41
10909:             .Height = 18
10910:             .FontName = "Tahoma"
10911:             .FontSize = 8
10912:             .SpecialEffect = 1
10913:             .Format = "K"
10914:             .InputMask = "999.99"
10915:             .Visible = .T.
10916:         ENDWITH
10917: 
10918:         loc_oAba.AddObject("lbl_4c_RespX", "Label")
10919:         WITH loc_oAba.lbl_4c_RespX
10920:             .Caption = "x"
10921:             .Top = 131
10922:             .Left = 448
10923:             .FontName = "Tahoma"
10924:             .FontSize = 7
10925:             .BackStyle = 0
10926:             .ForeColor = RGB(90,90,90)
10927:             .AutoSize = .T.
10928:             .Visible = .T.
10929:         ENDWITH
10930: 
10931:         loc_oAba.AddObject("txt_4c_RespC", "TextBox")
10932:         WITH loc_oAba.txt_4c_RespC
10933:             .ControlSource = "crSigCnFNf.copnrp"
10934:             .Top = 129
10935:             .Left = 454
10936:             .Width = 41
10937:             .Height = 18
10938:             .FontName = "Tahoma"
10939:             .FontSize = 8
10940:             .SpecialEffect = 1
10941:             .Format = "K"
10942:             .InputMask = "999.99"
10943:             .Visible = .T.
10944:         ENDWITH
10945: 
10946:         *-- Nome do Responsavel (top=117, left=507)
10947:         loc_oAba.AddObject("lbl_4c_LblNomeResp", "Label")
10948:         WITH loc_oAba.lbl_4c_LblNomeResp
10949:             .Caption = "Nome do Respons" + CHR(225) + "vel"
10950:             .Top = 117
10951:             .Left = 507
10952:             .FontName = "Tahoma"
10953:             .FontSize = 7
10954:             .BackStyle = 0
10955:             .ForeColor = RGB(90,90,90)
10956:             .AutoSize = .T.
10957:             .Visible = .T.
10958:         ENDWITH
10959: 
10960:         loc_oAba.AddObject("txt_4c_NomeRespL", "TextBox")
10961:         WITH loc_oAba.txt_4c_NomeRespL
10962:             .ControlSource = "crSigCnFNf.lopcvd"
10963:             .Top = 129
10964:             .Left = 507
10965:             .Width = 41
10966:             .Height = 18
10967:             .FontName = "Tahoma"
10968:             .FontSize = 8
10969:             .SpecialEffect = 1
10970:             .Format = "K"
10971:             .InputMask = "999.99"
10972:             .Visible = .T.
10973:         ENDWITH
10974: 
10975:         loc_oAba.AddObject("lbl_4c_NomeRespX", "Label")
10976:         WITH loc_oAba.lbl_4c_NomeRespX
10977:             .Caption = "x"
10978:             .Top = 131
10979:             .Left = 550
10980:             .FontName = "Tahoma"
10981:             .FontSize = 7
10982:             .BackStyle = 0
10983:             .ForeColor = RGB(90,90,90)
10984:             .AutoSize = .T.
10985:             .Visible = .T.
10986:         ENDWITH
10987: 
10988:         loc_oAba.AddObject("txt_4c_NomeRespC", "TextBox")
10989:         WITH loc_oAba.txt_4c_NomeRespC
10990:             .ControlSource = "crSigCnFNf.copcvd"
10991:             .Top = 129
10992:             .Left = 556
10993:             .Width = 41
10994:             .Height = 18
10995:             .FontName = "Tahoma"
10996:             .FontSize = 8
10997:             .SpecialEffect = 1
10998:             .Format = "K"
10999:             .InputMask = "999.99"
11000:             .Visible = .T.
11001:         ENDWITH
11002: 
11003:         *-- N Vias (top=184)
11004:         loc_oAba.AddObject("lbl_4c_LblNVias", "Label")
11005:         WITH loc_oAba.lbl_4c_LblNVias
11006:             .Caption = "N" + CHR(186) + " Vias : "
11007:             .Top = 187
11008:             .Left = 195
11009:             .FontName = "Tahoma"
11010:             .FontSize = 7
11011:             .BackStyle = 0
11012:             .ForeColor = RGB(90,90,90)
11013:             .AutoSize = .T.
11014:             .Visible = .T.
11015:         ENDWITH
11016: 
11017:         loc_oAba.AddObject("txt_4c_NVias", "TextBox")
11018:         WITH loc_oAba.txt_4c_NVias
11019:             .ControlSource = "crSigCnFNf.tipos"
11020:             .Top = 184
11021:             .Left = 243
11022:             .Width = 31
11023:             .Height = 18
11024:             .FontName = "Tahoma"
11025:             .FontSize = 8
11026:             .SpecialEffect = 1
11027:             .Format = "K"
11028:             .InputMask = ""
11029:             .Visible = .T.
11030:         ENDWITH
11031: 
11032:         *-- Fator Proporcao Linha (top=205)
11033:         loc_oAba.AddObject("lbl_4c_LblFatPropLin", "Label")
11034:         WITH loc_oAba.lbl_4c_LblFatPropLin
11035:             .Caption = "Fator Propor" + CHR(231) + CHR(227) + "o Linha : "
11036:             .Top = 205
11037:             .Left = 123
11038:             .FontName = "Tahoma"
11039:             .FontSize = 7
11040:             .BackStyle = 0
11041:             .ForeColor = RGB(90,90,90)
11042:             .AutoSize = .T.
11043:             .Visible = .T.
11044:         ENDWITH
11045: 
11046:         loc_oAba.AddObject("txt_4c_FatPropLin", "TextBox")
11047:         WITH loc_oAba.txt_4c_FatPropLin
11048:             .ControlSource = "crSigCnFNf.tamanhos"
11049:             .Top = 203
11050:             .Left = 243
11051:             .Width = 66
11052:             .Height = 18
11053:             .FontName = "Tahoma"
11054:             .FontSize = 8
11055:             .SpecialEffect = 1

