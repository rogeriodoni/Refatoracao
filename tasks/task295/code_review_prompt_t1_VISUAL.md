# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-WITH] Bloco WITH THIS.grd_4c_Cab define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Cab.RecordSource).
- [GRID-WITH] Bloco WITH THIS.grd_4c_Ite define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Ite.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrGst.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (912 linhas total):

*-- Linhas 72 a 80:
72:                 MsgErro("Erro ao criar objeto de neg" + CHR(243) + "cio SigPrGst.", "Erro")
73:             ELSE
74:                 *-- Definir Caption antes de ConfigurarCabecalho (labels usam THIS.Caption)
75:                 THIS.Caption = "Gera" + CHR(231) + CHR(227) + "o de Movimenta" + CHR(231) + ;
76:                                CHR(245) + "es de Estoque"
77: 
78:                 *-- Imagem de fundo e titulo
79:                 THIS.ConfigurarPageFrame()
80: 

*-- Linhas 103 a 112:
103:                 THIS.CarregarDados()
104: 
105:                 *-- Propagar titulo para labels do cabecalho
106:                 THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
107:                 THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
108: 
109:                 loc_lSucesso = .T.
110:             ENDIF
111: 
112:         CATCH TO loc_oErro

*-- Linhas 131 a 177:
131:         THIS.AddObject("cnt_4c_Sombra", "Container")
132:         WITH THIS.cnt_4c_Sombra
133:             .Visible     = .T.
134:             .Top         = 0
135:             .Left        = 0
136:             .Width       = THIS.Width
137:             .Height      = 80
138:             .BorderWidth = 0
139:             .BackColor   = RGB(100,100,100)
140: 
141:             .AddObject("lbl_4c_Sombra", "Label")
142:             WITH .lbl_4c_Sombra
143:                 .FontBold      = .T.
144:                 .FontName      = "Tahoma"
145:                 .FontSize      = 18
146:                 .FontUnderline = .F.
147:                 .WordWrap      = .T.
148:                 .Alignment     = 0
149:                 .AutoSize      = .F.
150:                 .BackStyle     = 0
151:                 .Caption       = THIS.Caption
152:                 .Height        = 40
153:                 .Left          = 10
154:                 .Top           = 18
155:                 .Width         = THIS.Width
156:                 .ForeColor     = RGB(0,0,0)
157:                 .Visible       = .T.
158:             ENDWITH
159: 
160:             .AddObject("lbl_4c_Titulo", "Label")
161:             WITH .lbl_4c_Titulo
162:                 .FontBold   = .T.
163:                 .FontName   = "Tahoma"
164:                 .FontSize   = 18
165:                 .WordWrap   = .T.
166:                 .Alignment  = 0
167:                 .AutoSize   = .F.
168:                 .BackStyle  = 0
169:                 .Caption    = THIS.Caption
170:                 .Height     = 46
171:                 .Left       = 10
172:                 .Top        = 17
173:                 .Width      = THIS.Width
174:                 .ForeColor  = RGB(255,255,255)
175:                 .Visible    = .T.
176:             ENDWITH
177:         ENDWITH

*-- Linhas 184 a 193:
184:     PROTECTED PROCEDURE ConfigurarSeparador
185:         THIS.AddObject("shp_4c_ShpP2", "Shape")
186:         WITH THIS.shp_4c_ShpP2
187:             .Top           = 11
188:             .Left          = 819
189:             .Width         = 21
190:             .Height        = 37
191:             .BackStyle     = 0
192:             .BorderStyle   = 0
193:             .SpecialEffect = 1

*-- Linhas 202 a 216:
202:     *   CmdCancela original: Top=3, Left=925, Picture=cadastro_sair_60.jpg, Cancel=.T.
203:     *==========================================================================
204:     PROTECTED PROCEDURE ConfigurarBotoes
205:         THIS.AddObject("cmd_4c_Confirmar", "CommandButton")
206:         WITH THIS.cmd_4c_Confirmar
207:             .Top             = 3
208:             .Left            = 850
209:             .Width           = 75
210:             .Height          = 75
211:             .Caption         = "Confirmar"
212:             .Picture         = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
213:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_disco2_60.jpg"
214:             .Themes          = .T.
215:             .FontName        = "Tahoma"
216:             .FontSize        = 8

*-- Linhas 226 a 240:
226:             .Visible         = .T.
227:         ENDWITH
228: 
229:         THIS.AddObject("cmd_4c_Encerrar", "CommandButton")
230:         WITH THIS.cmd_4c_Encerrar
231:             .Top             = 3
232:             .Left            = 925
233:             .Width           = 75
234:             .Height          = 75
235:             .Caption         = "Encerrar"
236:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
237:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
238:             .Cancel          = .T.
239:             .Themes          = .T.
240:             .FontName        = "Tahoma"

*-- Linhas 286 a 307:
286:     *   Colunas: Emp | Grupo Origem | Conta Origem | Conta Destino | Grupo Destino | Confirmacao | Movimentacao
287:     *==========================================================================
288:     PROTECTED PROCEDURE ConfigurarGrdCab
289:         LOCAL loc_oGrid
290: 
291:         THIS.AddObject("grd_4c_Cab", "Grid")
292:         WITH THIS.grd_4c_Cab
293:             .Top              = 95
294:             .Left             = 11
295:             .Width            = 798
296:             .Height           = 194
297:             .ColumnCount      = 7
298:             .FontName         = "Verdana"
299:             .FontSize         = 8
300:             .AllowHeaderSizing = .F.
301:             .AllowRowSizing   = .F.
302:             .DeleteMark       = .F.
303:             .RecordMark       = .F.
304:             .HeaderHeight     = 15
305:             .ReadOnly         = .T.
306:             .RowHeight        = 16
307:             .ScrollBars       = 2

