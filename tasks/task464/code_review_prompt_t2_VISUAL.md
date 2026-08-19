# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [LAYOUT-POSITION] Controle 'COTACAO' (parent: SIGCDMOE.Pagina.Lista): Top original=5 vs migrado 'chk_4c_Cotacao' Top=144 (diff=139px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMoe.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1683 linhas total):

*-- Linhas 50 a 59:
50:             ELSE
51:                 THIS.ConfigurarPageFrame()
52: 
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55: 
56:                 THIS.pgf_4c_Paginas.Visible   = .T.
57:                 THIS.pgf_4c_Paginas.ActivePage = 1
58:                 THIS.this_cModoAtual = "LISTA"
59: 

*-- Linhas 80 a 99:
80: 
81:         WITH THIS.pgf_4c_Paginas
82:             .PageCount = 2
83:             .Top       = -29
84:             .Left      = 0
85:             .Width     = THIS.Width
86:             .Height    = THIS.Height + 29
87:             .Tabs      = .F.
88:             .Visible   = .T.
89: 
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93: 
94:             .Page2.Caption   = "Dados"
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.BackColor = RGB(255, 255, 255)
97:         ENDWITH
98: 
99:         THIS.ConfigurarPaginaLista()

*-- Linhas 111 a 181:
111:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112: 
113:         *-- Container Cabecalho (cntSombra no legado)
114:         *-- Original: cntSombra.Top=1. Com compensacao PageFrame +29: Top=30
115:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
116:         WITH loc_oPagina.cnt_4c_Cabecalho
117:             .Top         = 30
118:             .Left        = 0
119:             .Width       = THIS.Width
120:             .Height      = 80
121:             .BackColor   = RGB(100, 100, 100)
122:             .BorderWidth = 0
123:             .Visible     = .T.
124:         ENDWITH
125: 
126:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
127:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
128:             .Caption   = "Cadastro de Moedas"
129:             .Top       = 15
130:             .Left      = 10
131:             .Width     = THIS.Width - 20
132:             .Height    = 46
133:             .FontName  = "Tahoma"
134:             .FontSize  = 16
135:             .FontBold  = .T.
136:             .ForeColor = RGB(0, 0, 0)
137:             .BackStyle = 0
138:             .AutoSize  = .F.
139:             .Visible   = .T.
140:         ENDWITH
141: 
142:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
143:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
144:             .Caption   = "Cadastro de Moedas"
145:             .Top       = 18
146:             .Left      = 10
147:             .Width     = THIS.Width - 20
148:             .Height    = 46
149:             .FontName  = "Tahoma"
150:             .FontSize  = 16
151:             .FontBold  = .T.
152:             .ForeColor = RGB(255, 255, 255)
153:             .BackStyle = 0
154:             .AutoSize  = .F.
155:             .Visible   = .T.
156:         ENDWITH
157: 
158:         *-- Container botoes CRUD (Grupo_op no legado)
159:         *-- Original: Grupo_op.Top=0. Com compensacao +29: Top=29; Left canonico: 542
160:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
161:         WITH loc_oPagina.cnt_4c_Botoes
162:             .Top         = 29
163:             .Left        = 542
164:             .Width       = 390
165:             .Height      = 85
166:             .BackColor   = RGB(100, 100, 100)
167:             .BackStyle = 0
168:             .BorderWidth = 0
169:             .Visible     = .T.
170:         ENDWITH
171: 
172:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
173:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
174:             .Caption         = "Incluir"
175:             .Top             = 5
176:             .Left            = 5
177:             .Width           = 75
178:             .Height          = 75
179:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:             .PicturePosition = 13
181:             .FontName        = "Tahoma"

*-- Linhas 192 a 204:
192:             .Visible         = .T.
193:         ENDWITH
194: 
195:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
196:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
197:             .Caption         = "Visualizar"
198:             .Top             = 5
199:             .Left            = 80
200:             .Width           = 75
201:             .Height          = 75
202:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:             .PicturePosition = 13
204:             .FontName        = "Tahoma"

*-- Linhas 215 a 227:
215:             .Visible         = .T.
216:         ENDWITH
217: 
218:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
219:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
220:             .Caption         = "Alterar"
221:             .Top             = 5
222:             .Left            = 155
223:             .Width           = 75
224:             .Height          = 75
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:             .PicturePosition = 13
227:             .FontName        = "Tahoma"

*-- Linhas 238 a 250:
238:             .Visible         = .T.
239:         ENDWITH
240: 
241:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
242:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
243:             .Caption         = "Excluir"
244:             .Top             = 5
245:             .Left            = 230
246:             .Width           = 75
247:             .Height          = 75
248:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
249:             .PicturePosition = 13
250:             .FontName        = "Tahoma"

*-- Linhas 261 a 273:
261:             .Visible         = .T.
262:         ENDWITH
263: 
264:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
265:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
266:             .Caption         = "Buscar"
267:             .Top             = 5
268:             .Left            = 305
269:             .Width           = 75
270:             .Height          = 75
271:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
272:             .PicturePosition = 13
273:             .FontName        = "Tahoma"

