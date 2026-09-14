# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH loc_oPg.grd_4c_Forma define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: loc_oPg.grd_4c_Forma.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREDES.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2114 linhas total):

*-- Linhas 17 a 37:
17: *     - Colecao  : txt_4c_Cole      + txt_4c_ColeD       -> SigCdPsg (codigos/descricaos)
18: *     - Produto  : txt_4c_Prod      + txt_4c_ProdD       -> SigCdPro (CPros/DPros)
19: *     - opt_4c_Tipo   : 1=Detalhado, 2=Resumido
20: *     - chk_4c_Desc   : somente com desconto
21: *     - chk_4c_Lanc   : somente lancamentos
22: *     - grd_4c_Forma  : formas de pagamento (cursor_4c_OpFp)
23: *     - cmd_4c_Marcar / cmd_4c_Desmarcar
24: *==============================================================================
25: 
26: DEFINE CLASS FormSIGREDES AS FormBase
27: 
28:     *-- Dimensoes exatas do original (Width=555, Height=499)
29:     Height      = 499
30:     Width       = 555
31:     DataSession = 2
32:     ShowWindow  = 1
33:     WindowType  = 1
34:     AutoCenter  = .T.
35:     BorderStyle = 2
36:     ControlBox  = .F.
37:     MaxButton   = .F.

*-- Linhas 60 a 68:
60:         loc_lSucesso   = .F.
61:         loc_lContinuar = .T.
62:         TRY
63:             THIS.Caption = "Cotas de Desconto"
64: 
65:             IF TYPE("gc_4c_CaminhoIcones") = "U"
66:                 gc_4c_CaminhoIcones = ""
67:             ENDIF
68:             IF TYPE("gc_4c_CaminhoReports") = "U"

*-- Linhas 95 a 113:
95:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
96: 
97:                 *-- Vincular eventos Click dos botoes de marca/desmarca do grid
98:                 BINDEVENT(THIS.pgf_4c_Paginas.Page1.cmd_4c_Marcar,    "Click", THIS, "MarcarClick")
99:                 BINDEVENT(THIS.pgf_4c_Paginas.Page1.cmd_4c_Desmarcar, "Click", THIS, "DesmarcarClick")
100: 
101:                 *-- Vincular eventos de teclado e duplo-clique dos campos de filtro
102:                 THIS.VincularEventosFiltros()
103: 
104:                 *-- Carregar valores iniciais do BO nos controles
105:                 THIS.CarregarFiltrosNaUI()
106: 
107:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
108:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
109:                 THIS.Visible = .T.
110:                 loc_lSucesso = .T.
111:             ENDIF
112:         CATCH TO loc_oErro
113:             THIS.this_cMensagemErro = loc_oErro.Message

*-- Linhas 125 a 163:
125:     PROTECTED PROCEDURE ConfigurarCabecalho()
126:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
127:         WITH THIS.cnt_4c_Cabecalho
128:             .Top         = 0
129:             .Left        = 0
130:             .Width       = THIS.Width
131:             .Height      = 80
132:             .BackStyle   = 1
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136: 
137:             .AddObject("lbl_4c_Sombra", "Label")
138:             WITH .lbl_4c_Sombra
139:                 .Top       = 22
140:                 .Left      = 22
141:                 .Width     = THIS.Width
142:                 .Height    = 30
143:                 .Caption   = "Cotas de Desconto"
144:                 .FontName  = "Tahoma"
145:                 .FontSize  = 14
146:                 .FontBold  = .T.
147:                 .ForeColor = RGB(0, 0, 0)
148:                 .BackStyle = 0
149:                 .Visible   = .T.
150:             ENDWITH
151: 
152:             .AddObject("lbl_4c_Titulo", "Label")
153:             WITH .lbl_4c_Titulo
154:                 .Top       = 20
155:                 .Left      = 20
156:                 .Width     = THIS.Width
157:                 .Height    = 30
158:                 .Caption   = "Cotas de Desconto"
159:                 .FontName  = "Tahoma"
160:                 .FontSize  = 14
161:                 .FontBold  = .T.
162:                 .ForeColor = RGB(255, 255, 255)
163:                 .BackStyle = 0

*-- Linhas 174 a 199:
174:     PROTECTED PROCEDURE ConfigurarBotoes()
175:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
176:         WITH THIS.cmg_4c_Botoes
177:             .Top           = 0
178:             .Left          = 283
179:             .Width         = 272
180:             .Height        = 80
181:             .ButtonCount   = 4
182:             .BackStyle     = 0
183:             .BorderStyle   = 0
184:             .BorderColor   = RGB(136, 189, 188)
185:             .SpecialEffect = 1
186:             .Themes        = .F.
187:             .Visible       = .T.
188: 
189:             WITH .Buttons(1)
190:                 .Top             = 5
191:                 .Left            = 5
192:                 .Width           = 65
193:                 .Height          = 70
194:                 .Caption         = "Visualizar"
195:                 .FontBold        = .T.
196:                 .FontItalic      = .T.
197:                 .BackColor       = RGB(255, 255, 255)
198:                 .ForeColor       = RGB(90, 90, 90)
199:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 206 a 218:
206:             ENDWITH
207: 
208:             WITH .Buttons(2)
209:                 .Top             = 5
210:                 .Left            = 71
211:                 .Width           = 65
212:                 .Height          = 70
213:                 .Caption         = "Imprimir"
214:                 .FontName        = "Tahoma"
215:                 .FontBold        = .T.
216:                 .FontItalic      = .T.
217:                 .FontSize        = 8
218:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 227 a 239:
227:             ENDWITH
228: 
229:             WITH .Buttons(3)
230:                 .Top             = 5
231:                 .Left            = 137
232:                 .Width           = 65
233:                 .Height          = 70
234:                 .Caption         = "Excel"
235:                 .FontName        = "Tahoma"
236:                 .FontBold        = .T.
237:                 .FontItalic      = .T.
238:                 .FontSize        = 8
239:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 248 a 260:
248:             ENDWITH
249: 
250:             WITH .Buttons(4)
251:                 .Top             = 5
252:                 .Left            = 203
253:                 .Width           = 65
254:                 .Height          = 70
255:                 .Caption         = "Encerrar"
256:                 .Cancel          = .T.
257:                 .FontName        = "Tahoma"
258:                 .FontBold        = .T.
259:                 .FontItalic      = .T.
260:                 .FontSize        = 8

*-- Linhas 284 a 325:
284:         *-- PageCount ANTES de acessar Page1
285:         loc_oPgf.PageCount = 1
286: 
287:         loc_oPgf.Top    = 85
288:         loc_oPgf.Left   = -1
289:         loc_oPgf.Width  = THIS.Width + 2
290:         loc_oPgf.Height = THIS.Height - 85
291:         loc_oPgf.Tabs   = .F.
292: 
293:         loc_oPgf.Page1.Caption   = "Filtros"
294:         loc_oPgf.Page1.FontName  = "Tahoma"
295:         loc_oPgf.Page1.FontSize  = 8
296:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
297:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
298:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
299: 
300:         loc_oPgf.Visible    = .T.
301:         loc_oPgf.ActivePage = 1
302:     ENDPROC
303: 
304:     *--------------------------------------------------------------------------
305:     * ConfigurarPaginaLista - Wrapper de compatibilidade do pipeline de migracao
306:     *   FormSIGREDES eh REPORT (frmrelatorio): Page1 contem os FILTROS do
307:     *   relatorio (datas, codigos, opcoes) e a grade grd_4c_Forma de formas
308:     *   de pagamento. Todo o layout e configurado em ConfigurarFiltros().
309:     *   Esta procedure existe para satisfazer a fase 4 do pipeline (que assume
310:     *   forms CRUD com Page1=Lista) sem duplicar codigo.
311:     *--------------------------------------------------------------------------
312:     PROTECTED PROCEDURE ConfigurarPaginaLista()
313:         THIS.ConfigurarFiltros()
314:     ENDPROC
315: 
316:     *--------------------------------------------------------------------------
317:     * ConfigurarPaginaDados - RELATORIO: sem Page2 de dados CRUD.
318:     *   FormSIGREDES tem layout FLAT (PageCount=1). Todos os campos de filtro
319:     *   (Empresa, Periodo, Grupo, Conta, Categoria, Colecao, Produto, Tipo,
320:     *   Checkboxes, Grid de Formas de Pagamento) foram adicionados em
321:     *   ConfigurarFiltros() chamado de ConfigurarPaginaLista(). Este metodo
322:     *   garante visibilidade da unica page e existe para compatibilidade com
323:     *   o pipeline de migracao multi-fase (Fase 5 - campos Page2 Parte 1).
324:     *--------------------------------------------------------------------------
325:     PROTECTED PROCEDURE ConfigurarPaginaDados()

