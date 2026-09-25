# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_HistPeds' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSIGMVCTH.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (843 linhas total):

*-- Linhas 172 a 263:
172:         THIS.ConfigurarCamposAprovacao()
173:         THIS.ConfigurarBotoes()
174:     ENDPROC
175: 
176:     *--------------------------------------------------------------------------
177:     * ConfigurarGrid - Cria grd_4c_Dados (equivalente a grdCotacoes do
178:     * legado), com as 8 colunas EXATAS do SCX (Data/Adquirida/Uni/Valor
179:     * Adq./Unitario/Total/Codigo/Fornecedor), ligado a cursor_4c_HistPeds
180:     * (equivalente a crHistPeds). Posicao/tamanho/formatos IDENTICOS ao
181:     * SCX legado (PILAR 1). Coluna 1 = Data, 2 = QtdAdqs, 3 = CUnis,
182:     * 4 = ValAdqs, 5 = Units, 6 = Totas, 7 = IClis, 8 = Fornecs.
183:     *--------------------------------------------------------------------------
184:     PROTECTED PROCEDURE ConfigurarGrid()
185:         THIS.AddObject("grd_4c_Dados", "Grid")
186: 
187:         WITH THIS.grd_4c_Dados
188:             .Top           = 7
189:             .Left          = 9
190:             .Width         = 891
191:             .Height        = 499
192:             .HeaderHeight       = 0
193:             .FontSize      = 8
194:             .ReadOnly      = .F.
195:             .RecordMark    = .F.
196:             .DeleteMark    = .F.
197:             .RowHeight     = 18
198:             .ScrollBars    = 2
199:             .GridLineColor = RGB(128,128,128)
200:         ENDWITH
201: 
202:         *-- Liga a grade ao cursor e aplica a configuracao das colunas
203:         THIS.VincularGridDados()
204: 
205:         *-- AfterRowColChange do legado: ao mudar de linha, os campos de
206:         *-- aprovacao (Comprador/Aprovador/Data/Observacao), que espelham a
207:         *-- linha corrente do cursor, precisam ser repintados.
208:         BINDEVENT(THIS.grd_4c_Dados, "AfterRowColChange", THIS, "GrdDadosAfterRowColChange")
209:     ENDPROC
210: 
211:     *--------------------------------------------------------------------------
212:     * VincularGridDados - Liga grd_4c_Dados a cursor_4c_HistPeds e aplica a
213:     * configuracao COMPLETA das 8 colunas (ControlSource, Width, Format,
214:     * Header e DynamicForeColor).
215:     *
216:     * Fica separado de ConfigurarGrid porque o BO FECHA e RECRIA o cursor a
217:     * cada CarregarHistorico(): isso quebra o vinculo do Grid, e reatribuir
218:     * RecordSource/ControlSource reseta Column.Width e Header1.Caption para
219:     * os defaults (Problema 48). Toda a configuracao de coluna mora aqui e eh
220:     * reaplicada em CADA caminho que repopula o cursor.
221:     *
222:     * ColumnCount eh reatribuido com o MESMO valor (8) para impedir que o Grid
223:     * auto-expanda para os 13 campos do cursor; como nenhuma coluna usa
224:     * AddObject, reatribuir o mesmo valor eh inofensivo.
225:     *--------------------------------------------------------------------------
226:     PROTECTED PROCEDURE VincularGridDados()
227:         *-- Cursor placeholder = cursor real (mesma estrutura criada em
228:         *-- SIGMVCTHBO.CarregarHistorico) - garante que o Grid sempre encontre
229:         *-- o RecordSource, mesmo se CarregarHistorico falhou antes de criar
230:         *-- o cursor.
231:         IF !USED("cursor_4c_HistPeds")
232:             CREATE CURSOR cursor_4c_HistPeds (Situas N(1), Datas D(8), QtdAdqs N(12,2), ;
233:                 CUnis C(3), ValAdqs N(12,2), Units N(12,2), Totas N(12,2), IClis C(10), ;
234:                 Fornecs C(50), Comprador C(10), Aprovador C(10), DtAprovs D(8), ObsAprovs M(4))
235:         ENDIF
236: 
237:         WITH THIS.grd_4c_Dados
238:             .ColumnCount   = 8
239:             .RecordSource  = "cursor_4c_HistPeds"
240: 
241:             .Column1.ControlSource = "cursor_4c_HistPeds.Datas"
242:             .Column2.ControlSource = "cursor_4c_HistPeds.QtdAdqs"
243:             .Column3.ControlSource = "cursor_4c_HistPeds.CUnis"
244:             .Column4.ControlSource = "cursor_4c_HistPeds.ValAdqs"
245:             .Column5.ControlSource = "cursor_4c_HistPeds.Units"
246:             .Column6.ControlSource = "cursor_4c_HistPeds.Totas"
247:             .Column7.ControlSource = "cursor_4c_HistPeds.IClis"
248:             .Column8.ControlSource = "cursor_4c_HistPeds.Fornecs"
249: 
250:             *-- Coluna 1: Data
251:             .Column1.Width             = 75
252:             .Column1.FontSize          = 8
253:             .Column1.Movable           = .F.
254:             .Column1.Resizable         = .F.
255:             .Column1.Alignment         = 2
256:             .Column1.ReadOnly          = .F.
257:             .Column1.Header1.Caption   = "Data"
258:             .Column1.Header1.Alignment = 2
259:             .Column1.Header1.FontSize  = 8
260:             .Column1.Text1.FontSize    = 8
261:             .Column1.Text1.Alignment   = 2
262:             .Column1.Text1.BorderStyle = 0
263:             .Column1.Text1.Margin      = 0