*-- Linhas 288 a 309:
288:         *-- Transparente sobre a Page; Page.Width NAO subtrai espaco por este container
289:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
290:         WITH loc_oPagina.cnt_4c_Saida
291:             .Top         = 29
292:             .Left        = 917
293:             .Width       = 90
294:             .Height      = 85
295:             .BackStyle   = 0
296:             .BorderWidth = 0
297:             .Visible     = .T.
298:         ENDWITH
299: 
300:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
301:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
302:             .Caption         = "Encerrar"
303:             .Top             = 5
304:             .Left            = 5
305:             .Width           = 75
306:             .Height          = 75
307:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
308:             .PicturePosition = 13
309:             .FontName        = "Tahoma"

*-- Linhas 322 a 336:
322: 
323:         *-- Botao Cambio (COTACAO no legado) - especifico deste form para cotacoes
324:         *-- Original: Top=5, Left=296. Com compensacao +29: Top=34
325:         loc_oPagina.AddObject("cmd_4c_Cambio", "CommandButton")
326:         WITH loc_oPagina.cmd_4c_Cambio
327:             .Caption         = "\<C" + CHR(226) + "mbio"
328:             .Picture         = gc_4c_CaminhoIcones + "geral_cambio_60.jpg"
329:             .PicturePosition = 13
330:             .Top             = 34
331:             .Left            = 296
332:             .Width           = 75
333:             .Height          = 75
334:             .FontName        = "Tahoma"
335:             .FontSize        = 8
336:             .FontBold        = .T.

*-- Linhas 346 a 358:
346:         ENDWITH
347: 
348:         *-- Grid de lista (Grade no legado)
349:         *-- Original: Grade.Top=88. Com compensacao +29: Top=117
350:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
351:         WITH loc_oPagina.grd_4c_Lista
352:             .Top                = 117
353:             .Left               = 12
354:             .Width              = 895
355:             .Height             = 455
356:             .FontName           = "Verdana"
357:             .FontSize           = 8
358:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 374 a 402:
374:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
375: 
376:         WITH loc_oPagina.grd_4c_Lista
377:             .Column1.Header1.Caption = "Moeda"
378:             .Column1.Width           = 120
379:             .Column1.Alignment       = 0
380: 
381:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
382:             .Column2.Width           = 330
383:             .Column2.Alignment       = 0
384: 
385:             .Column3.Header1.Caption = "Ordem de Impress" + CHR(227) + "o"
386:             .Column3.Width           = 129
387:             .Column3.Alignment       = 1
388:         ENDWITH
389: 
390:         *-- BINDEVENTs - metodos devem ser PUBLIC (sem PROTECTED) para funcionar
391:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
392:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
393:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
394:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
395:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
396:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
397:         BINDEVENT(loc_oPagina.cmd_4c_Cambio,                   "Click", THIS, "BtnCambioClick")
398: 
399:         THIS.TornarControlesVisiveis(loc_oPagina)
400:     ENDPROC
401: 
402:     *==========================================================================

*-- Linhas 413 a 438:
413:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
414: 
415:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
416:         *-- Original: Grupo_Salva.Top=16, Left=619. Compensacao +29: Top=45
417:         *-- Left canonico do framework: 842 (form Width=1000)
418:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
419:         WITH loc_oPagina.cnt_4c_Salva
420:             .Top         = 45
421:             .Left        = 842
422:             .Width       = 160
423:             .Height      = 85
424:             .BackStyle = 1
425:             .BackColor = RGB(255, 255, 255)
426:             .Visible     = .T.
427:         ENDWITH
428: 
429:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
430:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
431:             .Caption         = "Confirmar"
432:             .Top             = 5
433:             .Left            = 5
434:             .Width           = 75
435:             .Height          = 75
436:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
437:             .PicturePosition = 13
438:             .FontName        = "Tahoma"

*-- Linhas 449 a 461:
449:             .Visible         = .T.
450:         ENDWITH
451: 
452:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
453:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
454:             .Caption         = "Encerrar"
455:             .Top             = 5
456:             .Left            = 80
457:             .Width           = 75
458:             .Height          = 75
459:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
460:             .PicturePosition = 13
461:             .FontName        = "Tahoma"

*-- Linhas 474 a 486:
474: 
475:         *-- GRUPO 1: Codigo e Descricao
476:         *-- Say1 "Código :" - Original Top=66, +29=95, Left=298, Width=42, Height=15
477:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
478:         WITH loc_oPagina.lbl_4c_Label1
479:             .Caption    = "C" + CHR(243) + "digo :"
480:             .Top        = 95
481:             .Left       = 298
482:             .Width      = 42
483:             .Height     = 15
484:             .FontName   = "Tahoma"
485:             .FontSize   = 8
486:             .FontBold   = .F.