*-- Linhas 338 a 363:
338:         *-- === LINHA EMPRESA (Top_orig=86/89) ===
339: 
340:         *-- Label "Empresa :"
341:         loc_oPg.AddObject("lbl_4c_Empresa", "Label")
342:         WITH loc_oPg.lbl_4c_Empresa
343:             .Top       = 4
344:             .Left      = 69
345:             .Caption   = "Empresa :"
346:             .FontName  = "Tahoma"
347:             .FontSize  = 8
348:             .ForeColor = RGB(90, 90, 90)
349:             .BackStyle = 0
350:             .AutoSize  = .T.
351:             .Visible   = .T.
352:         ENDWITH
353: 
354:         *-- Codigo da Empresa (SigCdEmp.cEmps, MaxLength=3)
355:         loc_oPg.AddObject("txt_4c_Empresa", "TextBox")
356:         WITH loc_oPg.txt_4c_Empresa
357:             .Top           = 1
358:             .Left          = 123
359:             .Width         = 31
360:             .Height        = 21
361:             .MaxLength     = 3
362:             .Value         = ""
363:             .FontName      = "Tahoma"

*-- Linhas 372 a 381:
372:         *-- Descricao da Empresa (SigCdEmp.Razas, ReadOnly)
373:         loc_oPg.AddObject("txt_4c_DesEmpresa", "TextBox")
374:         WITH loc_oPg.txt_4c_DesEmpresa
375:             .Top           = 1
376:             .Left          = 156
377:             .Width         = 353
378:             .Height        = 23
379:             .Value         = ""
380:             .FontName      = "Tahoma"
381:             .FontSize      = 9

*-- Linhas 390 a 415:
390:         *-- === LINHA PERIODO (Top_orig=111/114/115) ===
391: 
392:         *-- Label "Periodo :"
393:         loc_oPg.AddObject("lbl_4c_Periodo", "Label")
394:         WITH loc_oPg.lbl_4c_Periodo
395:             .Top       = 29
396:             .Left      = 74
397:             .Caption   = "Per" + CHR(237) + "odo :"
398:             .FontName  = "Tahoma"
399:             .FontSize  = 8
400:             .ForeColor = RGB(90, 90, 90)
401:             .BackStyle = 0
402:             .AutoSize  = .T.
403:             .Visible   = .T.
404:         ENDWITH
405: 
406:         *-- Data Inicial
407:         loc_oPg.AddObject("txt_4c_DtInicial", "TextBox")
408:         WITH loc_oPg.txt_4c_DtInicial
409:             .Top           = 26
410:             .Left          = 123
411:             .Width         = 80
412:             .Height        = 23
413:             .MaxLength     = 10
414:             .Value         = {}
415:             .Format        = "K"

*-- Linhas 423 a 448:
423:         ENDWITH
424: 
425:         *-- Separador "a" entre datas
426:         loc_oPg.AddObject("lbl_4c_Sep", "Label")
427:         WITH loc_oPg.lbl_4c_Sep
428:             .Top       = 30
429:             .Left      = 207
430:             .Caption   = CHR(224)
431:             .FontName  = "Tahoma"
432:             .FontSize  = 8
433:             .ForeColor = RGB(90, 90, 90)
434:             .BackStyle = 0
435:             .AutoSize  = .T.
436:             .Visible   = .T.
437:         ENDWITH
438: 
439:         *-- Data Final
440:         loc_oPg.AddObject("txt_4c_DtFinal", "TextBox")
441:         WITH loc_oPg.txt_4c_DtFinal
442:             .Top           = 26
443:             .Left          = 220
444:             .Width         = 80
445:             .Height        = 23
446:             .MaxLength     = 10
447:             .Value         = {}
448:             .Format        = "K"

*-- Linhas 458 a 483:
458:         *-- === LINHA GRUPO (Top_orig=136/138) ===
459: 
460:         *-- Label "Grupo :"
461:         loc_oPg.AddObject("lbl_4c_Grupo", "Label")
462:         WITH loc_oPg.lbl_4c_Grupo
463:             .Top       = 53
464:             .Left      = 81
465:             .Caption   = "Grupo :"
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .ForeColor = RGB(90, 90, 90)
469:             .BackStyle = 0
470:             .AutoSize  = .T.
471:             .Visible   = .T.
472:         ENDWITH
473: 
474:         *-- Codigo do Grupo (SigCdGcr.codigos, MaxLength=10)
475:         loc_oPg.AddObject("txt_4c_CGru", "TextBox")
476:         WITH loc_oPg.txt_4c_CGru
477:             .Top           = 51
478:             .Left          = 123
479:             .Width         = 80
480:             .Height        = 21
481:             .MaxLength     = 10
482:             .Value         = ""
483:             .Format        = "K"

*-- Linhas 493 a 502:
493:         *-- Descricao do Grupo (SigCdGcr.descrs, ReadOnly)
494:         loc_oPg.AddObject("txt_4c_DGru", "TextBox")
495:         WITH loc_oPg.txt_4c_DGru
496:             .Top           = 51
497:             .Left          = 205
498:             .Width         = 304
499:             .Height        = 21
500:             .MaxLength     = 20
501:             .Value         = ""
502:             .Format        = "K"

*-- Linhas 513 a 538:
513:         *-- === LINHA CONTA/VENDEDOR (Top_orig=159/162) ===
514: 
515:         *-- Label "Conta :"
516:         loc_oPg.AddObject("lbl_4c_Conta", "Label")
517:         WITH loc_oPg.lbl_4c_Conta
518:             .Top       = 77
519:             .Left      = 81
520:             .Caption   = "Conta :"
521:             .FontName  = "Tahoma"
522:             .FontSize  = 8
523:             .ForeColor = RGB(90, 90, 90)
524:             .BackStyle = 0
525:             .AutoSize  = .T.
526:             .Visible   = .T.
527:         ENDWITH
528: 
529:         *-- Codigo do Vendedor/Conta (SigCdCli.IClis, MaxLength=10)
530:         loc_oPg.AddObject("txt_4c_Vend", "TextBox")
531:         WITH loc_oPg.txt_4c_Vend
532:             .Top           = 74
533:             .Left          = 123
534:             .Width         = 80
535:             .Height        = 21
536:             .MaxLength     = 10
537:             .Value         = ""
538:             .Format        = "K"

*-- Linhas 548 a 557:
548:         *-- Descricao do Vendedor/Conta (SigCdCli.RClis, ReadOnly)
549:         loc_oPg.AddObject("txt_4c_DVend", "TextBox")
550:         WITH loc_oPg.txt_4c_DVend
551:             .Top           = 74
552:             .Left          = 205
553:             .Width         = 304
554:             .Height        = 21
555:             .MaxLength     = 40
556:             .Value         = ""
557:             .Format        = "K"

*-- Linhas 568 a 593:
568:         *-- === LINHA CATEGORIA (Top_orig=182/185) ===
569: 
570:         *-- Label "Categoria :"
571:         loc_oPg.AddObject("lbl_4c_Categ", "Label")
572:         WITH loc_oPg.lbl_4c_Categ
573:             .Top       = 100
574:             .Left      = 63
575:             .Caption   = "Categoria :"
576:             .FontName  = "Tahoma"
577:             .FontSize  = 8
578:             .ForeColor = RGB(90, 90, 90)
579:             .BackStyle = 0
580:             .AutoSize  = .T.
581:             .Visible   = .T.
582:         ENDWITH
583: 
584:         *-- Codigo da Categoria (SigCdCol.codigos, MaxLength=10)
585:         loc_oPg.AddObject("txt_4c_Cate", "TextBox")
586:         WITH loc_oPg.txt_4c_Cate
587:             .Top           = 97
588:             .Left          = 123
589:             .Width         = 108
590:             .Height        = 23
591:             .MaxLength     = 10
592:             .Value         = ""
593:             .FontName      = "Tahoma"

*-- Linhas 602 a 611:
602:         *-- Descricao da Categoria (SigCdCol.descrs, ReadOnly)
603:         loc_oPg.AddObject("txt_4c_CateD", "TextBox")
604:         WITH loc_oPg.txt_4c_CateD
605:             .Top           = 97
606:             .Left          = 233
607:             .Width         = 276
608:             .Height        = 23
609:             .MaxLength     = 40
610:             .Value         = ""
611:             .FontName      = "Tahoma"

