# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 253: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 270: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 304: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 321: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigopdiv.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1549 linhas total):

*-- Linhas 71 a 81:
71: 
72:             *-- Definir Caption conforme operacao
73:             IF THIS.this_cOperacao = "R"
74:                 THIS.Caption = "Reinicia Industrializa" + CHR(231) + CHR(227) + "o"
75:             ELSE
76:                 THIS.Caption = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
77:             ENDIF
78: 
79:             *-- Criar cursores de trabalho (privados desta sessao de dados)
80:             SET NULL ON
81:             CREATE CURSOR Temp_DivOp ;

*-- Linhas 108 a 117:
108:             THIS.ConfigurarPaginaLista()
109: 
110:             *-- Propagar Caption para labels de titulo
111:             THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
112:             THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
113: 
114:             *-- BINDEVENT: Get_OP
115:             *-- Valid nao funciona via BINDEVENT em TextBox; usar KeyPress ENTER/TAB
116:             BINDEVENT(THIS.txt_4c_Op, "When",     THIS, "GetOpWhen")
117:             BINDEVENT(THIS.txt_4c_Op, "KeyPress",  THIS, "GetOpKeyPress")

*-- Linhas 143 a 151:
143: 
144:             *-- Ajustar caption do botao Gerar para modo Reinicia
145:             IF THIS.this_cOperacao = "R"
146:                 THIS.grp_4c_GrupoSalva.Buttons(1).Caption = "\<Reinicia"
147:             ENDIF
148: 
149:             *-- Tornar todos os controles visiveis (exceto flutuantes)
150:             THIS.TornarControlesVisiveis(THIS)
151: 

*-- Linhas 173 a 217:
173:         *----------------------------------------------------------------------
174:         THIS.AddObject("cnt_4c_Sombra", "Container")
175:         WITH THIS.cnt_4c_Sombra
176:             .Top         = 0
177:             .Left        = 0
178:             .Width       = 828
179:             .Height      = 80
180:             .BackColor   = RGB(100, 100, 100)
181:             .BorderWidth = 0
182:             .Visible     = .T.
183: 
184:             .AddObject("lbl_4c_Sombra", "Label")
185:             WITH .lbl_4c_Sombra
186:                 .Top      = 18
187:                 .Left     = 10
188:                 .Width    = 769
189:                 .Height   = 40
190:                 .FontBold = .T.
191:                 .FontName = "Tahoma"
192:                 .FontSize = 18
193:                 .BackStyle = 0
194:                 .ForeColor = RGB(0, 0, 0)
195:                 .WordWrap  = .T.
196:                 .Caption   = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
197:                 .Visible   = .T.
198:             ENDWITH
199: 
200:             .AddObject("lbl_4c_Titulo", "Label")
201:             WITH .lbl_4c_Titulo
202:                 .Top      = 19
203:                 .Left     = 10
204:                 .Width    = 769
205:                 .Height   = 46
206:                 .FontBold = .T.
207:                 .FontName = "Tahoma"
208:                 .FontSize = 18
209:                 .BackStyle = 0
210:                 .ForeColor = RGB(255, 255, 255)
211:                 .WordWrap  = .T.
212:                 .Caption   = "Separa Industrializa" + CHR(231) + CHR(227) + "o"
213:                 .Visible   = .T.
214:             ENDWITH
215:         ENDWITH
216:     ENDPROC
217: 