*-- Linhas 496 a 520:
496:         loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
497:         WITH loc_oPagina.txt_4c_Moeda
498:             .Value      = ""
499:             .Top        = 90
500:             .Left       = 347
501:             .Width      = 31
502:             .Height     = 23
503:             .FontName   = "Courier New"
504:             .FontSize   = 8
505:             .FontItalic = .F.
506:             .MaxLength  = 3
507:             .Visible    = .T.
508:         ENDWITH
509: 
510:         *-- Say2 "Descrição :" - Original Top=92, +29=121, Left=285
511:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
512:         WITH loc_oPagina.lbl_4c_Label2
513:             .Caption    = "Descri" + CHR(231) + CHR(227) + "o :"
514:             .Top        = 121
515:             .Left       = 285
516:             .Width      = 60
517:             .Height     = 15
518:             .FontName   = "Tahoma"
519:             .FontSize   = 8
520:             .FontBold   = .F.

*-- Linhas 529 a 555:
529:         loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
530:         WITH loc_oPagina.txt_4c_Descricao
531:             .Value      = ""
532:             .Top        = 116
533:             .Left       = 347
534:             .Width      = 115
535:             .Height     = 23
536:             .FontName   = "Tahoma"
537:             .FontSize   = 8
538:             .FontItalic = .F.
539:             .MaxLength  = 15
540:             .Visible    = .T.
541:         ENDWITH
542: 
543:         *-- GRUPO 2: Cotacao (checkbox)
544:         *-- fwcheckbox_cotacao - Original Top=115, +29=144, Left=295, Width=65, Height=15
545:         loc_oPagina.AddObject("chk_4c_Cotacao", "CheckBox")
546:         WITH loc_oPagina.chk_4c_Cotacao
547:             .Caption    = "Cota" + CHR(231) + CHR(227) + "o :"
548:             .Value      = 0
549:             .Top        = 144
550:             .Left       = 295
551:             .Width      = 65
552:             .Height     = 15
553:             .FontName   = "Tahoma"
554:             .FontSize   = 8
555:             .FontItalic = .F.

*-- Linhas 562 a 574:
562: 
563:         *-- GRUPO 3: Fator Multiplicador (N/S)
564:         *-- Say3 - Original Top=139, +29=168, Left=243
565:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
566:         WITH loc_oPagina.lbl_4c_Label3
567:             .Caption    = "Fator Multiplicador :"
568:             .Top        = 168
569:             .Left       = 243
570:             .Width      = 100
571:             .Height     = 15
572:             .FontName   = "Tahoma"
573:             .FontSize   = 8
574:             .FontBold   = .F.

*-- Linhas 584 a 593:
584:         loc_oPagina.AddObject("txt_4c_Fmult", "TextBox")
585:         WITH loc_oPagina.txt_4c_Fmult
586:             .Value      = ""
587:             .Top        = 163
588:             .Left       = 347
589:             .Width      = 20
590:             .Height     = 23
591:             .FontName   = "Tahoma"
592:             .FontSize   = 8
593:             .FontItalic = .F.

*-- Linhas 600 a 609:
600:         loc_oPagina.AddObject("obj_4c_SpnNordrels", "Spinner")
601:         WITH loc_oPagina.obj_4c_SpnNordrels
602:             .Value             = 0
603:             .Top               = 189
604:             .Left              = 347
605:             .Width             = 33
606:             .Height            = 25
607:             .FontName          = "Courier New"
608:             .FontSize          = 8
609:             .InputMask         = "9"

*-- Linhas 615 a 627:
615:         ENDWITH
616: 
617:         *-- Say4 "Nº da Coluna nos Relatórios :" - Original Top=165, +29=194, Left=197
618:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
619:         WITH loc_oPagina.lbl_4c_Label4
620:             .Caption    = "N" + CHR(186) + " da Coluna nos Relat" + CHR(243) + "rios :"
621:             .Top        = 194
622:             .Left       = 197
623:             .Width      = 145
624:             .Height     = 15
625:             .FontName   = "Tahoma"
626:             .FontSize   = 8
627:             .FontBold   = .F.

*-- Linhas 634 a 646:
634: 
635:         *-- GRUPO 5: Moeda Equivalente e Quantidade de Conversao
636:         *-- Say8 "Moeda Equivalente :" - Original Top=192, +29=221, Left=240, Width=100, Height=15
637:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
638:         WITH loc_oPagina.lbl_4c_Label8
639:             .Caption    = "Moeda Equivalente :"
640:             .Top        = 221
641:             .Left       = 240
642:             .Width      = 100
643:             .Height     = 15
644:             .FontName   = "Tahoma"
645:             .FontSize   = 8
646:             .FontBold   = .F.

*-- Linhas 656 a 680:
656:         loc_oPagina.AddObject("txt_4c_MoeEq", "TextBox")
657:         WITH loc_oPagina.txt_4c_MoeEq
658:             .Value      = ""
659:             .Top        = 217
660:             .Left       = 347
661:             .Width      = 31
662:             .Height     = 23
663:             .FontName   = "Courier New"
664:             .FontSize   = 8
665:             .FontItalic = .F.
666:             .MaxLength  = 3
667:             .Visible    = .T.
668:         ENDWITH
669: 
670:         *-- Say9 "Qtde: " - Original Top=192, +29=221, Left=386, Width=33, Height=15
671:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
672:         WITH loc_oPagina.lbl_4c_Label9
673:             .Caption    = "Qtde: "
674:             .Top        = 221
675:             .Left       = 386
676:             .Width      = 33
677:             .Height     = 15
678:             .FontName   = "Tahoma"
679:             .FontSize   = 8
680:             .FontBold   = .F.