*-- Linhas 621 a 646:
621:         *-- === LINHA COLECAO (Top_orig=207/210) ===
622: 
623:         *-- Label "Colecao :" (Cole + CHR(231) + CHR(227) + "o :")
624:         loc_oPg.AddObject("lbl_4c_Colecao", "Label")
625:         WITH loc_oPg.lbl_4c_Colecao
626:             .Top       = 125
627:             .Left      = 69
628:             .Caption   = "Cole" + CHR(231) + CHR(227) + "o :"
629:             .FontName  = "Tahoma"
630:             .FontSize  = 8
631:             .ForeColor = RGB(90, 90, 90)
632:             .BackStyle = 0
633:             .AutoSize  = .T.
634:             .Visible   = .T.
635:         ENDWITH
636: 
637:         *-- Codigo da Colecao (SigCdPsg.codigos, MaxLength=10)
638:         loc_oPg.AddObject("txt_4c_Cole", "TextBox")
639:         WITH loc_oPg.txt_4c_Cole
640:             .Top           = 122
641:             .Left          = 123
642:             .Width         = 108
643:             .Height        = 23
644:             .MaxLength     = 10
645:             .Value         = ""
646:             .FontName      = "Tahoma"

*-- Linhas 655 a 664:
655:         *-- Descricao da Colecao (SigCdPsg.descricaos, ReadOnly)
656:         loc_oPg.AddObject("txt_4c_ColeD", "TextBox")
657:         WITH loc_oPg.txt_4c_ColeD
658:             .Top           = 122
659:             .Left          = 233
660:             .Width         = 276
661:             .Height        = 23
662:             .MaxLength     = 40
663:             .Value         = ""
664:             .FontName      = "Tahoma"

*-- Linhas 674 a 699:
674:         *-- === LINHA PRODUTO (Top_orig=232/235) ===
675: 
676:         *-- Label "Produto :"
677:         loc_oPg.AddObject("lbl_4c_Produto", "Label")
678:         WITH loc_oPg.lbl_4c_Produto
679:             .Top       = 150
680:             .Left      = 72
681:             .Caption   = "Produto :"
682:             .FontName  = "Tahoma"
683:             .FontSize  = 8
684:             .ForeColor = RGB(90, 90, 90)
685:             .BackStyle = 0
686:             .AutoSize  = .T.
687:             .Visible   = .T.
688:         ENDWITH
689: 
690:         *-- Codigo do Produto (SigCdPro.CPros, MaxLength=14)
691:         loc_oPg.AddObject("txt_4c_Prod", "TextBox")
692:         WITH loc_oPg.txt_4c_Prod
693:             .Top           = 147
694:             .Left          = 123
695:             .Width         = 108
696:             .Height        = 23
697:             .MaxLength     = 14
698:             .Value         = ""
699:             .FontName      = "Tahoma"

*-- Linhas 708 a 717:
708:         *-- Descricao do Produto (SigCdPro.DPros, ReadOnly)
709:         loc_oPg.AddObject("txt_4c_ProdD", "TextBox")
710:         WITH loc_oPg.txt_4c_ProdD
711:             .Top           = 147
712:             .Left          = 233
713:             .Width         = 276
714:             .Height        = 23
715:             .MaxLength     = 40
716:             .Value         = ""
717:             .FontName      = "Tahoma"

*-- Linhas 727 a 816:
727:         *-- === TIPO DE VISAO (Top_orig=261/266) ===
728: 
729:         *-- Label "Tipo :"
730:         loc_oPg.AddObject("lbl_4c_Tipo", "Label")
731:         WITH loc_oPg.lbl_4c_Tipo
732:             .Top       = 181
733:             .Left      = 90
734:             .Caption   = "Tipo :"
735:             .FontName  = "Tahoma"
736:             .FontSize  = 8
737:             .ForeColor = RGB(90, 90, 90)
738:             .BackStyle = 0
739:             .AutoSize  = .T.
740:             .Visible   = .T.
741:         ENDWITH
742: 
743:         *-- OptionGroup tipo de visao (1=Detalhado, 2=Resumido)
744:         loc_oPg.AddObject("opt_4c_Tipo", "OptionGroup")
745:         WITH loc_oPg.opt_4c_Tipo
746:             .Top         = 176
747:             .Left        = 115
748:             .Width       = 137
749:             .Height      = 47
750:             .ButtonCount = 2
751:             .Value       = 1
752:             .BackStyle   = 0
753:             .BorderStyle = 0
754:             .Visible     = .T.
755: 
756:             WITH .Buttons(1)
757:                 .Caption   = "Vis" + CHR(227) + "o detalhada"
758:                 .Value     = 1
759:                 .Height    = 15
760:                 .Left      = 7
761:                 .Top       = 5
762:                 .Width     = 94
763:                 .AutoSize  = .T.
764:                 .BackStyle = 0
765:                 .ForeColor = RGB(90, 90, 90)
766:                 .Visible   = .T.
767:             ENDWITH
768: 
769:             WITH .Buttons(2)
770:                 .Caption   = "Vis" + CHR(227) + "o Resumida"
771:                 .Height    = 15
772:                 .Left      = 7
773:                 .Top       = 26
774:                 .Width     = 92
775:                 .AutoSize  = .T.
776:                 .FontName  = "Tahoma"
777:                 .FontSize  = 8
778:                 .BackStyle = 0
779:                 .ForeColor = RGB(90, 90, 90)
780:                 .Visible   = .T.
781:             ENDWITH
782:         ENDWITH
783: 
784:         *-- === CHECKBOXES (Top_orig=264) ===
785: 
786:         *-- CheckBox "Com desconto"
787:         loc_oPg.AddObject("chk_4c_Desc", "CheckBox")
788:         WITH loc_oPg.chk_4c_Desc
789:             .Top       = 179
790:             .Left      = 280
791:             .Height    = 15
792:             .Width     = 86
793:             .Caption   = "Com desconto"
794:             .Value     = 0
795:             .FontName  = "Tahoma"
796:             .FontSize  = 8
797:             .BackStyle = 0
798:             .Alignment = 0
799:             .ForeColor = RGB(90, 90, 90)
800:             .AutoSize  = .T.
801:             .Visible   = .T.
802:         ENDWITH
803: 
804:         *-- CheckBox "Lancamento"
805:         loc_oPg.AddObject("chk_4c_Lanc", "CheckBox")
806:         WITH loc_oPg.chk_4c_Lanc
807:             .Top       = 179
808:             .Left      = 385
809:             .Height    = 15
810:             .Width     = 76
811:             .Caption   = "Lan" + CHR(231) + "amento"
812:             .Value     = 0
813:             .FontName  = "Tahoma"
814:             .FontSize  = 8
815:             .BackStyle = 0
816:             .Alignment = 0

*-- Linhas 822 a 855:
822:         *-- === GRID FORMAS DE PAGAMENTO (Top_orig=306) ===
823: 
824:         *-- Label "Forma de Pagamento :"
825:         loc_oPg.AddObject("lbl_4c_FormasPgto", "Label")
826:         WITH loc_oPg.lbl_4c_FormasPgto
827:             .Top       = 221
828:             .Left      = 8
829:             .Caption   = "Forma de Pagamento :"
830:             .FontName  = "Tahoma"
831:             .FontSize  = 8
832:             .ForeColor = RGB(90, 90, 90)
833:             .BackStyle = 0
834:             .AutoSize  = .T.
835:             .Visible   = .T.
836:         ENDWITH
837: 
838:         *-- Grid de Formas de Pagamento (RecordSource = cursor_4c_OpFp)
839:         loc_oPg.AddObject("grd_4c_Forma", "Grid")
840:         WITH loc_oPg.grd_4c_Forma
841:             .Top           = 221
842:             .Left          = 122
843:             .Width         = 228
844:             .Height        = 181
845:             .ColumnCount   = 2
846:             .FontName      = "Tahoma"
847:             .AllowRowSizing = .F.
848:             .DeleteMark    = .F.
849:             .GridLines     = 3
850:             .GridLineColor = RGB(238, 238, 238)
851:             .HeaderHeight  = 18
852:             .RowHeight     = 18
853:             .ScrollBars    = 2
854:             .RecordMark    = .F.
855:             .Themes        = .F.

*-- Linhas 868 a 892:
868:                 .Alignment       = 0
869:                 .Sparse          = .F.
870:                 .ReadOnly        = .F.
871:                 .Header1.Caption = ""
872:                 .AddObject("chk_4c_Marca", "CheckBox")
873:                 WITH .chk_4c_Marca
874:                     .Alignment = 0
875:                     .Caption   = ""
876:                     .Height    = 17
877:                     .Visible   = .T.
878:                 ENDWITH
879:                 .CurrentControl = "chk_4c_Marca"
880:                 .ControlSource  = "cursor_4c_OpFp.nMarca"
881:             ENDWITH
882: 
883:             WITH .Column2
884:                 .Width         = 210
885:                 .ControlSource = "cursor_4c_OpFp.fpags"
886:                 .ReadOnly      = .T.
887:                 .Header1.Caption = "Descrs"
888:                 .AddObject("txt_4c_FpNome", "TextBox")
889:                 WITH .txt_4c_FpNome
890:                     .BorderStyle = 0
891:                     .Margin      = 0
892:                     .ReadOnly    = .T.