*-- Linhas 316 a 372:
316:             .Column1.Resizable   = .F.
317:             .Column1.ReadOnly    = .T.
318:             .Column1.FontSize    = 8
319:             .Column1.Header1.Caption   = "Emp"
320:             .Column1.Header1.Alignment = 2
321:             .Column1.Header1.FontName  = "Tahoma"
322:             .Column1.Header1.ForeColor = RGB(0,0,0)
323: 
324:             *-- Coluna 2: Grupo Origem (Width=100, ColumnOrder=3)
325:             .Column2.Width       = 100
326:             .Column2.ColumnOrder = 3
327:             .Column2.Movable     = .F.
328:             .Column2.Resizable   = .F.
329:             .Column2.ReadOnly    = .T.
330:             .Column2.FontSize    = 8
331:             .Column2.Header1.Caption   = "Grupo Origem"
332:             .Column2.Header1.Alignment = 2
333:             .Column2.Header1.FontName  = "Tahoma"
334:             .Column2.Header1.ForeColor = RGB(0,0,0)
335: 
336:             *-- Coluna 3: Conta Origem (Width=100, ColumnOrder=4)
337:             .Column3.Width       = 100
338:             .Column3.ColumnOrder = 4
339:             .Column3.Movable     = .F.
340:             .Column3.Resizable   = .F.
341:             .Column3.ReadOnly    = .T.
342:             .Column3.FontSize    = 8
343:             .Column3.Header1.Caption   = "Conta Origem"
344:             .Column3.Header1.Alignment = 2
345:             .Column3.Header1.FontName  = "Tahoma"
346:             .Column3.Header1.ForeColor = RGB(0,0,0)
347: 
348:             *-- Coluna 4: Conta Destino (Width=100, ColumnOrder=5)
349:             .Column4.Width       = 100
350:             .Column4.ColumnOrder = 5
351:             .Column4.Movable     = .F.
352:             .Column4.Resizable   = .F.
353:             .Column4.ReadOnly    = .T.
354:             .Column4.FontSize    = 8
355:             .Column4.Header1.Caption   = "Conta Destino"
356:             .Column4.Header1.Alignment = 2
357:             .Column4.Header1.FontName  = "Tahoma"
358:             .Column4.Header1.ForeColor = RGB(0,0,0)
359: 
360:             *-- Coluna 5: Grupo Destino (Width=100, ColumnOrder=6)
361:             .Column5.Width       = 100
362:             .Column5.ColumnOrder = 6
363:             .Column5.Movable     = .F.
364:             .Column5.Resizable   = .F.
365:             .Column5.ReadOnly    = .T.
366:             .Column5.FontSize    = 8
367:             .Column5.Header1.Caption   = "Grupo Destino"
368:             .Column5.Header1.Alignment = 2
369:             .Column5.Header1.FontName  = "Tahoma"
370:             .Column5.Header1.ForeColor = RGB(0,0,0)
371: 
372:             *-- Coluna 6: Confirmacao (Width=100, ColumnOrder=7, verde/bold)

*-- Linhas 379 a 399:
379:             .Column6.FontBold    = .T.
380:             .Column6.Alignment   = 2
381:             .Column6.ForeColor   = RGB(0,128,0)
382:             .Column6.Header1.Caption   = "Confirma" + CHR(231) + CHR(227) + "o"
383:             .Column6.Header1.Alignment = 2
384:             .Column6.Header1.FontName  = "Tahoma"
385:             .Column6.Header1.ForeColor = RGB(0,0,0)
386: 
387:             *-- Coluna 7: Movimentacao (Width=225, ColumnOrder=2)
388:             .Column7.Width       = 225
389:             .Column7.ColumnOrder = 2
390:             .Column7.Movable     = .F.
391:             .Column7.Resizable   = .F.
392:             .Column7.ReadOnly    = .T.
393:             .Column7.FontSize    = 8
394:             .Column7.Header1.Caption   = "Movimenta" + CHR(231) + CHR(227) + "o"
395:             .Column7.Header1.Alignment = 2
396:             .Column7.Header1.FontName  = "Tahoma"
397:             .Column7.Header1.ForeColor = RGB(0,0,0)
398: 
399:             *-- ControlSource e DynamicBackColor (vincula ao cursor csCabec)

*-- Linhas 416 a 437:
416:     * ConfigurarGrdIte - Grade de itens (Fase 4)
417:     *   Original: Top=295, Left=10, Width=980, Height=289, ColumnCount=7
418:     *   Colunas: [seq] | Produto | Descricao | M | Pr.Unit. | Quantidade | Total
419:     *==========================================================================
420:     PROTECTED PROCEDURE ConfigurarGrdIte
421:         THIS.AddObject("grd_4c_Ite", "Grid")
422:         WITH THIS.grd_4c_Ite
423:             .Top              = 295
424:             .Left             = 10
425:             .Width            = 980
426:             .Height           = 289
427:             .ColumnCount      = 7
428:             .FontName         = "Verdana"
429:             .FontSize         = 8
430:             .AllowHeaderSizing = .F.
431:             .AllowRowSizing   = .F.
432:             .DeleteMark       = .F.
433:             .RecordMark       = .F.
434:             .HeaderHeight     = 15
435:             .ReadOnly         = .T.
436:             .RowHeight        = 16
437:             .ScrollBars       = 2