*-- Linhas 690 a 716:
690:         loc_oPagina.AddObject("txt_4c_Qtde", "TextBox")
691:         WITH loc_oPagina.txt_4c_Qtde
692:             .Value      = 0
693:             .Top        = 217
694:             .Left       = 421
695:             .Width      = 92
696:             .Height     = 23
697:             .FontName   = "Courier New"
698:             .FontSize   = 8
699:             .FontItalic = .F.
700:             .InputMask  = "999999.999999"
701:             .Visible    = .T.
702:         ENDWITH
703: 
704:         *-- GRUPO 6: Imprime Tabela Referencia
705:         *-- fwcheckbox_tabref - Original Top=216, +29=245, Left=156, Width=205, Height=17
706:         loc_oPagina.AddObject("chk_4c_Tabref", "CheckBox")
707:         WITH loc_oPagina.chk_4c_Tabref
708:             .Caption    = "Imprime Tabela Refer" + CHR(234) + "ncia :"
709:             .Value      = 0
710:             .Top        = 245
711:             .Left       = 156
712:             .Width      = 205
713:             .Height     = 17
714:             .FontName   = "Tahoma"
715:             .FontSize   = 8
716:             .FontItalic = .F.

*-- Linhas 723 a 735:
723: 
724:         *-- GRUPO 7: Cond.Pagto Automatica (GET_FPG) - lookup SigOpFp
725:         *-- Say13 "Cond.Pagto Automática :" - Original Top=242, +29=271, Left=217
726:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
727:         WITH loc_oPagina.lbl_4c_Label13
728:             .Caption    = "Cond.Pagto Autom" + CHR(225) + "tica :"
729:             .Top        = 271
730:             .Left       = 217
731:             .Width      = 120
732:             .Height     = 15
733:             .FontName   = "Tahoma"
734:             .FontSize   = 8
735:             .FontBold   = .F.

*-- Linhas 745 a 770:
745:         loc_oPagina.AddObject("txt_4c_FPG", "TextBox")
746:         WITH loc_oPagina.txt_4c_FPG
747:             .Value      = ""
748:             .Top        = 267
749:             .Left       = 348
750:             .Width      = 94
751:             .Height     = 23
752:             .FontName   = "Tahoma"
753:             .FontSize   = 8
754:             .FontItalic = .F.
755:             .MaxLength  = 12
756:             .Visible    = .T.
757:         ENDWITH
758: 
759:         *-- GRUPO 8: Tolerancia Conversao
760:         *-- Say14 "Tolerância Conversão :" - Original Top=268, +29=297, Left=227, Width=113
761:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
762:         WITH loc_oPagina.lbl_4c_Label14
763:             .Caption    = "Toler" + CHR(226) + "ncia Convers" + CHR(227) + "o :"
764:             .Top        = 297
765:             .Left       = 227
766:             .Width      = 113
767:             .Height     = 15
768:             .FontName   = "Tahoma"
769:             .FontSize   = 8
770:             .FontBold   = .F.

*-- Linhas 779 a 804:
779:         loc_oPagina.AddObject("txt_4c_Toleras", "TextBox")
780:         WITH loc_oPagina.txt_4c_Toleras
781:             .Value      = 0
782:             .Top        = 293
783:             .Left       = 348
784:             .Width      = 45
785:             .Height     = 23
786:             .FontName   = "Courier New"
787:             .FontSize   = 8
788:             .FontItalic = .F.
789:             .InputMask  = "99.99"
790:             .Visible    = .T.
791:         ENDWITH
792: 
793:         *-- GRUPO 9: Listar na consulta (OptionGroup - Consultas)
794:         *-- Say15 "Listar na consulta :" - Original Top=293, +29=322, Left=247, Width=93
795:         loc_oPagina.AddObject("lbl_4c_Label15", "Label")
796:         WITH loc_oPagina.lbl_4c_Label15
797:             .Caption    = "Listar na consulta :"
798:             .Top        = 322
799:             .Left       = 247
800:             .Width      = 93
801:             .Height     = 15
802:             .FontName   = "Tahoma"
803:             .FontSize   = 8
804:             .FontBold   = .F.

*-- Linhas 814 a 847:
814:         loc_oPagina.AddObject("obj_4c_OptTipo", "OptionGroup")
815:         WITH loc_oPagina.obj_4c_OptTipo
816:             .ButtonCount = 2
817:             .Top         = 317
818:             .Left        = 343
819:             .Width       = 109
820:             .Height      = 25
821:             .AutoSize    = .T.
822:             .BackStyle   = 0
823:             .BorderStyle = 0
824:             .Value       = 1
825:             .Visible     = .T.
826:         ENDWITH
827:         WITH loc_oPagina.obj_4c_OptTipo.Buttons(1)
828:             .Caption   = "Sim"
829:             .Left      = 5
830:             .Top       = 5
831:             .Width     = 34
832:             .Height    = 15
833:             .AutoSize  = .T.
834:             .FontName  = "Tahoma"
835:             .FontSize  = 8
836:             .BackStyle = 0
837:             .ForeColor = RGB(90, 90, 90)
838:         ENDWITH
839:         WITH loc_oPagina.obj_4c_OptTipo.Buttons(2)
840:             .Caption   = "N" + CHR(227) + "o"
841:             .Left      = 62
842:             .Top       = 5
843:             .Width     = 37
844:             .Height    = 15
845:             .AutoSize  = .T.
846:             .FontName  = "Tahoma"
847:             .FontSize  = 8