*-- Linhas 901 a 934:
901:         *-- === BOTOES MARCAR / DESMARCAR (Top_orig=348/392) ===
902: 
903:         *-- Botao Marcar/Selecionar (Command2 do legado - geral_marcar_26.jpg)
904:         loc_oPg.AddObject("cmd_4c_Marcar", "CommandButton")
905:         WITH loc_oPg.cmd_4c_Marcar
906:             .Top          = 263
907:             .Left         = 355
908:             .Height       = 45
909:             .Width        = 45
910:             .Caption      = ""
911:             .ToolTipText  = "Selecionar"
912:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
913:             .FontName     = "Verdana"
914:             .FontSize     = 8
915:             .ForeColor    = RGB(36, 84, 155)
916:             .BackColor    = RGB(255, 255, 255)
917:             .TabStop      = .F.
918:             .Themes       = .F.
919:             .Visible      = .T.
920:         ENDWITH
921: 
922:         *-- Botao Desmarcar (Command1 do legado - cadastro_excluir_26.jpg)
923:         loc_oPg.AddObject("cmd_4c_Desmarcar", "CommandButton")
924:         WITH loc_oPg.cmd_4c_Desmarcar
925:             .Top          = 307
926:             .Left         = 355
927:             .Height       = 45
928:             .Width        = 45
929:             .Caption      = ""
930:             .ToolTipText  = "Desmarcar"
931:             .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
932:             .FontName     = "Verdana"
933:             .FontSize     = 8
934:             .ForeColor    = RGB(36, 84, 155)

*-- Linhas 996 a 1018:
996:             WITH THIS.this_oRelatorio
997:                 loc_oPg.txt_4c_Empresa.Value    = ALLTRIM(.this_cEmpresa)
998:                 loc_oPg.txt_4c_DesEmpresa.Value = ALLTRIM(.this_cDesEmpresa)
999:                 loc_oPg.txt_4c_DtInicial.Value  = .this_dDtInicial
1000:                 loc_oPg.txt_4c_DtFinal.Value    = .this_dDtFinal
1001:                 loc_oPg.txt_4c_CGru.Value       = ALLTRIM(.this_cCGru)
1002:                 loc_oPg.txt_4c_DGru.Value       = ALLTRIM(.this_cDGru)
1003:                 loc_oPg.txt_4c_Vend.Value       = ALLTRIM(.this_cVend)
1004:                 loc_oPg.txt_4c_DVend.Value      = ALLTRIM(.this_cDVend)
1005:                 loc_oPg.txt_4c_Cate.Value       = ALLTRIM(.this_cCate)
1006:                 loc_oPg.txt_4c_CateD.Value      = ALLTRIM(.this_cCateD)
1007:                 loc_oPg.txt_4c_Cole.Value       = ALLTRIM(.this_cCole)
1008:                 loc_oPg.txt_4c_ColeD.Value      = ALLTRIM(.this_cColeD)
1009:                 loc_oPg.txt_4c_Prod.Value       = ALLTRIM(.this_cProd)
1010:                 loc_oPg.txt_4c_ProdD.Value      = ALLTRIM(.this_cProdD)
1011:                 loc_oPg.opt_4c_Tipo.Value       = .this_nOpcao
1012:                 loc_oPg.chk_4c_Desc.Value       = .this_nDesc
1013:                 loc_oPg.chk_4c_Lanc.Value       = .this_nLanc
1014:             ENDWITH
1015: 
1016:             *-- Se empresa ainda sem descricao, buscar descricao
1017:             IF EMPTY(ALLTRIM(loc_oPg.txt_4c_DesEmpresa.Value)) AND ;
1018:                !EMPTY(ALLTRIM(loc_oPg.txt_4c_Empresa.Value))

*-- Linhas 1171 a 1210:
1171:                 GO TOP
1172:                 SCAN
1173:                     REPLACE nMarca WITH 1
1174:                 ENDSCAN
1175:                 GO TOP
1176:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
1177:             ENDIF
1178:         CATCH TO loc_oErro
1179:             MsgErro(loc_oErro.Message, "Erro")
1180:         ENDTRY
1181:     ENDPROC
1182: 
1183:     *--------------------------------------------------------------------------
1184:     * DesmarcarClick - Desmarca todas as formas de pagamento no grid
1185:     *--------------------------------------------------------------------------
1186:     PROCEDURE DesmarcarClick()
1187:         TRY
1188:             IF USED("cursor_4c_OpFp")
1189:                 SELECT cursor_4c_OpFp
1190:                 GO TOP
1191:                 SCAN
1192:                     REPLACE nMarca WITH 0
1193:                 ENDSCAN
1194:                 GO TOP
1195:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
1196:             ENDIF
1197:         CATCH TO loc_oErro
1198:             MsgErro(loc_oErro.Message, "Erro")
1199:         ENDTRY
1200:     ENDPROC
1201: 
1202:     *==========================================================================
1203:     * HANDLERS DE TECLADO (PUBLIC - contrato BINDEVENT)
1204:     * F4=115, ENTER=13, TAB=9, ESC=27
1205:     *==========================================================================
1206: 
1207:     PROCEDURE TeclaEmpresa(par_nKeyCode, par_nShiftAltCtrl)
1208:         IF par_nKeyCode = 115
1209:             THIS.AbrirBuscaEmpresa()
1210:         ENDIF

*-- Linhas 2041 a 2065:
2041:         LOCAL loc_lSucesso
2042:         loc_lSucesso = .F.
2043:         TRY
2044:             IF VARTYPE(THIS.this_oRelatorio) = "O"
2045:                 IF USED("cursor_4c_OpFp")
2046:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.ColumnCount = 2
2047:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.RecordSource = "cursor_4c_OpFp"
2048:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Column1.ControlSource = "cursor_4c_OpFp.nMarca"
2049:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Column2.ControlSource = "cursor_4c_OpFp.fpags"
2050:                     THIS.pgf_4c_Paginas.Page1.grd_4c_Forma.Refresh()
2051:                 ENDIF
2052:             ENDIF
2053:             loc_lSucesso = .T.
2054:         CATCH TO loc_oErro
2055:             MsgErro(loc_oErro.Message, "Erro")
2056:         ENDTRY
2057:         RETURN loc_lSucesso
2058:     ENDPROC
2059: 
2060:     *--------------------------------------------------------------------------
2061:     * AjustarBotoesPorModo - Em FormSIGREDES (REPORT), os botoes de relatorio
2062:     *   (Visualizar/Imprimir/Excel/Encerrar) ficam sempre habilitados.
2063:     *--------------------------------------------------------------------------
2064:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2065:         TRY


### BO (C:\4c\projeto\app\classes\SIGREDESBO.prg):
*==============================================================================
* SIGREDESBO.PRG
* Business Object para Relatorio de Cotas de Desconto (SIGREDES)
* Herda de RelatorioBase
*
* Tabelas principais: SigMvCab, SigMvItn, SigMvItd, sigcddes
* Relatorios FRX: SigReDes.frx (Detalhado), SigReDe1.frx (Resumido)
*
* Filtros:
*   - Empresa    (codigo + descricao)
*   - Periodo    (data inicial / data final)
*   - Grupo      (codigo + descricao - campo Grupos de SigCdCli)
*   - Vendedor   (codigo + descricao - campo Vends/IClis de SigMvCab/SigCdCli)
*   - Categoria  (codigo + descricao - campo colecoes de SigcdPro / SigCdCol)
*   - Colecao    (codigo + descricao - campo sgrus de SigcdPro / SigCdPsg)
*   - Produto    (codigo + descricao - campo CPros de SigCdPro)
*   - Com desconto (0=todos, 1=somente com desconto)
*   - Lancamento   (0=todos, 1=somente lancamentos novos)
*   - Tipo visao   (1=Detalhado, 2=Resumido)
*==============================================================================

