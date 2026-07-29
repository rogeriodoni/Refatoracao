# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Descrição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCla.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1562 linhas total):

*-- Linhas 53 a 61:
53:         loc_lResultado = .F.
54: 
55:         TRY
56:             THIS.Caption = "Cadastro de Classifica" + CHR(231) + CHR(227) + "o de Produto"
57: 
58:             THIS.this_oBusinessObject = CREATEOBJECT("ClaBO")
59: 
60:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
61:                 MsgErro("Falha ao criar ClaBO", "Erro")

*-- Linhas 70 a 79:
70: 
71:                 THIS.ConfigurarPageFrame()
72: 
73:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
74:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
75: 
76:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
77:                     THIS.CarregarLista()
78:                 ENDIF
79: 

*-- Linhas 99 a 116:
99: 
100:         WITH loc_oPgf
101:             .PageCount       = 2
102:             .Top             = -29
103:             .Left            = 0
104:             .Width           = THIS.Width
105:             .Height          = THIS.Height + 29
106:             .Tabs            = .F.
107:             .Visible         = .T.
108:             .Page1.Caption   = "Lista"
109:             .Page1.BackColor = RGB(100, 100, 100)
110:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
111:             .Page2.Caption   = "Dados"
112:             .Page2.BackColor = RGB(100, 100, 100)
113:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:         ENDWITH
115: 
116:         THIS.ConfigurarPaginaLista()

*-- Linhas 128 a 166:
128:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
129:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
130:         WITH loc_oCab
131:             .Top         = 31
132:             .Left        = 0
133:             .Width       = THIS.Width
134:             .Height      = 80
135:             .BackColor   = RGB(100, 100, 100)
136:             .BorderWidth = 0
137:             .Visible     = .T.
138:         ENDWITH
139: 
140:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
141:         WITH loc_oCab.lbl_4c_Sombra
142:             .AutoSize  = .F.
143:             .Caption   = THIS.Caption
144:             .Top       = 15
145:             .Left      = 10
146:             .Width     = THIS.Width
147:             .Height    = 40
148:             .FontName  = "Tahoma"
149:             .FontSize  = 16
150:             .FontBold  = .T.
151:             .ForeColor = RGB(0, 0, 0)
152:             .BackStyle = 0
153:             .Visible   = .T.
154:         ENDWITH
155: 
156:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
157:         WITH loc_oCab.lbl_4c_Titulo
158:             .AutoSize  = .F.
159:             .Caption   = THIS.Caption
160:             .Top       = 18
161:             .Left      = 10
162:             .Width     = THIS.Width
163:             .Height    = 46
164:             .FontName  = "Tahoma"
165:             .FontSize  = 16
166:             .FontBold  = .T.

*-- Linhas 173 a 197:
173:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
174:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
175:         WITH loc_oBotoes
176:             .Top         = 29
177:             .Left        = 542
178:             .Width       = 390
179:             .Height      = 85
180:             .BackColor   = RGB(53, 53, 53)
181:             .BackStyle   = 1
182:             .BorderWidth = 0
183:             .Visible     = .T.
184:         ENDWITH
185: 
186:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
187:         WITH loc_oBotoes.cmd_4c_Incluir
188:             .Caption         = "Incluir"
189:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
190:             .PicturePosition = 13
191:             .Top             = 5
192:             .Left            = 5
193:             .Width           = 75
194:             .Height          = 75
195:             .BackColor       = RGB(255, 255, 255)
196:             .ForeColor       = RGB(90, 90, 90)
197:             .FontName        = "Tahoma"

*-- Linhas 205 a 221:
205:             .AutoSize        = .F.
206:             .Visible         = .T.
207:         ENDWITH
208:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
209: 
210:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
211:         WITH loc_oBotoes.cmd_4c_Visualizar
212:             .Caption         = "Visualizar"
213:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
214:             .PicturePosition = 13
215:             .Top             = 5
216:             .Left            = 80
217:             .Width           = 75
218:             .Height          = 75
219:             .BackColor       = RGB(255, 255, 255)
220:             .ForeColor       = RGB(90, 90, 90)
221:             .FontName        = "Tahoma"