*-- Linhas 271 a 279:
271:             .Column2.Format            = "999,999.99"
272:             .Column2.InputMask         = "999,999.99"
273:             .Column2.ReadOnly          = .F.
274:             .Column2.Header1.Caption   = "Adquirida"
275:             .Column2.Header1.Alignment = 2
276:             .Column2.Header1.FontSize  = 8
277:             .Column2.Text1.FontSize    = 8
278:             .Column2.Text1.BorderStyle = 0
279:             .Column2.Text1.Format      = "999,999.99"

*-- Linhas 286 a 294:
286:             .Column3.FontSize          = 8
287:             .Column3.Movable           = .F.
288:             .Column3.Resizable         = .F.
289:             .Column3.Header1.Caption   = "Uni"
290:             .Column3.Header1.Alignment = 2
291:             .Column3.Header1.FontSize  = 8
292:             .Column3.Text1.FontSize    = 8
293:             .Column3.Text1.BorderStyle = 0
294:             .Column3.Text1.Margin      = 0

*-- Linhas 301 a 309:
301:             .Column4.Format            = "999,999.99"
302:             .Column4.InputMask         = "999,999.99"
303:             .Column4.ReadOnly          = .F.
304:             .Column4.Header1.Caption   = "Valor Adq."
305:             .Column4.Header1.Alignment = 2
306:             .Column4.Header1.FontSize  = 8
307:             .Column4.Text1.FontSize    = 8
308:             .Column4.Text1.BorderStyle = 0
309:             .Column4.Text1.Format      = "999,999.99"

*-- Linhas 320 a 328:
320:             .Column5.Format            = "999,999.99"
321:             .Column5.InputMask         = "999,999.99"
322:             .Column5.ReadOnly          = .F.
323:             .Column5.Header1.Caption   = "Unit" + CHR(225) + "rio"
324:             .Column5.Header1.Alignment = 2
325:             .Column5.Header1.FontSize  = 8
326:             .Column5.Text1.FontSize    = 8
327:             .Column5.Text1.BorderStyle = 0
328:             .Column5.Text1.Format      = "999,999.99"

*-- Linhas 339 a 347:
339:             .Column6.Format            = "999,999.99"
340:             .Column6.InputMask         = "999,999.99"
341:             .Column6.ReadOnly          = .F.
342:             .Column6.Header1.Caption   = "Total"
343:             .Column6.Header1.Alignment = 2
344:             .Column6.Header1.FontSize  = 8
345:             .Column6.Text1.FontSize    = 8
346:             .Column6.Text1.BorderStyle = 0
347:             .Column6.Text1.Format      = "999,999.99"

*-- Linhas 357 a 365:
357:             .Column7.Movable           = .F.
358:             .Column7.Resizable         = .F.
359:             .Column7.ReadOnly          = .F.
360:             .Column7.Header1.Caption   = "C" + CHR(243) + "digo"
361:             .Column7.Header1.Alignment = 2
362:             .Column7.Header1.FontSize  = 8
363:             .Column7.Text1.FontSize    = 8
364:             .Column7.Text1.BorderStyle = 0
365:             .Column7.Text1.Margin      = 0

