# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [LAYOUT-POSITION] Controle 'DataIni' (parent: SIGRECPR): Top original=167 vs migrado 'txt_4c_DataIni' Top=87 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'DataFin' (parent: SIGRECPR): Top original=167 vs migrado 'txt_4c_DataFin' Top=87 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say1' (parent: SIGRECPR): Top original=170 vs migrado 'lbl_4c_Say1' Top=90 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say2' (parent: SIGRECPR): Top original=171 vs migrado 'lbl_4c_Say2' Top=91 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opcao' (parent: SIGRECPR): Top original=120 vs migrado 'opt_4c_Opcao' Top=5 (diff=115px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opcao' (parent: SIGRECPR): Left original=288 vs migrado 'opt_4c_Opcao' Left=5 (diff=283px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Say3' (parent: SIGRECPR): Top original=145 vs migrado 'lbl_4c_Say3' Top=65 (diff=80px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptFiltro' (parent: SIGRECPR): Top original=140 vs migrado 'opt_4c_OptFiltro' Top=5 (diff=135px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'OptFiltro' (parent: SIGRECPR): Left original=288 vs migrado 'opt_4c_OptFiltro' Left=5 (diff=283px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrecpr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (886 linhas total):

*-- Linhas 64 a 72:
64:         LOCAL loc_lSucesso
65:         loc_lSucesso = .F.
66:         TRY
67:             THIS.Caption = "Cheques Prorrogados"
68: 
69:             IF TYPE("gc_4c_CaminhoIcones") = "U"
70:                 gc_4c_CaminhoIcones = ""
71:             ENDIF
72:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 84 a 93:
84:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
85:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
86: 
87:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
88:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
89: 
90:                 THIS.Visible  = .T.
91:                 loc_lSucesso  = .T.
92:             ENDIF
93:         CATCH TO loc_oErro

*-- Linhas 134 a 143:
134:     PROTECTED PROCEDURE ConfigurarContainerFiltros()
135:         THIS.AddObject("cnt_4c_Filtros", "Container")
136:         WITH THIS.cnt_4c_Filtros
137:             .Top         = 80
138:             .Left        = 0
139:             .Width       = THIS.Width
140:             .Height      = THIS.Height - 80
141:             .BackStyle   = 0
142:             .BorderWidth = 0
143:             .Visible     = .T.

*-- Linhas 151 a 226:
151:     PROTECTED PROCEDURE ConfigurarCabecalho()
152:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
153:         WITH THIS.cnt_4c_Cabecalho
154:             .Top         = 0
155:             .Left        = 0
156:             .Width       = THIS.Width
157:             .Height      = 80
158:             .BackStyle   = 1
159:             .BackColor   = RGB(100, 100, 100)
160:             .BorderWidth = 0
161:             .Visible     = .T.
162: 
163:             *-- Sombra deslocada 2px para efeito 3D
164:             .AddObject("lbl_4c_Sombra", "Label")
165:             WITH .lbl_4c_Sombra
166:                 .Top       = 22
167:                 .Left      = 22
168:                 .Width     = THIS.Width
169:                 .Height    = 30
170:                 .Caption   = "Cheques Prorrogados"
171:                 .FontName  = "Tahoma"
172:                 .FontSize  = 14
173:                 .FontBold  = .T.
174:                 .ForeColor = RGB(0, 0, 0)
175:                 .BackStyle = 0
176:                 .Visible   = .T.
177:             ENDWITH
178: 
179:             *-- Titulo em branco sobre a sombra
180:             .AddObject("lbl_4c_Titulo", "Label")
181:             WITH .lbl_4c_Titulo
182:                 .Top       = 20
183:                 .Left      = 20
184:                 .Width     = THIS.Width
185:                 .Height    = 30
186:                 .Caption   = "Cheques Prorrogados"
187:                 .FontName  = "Tahoma"
188:                 .FontSize  = 14
189:                 .FontBold  = .T.
190:                 .ForeColor = RGB(255, 255, 255)
191:                 .BackStyle = 0
192:                 .Visible   = .T.
193:             ENDWITH
194:         ENDWITH
195:     ENDPROC
196: 
197:     *--------------------------------------------------------------------------
198:     * ConfigurarBotoes - CommandGroup canonico do btnReport (4 botoes)
199:     * Original: btnReport.Left=528, Top=3, Width=305, Height=85 (800px form)
200:     * Canonico: cmg_4c_Botoes Top=0, Left=529, Width=273, Height=80
201:     * Lefts internos: Buttons(1)=5, (2)=71, (3)=137, (4)=203 (incrementos de 66)
202:     *--------------------------------------------------------------------------
203:     PROTECTED PROCEDURE ConfigurarBotoes()
204:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
205:         WITH THIS.cmg_4c_Botoes
206:             .Top           = 0
207:             .Left          = 529
208:             .Width         = 273
209:             .Height        = 80
210:             .ButtonCount   = 4
211:             .BackStyle     = 0
212:             .BorderStyle   = 0
213:             .BorderColor   = RGB(136, 189, 188)
214:             .SpecialEffect = 1
215:             .Themes        = .F.
216:             .Visible       = .T.
217: 
218:             WITH .Buttons(1)
219:                 .Caption         = "Visualizar"
220:                 .Top             = 5
221:                 .Left            = 5
222:                 .Width           = 65
223:                 .Height          = 70
224:                 .FontBold        = .T.
225:                 .FontItalic      = .T.
226:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 235 a 245:
235:             ENDWITH
236: 
237:             WITH .Buttons(2)
238:                 .Caption         = "Imprimir"
239:                 .Top             = 5
240:                 .Left            = 71
241:                 .Width           = 65
242:                 .Height          = 70
243:                 .FontName        = "Tahoma"
244:                 .FontBold        = .T.
245:                 .FontItalic      = .T.