*-- Linhas 229 a 245:
229:             .AutoSize        = .F.
230:             .Visible         = .T.
231:         ENDWITH
232:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
233: 
234:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
235:         WITH loc_oBotoes.cmd_4c_Alterar
236:             .Caption         = "Alterar"
237:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
238:             .PicturePosition = 13
239:             .Top             = 5
240:             .Left            = 155
241:             .Width           = 75
242:             .Height          = 75
243:             .BackColor       = RGB(255, 255, 255)
244:             .ForeColor       = RGB(90, 90, 90)
245:             .FontName        = "Tahoma"

*-- Linhas 253 a 269:
253:             .AutoSize        = .F.
254:             .Visible         = .T.
255:         ENDWITH
256:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
257: 
258:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
259:         WITH loc_oBotoes.cmd_4c_Excluir
260:             .Caption         = "Excluir"
261:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
262:             .PicturePosition = 13
263:             .Top             = 5
264:             .Left            = 230
265:             .Width           = 75
266:             .Height          = 75
267:             .BackColor       = RGB(255, 255, 255)
268:             .ForeColor       = RGB(90, 90, 90)
269:             .FontName        = "Tahoma"

*-- Linhas 277 a 293:
277:             .AutoSize        = .F.
278:             .Visible         = .T.
279:         ENDWITH
280:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
281: 
282:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
283:         WITH loc_oBotoes.cmd_4c_Buscar
284:             .Caption         = "Buscar"
285:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
286:             .PicturePosition = 13
287:             .Top             = 5
288:             .Left            = 305
289:             .Width           = 75
290:             .Height          = 75
291:             .BackColor       = RGB(255, 255, 255)
292:             .ForeColor       = RGB(90, 90, 90)
293:             .FontName        = "Tahoma"

*-- Linhas 301 a 330:
301:             .AutoSize        = .F.
302:             .Visible         = .T.
303:         ENDWITH
304:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
305: 
306:         *-- Container Encerrar canonico
307:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
308:         loc_oSaida = loc_oPg1.cnt_4c_Saida
309:         WITH loc_oSaida
310:             .Top         = 29
311:             .Left        = 917
312:             .Width       = 90
313:             .Height      = 85
314:             .BackStyle   = 0
315:             .BorderWidth = 0
316:             .Visible     = .T.
317:         ENDWITH
318: 
319:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
320:         WITH loc_oSaida.cmd_4c_Encerrar
321:             .Caption         = "Encerrar"
322:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
323:             .PicturePosition = 13
324:             .Top             = 5
325:             .Left            = 5
326:             .Width           = 75
327:             .Height          = 75
328:             .BackColor       = RGB(255, 255, 255)
329:             .ForeColor       = RGB(90, 90, 90)
330:             .FontName        = "Tahoma"

*-- Linhas 338 a 353:
338:             .AutoSize        = .F.
339:             .Visible         = .T.
340:         ENDWITH
341:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
342: 
343:         *-- Grid de listagem (dados carregados por CarregarLista)
344:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
345:         loc_oGrid = loc_oPg1.grd_4c_Lista
346:         WITH loc_oGrid
347:             .Top                = 117
348:             .Left               = 12
349:             .Width              = 890
350:             .Height             = 498
351:             .FontName           = "Verdana"
352:             .FontSize           = 8
353:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 376 a 403:
376:         LOCAL loc_oPg2, loc_oBotoesAcao, loc_oOpt
377:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
378: 
379:         *-- Container Confirmar/Cancelar (Grupo_Salva.Left=820, Top=8+29=37)
380:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
381:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
382:         WITH loc_oBotoesAcao
383:             .Top         = 37
384:             .Left        = 820
385:             .Width       = 160
386:             .Height      = 85
387:             .BackStyle   = 0
388:             .BorderWidth = 0
389:             .Visible     = .T.
390:         ENDWITH
391: 
392:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
393:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
394:             .Caption         = "Confirmar"
395:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
396:             .PicturePosition = 13
397:             .Top             = 5
398:             .Left            = 5
399:             .Width           = 75
400:             .Height          = 75
401:             .BackColor       = RGB(255, 255, 255)
402:             .ForeColor       = RGB(90, 90, 90)
403:             .FontName        = "Tahoma"