*-- Linhas 446 a 526:
446:             .Column1.Resizable   = .F.
447:             .Column1.ReadOnly    = .T.
448:             .Column1.FontSize    = 8
449:             .Column1.Header1.Caption   = ""
450:             .Column1.Header1.Alignment = 2
451:             .Column1.Header1.FontName  = "Tahoma"
452:             .Column1.Header1.ForeColor = RGB(0,0,0)
453: 
454:             *-- Coluna 2: Produto - CPros (Width=120, ColumnOrder=2)
455:             .Column2.Width       = 120
456:             .Column2.ColumnOrder = 2
457:             .Column2.Movable     = .F.
458:             .Column2.Resizable   = .F.
459:             .Column2.ReadOnly    = .T.
460:             .Column2.FontSize    = 8
461:             .Column2.Header1.Caption   = "Produto"
462:             .Column2.Header1.Alignment = 2
463:             .Column2.Header1.FontName  = "Tahoma"
464:             .Column2.Header1.ForeColor = RGB(0,0,0)
465: 
466:             *-- Coluna 3: Descricao do Produto - DPros (Width=403, ColumnOrder=3)
467:             .Column3.Width       = 403
468:             .Column3.ColumnOrder = 3
469:             .Column3.Movable     = .F.
470:             .Column3.Resizable   = .F.
471:             .Column3.ReadOnly    = .T.
472:             .Column3.FontSize    = 8
473:             .Column3.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o do Produto"
474:             .Column3.Header1.Alignment = 2
475:             .Column3.Header1.FontName  = "Tahoma"
476:             .Column3.Header1.ForeColor = RGB(0,0,0)
477: 
478:             *-- Coluna 4: M - Moedas (Width=23, ColumnOrder=4)
479:             .Column4.Width       = 23
480:             .Column4.ColumnOrder = 4
481:             .Column4.Movable     = .F.
482:             .Column4.Resizable   = .F.
483:             .Column4.ReadOnly    = .T.
484:             .Column4.FontSize    = 8
485:             .Column4.Header1.Caption   = "M"
486:             .Column4.Header1.Alignment = 2
487:             .Column4.Header1.FontName  = "Tahoma"
488:             .Column4.Header1.ForeColor = RGB(0,0,0)
489: 
490:             *-- Coluna 5: Preco Unitario - Units (Width=130, ColumnOrder=5)
491:             .Column5.Width       = 130
492:             .Column5.ColumnOrder = 5
493:             .Column5.Movable     = .F.
494:             .Column5.Resizable   = .F.
495:             .Column5.ReadOnly    = .T.
496:             .Column5.FontSize    = 8
497:             .Column5.Header1.Caption   = "Pr. Unit."
498:             .Column5.Header1.Alignment = 2
499:             .Column5.Header1.FontName  = "Tahoma"
500:             .Column5.Header1.ForeColor = RGB(0,0,0)
501: 
502:             *-- Coluna 6: Quantidade - Qtds (Width=100, ColumnOrder=6)
503:             .Column6.Width       = 100
504:             .Column6.ColumnOrder = 6
505:             .Column6.Movable     = .F.
506:             .Column6.Resizable   = .F.
507:             .Column6.ReadOnly    = .T.
508:             .Column6.FontSize    = 8
509:             .Column6.Header1.Caption   = "Quantidade"
510:             .Column6.Header1.Alignment = 2
511:             .Column6.Header1.FontName  = "Tahoma"
512:             .Column6.Header1.ForeColor = RGB(0,0,0)
513: 
514:             *-- Coluna 7: Total - Totas (Width=130, ColumnOrder=7)
515:             .Column7.Width       = 130
516:             .Column7.ColumnOrder = 7
517:             .Column7.Movable     = .F.
518:             .Column7.Resizable   = .F.
519:             .Column7.ReadOnly    = .T.
520:             .Column7.FontSize    = 8
521:             .Column7.Header1.Caption   = "Total"
522:             .Column7.Header1.Alignment = 2
523:             .Column7.Header1.FontName  = "Tahoma"
524:             .Column7.Header1.ForeColor = RGB(0,0,0)
525: 
526:             *-- ControlSource (vincula ao cursor csItens)

*-- Linhas 553 a 573:
553:     *   Original SCX: Text1.BorderStyle=0, Margin=0, ForeColor=0,0,0
554:     *   BackColor=255,255,255 em todos; Column6.Text1 FontBold=.T. Alignment=2
555:     *   ForeColor=0,128,0
556:     *==========================================================================
557:     PROTECTED PROCEDURE ConfigurarTextosGrdCab
558:         WITH THIS.grd_4c_Cab
559:             *-- Propriedades comuns a todos os Text1 das colunas
560:             .SetAll("BorderStyle",   0,                  "Text")
561:             .SetAll("Margin",        0,                  "Text")
562:             .SetAll("ForeColor",     RGB(0,0,0),         "Text")
563:             .SetAll("BackColor",     RGB(255,255,255),   "Text")
564: 
565:             *-- HighlightColors canonicos do grid
566:             .HighlightBackColor = RGB(255,255,255)
567:             .HighlightForeColor = RGB(15,41,104)
568:             .HighlightStyle     = 2
569: 
570:             *-- Coluna 6 (Confirmacao): Text1 verde+bold - SetAll sobrescreveu, restaurar aqui
571:             WITH .Column6
572:                 .FontBold  = .T.
573:                 .Alignment = 2

*-- Linhas 585 a 605:
585:     * ConfigurarTextosGrdIte - Propriedades Text1 de GrdIte + HighlightColors
586:     *   Original SCX: Text1.BorderStyle=0, Margin=0, ForeColor=0,0,0
587:     *   BackColor=255,255,255 em todos
588:     *==========================================================================
589:     PROTECTED PROCEDURE ConfigurarTextosGrdIte
590:         WITH THIS.grd_4c_Ite
591:             *-- Propriedades comuns a todos os Text1 das colunas
592:             .SetAll("BorderStyle",   0,                  "Text")
593:             .SetAll("Margin",        0,                  "Text")
594:             .SetAll("ForeColor",     RGB(0,0,0),         "Text")
595:             .SetAll("BackColor",     RGB(255,255,255),   "Text")
596: 
597:             *-- HighlightColors canonicos do grid
598:             .HighlightBackColor = RGB(255,255,255)
599:             .HighlightForeColor = RGB(15,41,104)
600:             .HighlightStyle     = 2
601:         ENDWITH
602:     ENDPROC
603: 
604:     *==========================================================================
605:     * TornarControlesVisiveis - Torna todos os controles visiveis