DEFINE CLASS SIGREDESBO AS RelatorioBase

    *-- Filtro: empresa
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""

    *-- Filtro: periodo
    this_dDtInicial     = {}
    this_dDtFinal       = {}

    *-- Filtro: grupo (campo Grupos de SigCdCli)
    this_cCGru          = ""
    this_cDGru          = ""

    *-- Filtro: vendedor (campo Vends de SigMvCab / IClis de SigCdCli)
    this_cVend          = ""
    this_cDVend         = ""

    *-- Filtro: categoria (campo colecoes de SigcdPro; lookup SigCdCol: colecoes/descs)
    this_cCate          = ""
    this_cCateD         = ""

    *-- Filtro: colecao (campo sgrus de SigcdPro; lookup SigCdPsg: codigos/descricaos)
    this_cCole          = ""
    this_cColeD         = ""

    *-- Filtro: produto (campo CPros de SigCdPro; lookup SigCdPro: CPros/DPros)
    this_cProd          = ""
    this_cProdD         = ""

    *-- Tipo de visao: 1=Detalhado (SigReDes.frx), 2=Resumido (SigReDe1.frx)
    this_nOpcao         = 1

    *-- Filtro com desconto: 0=todos, 1=somente itens com desconto (chaitd preenchido)
    this_nDesc          = 0

    *-- Filtro lancamento: 0=todos, 1=somente lancamentos (dtincs do produto < 61 dias)
    this_nLanc          = 0

    *-- Cursores gerenciados pelo BO
    this_cCursorDados      = "cursor_4c_Dados"
    this_cCursorRelatorio  = "cursor_4c_Relatorio"
    this_cCursorOpFp       = "cursor_4c_OpFp"

    *--------------------------------------------------------------------------
    * Init - Configura BO do relatorio de Cotas de Desconto
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarFiltros - Inicializa filtros com valores padrao e carrega
    * formas de pagamento disponiveis em cursor_4c_OpFp (ReadWrite para que o
    * grid do form permita marcar/desmarcar via CheckBox).
    * Equivalente ao bloco de Init() do form legado SIGREDES.
    * Chamado pelo form em InicializarForm().
    *--------------------------------------------------------------------------
    PROCEDURE InicializarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_dPrimeiro, loc_dUltimo
        loc_lSucesso = .F.
        TRY
            *-- Primeiro e ultimo dia do mes corrente
            loc_dPrimeiro = DATE() - DAY(DATE()) + 1
            loc_dUltimo   = GOMONTH(loc_dPrimeiro, 1) - 1

            THIS.this_dDtInicial  = loc_dPrimeiro
            THIS.this_dDtFinal    = loc_dUltimo
            THIS.this_cEmpresa    = go_4c_Sistema.cCodEmpresa
            THIS.this_cDesEmpresa = ""
            THIS.this_cVend       = ""
            THIS.this_cDVend      = ""
            THIS.this_cCGru       = ""
            THIS.this_cDGru       = ""
            THIS.this_cCate       = ""
            THIS.this_cCateD      = ""
            THIS.this_cCole       = ""
            THIS.this_cColeD      = ""
            THIS.this_cProd       = ""
            THIS.this_cProdD      = ""
            THIS.this_nOpcao      = 1
            THIS.this_nDesc       = 0
            THIS.this_nLanc       = 0

            *-- Carregar formas de pagamento disponiveis (SigOpFp)
            *-- Cursor precisa ser ReadWrite: usuario marca/desmarca via grid
            IF USED(THIS.this_cCursorOpFp)
                USE IN (THIS.this_cCursorOpFp)
            ENDIF
            IF USED("cursor_4c_OpFp_tmp")
                USE IN cursor_4c_OpFp_tmp
            ENDIF

            loc_cSQL = "SELECT CAST(0 AS INT) AS nMarca, fpags FROM SigOpFp ORDER BY fpags"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpFp_tmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha ao carregar formas de pagamento (SigOpFp)"
            ELSE
                SELECT * FROM cursor_4c_OpFp_tmp INTO CURSOR (THIS.this_cCursorOpFp) READWRITE
                USE IN cursor_4c_OpFp_tmp
                SELECT (THIS.this_cCursorOpFp)
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Processa dados do relatorio de Cotas de Desconto
    * Equivalente ao procedimento "processamento" do legado SIGREDES.SCX
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lContinuar
        LOCAL loc_lcGru, loc_lcVend, loc_lcEmp, loc_lcCole, loc_lcCate, loc_lcProd
        LOCAL loc_cheVen, loc_cheCole, loc_cheCate, loc_cheProd, loc_cheFP
        LOCAL loc_lcQuery, loc_nResult
        LOCAL loc_lcCbEmp, loc_lcCbTitulo, loc_lcCbPeriodo
        LOCAL loc_lcChaAnt, loc_ldDatM, loc_ldDatP, loc_lnValRel, loc_lnAlt
        LOCAL loc_lcPdes, loc_lcVdes, loc_lnOpt, loc_lnDesc, loc_lnLanc
        LOCAL loc_cOpFpAlias, loc_nVdestot
        LOCAL loc_aCursFech(11), loc_nFech
        PRIVATE pDtI, pDtF, pDtH

        loc_lSucesso   = .F.
        loc_lContinuar = .T.
        TRY
            *-- Extrair valores dos filtros do BO
            loc_lcGru  = ALLTRIM(THIS.this_cCGru)
            loc_lcVend = ALLTRIM(THIS.this_cVend)
            loc_lcEmp  = ALLTRIM(THIS.this_cEmpresa)
            loc_lcCole = ALLTRIM(THIS.this_cCole)
            loc_lcCate = ALLTRIM(THIS.this_cCate)
            loc_lcProd = ALLTRIM(THIS.this_cProd)
            loc_lnOpt  = THIS.this_nOpcao
            loc_lnDesc = THIS.this_nDesc
            loc_lnLanc = THIS.this_nLanc

            *-- Parametros de data para SQLEXEC binding (?pDtI / ?pDtF / ?pDtH)
            pDtI = DTOT(THIS.this_dDtInicial)
            pDtF = DTOT(THIS.this_dDtFinal) + 86399
            pDtH = DTOT(DATE()) + 86399

            *-- Filtro vendedor
            IF EMPTY(loc_lcVend)
                loc_cheVen = ""
            ELSE
                loc_cheVen = " and a.vends = '" + loc_lcVend + "' "
            ENDIF

            *-- Filtro colecao
            IF EMPTY(loc_lcCole)
                loc_cheCole = ""
            ELSE
                loc_cheCole = " and p.sgrus = '" + loc_lcCole + "' "
            ENDIF

            *-- Filtro categoria
            IF EMPTY(loc_lcCate)
                loc_cheCate = ""
            ELSE
                loc_cheCate = " and p.colecoes = '" + loc_lcCate + "' "
            ENDIF

            *-- Filtro produto
            IF EMPTY(loc_lcProd)
                loc_cheProd = ""
            ELSE
                loc_cheProd = " and b.cpros = '" + loc_lcProd + "' "
            ENDIF

            *-- Filtro formas de pagamento (marcadas no grid)
            loc_cheFP      = ""
            loc_cOpFpAlias = THIS.this_cCursorOpFp
            IF USED(loc_cOpFpAlias)
                SELECT nMarca, fpags FROM (loc_cOpFpAlias) WHERE nMarca = 1 ;
                    INTO CURSOR cursor_4c_FpSel
                GO TOP
                IF !EOF()
                    loc_cheFP = " and e.fpags in ('"
                    SCAN
                        loc_cheFP = loc_cheFP + ALLTRIM(fpags) + "','"
                    ENDSCAN
                    loc_cheFP = LEFT(loc_cheFP, LEN(loc_cheFP) - 2) + ") "
                ENDIF
                IF USED("cursor_4c_FpSel")
                    USE IN cursor_4c_FpSel
                ENDIF
            ENDIF

            *-- Titulo para cabecalho do relatorio
            loc_lcCbEmp = "VENDAS"
            IF !EMPTY(loc_lcGru)
                loc_lcCbEmp = loc_lcCbEmp + " (" + ALLTRIM(loc_lcGru) + ")"
            ENDIF

            *-- Fechar cursores de execucao anterior
            loc_aCursFech(1)  = "csDados"
            loc_aCursFech(2)  = "csDados1"
            loc_aCursFech(3)  = "csDados_tmp"
            loc_aCursFech(4)  = "csRelatorio"
            loc_aCursFech(5)  = "csTmpRel"
            loc_aCursFech(6)  = "csCabecalho"
            loc_aCursFech(7)  = "crProd"
            loc_aCursFech(8)  = "crMvPar"
            loc_aCursFech(9)  = "crAux"
            loc_aCursFech(10) = "crAux1"
            loc_aCursFech(11) = "crAux2"
            FOR loc_nFech = 1 TO 11
                IF USED(loc_aCursFech(loc_nFech))
                    USE IN (loc_aCursFech(loc_nFech))
                ENDIF
            ENDFOR
            IF USED("cursor_4c_FpSel")
                USE IN cursor_4c_FpSel
            ENDIF

            *-- Query principal: cabecalho x itens x descontos (SQL Server)
            loc_lcQuery = ;
                "Select a.datars, a.Emps, a.Dopes, a.Numes, " + ;
                "b.CPros, b.dpros, b.qtds, b.units, b.unitorigs, b.totas, b.opers, " + ;
                "c.rclis as repre, " + ;
                "case when co.descricaos is null then 'sem subgrupo' " + ;
                "  else co.descricaos end as colecao, " + ;
                "case when ca.descs is null then 'sem categoria' " + ;
                "  else ca.descs end as categoria, " + ;
                "a.empdopnums, a.cidchaves as chaCab, b.cidchaves as chaItn, " + ;
                "d.cidchaves as chaItd, SPACE(50) as formasP, '1' as imprime, " + ;
                "' ' as lancamento, d.ddesc, d.pdes, d.vdes, d.tpdesc, " + ;
                "d.codigo, e.valcota, round(unitorigs*qtds,2) as ValR, " + ;
                "CAST(0.00 as numeric(11,4)) as DescT, " + ;
                "CAST(0.00 as numeric(11,2)) as Realizado, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes01, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes01, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes02, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes02, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes03, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes03, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes04, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes04, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes05, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes05, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes06, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes06, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes07, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes07, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes08, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes08, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes09, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes09, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes10, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes10, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes11, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes11, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes12, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes12, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes13, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes13, " + ;
                "CAST(0.00 as numeric(7,4)) as pdes14, " + ;
                "CAST(0.00 as numeric(11,2)) as vdes14, " + ;
                "CAST(0.00 as numeric(11,4)) as vdestot " + ;
                "From SigMvCab a with(nolock) " + ;
                "left join SigCdCli c with(nolock) on c.IClis = a.Vends " + ;
                ", SigMvItn b with(nolock) " + ;
                "left join SigMvItd d with(nolock) " + ;
                "  on b.empdopnums = d.empdopnums " + ;
                "  and b.cpros = d.Cpros and b.citens = d.citens " + ;
                "left join sigcddes e with(nolock) on d.codigo = e.codigo, " + ;
                "SigCdOpe g with(nolock), " + ;
                "SigCdTom h with(nolock), SigcdPro p with(nolock) " + ;
                "left join SigCdPsg co with(nolock) " + ;
                "  on co.cgrus = p.cgrus and co.codigos = p.sgrus " + ;
                "left join SigCdCtg ca with(nolock) on ca.cods = p.categoria " + ;
                "Where a.datars BetWeen ?pDtI And ?pDtF And " + ;
                IIF(EMPTY(loc_lcGru), "", "c.Grupos = '" + loc_lcGru + "' And ") + ;
                IIF(EMPTY(loc_lcEmp), "", "a.Emps = '"   + loc_lcEmp + "' And ") + ;
                "b.cpros = p.cpros And " + ;
                "a.EmpDopNums = b.EmpDopNums and " + ;
                "a.dopes = g.dopes and " + ;
                "g.tipoops = h.codigos and " + ;
                "h.gergdmis = 1 and " + ;
                "g.tipoops <> 5 " + ;
                loc_cheCole + loc_cheCate + loc_cheVen + loc_cheProd + ;
                "order by a.cidchaves, b.cidchaves, d.cidchaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDados_tmp")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (csDados)"
                loc_lContinuar = .F.
            ENDIF

            IF loc_lContinuar
                SELECT * FROM csDados_tmp INTO CURSOR csDados READWRITE
                USE IN csDados_tmp
                SELECT csDados
                GO TOP

                *-- Query secundaria: cotas sigcddes nao cobertas pela query principal
                loc_lcQuery = "SELECT * FROM sigcddes WITH(NOLOCK)" + ;
                    " WHERE dtini >= ?pDtI And dtfin <= ?pDtF" + ;
                    IIF(EMPTY(loc_lcEmp), "", " and Emps = '" + loc_lcEmp + "'")
                loc_nResult = SQLEXEC(gnConnHandle, loc_lcQuery, "csDados1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (csDados1)"
                    loc_lContinuar = .F.
                ENDIF
            ENDIF

            IF loc_lContinuar
                *-- Append de cotas sem venda no periodo
                SELECT * FROM csDados1 ;
                    WHERE emps NOT IN (SELECT emps FROM csDados) ;
                    INTO CURSOR csDados1
                SELECT csDados1
                GO TOP
                SCAN
                    SELECT csDados
                    APPEND BLANK
                    REPLACE emps    WITH csDados1.emps
                    REPLACE valcota WITH csDados1.valcota
                    REPLACE imprime WITH "1"
                ENDSCAN
                IF USED("csDados1")
                    USE IN csDados1
                ENDIF

                *-- Marcar linhas duplicadas e sinalizar lancamentos
                loc_lcChaAnt = "xxxxxxx"
                SELECT csDados
                GO TOP
                SCAN
                    IF ISNULL(csDados.chaitd) OR EMPTY(csDados.chaitd)
                        REPLACE chaitd WITH SPACE(20) IN csDados
                        REPLACE ddesc  WITH ""         IN csDados
                        REPLACE pdes   WITH 0.00       IN csDados
                        REPLACE vdes   WITH 0.00       IN csDados
                    ENDIF
                    IF csDados.chacab + csDados.chaitn + csDados.chaitd = loc_lcChaAnt
                        REPLACE imprime WITH "" IN csDados
                    ENDIF
                    loc_lcChaAnt = csDados.chacab + csDados.chaitn + csDados.chaitd

                    *-- Lancamento: produto lancado ha menos de 61 dias da data da venda
                    loc_lcQuery = "SELECT dtincs FROM sigcdpro WITH(NOLOCK) WHERE cpros = " + ;
                                  EscaparSQL(ALLTRIM(csDados.cpros))
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crProd") >= 1
                        SELECT crProd
                        IF !EOF() AND !ISNULL(crProd.dtincs)
                            loc_ldDatM = TTOD(csDados.datars)
                            loc_ldDatP = TTOD(crProd.dtincs)
                            IF loc_ldDatM - loc_ldDatP < 61
                                REPLACE lancamento WITH "1" IN csDados
                            ENDIF
                        ENDIF
                        USE IN crProd
                    ENDIF
                    SELECT csDados
                ENDSCAN

                *-- Filtrar somente itens com desconto (chaitd preenchido)
                IF loc_lnDesc = 1
                    SELECT csDados
                    DELETE ALL FOR chaitd = SPACE(20)
                ENDIF

                *-- Filtrar somente produtos lancamento
                IF loc_lnLanc = 1
                    SELECT csDados
                    DELETE ALL FOR lancamento <> "1"
                ENDIF

                *-- Formas de pagamento de cada operacao
                SELECT csDados
                GO TOP
                SCAN
                    loc_lcQuery = "SELECT fpags FROM sigmvpar WITH(NOLOCK)" + ;
                        " WHERE empdopnums = " + ;
                        EscaparSQL(ALLTRIM(csDados.empdopnums)) + ;
                        " GROUP BY fpags"
                    IF SQLEXEC(gnConnHandle, loc_lcQuery, "crMvPar") >= 1
                        SELECT crMvPar
                        GO TOP
                        SCAN
                            REPLACE formasP WITH ALLTRIM(csDados.formasP) + ;
                                " " + ALLTRIM(crMvPar.fpags) IN csDados
                        ENDSCAN
                        USE IN crMvPar
                    ENDIF
                    SELECT csDados
                ENDSCAN

                *-- Cursor de trabalho: apenas registros a imprimir
                SELECT * FROM csDados WHERE imprime = "1" INTO CURSOR csRelatorio READWRITE

                *-- Preencher colunas de desconto (pdes01-pdes14) por tipo
                SELECT csRelatorio
                GO TOP
                SCAN
                    SELECT csDados
                    GO TOP
                    SCAN FOR csDados.chacab + csDados.chaitn + csDados.chaitd = ;
                             csRelatorio.chacab + csRelatorio.chaitn + csRelatorio.chaitd ;
                             AND NVL(csDados.tpdesc, 0) > 0
                        loc_lcPdes = "pDes" + PADL(ALLTRIM(STR(NVL(csDados.tpdesc, 1))), 2, "0")
                        loc_lcVdes = "vDes" + PADL(ALLTRIM(STR(NVL(csDados.tpdesc, 1))), 2, "0")
                        REPLACE &loc_lcPdes WITH csDados.pdes IN csRelatorio
                        REPLACE &loc_lcVdes WITH csDados.vdes IN csRelatorio
                    ENDSCAN
                    SELECT csRelatorio
                    loc_lnAlt = csRelatorio.pdes01 + csRelatorio.pdes02 + ;
                                csRelatorio.pdes03 + csRelatorio.pdes04 + ;
                                csRelatorio.pdes05 + csRelatorio.pdes06 + ;
                                csRelatorio.pdes07 + csRelatorio.pdes08 + ;
                                csRelatorio.pdes09 + csRelatorio.pdes10 + ;
                                csRelatorio.pdes11 + csRelatorio.pdes12 + ;
                                csRelatorio.pdes13 + csRelatorio.pdes14
                    REPLACE desct WITH IIF(csRelatorio.ValR = 0, 0, ;
                        ROUND((csRelatorio.ValR - csRelatorio.totas) / ;
                              NVL(csRelatorio.ValR, 1) * 100, 2)) ;
                        IN csRelatorio
                    loc_lnValRel = csRelatorio.vdes03 + csRelatorio.vdes04 + ;
                                   csRelatorio.vdes05 + csRelatorio.vdes06 + ;
                                   csRelatorio.vdes07 + csRelatorio.vdes08 + ;
                                   csRelatorio.vdes09 + csRelatorio.vdes10 + ;
                                   csRelatorio.vdes12 + csRelatorio.vdes13
                    REPLACE realizado WITH loc_lnValRel IN csRelatorio
                    loc_nVdestot = csRelatorio.vdes01 + csRelatorio.vdes02 + ;
                                   csRelatorio.vdes03 + csRelatorio.vdes04 + ;
                                   csRelatorio.vdes05 + csRelatorio.vdes06 + ;
                                   csRelatorio.vdes07 + csRelatorio.vdes08 + ;
                                   csRelatorio.vdes09 + csRelatorio.vdes10 + ;
                                   csRelatorio.vdes11 + csRelatorio.vdes12 + ;
                                   csRelatorio.vdes13 + csRelatorio.vdes14
                    REPLACE vdestot WITH loc_nVdestot IN csRelatorio
                ENDSCAN

                *-- Agrupa em csTmpRel
                IF loc_lnOpt = 1
                    *-- Detalhado: agrupa colapsando chaitd duplicados
                    SELECT datars, emps, dopes, numes, cpros, dpros, qtds, units, ;
                           unitorigs, totas, opers, repre, colecao, categoria, ;
                           empdopnums, chacab, chaitn, ;
                           MAX(chaitd) AS chaitd, formasp, imprime, lancamento, ;
                           MAX(ddesc) AS ddesc, SUM(pdes) AS pdes, SUM(vdes) AS vdes, ;
                           MAX(tpdesc) AS tpdesc, codigo, valcota, valr, desct, ;
                           realizado, ;
                           SUM(pdes01) AS pdes01, SUM(vdes01) AS vdes01, ;
                           SUM(pdes02) AS pdes02, SUM(vdes02) AS vdes02, ;
                           SUM(pdes03) AS pdes03, SUM(vdes03) AS vdes03, ;
                           SUM(pdes04) AS pdes04, SUM(vdes04) AS vdes04, ;
                           SUM(pdes05) AS pdes05, SUM(vdes05) AS vdes05, ;
                           SUM(pdes06) AS pdes06, SUM(vdes06) AS vdes06, ;
                           SUM(pdes07) AS pdes07, SUM(vdes07) AS vdes07, ;
                           SUM(pdes08) AS pdes08, SUM(vdes08) AS vdes08, ;
                           SUM(pdes09) AS pdes09, SUM(vdes09) AS vdes09, ;
                           SUM(pdes10) AS pdes10, SUM(vdes10) AS vdes10, ;
                           SUM(pdes11) AS pdes11, SUM(vdes11) AS vdes11, ;
                           SUM(pdes12) AS pdes12, SUM(vdes12) AS vdes12, ;
                           SUM(pdes13) AS pdes13, SUM(vdes13) AS vdes13, ;
                           SUM(pdes14) AS pdes14, SUM(vdes14) AS vdes14, ;
                           SUM(vdestot) AS vdestot ;
                           FROM csRelatorio ;
                           GROUP BY datars, emps, dopes, numes, cpros, dpros, qtds, ;
                                    units, unitorigs, totas, opers, repre, colecao, ;
                                    categoria, empdopnums, chacab, chaitn, formasp, ;
                                    imprime, lancamento, codigo, valcota, valr, ;
                                    desct, realizado ;
                           INTO CURSOR csTmpRel READWRITE
                ELSE
                    *-- Resumido: inclui chaitd no agrupamento
                    SELECT datars, emps, dopes, numes, cpros, dpros, qtds, units, ;
                           unitorigs, totas, opers, repre, colecao, categoria, ;
                           empdopnums, chacab, chaitn, chaitd, formasp, imprime, ;
                           lancamento, MAX(ddesc) AS ddesc, SUM(pdes) AS pdes, ;
                           SUM(vdes) AS vdes, MAX(tpdesc) AS tpdesc, codigo, ;
                           valcota, valr, desct, realizado, ;
                           SUM(pdes01) AS pdes01, SUM(vdes01) AS vdes01, ;
                           SUM(pdes02) AS pdes02, SUM(vdes02) AS vdes02, ;
                           SUM(pdes03) AS pdes03, SUM(vdes03) AS vdes03, ;
                           SUM(pdes04) AS pdes04, SUM(vdes04) AS vdes04, ;
                           SUM(pdes05) AS pdes05, SUM(vdes05) AS vdes05, ;
                           SUM(pdes06) AS pdes06, SUM(vdes06) AS vdes06, ;
                           SUM(pdes07) AS pdes07, SUM(vdes07) AS vdes07, ;
                           SUM(pdes08) AS pdes08, SUM(vdes08) AS vdes08, ;
                           SUM(pdes09) AS pdes09, SUM(vdes09) AS vdes09, ;
                           SUM(pdes10) AS pdes10, SUM(vdes10) AS vdes10, ;
                           SUM(pdes11) AS pdes11, SUM(vdes11) AS vdes11, ;
                           SUM(pdes12) AS pdes12, SUM(vdes12) AS vdes12, ;
                           SUM(pdes13) AS pdes13, SUM(vdes13) AS vdes13, ;
                           SUM(pdes14) AS pdes14, SUM(vdes14) AS vdes14, ;
                           SUM(vdestot) AS vdestot ;
                           FROM csRelatorio ;
                           GROUP BY datars, emps, dopes, numes, cpros, dpros, qtds, ;
                                    units, unitorigs, totas, opers, repre, colecao, ;
                                    categoria, empdopnums, chacab, chaitn, chaitd, ;
                                    formasp, imprime, lancamento, codigo, valcota, ;
                                    valr, desct, realizado ;
                           INTO CURSOR csTmpRel READWRITE
                ENDIF

                *-- Reconstruir csRelatorio a partir de csTmpRel
                ZAP IN csRelatorio
                SELECT * FROM csTmpRel INTO CURSOR csRelatorio READWRITE
                IF USED("csTmpRel")
                    USE IN csTmpRel
                ENDIF
                SELECT csRelatorio
                GO TOP

                *-- Visao Resumida: calculos de totais por empresa e vendedor
                IF loc_lnOpt <> 1
                    SELECT emps, SPACE(20) AS repre, MAX(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "1" AS tipo ;
                           FROM csRelatorio GROUP BY emps, codigo INTO CURSOR crAux2
                    SELECT emps, SPACE(20) AS repre, SUM(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "1" AS tipo ;
                           FROM crAux2 GROUP BY emps INTO CURSOR crAux2

                    SELECT emps, repre, MAX(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "2" AS tipo ;
                           FROM csRelatorio GROUP BY emps, repre, codigo ;
                           INTO CURSOR crAux1
                    SELECT emps, repre, MAX(valcota) AS valcota, ;
                           SUM(realizado) AS realizado, "2" AS tipo ;
                           FROM crAux1 GROUP BY emps, repre ;
                           INTO CURSOR crAux1 READWRITE
                    SELECT crAux1
                    DELETE ALL FOR EMPTY(repre)

                    SELECT * FROM crAux2 UNION (SELECT * FROM crAux1) INTO CURSOR crAux
                    SELECT emps, repre, valcota, ;
                           realizado AS realizadoV, ;
                           ROUND(realizado / NVL(valcota, 1) * 100, 2) AS realizadoP, ;
                           valcota - realizado AS saldoV, ;
                           ROUND((valcota - realizado) / NVL(valcota, 1) * 100, 2) AS saldoP, ;
                           tipo ;
                           FROM crAux INTO CURSOR csRelatorio ORDER BY 1
                    loc_lcCbTitulo = "Relatorio de cotas de Desconto - Resumido"
                ELSE
                    loc_lcCbTitulo = "Relatorio de cotas de Desconto - Detalhado"
                ENDIF

                *-- Cursor de cabecalho para o relatorio
                loc_lcCbPeriodo = "Per" + CHR(237) + "odo : " + ;
                    DTOC(THIS.this_dDtInicial) + " 00:00:00 - " + ;
                    DTOC(THIS.this_dDtFinal)   + " 23:59:59 "
                CREATE CURSOR csCabecalho (empresa c(240), titulo c(240), periodo c(80))
                INSERT INTO csCabecalho (empresa, titulo, periodo) ;
                    VALUES (loc_lcCbEmp, loc_lcCbTitulo, loc_lcCbPeriodo)

                SELECT csRelatorio
                GO TOP
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Processa e exibe relatorio em preview na tela
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOpcao = 1
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDes"
                ELSE
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDe1"
                ENDIF
                SELECT csRelatorio
                GO TOP
                REPORT FORM (loc_cFRX) PREVIEW
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Processa e envia relatorio para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso, loc_cFRX
        loc_lSucesso = .F.
        TRY
            IF THIS.PrepararDados()
                IF THIS.this_nOpcao = 1
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDes"
                ELSE
                    loc_cFRX = gc_4c_CaminhoReports + "SigReDe1"
                ENDIF
                SELECT csRelatorio
                GO TOP
                REPORT FORM (loc_cFRX) TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega valores de filtro a partir de um cursor
    * (snapshot de filtros - usado para reaproveitar filtros entre execucoes)
    * Equivalente a CarregarDoCursor de BOs CRUD, adaptado para relatorio.
    * par_cAliasCursor : nome do cursor com campos identicos as propriedades
    *                    de filtro do BO (cEmpresa, dDtInicial, etc.)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_cAlias, loc_aFields(1), loc_nFlds, loc_nI, loc_cFld
        loc_lSucesso = .F.
        TRY
            loc_cAlias = par_cAliasCursor
            IF EMPTY(loc_cAlias) OR !USED(loc_cAlias)
                THIS.this_cMensagemErro = "Cursor de filtros n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                loc_lSucesso = .F.
            ENDIF

            SELECT (loc_cAlias)
            IF EOF() OR BOF()
                THIS.this_cMensagemErro = "Cursor de filtros vazio"
                loc_lSucesso = .F.
            ENDIF

            *-- Mapear apenas os campos efetivamente presentes no cursor
            loc_nFlds = AFIELDS(loc_aFields, loc_cAlias)
            FOR loc_nI = 1 TO loc_nFlds
                loc_cFld = UPPER(ALLTRIM(loc_aFields(loc_nI, 1)))
                DO CASE
                    CASE loc_cFld == "CEMPRESA"
                        THIS.this_cEmpresa    = TratarNulo(EVALUATE(loc_cAlias + ".cEmpresa"),    "C")
                    CASE loc_cFld == "CDESEMPRESA"
                        THIS.this_cDesEmpresa = TratarNulo(EVALUATE(loc_cAlias + ".cDesEmpresa"), "C")
                    CASE loc_cFld == "DDTINICIAL"
                        THIS.this_dDtInicial  = TratarNulo(EVALUATE(loc_cAlias + ".dDtInicial"),  "D")
                    CASE loc_cFld == "DDTFINAL"
                        THIS.this_dDtFinal    = TratarNulo(EVALUATE(loc_cAlias + ".dDtFinal"),    "D")
                    CASE loc_cFld == "CCGRU"
                        THIS.this_cCGru       = TratarNulo(EVALUATE(loc_cAlias + ".cCGru"),       "C")
                    CASE loc_cFld == "CDGRU"
                        THIS.this_cDGru       = TratarNulo(EVALUATE(loc_cAlias + ".cDGru"),       "C")
                    CASE loc_cFld == "CVEND"
                        THIS.this_cVend       = TratarNulo(EVALUATE(loc_cAlias + ".cVend"),       "C")
                    CASE loc_cFld == "CDVEND"
                        THIS.this_cDVend      = TratarNulo(EVALUATE(loc_cAlias + ".cDVend"),      "C")
                    CASE loc_cFld == "CCATE"
                        THIS.this_cCate       = TratarNulo(EVALUATE(loc_cAlias + ".cCate"),       "C")
                    CASE loc_cFld == "CCATED"
                        THIS.this_cCateD      = TratarNulo(EVALUATE(loc_cAlias + ".cCateD"),      "C")
                    CASE loc_cFld == "CCOLE"
                        THIS.this_cCole       = TratarNulo(EVALUATE(loc_cAlias + ".cCole"),       "C")
                    CASE loc_cFld == "CCOLED"
                        THIS.this_cColeD      = TratarNulo(EVALUATE(loc_cAlias + ".cColeD"),      "C")
                    CASE loc_cFld == "CPROD"
                        THIS.this_cProd       = TratarNulo(EVALUATE(loc_cAlias + ".cProd"),       "C")
                    CASE loc_cFld == "CPRODD"
                        THIS.this_cProdD      = TratarNulo(EVALUATE(loc_cAlias + ".cProdD"),      "C")
                    CASE loc_cFld == "NOPCAO"
                        THIS.this_nOpcao      = TratarNulo(EVALUATE(loc_cAlias + ".nOpcao"),      "N")
                    CASE loc_cFld == "NDESC"
                        THIS.this_nDesc       = TratarNulo(EVALUATE(loc_cAlias + ".nDesc"),       "N")
                    CASE loc_cFld == "NLANC"
                        THIS.this_nLanc       = TratarNulo(EVALUATE(loc_cAlias + ".nLanc"),       "N")
                ENDCASE
            ENDFOR

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Relatorio nao suporta operacoes de insercao de dados
    * Mantido por contrato com BusinessBase mas registra auditoria da execucao
    * do relatorio (que e a unica operacao "de escrita" relevante para reports)
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            *-- Reports nao inserem registros de negocio. A unica acao registrada
            *-- e a auditoria da execucao do relatorio em si.
            THIS.RegistrarAuditoria("EXECUCAO_RELATORIO")
            THIS.this_cMensagemErro = "Relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o suporta opera" + CHR(231) + CHR(245) + "es de inser" + ;
                CHR(231) + CHR(227) + "o"
            loc_lSucesso = .F.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Relatorio nao suporta operacoes de atualizacao de dados
    * Mantido por contrato com BusinessBase. Reports sao read-only.
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            THIS.this_cMensagemErro = "Relat" + CHR(243) + "rio n" + CHR(227) + ;
                "o suporta opera" + CHR(231) + CHR(245) + "es de atualiza" + ;
                CHR(231) + CHR(227) + "o"
            loc_lSucesso = .F.
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra execucao do relatorio em LogAuditoria
    * Operacao tipica: "EXECUCAO_RELATORIO"
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cUsuario, loc_cDetalhe, loc_nResult
        loc_lSucesso = .F.
        TRY
            IF TYPE("gnConnHandle") <> "N" OR gnConnHandle < 1
                loc_lSucesso = .F.
            ENDIF

            loc_cUsuario = IIF(TYPE("gc_4c_UsuarioLogado") = "C", gc_4c_UsuarioLogado, "")
            loc_cDetalhe = "SIGREDES " + ALLTRIM(par_cOperacao) + ;
                " | Per" + CHR(237) + "odo " + DTOC(THIS.this_dDtInicial) + ;
                " - " + DTOC(THIS.this_dDtFinal) + ;
                " | Empresa " + ALLTRIM(THIS.this_cEmpresa) + ;
                " | Vend " + ALLTRIM(THIS.this_cVend) + ;
                " | Visao " + IIF(THIS.this_nOpcao = 1, "Detalhada", "Resumida")

            loc_cSQL = "INSERT INTO LogAuditoria (Tabela, Operacao, Usuario, DataHora, Detalhe) " + ;
                "VALUES (" + EscaparSQL("SIGREDES") + ", " + ;
                EscaparSQL(ALLTRIM(par_cOperacao)) + ", " + ;
                EscaparSQL(loc_cUsuario) + ", " + ;
                FormatarDataSQL(DATETIME()) + ", " + ;
                EscaparSQL(loc_cDetalhe) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResult >= 0)
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Fecha todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursores(15), loc_nI
        loc_aCursores(1)  = THIS.this_cCursorDados
        loc_aCursores(2)  = THIS.this_cCursorRelatorio
        loc_aCursores(3)  = THIS.this_cCursorOpFp
        loc_aCursores(4)  = "cursor_4c_OpFp_tmp"
        loc_aCursores(5)  = "csDados1"
        loc_aCursores(6)  = "csTmpRel"
        loc_aCursores(7)  = "csRelatorio"
        loc_aCursores(8)  = "crAux"
        loc_aCursores(9)  = "crAux1"
        loc_aCursores(10) = "crAux2"
        loc_aCursores(11) = "crProd"
        loc_aCursores(12) = "crMvPar"
        loc_aCursores(13) = "csCabecalho"
        loc_aCursores(14) = "cursor_4c_EmpCab"
        loc_aCursores(15) = "csDados"

        FOR loc_nI = 1 TO 15
            IF !EMPTY(loc_aCursores(loc_nI)) AND USED(loc_aCursores(loc_nI))
                USE IN (loc_aCursores(loc_nI))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