*-- Linhas 230 a 327:
230:         *----------------------------------------------------------------------
231:         THIS.AddObject("grp_4c_GrupoSalva", "CommandGroup")
232:         WITH THIS.grp_4c_GrupoSalva
233:             .Top           = -1
234:             .Left          = 673
235:             .Width         = 160
236:             .Height        = 85
237:             .AutoSize      = .T.
238:             .ButtonCount   = 2
239:             .BorderStyle   = 0
240:             .SpecialEffect = 1
241:             .BorderColor   = RGB(100, 100, 100)
242:             .Themes        = .F.
243:             .Visible       = .T.
244:         ENDWITH
245:         WITH THIS.grp_4c_GrupoSalva.Buttons(1)
246:             .Top             = 5
247:             .Left            = 5
248:             .Height          = 75
249:             .Width           = 75
250:             .Caption         = "\<Gerar O.P."
251:             .FontBold        = .T.
252:             .FontItalic      = .T.
253:             .FontName        = "Comic Sans MS"
254:             .FontSize        = 8
255:             .ForeColor       = RGB(90, 90, 90)
256:             .BackColor       = RGB(255, 255, 255)
257:             .Themes          = .F.
258:             .PicturePosition = 13
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
260:         ENDWITH
261:         WITH THIS.grp_4c_GrupoSalva.Buttons(2)
262:             .Top             = 5
263:             .Left            = 80
264:             .Height          = 75
265:             .Width           = 75
266:             .Caption         = "Encerrar"
267:             .Cancel          = .T.
268:             .FontBold        = .T.
269:             .FontItalic      = .T.
270:             .FontName        = "Comic Sans MS"
271:             .FontSize        = 8
272:             .ForeColor       = RGB(90, 90, 90)
273:             .BackColor       = RGB(255, 255, 255)
274:             .Themes          = .F.
275:             .PicturePosition = 13
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
277:         ENDWITH
278: 
279:         *----------------------------------------------------------------------
280:         * CommandGroup Grupo_Conf: "Confirmar" + "Encerrar" (oculto inicialmente)
281:         *----------------------------------------------------------------------
282:         THIS.AddObject("grp_4c_GrupoConf", "CommandGroup")
283:         WITH THIS.grp_4c_GrupoConf
284:             .Top           = -1
285:             .Left          = 674
286:             .Width         = 173
287:             .Height        = 110
288:             .ButtonCount   = 2
289:             .BorderStyle   = 0
290:             .SpecialEffect = 1
291:             .BorderColor   = RGB(136, 189, 188)
292:             .Themes        = .F.
293:             .Enabled       = .F.
294:             .Visible       = .F.
295:         ENDWITH
296:         WITH THIS.grp_4c_GrupoConf.Buttons(1)
297:             .Top             = 5
298:             .Left            = 5
299:             .Height          = 75
300:             .Width           = 75
301:             .Caption         = "\<Confirmar"
302:             .FontBold        = .T.
303:             .FontItalic      = .T.
304:             .FontName        = "Comic Sans MS"
305:             .FontSize        = 8
306:             .ForeColor       = RGB(90, 90, 90)
307:             .BackColor       = RGB(255, 255, 255)
308:             .Themes          = .F.
309:             .PicturePosition = 13
310:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
311:         ENDWITH
312:         WITH THIS.grp_4c_GrupoConf.Buttons(2)
313:             .Top             = 5
314:             .Left            = 80
315:             .Height          = 75
316:             .Width           = 75
317:             .Caption         = "Encerrar"
318:             .Cancel          = .T.
319:             .FontBold        = .T.
320:             .FontItalic      = .T.
321:             .FontName        = "Comic Sans MS"
322:             .FontSize        = 8
323:             .ForeColor       = RGB(90, 90, 90)
324:             .BackColor       = RGB(255, 255, 255)
325:             .Themes          = .F.
326:             .PicturePosition = 13
327:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"

*-- Linhas 343 a 369:
343:         *----------------------------------------------------------------------
344:         * Label "OP :"
345:         *----------------------------------------------------------------------
346:         THIS.AddObject("lbl_4c_Op", "Label")
347:         WITH THIS.lbl_4c_Op
348:             .Top       = 87
349:             .Left      = 41
350:             .Width     = 23
351:             .Height    = 15
352:             .Caption   = "OP :"
353:             .ForeColor = RGB(90, 90, 90)
354:             .BackStyle = 0
355:             .Visible   = .T.
356:         ENDWITH
357: 
358:         *----------------------------------------------------------------------
359:         * TextBox Get_OP: entrada do numero da OP
360:         *----------------------------------------------------------------------
361:         THIS.AddObject("txt_4c_Op", "TextBox")
362:         WITH THIS.txt_4c_Op
363:             .Top           = 83
364:             .Left          = 67
365:             .Width         = 108
366:             .Height        = 23
367:             .Alignment     = 3
368:             .Format        = "K"
369:             .InputMask     = "999999999999"

*-- Linhas 377 a 403:
377:         *----------------------------------------------------------------------
378:         * Label "Produto :"
379:         *----------------------------------------------------------------------
380:         THIS.AddObject("lbl_4c_Produto", "Label")
381:         WITH THIS.lbl_4c_Produto
382:             .Top       = 87
383:             .Left      = 213
384:             .Width     = 47
385:             .Height    = 15
386:             .Caption   = "Produto :"
387:             .ForeColor = RGB(90, 90, 90)
388:             .BackStyle = 0
389:             .Visible   = .T.
390:         ENDWITH
391: 
392:         *----------------------------------------------------------------------
393:         * TextBox Produto: exibe codigo do produto (readonly)
394:         *----------------------------------------------------------------------
395:         THIS.AddObject("txt_4c_Produto", "TextBox")
396:         WITH THIS.txt_4c_Produto
397:             .Top           = 83
398:             .Left          = 262
399:             .Width         = 108
400:             .Height        = 23
401:             .Alignment     = 3
402:             .Format        = "K"
403:             .SpecialEffect = 1

