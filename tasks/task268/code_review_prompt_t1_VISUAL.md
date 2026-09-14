# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (16)
- [ALINHAMENTO] Botao 'cmd_4c_BtnCopiar' tem Top=4 mas grupo usa Top=5 (diferenca de 1px)
- [ALINHAMENTO] Botao 'cmd_4c_CmdProcessa' tem Top=3 mas grupo usa Top=5 (diferenca de 2px)
- [ALINHAMENTO] Botao 'cmd_4c_CmdCopiar' tem Top=3 mas grupo usa Top=5 (diferenca de 2px)
- [ALINHAMENTO] Botao 'cmd_4c_CmdSair' tem Top=3 mas grupo usa Top=5 (diferenca de 2px)
- [FONTNAME-ERRADO] Linha 276: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 315: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 337: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 359: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 381: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 403: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 426: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 573: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 595: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 617: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 868: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 891: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprcom.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2452 linhas total):

*-- Linhas 109 a 125:
109:                 MostrarErro("Erro ao criar Business Object sigprcomBO", "Erro Cr" + CHR(237) + "tico")
110:             ELSE
111:                 *-- Corrigir Caption com acento (CHR nao pode ser usado em DEFINE CLASS)
112:                 THIS.Caption = "Estoque M" + CHR(225) + "ximo"
113: 
114:                 THIS.ConfigurarPageFrame()
115:                 THIS.ConfigurarPaginaLista()
116:                 THIS.ConfigurarPaginaDados()
117: 
118:                 *-- Propagar Caption para labels do cabe" + CHR(231) + "alho
119:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
120:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
121: 
122:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
123:                     *-- Modo externo: produto j" + CHR(225) + " definido, ir direto para Page2
124:                     IF !EMPTY(THIS.this_cPCPros)
125:                         THIS.this_cPCEscolha = "ALTERAR"

*-- Linhas 155 a 182:
155: 
156:     *--------------------------------------------------------------------------
157:     * ConfigurarPageFrame - Configura PageFrame principal
158:     * PageFrame.Top=-29 para ocultar abas; controles compensam +29 no Top
159:     *--------------------------------------------------------------------------
160:     PROTECTED PROCEDURE ConfigurarPageFrame()
161:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
162: 
163:         WITH THIS.pgf_4c_Paginas
164:             .Top       = -29
165:             .Left      = 0
166:             .Width     = 1003
167:             .Height    = 704   && 675 (form.Height) + 29 (compensacao abas)
168:             .PageCount = 2
169:             .Tabs      = .F.
170:             .Visible   = .F.
171:         ENDWITH
172: 
173:         THIS.pgf_4c_Paginas.Page1.Caption   = "Lista"
174:         THIS.pgf_4c_Paginas.Page1.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
175:         THIS.pgf_4c_Paginas.Page1.BackColor = RGB(255, 255, 255)
176: 
177:         THIS.pgf_4c_Paginas.Page2.Caption   = "Dados"
178:         THIS.pgf_4c_Paginas.Page2.Picture   = gc_4c_CaminhoIcones + "new_background.jpg"
179:         THIS.pgf_4c_Paginas.Page2.BackColor = RGB(255, 255, 255)
180:     ENDPROC
181: 
182:     *--------------------------------------------------------------------------

*-- Linhas 193 a 283:
193:         *-- Cabe" + CHR(231) + "alho (equivalente ao cntSombra do legado)
194:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
195:         WITH loc_oPagina.cnt_4c_Cabecalho
196:             .Top         = 1 + 29   && compensacao PageFrame (cntSombra.Top=1)
197:             .Left        = -1
198:             .Width       = 1008
199:             .Height      = 80
200:             .BackColor   = RGB(100, 100, 100)
201:             .BorderWidth = 0
202:             .Visible     = .T.
203:         ENDWITH
204: 
205:         *-- Label sombra (offset 2px para efeito de sombra)
206:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
207:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
208:             .AutoSize  = .F.
209:             .Top       = 15
210:             .Left      = 12
211:             .Width     = 980
212:             .Height    = 40
213:             .Caption   = THIS.Caption
214:             .FontName  = "Tahoma"
215:             .FontSize  = 16
216:             .FontBold  = .T.
217:             .ForeColor = RGB(0, 0, 0)
218:             .BackStyle = 0
219:             .Visible   = .T.
220:         ENDWITH
221: 
222:         *-- Label titulo (branco sobre fundo escuro)
223:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
224:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
225:             .AutoSize  = .F.
226:             .Top       = 18
227:             .Left      = 10
228:             .Width     = 980
229:             .Height    = 46
230:             .Caption   = THIS.Caption
231:             .FontName  = "Tahoma"
232:             .FontSize  = 16
233:             .FontBold  = .T.
234:             .ForeColor = RGB(255, 255, 255)
235:             .BackStyle = 0
236:             .Visible   = .T.
237:         ENDWITH
238: 
239:         *-- Container de bot" + CHR(245) + "es CRUD (equivalente ao Grupo_op do legado)
240:         *-- Grupo_op.Left=544, Grupo_op.Top=-1 + compensacao +29 = 28
241:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
242:         WITH loc_oPagina.cnt_4c_Botoes
243:             .Top         = -1 + 29   && 28
244:             .Left        =  542
245:             .Width       = 385
246:             .Height      = 85
247:             .BackStyle = 0
248:             .BorderWidth = 0
249:             .Visible     = .T.
250:         ENDWITH
251: 
252:         *-- Container de sa" + CHR(237) + "da (padrao canonico - PREVALECE sobre PILAR 1)
253:         *-- Grupo_Saida.Left=919, Top=-1 -> canonico: Left=917, Width=90
254:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
255:         WITH loc_oPagina.cnt_4c_Saida
256:             .Top         = -1 + 29   && 28
257:             .Left        = 917
258:             .Width       = 90
259:             .Height      = 85
260:             .BackStyle   = 0
261:             .BorderWidth = 0
262:             .Visible     = .T.
263:         ENDWITH
264: 
265:         *-- Bot" + CHR(227) + "o Copiar Produto (btnCopiar.Left=474, Top=4 + 29 = 33)
266:         *-- Fora do Grupo_op, posicionado diretamente na Page1
267:         loc_oPagina.AddObject("cmd_4c_BtnCopiar", "CommandButton")
268:         WITH loc_oPagina.cmd_4c_BtnCopiar
269:             .Top             = 4 + 29    && 33
270:             .Left            = 474
271:             .Width           = 75
272:             .Height          = 75
273:             .Caption         = "Copiar Produto"
274:             .Picture         = gc_4c_CaminhoIcones + "geral_duplicar_60.jpg"
275:             .PicturePosition = 13
276:             .FontName        = "Comic Sans MS"
277:             .FontSize        = 8
278:             .FontBold        = .T.
279:             .FontItalic      = .T.
280:             .ForeColor       = RGB(90, 90, 90)
281:             .BackColor       = RGB(255, 255, 255)
282:             .Themes          = .F.
283:             .SpecialEffect   = 0