*-- Linhas 411 a 427:
411:             .AutoSize        = .F.
412:             .Visible         = .T.
413:         ENDWITH
414:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
415: 
416:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
417:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
418:             .Caption         = "Encerrar"
419:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
420:             .PicturePosition = 13
421:             .Top             = 5
422:             .Left            = 80
423:             .Width           = 75
424:             .Height          = 75
425:             .BackColor       = RGB(255, 255, 255)
426:             .ForeColor       = RGB(90, 90, 90)
427:             .FontName        = "Tahoma"

*-- Linhas 435 a 451:
435:             .AutoSize        = .F.
436:             .Visible         = .T.
437:         ENDWITH
438:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
439: 
440:         *-------- Say1 + Getcods: Codigo (Top=85+29=114, Left=280 / Top=81+29=110, Left=326) ----
441:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
442:         WITH loc_oPg2.lbl_4c_Label1
443:             .AutoSize  = .F.
444:             .Caption   = "Codigo :"
445:             .Top       = 114
446:             .Left      = 280
447:             .Width     = 42
448:             .Height    = 15
449:             .FontName  = "Tahoma"
450:             .FontSize  = 8
451:             .FontBold  = .F.

*-- Linhas 459 a 483:
459:             .Value         = ""
460:             .Alignment     = 3
461:             .Height        = 24
462:             .Left          = 326
463:             .Top           = 110
464:             .Width         = 38
465:             .MaxLength     = 3
466:             .SpecialEffect = 1
467:             .FontName      = "Tahoma"
468:             .FontSize      = 8
469:             .Visible       = .T.
470:         ENDWITH
471: 
472:         *-------- Say2 + Getdescs: Descricao (Top=112+29=141 / Top=108+29=137) ----------------
473:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
474:         WITH loc_oPg2.lbl_4c_Label2
475:             .AutoSize  = .F.
476:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
477:             .Top       = 141
478:             .Left      = 267
479:             .Width     = 55
480:             .Height    = 15
481:             .FontName  = "Tahoma"
482:             .FontSize  = 8
483:             .FontBold  = .F.

*-- Linhas 490 a 514:
490:         WITH loc_oPg2.txt_4c_Descricao
491:             .Value         = ""
492:             .Height        = 24
493:             .Left          = 326
494:             .Top           = 137
495:             .Width         = 290
496:             .MaxLength     = 40
497:             .SpecialEffect = 1
498:             .FontName      = "Tahoma"
499:             .FontSize      = 8
500:             .Visible       = .T.
501:         ENDWITH
502: 
503:         *-------- Say5 + GetTipos: Tipo (Top=140+29=169 / Top=135+29=164) ---------------------
504:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
505:         WITH loc_oPg2.lbl_4c_Label5
506:             .AutoSize  = .F.
507:             .Caption   = "Tipo :"
508:             .Top       = 169
509:             .Left      = 293
510:             .Width     = 29
511:             .Height    = 15
512:             .FontName  = "Tahoma"
513:             .FontSize  = 8
514:             .FontBold  = .F.