*-- Linhas 256 a 266:
256:             ENDWITH
257: 
258:             WITH .Buttons(3)
259:                 .Caption         = "DocExcel"
260:                 .Top             = 5
261:                 .Left            = 137
262:                 .Width           = 65
263:                 .Height          = 70
264:                 .FontName        = "Tahoma"
265:                 .FontBold        = .T.
266:                 .FontItalic      = .T.

*-- Linhas 277 a 287:
277:             ENDWITH
278: 
279:             WITH .Buttons(4)
280:                 .Caption         = "Encerrar"
281:                 .Top             = 5
282:                 .Left            = 203
283:                 .Width           = 65
284:                 .Height          = 70
285:                 .FontName        = "Tahoma"
286:                 .FontBold        = .T.
287:                 .FontItalic      = .T.

*-- Linhas 306 a 360:
306:     * Em REPORT forms nao ha alternancia Lista/Dados (layout FLAT, sem
307:     * PageFrame). Este metodo, mantido por uniformidade arquitetural com forms
308:     * CRUD, repassa a navegacao para acoes equivalentes ao contexto de
309:     * relatorio:
310:     *   par_nPagina = 1 (Lista)  -> reposiciona o foco no primeiro filtro
311:     *                               (txt_4c_DataIni), simulando "voltar para a
312:     *                               tela de parametros" apos gerar o relatorio.
313:     *   par_nPagina = 2 (Dados)  -> reseta os filtros para os defaults do Init
314:     *                               (LimparCampos), simulando "novo relatorio".
315:     *   outros valores            -> tratado como 1 (Lista) por seguranca.
316:     *
317:     * Tambem sincroniza a visibilidade de opt_4c_Bons conforme o ComboBox de
318:     * tipo (replicando o Valid event de GetTipoRel do legado) para garantir
319:     * estado consistente da UI quando o form e reapresentado.
320:     *--------------------------------------------------------------------------
321:     PROCEDURE AlternarPagina(par_nPagina)
322:         LOCAL loc_nPagina, loc_oCnt
323:         loc_nPagina = IIF(VARTYPE(par_nPagina) = "N", par_nPagina, 1)
324: 
325:         IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
326:             RETURN
327:         ENDIF
328:         loc_oCnt = THIS.cnt_4c_Filtros
329: 
330:         DO CASE
331:             CASE loc_nPagina = 2
332:                 *-- "Dados" = novo relatorio: reseta para os defaults do Init
333:                 THIS.LimparCampos()
334:                 IF VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
335:                     loc_oCnt.txt_4c_DataIni.SetFocus()
336:                 ENDIF
337:             OTHERWISE
338:                 *-- "Lista" (1) ou qualquer outro: foca no primeiro filtro e
339:                 *-- ressincroniza visibilidade de opt_4c_Bons com o ComboBox.
340:                 IF VARTYPE(loc_oCnt.cbo_4c_TipoRel) = "O" ;
341:                    AND VARTYPE(loc_oCnt.opt_4c_Bons) = "O"
342:                     loc_oCnt.opt_4c_Bons.Visible = (loc_oCnt.cbo_4c_TipoRel.ListIndex = 4)
343:                 ENDIF
344:                 IF VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
345:                     loc_oCnt.txt_4c_DataIni.SetFocus()
346:                 ENDIF
347:         ENDCASE
348:     ENDPROC
349: 
350:     *--------------------------------------------------------------------------
351:     * BtnVisualizarClick - Exibe relatorio em preview na tela
352:     * Equivalente ao PROCEDURE visualizacao do legado
353:     *--------------------------------------------------------------------------
354:     PROCEDURE BtnVisualizarClick()
355:         THIS.FormParaRelatorio()
356:         IF !THIS.this_oRelatorio.Visualizar()
357:             MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Visualizar")
358:         ENDIF
359:     ENDPROC
360: 