*-- Linhas 291 a 432:
291:         *-- Top=161 + 29=190 (compensacao PageFrame)
292:         loc_oPagina.AddObject("cnt_4c_Copia", "Container")
293:         WITH loc_oPagina.cnt_4c_Copia
294:             .Top           = 161 + 29   && 190
295:             .Left          = 256
296:             .Width         = 486
297:             .Height        = 373
298:             .SpecialEffect = 0
299:             .BackColor     = RGB(255, 255, 255)
300:             .BackStyle     = 1
301:             .Visible       = .F.    && Inicia oculto - aparece ao clicar "Copiar Produto"
302:             .BorderWidth   = 1
303:         ENDWITH
304: 
305:         *-- ===== BOTOES CRUD dentro de cnt_4c_Botoes (Lefts: 5,80,155,230,305) =====
306:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Inserir", "CommandButton")
307:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir
308:             .Top             = 5
309:             .Left            = 5
310:             .Width           = 75
311:             .Height          = 75
312:             .Caption         = "Inserir"
313:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
314:             .PicturePosition = 13
315:             .FontName        = "Comic Sans MS"
316:             .FontSize        = 8
317:             .FontBold        = .T.
318:             .FontItalic      = .T.
319:             .ForeColor       = RGB(90, 90, 90)
320:             .BackColor       = RGB(255, 255, 255)
321:             .Themes          = .F.
322:             .SpecialEffect   = 0
323:             .WordWrap        = .T.
324:             .MousePointer    = 15
325:             .Visible         = .T.
326:         ENDWITH
327: 
328:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
329:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
330:             .Top             = 5
331:             .Left            = 80
332:             .Width           = 75
333:             .Height          = 75
334:             .Caption         = "Visualizar"
335:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
336:             .PicturePosition = 13
337:             .FontName        = "Comic Sans MS"
338:             .FontSize        = 8
339:             .FontBold        = .T.
340:             .FontItalic      = .T.
341:             .ForeColor       = RGB(90, 90, 90)
342:             .BackColor       = RGB(255, 255, 255)
343:             .Themes          = .F.
344:             .SpecialEffect   = 0
345:             .WordWrap        = .T.
346:             .MousePointer    = 15
347:             .Visible         = .T.
348:         ENDWITH
349: 
350:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
351:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
352:             .Top             = 5
353:             .Left            = 155
354:             .Width           = 75
355:             .Height          = 75
356:             .Caption         = "Alterar"
357:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
358:             .PicturePosition = 13
359:             .FontName        = "Comic Sans MS"
360:             .FontSize        = 8
361:             .FontBold        = .T.
362:             .FontItalic      = .T.
363:             .ForeColor       = RGB(90, 90, 90)
364:             .BackColor       = RGB(255, 255, 255)
365:             .Themes          = .F.
366:             .SpecialEffect   = 0
367:             .WordWrap        = .T.
368:             .MousePointer    = 15
369:             .Visible         = .T.
370:         ENDWITH
371: 
372:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
373:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
374:             .Top             = 5
375:             .Left            = 230
376:             .Width           = 75
377:             .Height          = 75
378:             .Caption         = "Excluir"
379:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
380:             .PicturePosition = 13
381:             .FontName        = "Comic Sans MS"
382:             .FontSize        = 8
383:             .FontBold        = .T.
384:             .FontItalic      = .T.
385:             .ForeColor       = RGB(90, 90, 90)
386:             .BackColor       = RGB(255, 255, 255)
387:             .Themes          = .F.
388:             .SpecialEffect   = 0
389:             .WordWrap        = .T.
390:             .MousePointer    = 15
391:             .Visible         = .T.
392:         ENDWITH
393: 
394:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
395:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
396:             .Top             = 5
397:             .Left            = 305
398:             .Width           = 75
399:             .Height          = 75
400:             .Caption         = "Buscar"
401:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
402:             .PicturePosition = 13
403:             .FontName        = "Comic Sans MS"
404:             .FontSize        = 8
405:             .FontBold        = .T.
406:             .FontItalic      = .T.
407:             .ForeColor       = RGB(90, 90, 90)
408:             .BackColor       = RGB(255, 255, 255)
409:             .Themes          = .F.
410:             .SpecialEffect   = 0
411:             .WordWrap        = .T.
412:             .MousePointer    = 15
413:             .Visible         = .T.
414:         ENDWITH
415: 
416:         *-- Botao Encerrar no cnt_4c_Saida (padrao canonico)
417:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
418:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
419:             .Top             = 5
420:             .Left            = 5
421:             .Width           = 75
422:             .Height          = 75
423:             .Caption         = "Encerrar"
424:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
425:             .PicturePosition = 13
426:             .FontName        = "Comic Sans MS"
427:             .FontSize        = 8
428:             .FontBold        = .T.
429:             .FontItalic      = .T.
430:             .ForeColor       = RGB(90, 90, 90)
431:             .BackColor       = RGB(255, 255, 255)
432:             .Themes          = .F.

*-- Linhas 443 a 452:
443:         loc_oPagina.grd_4c_Lista.RecordSource = ""
444:         loc_oPagina.grd_4c_Lista.ColumnCount  = 6
445:         WITH loc_oPagina.grd_4c_Lista
446:             .Top                = 88 + 29   && 117
447:             .Left               = 26
448:             .Width              = 860
449:             .Height             = 553
450:             .FontName           = "Verdana"
451:             .FontSize           = 8
452:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 473 a 544:
473: 
474:         *-- ===== Conteudo do painel de copia (cnt_4c_Copia) =====
475:         *-- Labels de identificacao das empresas
476:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Lbl_empresa", "Label")
477:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Lbl_empresa
478:             .Top       = 35
479:             .Left      = 35
480:             .Width     = 87
481:             .Height    = 17
482:             .Caption   = "Empresa Origem :"
483:             .FontName  = "Tahoma"
484:             .FontSize  = 8
485:             .ForeColor = RGB(90, 90, 90)
486:             .BackStyle = 0
487:             .AutoSize  = .F.
488:             .Visible   = .T.
489:         ENDWITH
490: 
491:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label2", "Label")
492:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label2
493:             .Top       = 60
494:             .Left      = 33
495:             .Width     = 89
496:             .Height    = 17
497:             .Caption   = "Empresa Destino :"
498:             .FontName  = "Tahoma"
499:             .FontSize  = 8
500:             .ForeColor = RGB(90, 90, 90)
501:             .BackStyle = 0
502:             .AutoSize  = .F.
503:             .Visible   = .T.
504:         ENDWITH
505: 
506:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label1", "Label")
507:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label1
508:             .Top       = 85
509:             .Left      = 35
510:             .Width     = 85
511:             .Height    = 17
512:             .Caption   = "Procura Produto :"
513:             .FontName  = "Tahoma"
514:             .FontSize  = 8
515:             .ForeColor = RGB(90, 90, 90)
516:             .BackStyle = 0
517:             .AutoSize  = .F.
518:             .Visible   = .T.
519:         ENDWITH
520: 
521:         *-- TextBoxes de filtro da copia
522:         loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_EmpOs", "TextBox")
523:         WITH loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs
524:             .Top       = 31
525:             .Left      = 124
526:             .Width     = 31
527:             .Height    = 23
528:             .InputMask = "XXX"
529:             .Value     = ""
530:             .MaxLength = 3
531:             .FontName  = "Tahoma"
532:             .FontSize  = 8
533:             .Visible   = .T.
534:         ENDWITH
535: 
536:         loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_EmpDs", "TextBox")
537:         WITH loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs
538:             .Top       = 56
539:             .Left      = 124
540:             .Width     = 31
541:             .Height    = 23
542:             .InputMask = "XXX"
543:             .Value     = ""
544:             .MaxLength = 3

*-- Linhas 550 a 624:
550: 
551:         loc_oPagina.cnt_4c_Copia.AddObject("txt_4c_Produto", "TextBox")
552:         WITH loc_oPagina.cnt_4c_Copia.txt_4c_Produto
553:             .Top       = 81
554:             .Left      = 124
555:             .Width     = 108
556:             .Height    = 23
557:             .Value     = ""
558:             .FontName  = "Tahoma"
559:             .FontSize  = 8
560:             .Visible   = .T.
561:         ENDWITH
562: 
563:         *-- Botoes de acao do painel de copia
564:         loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CmdProcessa", "CommandButton")
565:         WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CmdProcessa
566:             .Top             = 3
567:             .Left            = 256
568:             .Width           = 75
569:             .Height          = 75
570:             .Caption         = "\<Processar"
571:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
572:             .PicturePosition = 13
573:             .FontName        = "Comic Sans MS"
574:             .FontSize        = 8
575:             .FontBold        = .T.
576:             .FontItalic      = .T.
577:             .ForeColor       = RGB(90, 90, 90)
578:             .BackColor       = RGB(255, 255, 255)
579:             .Themes          = .F.
580:             .SpecialEffect   = 0
581:             .WordWrap        = .T.
582:             .MousePointer    = 15
583:             .Visible         = .T.
584:         ENDWITH
585: 
586:         loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CmdCopiar", "CommandButton")
587:         WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CmdCopiar
588:             .Top             = 3
589:             .Left            = 332
590:             .Width           = 75
591:             .Height          = 75
592:             .Caption         = "Confirma"
593:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
594:             .PicturePosition = 13
595:             .FontName        = "Comic Sans MS"
596:             .FontSize        = 8
597:             .FontBold        = .T.
598:             .FontItalic      = .T.
599:             .ForeColor       = RGB(90, 90, 90)
600:             .BackColor       = RGB(255, 255, 255)
601:             .Themes          = .F.
602:             .SpecialEffect   = 0
603:             .WordWrap        = .T.
604:             .MousePointer    = 15
605:             .Visible         = .T.
606:         ENDWITH
607: 
608:         loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_CmdSair", "CommandButton")
609:         WITH loc_oPagina.cnt_4c_Copia.cmd_4c_CmdSair
610:             .Top             = 3
611:             .Left            = 407
612:             .Width           = 75
613:             .Height          = 75
614:             .Caption         = "Encerrar"
615:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
616:             .PicturePosition = 13
617:             .FontName        = "Comic Sans MS"
618:             .FontSize        = 8
619:             .FontBold        = .T.
620:             .FontItalic      = .T.
621:             .ForeColor       = RGB(90, 90, 90)
622:             .BackColor       = RGB(255, 255, 255)
623:             .Themes          = .F.
624:             .SpecialEffect   = 0