*-- Linhas 371 a 416:
371:             .Column8.Movable           = .F.
372:             .Column8.Resizable         = .F.
373:             .Column8.ReadOnly          = .F.
374:             .Column8.Header1.Caption   = "Fornecedor"
375:             .Column8.Header1.Alignment = 2
376:             .Column8.Header1.FontSize  = 8
377:             .Column8.Text1.FontSize    = 8
378:             .Column8.Text1.BorderStyle = 0
379:             .Column8.Text1.Margin      = 0
380:             .Column8.Text1.ReadOnly    = .F.
381: 
382:             *-- Destaca em azul as linhas ja aprovadas (Situas > 0), igual ao
383:             *-- SetAll("DynamicForeColor", ...) do Init do legado
384:             .SetAll("DynamicForeColor", ;
385:                 "IIF(cursor_4c_HistPeds.Situas > 0, RGB(0,0,255), RGB(0,0,0))", "Column")
386:         ENDWITH
387: 
388:         *-- Popular cursor nao repinta a grade sozinho - GO TOP + Refresh
389:         *-- (mesmo padrao do "Select crHistPeds / Go Top / grdCotacoes.Refresh"
390:         *-- no final do CarregaPedidos legado)
391:         IF USED("cursor_4c_HistPeds")
392:             SELECT cursor_4c_HistPeds
393:             GO TOP
394:             THIS.grd_4c_Dados.Refresh()
395:         ENDIF
396:     ENDPROC
397: 
398:     *--------------------------------------------------------------------------
399:     * ConfigurarCamposAprovacao - Cria os labels estaticos, o indicador de
400:     * legenda (Say10/Say5/Say1/Say2/Shape6/Say12 do legado) e os 3 TextBox +
401:     * 1 EditBox ligados a cursor_4c_HistPeds (getComprador/getAprovador/
402:     * getDtAprovs/getObsAprovs) que espelham a linha corrente da grade.
403:     *
404:     * ForeColor do legado (224,235,235) eh quase-branco e fica INVISIVEL sobre
405:     * o fundo claro (new_background.jpg) - todos os labels desta faixa
406:     * compartilham essa mesma cor quase-branca (sem irma com cor legivel para
407:     * herdar), entao escurecido para o canonico RGB(90,90,90) (regra #12).
408:     *
409:     * Os 4 campos tem PROCEDURE When / RETURN .f. no legado - nunca recebem
410:     * foco, sao APENAS espelho visual da linha corrente (repintados por
411:     * BOParaForm/GrdDadosAfterRowColChange). Equivalente aqui eh
412:     * .Enabled = .F. - BINDEVENT em "When" NAO serviria, porque o retorno do
413:     * delegate eh DESCARTADO e o .F. nunca bloquearia o foco.
414:     *
415:     * Mas .Enabled = .F. e When / RETURN .f. RENDERIZAM DIFERENTE: o When do
416:     * legado nao esmaece o controle (o campo aparece normal, preto no branco,

*-- Linhas 429 a 600:
429:     *--------------------------------------------------------------------------
430:     PROTECTED PROCEDURE ConfigurarCamposAprovacao()
431:         *-- Say10 "Comprador"
432:         THIS.AddObject("lbl_4c_Label10", "Label")
433:         WITH THIS.lbl_4c_Label10
434:             .Top       = 516
435:             .Left      = 9
436:             .Width     = 74
437:             .Height    = 15
438:             .AutoSize  = .T.
439:             .BackStyle = 0
440:             .FontBold  = .T.
441:             .FontSize  = 8
442:             .ForeColor = RGB(90,90,90)
443:             .Caption   = "Comprador"
444:         ENDWITH
445: 
446:         *-- Say5 "Aprovador"
447:         THIS.AddObject("lbl_4c_Label5", "Label")
448:         WITH THIS.lbl_4c_Label5
449:             .Top       = 516
450:             .Left      = 93
451:             .Width     = 71
452:             .Height    = 15
453:             .AutoSize  = .T.
454:             .BackStyle = 0
455:             .FontBold  = .T.
456:             .FontSize  = 8
457:             .ForeColor = RGB(90,90,90)
458:             .Caption   = "Aprovador"
459:         ENDWITH
460: 
461:         *-- Say1 "Data"
462:         THIS.AddObject("lbl_4c_Label1", "Label")
463:         WITH THIS.lbl_4c_Label1
464:             .Top       = 516
465:             .Left      = 177
466:             .Width     = 32
467:             .Height    = 15
468:             .AutoSize  = .T.
469:             .BackStyle = 0
470:             .FontBold  = .T.
471:             .FontSize  = 8
472:             .ForeColor = RGB(90,90,90)
473:             .Caption   = "Data"
474:         ENDWITH
475: 
476:         *-- Say2 "Observacao"
477:         THIS.AddObject("lbl_4c_Label2", "Label")
478:         WITH THIS.lbl_4c_Label2
479:             .Top       = 516
480:             .Left      = 261
481:             .Width     = 79
482:             .Height    = 15
483:             .AutoSize  = .T.
484:             .BackStyle = 0
485:             .FontBold  = .T.
486:             .FontSize  = 8
487:             .ForeColor = RGB(90,90,90)
488:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o"
489:         ENDWITH
490: 
491:         *-- getComprador (mirror da linha corrente - nunca recebe foco)
492:         THIS.AddObject("txt_4c_Comprador", "TextBox")
493:         WITH THIS.txt_4c_Comprador
494:             .Top               = 532
495:             .Left              = 9
496:             .Width             = 80
497:             .Height            = 20
498:             .FontName          = "Arial"
499:             .FontSize          = 8
500:             .MaxLength         = 10
501:             .SpecialEffect     = 1
502:             .BorderColor       = RGB(0,0,128)
503:             .Format            = "K"
504:             .Enabled           = .F.
505:             .DisabledBackColor = RGB(255,255,255)
506:             .DisabledForeColor = RGB(0,0,0)
507:             .ControlSource     = "cursor_4c_HistPeds.Comprador"
508:         ENDWITH
509: 
510:         *-- getAprovador (mirror da linha corrente - nunca recebe foco)
511:         THIS.AddObject("txt_4c_Aprovador", "TextBox")
512:         WITH THIS.txt_4c_Aprovador
513:             .Top               = 532
514:             .Left              = 93
515:             .Width             = 80
516:             .Height            = 20
517:             .FontName          = "Arial"
518:             .FontSize          = 8
519:             .MaxLength         = 10
520:             .SpecialEffect     = 1
521:             .BorderColor       = RGB(0,0,128)
522:             .Format            = "K"
523:             .Enabled           = .F.
524:             .DisabledBackColor = RGB(255,255,255)
525:             .DisabledForeColor = RGB(0,0,0)
526:             .ControlSource     = "cursor_4c_HistPeds.Aprovador"
527:         ENDWITH
528: 
529:         *-- getDtAprovs (mirror da linha corrente - nunca recebe foco)
530:         THIS.AddObject("txt_4c_DtAprovs", "TextBox")
531:         WITH THIS.txt_4c_DtAprovs
532:             .Top               = 532
533:             .Left              = 177
534:             .Width             = 80
535:             .Height            = 20
536:             .FontName          = "Arial"
537:             .FontSize          = 8
538:             .MaxLength         = 10
539:             .SpecialEffect     = 1
540:             .BorderColor       = RGB(0,0,128)
541:             .Format            = "K"
542:             .Enabled           = .F.
543:             .DisabledBackColor = RGB(255,255,255)
544:             .DisabledForeColor = RGB(0,0,0)
545:             .ControlSource     = "cursor_4c_HistPeds.DtAprovs"
546:         ENDWITH
547: 
548:         *-- getObsAprovs (mirror da linha corrente - nunca recebe foco). SCX
549:         *-- declara DisabledBackColor/DisabledForeColor explicitos - overrida
550:         *-- o cinza padrao do VFP9 para Enabled = .F.
551:         THIS.AddObject("obj_4c_GetObsAprovs", "EditBox")
552:         WITH THIS.obj_4c_GetObsAprovs
553:             .Top               = 532
554:             .Left              = 261
555:             .Width             = 640
556:             .Height            = 20
557:             .FontName          = "Arial"
558:             .FontSize          = 8
559:             .SpecialEffect     = 1
560:             .BorderColor       = RGB(0,0,128)
561:             .Format            = "K!"
562:             .Enabled           = .F.
563:             .DisabledBackColor = RGB(255,255,255)
564:             .DisabledForeColor = RGB(0,0,128)
565:             .ControlSource     = "cursor_4c_HistPeds.ObsAprovs"
566:         ENDWITH
567: 
568:         *-- Shape6 - indicador da legenda (quadrado azul), pareado com Say12
569:         THIS.AddObject("shp_4c_Shape6", "Shape")
570:         WITH THIS.shp_4c_Shape6
571:             .Top           = 562
572:             .Left          = 9
573:             .Width         = 19
574:             .Height        = 19
575:             .BackStyle     = 1
576:             .BorderStyle   = 1
577:             .SpecialEffect = 0
578:             .BackColor     = RGB(0,0,255)
579:             .BorderColor   = RGB(90,90,90)
580:         ENDWITH
581: 
582:         *-- Say12 "Pedidos Gerados" - legenda do Shape6
583:         THIS.AddObject("lbl_4c_Label12", "Label")
584:         WITH THIS.lbl_4c_Label12
585:             .Top       = 565
586:             .Left      = 34
587:             .Width     = 111
588:             .Height    = 15
589:             .AutoSize  = .T.
590:             .WordWrap  = .F.
591:             .BackStyle = 0
592:             .FontBold  = .T.
593:             .FontSize  = 8
594:             .ForeColor = RGB(90,90,90)
595:             .Caption   = "Pedidos Gerados"
596:         ENDWITH
597:     ENDPROC
598: 
599:     *--------------------------------------------------------------------------
600:     * ConfigurarBotoes - Cria cmg_4c_Botoes (equivalente a cmdSalva do

*-- Linhas 608 a 632:
608: 
609:         WITH THIS.cmg_4c_Botoes
610:             .ButtonCount   = 1
611:             .Top           = 5
612:             .Left          = 908
613:             .Width         = 90
614:             .Height        = 110
615:             .BackStyle     = 0
616:             .BorderStyle   = 0
617:             .Value         = 0
618: 
619:             WITH .Buttons(1)
620:                 .Name          = "cmd_4c_Retornar"
621:                 .Top           = 5
622:                 .Left          = 5
623:                 .Width         = 80
624:                 .Height        = 100
625:                 .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
626:                 .Cancel        = .T.
627:                 .Caption       = "Retornar"
628:                 .FontName        = "Comic Sans MS"
629:                 .FontSize        = 8
630:                 .SpecialEffect = 0
631:                 .ForeColor     = RGB(36,84,155)
632:                 .BackColor     = RGB(255,255,255)

*-- Linhas 697 a 717:
697: 
698:     *--------------------------------------------------------------------------
699:     * BOParaForm - Espelha no form a linha CORRENTE do historico.
700:     *
701:     * Duas etapas, nesta ordem:
702:     *   1. Carrega a linha corrente de cursor_4c_HistPeds nas propriedades
703:     *      this_* do BO (SIGMVCTHBO.CarregarDoCursor) - assim o BO eh a fonte
704:     *      unica do registro selecionado.
705:     *   2. Repinta os 4 campos de aprovacao (Comprador/Aprovador/Data/
706:     *      Observacao - getComprador/getAprovador/getDtAprovs/getObsAprovs no
707:     *      legado), transcrevendo o AfterRowColChange do grdCotacoes legado:
708:     *          ThisForm.getComprador.Refresh
709:     *          ThisForm.getAprovador.Refresh
710:     *          ThisForm.getDtAprovs.Refresh
711:     *          ThisForm.getObsAprovs.Refresh
712:     *
713:     * Os 4 controles tem .ControlSource apontando para o cursor (igual ao
714:     * legado), por isso aqui se chama Refresh() e NUNCA se atribui .Value:
715:     * atribuir .Value em controle com ControlSource escreveria de volta no
716:     * cursor, alterando o historico exibido.
717:     *

*-- Linhas 757 a 777:
757:     *--------------------------------------------------------------------------
758:     * CarregarLista - Repopula o historico de cotacoes e repinta a grade.
759:     * Equivalente ao PROCEDURE CarregaPedidos do form legado (a consulta em si
760:     * mora no BO, em SIGMVCTHBO.CarregarHistorico).
761:     *
762:     * Como o BO fecha e recria cursor_4c_HistPeds, o vinculo do Grid tem de ser
763:     * REFEITO depois de cada carga (VincularGridDados) - sem isso a grade fica
764:     * visualmente vazia com o cursor cheio.
765:     *
766:     * PUBLIC (sem PROTECTED): eh chamada de fora da classe pelo harness de
767:     * teste automatizado.
768:     *--------------------------------------------------------------------------
769:     PROCEDURE CarregarLista()
770:         LOCAL loc_lSucesso, loc_oErro
771:         loc_lSucesso = .F.
772: 
773:         TRY
774:             *-- FormParaBO devolve .F. quando o BO nao existe - preserva a
775:             *-- guarda que antes era VARTYPE(THIS.this_oBusinessObject) = "O"
776:             IF THIS.FormParaBO()
777:                 loc_lSucesso = THIS.this_oBusinessObject.CarregarHistorico()

*-- Linhas 792 a 812:
792: 
793:         RETURN loc_lSucesso
794:     ENDPROC
795: 
796:     *--------------------------------------------------------------------------
797:     * GrdDadosAfterRowColChange - Handler de AfterRowColChange de grd_4c_Dados.
798:     * Transcrito do AfterRowColChange do grdCotacoes legado, que repinta os 4
799:     * campos de aprovacao ao mudar a linha corrente. Declara par_nColIndex
800:     * porque o evento passa esse parametro. PUBLIC porque eh alvo de BINDEVENT.
801:     *--------------------------------------------------------------------------
802:     PROCEDURE GrdDadosAfterRowColChange(par_nColIndex)
803:         THIS.BOParaForm()
804:     ENDPROC
805: 
806: 
807:     *--------------------------------------------------------------------------
808:     * TornarControlesVisiveis - Torna visiveis, recursivamente, os controles
809:     * criados via AddObject (que nascem com Visible = .F.).
810:     *--------------------------------------------------------------------------
811:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
812:         LOCAL loc_nI, loc_oObjeto

*-- Linhas 831 a 843:
831:     *--------------------------------------------------------------------------
832:     * Destroy - Fecha o cursor de historico antes de delegar a FormBase.Destroy
833:     * (que faz o restauro do menu principal - DODEFAULT() OBRIGATORIO).
834:     *--------------------------------------------------------------------------
835:     PROCEDURE Destroy()
836:         IF USED("cursor_4c_HistPeds")
837:             USE IN cursor_4c_HistPeds
838:         ENDIF
839: 
840:         DODEFAULT()
841:     ENDPROC
842: 
843: ENDDEFINE


### BO (C:\4c\projeto\app\classes\SIGMVCTHBO.prg):
*====================================================================
* SIGMVCTHBO.prg
*
* Business Object para Historico de Cotacoes (consulta de cotacoes
* anteriores de um produto dentro de uma proposta de compra)
* Tabelas: SigCtTCt (itens de cotacao), SigCtTDc (documento/aprovacao
*          da cotacao), SigCtTFn (fornecedor vencedor por cotacao)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS SIGMVCTHBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para SigCtTCt/SigCtTDc/SigCtTFn)
    this_cCPros       = ""   && cpros char(14) - SigCtTCt - proposta filtrada
    this_nCodigos     = 0    && codigos numeric(6,0) - SigCtTCt - produto atual (excluido do historico)
    this_cCursorDados = ""   && nome do cursor de resultado exibido na grade (equivalente a crHistPeds do legado)

    *-- Propriedades espelhando a linha corrente de THIS.this_cCursorDados
    *-- (mapeadas por CarregarDoCursor - TODAS as colunas de cursor_4c_HistPeds)
    this_nSituas      = 0    && Situas n(1) - situacao da aprovacao (SigCtTDc.situas)
    this_dDatas       = {}   && Datas d(8) - data da cotacao (SigCtTDc.dtcotas)
    this_nQtdAdqs     = 0    && QtdAdqs n(12,2) - quantidade adquirida (SigCtTCt.qtdadqs)
    this_cCUnis       = ""   && CUnis c(3) - unidade (SigCtTCt.cunis)
    this_nValAdqs     = 0    && ValAdqs n(12,2) - valor adquirido (SigCtTCt.valadqs)
    this_nUnits       = 0    && Units n(12,2) - valor unitario da marca vencedora (unit01..unit06)
    this_nTotas       = 0    && Totas n(12,2) - valor total da marca vencedora (tota01..tota06)
    this_cIClis       = ""   && IClis c(10) - codigo do fornecedor vencedor (SigCtTFn.iclis)
    this_cFornecs     = ""   && Fornecs c(50) - nome do fornecedor vencedor (SigCtTFn.fornecs)
    this_cComprador   = ""   && Comprador c(10) - comprador responsavel (SigCtTDc.comprador)
    this_cAprovador   = ""   && Aprovador c(10) - aprovador responsavel (SigCtTDc.aprovador)
    this_dDtAprovs    = {}   && DtAprovs d(8) - data da aprovacao (SigCtTDc.dtaprovs)
    this_cObsAprovs   = ""   && ObsAprovs m(4) - observacao da aprovacao (SigCtTDc.obsaprovs)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela      = "SigCtTCt"
            THIS.this_cCampoChave  = "cidchaves"
            THIS.this_cCPros       = ""
            THIS.this_nCodigos     = 0
            THIS.this_cCursorDados = "cursor_4c_HistPeds"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarHistorico - Busca o historico de cotacoes do produto dentro
    * da proposta filtrada (THIS.this_cCPros / THIS.this_nCodigos).
    *
    * Porta o metodo "CarregaPedidos" do legado: para cada linha de
    * SigCtTCt (itens cotados) casada com SigCtTDc (documento/aprovacao),
    * resolve qual das 6 marcas (Marca01..Marca06) foi a vencedora e busca
    * o fornecedor correspondente em SigCtTFn (chave Codigos+Grades).
    *
    * Popula THIS.this_cCursorDados (cursor_4c_HistPeds), com a MESMA
    * estrutura de campos que o Load() do legado criava para crHistPeds.
    *====================================================================
    PROCEDURE CarregarHistorico()
        LOCAL loc_cSQL, loc_cSQLFn, loc_nResultado, loc_nResultadoFn
        LOCAL loc_lSucesso, loc_lProsseguir, loc_cLetra, loc_nUnit, loc_nTotal
        loc_lSucesso    = .F.
        loc_lProsseguir = .T.

        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorDados) (Situas N(1), Datas D(8), QtdAdqs N(12,2), ;
                CUnis C(3), ValAdqs N(12,2), Units N(12,2), Totas N(12,2), IClis C(10), ;
                Fornecs C(50), Comprador C(10), Aprovador C(10), DtAprovs D(8), ObsAprovs M(4))

            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                *-- Modo de validacao de UI (sem conexao SQL) - cursor fica vazio e o form abre normalmente
                loc_lSucesso = .T.
            ELSE
                IF EMPTY(ALLTRIM(THIS.this_cCPros))
                    MostrarErro("Proposta n" + CHR(227) + "o informada.", "SIGMVCTHBO.CarregarHistorico")
                    loc_lProsseguir = .F.
                ENDIF

                IF loc_lProsseguir
                    loc_cSQL = "SELECT a.Codigos, b.DtCotas AS Datas, b.Situas, a.QtdAdqs, a.CUnis, a.ValAdqs, " + ;
                        "a.Marca01, a.Unit01, a.Tota01, a.Marca02, a.Unit02, a.Tota02, " + ;
                        "a.Marca03, a.Unit03, a.Tota03, a.Marca04, a.Unit04, a.Tota04, " + ;
                        "a.Marca05, a.Unit05, a.Tota05, a.Marca06, a.Unit06, a.Tota06, " + ;
                        "b.Comprador, b.Aprovador, b.DtAprovs, b.ObsAprovs " + ;
                        "FROM SigCtTCt a, SigCtTDc b " + ;
                        "WHERE a.CPros = " + EscaparSQL(THIS.this_cCPros) + " " + ;
                        "AND a.Codigos <> " + FormatarNumeroSQL(THIS.this_nCodigos, 0) + " " + ;
                        "AND a.Codigos = b.Codigos " + ;
                        "ORDER BY b.DtCotas DESC, a.Codigos ASC"

                    IF USED("cursor_4c_HistPedsCt")
                        USE IN cursor_4c_HistPedsCt
                    ENDIF
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_HistPedsCt")

                    IF loc_nResultado < 0
                        MostrarErro("Falha ao carregar hist" + CHR(243) + "rico de cota" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                        loc_lProsseguir = .F.
                    ENDIF
                ENDIF

                IF loc_lProsseguir
                    SELECT cursor_4c_HistPedsCt
                    SCAN
                        loc_cLetra = " "
                        loc_nUnit  = 0
                        loc_nTotal = 0

                        DO CASE
                            CASE cursor_4c_HistPedsCt.Marca01
                                loc_cLetra = "A"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit01
                                loc_nTotal = cursor_4c_HistPedsCt.Tota01
                            CASE cursor_4c_HistPedsCt.Marca02
                                loc_cLetra = "B"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit02
                                loc_nTotal = cursor_4c_HistPedsCt.Tota02
                            CASE cursor_4c_HistPedsCt.Marca03
                                loc_cLetra = "C"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit03
                                loc_nTotal = cursor_4c_HistPedsCt.Tota03
                            CASE cursor_4c_HistPedsCt.Marca04
                                loc_cLetra = "D"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit04
                                loc_nTotal = cursor_4c_HistPedsCt.Tota04
                            CASE cursor_4c_HistPedsCt.Marca05
                                loc_cLetra = "E"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit05
                                loc_nTotal = cursor_4c_HistPedsCt.Tota05
                            CASE cursor_4c_HistPedsCt.Marca06
                                loc_cLetra = "F"
                                loc_nUnit  = cursor_4c_HistPedsCt.Unit06
                                loc_nTotal = cursor_4c_HistPedsCt.Tota06
                        ENDCASE

                        IF !EMPTY(loc_cLetra)
                            INSERT INTO (THIS.this_cCursorDados) ;
                                (Situas, Datas, QtdAdqs, CUnis, ValAdqs, Comprador, Aprovador, DtAprovs, ObsAprovs, Units, Totas) ;
                                VALUES ( ;
                                    cursor_4c_HistPedsCt.Situas, ;
                                    ConverterParaData(cursor_4c_HistPedsCt.Datas), ;
                                    cursor_4c_HistPedsCt.QtdAdqs, ;
                                    cursor_4c_HistPedsCt.CUnis, ;
                                    cursor_4c_HistPedsCt.ValAdqs, ;
                                    cursor_4c_HistPedsCt.Comprador, ;
                                    cursor_4c_HistPedsCt.Aprovador, ;
                                    ConverterParaData(cursor_4c_HistPedsCt.DtAprovs), ;
                                    TratarNulo(cursor_4c_HistPedsCt.ObsAprovs, ""), ;
                                    loc_nUnit, ;
                                    loc_nTotal)

                            loc_cSQLFn = "SELECT a.IClis, a.Fornecs FROM SigCtTFn a " + ;
                                "WHERE a.Codigos = " + FormatarNumeroSQL(cursor_4c_HistPedsCt.Codigos, 0) + " " + ;
                                "AND a.Grades = " + EscaparSQL(loc_cLetra)

                            IF USED("cursor_4c_HistPedsFn")
                                USE IN cursor_4c_HistPedsFn
                            ENDIF
                            loc_nResultadoFn = SQLEXEC(gnConnHandle, loc_cSQLFn, "cursor_4c_HistPedsFn")

                            IF loc_nResultadoFn < 0
                                MostrarErro("Falha ao carregar fornecedor vencedor da cota" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lProsseguir = .F.
                            ELSE
                                IF RECCOUNT("cursor_4c_HistPedsFn") > 0
                                    SELECT (THIS.this_cCursorDados)
                                    GO BOTTOM
                                    REPLACE IClis   WITH cursor_4c_HistPedsFn.IClis, ;
                                            Fornecs WITH cursor_4c_HistPedsFn.Fornecs
                                ENDIF
                                IF USED("cursor_4c_HistPedsFn")
                                    USE IN cursor_4c_HistPedsFn
                                ENDIF
                            ENDIF
                        ENDIF

                        IF !loc_lProsseguir
                            EXIT
                        ENDIF

                        SELECT cursor_4c_HistPedsCt
                    ENDSCAN

                    IF USED("cursor_4c_HistPedsCt")
                        USE IN cursor_4c_HistPedsCt
                    ENDIF
                    IF USED("cursor_4c_HistPedsFn")
                        USE IN cursor_4c_HistPedsFn
                    ENDIF
                ENDIF

                loc_lSucesso = loc_lProsseguir
            ENDIF

            IF loc_lSucesso AND USED(THIS.this_cCursorDados)
                SELECT (THIS.this_cCursorDados)
                GO TOP
            ENDIF

        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.CarregarHistorico")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia a linha CORRENTE de par_cAliasCursor
    * (tipicamente THIS.this_cCursorDados, a linha selecionada na grade)
    * para as propriedades this_* do Business Object.
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cAliasCursor) = "C" AND USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_nSituas    = TratarNulo(Situas, 0)
                THIS.this_dDatas     = ConverterParaData(TratarNulo(Datas, {}))
                THIS.this_nQtdAdqs   = TratarNulo(QtdAdqs, 0)
                THIS.this_cCUnis     = TratarNulo(CUnis, "")
                THIS.this_nValAdqs   = TratarNulo(ValAdqs, 0)
                THIS.this_nUnits     = TratarNulo(Units, 0)
                THIS.this_nTotas     = TratarNulo(Totas, 0)
                THIS.this_cIClis     = TratarNulo(IClis, "")
                THIS.this_cFornecs   = TratarNulo(Fornecs, "")
                THIS.this_cComprador = TratarNulo(Comprador, "")
                THIS.this_cAprovador = TratarNulo(Aprovador, "")
                THIS.this_dDtAprovs  = ConverterParaData(TratarNulo(DtAprovs, {}))
                THIS.this_cObsAprovs = TratarNulo(ObsAprovs, "")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "SIGMVCTHBO.CarregarDoCursor")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir/Atualizar/ExecutarExclusao/ObterChavePrimaria/RegistrarAuditoria
    * continuam exatamente como herdados de BusinessBase, por fidelidade ao
    * legado: o formulario SIGMVCTH.SCX e um visualizador de historico
    * SOMENTE LEITURA - as tres consultas acima (SELECT em SigCtTCt/
    * SigCtTDc/SigCtTFn) sao a totalidade do SQL que ele executa. O unico
    * botao (cmdSalva.btnSair, rotulado "Retornar") apenas fecha a tela
    * (ThisForm.Release) - o legado nao tem nenhum INSERT/UPDATE/DELETE
    * para portar, e este form nunca aciona THIS.Salvar() nem
    * THIS.Excluir(). O comportamento herdado de BusinessBase (recusar a
    * operacao e avisar o usuario) ja reproduz essa realidade com
    * fidelidade, entao sobrescrever aqui apenas duplicaria codigo sem
    * alterar nada em tempo de execucao.
    *====================================================================

ENDDEFINE