*-- Linhas 411 a 479:
411:     *--------------------------------------------------------------------------
412:     PROCEDURE BtnIncluirClick()
413:         LOCAL loc_oCnt
414:         THIS.LimparCampos()
415:         loc_oCnt = THIS.cnt_4c_Filtros
416:         IF VARTYPE(loc_oCnt) = "O" AND VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
417:             loc_oCnt.txt_4c_DataIni.SetFocus()
418:         ENDIF
419:     ENDPROC
420: 
421:     *--------------------------------------------------------------------------
422:     * BtnAlterarClick - Em REPORT forms, "Alterar" equivale a "Alterar
423:     * Filtros": preserva os valores atuais dos filtros (NAO chama LimparCampos)
424:     * e devolve o foco ao primeiro filtro de data, permitindo refinar a
425:     * consulta antes de re-Visualizar/Imprimir. Tambem ressincroniza a
426:     * visibilidade de opt_4c_Bons com o ComboBox de tipo, replicando o Valid
427:     * event de GetTipoRel do legado para garantir UI consistente.
428:     *--------------------------------------------------------------------------
429:     PROCEDURE BtnAlterarClick()
430:         LOCAL loc_oCnt
431:         loc_oCnt = THIS.cnt_4c_Filtros
432:         IF VARTYPE(loc_oCnt) != "O"
433:             RETURN
434:         ENDIF
435:         IF VARTYPE(loc_oCnt.cbo_4c_TipoRel) = "O" ;
436:            AND VARTYPE(loc_oCnt.opt_4c_Bons) = "O"
437:             loc_oCnt.opt_4c_Bons.Visible = (loc_oCnt.cbo_4c_TipoRel.ListIndex = 4)
438:         ENDIF
439:         IF VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
440:             loc_oCnt.txt_4c_DataIni.SetFocus()
441:         ENDIF
442:     ENDPROC
443: 
444:     *--------------------------------------------------------------------------
445:     * BtnExcluirClick - Em REPORT forms, "Excluir" mapeia para "Limpar
446:     * Filtros" / "Descartar parametros": zera datas e reseta os OptionGroups
447:     * para os defaults, mas preserva visibilidade derivada do ComboBox de
448:     * tipo. Util quando o usuario quer abandonar uma combinacao de filtros e
449:     * recomecar do zero sem fechar o form. Pede confirmacao para evitar perda
450:     * acidental de filtros ja preenchidos.
451:     *--------------------------------------------------------------------------
452:     PROCEDURE BtnExcluirClick()
453:         LOCAL loc_oCnt, loc_cMsg
454:         loc_oCnt = THIS.cnt_4c_Filtros
455:         IF VARTYPE(loc_oCnt) != "O"
456:             RETURN
457:         ENDIF
458:         loc_cMsg = "Deseja limpar os filtros e recome" + CHR(231) + "ar?"
459:         IF !MsgConfirma(loc_cMsg, "Limpar Filtros")
460:             RETURN
461:         ENDIF
462:         THIS.LimparCampos()
463:         IF VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
464:             loc_oCnt.txt_4c_DataIni.SetFocus()
465:         ENDIF
466:     ENDPROC
467: 
468:     *--------------------------------------------------------------------------
469:     * Destroy - Libera BO e delega para FormBase
470:     * REGRA: this_oRelatorio = .NULL. (NAO .Release() - Custom nao tem Release)
471:     *--------------------------------------------------------------------------
472:     PROCEDURE Destroy()
473:         IF VARTYPE(THIS.this_oRelatorio) = "O"
474:             THIS.this_oRelatorio = .NULL.
475:         ENDIF
476:         DODEFAULT()
477:     ENDPROC
478: 
479:     *--------------------------------------------------------------------------

*-- Linhas 485 a 576:
485:         loc_oCnt = THIS.cnt_4c_Filtros
486: 
487:         *-- Say3: "Filtrar por :"  (Top original=145, container=65)
488:         loc_oCnt.AddObject("lbl_4c_Say3", "Label")
489:         WITH loc_oCnt.lbl_4c_Say3
490:             .Top       = 65
491:             .Left      = 227
492:             .Height    = 15
493:             .Width     = 70
494:             .Caption   = "Filtrar por : "
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .BackStyle = 0
498:             .ForeColor = RGB(90, 90, 90)
499:             .Visible   = .T.
500:         ENDWITH
501: 
502:         *-- OptFiltro: Prorrogados / Vencimento  (Top original=140, container=60)
503:         loc_oCnt.AddObject("opt_4c_OptFiltro", "OptionGroup")
504:         WITH loc_oCnt.opt_4c_OptFiltro
505:             .Top         = 60
506:             .Left        = 288
507:             .Width       = 194
508:             .Height      = 25
509:             .ButtonCount = 2
510:             .BackStyle   = 0
511:             .BorderStyle = 0
512:             .Value       = 1
513:             WITH .Buttons(1)
514:                 .Caption   = "Prorrogados"
515:                 .BackStyle = 0
516:                 .Height    = 15
517:                 .Left      = 5
518:                 .Top       = 5
519:                 .Width     = 77
520:                 .ForeColor = RGB(90, 90, 90)
521:                 .Visible   = .T.
522:             ENDWITH
523:             WITH .Buttons(2)
524:                 .Caption   = "Vencimento"
525:                 .FontName  = "Tahoma"
526:                 .FontSize  = 8
527:                 .BackStyle = 0
528:                 .Height    = 15
529:                 .Left      = 116
530:                 .Top       = 5
531:                 .Width     = 73
532:                 .ForeColor = RGB(90, 90, 90)
533:                 .Visible   = .T.
534:             ENDWITH
535:             .Visible = .T.
536:         ENDWITH
537: 
538:         *-- Say1: "Per?odo :"  (Top original=170, container=90)
539:         loc_oCnt.AddObject("lbl_4c_Say1", "Label")
540:         WITH loc_oCnt.lbl_4c_Say1
541:             .Top       = 90
542:             .Left      = 238
543:             .Height    = 15
544:             .Width     = 50
545:             .Caption   = "Per" + CHR(237) + "odo : "
546:             .FontName  = "Tahoma"
547:             .FontSize  = 8
548:             .BackStyle = 0
549:             .ForeColor = RGB(90, 90, 90)
550:             .Visible   = .T.
551:         ENDWITH
552: 
553:         *-- DataIni  (Top original=167, container=87)
554:         loc_oCnt.AddObject("txt_4c_DataIni", "TextBox")
555:         WITH loc_oCnt.txt_4c_DataIni
556:             .Top     = 87
557:             .Left    = 292
558:             .Height  = 20
559:             .Width   = 80
560:             .Value   = {}
561:             .Visible = .T.
562:         ENDWITH
563: 
564:         *-- Say2: "a" grave separador de datas  (Top original=171, container=91)
565:         loc_oCnt.AddObject("lbl_4c_Say2", "Label")
566:         WITH loc_oCnt.lbl_4c_Say2
567:             .Top       = 91
568:             .Left      = 376
569:             .Height    = 15
570:             .Width     = 10
571:             .Caption   = CHR(224)
572:             .FontName  = "Verdana"
573:             .FontSize  = 8
574:             .BackStyle = 0
575:             .ForeColor = RGB(36, 84, 155)
576:             .Visible   = .T.