*-- Linhas 633 a 642:
633:         loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.RecordSource = ""
634:         loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.ColumnCount  = 6
635:         WITH loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia
636:             .Top              = 131
637:             .Left             = 27
638:             .Width            = 403
639:             .Height           = 184
640:             .FontName         = "Tahoma"
641:             .FontSize         = 8
642:             .BackColor        = RGB(255, 255, 255)

*-- Linhas 648 a 978:
648:             .ScrollBars       = 2
649:             .GridLines        = 3
650:             .Visible          = .T.
651:             *-- Column1: CheckBox de selecao (Sparse=.F. obrigatorio para mostrar em todas as linhas)
652:             .Column1.Width    = 30
653:             .Column1.Sparse   = .F.
654:             *-- Column2..6: campos de dados
655:             .Column2.Width    = 70
656:             .Column3.Width    = 65
657:             .Column4.Width    = 50
658:             .Column5.Width    = 50
659:             .Column6.Width    = 120
660:             *-- Headers (serao reconfigurados em BtnProcessarCopiaClick apos RecordSource)
661:             .Column1.Header1.Caption = ""
662:             .Column2.Header1.Caption = "Produto"
663:             .Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
664:             .Column4.Header1.Caption = "Tam"
665:             .Column5.Header1.Caption = "Cor"
666:             .Column6.Header1.Caption = "Departamento"
667:         ENDWITH
668: 
669:         *-- CheckBox na Column1 do grd_4c_DadosCopia
670:         loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.Column1.AddObject("chk_4c_Check1", "CheckBox")
671:         WITH loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.Column1.chk_4c_Check1
672:             .Caption = ""
673:             .FontName = "Tahoma"
674:             .FontSize = 8
675:             .Visible  = .T.
676:         ENDWITH
677:         loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.Column1.CurrentControl = "chk_4c_Check1"
678: 
679:         *-- Botoes Marcar/Desmarcar (standalone com icone - Themes=.T. obrigatorio)
680:         loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_Marcar", "CommandButton")
681:         WITH loc_oPagina.cnt_4c_Copia.cmd_4c_Marcar
682:             .Top             = 234
683:             .Left            = 434
684:             .Width           = 40
685:             .Height          = 40
686:             .Caption         = ""
687:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
688:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
689:             .PicturePosition = 13
690:             .Themes          = .T.
691:             .SpecialEffect   = 0
692:             .ToolTipText     = "Selecionar todos"
693:             .MousePointer    = 15
694:             .Visible         = .T.
695:         ENDWITH
696: 
697:         loc_oPagina.cnt_4c_Copia.AddObject("cmd_4c_Desmarcar", "CommandButton")
698:         WITH loc_oPagina.cnt_4c_Copia.cmd_4c_Desmarcar
699:             .Top             = 274
700:             .Left            = 434
701:             .Width           = 40
702:             .Height          = 40
703:             .Caption         = ""
704:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
705:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
706:             .PicturePosition = 13
707:             .Themes          = .T.
708:             .SpecialEffect   = 0
709:             .ToolTipText     = "Desmarcar todos"
710:             .MousePointer    = 15
711:             .Visible         = .T.
712:         ENDWITH
713: 
714:         *-- Labels de legenda de cores (Vermelho/Azul/Preto)
715:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label3", "Label")
716:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label3
717:             .Top       = 317
718:             .Left      = 40
719:             .Width     = 74
720:             .Height    = 15
721:             .Caption   = "Vermelho : "
722:             .ForeColor = RGB(255, 0, 0)
723:             .FontName  = "Tahoma"
724:             .FontSize  = 8
725:             .FontBold  = .T.
726:             .BackStyle = 0
727:             .AutoSize  = .F.
728:             .Visible   = .T.
729:         ENDWITH
730: 
731:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label4", "Label")
732:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label4
733:             .Top       = 317
734:             .Left      = 118
735:             .Width     = 250
736:             .Height    = 15
737:             .Caption   = "Produtos existem na Origem e no Destino."
738:             .ForeColor = RGB(90, 90, 90)
739:             .FontName  = "Tahoma"
740:             .FontSize  = 8
741:             .BackStyle = 0
742:             .AutoSize  = .F.
743:             .Visible   = .T.
744:         ENDWITH
745: 
746:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label6", "Label")
747:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label6
748:             .Top       = 333
749:             .Left      = 45
750:             .Width     = 70
751:             .Height    = 15
752:             .Caption   = "Azul : "
753:             .ForeColor = RGB(0, 0, 255)
754:             .FontName  = "Tahoma"
755:             .FontSize  = 8
756:             .FontBold  = .T.
757:             .BackStyle = 0
758:             .AutoSize  = .F.
759:             .Visible   = .T.
760:         ENDWITH
761: 
762:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label5", "Label")
763:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label5
764:             .Top       = 333
765:             .Left      = 118
766:             .Width     = 274
767:             .Height    = 15
768:             .Caption   = "Produtos existem no Destino mas n" + CHR(227) + "o existem na Origem"
769:             .ForeColor = RGB(90, 90, 90)
770:             .FontName  = "Tahoma"
771:             .FontSize  = 8
772:             .BackStyle = 0
773:             .AutoSize  = .F.
774:             .Visible   = .T.
775:         ENDWITH
776: 
777:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label7", "Label")
778:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label7
779:             .Top       = 349
780:             .Left      = 45
781:             .Width     = 70
782:             .Height    = 15
783:             .Caption   = "Preto : "
784:             .ForeColor = RGB(0, 0, 0)
785:             .FontName  = "Tahoma"
786:             .FontSize  = 8
787:             .FontBold  = .T.
788:             .BackStyle = 0
789:             .AutoSize  = .F.
790:             .Visible   = .T.
791:         ENDWITH
792: 
793:         loc_oPagina.cnt_4c_Copia.AddObject("lbl_4c_Label8", "Label")
794:         WITH loc_oPagina.cnt_4c_Copia.lbl_4c_Label8
795:             .Top       = 349
796:             .Left      = 118
797:             .Width     = 274
798:             .Height    = 15
799:             .Caption   = "Produtos existem na Origem mas n" + CHR(227) + "o existem no Destino"
800:             .ForeColor = RGB(90, 90, 90)
801:             .FontName  = "Tahoma"
802:             .FontSize  = 8
803:             .BackStyle = 0
804:             .AutoSize  = .F.
805:             .Visible   = .T.
806:         ENDWITH
807: 
808:         THIS.TornarControlesVisiveis(loc_oPagina)
809: 
810:         *-- ===== BINDEVENTs dos botoes CRUD (Page1) =====
811:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Inserir,    "Click", THIS, "BtnIncluirClick")
812:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
813:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
814:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
815:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
816:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
817:         BINDEVENT(loc_oPagina.cmd_4c_BtnCopiar,                "Click", THIS, "BtnCopiarClick")
818: 
819:         *-- BINDEVENTs dos botoes do painel de copia
820:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CmdProcessa, "Click", THIS, "BtnProcessarCopiaClick")
821:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CmdCopiar,   "Click", THIS, "BtnConfirmarCopiaClick")
822:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_CmdSair,     "Click", THIS, "BtnSairCopiaClick")
823:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_Marcar,      "Click", THIS, "BtnMarcarCopiaClick")
824:         BINDEVENT(loc_oPagina.cnt_4c_Copia.cmd_4c_Desmarcar,   "Click", THIS, "BtnDesmarcarCopiaClick")
825: 
826:         *-- BINDEVENT para LostFocus de EmpOs (habilita EmpDs quando preenchido)
827:         BINDEVENT(loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs, "KeyPress", THIS, "EmpOsLostFocus")
828:     ENDPROC
829: 
830:     *--------------------------------------------------------------------------
831:     * ConfigurarPaginaDados - Configura Page2 (Dados do produto + grade de maximos)
832:     * Fase 5: botoes acao + labels + textboxes produto/grupo + optiongroup situacao
833:     * Fase 6: textboxes fornecedor/ref + botao excluir + gradei
834:     *--------------------------------------------------------------------------
835:     PROTECTED PROCEDURE ConfigurarPaginaDados()
836:         LOCAL loc_oPagina
837:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
838: 
839:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
840:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
841: 
842:         *-- Container de botoes de acao (Confirmar/Cancelar)
843:         *-- Grupo_Salva.Left=843, Grupo_Salva.Top=-3 + 29 = 26
844:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
845:         WITH loc_oPagina.cnt_4c_BotoesAcao
846:             .Top         = -3 + 29   && 26
847:             .Left        = 843
848:             .Width       = 160
849:             .Height      = 85
850:             .BackStyle   = 0
851:             .BorderWidth = 0
852:             .Visible     = .T.
853:         ENDWITH
854: 
855:         *-- Botao Confirmar (salva maximos e volta para lista)
856:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
857:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
858:             .Top             = 5
859:             .Left            = 5
860:             .Width           = 75
861:             .Height          = 75
862:             .Caption         = "Confirmar"
863:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
864:             .PicturePosition = 13
865:             .FontName        = "Comic Sans MS"
866:             .FontSize        = 8
867:             .FontBold        = .T.
868:             .FontItalic      = .T.
869:             .ForeColor       = RGB(90, 90, 90)
870:             .BackColor       = RGB(255, 255, 255)
871:             .Themes          = .F.
872:             .SpecialEffect   = 0
873:             .WordWrap        = .T.
874:             .MousePointer    = 15
875:             .Visible         = .T.
876:         ENDWITH
877: 
878:         *-- Botao Cancelar (descarta e volta para lista)
879:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
880:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
881:             .Top             = 5
882:             .Left            = 80
883:             .Width           = 75
884:             .Height          = 75
885:             .Caption         = "Encerrar"
886:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
887:             .PicturePosition = 13
888:             .FontName        = "Comic Sans MS"
889:             .FontSize        = 8
890:             .FontBold        = .T.
891:             .FontItalic      = .T.
892:             .ForeColor       = RGB(90, 90, 90)
893:             .BackColor       = RGB(255, 255, 255)
894:             .Themes          = .F.
895:             .SpecialEffect   = 0
896:             .WordWrap        = .T.
897:             .MousePointer    = 15
898:             .Visible         = .T.
899:         ENDWITH
900: 
901:         *-- ===== LABELS (primeira metade: produto, grupo, fornecedor, ref, situacao) =====
902:         *-- Label Produto (Say1): top=79+29=108, left=260, width=47
903:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
904:         WITH loc_oPagina.lbl_4c_Label1
905:             .Top       = 79 + 29
906:             .Left      = 260
907:             .Width     = 47
908:             .Height    = 15
909:             .Caption   = "Produto :"
910:             .FontName  = "Tahoma"
911:             .FontSize  = 8
912:             .ForeColor = RGB(90, 90, 90)
913:             .BackStyle = 0
914:             .AutoSize  = .F.
915:             .Visible   = .T.
916:         ENDWITH
917: 
918:         *-- Label Grupo (Say8): top=105+29=134, left=269, width=38
919:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
920:         WITH loc_oPagina.lbl_4c_Label8
921:             .Top       = 105 + 29
922:             .Left      = 269
923:             .Width     = 38
924:             .Height    = 15
925:             .Caption   = "Grupo :"
926:             .FontName  = "Tahoma"
927:             .FontSize  = 8
928:             .ForeColor = RGB(90, 90, 90)
929:             .BackStyle = 0
930:             .AutoSize  = .F.
931:             .Visible   = .T.
932:         ENDWITH
933: 
934:         *-- Label Fornecedor (Say11): top=130+29=159, left=243, width=64
935:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
936:         WITH loc_oPagina.lbl_4c_Label11
937:             .Top       = 130 + 29
938:             .Left      = 243
939:             .Width     = 64
940:             .Height    = 15
941:             .Caption   = "Fornecedor :"
942:             .FontName  = "Tahoma"
943:             .FontSize  = 8
944:             .ForeColor = RGB(90, 90, 90)
945:             .BackStyle = 0
946:             .AutoSize  = .F.
947:             .Visible   = .T.
948:         ENDWITH
949: 
950:         *-- Label Ref. Fornecedor (Say12): top=156+29=185, left=219, width=88
951:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
952:         WITH loc_oPagina.lbl_4c_Label12
953:             .Top       = 156 + 29
954:             .Left      = 219
955:             .Width     = 88
956:             .Height    = 15
957:             .Caption   = "Ref. Fornecedor :"
958:             .FontName  = "Tahoma"
959:             .FontSize  = 8
960:             .ForeColor = RGB(90, 90, 90)
961:             .BackStyle = 0
962:             .AutoSize  = .F.
963:             .Visible   = .T.
964:         ENDWITH
965: 
966:         *-- Label Situacao (Say19): top=105+29=134, left=505
967:         loc_oPagina.AddObject("lbl_4c_Label19", "Label")
968:         WITH loc_oPagina.lbl_4c_Label19
969:             .Top       = 105 + 29
970:             .Left      = 505
971:             .Width     = 50
972:             .Height    = 15
973:             .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
974:             .FontName  = "Tahoma"
975:             .FontSize  = 8
976:             .ForeColor = RGB(90, 90, 90)
977:             .BackStyle = 0
978:             .AutoSize  = .F.