*-- Linhas 853 a 878:
853:         *-- Shape2 separador - Original Top=352, +29=381, Left=150, Width=367, Height=2
854:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
855:         WITH loc_oPagina.shp_4c_Shape2
856:             .Top           = 381
857:             .Left          = 150
858:             .Width         = 367
859:             .Height        = 2
860:             .BackStyle     = 0
861:             .BorderStyle   = 1
862:             .BorderWidth   = 2
863:             .SpecialEffect = 0
864:             .BorderColor   = RGB(90, 90, 90)
865:             .Visible       = .T.
866:         ENDWITH
867: 
868:         *-- Say7 "Preço na Etiqueta do Produto" - Original Top=335, +29=364, Left=150
869:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
870:         WITH loc_oPagina.lbl_4c_Label7
871:             .Caption    = "Pre" + CHR(231) + "o na Etiqueta do Produto"
872:             .Top        = 364
873:             .Left       = 150
874:             .Width      = 200
875:             .Height     = 15
876:             .FontName   = "Tahoma"
877:             .FontSize   = 8
878:             .FontBold   = .T.

*-- Linhas 884 a 896:
884:         ENDWITH
885: 
886:         *-- Say5 "Codifica na Etiqueta do Produto :" - Original Top=364, +29=393, Left=166
887:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
888:         WITH loc_oPagina.lbl_4c_Label5
889:             .Caption    = "Codifica na Etiqueta do Produto :"
890:             .Top        = 393
891:             .Left       = 166
892:             .Width      = 175
893:             .Height     = 15
894:             .FontName   = "Tahoma"
895:             .FontSize   = 8
896:             .FontBold   = .F.

*-- Linhas 906 a 930:
906:         loc_oPagina.AddObject("txt_4c_DisfPres", "TextBox")
907:         WITH loc_oPagina.txt_4c_DisfPres
908:             .Value      = ""
909:             .Top        = 388
910:             .Left       = 347
911:             .Width      = 20
912:             .Height     = 23
913:             .FontName   = "Tahoma"
914:             .FontSize   = 8
915:             .FontItalic = .F.
916:             .InputMask  = "N,S,A,P"
917:             .Visible    = .T.
918:         ENDWITH
919: 
920:         *-- Say6 "Valor Adicional :" - Original Top=389, +29=418, Left=249
921:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
922:         WITH loc_oPagina.lbl_4c_Label6
923:             .Caption    = "Valor Adicional :"
924:             .Top        = 418
925:             .Left       = 249
926:             .Width      = 90
927:             .Height     = 15
928:             .FontName   = "Tahoma"
929:             .FontSize   = 8
930:             .FontBold   = .F.

*-- Linhas 940 a 949:
940:         loc_oPagina.AddObject("txt_4c_ValAdics", "TextBox")
941:         WITH loc_oPagina.txt_4c_ValAdics
942:             .Value      = 0
943:             .Top        = 414
944:             .Left       = 347
945:             .Width      = 31
946:             .Height     = 23
947:             .FontName   = "Courier New"
948:             .FontSize   = 8
949:             .FontItalic = .F.

*-- Linhas 955 a 980:
955:         *-- Shape3 separador - Original Top=438, +29=467, Left=150, Width=367, Height=2
956:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
957:         WITH loc_oPagina.shp_4c_Shape3
958:             .Top           = 467
959:             .Left          = 150
960:             .Width         = 367
961:             .Height        = 2
962:             .BackStyle     = 0
963:             .BorderStyle   = 1
964:             .BorderWidth   = 2
965:             .SpecialEffect = 0
966:             .BorderColor   = RGB(90, 90, 90)
967:             .Visible       = .T.
968:         ENDWITH
969: 
970:         *-- Say11 "Valorização do Estoque" - Original Top=422, +29=451, Left=150
971:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
972:         WITH loc_oPagina.lbl_4c_Label11
973:             .Caption    = "Valoriza" + CHR(231) + CHR(227) + "o do Estoque"
974:             .Top        = 451
975:             .Left       = 150
976:             .Width      = 200
977:             .Height     = 15
978:             .FontName   = "Tahoma"
979:             .FontSize   = 8
980:             .FontBold   = .T.

*-- Linhas 986 a 998:
986:         ENDWITH
987: 
988:         *-- Say12 "Grupo :" - Original Top=449, +29=478, Left=299
989:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
990:         WITH loc_oPagina.lbl_4c_Label12
991:             .Caption    = "Grupo :"
992:             .Top        = 478
993:             .Left       = 299
994:             .Width      = 45
995:             .Height     = 15
996:             .FontName   = "Tahoma"
997:             .FontSize   = 8
998:             .FontBold   = .F.