*-- Linhas 583 a 658:
583:     * Equivalente ao Init() do legado: DataIni/DataFin vazios, OptFiltro=1,
584:     * GetTipoRel=1 (ATIVOS), Opt_Bons oculto e resetado
585:     *--------------------------------------------------------------------------
586:     PROCEDURE LimparCampos()
587:         WITH THIS.cnt_4c_Filtros
588:             .txt_4c_DataIni.Value    = {}
589:             .txt_4c_DataFin.Value    = {}
590:             .opt_4c_OptFiltro.Value  = 1
591:             .cbo_4c_TipoRel.ListIndex = 1
592:             .opt_4c_Bons.Visible     = .F.
593:             .opt_4c_Bons.Value       = 1
594:             .opt_4c_Opcao.Value      = 1
595:         ENDWITH
596:     ENDPROC
597: 
598:     *--------------------------------------------------------------------------
599:     * FormParaRelatorio - Transfere valores dos filtros do form para o BO
600:     * Chamado antes de Visualizar(), Imprimir() ou PrepararDados()
601:     *--------------------------------------------------------------------------
602:     PROTECTED PROCEDURE FormParaRelatorio()
603:         WITH THIS.this_oRelatorio
604:             .this_dDataIni    = THIS.cnt_4c_Filtros.txt_4c_DataIni.Value
605:             .this_dDataFin    = THIS.cnt_4c_Filtros.txt_4c_DataFin.Value
606:             .this_nTipoFiltro = THIS.cnt_4c_Filtros.opt_4c_OptFiltro.Value
607:             .this_nTipoRel    = THIS.cnt_4c_Filtros.cbo_4c_TipoRel.ListIndex
608:             .this_nBons       = THIS.cnt_4c_Filtros.opt_4c_Bons.Value
609:             .this_nOpcao      = THIS.cnt_4c_Filtros.opt_4c_Opcao.Value
610:         ENDWITH
611:     ENDPROC
612: 
613:     *--------------------------------------------------------------------------
614:     * ConfigurarPaginaDados - Segunda metade dos controles de filtro
615:     * DataFin, lbl_Operacao, cbo_TipoRel, opt_Bons, opt_Opcao + BINDEVENT
616:     * Equivale a "Page2" no pipeline multi-fase; para REPORT ? bloco de
617:     * parametros de operacao (tipo de cheque e opcoes de baixa).
618:     *--------------------------------------------------------------------------
619:     PROTECTED PROCEDURE ConfigurarPaginaDados()
620:         LOCAL loc_oCnt
621:         loc_oCnt = THIS.cnt_4c_Filtros
622: 
623:         *-- DataFin  (Top original=167, container=87)
624:         loc_oCnt.AddObject("txt_4c_DataFin", "TextBox")
625:         WITH loc_oCnt.txt_4c_DataFin
626:             .Top     = 87
627:             .Left    = 389
628:             .Height  = 20
629:             .Width   = 80
630:             .Value   = {}
631:             .Visible = .T.
632:         ENDWITH
633: 
634:         *-- lbl_operacao: "Opera" + CHR(231)+CHR(227)+"o :"  (Top orig=199, cont=119)
635:         loc_oCnt.AddObject("lbl_4c_Operacao", "Label")
636:         WITH loc_oCnt.lbl_4c_Operacao
637:             .Top       = 119
638:             .Left      = 230
639:             .Height    = 15
640:             .Width     = 60
641:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
642:             .FontName  = "Tahoma"
643:             .FontSize  = 8
644:             .BackStyle = 0
645:             .ForeColor = RGB(90, 90, 90)
646:             .Visible   = .T.
647:         ENDWITH
648: 
649:         *-- cbo_4c_TipoRel: ComboBox de tipo  (Top original=194, container=114)
650:         loc_oCnt.AddObject("cbo_4c_TipoRel", "ComboBox")
651:         WITH loc_oCnt.cbo_4c_TipoRel
652:             .Top                  = 114
653:             .Left                 = 292
654:             .Height               = 24
655:             .Width                = 134
656:             .RowSourceType        = 1
657:             .RowSource            = "ATIVOS,BAIXADOS,NEG.PG,BONS,DEVOLVIDOS"
658:             .Style                = 2