*-- Linhas 984 a 1007:
984:         *-- top=75+29=104, left=309, width=108, height=23
985:         loc_oPagina.AddObject("txt_4c__produto", "TextBox")
986:         WITH loc_oPagina.txt_4c__produto
987:             .Top       = 75 + 29
988:             .Left      = 309
989:             .Width     = 108
990:             .Height    = 23
991:             .Value     = ""
992:             .FontName  = "Tahoma"
993:             .FontSize  = 8
994:             .Visible   = .T.
995:         ENDWITH
996: 
997:         *-- txt_4c_Dpro (getDpro): descricao do produto - somente leitura
998:         *-- top=75+29=104, left=419, width=360, height=23
999:         loc_oPagina.AddObject("txt_4c_Dpro", "TextBox")
1000:         WITH loc_oPagina.txt_4c_Dpro
1001:             .Top       = 75 + 29
1002:             .Left      = 419
1003:             .Width     = 360
1004:             .Height    = 23
1005:             .Value     = ""
1006:             .ReadOnly  = .T.
1007:             .BackColor = RGB(220, 220, 220)

*-- Linhas 1015 a 1024:
1015:         *-- top=101+29=130, left=309, width=31, height=23
1016:         loc_oPagina.AddObject("txt_4c_Cgru", "TextBox")
1017:         WITH loc_oPagina.txt_4c_Cgru
1018:             .Top       = 101 + 29
1019:             .Left      = 309
1020:             .Width     = 31
1021:             .Height    = 23
1022:             .Value     = ""
1023:             .ReadOnly  = .T.
1024:             .BackColor = RGB(220, 220, 220)

*-- Linhas 1031 a 1040:
1031:         *-- top=101+29=130, left=343, width=150, height=23
1032:         loc_oPagina.AddObject("txt_4c_Dgru", "TextBox")
1033:         WITH loc_oPagina.txt_4c_Dgru
1034:             .Top       = 101 + 29
1035:             .Left      = 343
1036:             .Width     = 150
1037:             .Height    = 23
1038:             .Value     = ""
1039:             .ReadOnly  = .T.
1040:             .BackColor = RGB(220, 220, 220)