*-- Linhas 412 a 421:
412:         *----------------------------------------------------------------------
413:         THIS.AddObject("edt_4c_Obss", "EditBox")
414:         WITH THIS.edt_4c_Obss
415:             .Top           = 421
416:             .Left          = 11
417:             .Width         = 626
418:             .Height        = 94
419:             .SpecialEffect = 1
420:             .BorderColor   = RGB(100, 100, 100)
421:             .ControlSource = "Temp_DivOp.Obss"

*-- Linhas 428 a 437:
428:         *----------------------------------------------------------------------
429:         THIS.AddObject("edt_4c_MemoObs", "EditBox")
430:         WITH THIS.edt_4c_MemoObs
431:             .Top           = 421
432:             .Left          = 11
433:             .Width         = 626
434:             .Height        = 94
435:             .SpecialEffect = 1
436:             .BorderColor   = RGB(36, 84, 155)
437:             .ControlSource = "Temporario.Obss"

*-- Linhas 450 a 459:
450:         THIS.AddObject("grd_4c_Grade", "Grid")
451:         loc_oGrd = THIS.grd_4c_Grade
452:         WITH loc_oGrd
453:             .Top           = 121
454:             .Left          = 11
455:             .Width         = 626
456:             .Height        = 293
457:             .FontName      = "Arial"
458:             .FontSize      = 8
459:             .ColumnCount   = 7

*-- Linhas 473 a 481:
473: 
474:         *-- Column1: Pedido (expressao Dopes + Numes - readonly)
475:         WITH loc_oGrd.Column1
476:             .Header1.Caption     = "Pedido"
477:             .Header1.Alignment   = 2
478:             .Header1.BackColor   = RGB(192, 192, 192)
479:             .Text1.ControlSource = "ALLTRIM(Temp_DivOp.Dopes)+' '+ALLTRIM(STR(Temp_DivOp.Numes,6))"
480:             .Text1.ReadOnly      = .T.
481:             .Text1.BorderStyle   = 0

*-- Linhas 489 a 497:
489: 
490:         *-- Column2: Qtd.Op (QtdEtiqs) - editavel para divisao por etiquetas
491:         WITH loc_oGrd.Column2
492:             .Header1.Caption     = "Qtd.Op"
493:             .Header1.Alignment   = 2
494:             .Header1.BackColor   = RGB(192, 192, 192)
495:             .Text1.ControlSource = "Temp_DivOp.QtdEtiqs"
496:             .Text1.BorderStyle   = 0
497:             .Text1.Alignment     = 1

*-- Linhas 506 a 514:
506: 
507:         *-- Column3: Quantidade (Qtds - readonly)
508:         WITH loc_oGrd.Column3
509:             .Header1.Caption     = "Quantidade"
510:             .Header1.Alignment   = 2
511:             .Text1.ControlSource = "Temp_DivOp.Qtds"
512:             .Text1.ReadOnly      = .T.
513:             .Text1.BorderStyle   = 0
514:             .Text1.Alignment     = 1

*-- Linhas 523 a 531:
523: 
524:         *-- Column4: Divisao (QtdDivs) - editavel para informar quantidade a dividir
525:         WITH loc_oGrd.Column4
526:             .Header1.Caption     = "Divis" + CHR(227) + "o"
527:             .Header1.Alignment   = 2
528:             .Header1.BackColor   = RGB(192, 192, 192)
529:             .Text1.ControlSource = "Temp_DivOp.QtdDivs"
530:             .Text1.BorderStyle   = 0
531:             .Text1.Alignment     = 1

*-- Linhas 540 a 548:
540: 
541:         *-- Column5: Cor (CodCors - readonly)
542:         WITH loc_oGrd.Column5
543:             .Header1.Caption     = "Cor"
544:             .Header1.Alignment   = 2
545:             .Text1.ControlSource = "Temp_DivOp.CodCors"
546:             .Text1.ReadOnly      = .T.
547:             .Text1.BorderStyle   = 0
548:             .Text1.Margin        = 0