*-- Linhas 677 a 743:
677:         *-- opt_4c_Bons: Ativos/Todos  (Top orig=194, cont=114 - oculto ate TipoRel=BONS)
678:         loc_oCnt.AddObject("opt_4c_Bons", "OptionGroup")
679:         WITH loc_oCnt.opt_4c_Bons
680:             .Top         = 114
681:             .Left        = 433
682:             .Width       = 116
683:             .Height      = 25
684:             .ButtonCount = 2
685:             .BackStyle   = 0
686:             .BorderStyle = 0
687:             .Value       = 1
688:             WITH .Buttons(1)
689:                 .Caption   = "Ativos"
690:                 .BackStyle = 0
691:                 .Height    = 15
692:                 .Left      = 5
693:                 .Top       = 5
694:                 .Width     = 48
695:                 .ForeColor = RGB(90, 90, 90)
696:                 .Visible   = .T.
697:             ENDWITH
698:             WITH .Buttons(2)
699:                 .Caption   = "Todos"
700:                 .FontName  = "Tahoma"
701:                 .FontSize  = 8
702:                 .BackStyle = 0
703:                 .Height    = 15
704:                 .Left      = 64
705:                 .Top       = 5
706:                 .Width     = 47
707:                 .ForeColor = RGB(90, 90, 90)
708:                 .Visible   = .T.
709:             ENDWITH
710:             .Visible = .F.
711:         ENDWITH
712: 
713:         *-- opt_4c_Opcao: Em aberto/Geral  (Top orig=120, cont=40 - permanece oculto)
714:         loc_oCnt.AddObject("opt_4c_Opcao", "OptionGroup")
715:         WITH loc_oCnt.opt_4c_Opcao
716:             .Top         = 40
717:             .Left        = 288
718:             .Width       = 145
719:             .Height      = 27
720:             .ButtonCount = 2
721:             .BackStyle   = 0
722:             .BorderStyle = 0
723:             .Value       = 1
724:             WITH .Buttons(1)
725:                 .Caption   = "Pendentes"
726:                 .BackStyle = 0
727:                 .Left      = 5
728:                 .Top       = 5
729:                 .ForeColor = RGB(90, 90, 90)
730:                 .Visible   = .T.
731:             ENDWITH
732:             WITH .Buttons(2)
733:                 .Caption   = "Geral"
734:                 .FontName  = "Tahoma"
735:                 .FontSize  = 8
736:                 .BackStyle = 0
737:                 .Left      = 87
738:                 .Top       = 5
739:                 .ForeColor = RGB(90, 90, 90)
740:                 .Visible   = .T.
741:             ENDWITH
742:             .Visible = .F.
743:         ENDWITH

*-- Linhas 771 a 833:
771:     PROTECTED PROCEDURE BOParaForm()
772:         IF VARTYPE(THIS.this_oRelatorio) != "O"
773:             RETURN
774:         ENDIF
775:         WITH THIS.cnt_4c_Filtros
776:             .txt_4c_DataIni.Value     = THIS.this_oRelatorio.this_dDataIni
777:             .txt_4c_DataFin.Value     = THIS.this_oRelatorio.this_dDataFin
778:             .opt_4c_OptFiltro.Value   = THIS.this_oRelatorio.this_nTipoFiltro
779:             .cbo_4c_TipoRel.ListIndex = THIS.this_oRelatorio.this_nTipoRel
780:             .opt_4c_Bons.Value        = THIS.this_oRelatorio.this_nBons
781:             .opt_4c_Opcao.Value       = THIS.this_oRelatorio.this_nOpcao
782:             .opt_4c_Bons.Visible      = (THIS.this_oRelatorio.this_nTipoRel = 4)
783:             .Visible     = .T.
784:         ENDWITH
785:     ENDPROC
786: 
787:     *--------------------------------------------------------------------------
788:     * HabilitarCampos - Em forms REPORT todos os filtros estao sempre habilitados
789:     * Stub semantico: nao ha modo CRUD (INCLUIR/ALTERAR/VISUALIZAR) neste form.
790:     * Mantido para uniformidade arquitetural com o pipeline de migracao.
791:     *--------------------------------------------------------------------------
792:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
793:         LOCAL loc_lHab
794:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
795:         IF VARTYPE(THIS.cnt_4c_Filtros) != "O"
796:             RETURN
797:         ENDIF
798:         WITH THIS.cnt_4c_Filtros
799:             .txt_4c_DataIni.Enabled     = loc_lHab
800:             .txt_4c_DataFin.Enabled     = loc_lHab
801:             .opt_4c_OptFiltro.Enabled   = loc_lHab
802:             .cbo_4c_TipoRel.Enabled     = loc_lHab
803:             .opt_4c_Bons.Enabled        = loc_lHab
804:             .opt_4c_Opcao.Enabled       = loc_lHab
805:             .Visible     = .T.
806:         ENDWITH
807:     ENDPROC
808: 
809:     *--------------------------------------------------------------------------
810:     * CarregarLista - Em forms REPORT nao existe grid de lista; reaplica filtros
811:     * padrao e restaura o foco no primeiro campo de data.
812:     * Mantido para uniformidade arquitetural com o pipeline de migracao.
813:     *--------------------------------------------------------------------------
814:     PROCEDURE CarregarLista()
815:         THIS.LimparCampos()
816:         IF VARTYPE(THIS.cnt_4c_Filtros) = "O" ;
817:            AND VARTYPE(THIS.cnt_4c_Filtros.txt_4c_DataIni) = "O"
818:             THIS.cnt_4c_Filtros.txt_4c_DataIni.SetFocus()
819:         ENDIF
820:         RETURN .T.
821:     ENDPROC
822: 
823:     *--------------------------------------------------------------------------
824:     * AjustarBotoesPorModo - Em forms REPORT nao ha modos CRUD; os 4 botoes do
825:     * CommandGroup permanecem sempre habilitados (Visualizar/Imprimir/DocExcel/
826:     * Encerrar) sempre ativos, sem depender de qualquer estado.
827:     * Mantido para uniformidade arquitetural com o pipeline de migracao.
828:     *--------------------------------------------------------------------------
829:     PROCEDURE AjustarBotoesPorModo()
830:         IF VARTYPE(THIS.cmg_4c_Botoes) != "O"
831:             RETURN
832:         ENDIF
833:         THIS.cmg_4c_Botoes.Buttons(1).Enabled = .T.