*-- Linhas 1047 a 1076:
1047:         *-- top=100+29=129, left=555, width=117, height=25; ButtonCount=2 (1=Ativo, 2=Inativo)
1048:         loc_oPagina.AddObject("obj_4c_Opc_situacao", "OptionGroup")
1049:         WITH loc_oPagina.obj_4c_Opc_situacao
1050:             .Top         = 100 + 29
1051:             .Left        = 555
1052:             .Width       = 117
1053:             .Height      = 25
1054:             .ButtonCount = 2
1055:             .BackStyle   = 0
1056:             .BorderStyle = 0
1057:             .Value       = 1
1058:             .Visible     = .T.
1059:             WITH .Buttons(1)
1060:                 .Caption   = "Ativo"
1061:                 .Left      = 5
1062:                 .Top       = 5
1063:                 .Width     = 50
1064:                 .AutoSize  = .T.
1065:                 .ForeColor = RGB(90, 90, 90)
1066:                 .Themes    = .F.
1067:             ENDWITH
1068:             WITH .Buttons(2)
1069:                 .Caption   = "Inativo"
1070:                 .Left      = 58
1071:                 .Top       = 5
1072:                 .Width     = 55
1073:                 .AutoSize  = .T.
1074:                 .FontName  = "Tahoma"
1075:                 .FontSize  = 8
1076:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1082 a 1091:
1082:         *-- txt_4c_Ifor: codigo do fornecedor - somente leitura (top=130+29=159)
1083:         loc_oPagina.AddObject("txt_4c_Ifor", "TextBox")
1084:         WITH loc_oPagina.txt_4c_Ifor
1085:             .Top       = 130 + 29
1086:             .Left      = 309
1087:             .Width     = 80
1088:             .Height    = 23
1089:             .Value     = ""
1090:             .ReadOnly  = .T.
1091:             .BackColor = RGB(220, 220, 220)

*-- Linhas 1097 a 1106:
1097:         *-- txt_4c_Dfor: nome do fornecedor - somente leitura (top=130+29=159)
1098:         loc_oPagina.AddObject("txt_4c_Dfor", "TextBox")
1099:         WITH loc_oPagina.txt_4c_Dfor
1100:             .Top       = 130 + 29
1101:             .Left      = 392
1102:             .Width     = 220
1103:             .Height    = 23
1104:             .Value     = ""
1105:             .ReadOnly  = .T.
1106:             .BackColor = RGB(220, 220, 220)

*-- Linhas 1112 a 1140:
1112:         *-- txt_4c_Refs: referencia do fornecedor - somente leitura (top=156+29=185)
1113:         loc_oPagina.AddObject("txt_4c_Refs", "TextBox")
1114:         WITH loc_oPagina.txt_4c_Refs
1115:             .Top       = 156 + 29
1116:             .Left      = 309
1117:             .Width     = 150
1118:             .Height    = 23
1119:             .Value     = ""
1120:             .ReadOnly  = .T.
1121:             .BackColor = RGB(220, 220, 220)
1122:             .FontName  = "Tahoma"
1123:             .FontSize  = 8
1124:             .Visible   = .T.
1125:         ENDWITH
1126: 
1127:         *-- ===== BOTAO EXCLUIR LINHAS (Fase 6) =====
1128:         *-- cmd_4c_BtnExcluir: exclui linhas da empresa corrente na grade
1129:         loc_oPagina.AddObject("cmd_4c_BtnExcluir", "CommandButton")
1130:         WITH loc_oPagina.cmd_4c_BtnExcluir
1131:             .Top             = 414
1132:             .Left            = 700
1133:             .Width           = 40
1134:             .Height          = 40
1135:             .Caption         = ""
1136:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1137:             .PicturePosition = 7
1138:             .Themes          = .T.
1139:             .SpecialEffect   = 0
1140:             .MousePointer    = 15

*-- Linhas 1152 a 1161:
1152:         loc_oPagina.grd_4c_Gradei.ColumnCount  = 5
1153: 
1154:         WITH loc_oPagina.grd_4c_Gradei
1155:             .Top          = 181 + 29
1156:             .Left         = 309
1157:             .Width        = 387
1158:             .Height       = 472
1159:             .ReadOnly     = .F.
1160:             .DeleteMark   = .F.
1161:             .RecordMark   = .F.

*-- Linhas 1171 a 1179:
1171:                 .Width         = 40
1172:                 .Sparse        = .F.
1173:                 WITH .Header1
1174:                     .Caption  = "Empresa"
1175:                     .FontName = "Tahoma"
1176:                     .FontSize = 8
1177:                     .FontBold = .T.
1178:                 ENDWITH
1179:                 WITH .Text1

*-- Linhas 1188 a 1196:
1188:                 .Width         = 65
1189:                 .Sparse        = .F.
1190:                 WITH .Header1
1191:                     .Caption  = "Qtde.M" + CHR(225) + "x."
1192:                     .FontName = "Tahoma"
1193:                     .FontSize = 8
1194:                     .FontBold = .T.
1195:                 ENDWITH
1196:                 WITH .Text1

*-- Linhas 1206 a 1214:
1206:                 .Width         = 55
1207:                 .Sparse        = .F.
1208:                 WITH .Header1
1209:                     .Caption  = "Tam."
1210:                     .FontName = "Tahoma"
1211:                     .FontSize = 8
1212:                     .FontBold = .T.
1213:                 ENDWITH
1214:                 WITH .Text1

*-- Linhas 1223 a 1231:
1223:                 .Width         = 55
1224:                 .Sparse        = .F.
1225:                 WITH .Header1
1226:                     .Caption  = "Cor"
1227:                     .FontName = "Tahoma"
1228:                     .FontSize = 8
1229:                     .FontBold = .T.
1230:                 ENDWITH
1231:                 WITH .Text1

*-- Linhas 1240 a 1248:
1240:                 .Width         = 172
1241:                 .Sparse        = .F.
1242:                 WITH .Header1
1243:                     .Caption  = "Departamento"
1244:                     .FontName = "Tahoma"
1245:                     .FontSize = 8
1246:                     .FontBold = .T.
1247:                 ENDWITH
1248:                 WITH .Text1

*-- Linhas 1256 a 1271:
1256:         THIS.TornarControlesVisiveis(loc_oPagina)
1257: 
1258:         *-- BINDEVENTs dos botoes de Page2
1259:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1260:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1261: 
1262:         *-- BINDEVENT para busca de produto via F4
1263:         BINDEVENT(loc_oPagina.txt_4c__produto, "KeyPress", THIS, "ProdutoKeyPress")
1264: 
1265:         *-- BINDEVENTs da grade de maximos (Fase 6)
1266:         BINDEVENT(loc_oPagina.cmd_4c_BtnExcluir,             "Click",             THIS, "BtnExcluirGradeClick")
1267:         BINDEVENT(loc_oPagina.grd_4c_Gradei,                 "AfterRowColChange", THIS, "GradeIAfterRowColChange")
1268:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column2.Text1,   "KeyPress",         THIS, "QmaxsLostFocus")
1269:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column3.Text1,   "KeyPress",          THIS, "TamKeyPress")
1270:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column4.Text1,   "KeyPress",          THIS, "CorKeyPress")
1271:         BINDEVENT(loc_oPagina.grd_4c_Gradei.Column5.Text1,   "KeyPress",          THIS, "DptKeyPress")

*-- Linhas 1302 a 1315:
1302:                         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.situas"
1303: 
1304:                         *-- Headers: OBRIGATORIO re-setar apos RecordSource (VFP9 reseta)
1305:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1306:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1307:                         loc_oGrid.Column3.Header1.Caption = "Grupo"
1308:                         loc_oGrid.Column4.Header1.Caption = "Fornecedor"
1309:                         loc_oGrid.Column5.Header1.Caption = "Refer" + CHR(234) + "ncia"
1310:                         loc_oGrid.Column6.Header1.Caption = "St"
1311: 
1312:                         THIS.FormatarGridLista(loc_oGrid)
1313:                         loc_lResultado = .T.
1314:                     ENDIF
1315:                 ENDIF

*-- Linhas 1593 a 1613:
1593:                 MsgAviso("Voc" + CHR(234) + " n" + CHR(227) + "o tem permiss" + CHR(227) + "o para copiar entre empresas.", "Acesso Negado")
1594:             ELSE
1595:                 loc_oPagina.grd_4c_Lista.Visible     = .F.
1596:                 loc_oPagina.cnt_4c_Botoes.Visible    = .F.
1597:                 loc_oPagina.cnt_4c_Saida.Visible     = .F.
1598:                 loc_oPagina.cmd_4c_BtnCopiar.Visible = .F.
1599: 
1600:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.Value   = ""
1601:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Value   = ""
1602:                 loc_oPagina.cnt_4c_Copia.txt_4c_Produto.Value = ""
1603:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpDs.Enabled = .F.
1604: 
1605:                 IF USED("cursor_4c_Copia")
1606:                     USE IN cursor_4c_Copia
1607:                 ENDIF
1608:                 loc_oPagina.cnt_4c_Copia.grd_4c_DadosCopia.RecordSource = ""
1609: 
1610:                 loc_oPagina.cnt_4c_Copia.Visible = .T.
1611:                 loc_oPagina.cnt_4c_Copia.txt_4c_EmpOs.SetFocus()
1612:             ENDIF
1613:         CATCH TO loc_oErro