*-- Linhas 522 a 548:
522:             .Value         = ""
523:             .Alignment     = 3
524:             .Height        = 24
525:             .Left          = 326
526:             .Top           = 164
527:             .Width         = 38
528:             .MaxLength     = 1
529:             .SpecialEffect = 1
530:             .FontName      = "Tahoma"
531:             .FontSize      = 8
532:             .ToolTipText   = "O = Ouro, P = Prata, R = Rel" + CHR(243) + "gio, J = Jolie"
533:             .Visible       = .T.
534:         ENDWITH
535:         BINDEVENT(loc_oPg2.txt_4c_Tipos, "KeyPress", THIS, "ValidarTipos")
536: 
537:         *-------- Say3 + optSituas: Usada em Produtos (Top=163+29=192 / Top=158+29=187) -------
538:         loc_oPg2.AddObject("lbl_4c_Label3", "Label")
539:         WITH loc_oPg2.lbl_4c_Label3
540:             .AutoSize  = .F.
541:             .Caption   = "Usada em Produtos :"
542:             .Top       = 192
543:             .Left      = 220
544:             .Width     = 102
545:             .Height    = 15
546:             .FontName  = "Tahoma"
547:             .FontSize  = 8
548:             .FontBold  = .F.

*-- Linhas 555 a 612:
555:         loc_oOpt = loc_oPg2.obj_4c_OptSituas
556:         WITH loc_oOpt
557:             .ButtonCount = 3
558:             .Top         = 187
559:             .Left        = 320
560:             .Width       = 188
561:             .Height      = 25
562:             .BackStyle   = 0
563:             .BorderStyle = 0
564:             .Value       = 1
565:             .Visible     = .T.
566:             WITH .Buttons(1)
567:                 .Caption   = "Ativos"
568:                 .Left      = 5
569:                 .Top       = 5
570:                 .Width     = 48
571:                 .AutoSize  = .T.
572:                 .FontName  = "Tahoma"
573:                 .FontSize  = 8
574:                 .BackStyle = 0
575:                 .ForeColor = RGB(90, 90, 90)
576:             ENDWITH
577:             WITH .Buttons(2)
578:                 .Caption   = "Inativos"
579:                 .Left      = 63
580:                 .Top       = 5
581:                 .Width     = 57
582:                 .AutoSize  = .T.
583:                 .FontName  = "Tahoma"
584:                 .FontSize  = 8
585:                 .BackStyle = 0
586:                 .ForeColor = RGB(90, 90, 90)
587:             ENDWITH
588:             WITH .Buttons(3)
589:                 .Caption   = "Ambos"
590:                 .Left      = 133
591:                 .Top       = 5
592:                 .Width     = 50
593:                 .AutoSize  = .T.
594:                 .FontName  = "Tahoma"
595:                 .FontSize  = 8
596:                 .BackStyle = 0
597:                 .ForeColor = RGB(90, 90, 90)
598:             ENDWITH
599:         ENDWITH
600: 
601:         *-------- Say4 + txt_4c_GdeGrps: Grande Grupo (Top=199+29=228 / 196+29=225) ------
602:         loc_oPg2.AddObject("lbl_4c_Label4", "Label")
603:         WITH loc_oPg2.lbl_4c_Label4
604:             .AutoSize  = .F.
605:             .Caption   = "Grande Grupo :"
606:             .Top       = 228
607:             .Left      = 614
608:             .Width     = 76
609:             .Height    = 15
610:             .FontName  = "Tahoma"
611:             .FontSize  = 8
612:             .FontBold  = .F.

*-- Linhas 620 a 629:
620:             .Value         = ""
621:             .Alignment     = 3
622:             .Height        = 24
623:             .Left          = 689
624:             .Top           = 225
625:             .Width         = 38
626:             .MaxLength     = 3
627:             .SpecialEffect = 1
628:             .FontName      = "Tahoma"
629:             .FontSize      = 8

*-- Linhas 639 a 648:
639:         loc_oGridGrp.RecordSource = "crGrdCdCom"
640:         loc_oGridGrp.ColumnCount  = 2
641:         WITH loc_oGridGrp
642:             .Top               = 210
643:             .Left              = 326
644:             .Width             = 217
645:             .Height            = 365
646:             .FontSize          = 8
647:             .AllowHeaderSizing = .F.
648:             .AllowRowSizing    = .F.