*-- Linhas 876 a 886:
876:     *--------------------------------------------------------------------------
877:     PROCEDURE BtnCancelarClick()
878:         LOCAL loc_oCnt
879:         THIS.LimparCampos()
880:         loc_oCnt = THIS.cnt_4c_Filtros
881:         IF VARTYPE(loc_oCnt) = "O" AND VARTYPE(loc_oCnt.txt_4c_DataIni) = "O"
882:             loc_oCnt.txt_4c_DataIni.SetFocus()
883:         ENDIF
884:     ENDPROC
885: 
886: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigrecprBO.prg):
*==============================================================================
* SIGRECPRBO.PRG
* Business Object para Relatorio de Cheques Prorrogados
* Herda de RelatorioBase
*
* Filtros do formulario original (SIGRECPR):
*   DataIni / DataFin     -> this_dDataIni / this_dDataFin
*   OptFiltro (1/2)       -> this_nTipoFiltro (1=Prorrogados, 2=Vencimento)
*   GetTipoRel (ListIndex)-> this_nTipoRel (1=Ativos..5=Devolvidos)
*   Opt_Bons (1/2)        -> this_nBons (1=Ativos, 2=Todos)
*   Opcao (hidden, 1/2)   -> this_nOpcao (1=Em aberto, 2=Geral)
*==============================================================================