*-- Linhas 647 a 718:
647:             SET KEY TO csCabec.EmpDopNums
648:             GO TOP
649:             SELECT csCabec
650:         ENDIF
651: 
652:         IF VARTYPE(THIS.grd_4c_Cab) = "O"
653:             THIS.grd_4c_Cab.Refresh()
654:         ENDIF
655: 
656:         IF VARTYPE(THIS.grd_4c_Ite) = "O"
657:             THIS.grd_4c_Ite.Refresh()
658:         ENDIF
659:     ENDPROC
660: 
661:     *==========================================================================
662:     * ProcessaPeriodo - Stub para nao gerar erro em chamadas do SigMvCab
663:     *   Original SIGPRGST: "Rotina Criada Apenas Para Nao Gerar Erro Nas
664:     *   Chamadas do SigMvCab." ? SigMvCab pode chamar ThisForm.ParentForm.ProcessaPeriodo
665:     *==========================================================================
666:     PROCEDURE ProcessaPeriodo(par_P1, par_P2, par_P3)
667:         RETURN .T.
668:     ENDPROC
669: 
670:     *==========================================================================
671:     * GrdCabAfterRowColChange - Atualiza GrdIte ao mudar linha no GrdCab
672:     *   Original: seleciona csItens com SET KEY TO csCabec.EmpDopNums + Refresh
673:     *==========================================================================
674:     PROCEDURE GrdCabAfterRowColChange(par_nColIndex)
675:         IF USED("csItens") AND USED("csCabec") AND !EOF("csCabec")
676:             SELECT csItens
677:             SET KEY TO csCabec.EmpDopNums
678:             GO TOP
679:             THIS.grd_4c_Ite.Refresh()
680:         ENDIF
681:     ENDPROC
682: 
683:     *==========================================================================
684:     * BtnConfirmarClick - Verifica selecao e chama GerarPedido no BO
685:     *   Original: CmdGrava.Click - valida EOF, chama GerarPedido, abre SigMvCab
686:     *==========================================================================
687:     PROCEDURE BtnConfirmarClick()
688:         LOCAL loc_lResultado, loc_oErro
689:         loc_lResultado = .F.
690: 
691:         TRY
692:             IF !USED("csCabec") OR EOF("csCabec")
693:                 MsgAviso("Selecione um pedido na grade e tente novamente.", ;
694:                     "Aten" + CHR(231) + CHR(227) + "o")
695:             ELSE
696:                 loc_lResultado = THIS.this_oBusinessObject.GerarPedido()
697:                 IF loc_lResultado AND !EMPTY(ALLTRIM(csCabec.Gerado))
698:                     DO FORM SigMvCab WITH ;
699:                         csCabec.GerDopes, csCabec.GerNumes, csCabec.GerEmps, ;
700:                         .T., 3, THIS, .F., .T.
701:                 ENDIF
702:                 THIS.grd_4c_Cab.Refresh()
703:                 THIS.grd_4c_Ite.Refresh()
704:             ENDIF
705: 
706:         CATCH TO loc_oErro
707:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
708:                 " PROC=" + loc_oErro.Procedure, "Erro Confirmar")
709:         ENDTRY
710:     ENDPROC
711: 
712:     *==========================================================================
713:     * BtnEncerrarClick - Verifica pedidos nao confirmados antes de fechar
714:     *   Original: CmdCancela.Click - conta registros com Gerado vazio, confirma
715:     *==========================================================================
716:     PROCEDURE BtnEncerrarClick()
717:         LOCAL loc_lResultado, loc_nFal, loc_oErro
718:         loc_lResultado = .F.

*-- Linhas 762 a 782:
762:     * ConfigurarBINDEVENTs - Vincular eventos de botoes (chamado em Fase 7/8)
763:     *==========================================================================
764:     PROTECTED PROCEDURE ConfigurarBINDEVENTs
765:         BINDEVENT(THIS.cmd_4c_Confirmar,  "Click",              THIS, "BtnConfirmarClick")
766:         BINDEVENT(THIS.cmd_4c_Encerrar,   "Click",              THIS, "BtnEncerrarClick")
767:         BINDEVENT(THIS.grd_4c_Cab, "AfterRowColChange", THIS, "GrdCabAfterRowColChange")
768:     ENDPROC
769: 
770:     *==========================================================================
771:     * BtnIncluirClick - Alias CRUD para OPERACIONAL: incluir = gerar novo
772:     *   pedido de movimentacao a partir da linha selecionada no GrdCab.
773:     *   Delega para BtnConfirmarClick (mesma logica do CmdGrava original).
774:     *==========================================================================
775:     PROCEDURE BtnIncluirClick()
776:         THIS.BtnConfirmarClick()
777:     ENDPROC
778: 
779:     *==========================================================================
780:     * BtnAlterarClick - Alias CRUD para OPERACIONAL: alterar = re-confirmar
781:     *   a geracao do pedido da linha selecionada. Delega para BtnConfirmarClick.
782:     *   O legado nao tem "alterar" separado; GerarPedido no BO ja checa

*-- Linhas 827 a 879:
827:     *==========================================================================
828:     * BOParaForm - Atualiza grades a partir do estado atual do BO/cursores
829:     *   Para OPERACIONAL: forca refresh das grades sem reposicionar cursores.
830:     *==========================================================================
831:     PROTECTED PROCEDURE BOParaForm
832:         IF VARTYPE(THIS.grd_4c_Cab) = "O"
833:             THIS.grd_4c_Cab.Refresh()
834:         ENDIF
835:         IF VARTYPE(THIS.grd_4c_Ite) = "O"
836:             THIS.grd_4c_Ite.Refresh()
837:         ENDIF
838:     ENDPROC
839: 
840:     *==========================================================================
841:     * HabilitarCampos - Para OPERACIONAL: grades sao sempre ReadOnly
842:     *   Mantido para compatibilidade com pipeline; nao ha controles editaveis.
843:     *==========================================================================
844:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
845:         IF VARTYPE(THIS.grd_4c_Cab) = "O"
846:             THIS.grd_4c_Cab.ReadOnly = .T.
847:         ENDIF
848:         IF VARTYPE(THIS.grd_4c_Ite) = "O"
849:             THIS.grd_4c_Ite.ReadOnly = .T.
850:         ENDIF
851:     ENDPROC
852: 
853:     *==========================================================================
854:     * LimparCampos - Para OPERACIONAL: forca refresh das grades
855:     *   Nao ha campos de entrada para limpar; apenas atualiza visualizacao.
856:     *==========================================================================
857:     PROTECTED PROCEDURE LimparCampos
858:         IF VARTYPE(THIS.grd_4c_Cab) = "O"
859:             THIS.grd_4c_Cab.Refresh()
860:         ENDIF
861:         IF VARTYPE(THIS.grd_4c_Ite) = "O"
862:             THIS.grd_4c_Ite.Refresh()
863:         ENDIF
864:     ENDPROC
865: 
866:     *==========================================================================
867:     * AjustarBotoesPorModo - Para OPERACIONAL: habilita Confirmar e Encerrar.
868:     *==========================================================================
869:     PROTECTED PROCEDURE AjustarBotoesPorModo
870:         IF VARTYPE(THIS.cmd_4c_Confirmar) = "O"
871:             THIS.cmd_4c_Confirmar.Enabled = .T.
872:         ENDIF
873:         IF VARTYPE(THIS.cmd_4c_Encerrar) = "O"
874:             THIS.cmd_4c_Encerrar.Enabled = .T.
875:         ENDIF
876:     ENDPROC
877: 
878:     *==========================================================================
879:     * BtnBuscarClick - Alias CRUD para OPERACIONAL: buscar = sincronizar grades