*-- Linhas 1007 a 1031:
1007:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
1008:         WITH loc_oPagina.txt_4c_Grupo
1009:             .Value      = ""
1010:             .Top        = 474
1011:             .Left       = 347
1012:             .Width      = 80
1013:             .Height     = 23
1014:             .FontName   = "Tahoma"
1015:             .FontSize   = 8
1016:             .FontItalic = .F.
1017:             .MaxLength  = 10
1018:             .Visible    = .T.
1019:         ENDWITH
1020: 
1021:         *-- Say10 "Sub-Grupo :" - Original Top=475, +29=504, Left=277
1022:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
1023:         WITH loc_oPagina.lbl_4c_Label10
1024:             .Caption    = "Sub-Grupo :"
1025:             .Top        = 504
1026:             .Left       = 277
1027:             .Width      = 65
1028:             .Height     = 15
1029:             .FontName   = "Tahoma"
1030:             .FontSize   = 8
1031:             .FontBold   = .F.

*-- Linhas 1040 a 1061:
1040:         loc_oPagina.AddObject("txt_4c_Subg", "TextBox")
1041:         WITH loc_oPagina.txt_4c_Subg
1042:             .Value      = ""
1043:             .Top        = 500
1044:             .Left       = 347
1045:             .Width      = 80
1046:             .Height     = 23
1047:             .FontName   = "Tahoma"
1048:             .FontSize   = 8
1049:             .FontItalic = .F.
1050:             .MaxLength  = 10
1051:             .Visible    = .T.
1052:         ENDWITH
1053: 
1054:         *-- BINDEVENTs para Page2 - metodos PUBLIC (sem PROTECTED) para funcionar com BINDEVENT
1055:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click",     THIS, "BtnSalvarClick")
1056:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click",     THIS, "BtnCancelarClick")
1057:         BINDEVENT(loc_oPagina.txt_4c_MoeEq,                  "KeyPress", THIS, "ValidarMoeEq")
1058:         BINDEVENT(loc_oPagina.txt_4c_FPG,                    "KeyPress", THIS, "ValidarFpag")
1059:         BINDEVENT(loc_oPagina.txt_4c_FPG,                    "KeyPress",  THIS, "FpgKeyPress")
1060:         BINDEVENT(loc_oPagina.txt_4c_ValAdics,               "KeyPress", THIS, "ValidarValAdics")
1061: 

*-- Linhas 1171 a 1181:
1171:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.nordrels"
1172: 
1173:                     *-- Reconfigurar headers apos RecordSource (RecordSource reseta captions)
1174:                     loc_oGrid.Column1.Header1.Caption = "Moeda"
1175:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1176:                     loc_oGrid.Column3.Header1.Caption = "Ordem de Impress" + CHR(227) + "o"
1177: 
1178:                     loc_oGrid.Column1.Width = 120
1179:                     loc_oGrid.Column2.Width = 330
1180:                     loc_oGrid.Column3.Width = 129
1181: 

*-- Linhas 1599 a 1617:
1599:         WITH THIS.this_oBusinessObject
1600:             loc_oPg2.txt_4c_Moeda.Value          = ALLTRIM(.this_cCodigo)
1601:             loc_oPg2.txt_4c_Descricao.Value       = ALLTRIM(.this_cDescricao)
1602:             loc_oPg2.chk_4c_Cotacao.Value         = .this_lCotas
1603:             loc_oPg2.txt_4c_Fmult.Value           = ALLTRIM(.this_cFmults)
1604:             loc_oPg2.obj_4c_SpnNordrels.Value     = .this_nNordrels
1605:             loc_oPg2.txt_4c_MoeEq.Value           = ALLTRIM(.this_cMoeqs)
1606:             loc_oPg2.txt_4c_Qtde.Value            = .this_nQtdeqs
1607:             loc_oPg2.chk_4c_Tabref.Value          = .this_lTabrefs
1608:             loc_oPg2.txt_4c_FPG.Value             = ALLTRIM(.this_cFpags)
1609:             loc_oPg2.txt_4c_Toleras.Value         = .this_nToleras
1610:             loc_oPg2.obj_4c_OptTipo.Value         = IIF(.this_nConsultas >= 1 AND .this_nConsultas <= 2, .this_nConsultas, 1)
1611:             loc_oPg2.txt_4c_DisfPres.Value        = ALLTRIM(.this_cDisfpres)
1612:             loc_oPg2.txt_4c_ValAdics.Value        = .this_nValadics
1613:             loc_oPg2.txt_4c_Grupo.Value           = ALLTRIM(.this_cGrumoes)
1614:             loc_oPg2.txt_4c_Subg.Value            = ALLTRIM(.this_cSubmoes)
1615:         ENDWITH
1616:     ENDPROC
1617: 

*-- Linhas 1676 a 1683:
1676:         loc_oPg2           = THIS.pgf_4c_Paginas.Page2
1677:         loc_lPodeConfirmar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1678: 
1679:         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lPodeConfirmar
1680:         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1681:     ENDPROC
1682: 
1683: ENDDEFINE