DEFINE CLASS sigrecprBO AS RelatorioBase

    *-- Filtros do relatorio
    this_dDataIni       = {}
    this_dDataFin       = {}
    this_nTipoFiltro    = 1
    this_nTipoRel       = 1
    this_nBons          = 1
    this_nOpcao         = 1

    *-- Titulo calculado com os filtros selecionados
    this_cTitulo        = ""

    *-- Caminho do FRX
    this_cArquivoRelatorio = ""

    *-- Cursor principal do relatorio
    this_cCursorDados   = "CsRelatorio"

    *--------------------------------------------------------------------------
    * Init - Inicializa BO do relatorio de Cheques Prorrogados
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cTabela          = ""
            THIS.this_cCampoChave      = ""
            THIS.this_cArquivoRelatorio = gc_4c_CaminhoReports + "SigReCpr.frx"
            THIS.this_dDataIni         = DATE()
            THIS.this_dDataFin         = DATE()
            THIS.this_nTipoFiltro      = 1
            THIS.this_nTipoRel         = 1
            THIS.this_nBons            = 1
            THIS.this_nOpcao           = 1
            THIS.this_cTitulo          = "Cheques Prorrogados"
            loc_lSucesso               = DODEFAULT()
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro
    *--------------------------------------------------------------------------
    FUNCTION ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararDados - Monta SQL com filtros e popula CsRelatorio para impressao
    * Chamado por Imprimir() e Visualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_cSQL, loc_cVerTipo, loc_cCampoDt
        LOCAL loc_cDataIni, loc_cDataFin, loc_nResult

        loc_lSucesso = .F.
        TRY
            *-- Validar periodo
            IF EMPTY(THIS.this_dDataIni) OR EMPTY(THIS.this_dDataFin)
                THIS.this_cMensagemErro = "Per" + CHR(237) + "odo n" + ;
                    CHR(227) + "o informado"
                loc_lSucesso = .F.
            ENDIF
            IF THIS.this_dDataIni > THIS.this_dDataFin
                THIS.this_cMensagemErro = "Data inicial maior que data final"
                loc_lSucesso = .F.
            ENDIF

            *-- Formatar datas para SQL
            loc_cDataIni = FormatarDataSQL(THIS.this_dDataIni)
            loc_cDataFin = "'" + ;
                PADL(YEAR(THIS.this_dDataFin),  4, "0") + "-" + ;
                PADL(MONTH(THIS.this_dDataFin), 2, "0") + "-" + ;
                PADL(DAY(THIS.this_dDataFin),   2, "0") + " 23:59:59'"

            *-- Campo de data do filtro (Prorrogados=e.vencs, Vencimento=a.vencs)
            loc_cCampoDt = IIF(THIS.this_nTipoFiltro = 1, "e.vencs", "a.vencs")

            *-- Montar clausula adicional de filtro por tipo de relatorio
            DO CASE
                CASE THIS.this_nTipoRel = 2  && Baixados
                    loc_cVerTipo = " AND a.umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE tipos='CR' AND devolvidos='N' " + ;
                        "AND opants NOT IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE tipos='DB' AND devolvidos='S'))"

                CASE THIS.this_nTipoRel = 3  && NEG.PG (Devolvidos)
                    loc_cVerTipo = " AND a.umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE tipos='DB' AND devolvidos='S')"

                CASE THIS.this_nTipoRel = 4  && Bons
                    IF THIS.this_nBons = 1  && Ativos
                        loc_cVerTipo = " AND a.umovs IN (" + ;
                            "SELECT operacaos FROM SigCdOpt " + ;
                            "WHERE devolvidos<>'S' AND tipos='DB' AND Ordens=1)"
                    ELSE  && Todos
                        loc_cVerTipo = " AND a.umovs IN (" + ;
                            "SELECT operacaos FROM SigCdOpt " + ;
                            "WHERE devolvidos<>'S')"
                    ENDIF
                    loc_cVerTipo = loc_cVerTipo + ;
                        " AND a.contat NOT IN (" + ;
                        "SELECT DISTINCT contat FROM sigche " + ;
                        "WHERE umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE devolvidos='S'))"

                CASE THIS.this_nTipoRel = 5  && Devolvidos
                    loc_cVerTipo = " AND a.umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE devolvidos='S')"

                OTHERWISE  && Ativos (lnTipoRel=1 ou vazio)
                    loc_cVerTipo = " AND a.umovs IN (" + ;
                        "SELECT operacaos FROM SigCdOpt " + ;
                        "WHERE tipos='DB' AND devolvidos='N')"
            ENDCASE

            *-- Calcular titulo com filtros aplicados
            THIS.this_cTitulo = "Filtros: " + ;
                IIF(THIS.this_nTipoFiltro = 1, "Prorrogados", "Vencimento") + ;
                " - " + ;
                IIF(THIS.this_nTipoRel = 1 OR THIS.this_nTipoRel = 0, "Ativos", ;
                IIF(THIS.this_nTipoRel = 2, "Baixados", ;
                IIF(THIS.this_nTipoRel = 3, "NEG.PG", ;
                IIF(THIS.this_nTipoRel = 4, ;
                    "Bons - " + IIF(THIS.this_nBons = 1, "Ativos", "Todos"), ;
                    "Devolvidos"))))

            *-- Fechar cursor anterior se existir
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF

            *-- Montar SQL principal (todas as tabelas em SQL Server)
            loc_cSQL = "SELECT e.iclis, e.vencs AS ultvenc, e.umovs, " + ;
                       "e.agencias, e.bancos, e.ncontas, e.ncheques, " + ;
                       "c.rclis, c.grupos, e.valors, a.*, " + ;
                       TRANSFORM(THIS.this_nOpcao) + " AS opcao, " + ;
                       "m.razas AS empresa, " + ;
                       "CAST(" + loc_cDataIni + " AS datetime) AS dataini, " + ;
                       "CAST(" + loc_cDataFin + " AS datetime) AS datafin, " + ;
                       "e.contat, e.grupot, t.rclis AS dContat "
            loc_cSQL = loc_cSQL + ;
                       "FROM SigChe e, SigCdOpt r, SigCdCli c, " + ;
                       "SigChea a, SigCdEmp m, SigCdCli t "
            loc_cSQL = loc_cSQL + ;
                       "WHERE " + loc_cCampoDt + ;
                       " BETWEEN " + loc_cDataIni + " AND " + loc_cDataFin + ;
                       " AND e.umovs = r.operacaos" + ;
                       " AND e.iclis = c.iclis" + ;
                       " AND e.nums = a.nums" + ;
                       " AND e.contat = t.iclis" + ;
                       " AND m.cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_cSQL = loc_cSQL + loc_cVerTipo + ;
                       " ORDER BY c.rclis, e.agencias, e.bancos, e.ncontas, e.ncheques"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, THIS.this_cCursorDados)
            IF loc_nResult < 0
                THIS.this_cMensagemErro = "Erro ao buscar dados de cheques prorrogados"
                loc_lSucesso = .F.
            ENDIF

            SELECT (THIS.this_cCursorDados)
            GO TOP
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.PrepararDados")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MontarCabecalho - Cria CsCabecalho para uso no relatorio
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE MontarCabecalho()
        LOCAL loc_lSucesso, loc_nResult, loc_cSqlEmp, loc_cNomeEmpresa, loc_cPeriodo
        loc_lSucesso = .F.
        TRY
            loc_cNomeEmpresa = ""
            loc_cSqlEmp = "SELECT TOP 1 Razas FROM SigCdEmp WHERE cemps = " + ;
                          EscaparSQL(go_4c_Sistema.cCodEmpresa)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSqlEmp, "cursor_4c_Emp")
            IF loc_nResult > 0
                SELECT cursor_4c_Emp
                IF !EOF()
                    loc_cNomeEmpresa = ALLTRIM(cursor_4c_Emp.Razas)
                ENDIF
                USE IN cursor_4c_Emp
            ENDIF

            loc_cPeriodo = "Per" + CHR(237) + "odo: " + DTOC(THIS.this_dDataIni) + ;
                           " " + CHR(224) + " " + DTOC(THIS.this_dDataFin) + ;
                           " - Filtro: " + ;
                           IIF(THIS.this_nTipoFiltro = 1, "Prorrogados", "Vencimento")

            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
            CREATE CURSOR CsCabecalho ;
                (NomeEmpresa C(80), Titulo C(100), Periodo C(100))
            INSERT INTO CsCabecalho (NomeEmpresa, Titulo, Periodo) ;
                VALUES (loc_cNomeEmpresa, THIS.this_cTitulo, loc_cPeriodo)

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.MontarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursores - Fecha cursores de trabalho apos impressao/visualizacao
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursores()
        TRY
            IF USED(THIS.this_cCursorDados)
                USE IN (THIS.this_cCursorDados)
            ENDIF
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.LimparCursores")
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e imprime relatorio na impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF !THIS.PrepararDados()
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + ;
                        CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorDados)
            REPORT FORM (THIS.this_cArquivoRelatorio) TO PRINTER PROMPT NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.Imprimir")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = ""
            IF !THIS.PrepararDados()
                IF EMPTY(THIS.this_cMensagemErro)
                    THIS.this_cMensagemErro = "Erro ao preparar dados do relat" + ;
                        CHR(243) + "rio"
                ENDIF
                loc_lSucesso = .F.
            ENDIF
            IF !THIS.MontarCabecalho()
                loc_lSucesso = .F.
            ENDIF
            SELECT (THIS.this_cCursorDados)
            REPORT FORM (THIS.this_cArquivoRelatorio) PREVIEW NOCONSOLE
            THIS.LimparCursores()
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrecprBO.Visualizar")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega os filtros do BO a partir de um cursor
    * Util para restaurar filtros salvos / pre-configurados antes da impressao.
    * Aceita cursores com qualquer subconjunto das colunas abaixo:
    *   dDataIni, dDataFin (data)
    *   nTipoFiltro, nTipoRel, nBons, nOpcao (numerico)
    *   cTitulo (texto)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias
        loc_lSucesso = .F.
        TRY
            loc_cAlias = ALLTRIM(par_cAliasCursor)
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + ;
                    "o dispon" + CHR(237) + "vel: " + loc_cAlias
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)

            IF TYPE(loc_cAlias + ".dDataIni") = "D"
                THIS.this_dDataIni = NVL(EVALUATE(loc_cAlias + ".dDataIni"), DATE())
            ENDIF
            IF TYPE(loc_cAlias + ".dDataFin") = "D"
                THIS.this_dDataFin = NVL(EVALUATE(loc_cAlias + ".dDataFin"), DATE())
            ENDIF
            IF TYPE(loc_cAlias + ".nTipoFiltro") = "N"
                THIS.this_nTipoFiltro = NVL(EVALUATE(loc_cAlias + ".nTipoFiltro"), 1)
            ENDIF
            IF TYPE(loc_cAlias + ".nTipoRel") = "N"
                THIS.this_nTipoRel = NVL(EVALUATE(loc_cAlias + ".nTipoRel"), 1)
            ENDIF
            IF TYPE(loc_cAlias + ".nBons") = "N"
                THIS.this_nBons = NVL(EVALUATE(loc_cAlias + ".nBons"), 1)
            ENDIF
            IF TYPE(loc_cAlias + ".nOpcao") = "N"
                THIS.this_nOpcao = NVL(EVALUATE(loc_cAlias + ".nOpcao"), 1)
            ENDIF
            IF TYPE(loc_cAlias + ".cTitulo") = "C"
                THIS.this_cTitulo = ALLTRIM(NVL(EVALUATE(loc_cAlias + ".cTitulo"), ""))
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecprBO.CarregarDoCursor")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave composta dos filtros para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = "TIPO="   + ALLTRIM(STR(THIS.this_nTipoFiltro, 1)) + ;
                     ";REL="   + ALLTRIM(STR(THIS.this_nTipoRel, 1)) + ;
                     ";BONS="  + ALLTRIM(STR(THIS.this_nBons, 1)) + ;
                     ";OPC="   + ALLTRIM(STR(THIS.this_nOpcao, 1)) + ;
                     ";DT="    + DTOC(THIS.this_dDataIni) + ;
                     "-"       + DTOC(THIS.this_dDataFin)
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra geracao do relatorio em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = ""
            IF TYPE("gc_4c_UsuarioLogado") = "C"
                loc_cUsuario = ALLTRIM(NVL(gc_4c_UsuarioLogado, ""))
            ENDIF

            loc_cChave = THIS.ObterChavePrimaria()

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(DataHora, Usuario, Tabela, Operacao, ChaveRegistro) " + ;
                       "VALUES (GETDATE(), " + ;
                       EscaparSQL(loc_cUsuario) + ", " + ;
                       EscaparSQL("SigReCpr") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(loc_cChave) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Semantica para BO de relatorio: delega para Imprimir
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Imprimir()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("IMPRESSAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecprBO.Inserir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Semantica para BO de relatorio: delega para Visualizar
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            loc_lSucesso = THIS.Visualizar()
            IF loc_lSucesso
                THIS.RegistrarAuditoria("VISUALIZACAO")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrecprBO.Atualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Limpa cursores e chama base
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursores()
        DODEFAULT()
    ENDPROC

ENDDEFINE