*-- Linhas 1673 a 1686:
1673:                             loc_oGrid.Column6.ControlSource = "cursor_4c_Copia.deptos"
1674: 
1675:                             *-- Headers: re-setar apos RecordSource (VFP9 reseta)
1676:                             loc_oGrid.Column1.Header1.Caption = ""
1677:                             loc_oGrid.Column2.Header1.Caption = "Produto"
1678:                             loc_oGrid.Column3.Header1.Caption = "Qtde. M" + CHR(225) + "x."
1679:                             loc_oGrid.Column4.Header1.Caption = "Tam"
1680:                             loc_oGrid.Column5.Header1.Caption = "Cor"
1681:                             loc_oGrid.Column6.Header1.Caption = "Departamento"
1682: 
1683:                             GO TOP IN cursor_4c_Copia
1684:                             loc_lResultado = .T.
1685:                         ELSE
1686:                             MsgAviso("Nenhum produto encontrado para c" + CHR(243) + "pia.", "Aviso")

*-- Linhas 1743 a 1763:
1743:         TRY
1744:             loc_oPagina.cnt_4c_Copia.Visible     = .F.
1745:             loc_oPagina.grd_4c_Lista.Visible      = .T.
1746:             loc_oPagina.cnt_4c_Botoes.Visible     = .T.
1747:             loc_oPagina.cnt_4c_Saida.Visible      = .T.
1748:             loc_oPagina.cmd_4c_BtnCopiar.Visible  = .T.
1749: 
1750:             IF USED("cursor_4c_Copia")
1751:                 USE IN cursor_4c_Copia
1752:             ENDIF
1753:         CATCH TO loc_oErro
1754:             MsgErro("Erro em BtnSairCopiaClick: " + loc_oErro.Message, "Erro")
1755:         ENDTRY
1756:     ENDPROC
1757: 
1758:     *--------------------------------------------------------------------------
1759:     * BtnMarcarCopiaClick - Marca todos os itens para copia
1760:     *--------------------------------------------------------------------------
1761:     PROCEDURE BtnMarcarCopiaClick()
1762:         TRY
1763:             IF USED("cursor_4c_Copia") AND RECCOUNT("cursor_4c_Copia") > 0

*-- Linhas 1987 a 1995:
1987: 
1988:             *-- Grade editavel em INSERIR/ALTERAR; botao excluir visivel idem
1989:             loc_oPagina.grd_4c_Gradei.ReadOnly      = !loc_lEditar
1990:             loc_oPagina.cmd_4c_BtnExcluir.Visible   = loc_lEditar
1991: 
1992:             *-- Colunas de variacao somente se produto tem a caracteristica
1993:             loc_oPagina.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam
1994:             loc_oPagina.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor
1995:         CATCH TO loc_oErro

*-- Linhas 2038 a 2050:
2038:                 loc_oGrid.Column5.ControlSource      = "cursor_4c_Max.deptos"
2039: 
2040:                 *-- Headers OBRIGATORIO re-setar apos RecordSource (VFP9 reseta)
2041:                 loc_oGrid.Column1.Header1.Caption = "Emp"
2042:                 loc_oGrid.Column2.Header1.Caption = "Qtde. M" + CHR(225) + "xima"
2043:                 loc_oGrid.Column3.Header1.Caption = "Tamanho"
2044:                 loc_oGrid.Column4.Header1.Caption = "Cor"
2045:                 loc_oGrid.Column5.Header1.Caption = "Departamento"
2046: 
2047:                 GO TOP IN cursor_4c_Max
2048:                 loc_oGrid.Refresh()
2049: 
2050:                 IF RECCOUNT("cursor_4c_Max") = 0

*-- Linhas 2410 a 2426:
2410: 
2411:             *-- Grade: editavel apenas em INSERIR/ALTERAR
2412:             loc_oPagina.grd_4c_Gradei.ReadOnly      = !loc_lEditar
2413:             loc_oPagina.cmd_4c_BtnExcluir.Visible   = loc_lEditar
2414: 
2415:             *-- Colunas de variacao: habilitadas conforme caracteristica do produto
2416:             loc_oPagina.grd_4c_Gradei.Column3.ReadOnly = !THIS.this_lTemTam OR !loc_lEditar
2417:             loc_oPagina.grd_4c_Gradei.Column4.ReadOnly = !THIS.this_lTemCor OR !loc_lEditar
2418: 
2419:             *-- Botoes de acao Page2
2420:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
2421:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = par_lHabilitar
2422:         CATCH TO loc_oErro
2423:             MsgErro("Erro em HabilitarCampos: " + loc_oErro.Message, "Erro")
2424:         ENDTRY
2425:     ENDPROC
2426: 