*-- Linhas 555 a 563:
555: 
556:         *-- Column6: Tam (CodTams - readonly)
557:         WITH loc_oGrd.Column6
558:             .Header1.Caption     = "Tam"
559:             .Header1.Alignment   = 2
560:             .Text1.ControlSource = "Temp_DivOp.CodTams"
561:             .Text1.ReadOnly      = .T.
562:             .Text1.BorderStyle   = 0
563:             .Text1.Margin        = 0

*-- Linhas 570 a 578:
570: 
571:         *-- Column7: Cliente (Contas - readonly)
572:         WITH loc_oGrd.Column7
573:             .Header1.Caption     = "Cliente"
574:             .Header1.Alignment   = 2
575:             .Text1.ControlSource = "Temp_DivOp.Contas"
576:             .Text1.ReadOnly      = .T.
577:             .Text1.BorderStyle   = 0
578:             .Text1.Margin        = 0

*-- Linhas 593 a 602:
593:         THIS.AddObject("grd_4c_Grade2", "Grid")
594:         loc_oGrd = THIS.grd_4c_Grade2
595:         WITH loc_oGrd
596:             .Top           = 121
597:             .Left          = 11
598:             .Width         = 626
599:             .Height        = 293
600:             .FontName      = "Arial"
601:             .FontSize      = 8
602:             .ColumnCount   = 7

*-- Linhas 617 a 625:
617: 
618:         *-- Column1: Pedido
619:         WITH loc_oGrd.Column1
620:             .Header1.Caption     = "Pedido"
621:             .Header1.Alignment   = 2
622:             .Header1.BackColor   = RGB(192, 192, 192)
623:             .Text1.ControlSource = "ALLTRIM(Temporario.Dopes)+' '+ALLTRIM(STR(Temporario.Numes,6))"
624:             .Text1.ReadOnly      = .T.
625:             .Text1.Alignment     = 0

*-- Linhas 636 a 644:
636: 
637:         *-- Column2: O.P. (Nops)
638:         WITH loc_oGrd.Column2
639:             .Header1.Caption     = "O.P."
640:             .Header1.Alignment   = 2
641:             .Header1.BackColor   = RGB(192, 192, 192)
642:             .Text1.ControlSource = "Temporario.Nops"
643:             .Text1.ReadOnly      = .T.
644:             .Text1.Alignment     = 1

*-- Linhas 657 a 665:
657: 
658:         *-- Column3: Quantidade (Qtds)
659:         WITH loc_oGrd.Column3
660:             .Header1.Caption     = "Quantidade"
661:             .Header1.Alignment   = 2
662:             .Header1.BackColor   = RGB(192, 192, 192)
663:             .Text1.ControlSource = "Temporario.Qtds"
664:             .Text1.ReadOnly      = .T.
665:             .Text1.Alignment     = 1

*-- Linhas 677 a 685:
677: 
678:         *-- Column4: Cor
679:         WITH loc_oGrd.Column4
680:             .Header1.Caption     = "Cor"
681:             .Header1.Alignment   = 2
682:             .Text1.ControlSource = "Temporario.CodCors"
683:             .Text1.ReadOnly      = .T.
684:             .Text1.BorderStyle   = 0
685:             .Text1.Margin        = 0

*-- Linhas 694 a 702:
694: 
695:         *-- Column5: Tam
696:         WITH loc_oGrd.Column5
697:             .Header1.Caption     = "Tam"
698:             .Header1.Alignment   = 2
699:             .Text1.ControlSource = "Temporario.CodTams"
700:             .Text1.ReadOnly      = .T.
701:             .Text1.BorderStyle   = 0
702:             .Text1.Margin        = 0

*-- Linhas 711 a 719:
711: 
712:         *-- Column6: Cliente (Contas)
713:         WITH loc_oGrd.Column6
714:             .Header1.Caption     = "Cliente"
715:             .Header1.Alignment   = 2
716:             .Text1.ControlSource = "Temporario.Contas"
717:             .Text1.ReadOnly      = .T.
718:             .Text1.BorderStyle   = 0
719:             .Text1.Margin        = 0

*-- Linhas 728 a 736:
728: 
729:         *-- Column7: Peso
730:         WITH loc_oGrd.Column7
731:             .Header1.Caption     = "Peso"
732:             .Header1.Alignment   = 2
733:             .Text1.ControlSource = "Temporario.Pesos"
734:             .Text1.ReadOnly      = .T.
735:             .Text1.BorderStyle   = 0
736:             .Text1.Margin        = 0