### BO (C:\4c\projeto\app\classes\SigPrGstBO.prg):
*==============================================================================
* SigPrGstBO.prg - Business Object: Geracao de Movimentacoes de Estoque
*
* Tabela principal : SigMvCab (cabecalho de movimentacao gerado)
* Chave primaria   : EmpDopNums (composta: Emps + Dopes + STR(Numes,6))
* Herda de         : BusinessBase
*
* Este BO opera sobre cursores passados pelo formulario pai:
*   Entrada  : csCabec, csItens, CsEstPe, CrSigCdNec
*   Saida    : SigMvCab, SigMvItn, SigMvIts, SigMvPec, SigInBep (via SQLEXEC)
*==============================================================================

DEFINE CLASS SigPrGstBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Contexto do formulario (recebido do pai via Init)
    *--------------------------------------------------------------------------
    this_cGrupoOper     = ""    && Grupo de operacao (C10)
    this_cPcEscolha     = ""    && Escolha de processamento passada pelo pai

    *--------------------------------------------------------------------------
    * Campos de csCabec - Cabecalho da necessidade/pedido de origem
    *--------------------------------------------------------------------------
    this_cEmps          = ""    && Empresa (C3)
    this_cEmpDs         = ""    && Descricao da empresa (display)
    this_cDopes         = ""    && Codigo da operacao (C20)
    this_nNumes         = 0     && Numero do pedido (N6,0)
    this_cMascNum       = ""    && Mascara formatada do numero
    this_dDatars        = {}    && Data de referencia do pedido
    this_cIdChaves      = ""    && ID unico (via fUniqueIds)
    this_cEmpDopNums    = ""    && Chave composta: Emps + Dopes + STR(Numes,6) (C29)
    this_cEmpDnPs       = ""    && Chave composta da NEC origem (EmpDnPs)
    this_cGrupoOs       = ""    && Grupo de Conta Origem (C10)
    this_cContaOs       = ""    && Conta de Origem (C10)
    this_cGrupoDs       = ""    && Grupo de Conta Destino (C10)
    this_cContaDs       = ""    && Conta de Destino (C10)
    this_cGerado        = ""    && Flag: "OK" se pedido ja gerou movimento
    this_cGerEmps       = ""    && Empresa do movimento gerado (SigMvCab.Emps)
    this_cGerDopes      = ""    && Operacao do movimento gerado (SigMvCab.Dopes)
    this_nGerNumes      = 0     && Numero do movimento gerado (SigMvCab.Numes, N6,0)

    *--------------------------------------------------------------------------
    * Campos de csItens - Item corrente do pedido
    *--------------------------------------------------------------------------
    this_nCItens        = 0     && Numero sequencial do item
    this_cCPros         = ""    && Codigo do produto
    this_cDPros         = ""    && Descricao do produto
    this_cMoedas        = ""    && Moeda de cotacao
    this_nUnits         = 0     && Preco unitario
    this_nQtds          = 0     && Quantidade solicitada
    this_nTotas         = 0     && Total do item

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor csCabec para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cEmps       = TratarNulo(Emps, "C")
                THIS.this_cDopes      = TratarNulo(Dopes, "C")
                THIS.this_nNumes      = TratarNulo(Numes, "N")
                THIS.this_cMascNum    = TratarNulo(MascNum, "C")
                THIS.this_cGrupoOs    = TratarNulo(GrupoOs, "C")
                THIS.this_cContaOs    = TratarNulo(ContaOs, "C")
                THIS.this_cGrupoDs    = TratarNulo(GrupoDs, "C")
                THIS.this_cContaDs    = TratarNulo(ContaDs, "C")
                THIS.this_cGerado     = TratarNulo(Gerado, "C")
                THIS.this_cGerEmps    = TratarNulo(GerEmps, "C")
                THIS.this_cGerDopes   = TratarNulo(GerDopes, "C")
                THIS.this_nGerNumes   = TratarNulo(GerNumes, "N")
                THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
                IF TYPE("EmpDnPs") != "U"
                    THIS.this_cEmpDnPs = TratarNulo(EmpDnPs, "C")
                ENDIF
                IF TYPE("Datars") != "U"
                    THIS.this_dDatars = TratarNulo(Datars, "D")
                ENDIF
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro corrente
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cEmpDopNums)
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Verifica pre-condicoes para gerar pedido
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF !USED("csCabec") OR EOF("csCabec")
            THIS.this_cMensagemErro = "Selecione um pedido na grade e tente novamente."
            RETURN .F.
        ENDIF
        IF !EMPTY(ALLTRIM(csCabec.Gerado))
            THIS.this_cMensagemErro = "Este pedido j" + CHR(225) + " foi gerado anteriormente."
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarPedido - Opera principal: gera movimentacoes de estoque a partir
    *   dos cursores csCabec, csItens e CsEstPe para as tabelas SQL Server.
    *   Equivalente ao PROCEDURE gerarpedido do formulario legado.
    *--------------------------------------------------------------------------
    PROCEDURE GerarPedido()
        LOCAL loc_lResultado, loc_lOks, loc_lTransacaoAberta
        LOCAL loc_nNum, loc_cMascNum, loc_cEmpDopNums, loc_cSQL
        LOCAL loc_cEmps, loc_cDopes, loc_cGrupoOs, loc_cContaOs
        LOCAL loc_cGrupoDs, loc_cContaDs, loc_cEmpDnPsNec
        LOCAL loc_loBarra

        loc_lResultado       = .F.
        loc_lOks             = .T.
        loc_lTransacaoAberta = .F.

        TRY
            *-- Verificar pre-condicoes
            IF !THIS.ValidarDados()
                MsgAviso(THIS.this_cMensagemErro, "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE

                *-- Se ja gerado, retornar .T. diretamente (sem nova geracao)
                IF !EMPTY(ALLTRIM(csCabec.Gerado))
                    loc_lResultado = .T.
                ELSE

                    *-- Capturar campos do csCabec ANTES de qualquer SQLEXEC
                    loc_cEmps    = ALLTRIM(csCabec.Emps)
                    loc_cDopes   = PADR(ALLTRIM(csCabec.Dopes), 20)
                    loc_cGrupoOs = ALLTRIM(csCabec.GrupoOs)
                    loc_cContaOs = ALLTRIM(csCabec.ContaOs)
                    loc_cGrupoDs = ALLTRIM(csCabec.GrupoDs)
                    loc_cContaDs = ALLTRIM(csCabec.ContaDs)

                    *-- Capturar EmpDnPs de CrSigCdNec
                    loc_cEmpDnPsNec = ""
                    IF USED("CrSigCdNec") AND !EOF("CrSigCdNec")
                        loc_cEmpDnPsNec = ALLTRIM(CrSigCdNec.EmpDnPs)
                    ENDIF

                    *-- Carregar SigCdEmb para divisao de embalagem
                    loc_cSQL = "SELECT Cods, Multis FROM SigCdEmb"
                    IF USED("crSigCdEmb")
                        USE IN crSigCdEmb
                    ENDIF
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigCdEmb") < 1
                        loc_lOks = .F.
                        MsgErro("Falha ao carregar tabela de embalagem (SigCdEmb)", "Erro")
                    ENDIF

                    IF loc_lOks
                        SELECT crSigCdEmb
                        INDEX ON UPPER(ALLTRIM(Cods)) TAG Cods
                        GO TOP IN crSigCdEmb

                        *-- Gerar numero unico e mascara para o novo movimento
                        loc_nNum        = fGerUniqueKey(ALLTRIM(loc_cDopes) + go_4c_Sistema.cCodEmpresa)
                        loc_cMascNum    = ALLTRIM(fGerMascara(loc_nNum))
                        loc_cEmpDopNums = loc_cEmps + PADR(ALLTRIM(loc_cDopes), 20) + STR(loc_nNum, 6)

                        *-- Barra de progresso
                        loc_loBarra = CREATEOBJECT("fwprogressbar", ;
                            "Gravando " + ALLTRIM(loc_cDopes) + "...", 3)
                        loc_loBarra.Show()
                        loc_loBarra.Update(.T., "Gerando Informa" + CHR(231) + CHR(245) + ;
                            "es Para Lan" + CHR(231) + "amento")

                        *-- Iniciar transacao SQL Server
                        SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
                        loc_lTransacaoAberta = .T.

                        *-- INSERT INTO SigMvCab
                        loc_cSQL = "INSERT INTO SigMvCab " + ;
                                   "(emps, dopes, numes, datars, mascnum, " + ;
                                   " grupoos, contaos, grupods, contads, " + ;
                                   " usuars, empdopnums, cidchaves, empdnps, dtalts) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                   FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                   FormatarDataSQL(DATE()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cMascNum, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
                                   EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cEmpDnPsNec, 29)) + ", " + ;
                                   "GETDATE())"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            loc_lOks = .F.
                            MsgErro("Falha ao inserir cabe" + CHR(231) + "alho de " + ;
                                "movimenta" + CHR(231) + CHR(227) + "o (SigMvCab)", "Erro")
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        *-- INSERT INTO SigInBep (rastreio - mesmo conteudo que SigMvCab)
                        loc_cSQL = "INSERT INTO SigInBep " + ;
                                   "(emps, dopes, numes, datars, mascnum, " + ;
                                   " grupoos, contaos, grupods, contads, " + ;
                                   " usuars, empdopnums, cidchaves, empdnps, dtalts) " + ;
                                   "VALUES (" + ;
                                   EscaparSQL(loc_cEmps) + ", " + ;
                                   EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                   FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                   FormatarDataSQL(DATE()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cMascNum, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaOs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cGrupoDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(loc_cContaDs, 10)) + ", " + ;
                                   EscaparSQL(LEFT(gc_4c_UsuarioLogado, 10)) + ", " + ;
                                   EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                   EscaparSQL(fUniqueIds()) + ", " + ;
                                   EscaparSQL(LEFT(loc_cEmpDnPsNec, 29)) + ", " + ;
                                   "GETDATE())"
                        IF SQLEXEC(gnConnHandle, loc_cSQL) < 1
                            loc_lOks = .F.
                            MsgErro("Falha ao inserir registro de rastreio (SigInBep)", "Erro")
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        loc_loBarra.Update(.T., "Gerando Informa" + CHR(231) + CHR(245) + ;
                            "es Dos Itens")

                        *-- Processar itens de csItens -> SigMvItn e SigMvIts
                        LOCAL loc_nCItens, loc_cCPros, loc_cDPros, loc_cMoedas
                        LOCAL loc_nUnits, loc_nQtds, loc_nTotas
                        LOCAL loc_cCGrus, loc_cCUnisPro, loc_nTipoEstos, loc_nEmbs
                        LOCAL loc_cSQLItem, loc_nMultis, loc_cCodEmbs, loc_nQtdEmb
                        LOCAL loc_lSub

                        IF USED("csItens")
                            SELECT csItens
                            SET KEY TO csCabec.EmpDopNums
                            GO TOP

                            SCAN
                                IF !loc_lOks
                                    LOOP
                                ENDIF

                                *-- Capturar campos do item ANTES de SQLEXEC
                                loc_nCItens = csItens.CItens
                                loc_cCPros  = ALLTRIM(csItens.CPros)
                                loc_cDPros  = LEFT(ALLTRIM(csItens.DPros), 65)
                                loc_cMoedas = LEFT(ALLTRIM(csItens.Moedas), 3)
                                loc_nUnits  = NVL(csItens.Units, 0)
                                loc_nQtds   = NVL(csItens.Qtds, 0)
                                loc_nTotas  = NVL(csItens.Totas, 0)

                                *-- Buscar dados do produto (grupo e unidade)
                                loc_cCGrus   = ""
                                loc_cCUnisPro = ""
                                loc_cSQLItem = "SELECT TOP 1 cgrus, cunis FROM SigCdPro " + ;
                                               "WHERE cpros = " + EscaparSQL(loc_cCPros)
                                IF USED("crTmpPro")
                                    USE IN crTmpPro
                                ENDIF
                                IF SQLEXEC(gnConnHandle, loc_cSQLItem, "crTmpPro") > 0
                                    SELECT crTmpPro
                                    IF !EOF()
                                        loc_cCGrus    = ALLTRIM(cgrus)
                                        loc_cCUnisPro = ALLTRIM(cunis)
                                    ENDIF
                                ENDIF

                                *-- Buscar tipo do grupo (para verificar embalagem)
                                loc_nTipoEstos = 0
                                loc_nEmbs      = 0
                                IF !EMPTY(loc_cCGrus)
                                    loc_cSQLItem = "SELECT TOP 1 tipoestos, embs FROM SigCdGrp " + ;
                                                   "WHERE cgrus = " + EscaparSQL(loc_cCGrus)
                                    IF USED("crTmpGru")
                                        USE IN crTmpGru
                                    ENDIF
                                    IF SQLEXEC(gnConnHandle, loc_cSQLItem, "crTmpGru") > 0
                                        SELECT crTmpGru
                                        IF !EOF()
                                            loc_nTipoEstos = NVL(tipoestos, 0)
                                            loc_nEmbs      = NVL(embs, 0)
                                        ENDIF
                                    ENDIF
                                ENDIF

                                *-- INSERT INTO SigMvItn
                                loc_cSQLItem = "INSERT INTO SigMvItn " + ;
                                    "(emps, dopes, numes, citens, cpros, dpros, " + ;
                                    " moedas, units, qtds, totas, empdopnums, cidchaves, dtalts) " + ;
                                    "VALUES (" + ;
                                    EscaparSQL(loc_cEmps) + ", " + ;
                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                    FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                    FormatarNumeroSQL(loc_nCItens, 0) + ", " + ;
                                    EscaparSQL(loc_cCPros) + ", " + ;
                                    EscaparSQL(loc_cDPros) + ", " + ;
                                    EscaparSQL(loc_cMoedas) + ", " + ;
                                    FormatarNumeroSQL(loc_nUnits, 5) + ", " + ;
                                    FormatarNumeroSQL(loc_nQtds, 3) + ", " + ;
                                    FormatarNumeroSQL(loc_nTotas, 2) + ", " + ;
                                    EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                    EscaparSQL(fUniqueIds()) + ", " + ;
                                    "GETDATE())"
                                IF SQLEXEC(gnConnHandle, loc_cSQLItem) < 1
                                    loc_lOks = .F.
                                    MsgErro("Falha ao inserir item de movimenta" + ;
                                        CHR(231) + CHR(227) + "o (SigMvItn)", "Erro")
                                ENDIF

                                *-- Verificar embalagem e inserir SigMvIts se aplicavel
                                IF loc_lOks
                                    loc_lSub = (INLIST(loc_nTipoEstos, 2, 3, 4) OR loc_nEmbs = 1)
                                    IF loc_lSub AND !EMPTY(loc_cCUnisPro)
                                        loc_nMultis  = 0
                                        loc_cCodEmbs = ""
                                        SELECT crSigCdEmb
                                        IF SEEK(UPPER(ALLTRIM(loc_cCUnisPro)), "crSigCdEmb", "Cods")
                                            loc_nMultis  = NVL(crSigCdEmb.Multis, 0)
                                            loc_cCodEmbs = ALLTRIM(crSigCdEmb.Cods)
                                        ENDIF

                                        IF loc_nMultis > 0 AND !EMPTY(loc_cCodEmbs)
                                            loc_nQtdEmb = loc_nQtds / loc_nMultis
                                            loc_cSQLItem = "INSERT INTO SigMvIts " + ;
                                                "(emps, dopes, numes, cpros, citens, qtds, " + ;
                                                " codembs, qtdembs, empdopnums, cidchaves, dtalts) " + ;
                                                "VALUES (" + ;
                                                EscaparSQL(loc_cEmps) + ", " + ;
                                                EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                                FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                                EscaparSQL(loc_cCPros) + ", " + ;
                                                FormatarNumeroSQL(loc_nCItens, 0) + ", " + ;
                                                FormatarNumeroSQL(loc_nQtdEmb, 3) + ", " + ;
                                                EscaparSQL(loc_cCodEmbs) + ", " + ;
                                                FormatarNumeroSQL(loc_nMultis, 3) + ", " + ;
                                                EscaparSQL(loc_cEmpDopNums) + ", " + ;
                                                EscaparSQL(fUniqueIds()) + ", " + ;
                                                "GETDATE())"
                                            IF SQLEXEC(gnConnHandle, loc_cSQLItem) < 1
                                                loc_lOks = .F.
                                                MsgErro("Falha ao inserir subitem de embalagem (SigMvIts)", "Erro")
                                            ENDIF
                                        ENDIF
                                    ENDIF
                                ENDIF

                                SELECT csItens
                            ENDSCAN

                            SELECT csItens
                            SET KEY TO
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        *-- Processar CsEstPe -> SigMvPec
                        IF USED("CsEstPe")
                            LOCAL loc_nCodigos, loc_dDatatrans, loc_nNtrans
                            LOCAL loc_cLocals, loc_nValobxs, loc_cEmpSubsLocal
                            LOCAL loc_dDatas, loc_lChksubn, loc_dDtagends
                            LOCAL loc_lChkpagos, loc_nNparcs, loc_nValps
                            LOCAL loc_nValvars, loc_dVencps, loc_cPstatus
                            LOCAL loc_cEmpDopNumsPec, loc_cSQLPec

                            SELECT CsEstPe
                            SET KEY TO csCabec.EmpDopNums
                            GO TOP

                            SCAN
                                IF !loc_lOks
                                    LOOP
                                ENDIF

                                *-- Capturar campos ANTES de SQLEXEC
                                loc_nCodigos     = NVL(CsEstPe.Codigos, 0)
                                loc_dDatatrans   = CsEstPe.Datatrans
                                loc_nNtrans      = NVL(CsEstPe.Ntrans, 0)
                                loc_cLocals      = ALLTRIM(CsEstPe.Locals)
                                loc_nValobxs     = NVL(CsEstPe.Valobxs, 0)
                                loc_cEmpSubsLocal = ALLTRIM(go_4c_Sistema.cCodEmpresa)
                                loc_dDatas       = CsEstPe.Datas
                                loc_lChksubn     = IIF(VARTYPE(CsEstPe.Chksubn) = "L", ;
                                                       CsEstPe.Chksubn, ;
                                                       NVL(CsEstPe.Chksubn, 0) = 1)
                                loc_dDtagends    = CsEstPe.Dtagends
                                loc_lChkpagos    = IIF(VARTYPE(CsEstPe.Chkpagos) = "L", ;
                                                       CsEstPe.Chkpagos, ;
                                                       NVL(CsEstPe.Chkpagos, 0) = 1)
                                loc_nNparcs      = NVL(CsEstPe.Nparcs, 0)
                                loc_nValps       = NVL(CsEstPe.Valps, 0)
                                loc_nValvars     = NVL(CsEstPe.Valvars, 0)
                                loc_dVencps      = CsEstPe.Vencps
                                loc_cPstatus     = LEFT(ALLTRIM(CsEstPe.Pstatus), 1)
                                loc_cEmpDopNumsPec = loc_cEmps + PADR(ALLTRIM(loc_cDopes), 20) + ;
                                                     STR(loc_nNum, 6)

                                loc_cSQLPec = "INSERT INTO SigMvPec " + ;
                                    "(emps, dopes, numes, codigos, datatrans, ntrans, " + ;
                                    " locals, valobxs, cidchaves, empdopnums, empsubns, " + ;
                                    " datas, chksubn, dtagends, chkpagos, nparcs, " + ;
                                    " valps, valvars, vencps, pstatus) " + ;
                                    "VALUES (" + ;
                                    EscaparSQL(loc_cEmps) + ", " + ;
                                    EscaparSQL(PADR(ALLTRIM(loc_cDopes), 20)) + ", " + ;
                                    FormatarNumeroSQL(loc_nNum, 0) + ", " + ;
                                    FormatarNumeroSQL(loc_nCodigos, 0) + ", " + ;
                                    FormatarDataSQL(loc_dDatatrans) + ", " + ;
                                    FormatarNumeroSQL(loc_nNtrans, 0) + ", " + ;
                                    EscaparSQL(LEFT(loc_cLocals, 10)) + ", " + ;
                                    FormatarNumeroSQL(loc_nValobxs, 2) + ", " + ;
                                    EscaparSQL(fUniqueIds()) + ", " + ;
                                    EscaparSQL(loc_cEmpDopNumsPec) + ", " + ;
                                    EscaparSQL(LEFT(loc_cEmpSubsLocal, 3)) + ", " + ;
                                    FormatarDataSQL(loc_dDatas) + ", " + ;
                                    IIF(loc_lChksubn, "1", "0") + ", " + ;
                                    FormatarDataSQL(loc_dDtagends) + ", " + ;
                                    IIF(loc_lChkpagos, "1", "0") + ", " + ;
                                    FormatarNumeroSQL(loc_nNparcs, 0) + ", " + ;
                                    FormatarNumeroSQL(loc_nValps, 2) + ", " + ;
                                    FormatarNumeroSQL(loc_nValvars, 2) + ", " + ;
                                    FormatarDataSQL(loc_dVencps) + ", " + ;
                                    EscaparSQL(loc_cPstatus) + ")"
                                IF SQLEXEC(gnConnHandle, loc_cSQLPec) < 1
                                    loc_lOks = .F.
                                    MsgErro("Falha ao inserir parcela de pedido (SigMvPec)", "Erro")
                                ENDIF

                                SELECT CsEstPe
                            ENDSCAN

                            SELECT CsEstPe
                            SET KEY TO
                        ENDIF
                    ENDIF

                    IF loc_lOks
                        loc_loBarra.Update(.T., "Preparando Grava" + CHR(231) + CHR(227) + "o")

                        *-- Auditoria
                        THIS.this_cDopes    = ALLTRIM(loc_cDopes)
                        THIS.this_cGerEmps  = loc_cEmps
                        THIS.this_cGerDopes = ALLTRIM(loc_cDopes)
                        THIS.this_nGerNumes = loc_nNum
                        THIS.RegistrarAuditoria("GERAR")

                        *-- Commit da transacao
                        IF SQLEXEC(gnConnHandle, "COMMIT TRANSACTION") < 1
                            loc_lOks = .F.
                            MsgErro("Falha ao confirmar a transa" + CHR(231) + CHR(227) + "o", "Erro")
                        ELSE
                            loc_lTransacaoAberta = .F.
                        ENDIF
                    ENDIF

                    IF !loc_lOks AND loc_lTransacaoAberta
                        SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
                        loc_lTransacaoAberta = .F.
                    ENDIF

                    IF loc_lOks
                        *-- Atualizar csCabec local com marcacao de gerado
                        SELECT csCabec
                        REPLACE Gerado   WITH "OK", ;
                                GerEmps  WITH loc_cEmps, ;
                                GerDopes WITH ALLTRIM(loc_cDopes), ;
                                GerNumes WITH loc_nNum

                        THIS.this_cEmpDopNums = loc_cEmpDopNums
                        loc_lResultado = .T.
                    ENDIF

                    *-- Fechar cursores temporarios
                    IF USED("crSigCdEmb")
                        USE IN crSigCdEmb
                    ENDIF
                    IF USED("crTmpPro")
                        USE IN crTmpPro
                    ENDIF
                    IF USED("crTmpGru")
                        USE IN crTmpGru
                    ENDIF

                    loc_loBarra.Complete(.T.)

                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
                " PROC=" + loc_oErro.Procedure, "Erro GerarPedido")
            IF loc_lTransacaoAberta
                SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
            ENDIF
        ENDTRY

        *-- Restaurar SET KEY dos cursores de iteracao
        IF USED("csItens")
            SELECT csItens
            SET KEY TO
        ENDIF
        IF USED("CsEstPe")
            SELECT CsEstPe
            SET KEY TO
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarPeriodo - Stub de compatibilidade com chamadas de SigMvCab
    * O formulario legado definia este metodo para nao gerar erro nas chamadas
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarPeriodo(par_P1, par_P2, par_P3)
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Log da operacao de geracao de movimento
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cMsg, loc_cDopps
        loc_cDopps = ""
        IF USED("CrSigCdNec") AND !EOF("CrSigCdNec")
            IF TYPE("CrSigCdNec.Dopps") != "U"
                loc_cDopps = ALLTRIM(CrSigCdNec.Dopps)
            ENDIF
        ENDIF
        loc_cMsg = "Ger.Movim.: " + ALLTRIM(THIS.this_cGerDopes) + ;
                   " Num." + ALLTRIM(STR(THIS.this_nGerNumes, 6)) + ;
                   " Emp." + ALLTRIM(THIS.this_cGerEmps)
        IF !EMPTY(loc_cDopps)
            =fGravarLog("T", loc_cDopps, gc_4c_UsuarioLogado, loc_cMsg)
        ENDIF
    ENDPROC

ENDDEFINE