### BO (C:\4c\projeto\app\classes\MoeBO.prg):
*==============================================================================
* MoeBO.prg - Business Object para Cadastro de Moedas
* Tabela: SigCdMoe
* Chave primaria: cmoes char(3)
*==============================================================================

DEFINE CLASS MoeBO AS BusinessBase

    *-- Chave primaria
    this_cCodigo      = ""    && char(3)       cmoes  - Codigo da moeda (PK)

    *-- Dados cadastrais
    this_cDescricao   = ""    && char(15)      dmoes  - Descricao da moeda
    this_lCotas       = .F.   && bit           cotas  - Permite cotacao
    this_dDataTrans   = {}    && datetime NULL  datatrans - Data transacao

    *-- Fator multiplicador / ordem relatorios
    this_cFmults      = ""    && char(1)       fmults     - Fator multiplicador (N=Nao / S=Sim)
    this_nNordrels    = 0     && numeric(1,0)  nordrels   - N da coluna nos relatorios (0-5)

    *-- Codificacao etiqueta produto
    this_cDisfpres    = ""    && char(1)       disfpres   - Codifica na etiqueta (N/S/A/P)
    this_nValadics    = 0     && numeric(3,0)  valadics   - Valor adicional

    *-- Moeda equivalente
    this_cMoeqs       = ""    && char(3)       moeqs      - Codigo da moeda equivalente (FK SigCdMoe.cmoes)
    this_nQtdeqs      = 0     && numeric(12,6) qtdeqs     - Quantidade moeda equivalente
    this_nToleras     = 0     && numeric(4,2)  toleras    - Tolerancia conversao

    *-- Classificacao
    this_cGrumoes     = ""    && char(10)      grumoes    - Grupo
    this_cSubmoes     = ""    && char(10)      submoes    - Sub-grupo

    *-- Configuracao gerencial
    this_lTabrefs     = .F.   && bit           tabrefs    - Imprime tabela referencia
    this_cFpags       = ""    && char(12)      fpags      - Cond. pagamento automatica (FK SigOpFp.fpags)
    this_nConsultas   = 1     && numeric(1,0)  consultas  - Listar na consulta (1=Sim / 2=Nao)
    this_nObgfator    = 0     && numeric(1,0)  obgfator   - Obrigatorio fator

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdMoe"
        THIS.this_cCampoChave = "cmoes"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, nordrels, cotas" + ;
                " FROM SigCdMoe"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cmoes"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar moedas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT cmoes, dmoes, cotas, datatrans, fmults, nordrels," + ;
                " disfpres, valadics, moeqs, qtdeqs, toleras," + ;
                " grumoes, submoes, tabrefs, fpags, consultas, obgfator" + ;
                " FROM SigCdMoe" + ;
                " WHERE cmoes = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MsgAviso("Moeda n" + CHR(227) + "o encontrada: " + ALLTRIM(par_cCodigo), "N" + CHR(227) + "o Encontrado")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cmoes,    "C")
            THIS.this_cDescricao = TratarNulo(dmoes,    "C")
            IF VARTYPE(cotas) = "L"
                THIS.this_lCotas = cotas
            ELSE
                THIS.this_lCotas = (NVL(cotas, 0) = 1)
            ENDIF
            THIS.this_cFmults    = TratarNulo(fmults,   "C")
            THIS.this_nNordrels  = TratarNulo(nordrels, "N")
            THIS.this_cDisfpres  = TratarNulo(disfpres, "C")
            THIS.this_nValadics  = TratarNulo(valadics, "N")
            THIS.this_cMoeqs     = TratarNulo(moeqs,    "C")
            THIS.this_nQtdeqs    = TratarNulo(qtdeqs,   "N")
            THIS.this_nToleras   = TratarNulo(toleras,  "N")
            THIS.this_cGrumoes   = TratarNulo(grumoes,  "C")
            THIS.this_cSubmoes   = TratarNulo(submoes,  "C")
            IF VARTYPE(tabrefs) = "L"
                THIS.this_lTabrefs = tabrefs
            ELSE
                THIS.this_lTabrefs = (NVL(tabrefs, 0) = 1)
            ENDIF
            THIS.this_cFpags     = TratarNulo(fpags,    "C")
            THIS.this_nConsultas = TratarNulo(consultas,"N")
            THIS.this_nObgfator  = TratarNulo(obgfator, "N")
            IF ISNULL(datatrans) OR EMPTY(datatrans)
                THIS.this_dDataTrans = {}
            ELSE
                THIS.this_dDataTrans = datatrans
            ENDIF
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        LOCAL loc_cSQL, loc_nResult, loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo da moeda n" + CHR(227) + "o pode ser vazio!", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o da moeda n" + CHR(227) + "o pode ser vazia!", ;
                "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND !BETWEEN(THIS.this_nNordrels, 0, 5)
            MsgAviso("Ordem de Impress" + CHR(227) + "o nos Relat" + CHR(243) + ;
                "rios inv" + CHR(225) + "lida (0 a 5)!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            TRY
                IF USED("cursor_4c_ValidaMoe")
                    USE IN cursor_4c_ValidaMoe
                ENDIF
                loc_cSQL = "SELECT cmoes FROM SigCdMoe" + ;
                    " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValidaMoe")
                IF loc_nResult > 0 AND RECCOUNT("cursor_4c_ValidaMoe") > 0
                    MsgAviso("Moeda j" + CHR(225) + " cadastrada!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro na valida" + CHR(231) + CHR(227) + "o: " + loc_oErro.Message, "Erro")
                loc_lValido = .F.
            ENDTRY
            IF USED("cursor_4c_ValidaMoe")
                USE IN cursor_4c_ValidaMoe
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDisfpres
        loc_lSucesso = .F.

        loc_cDisfpres = THIS.this_cDisfpres
        IF EMPTY(ALLTRIM(loc_cDisfpres))
            loc_cDisfpres = "S"
        ENDIF

        TRY
            loc_cSQL = "INSERT INTO SigCdMoe" + ;
                " (cmoes, dmoes, cotas, datatrans, fmults, nordrels," + ;
                " disfpres, valadics, moeqs, qtdeqs, toleras," + ;
                " grumoes, submoes, tabrefs, fpags, consultas, obgfator)" + ;
                " VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cCodigo)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + ", " + ;
                IIF(THIS.this_lCotas, "1", "0") + ", " + ;
                "GETDATE(), " + ;
                EscaparSQL(THIS.this_cFmults) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNordrels) + ", " + ;
                EscaparSQL(loc_cDisfpres) + ", " + ;
                FormatarNumeroSQL(THIS.this_nValadics) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cMoeqs)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nQtdeqs) + ", " + ;
                FormatarNumeroSQL(THIS.this_nToleras) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cGrumoes)) + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cSubmoes)) + ", " + ;
                IIF(THIS.this_lTabrefs, "1", "0") + ", " + ;
                EscaparSQL(ALLTRIM(THIS.this_cFpags)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nConsultas) + ", " + ;
                FormatarNumeroSQL(THIS.this_nObgfator) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cDisfpres
        loc_lSucesso = .F.

        loc_cDisfpres = THIS.this_cDisfpres
        IF EMPTY(ALLTRIM(loc_cDisfpres))
            loc_cDisfpres = "S"
        ENDIF

        TRY
            loc_cSQL = "UPDATE SigCdMoe SET" + ;
                " dmoes = " + EscaparSQL(ALLTRIM(THIS.this_cDescricao)) + "," + ;
                " cotas = " + IIF(THIS.this_lCotas, "1", "0") + "," + ;
                " datatrans = GETDATE()," + ;
                " fmults = " + EscaparSQL(THIS.this_cFmults) + "," + ;
                " nordrels = " + FormatarNumeroSQL(THIS.this_nNordrels) + "," + ;
                " disfpres = " + EscaparSQL(loc_cDisfpres) + "," + ;
                " valadics = " + FormatarNumeroSQL(THIS.this_nValadics) + "," + ;
                " moeqs = " + EscaparSQL(ALLTRIM(THIS.this_cMoeqs)) + "," + ;
                " qtdeqs = " + FormatarNumeroSQL(THIS.this_nQtdeqs) + "," + ;
                " toleras = " + FormatarNumeroSQL(THIS.this_nToleras) + "," + ;
                " grumoes = " + EscaparSQL(ALLTRIM(THIS.this_cGrumoes)) + "," + ;
                " submoes = " + EscaparSQL(ALLTRIM(THIS.this_cSubmoes)) + "," + ;
                " tabrefs = " + IIF(THIS.this_lTabrefs, "1", "0") + "," + ;
                " fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFpags)) + "," + ;
                " consultas = " + FormatarNumeroSQL(THIS.this_nConsultas) + "," + ;
                " obgfator = " + FormatarNumeroSQL(THIS.this_nObgfator) + ;
                " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_lPodeExcluir
        loc_lSucesso   = .F.
        loc_lPodeExcluir = .F.

        *-- Verificar se há cotações cadastradas
        TRY
            IF USED("cursor_4c_VerifCot")
                USE IN cursor_4c_VerifCot
            ENDIF
            loc_cSQL = "SELECT TOP 1 cidchaves FROM SigCdCot" + ;
                " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifCot")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_VerifCot") > 0
                MsgErro("Imposs" + CHR(237) + "vel excluir moeda com cota" + CHR(231) + ;
                    CHR(227) + "o cadastrada!", "Exclus" + CHR(227) + "o Inv" + CHR(225) + "lida")
            ELSE
                loc_lPodeExcluir = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar cota" + CHR(231) + CHR(245) + "es: " + loc_oErro.Message, "Erro")
        ENDTRY
        IF USED("cursor_4c_VerifCot")
            USE IN cursor_4c_VerifCot
        ENDIF

        IF loc_lPodeExcluir
            TRY
                loc_cSQL = "DELETE FROM SigCdMoe" + ;
                    " WHERE cmoes = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult > 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao excluir moeda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
            ENDTRY
        ENDIF
        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