*-- Linhas 662 a 718:
662:             .Resizable     = .F.
663:             .FontSize      = 8
664:         ENDWITH
665:         loc_oGridGrp.Column1.Header1.Caption   = "Grupo"
666:         loc_oGridGrp.Column1.Header1.Alignment = 2
667:         WITH loc_oGridGrp.Column2
668:             .ControlSource = "crGrdCdCom.DGrus"
669:             .Width         = 150
670:             .Movable       = .F.
671:             .Resizable     = .F.
672:             .ReadOnly      = .F.
673:             .FontSize      = 8
674:         ENDWITH
675:         loc_oGridGrp.Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
676:         loc_oGridGrp.Column2.Header1.Alignment = 2
677:         BINDEVENT(loc_oGridGrp, "AfterRowColChange", THIS, "GridGruposAfterRowColChange")
678: 
679:         *-------- cmd_4c_BtnCarregar: Carregar Grande Grupo (Top=180+29=209, Left=550) --
680:         loc_oPg2.AddObject("cmd_4c_BtnCarregar", "CommandButton")
681:         WITH loc_oPg2.cmd_4c_BtnCarregar
682:             .Caption     = ""
683:             .Picture     = gc_4c_CaminhoIcones + "importar_48.png"
684:             .Top         = 209
685:             .Left        = 550
686:             .Width       = 52
687:             .Height      = 52
688:             .BackColor   = RGB(255, 255, 255)
689:             .FontName    = "Verdana"
690:             .FontSize    = 8
691:             .Themes      = .F.
692:             .ToolTipText = "Carregar Grande Grupo"
693:             .Visible     = .T.
694:         ENDWITH
695:         BINDEVENT(loc_oPg2.cmd_4c_BtnCarregar, "Click", THIS, "BtnCarregarClick")
696: 
697:         *-------- cmd_4c_CmdExcluir: Excluir Grupo (Top=341+29=370, Left=550) ----------
698:         loc_oPg2.AddObject("cmd_4c_CmdExcluir", "CommandButton")
699:         WITH loc_oPg2.cmd_4c_CmdExcluir
700:             .Caption     = ""
701:             .Picture     = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
702:             .Top         = 370
703:             .Left        = 550
704:             .Width       = 52
705:             .Height      = 52
706:             .BackColor   = RGB(255, 255, 255)
707:             .FontName    = "Verdana"
708:             .FontSize    = 8
709:             .Themes      = .F.
710:             .ToolTipText = "Excluir Grupo"
711:             .Visible     = .T.
712:         ENDWITH
713:         BINDEVENT(loc_oPg2.cmd_4c_CmdExcluir, "Click", THIS, "CmdExcluirClick")
714: 
715:         THIS.TornarControlesVisiveis(loc_oPg2)
716:     ENDPROC
717: 
718:     *--------------------------------------------------------------------------

*-- Linhas 744 a 753:
744:                         loc_oGrid.Column1.ReadOnly = .T.
745:                         loc_oGrid.Column2.ReadOnly = .T.
746: 
747:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
748:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
749: 
750:                         THIS.FormatarGridLista(loc_oGrid)
751:                     ENDIF
752:                     loc_lResultado = .T.
753:                 ENDIF

*-- Linhas 862 a 877:
862:         loc_oBotoes = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
863: 
864:         IF VARTYPE(loc_oBotoes) = "O"
865:             IF PEMSTATUS(loc_oBotoes, "cmd_4c_Visualizar", 5)
866:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
867:             ENDIF
868:             IF PEMSTATUS(loc_oBotoes, "cmd_4c_Alterar", 5)
869:                 loc_oBotoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
870:             ENDIF
871:             IF PEMSTATUS(loc_oBotoes, "cmd_4c_Excluir", 5)
872:                 loc_oBotoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
873:             ENDIF
874:         ENDIF
875:     ENDPROC
876: 
877:     *--------------------------------------------------------------------------