*-- Linhas 2435 a 2452:
2435: 
2436:         TRY
2437:             WITH loc_oPg1.cnt_4c_Botoes
2438:                 .cmd_4c_Inserir.Enabled    = .T.
2439:                 .cmd_4c_Visualizar.Enabled = loc_lTemSelecao
2440:                 .cmd_4c_Alterar.Enabled    = loc_lTemSelecao
2441:                 .cmd_4c_Excluir.Enabled    = loc_lTemSelecao
2442:                 .cmd_4c_Buscar.Enabled     = .T.
2443:                 .Visible     = .T.
2444:             ENDWITH
2445: 
2446:             loc_oPg1.cmd_4c_BtnCopiar.Enabled = THIS.this_lAcCopiar
2447:         CATCH TO loc_oErro
2448:             MsgErro("Erro em AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
2449:         ENDTRY
2450:     ENDPROC
2451: 
2452: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigprcomBO.prg):
*==============================================================================
* sigprcomBO.prg - Business Object para Estoque M" + CHR(225) + "ximo (SigCdMax)
* Herda de BusinessBase
*==============================================================================
DEFINE CLASS sigprcomBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Tabela SigCdMax (linha corrente da grade de estoque)
    *--------------------------------------------------------------------------
    this_cCidChaves  = ""   && char(20) - PK
    this_cCodCores   = ""   && char(4)  - C" + CHR(243) + "digo da Cor
    this_cCodTams    = ""   && char(4)  - C" + CHR(243) + "digo do Tamanho
    this_cCPros      = ""   && char(14) - C" + CHR(243) + "digo do Produto (FK SigCdPro)
    this_cEmps       = ""   && char(3)  - Empresa
    this_cOrdems     = ""   && char(1)  - Ordem
    this_nQmaxs      = 0    && numeric(7,2) - Quantidade M" + CHR(225) + "xima
    this_cDeptos     = ""   && char(10) - Departamento (FK SigCdDpt)

    *--------------------------------------------------------------------------
    * Propriedades - Informa" + CHR(231) + CHR(245) + "es do Produto (SigCdPro - leitura)
    *--------------------------------------------------------------------------
    this_cDPros      = ""   && char(65) - Descri" + CHR(231) + CHR(227) + "o do Produto
    this_cCGrus      = ""   && char(3)  - C" + CHR(243) + "digo do Grupo
    this_cDGrus      = ""   && Descri" + CHR(231) + CHR(227) + "o do Grupo (join SigCdGrp)
    this_cIFors      = ""   && char(10) - C" + CHR(243) + "digo do Fornecedor
    this_cRClis      = ""   && Raz" + CHR(227) + "o do Fornecedor (join SigCdCli)
    this_cReffs      = ""   && char(40) - Refer" + CHR(234) + "ncia do Produto
    this_nSituas     = 0    && numeric(1,0) - Situa" + CHR(231) + CHR(227) + "o (1=ativo, 2=inativo)

    *--------------------------------------------------------------------------
    * Propriedades - Caracter" + CHR(237) + "sticas de varia" + CHR(231) + CHR(227) + "o do produto
    *--------------------------------------------------------------------------
    this_lTemCor     = .F.  && Produto possui varia" + CHR(231) + CHR(227) + "o de Cor
    this_lTemTam     = .F.  && Produto possui varia" + CHR(231) + CHR(227) + "o de Tamanho
    this_nTipoEstos  = 0    && Tipo de Estoque (0=sem, 1=tam, 2=cor, 3=tam+cor)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave prim" + CHR(225) + "ria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMax"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK do registro corrente (auditoria)
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - L" + CHR(234) + " linha de SigCdMax de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves = TratarNulo(cidchaves, "C")
            THIS.this_cCodCores  = TratarNulo(codcores,  "C")
            THIS.this_cCodTams   = TratarNulo(codtams,   "C")
            THIS.this_cCPros     = TratarNulo(cpros,     "C")
            THIS.this_cEmps      = TratarNulo(emps,      "C")
            THIS.this_cOrdems    = TratarNulo(ordems,    "C")
            THIS.this_nQmaxs     = TratarNulo(qmaxs,     "N")
            THIS.this_cDeptos    = TratarNulo(deptos,    "C")
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Pesquisa produtos em SigCdPro para a lista (Page1)
    * par_cFiltro: filtro livre por cpros/dpros/ifors/reffs
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " ORDER BY p.cpros"
            ELSE
                loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                    " p.reffs, p.situas" + ;
                    " FROM SigCdPro p" + ;
                    " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                    " WHERE p.cpros LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " OR p.ifors LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                    " ORDER BY p.cpros"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult < 0
                MsgErro("Erro ao buscar produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega produto + SigCdMax do produto
    * par_cCPros: c" + CHR(243) + "digo do produto
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_nVarias
        loc_lResultado = .F.

        IF EMPTY(par_cCPros)
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado!")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Produto")
                USE IN cursor_4c_Produto
            ENDIF

            loc_cSQL = "SELECT p.cpros, p.dpros, p.cgrus, g.dgrus, p.ifors," + ;
                " c.rclis, p.reffs, p.situas, p.codcors, p.codtams, p.varias" + ;
                " FROM SigCdPro p" + ;
                " LEFT JOIN SigCdGrp g ON g.cgrus = p.cgrus" + ;
                " LEFT JOIN SigCdCli c ON c.iclis = p.ifors" + ;
                " WHERE p.cpros = " + EscaparSQL(par_cCPros)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Produto")

            IF loc_nResult < 0
                MsgErro("Erro ao carregar produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF !USED("cursor_4c_Produto") OR RECCOUNT("cursor_4c_Produto") = 0
                MsgErro("Produto n" + CHR(227) + "o encontrado!", "Aviso")
                loc_lResultado = .F.
            ELSE
                SELECT cursor_4c_Produto
                GO TOP

                THIS.this_cCPros     = ALLTRIM(TratarNulo(cpros,  "C"))
                THIS.this_cDPros     = ALLTRIM(TratarNulo(dpros,  "C"))
                THIS.this_cCGrus     = ALLTRIM(TratarNulo(cgrus,  "C"))
                THIS.this_cDGrus     = ALLTRIM(TratarNulo(dgrus,  "C"))
                THIS.this_cIFors     = ALLTRIM(TratarNulo(ifors,  "C"))
                THIS.this_cRClis     = ALLTRIM(TratarNulo(rclis,  "C"))
                THIS.this_cReffs     = ALLTRIM(TratarNulo(reffs,  "C"))
                THIS.this_nSituas    = TratarNulo(situas, "N")
                THIS.this_lNovoRegistro = .F.

                loc_nVarias = TratarNulo(varias, "N")
                DO CASE
                    CASE loc_nVarias = 0
                        THIS.this_nTipoEstos = 0
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                    CASE loc_nVarias = 1
                        THIS.this_nTipoEstos = 1
                        THIS.this_lTemTam    = .T.
                        THIS.this_lTemCor    = .F.
                    CASE loc_nVarias = 2
                        THIS.this_nTipoEstos = 2
                        THIS.this_lTemCor    = .T.
                        THIS.this_lTemTam    = .F.
                    CASE loc_nVarias = 3
                        THIS.this_nTipoEstos = 3
                        THIS.this_lTemTam    = .T.
                        THIS.this_lTemCor    = .T.
                    OTHERWISE
                        THIS.this_nTipoEstos = 0
                        THIS.this_lTemCor    = .F.
                        THIS.this_lTemTam    = .F.
                ENDCASE

                IF USED("cursor_4c_Produto")
                    USE IN cursor_4c_Produto
                ENDIF

                loc_lResultado = THIS.CarregarMaxPorProduto(par_cCPros)
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarMaxPorProduto - Carrega SigCdMax de um produto em cursor_4c_Max
    * Cria cursor local EDITAVEL (SQLEXEC retorna cursor somente leitura)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarMaxPorProduto(par_cCPros)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF USED("cursor_4c_Max")
                USE IN cursor_4c_Max
            ENDIF
            IF USED("cursor_4c_MaxTemp")
                USE IN cursor_4c_MaxTemp
            ENDIF

            loc_cSQL = "SELECT m.cidchaves, m.emps, m.qmaxs, m.codtams," + ;
                " m.codcores, m.deptos, m.ordems" + ;
                " FROM SigCdMax m" + ;
                " WHERE m.cpros = " + EscaparSQL(par_cCPros) + ;
                " ORDER BY m.emps, m.codtams, m.codcores, m.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MaxTemp")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Criar cursor local editavel (SQLEXEC cria cursor somente leitura)
                SET NULL ON
                CREATE CURSOR cursor_4c_Max (cidchaves C(20), emps C(3), qmaxs N(7,2), ;
                    codtams C(4), codcores C(4), deptos C(10), ordems C(1))
                SET NULL OFF

                IF USED("cursor_4c_MaxTemp") AND RECCOUNT("cursor_4c_MaxTemp") > 0
                    APPEND FROM DBF("cursor_4c_MaxTemp")
                ENDIF

                IF USED("cursor_4c_MaxTemp")
                    USE IN cursor_4c_MaxTemp
                ENDIF

                GO TOP IN cursor_4c_Max
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarMaxPorProduto:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT de um registro em SigCdMax (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cChave
        loc_lResultado = .F.

        TRY
            loc_cChave               = fUniqueIds()
            THIS.this_cCidChaves     = loc_cChave

            loc_cSQL = "INSERT INTO SigCdMax" + ;
                " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                " VALUES (" + ;
                EscaparSQL(loc_cChave) + ", " + ;
                EscaparSQL(THIS.this_cCPros) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cEmps), 7) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQmaxs) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cCodTams), 8) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cCodCores), 8) + ", " + ;
                LEFT(EscaparSQL(THIS.this_cDeptos), 14) + ", " + ;
                EscaparSQL(THIS.this_cOrdems) + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult < 0
                MsgErro("Erro ao inserir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        IF USED("cursor_4c_Ins")
            USE IN cursor_4c_Ins
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE de um registro de SigCdMax (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF EMPTY(THIS.this_cCidChaves)
                MsgErro("Chave do registro n" + CHR(227) + "o definida!", "Erro")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "UPDATE SigCdMax SET" + ;
                    " qmaxs = " + FormatarNumeroSQL(THIS.this_nQmaxs) + "," + ;
                    " codtams = " + LEFT(EscaparSQL(THIS.this_cCodTams), 8) + "," + ;
                    " codcores = " + LEFT(EscaparSQL(THIS.this_cCodCores), 8) + "," + ;
                    " deptos = " + LEFT(EscaparSQL(THIS.this_cDeptos), 14) + "," + ;
                    " emps = " + LEFT(EscaparSQL(THIS.this_cEmps), 7) + "," + ;
                    " ordems = " + EscaparSQL(THIS.this_cOrdems) + ;
                    " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
                IF loc_nResult < 0
                    MsgErro("Erro ao atualizar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdMax (PROTECTED)
    * Deleta por cidchaves OU por cpros+emps dependendo do contexto
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            IF !EMPTY(THIS.this_cCidChaves)
                loc_cSQL = "DELETE FROM SigCdMax WHERE cidchaves = " + ;
                    EscaparSQL(THIS.this_cCidChaves)
            ELSE
                IF !EMPTY(THIS.this_cCPros) AND !EMPTY(THIS.this_cEmps)
                loc_cSQL = "DELETE FROM SigCdMax WHERE cpros = " + ;
                    EscaparSQL(THIS.this_cCPros) + ;
                    " AND emps = " + LEFT(EscaparSQL(THIS.this_cEmps), 7)
            ELSE
                MsgErro("Nenhuma chave definida para exclus" + CHR(227) + "o!", "Erro")
                loc_lResultado = .F.
                ENDIF
            ENDIF

            IF !EMPTY(loc_cSQL)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF

                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarGradeMax - Persiste cursor_4c_Max no banco (replace by delete+insert)
    * Chamado pelo form ap" + CHR(243) + "s edi" + CHR(231) + CHR(227) + "o da grade para o produto par_cCPros
    *--------------------------------------------------------------------------
    PROCEDURE SalvarGradeMax(par_cCPros)
        LOCAL loc_lResultado, loc_nResult
        LOCAL loc_cChaveNova, loc_cInsSQL
        loc_lResultado = .F.

        IF EMPTY(par_cCPros)
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o definido!")
            RETURN .F.
        ENDIF

        IF !USED("cursor_4c_Max")
            MsgErro("Cursor de estoque m" + CHR(225) + "ximo n" + CHR(227) + "o dispon" + CHR(237) + "vel!", "Erro")
            RETURN .F.
        ENDIF

        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdMax WHERE cpros = " + EscaparSQL(par_cCPros) + ;
                " AND emps <> ''", ;
                "cursor_4c_DelAll")

            IF loc_nResult < 0
                MsgErro("Erro ao limpar estoque m" + CHR(225) + "ximo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_DelAll")
                    USE IN cursor_4c_DelAll
                ENDIF

                SELECT cursor_4c_Max
                GO TOP
                loc_lResultado = .T.

                DO WHILE !EOF("cursor_4c_Max") AND loc_lResultado
                    IF !EMPTY(ALLTRIM(cursor_4c_Max.emps))
                        loc_cChaveNova = fUniqueIds()

                        loc_cInsSQL = "INSERT INTO SigCdMax" + ;
                            " (cidchaves, cpros, emps, qmaxs, codtams, codcores, deptos, ordems)" + ;
                            " VALUES (" + ;
                            EscaparSQL(loc_cChaveNova) + ", " + ;
                            EscaparSQL(par_cCPros) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.emps)), 7) + ", " + ;
                            FormatarNumeroSQL(cursor_4c_Max.qmaxs) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.codtams)), 8) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.codcores)), 8) + ", " + ;
                            LEFT(EscaparSQL(ALLTRIM(cursor_4c_Max.deptos)), 14) + ", " + ;
                            EscaparSQL(ALLTRIM(cursor_4c_Max.ordems)) + ;
                            ")"

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cInsSQL, "cursor_4c_InsLinha")
                        IF loc_nResult < 0
                            MsgErro("Erro ao salvar linha de estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ELSE
                            IF USED("cursor_4c_InsLinha")
                                USE IN cursor_4c_InsLinha
                            ENDIF
                        ENDIF
                    ENDIF

                    IF loc_lResultado
                        SKIP IN cursor_4c_Max
                    ENDIF
                ENDDO

                IF loc_lResultado
                    THIS.RegistrarAuditoria("UPDATE")
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em SalvarGradeMax:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarCopiaParaCursor - Popula cursor_4c_Copia com dados da empresa origem
    * para a funcionalidade de c" + CHR(243) + "pia entre empresas (cntCopia)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarCopiaParaCursor(par_cCPros, par_cEmpOs, par_cEmpDs)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        IF EMPTY(par_cEmpOs)
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Copia")
                USE IN cursor_4c_Copia
            ENDIF

            loc_cSQL = "SELECT o.cpros AS cpros, o.emps AS emps, o.qmaxs AS qmaxs," + ;
                " o.codtams AS codtams, o.codcores AS codcores, o.deptos AS deptos," + ;
                " CASE WHEN d.cidchaves IS NOT NULL THEN 1 ELSE 0 END AS existes," + ;
                " CAST(0 AS INT) AS marcas" + ;
                " FROM SigCdMax o" + ;
                " LEFT JOIN SigCdMax d ON d.cpros = o.cpros" + ;
                " AND d.emps = " + LEFT(EscaparSQL(par_cEmpDs), 7) + ;
                " AND d.codtams = o.codtams AND d.codcores = o.codcores" + ;
                " AND d.deptos = o.deptos" + ;
                " WHERE o.emps = " + LEFT(EscaparSQL(par_cEmpOs), 7) + ;
                IIF(!EMPTY(ALLTRIM(par_cCPros)), " AND o.cpros = " + EscaparSQL(par_cCPros), "") + ;
                " ORDER BY o.codtams, o.codcores, o.deptos"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Copia")
            IF loc_nResult < 0
                MsgErro("Erro ao carregar c" + CHR(243) + "pia:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Copia")
                    GO TOP IN cursor_4c_Copia
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CarregarCopiaParaCursor:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarMaxEntreEmpresas - Insere em SigCdMax os registros marcados do cursor
    * de c" + CHR(243) + "pia para a empresa destino
    * par_cEmpDs: empresa destino
    * par_cCursorCopia: nome do cursor com registros marcados (marcas=1, existes=0)
    *--------------------------------------------------------------------------
    PROCEDURE CopiarMaxEntreEmpresas(par_cEmpDs, par_cCursorCopia)
        LOCAL loc_lResultado, loc_nResult, loc_nCopias
        LOCAL loc_cChaveNova, loc_cCopSQL
        LOCAL loc_cCPros, loc_cEmps, loc_nQmaxs, loc_cCodTams
        LOCAL loc_cCodCores, loc_cDeptos, loc_nMarcas, loc_nExistes
        loc_lResultado = .F.
        loc_nCopias    = 0

        IF EMPTY(par_cEmpDs) OR EMPTY(par_cCursorCopia)
            MsgErro("Par" + CHR(226) + "metros inv" + CHR(225) + "lidos em CopiarMaxEntreEmpresas!", "Erro")
            RETURN .F.
        ENDIF

        IF !USED(par_cCursorCopia)
            MsgErro("Cursor de c" + CHR(243) + "pia n" + CHR(227) + "o dispon" + CHR(237) + "vel!", "Erro")
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cCursorCopia)
            GO TOP
            loc_lResultado = .T.

            DO WHILE !EOF() AND loc_lResultado
                loc_nMarcas  = TratarNulo(marcas,   "N")
                loc_nExistes = TratarNulo(existes,  "N")

                IF loc_nMarcas = 1 AND loc_nExistes = 0
                    loc_cCPros    = ALLTRIM(TratarNulo(cpros,    "C"))
                    loc_cEmps     = ALLTRIM(TratarNulo(emps,     "C"))
                    loc_nQmaxs    = TratarNulo(qmaxs,    "N")
                    loc_cCodTams  = ALLTRIM(TratarNulo(codtams,  "C"))
                    loc_cCodCores = ALLTRIM(TratarNulo(codcores, "C"))
                    loc_cDeptos   = ALLTRIM(TratarNulo(deptos,   "C"))

                    loc_cChaveNova = fUniqueIds()

                    loc_cCopSQL = "INSERT INTO SigCdMax" + ;
                        " (cpros, emps, qmaxs, codtams, codcores, cidchaves, deptos, ordems)" + ;
                        " VALUES (" + ;
                        EscaparSQL(loc_cCPros) + ", " + ;
                        LEFT(EscaparSQL(par_cEmpDs), 7) + ", " + ;
                        FormatarNumeroSQL(loc_nQmaxs) + ", " + ;
                        LEFT(EscaparSQL(loc_cCodTams), 8) + ", " + ;
                        LEFT(EscaparSQL(loc_cCodCores), 8) + ", " + ;
                        EscaparSQL(loc_cChaveNova) + ", " + ;
                        LEFT(EscaparSQL(loc_cDeptos), 14) + ", " + ;
                        "' ')"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cCopSQL, "cursor_4c_CopIns")
                    IF loc_nResult >= 0
                        loc_nCopias = loc_nCopias + 1
                        IF USED("cursor_4c_CopIns")
                            USE IN cursor_4c_CopIns
                        ENDIF
                    ELSE
                        MsgErro("Erro ao copiar linha:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        IF USED("cursor_4c_CopIns")
                            USE IN cursor_4c_CopIns
                        ENDIF
                        loc_lResultado = .F.
                    ENDIF

                    SELECT (par_cCursorCopia)
                ENDIF

                IF loc_lResultado
                    SKIP
                ENDIF
            ENDDO

            IF loc_lResultado
                MsgInfo("Foram copiados " + ALLTRIM(STR(loc_nCopias)) + ;
                    " registros para " + ALLTRIM(par_cEmpDs) + "!", ;
                    "C" + CHR(243) + "pia Conclu" + CHR(237) + "da")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CopiarMaxEntreEmpresas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