*-- Linhas 1168 a 1185:
1168:         IF PEMSTATUS(loc_oPg2, "grd_4c_Dados", 5)
1169:             loc_oPg2.grd_4c_Dados.Enabled     = loc_lHabilitar
1170:         ENDIF
1171:         IF PEMSTATUS(loc_oPg2, "cmd_4c_BtnCarregar", 5)
1172:             loc_oPg2.cmd_4c_BtnCarregar.Enabled = loc_lHabilitar
1173:         ENDIF
1174:         IF PEMSTATUS(loc_oPg2, "cmd_4c_CmdExcluir", 5)
1175:             loc_oPg2.cmd_4c_CmdExcluir.Enabled  = loc_lHabilitar
1176:         ENDIF
1177:         *-- Botao Confirmar
1178:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1179:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1180:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lHabilitar
1181:             ENDIF
1182:         ENDIF
1183:     ENDPROC
1184: 
1185:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\ClaBO.prg):
*------------------------------------------------------------------------------
* ClaBO.prg - Business Object para Classificacao de Produtos
* Tabela principal: SigCdCls
* Tabela detalhe:   SigCdCla (grupos associados)
*------------------------------------------------------------------------------

DEFINE CLASS ClaBO AS BusinessBase

    *-- Propriedades da entidade SigCdCls
    this_cCodigo    = ""   && SigCdCls.Cods     (PK char(3))
    this_cDescricao = ""   && SigCdCls.Descs    (char(40))
    this_cTipo      = ""   && SigCdCls.Tipos    (char(1): O=Ouro, P=Prata, R=Rel+CHR(243)+gio, J=Jolie)
    this_nSitua     = 0    && SigCdCls.Situas   (numeric(1,0): 1=Ativos, 2=Inativos, 3=Ambos)

    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdCls"
        THIS.this_cCampoChave = "Cods"
        RETURN .T.
    ENDPROC

    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigCdCls filtrados opcionalmente
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF VARTYPE(par_cFiltro) != "C"
                par_cFiltro = ""
            ENDIF

            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT Cods, Descs, Tipos, Situas" + ;
                           " FROM SigCdCls" + ;
                           " ORDER BY Cods"
            ELSE
                loc_cSQL = "SELECT Cods, Descs, Tipos, Situas" + ;
                           " FROM SigCdCls" + ;
                           " WHERE Cods LIKE " + EscaparSQL("%" + par_cFiltro + "%") + ;
                           " ORDER BY Cods"
            ENDIF

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado < 0
                MsgErro("Erro ao buscar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.Buscar: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "SELECT Cods, Descs, Tipos, Situas" + ;
                           " FROM SigCdCls" + ;
                           " WHERE Cods = " + EscaparSQL(par_cCodigo)

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                        loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                        THIS.this_lNovoRegistro = .F.
                    ELSE
                        loc_lResultado = .F.
                    ENDIF

                    IF USED("cursor_4c_Carrega")
                        USE IN cursor_4c_Carrega
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = ALLTRIM(NVL(Cods,  ""))
                THIS.this_cDescricao = ALLTRIM(NVL(Descs, ""))
                THIS.this_cTipo      = ALLTRIM(NVL(Tipos, ""))
                THIS.this_nSitua     = NVL(Situas, 0)
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.CarregarDoCursor: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigCdCls (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cCodigo))
                MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o informado!", "Aten" + CHR(231) + CHR(227) + "o")
                loc_lResultado = .F.
            ELSE
                loc_cSQL = "INSERT INTO SigCdCls (Cods, Descs, Tipos, Situas)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cCodigo)    + "," + ;
                           EscaparSQL(THIS.this_cDescricao) + "," + ;
                           EscaparSQL(THIS.this_cTipo)      + "," + ;
                           FormatarNumeroSQL(THIS.this_nSitua) + ;
                           ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.Inserir: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigCdCls (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCls SET" + ;
                       "  Descs  = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       "  Tipos  = " + EscaparSQL(THIS.this_cTipo)      + "," + ;
                       "  Situas = " + FormatarNumeroSQL(THIS.this_nSitua) + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao atualizar classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.Atualizar: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigCdCla e SigCdCls (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            *-- Excluir registros de detalhe (SigCdCla)
            loc_cSQL = "DELETE FROM SigCdCla WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir grupos da classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Excluir registro principal (SigCdCls)
                loc_cSQL = "DELETE FROM SigCdCls WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao excluir classifica" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                            CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega grupos associados (SigCdCla + SigCdGrp) para o grid
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupos(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.CGrus, b.DGrus" + ;
                       " FROM SigCdCla a" + ;
                       " LEFT JOIN SigCdGrp b ON b.CGrus = a.CGrus" + ;
                       " WHERE a.Cods = " + EscaparSQL(par_cCodigo) + ;
                       " ORDER BY a.CGrus"

            IF USED("cursor_4c_Grupos")
                USE IN cursor_4c_Grupos
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Grupos")

            IF loc_nResultado < 0
                MsgErro("Erro ao carregar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                IF USED("cursor_4c_Grupos")
                    GO TOP IN cursor_4c_Grupos
                ENDIF
                loc_lResultado = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.BuscarGrupos: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarGrupos - Salva grupos associados em SigCdCla (DELETE + INSERT)
    *   par_cCodigo       = codigo da classificacao (SigCdCls.Cods)
    *   par_cCursorGrupos = alias do cursor local com CGrus/DGrus
    *--------------------------------------------------------------------------
    FUNCTION SalvarGrupos(par_cCodigo, par_cCursorGrupos)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado, loc_cCGrus, loc_cCidchaves
        loc_lResultado = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cCodigo))
                loc_lResultado = .F.
            ELSE
                *-- Remover grupos antigos
                loc_cSQL = "DELETE FROM SigCdCla WHERE Cods = " + EscaparSQL(par_cCodigo)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao limpar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lResultado = .F.
                ELSE
                    loc_lResultado = .T.

                    *-- Inserir grupos do cursor (apenas CGrus nao vazio e distintos)
                    IF USED(par_cCursorGrupos) AND RECCOUNT(par_cCursorGrupos) > 0
                        SELECT DISTINCT CGrus FROM (par_cCursorGrupos) ;
                            WHERE !EMPTY(CGrus) ;
                            ORDER BY CGrus ;
                            INTO CURSOR cursor_4c_GruposGrav

                        IF USED("cursor_4c_GruposGrav") AND RECCOUNT("cursor_4c_GruposGrav") > 0
                            GO TOP IN cursor_4c_GruposGrav
                            SELECT cursor_4c_GruposGrav
                            SCAN
                                loc_cCGrus      = ALLTRIM(cursor_4c_GruposGrav.CGrus)
                                loc_cCidchaves  = LEFT(fUniqueIds(), 20)

                                loc_cSQL = "INSERT INTO SigCdCla (CGrus, CIdChaves, Cods)" + ;
                                           " VALUES (" + ;
                                           EscaparSQL(loc_cCGrus)     + "," + ;
                                           EscaparSQL(loc_cCidchaves) + "," + ;
                                           EscaparSQL(par_cCodigo)    + ;
                                           ")"

                                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                                IF loc_nResultado < 0
                                    MsgErro("Erro ao inserir grupo " + loc_cCGrus + ":" + CHR(13) + ;
                                            CapturarErroSQL(), "Erro SQL")
                                    loc_lResultado = .F.
                                    EXIT
                                ENDIF
                            ENDSCAN
                        ENDIF

                        IF USED("cursor_4c_GruposGrav")
                            USE IN cursor_4c_GruposGrav
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em ClaBO.SalvarGrupos: " + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

