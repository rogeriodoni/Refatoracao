# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [GRID-HEADER] Header Caption ' ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Conta, Contrapartida, Histórico, Débito, Crédito, , NF, Documento, O. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Conta, Contrapartida, Histórico, Débito, Crédito, , NF, Documento, O. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2982 linhas total):

*-- Linhas 64 a 76:
64:                 THIS.ConfigurarPaginaDados()
65: 
66:                 *-- Propagar Caption para labels do cabecalho
67:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra, "Caption", 5)
68:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
69:                 ENDIF
70:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo, "Caption", 5)
71:                     THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
72:                 ENDIF
73: 
74:                 *-- Carregar lista inicial (pular se validando UI)
75:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
76:                     THIS.CarregarLista()

*-- Linhas 97 a 112:
97:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
98:             WITH THIS.pgf_4c_Paginas
99:                 .PageCount  = 2
100:                 .Top        = -29
101:                 .Left       = 0
102:                 .Width      = THIS.Width
103:                 .Height     = THIS.Height + 29
104:                 .Tabs       = .F.
105:                 .Visible    = .T.
106:                 .Page1.Caption   = "Lista"
107:                 .Page2.Caption   = "Dados"
108:                 .Page1.BackColor = RGB(240, 240, 240)
109:                 .Page2.BackColor = RGB(240, 240, 240)
110:             ENDWITH
111:         CATCH TO loc_oErro
112:             MsgErro(loc_oErro.Message, "ConfigurarPageFrame")

*-- Linhas 130 a 168:
130:             *--------------------------------------------------------------------
131:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
132:             WITH loc_oPagina.cnt_4c_Cabecalho
133:                 .Top         = 31
134:                 .Left        = 0
135:                 .Width       = 935
136:                 .Height      = 80
137:                 .BackStyle   = 1
138:                 .BackColor   = RGB(53, 53, 53)
139:                 .BorderWidth = 0
140:                 .Visible     = .T.
141: 
142:                 .AddObject("lbl_4c_Sombra", "Label")
143:                 WITH .lbl_4c_Sombra
144:                     .Top       = 15
145:                     .Left      = 10
146:                     .Width     = 909
147:                     .Height    = 40
148:                     .Caption   = "Conta Corrente Geral"
149:                     .FontName  = "Tahoma"
150:                     .FontSize  = 16
151:                     .FontBold  = .T.
152:                     .ForeColor = RGB(0, 0, 0)
153:                     .BackStyle = 0
154:                     .Visible   = .T.
155:                 ENDWITH
156: 
157:                 .AddObject("lbl_4c_Titulo", "Label")
158:                 WITH .lbl_4c_Titulo
159:                     .Top       = 18
160:                     .Left      = 10
161:                     .Width     = 909
162:                     .Height    = 46
163:                     .Caption   = "Conta Corrente Geral"
164:                     .FontName  = "Tahoma"
165:                     .FontSize  = 16
166:                     .FontBold  = .T.
167:                     .ForeColor = RGB(255, 255, 255)
168:                     .BackStyle = 0

*-- Linhas 175 a 199:
175:             *--------------------------------------------------------------------
176:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
177:             WITH loc_oPagina.cnt_4c_Botoes
178:                 .Top         = 29
179:                 .Left        = 542
180:                 .Width       = 390
181:                 .Height      = 85
182:                 .BackStyle   = 1
183:                 .BackColor   = RGB(53, 53, 53)
184:                 .BorderWidth = 0
185:                 .Visible     = .T.
186: 
187:                 *-- cmd_4c_Incluir
188:                 .AddObject("cmd_4c_Incluir", "CommandButton")
189:                 WITH .cmd_4c_Incluir
190:                     .Caption         = "Incluir"
191:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
192:                     .PicturePosition = 13
193:                     .Top             = 5
194:                     .Left            = 5
195:                     .Width           = 75
196:                     .Height          = 75
197:                     .BackColor       = RGB(255, 255, 255)
198:                     .ForeColor       = RGB(90, 90, 90)
199:                     .FontName        = "Tahoma"

*-- Linhas 206 a 221:
206:                     .Visible         = .T.
207:                 ENDWITH
208: 
209:                 *-- cmd_4c_Visualizar
210:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
211:                 WITH .cmd_4c_Visualizar
212:                     .Caption         = "Visualizar"
213:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
214:                     .PicturePosition = 13
215:                     .Top             = 5
216:                     .Left            = 80
217:                     .Width           = 75
218:                     .Height          = 75
219:                     .BackColor       = RGB(255, 255, 255)
220:                     .ForeColor       = RGB(90, 90, 90)
221:                     .FontName        = "Tahoma"

*-- Linhas 229 a 244:
229:                     .Visible         = .T.
230:                 ENDWITH
231: 
232:                 *-- cmd_4c_Alterar
233:                 .AddObject("cmd_4c_Alterar", "CommandButton")
234:                 WITH .cmd_4c_Alterar
235:                     .Caption         = "Alterar"
236:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
237:                     .PicturePosition = 13
238:                     .Top             = 5
239:                     .Left            = 155
240:                     .Width           = 75
241:                     .Height          = 75
242:                     .BackColor       = RGB(255, 255, 255)
243:                     .ForeColor       = RGB(90, 90, 90)
244:                     .FontName        = "Tahoma"

*-- Linhas 252 a 267:
252:                     .Visible         = .T.
253:                 ENDWITH
254: 
255:                 *-- cmd_4c_Excluir
256:                 .AddObject("cmd_4c_Excluir", "CommandButton")
257:                 WITH .cmd_4c_Excluir
258:                     .Caption         = "Excluir"
259:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
260:                     .PicturePosition = 13
261:                     .Top             = 5
262:                     .Left            = 230
263:                     .Width           = 75
264:                     .Height          = 75
265:                     .BackColor       = RGB(255, 255, 255)
266:                     .ForeColor       = RGB(90, 90, 90)
267:                     .FontName        = "Tahoma"

*-- Linhas 275 a 290:
275:                     .Visible         = .T.
276:                 ENDWITH
277: 
278:                 *-- cmd_4c_Buscar
279:                 .AddObject("cmd_4c_Buscar", "CommandButton")
280:                 WITH .cmd_4c_Buscar
281:                     .Caption         = "Buscar"
282:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
283:                     .PicturePosition = 13
284:                     .Top             = 5
285:                     .Left            = 305
286:                     .Width           = 75
287:                     .Height          = 75
288:                     .BackColor       = RGB(255, 255, 255)
289:                     .ForeColor       = RGB(90, 90, 90)
290:                     .FontName        = "Tahoma"

*-- Linhas 304 a 327:
304:             *--------------------------------------------------------------------
305:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
306:             WITH loc_oPagina.cnt_4c_Saida
307:                 .Top         = 29
308:                 .Left        = 937
309:                 .Width       = 60
310:                 .Height      = 85
311:                 .BackStyle   = 1
312:                 .BackColor   = RGB(53, 53, 53)
313:                 .BorderWidth = 0
314:                 .Visible     = .T.
315: 
316:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
317:                 WITH .cmd_4c_Encerrar
318:                     .Caption         = "Encerrar"
319:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
320:                     .PicturePosition = 13
321:                     .Top             = 5
322:                     .Left            = 5
323:                     .Width           = 50
324:                     .Height          = 75
325:                     .BackColor       = RGB(255, 255, 255)
326:                     .ForeColor       = RGB(90, 90, 90)
327:                     .FontName        = "Tahoma"

*-- Linhas 338 a 352:
338:             *--------------------------------------------------------------------
339:             * Botao Movimento (Anexa) - Top=4+29=33, Left=847
340:             *--------------------------------------------------------------------
341:             loc_oPagina.AddObject("cmd_4c_Movimento", "CommandButton")
342:             WITH loc_oPagina.cmd_4c_Movimento
343:                 .Caption         = "Movimento"
344:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
345:                 .PicturePosition = 13
346:                 .Top             = 33
347:                 .Left            = 847
348:                 .Width           = 75
349:                 .Height          = 75
350:                 .BackColor       = RGB(255, 255, 255)
351:                 .ForeColor       = RGB(90, 90, 90)
352:                 .FontName        = "Tahoma"

*-- Linhas 365 a 425:
365:             *--------------------------------------------------------------------
366:             loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
367:             WITH loc_oPagina.cnt_4c_Filtros
368:                 .Top         = 114
369:                 .Left        = 0
370:                 .Width       = 400
371:                 .Height      = 36
372:                 .BackStyle   = 0
373:                 .BorderWidth = 0
374:                 .Visible     = .T.
375: 
376:                 .AddObject("lbl_4c_Periodo", "Label")
377:                 WITH .lbl_4c_Periodo
378:                     .Caption   = "Per" + CHR(237) + "odo : "
379:                     .Top       = 10
380:                     .Left      = 17
381:                     .Width     = 54
382:                     .Height    = 15
383:                     .FontName  = "Tahoma"
384:                     .FontSize  = 8
385:                     .ForeColor = RGB(0, 0, 0)
386:                     .BackStyle = 0
387:                     .Visible   = .T.
388:                 ENDWITH
389: 
390:                 .AddObject("txt_4c_DtInicial", "TextBox")
391:                 WITH .txt_4c_DtInicial
392:                     .Top      = 6
393:                     .Left     = 73
394:                     .Width    = 80
395:                     .Height   = 21
396:                     .Value    = {}
397:                     .FontName = "Tahoma"
398:                     .FontSize = 8
399:                     .Format   = "D"
400:                     .Visible  = .T.
401:                 ENDWITH
402: 
403:                 .AddObject("lbl_4c_Ate", "Label")
404:                 WITH .lbl_4c_Ate
405:                     .Caption   = "at" + CHR(233)
406:                     .Top       = 10
407:                     .Left      = 158
408:                     .Width     = 20
409:                     .Height    = 15
410:                     .FontName  = "Tahoma"
411:                     .FontSize  = 8
412:                     .ForeColor = RGB(0, 0, 0)
413:                     .BackStyle = 0
414:                     .Visible   = .T.
415:                 ENDWITH
416: 
417:                 .AddObject("txt_4c_DtFinal", "TextBox")
418:                 WITH .txt_4c_DtFinal
419:                     .Top      = 6
420:                     .Left     = 184
421:                     .Width    = 80
422:                     .Height   = 21
423:                     .Value    = {}
424:                     .FontName = "Tahoma"
425:                     .FontSize = 8

*-- Linhas 456 a 465:
456:             loc_oPagina.AddObject("grd_4c_Dados", "Grid")
457:             loc_oGrid = loc_oPagina.grd_4c_Dados
458: 
459:             loc_oGrid.Top              = 150
460:             loc_oGrid.Left             = 5
461:             loc_oGrid.Width            = 986
462:             loc_oGrid.Height           = 472
463:             loc_oGrid.FontName         = "Verdana"
464:             loc_oGrid.FontSize         = 8
465:             loc_oGrid.ForeColor        = RGB(90, 90, 90)

*-- Linhas 510 a 539:
510:             loc_oGrid.Column7.Alignment = 1   && Right para Credito
511: 
512:             *-- Headers (APOS RecordSource e ControlSource - OBRIGATORIO)
513:             loc_oGrid.Column1.Header1.Caption  = "Data"
514:             loc_oGrid.Column2.Header1.Caption  = "O"
515:             loc_oGrid.Column3.Header1.Caption  = "Conta"
516:             loc_oGrid.Column4.Header1.Caption  = "Contrapartida"
517:             loc_oGrid.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
518:             loc_oGrid.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
519:             loc_oGrid.Column7.Header1.Caption  = "Cr" + CHR(233) + "dito"
520:             loc_oGrid.Column8.Header1.Caption  = ""
521:             loc_oGrid.Column9.Header1.Caption  = " "
522:             loc_oGrid.Column10.Header1.Caption = "NF"
523:             loc_oGrid.Column11.Header1.Caption = "Documento"
524: 
525:             *--------------------------------------------------------------------
526:             * BINDEVENTs para botoes
527:             *--------------------------------------------------------------------
528:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
529:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
530:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
531:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
532:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
533:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
534:             BINDEVENT(loc_oPagina.cmd_4c_Movimento,                 "Click", THIS, "BtnMovimentoClick")
535: 
536:             *-- BINDEVENTs para filtro de periodo
537:             BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtInicial, "LostFocus", THIS, "FiltroDataInicialLostFocus")
538:             BINDEVENT(loc_oPagina.cnt_4c_Filtros.txt_4c_DtFinal,   "LostFocus", THIS, "FiltroDataFinalLostFocus")
539: 

*-- Linhas 565 a 588:
565:             *--------------------------------------------------------------------
566:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
567:             WITH loc_oPagina.cnt_4c_BotoesAcao
568:                 .Top         = 29
569:                 .Left        = 842
570:                 .Width       = 160
571:                 .Height      = 85
572:                 .BackStyle   = 1
573:                 .BackColor   = RGB(53, 53, 53)
574:                 .BorderWidth = 0
575:                 .Visible     = .T.
576: 
577:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
578:                 WITH .cmd_4c_Confirmar
579:                     .Caption         = "Confirmar"
580:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
581:                     .PicturePosition = 13
582:                     .Top             = 5
583:                     .Left            = 5
584:                     .Width           = 75
585:                     .Height          = 75
586:                     .BackColor       = RGB(255, 255, 255)
587:                     .ForeColor       = RGB(90, 90, 90)
588:                     .FontName        = "Tahoma"

*-- Linhas 595 a 609:
595:                     .Visible         = .T.
596:                 ENDWITH
597: 
598:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
599:                 WITH .cmd_4c_Cancelar
600:                     .Caption         = "Cancelar"
601:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
602:                     .PicturePosition = 13
603:                     .Top             = 5
604:                     .Left            = 80
605:                     .Width           = 75
606:                     .Height          = 75
607:                     .BackColor       = RGB(255, 255, 255)
608:                     .ForeColor       = RGB(90, 90, 90)
609:                     .FontName        = "Tahoma"

*-- Linhas 624 a 633:
624:             *--------------------------------------------------------------------
625:             loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
626:             WITH loc_oPagina.shp_4c_Shape1
627:                 .Top          = 182
628:                 .Left         = 9
629:                 .Width        = 980
630:                 .Height       = 64
631:                 .BackStyle    = 1
632:                 .BackColor    = RGB(220, 220, 220)
633:                 .FillStyle    = 0

*-- Linhas 640 a 649:
640:             *-- Shape3: Painel movimento esquerdo (top=224+29=253)
641:             loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
642:             WITH loc_oPagina.shp_4c_Shape3
643:                 .Top          = 253
644:                 .Left         = 9
645:                 .Width        = 485
646:                 .Height       = 117
647:                 .BackStyle    = 1
648:                 .BackColor    = RGB(220, 220, 220)
649:                 .FillStyle    = 0

*-- Linhas 656 a 665:
656:             *-- Shape2: Painel movimento direito (top=224+29=253)
657:             loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
658:             WITH loc_oPagina.shp_4c_Shape2
659:                 .Top          = 253
660:                 .Left         = 504
661:                 .Width        = 485
662:                 .Height       = 117
663:                 .BackStyle    = 1
664:                 .BackColor    = RGB(220, 220, 220)
665:                 .FillStyle    = 0

*-- Linhas 672 a 681:
672:             *-- Shape6: Painel historico (top=350+29=379)
673:             loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
674:             WITH loc_oPagina.shp_4c_Shape6
675:                 .Top          = 379
676:                 .Left         = 9
677:                 .Width        = 980
678:                 .Height       = 39
679:                 .BackStyle    = 1
680:                 .BackColor    = RGB(220, 220, 220)
681:                 .FillStyle    = 0

*-- Linhas 689 a 1001:
689:             * Labels - Say objects (top legado + 29)
690:             *--------------------------------------------------------------------
691:             *-- Say1 "Lancamento :" (top=165+29=194, left=43)
692:             loc_oPagina.AddObject("lbl_4c_Lancamento", "Label")
693:             WITH loc_oPagina.lbl_4c_Lancamento
694:                 .Caption  = "Lan" + CHR(231) + "amento :"
695:                 .Top      = 194
696:                 .Left     = 43
697:                 .Width    = 75
698:                 .Height   = 15
699:                 .FontName = "Tahoma"
700:                 .FontSize = 8
701:                 .ForeColor = RGB(0, 0, 0)
702:                 .BackStyle = 0
703:                 .Visible  = .T.
704:             ENDWITH
705: 
706:             *-- Say10 "Vencimento :" (top=165+29=194, left=234)
707:             loc_oPagina.AddObject("lbl_4c_Vencimento", "Label")
708:             WITH loc_oPagina.lbl_4c_Vencimento
709:                 .Caption  = "Vencimento :"
710:                 .Top      = 194
711:                 .Left     = 234
712:                 .Width    = 70
713:                 .Height   = 15
714:                 .FontName = "Tahoma"
715:                 .FontSize = 8
716:                 .ForeColor = RGB(0, 0, 0)
717:                 .BackStyle = 0
718:                 .Visible  = .T.
719:             ENDWITH
720: 
721:             *-- Say15 "Emissao :" (top=165+29=194, left=435)
722:             loc_oPagina.AddObject("lbl_4c_Emissao", "Label")
723:             WITH loc_oPagina.lbl_4c_Emissao
724:                 .Caption  = "Emiss" + CHR(227) + "o :"
725:                 .Top      = 194
726:                 .Left     = 435
727:                 .Width    = 55
728:                 .Height   = 15
729:                 .FontName = "Tahoma"
730:                 .FontSize = 8
731:                 .ForeColor = RGB(0, 0, 0)
732:                 .BackStyle = 0
733:                 .Visible  = .T.
734:             ENDWITH
735: 
736:             *-- Say7 "Nota Fiscal :" (top=165+29=194, left=615)
737:             loc_oPagina.AddObject("lbl_4c_NotaFiscal", "Label")
738:             WITH loc_oPagina.lbl_4c_NotaFiscal
739:                 .Caption  = "Nota Fiscal :"
740:                 .Top      = 194
741:                 .Left     = 615
742:                 .Width    = 70
743:                 .Height   = 15
744:                 .FontName = "Tahoma"
745:                 .FontSize = 8
746:                 .ForeColor = RGB(0, 0, 0)
747:                 .BackStyle = 0
748:                 .Visible  = .T.
749:             ENDWITH
750: 
751:             *-- Say6 "Usuario :" (top=165+29=194, left=818)
752:             loc_oPagina.AddObject("lbl_4c_Usuario", "Label")
753:             WITH loc_oPagina.lbl_4c_Usuario
754:                 .Caption  = "Usu" + CHR(225) + "rio :"
755:                 .Top      = 194
756:                 .Left     = 818
757:                 .Width    = 55
758:                 .Height   = 15
759:                 .FontName = "Tahoma"
760:                 .FontSize = 8
761:                 .ForeColor = RGB(0, 0, 0)
762:                 .BackStyle = 0
763:                 .Visible  = .T.
764:             ENDWITH
765: 
766:             *-- Say17 "Job :" (top=191+29=220, left=84)
767:             loc_oPagina.AddObject("lbl_4c_Job", "Label")
768:             WITH loc_oPagina.lbl_4c_Job
769:                 .Caption  = "Job :"
770:                 .Top      = 220
771:                 .Left     = 84
772:                 .Width    = 30
773:                 .Height   = 15
774:                 .FontName = "Tahoma"
775:                 .FontSize = 8
776:                 .ForeColor = RGB(0, 0, 0)
777:                 .BackStyle = 0
778:                 .Visible  = .T.
779:             ENDWITH
780: 
781:             *-- Say2 "Documento :" (top=191+29=220, left=613)
782:             loc_oPagina.AddObject("lbl_4c_Documento", "Label")
783:             WITH loc_oPagina.lbl_4c_Documento
784:                 .Caption  = "Documento :"
785:                 .Top      = 220
786:                 .Left     = 613
787:                 .Width    = 65
788:                 .Height   = 15
789:                 .FontName = "Tahoma"
790:                 .FontSize = 8
791:                 .ForeColor = RGB(0, 0, 0)
792:                 .BackStyle = 0
793:                 .Visible  = .T.
794:             ENDWITH
795: 
796:             *-- Say3 "Movimento :" Esquerdo (top=235+29=264, left=49)
797:             loc_oPagina.AddObject("lbl_4c_MovEsq", "Label")
798:             WITH loc_oPagina.lbl_4c_MovEsq
799:                 .Caption  = "Movimento :"
800:                 .Top      = 264
801:                 .Left     = 49
802:                 .Width    = 70
803:                 .Height   = 15
804:                 .FontName = "Tahoma"
805:                 .FontSize = 8
806:                 .ForeColor = RGB(0, 0, 0)
807:                 .BackStyle = 0
808:                 .Visible  = .T.
809:             ENDWITH
810: 
811:             *-- Say18 "[D/C]" Esquerdo (top=235+29=264, left=130)
812:             loc_oPagina.AddObject("lbl_4c_DcEsq", "Label")
813:             WITH loc_oPagina.lbl_4c_DcEsq
814:                 .Caption  = "[D/C]"
815:                 .Top      = 264
816:                 .Left     = 130
817:                 .Width    = 30
818:                 .Height   = 15
819:                 .FontName = "Tahoma"
820:                 .FontSize = 8
821:                 .ForeColor = RGB(0, 0, 0)
822:                 .BackStyle = 0
823:                 .Visible  = .T.
824:             ENDWITH
825: 
826:             *-- Say11 "Movimento :" Direito (top=235+29=264, left=544)
827:             loc_oPagina.AddObject("lbl_4c_MovDir", "Label")
828:             WITH loc_oPagina.lbl_4c_MovDir
829:                 .Caption  = "Movimento :"
830:                 .Top      = 264
831:                 .Left     = 544
832:                 .Width    = 70
833:                 .Height   = 15
834:                 .FontName = "Tahoma"
835:                 .FontSize = 8
836:                 .ForeColor = RGB(0, 0, 0)
837:                 .BackStyle = 0
838:                 .Visible  = .T.
839:             ENDWITH
840: 
841:             *-- Say14 "[D/C]" Direito (top=235+29=264, left=626)
842:             loc_oPagina.AddObject("lbl_4c_DcDir", "Label")
843:             WITH loc_oPagina.lbl_4c_DcDir
844:                 .Caption  = "[D/C]"
845:                 .Top      = 264
846:                 .Left     = 626
847:                 .Width    = 30
848:                 .Height   = 15
849:                 .FontName = "Tahoma"
850:                 .FontSize = 8
851:                 .ForeColor = RGB(0, 0, 0)
852:                 .BackStyle = 0
853:                 .Visible  = .T.
854:             ENDWITH
855: 
856:             *-- Say4 "Grupo :" Esquerdo (top=261+29=290, left=72)
857:             loc_oPagina.AddObject("lbl_4c_GrupoEsq", "Label")
858:             WITH loc_oPagina.lbl_4c_GrupoEsq
859:                 .Caption  = "Grupo :"
860:                 .Top      = 290
861:                 .Left     = 72
862:                 .Width    = 40
863:                 .Height   = 15
864:                 .FontName = "Tahoma"
865:                 .FontSize = 8
866:                 .ForeColor = RGB(0, 0, 0)
867:                 .BackStyle = 0
868:                 .Visible  = .T.
869:             ENDWITH
870: 
871:             *-- Say12 "Grupo :" Direito (top=261+29=290, left=567)
872:             loc_oPagina.AddObject("lbl_4c_GrupoDir", "Label")
873:             WITH loc_oPagina.lbl_4c_GrupoDir
874:                 .Caption  = "Grupo :"
875:                 .Top      = 290
876:                 .Left     = 567
877:                 .Width    = 40
878:                 .Height   = 15
879:                 .FontName = "Tahoma"
880:                 .FontSize = 8
881:                 .ForeColor = RGB(0, 0, 0)
882:                 .BackStyle = 0
883:                 .Visible  = .T.
884:             ENDWITH
885: 
886:             *-- Say5 "Conta :" Esquerdo (top=287+29=316, left=72)
887:             loc_oPagina.AddObject("lbl_4c_ContaEsq", "Label")
888:             WITH loc_oPagina.lbl_4c_ContaEsq
889:                 .Caption  = "Conta :"
890:                 .Top      = 316
891:                 .Left     = 72
892:                 .Width    = 40
893:                 .Height   = 15
894:                 .FontName = "Tahoma"
895:                 .FontSize = 8
896:                 .ForeColor = RGB(0, 0, 0)
897:                 .BackStyle = 0
898:                 .Visible  = .T.
899:             ENDWITH
900: 
901:             *-- Say13 "Conta :" Direito (top=287+29=316, left=567)
902:             loc_oPagina.AddObject("lbl_4c_ContaDir", "Label")
903:             WITH loc_oPagina.lbl_4c_ContaDir
904:                 .Caption  = "Conta :"
905:                 .Top      = 316
906:                 .Left     = 567
907:                 .Width    = 40
908:                 .Height   = 15
909:                 .FontName = "Tahoma"
910:                 .FontSize = 8
911:                 .ForeColor = RGB(0, 0, 0)
912:                 .BackStyle = 0
913:                 .Visible  = .T.
914:             ENDWITH
915: 
916:             *-- Say8 "Valor :" Esquerdo (top=313+29=342, left=77)
917:             loc_oPagina.AddObject("lbl_4c_ValorEsq", "Label")
918:             WITH loc_oPagina.lbl_4c_ValorEsq
919:                 .Caption  = "Valor :"
920:                 .Top      = 342
921:                 .Left     = 77
922:                 .Width    = 35
923:                 .Height   = 15
924:                 .FontName = "Tahoma"
925:                 .FontSize = 8
926:                 .ForeColor = RGB(0, 0, 0)
927:                 .BackStyle = 0
928:                 .Visible  = .T.
929:             ENDWITH
930: 
931:             *-- Say16 "Valor :" Direito (top=313+29=342, left=572)
932:             loc_oPagina.AddObject("lbl_4c_ValorDir", "Label")
933:             WITH loc_oPagina.lbl_4c_ValorDir
934:                 .Caption  = "Valor :"
935:                 .Top      = 342
936:                 .Left     = 572
937:                 .Width    = 35
938:                 .Height   = 15
939:                 .FontName = "Tahoma"
940:                 .FontSize = 8
941:                 .ForeColor = RGB(0, 0, 0)
942:                 .BackStyle = 0
943:                 .Visible  = .T.
944:             ENDWITH
945: 
946:             *-- Say_Cotacao "Cambio :" Esquerdo (top=313+29=342, left=303)
947:             loc_oPagina.AddObject("lbl_4c_CotacaoEsq", "Label")
948:             WITH loc_oPagina.lbl_4c_CotacaoEsq
949:                 .Caption  = "C" + CHR(226) + "mbio :"
950:                 .Top      = 342
951:                 .Left     = 303
952:                 .Width    = 50
953:                 .Height   = 15
954:                 .FontName = "Tahoma"
955:                 .FontSize = 8
956:                 .ForeColor = RGB(0, 0, 0)
957:                 .BackStyle = 0
958:                 .Visible  = .T.
959:             ENDWITH
960: 
961:             *-- Say_sCotacao "Cambio :" Direito (top=313+29=342, left=797)
962:             loc_oPagina.AddObject("lbl_4c_CotacaoDir", "Label")
963:             WITH loc_oPagina.lbl_4c_CotacaoDir
964:                 .Caption  = "C" + CHR(226) + "mbio :"
965:                 .Top      = 342
966:                 .Left     = 797
967:                 .Width    = 50
968:                 .Height   = 15
969:                 .FontName = "Tahoma"
970:                 .FontSize = 8
971:                 .ForeColor = RGB(0, 0, 0)
972:                 .BackStyle = 0
973:                 .Visible  = .T.
974:             ENDWITH
975: 
976:             *-- Say9 "Historico :" (top=362+29=391, left=60)
977:             loc_oPagina.AddObject("lbl_4c_Historico", "Label")
978:             WITH loc_oPagina.lbl_4c_Historico
979:                 .Caption  = "Hist" + CHR(243) + "rico :"
980:                 .Top      = 391
981:                 .Left     = 60
982:                 .Width    = 55
983:                 .Height   = 15
984:                 .FontName = "Tahoma"
985:                 .FontSize = 8
986:                 .ForeColor = RGB(0, 0, 0)
987:                 .BackStyle = 0
988:                 .Visible  = .T.
989:             ENDWITH
990: 
991:             *-- Say19 "Lancar Contas :" (top=362+29=391, left=758)
992:             loc_oPagina.AddObject("lbl_4c_LancarContas", "Label")
993:             WITH loc_oPagina.lbl_4c_LancarContas
994:                 .Caption  = "Lan" + CHR(231) + "ar Contas :"
995:                 .Top      = 391
996:                 .Left     = 758
997:                 .Width    = 85
998:                 .Height   = 15
999:                 .FontName = "Tahoma"
1000:                 .FontSize = 8
1001:                 .ForeColor = RGB(0, 0, 0)

*-- Linhas 1009 a 1046:
1009:             *-- fweditdata_DATA "Lancamento" (top=161+29=190, left=112, width=80)
1010:             loc_oPagina.AddObject("txt_4c_Data", "TextBox")
1011:             WITH loc_oPagina.txt_4c_Data
1012:                 .Top      = 190
1013:                 .Left     = 112
1014:                 .Width    = 80
1015:                 .Height   = 21
1016:                 .Value    = {}
1017:                 .Format   = "D"
1018:                 .FontName = "Tahoma"
1019:                 .FontSize = 8
1020:                 .Visible  = .T.
1021:             ENDWITH
1022: 
1023:             *-- fweditdata_VENC "Vencimento" (top=161+29=190, left=300, width=80)
1024:             loc_oPagina.AddObject("txt_4c_Venc", "TextBox")
1025:             WITH loc_oPagina.txt_4c_Venc
1026:                 .Top      = 190
1027:                 .Left     = 300
1028:                 .Width    = 80
1029:                 .Height   = 21
1030:                 .Value    = {}
1031:                 .Format   = "D"
1032:                 .FontName = "Tahoma"
1033:                 .FontSize = 8
1034:                 .Visible  = .T.
1035:             ENDWITH
1036: 
1037:             *-- getDtEmis "Emissao" (top=161+29=190, left=484, width=80)
1038:             loc_oPagina.AddObject("txt_4c_Emis", "TextBox")
1039:             WITH loc_oPagina.txt_4c_Emis
1040:                 .Top      = 190
1041:                 .Left     = 484
1042:                 .Width    = 80
1043:                 .Height   = 21
1044:                 .Value    = {}
1045:                 .Format   = "D"
1046:                 .FontName = "Tahoma"

*-- Linhas 1054 a 1076:
1054:             *-- Get_Nota "Nota Fiscal" (top=161+29=190, left=678, width=80)
1055:             loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
1056:             WITH loc_oPagina.txt_4c_Nota
1057:                 .Top      = 190
1058:                 .Left     = 678
1059:                 .Width    = 80
1060:                 .Height   = 21
1061:                 .Value    = SPACE(10)
1062:                 .FontName = "Tahoma"
1063:                 .FontSize = 8
1064:                 .Visible  = .T.
1065:             ENDWITH
1066: 
1067:             *-- get_Usuario "Usuario" (top=161+29=190, left=865, width=80) - somente leitura
1068:             loc_oPagina.AddObject("txt_4c_Usuario", "TextBox")
1069:             WITH loc_oPagina.txt_4c_Usuario
1070:                 .Top      = 190
1071:                 .Left     = 865
1072:                 .Width    = 80
1073:                 .Height   = 21
1074:                 .Value    = SPACE(10)
1075:                 .ReadOnly = .T.
1076:                 .BackColor = RGB(224, 224, 224)

*-- Linhas 1082 a 1104:
1082:             *-- getJob "Job" (top=187+29=216, left=112, width=80)
1083:             loc_oPagina.AddObject("txt_4c_Job", "TextBox")
1084:             WITH loc_oPagina.txt_4c_Job
1085:                 .Top      = 216
1086:                 .Left     = 112
1087:                 .Width    = 80
1088:                 .Height   = 23
1089:                 .Value    = SPACE(10)
1090:                 .FontName = "Tahoma"
1091:                 .FontSize = 8
1092:                 .Visible  = .T.
1093:             ENDWITH
1094: 
1095:             *-- getDJob "Descricao Job" (top=187+29=216, left=195, width=290) - somente leitura
1096:             loc_oPagina.AddObject("txt_4c_DJob", "TextBox")
1097:             WITH loc_oPagina.txt_4c_DJob
1098:                 .Top      = 216
1099:                 .Left     = 195
1100:                 .Width    = 290
1101:                 .Height   = 23
1102:                 .Value    = SPACE(40)
1103:                 .ReadOnly = .T.
1104:                 .BackColor = RGB(224, 224, 224)

*-- Linhas 1110 a 1119:
1110:             *-- Get_DOCU "Documento" (top=187+29=216, left=678, width=80)
1111:             loc_oPagina.AddObject("txt_4c_Docu", "TextBox")
1112:             WITH loc_oPagina.txt_4c_Docu
1113:                 .Top      = 216
1114:                 .Left     = 678
1115:                 .Width    = 80
1116:                 .Height   = 21
1117:                 .Value    = SPACE(10)
1118:                 .FontName = "Tahoma"
1119:                 .FontSize = 8

*-- Linhas 1126 a 1162:
1126:             *-- Get_OPER D/C esquerdo (top=231+29=260, left=112, width=15)
1127:             loc_oPagina.AddObject("txt_4c_Oper", "TextBox")
1128:             WITH loc_oPagina.txt_4c_Oper
1129:                 .Top      = 260
1130:                 .Left     = 112
1131:                 .Width    = 15
1132:                 .Height   = 21
1133:                 .Value    = SPACE(1)
1134:                 .MaxLength = 1
1135:                 .FontName = "Tahoma"
1136:                 .FontSize = 8
1137:                 .Visible  = .T.
1138:             ENDWITH
1139: 
1140:             *-- Get_grupo esquerdo (top=257+29=286, left=112, width=80)
1141:             loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
1142:             WITH loc_oPagina.txt_4c_Grupo
1143:                 .Top      = 286
1144:                 .Left     = 112
1145:                 .Width    = 80
1146:                 .Height   = 23
1147:                 .Value    = SPACE(10)
1148:                 .FontName = "Tahoma"
1149:                 .FontSize = 8
1150:                 .Visible  = .T.
1151:             ENDWITH
1152: 
1153:             *-- Get_dgrupo desc. Grupo esquerdo (top=257+29=286, left=195, width=290) - RO
1154:             loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
1155:             WITH loc_oPagina.txt_4c_DGrupo
1156:                 .Top      = 286
1157:                 .Left     = 195
1158:                 .Width    = 290
1159:                 .Height   = 23
1160:                 .Value    = SPACE(40)
1161:                 .ReadOnly = .T.
1162:                 .BackColor = RGB(224, 224, 224)

*-- Linhas 1168 a 1190:
1168:             *-- Get_conta esquerdo (top=283+29=312, left=112, width=80)
1169:             loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
1170:             WITH loc_oPagina.txt_4c_Conta
1171:                 .Top      = 312
1172:                 .Left     = 112
1173:                 .Width    = 80
1174:                 .Height   = 21
1175:                 .Value    = SPACE(10)
1176:                 .FontName = "Tahoma"
1177:                 .FontSize = 8
1178:                 .Visible  = .T.
1179:             ENDWITH
1180: 
1181:             *-- Get_dconta desc. Conta esquerdo (top=283+29=312, left=195, width=290) - RO
1182:             loc_oPagina.AddObject("txt_4c_DcConta", "TextBox")
1183:             WITH loc_oPagina.txt_4c_DcConta
1184:                 .Top      = 312
1185:                 .Left     = 195
1186:                 .Width    = 290
1187:                 .Height   = 21
1188:                 .Value    = SPACE(40)
1189:                 .ReadOnly = .T.
1190:                 .BackColor = RGB(224, 224, 224)

*-- Linhas 1196 a 1245:
1196:             *-- Get_VALOR esquerdo (top=309+29=338, left=112, width=128)
1197:             loc_oPagina.AddObject("txt_4c_Valor", "TextBox")
1198:             WITH loc_oPagina.txt_4c_Valor
1199:                 .Top      = 338
1200:                 .Left     = 112
1201:                 .Width    = 128
1202:                 .Height   = 23
1203:                 .Value    = 0.00
1204:                 .FontName = "Tahoma"
1205:                 .FontSize = 8
1206:                 .Visible  = .T.
1207:             ENDWITH
1208: 
1209:             *-- Get_MOEDA esquerdo (top=309+29=338, left=243, width=31)
1210:             loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
1211:             WITH loc_oPagina.txt_4c_Moeda
1212:                 .Top      = 338
1213:                 .Left     = 243
1214:                 .Width    = 31
1215:                 .Height   = 21
1216:                 .Value    = SPACE(3)
1217:                 .FontName = "Tahoma"
1218:                 .FontSize = 8
1219:                 .Visible  = .T.
1220:             ENDWITH
1221: 
1222:             *-- Get_COTACAO esquerdo (top=309+29=338, left=349, width=108)
1223:             loc_oPagina.AddObject("txt_4c_Cotacao", "TextBox")
1224:             WITH loc_oPagina.txt_4c_Cotacao
1225:                 .Top      = 338
1226:                 .Left     = 349
1227:                 .Width    = 108
1228:                 .Height   = 21
1229:                 .Value    = 0.0000000
1230:                 .FontName = "Tahoma"
1231:                 .FontSize = 8
1232:                 .Visible  = .T.
1233:             ENDWITH
1234: 
1235:             *-- alteracotacao "$" esquerdo (top=309+29=338, left=461, width=24)
1236:             loc_oPagina.AddObject("cmd_4c_AlteraCotacao", "CommandButton")
1237:             WITH loc_oPagina.cmd_4c_AlteraCotacao
1238:                 .Caption       = "$"
1239:                 .Top           = 338
1240:                 .Left          = 461
1241:                 .Width         = 24
1242:                 .Height        = 23
1243:                 .FontName      = "Tahoma"
1244:                 .FontSize      = 8
1245:                 .BackColor     = RGB(192, 192, 192)

*-- Linhas 1256 a 1292:
1256:             *-- Get_SOPER D/C direito (top=231+29=260, left=607, width=15)
1257:             loc_oPagina.AddObject("txt_4c_SOper", "TextBox")
1258:             WITH loc_oPagina.txt_4c_SOper
1259:                 .Top      = 260
1260:                 .Left     = 607
1261:                 .Width    = 15
1262:                 .Height   = 21
1263:                 .Value    = SPACE(1)
1264:                 .MaxLength = 1
1265:                 .FontName = "Tahoma"
1266:                 .FontSize = 8
1267:                 .Visible  = .T.
1268:             ENDWITH
1269: 
1270:             *-- Get_SGRUPO direito (top=257+29=286, left=607, width=80)
1271:             loc_oPagina.AddObject("txt_4c_SGrupo", "TextBox")
1272:             WITH loc_oPagina.txt_4c_SGrupo
1273:                 .Top      = 286
1274:                 .Left     = 607
1275:                 .Width    = 80
1276:                 .Height   = 23
1277:                 .Value    = SPACE(10)
1278:                 .FontName = "Tahoma"
1279:                 .FontSize = 8
1280:                 .Visible  = .T.
1281:             ENDWITH
1282: 
1283:             *-- Get_sdgrupo desc. Grupo direito (top=257+29=286, left=689, width=290) - RO
1284:             loc_oPagina.AddObject("txt_4c_SDGrupo", "TextBox")
1285:             WITH loc_oPagina.txt_4c_SDGrupo
1286:                 .Top      = 286
1287:                 .Left     = 689
1288:                 .Width    = 290
1289:                 .Height   = 23
1290:                 .Value    = SPACE(40)
1291:                 .ReadOnly = .T.
1292:                 .BackColor = RGB(224, 224, 224)

*-- Linhas 1298 a 1320:
1298:             *-- Get_SCONTA direito (top=283+29=312, left=607, width=80)
1299:             loc_oPagina.AddObject("txt_4c_SConta", "TextBox")
1300:             WITH loc_oPagina.txt_4c_SConta
1301:                 .Top      = 312
1302:                 .Left     = 607
1303:                 .Width    = 80
1304:                 .Height   = 21
1305:                 .Value    = SPACE(10)
1306:                 .FontName = "Tahoma"
1307:                 .FontSize = 8
1308:                 .Visible  = .T.
1309:             ENDWITH
1310: 
1311:             *-- Get_SDCONTA desc. Conta direito (top=283+29=312, left=689, width=290) - RO
1312:             loc_oPagina.AddObject("txt_4c_SDcConta", "TextBox")
1313:             WITH loc_oPagina.txt_4c_SDcConta
1314:                 .Top      = 312
1315:                 .Left     = 689
1316:                 .Width    = 290
1317:                 .Height   = 21
1318:                 .Value    = SPACE(40)
1319:                 .ReadOnly = .T.
1320:                 .BackColor = RGB(224, 224, 224)

*-- Linhas 1326 a 1375:
1326:             *-- Get_SVALOR direito (top=309+29=338, left=607, width=128)
1327:             loc_oPagina.AddObject("txt_4c_SValor", "TextBox")
1328:             WITH loc_oPagina.txt_4c_SValor
1329:                 .Top      = 338
1330:                 .Left     = 607
1331:                 .Width    = 128
1332:                 .Height   = 23
1333:                 .Value    = 0.00
1334:                 .FontName = "Tahoma"
1335:                 .FontSize = 8
1336:                 .Visible  = .T.
1337:             ENDWITH
1338: 
1339:             *-- Get_smoeda direito (top=309+29=338, left=737, width=31)
1340:             loc_oPagina.AddObject("txt_4c_SMoeda", "TextBox")
1341:             WITH loc_oPagina.txt_4c_SMoeda
1342:                 .Top      = 338
1343:                 .Left     = 737
1344:                 .Width    = 31
1345:                 .Height   = 21
1346:                 .Value    = SPACE(3)
1347:                 .FontName = "Tahoma"
1348:                 .FontSize = 8
1349:                 .Visible  = .T.
1350:             ENDWITH
1351: 
1352:             *-- Get_SCOTACAO direito (top=309+29=338, left=843, width=108)
1353:             loc_oPagina.AddObject("txt_4c_SCotacao", "TextBox")
1354:             WITH loc_oPagina.txt_4c_SCotacao
1355:                 .Top      = 338
1356:                 .Left     = 843
1357:                 .Width    = 108
1358:                 .Height   = 21
1359:                 .Value    = 0.0000000
1360:                 .FontName = "Tahoma"
1361:                 .FontSize = 8
1362:                 .Visible  = .T.
1363:             ENDWITH
1364: 
1365:             *-- alterascotacao "$" direito (top=309+29=338, left=955, width=24)
1366:             loc_oPagina.AddObject("cmd_4c_AlteraSCotacao", "CommandButton")
1367:             WITH loc_oPagina.cmd_4c_AlteraSCotacao
1368:                 .Caption       = "$"
1369:                 .Top           = 338
1370:                 .Left          = 955
1371:                 .Width         = 24
1372:                 .Height        = 23
1373:                 .FontName      = "Tahoma"
1374:                 .FontSize      = 8
1375:                 .BackColor     = RGB(192, 192, 192)

*-- Linhas 1386 a 1459:
1386:             *-- Get_HIST "Historico" (top=358+29=387, left=112, width=300)
1387:             loc_oPagina.AddObject("txt_4c_Hist", "TextBox")
1388:             WITH loc_oPagina.txt_4c_Hist
1389:                 .Top      = 387
1390:                 .Left     = 112
1391:                 .Width    = 300
1392:                 .Height   = 21
1393:                 .Value    = SPACE(60)
1394:                 .FontName = "Tahoma"
1395:                 .FontSize = 8
1396:                 .Visible  = .T.
1397:             ENDWITH
1398: 
1399:             *-- Get_Hist2 "Historico 2" (top=358+29=387, left=415, width=300)
1400:             loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
1401:             WITH loc_oPagina.txt_4c_Hist2
1402:                 .Top      = 387
1403:                 .Left     = 415
1404:                 .Width    = 300
1405:                 .Height   = 21
1406:                 .Value    = SPACE(60)
1407:                 .FontName = "Tahoma"
1408:                 .FontSize = 8
1409:                 .Visible  = .T.
1410:             ENDWITH
1411: 
1412:             *-- Opcao_conta "Lancar Contas" (top=356+29=385, left=844, width=99, height=27)
1413:             loc_oPagina.AddObject("opt_4c_OpcaoConta", "OptionGroup")
1414:             WITH loc_oPagina.opt_4c_OpcaoConta
1415:                 .Top         = 385
1416:                 .Left        = 844
1417:                 .Width       = 99
1418:                 .Height      = 27
1419:                 .ButtonCount = 2
1420:                 .BorderStyle = 0
1421:                 .Themes      = .F.
1422:                 .Value       = 1
1423:                 .Visible     = .T.
1424:                 WITH .Buttons(1)
1425:                     .Caption   = "Sim"
1426:                     .Left      = 2
1427:                     .Top       = 3
1428:                     .Width     = 47
1429:                     .Height    = 21
1430:                     .AutoSize  = .F.
1431:                     .ForeColor = RGB(0, 0, 0)
1432:                     .Themes    = .F.
1433:                     .Visible   = .T.
1434:                 ENDWITH
1435:                 WITH .Buttons(2)
1436:                     .Caption   = "N" + CHR(227) + "o"
1437:                     .Left      = 51
1438:                     .Top       = 3
1439:                     .Width     = 46
1440:                     .Height    = 21
1441:                     .AutoSize  = .F.
1442:                     .ForeColor = RGB(0, 0, 0)
1443:                     .Themes    = .F.
1444:                     .Visible   = .T.
1445:                 ENDWITH
1446:             ENDWITH
1447: 
1448:             *--------------------------------------------------------------------
1449:             * BINDEVENTs Page2
1450:             *--------------------------------------------------------------------
1451:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
1452:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
1453:             BINDEVENT(loc_oPagina.cmd_4c_AlteraCotacao,                "Click", THIS, "BtnAlteraCotacaoClick")
1454:             BINDEVENT(loc_oPagina.cmd_4c_AlteraSCotacao,               "Click", THIS, "BtnAlteraSCotacaoClick")
1455: 
1456:             *-- Lookups LostFocus (valida codigo ao sair do campo)
1457:             BINDEVENT(loc_oPagina.txt_4c_Grupo,   "LostFocus", THIS, "GrupoLostFocus")
1458:             BINDEVENT(loc_oPagina.txt_4c_Conta,   "LostFocus", THIS, "ContaLostFocus")
1459:             BINDEVENT(loc_oPagina.txt_4c_Moeda,   "LostFocus", THIS, "MoedaLostFocus")

*-- Linhas 1538 a 1556:
1538:                     ENDIF
1539: 
1540:                     *-- Reconfigurar headers (seguranca apos operacoes no cursor)
1541:                     loc_oGrid.Column1.Header1.Caption  = "Data"
1542:                     loc_oGrid.Column2.Header1.Caption  = "O"
1543:                     loc_oGrid.Column3.Header1.Caption  = "Conta"
1544:                     loc_oGrid.Column4.Header1.Caption  = "Contrapartida"
1545:                     loc_oGrid.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
1546:                     loc_oGrid.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
1547:                     loc_oGrid.Column7.Header1.Caption  = "Cr" + CHR(233) + "dito"
1548:                     loc_oGrid.Column8.Header1.Caption  = ""
1549:                     loc_oGrid.Column9.Header1.Caption  = " "
1550:                     loc_oGrid.Column10.Header1.Caption = "NF"
1551:                     loc_oGrid.Column11.Header1.Caption = "Documento"
1552: 
1553:                     THIS.FormatarGridLista(loc_oGrid)
1554:                     loc_oGrid.Refresh()
1555:                     loc_lResultado = .T.
1556:                 ENDIF

*-- Linhas 2125 a 2135:
2125:             loc_oPagina.txt_4c_Hist2.ReadOnly    = loc_lRO
2126: 
2127:             loc_oPagina.opt_4c_OpcaoConta.Enabled      = par_lHabilitar
2128:             loc_oPagina.cmd_4c_AlteraCotacao.Enabled   = par_lHabilitar
2129:             loc_oPagina.cmd_4c_AlteraSCotacao.Enabled  = par_lHabilitar
2130:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
2131: 
2132:         CATCH TO loc_oErro
2133:             MsgErro(loc_oErro.Message, "HabilitarCamposDados")
2134:         ENDTRY
2135:     ENDPROC

*-- Linhas 2187 a 2203:
2187:             loc_oPagina = THIS.pgf_4c_Paginas.Page2
2188: 
2189:             *-- Confirmar: habilitado somente em INCLUIR ou ALTERAR
2190:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
2191: 
2192:             *-- Cancelar: sempre habilitado quando na Page2
2193:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
2194: 
2195:             *-- Botoes de cotacao: somente em edicao
2196:             IF PEMSTATUS(loc_oPagina, "cmd_4c_AlteraCotacao", 5)
2197:                 loc_oPagina.cmd_4c_AlteraCotacao.Enabled  = loc_lEdicao
2198:                 loc_oPagina.cmd_4c_AlteraSCotacao.Enabled = loc_lEdicao
2199:             ENDIF
2200: 
2201:         CATCH TO loc_oErro
2202:             MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")
2203:         ENDTRY


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*==============================================================================
* sigmvccrBO.prg - Business Object para Movimentos de Conta Corrente
* Data: 2026-04-11
* Tabela: SigMvCcr | PK: cidchaves (clustered)
* Operacao principal: nopers (numero da operacao)
*==============================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - campos BIT (logico)
    *--------------------------------------------------------------------------
    this_lAutos   = .F.    && autos   BIT - Lancamento automatico
    this_lConcs   = .F.    && concs   BIT - Conciliado

    *--------------------------------------------------------------------------
    * Propriedades - campos CHAR
    *--------------------------------------------------------------------------
    this_cEmps        = ""    && emps        CHAR(3)  - Empresa (FK)
    this_cEmpccs      = ""    && empccs      CHAR(3)  - Empresa contra-partida
    this_cEmpos       = ""    && empos       CHAR(3)  - Empresa origem

    this_cCidchaves   = ""    && cidchaves   CHAR(20) - Chave unica (PK)
    this_cGruconmoes  = ""    && gruconmoes  CHAR(23) - Grupos+Contas+Moedas (computado)
    this_cEmpdopncs   = ""    && empdopncs   CHAR(29) - Emps+Dopes+Numcs
    this_cEmpdopnums  = ""    && empdopnums  CHAR(29) - Emps+Dopes+Numes
    this_cDopotps     = ""    && dopotps     CHAR(23) - Dopes+Opers+Tipos+Pagos

    this_cDopes       = ""    && dopes       CHAR(20) - Operacao debito
    this_cDopcs       = ""    && dopcs       CHAR(20) - Operacao credito
    this_cVopers      = ""    && vopers      CHAR(13) - Operacao estendida
    this_cOpers       = ""    && opers       CHAR(1)  - Tipo D/C (debito/credito)
    this_cSopers      = ""    && sopers      CHAR(1)  - Tipo D/C contra-partida
    this_cTipos       = ""    && tipos       CHAR(1)  - Tipo de lancamento
    this_cPagos       = ""    && pagos       CHAR(1)  - Pago (S/N)

    this_cGrupos      = ""    && grupos      CHAR(10) - Grupo debito
    this_cContas      = ""    && contas      CHAR(10) - Conta debito
    this_cMoedas      = ""    && moedas      CHAR(3)  - Moeda debito
    this_cSgrupos     = ""    && sgrupos     CHAR(10) - Grupo credito
    this_cScontas     = ""    && scontas     CHAR(10) - Conta credito
    this_cSmoedas     = ""    && smoedas     CHAR(3)  - Moeda credito

    this_cContages    = ""    && contages    CHAR(10) - Conta gerencial
    this_cGrupages    = ""    && grupages    CHAR(10) - Grupo gerencial
    this_cContems     = ""    && contems     CHAR(10) - Conta empresa
    this_cGrupems     = ""    && grupems     CHAR(10) - Grupo empresa
    this_cLocals      = ""    && locals      CHAR(10) - Local
    this_cBcontas     = ""    && bcontas     CHAR(10) - Conta bancaria
    this_cBgrupos     = ""    && bgrupos     CHAR(10) - Grupo bancario
    this_cRcontas     = ""    && rcontas     CHAR(10) - Conta referencia
    this_cVlancs      = ""    && vlancs      CHAR(10) - Vinculo lancamento

    this_cNfs         = ""    && nfs         CHAR(10) - Numero nota fiscal
    this_cDocus       = ""    && docus       CHAR(10) - Documento
    this_cEspecienfs  = ""    && especienfs  CHAR(6)  - Especie NF
    this_cTpdocnf     = ""    && tpdocnf     CHAR(2)  - Tipo documento NF
    this_cTitulos     = ""    && titulos     CHAR(10) - Titulo
    this_cTitbans     = ""    && titbans     CHAR(12) - Titulo bancario
    this_cTitpais     = ""    && titpais     CHAR(10) - Titulo pai

    this_cHists       = ""    && hists       CHAR(60) - Historico
    this_cHist2s      = ""    && hist2s      CHAR(80) - Historico 2
    this_cShists      = ""    && shists      CHAR(40) - Historico complementar

    this_cJobs        = ""    && jobs        CHAR(10) - Job/Projeto
    this_cCompet      = ""    && compet      CHAR(7)  - Competencia (AAAAMM)
    this_cOridopnums  = ""    && oridopnums  CHAR(29) - Operacao origem
    this_cCotusus     = ""    && cotusus     CHAR(10) - Cotacao usuario

    this_cUsualts     = ""    && usualts     CHAR(10) - Usuario alteracao
    this_cUsuexcs     = ""    && usuexcs     CHAR(10) - Usuario exclusao
    this_cUsuconcs    = ""    && usuconcs    CHAR(10) - Usuario conciliacao
    this_cAuditors    = ""    && auditors    CHAR(10) - Auditor
    this_cUsuconfs    = ""    && usuconfs    CHAR(10) - Usuario confirmacao
    this_cUsupagos    = ""    && usupagos    CHAR(10) - Usuario pagamento

    this_cPastas      = ""    && pastas      TEXT     - Pasta (memo)

    *--------------------------------------------------------------------------
    * Propriedades - campos NUMERIC
    *--------------------------------------------------------------------------
    this_nNopers      = 0     && nopers      NUMERIC(7,0)   - Numero operacao
    this_nNumes       = 0     && numes       NUMERIC(6,0)   - Numero debito
    this_nNumcs       = 0     && numcs       NUMERIC(6,0)   - Numero credito
    this_nNlancs      = 0     && nlancs      NUMERIC(6,0)   - Numero lancamento
    this_nNtrans      = 0     && ntrans      NUMERIC(6,0)   - Numero transferencia
    this_nBorderos    = 0     && borderos    NUMERIC(6,0)   - Bordereau
    this_nIntconts    = 0     && intconts    NUMERIC(6,0)   - Integracao contabil
    this_nNopercancs  = 0     && nopercancs  NUMERIC(7,0)   - Numero operacao cancelada

    this_nCotacaos    = 0     && cotacaos    NUMERIC(15,7)  - Cotacao debito
    this_nScotacaos   = 0     && scotacaos   NUMERIC(15,7)  - Cotacao credito

    this_nValors      = 0     && valors      NUMERIC(11,2)  - Valor debito
    this_nSvalors     = 0     && svalors     NUMERIC(11,2)  - Valor credito
    this_nValliqs     = 0     && valliqs     NUMERIC(11,2)  - Valor liquido
    this_nValocurs    = 0     && valocurs    NUMERIC(11,2)  - Valor ocorrencia
    this_nValpags     = 0     && valpags     NUMERIC(11,2)  - Valor pago
    this_nValprev     = 0     && valprev     NUMERIC(11,2)  - Valor previsto
    this_nImpostos    = 0     && impostos    NUMERIC(11,2)  - Impostos

    this_nSaldos      = 0     && saldos      NUMERIC(15,2)  - Saldo geral
    this_nSaldocs     = 0     && saldocs     NUMERIC(15,2)  - Saldo credito
    this_nSaldons     = 0     && saldons     NUMERIC(15,2)  - Saldo debito

    this_nContapgs    = 0     && contapgs    NUMERIC(1,0)   - Opcao conta (0=Global/1=Cred/2=Deb)
    this_nTitcancs    = 0     && titcancs    NUMERIC(1,0)   - Titulo cancelado
    this_nTpimpostos  = 0     && tpimpostos  NUMERIC(2,0)   - Tipo imposto
    this_nRecor       = 0     && recor       NUMERIC(1,0)   - Recorrencia

    *--------------------------------------------------------------------------
    * Propriedades - campos DATETIME
    *--------------------------------------------------------------------------
    this_dDatas     = {}      && datas       DATETIME - Data lancamento
    this_dVencs     = {}      && vencs       DATETIME - Data vencimento
    this_dDtemis    = {}      && dtemis      DATETIME - Data emissao
    this_dDatalts   = {}      && datalts     DATETIME - Data alteracao
    this_dDatexcs   = {}      && datexcs     DATETIME - Data exclusao
    this_dDataconcs = {}      && dataconcs   DATETIME - Data conciliacao
    this_dDatatrans = {}      && datatrans   DATETIME - Data transferencia
    this_dDtaudits  = {}      && dtaudits    DATETIME - Data auditoria
    this_dDtconfs   = {}      && dtconfs     DATETIME - Data confirmacao

    *--------------------------------------------------------------------------
    * Propriedades de filtro para Buscar()
    *--------------------------------------------------------------------------
    this_dFiltroInicio = {}   && Data inicial do filtro de periodo
    this_dFiltroFim    = {}   && Data final do filtro de periodo

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigMvCcr"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista movimentos de conta corrente com filtro de periodo
    * par_cFiltro: clausula WHERE adicional (opcional)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF !EMPTY(THIS.this_dFiltroInicio) AND !EMPTY(THIS.this_dFiltroFim)
                loc_cWhere = loc_cWhere + ;
                    " AND a.Datas >= " + FormatarDataSQL(THIS.this_dFiltroInicio) + ;
                    " AND a.Datas < DATEADD(day, 1, " + FormatarDataSQL(THIS.this_dFiltroFim) + ")"
            ENDIF

            IF !EMPTY(par_cFiltro)
                loc_cWhere = loc_cWhere + " AND " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Vencs, a.Dtemis," + ;
                       " a.Grupos, a.Contas, a.Moedas, a.Opers," + ;
                       " a.Sgrupos, a.Scontas, a.Smoedas, a.Sopers," + ;
                       " a.Valors, a.Svalors, a.Cotacaos, a.Scotacaos," + ;
                       " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                       " a.Cidchaves, a.Autos, a.Concs," + ;
                       " a.Vopers, a.Dopes, a.Dopcs," + ;
                       " a.Jobs, a.Usualts, a.Contapgs," + ;
                       " a.Saldos, a.Saldocs, a.Saldons" + ;
                       " FROM SigMvCcr a" + ;
                       loc_cWhere + ;
                       " ORDER BY a.Datas, a.Nopers"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar movimentos de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Nopers, a.Datas, a.Vencs, a.Dtemis," + ;
                       " a.Grupos, a.Contas, a.Moedas, a.Opers," + ;
                       " a.Sgrupos, a.Scontas, a.Smoedas, a.Sopers," + ;
                       " a.Valors, a.Svalors, a.Cotacaos, a.Scotacaos," + ;
                       " a.Hists, a.Hist2s, a.Shists, a.Nfs, a.Docus," + ;
                       " a.Cidchaves, a.Autos, a.Concs, a.Pagos," + ;
                       " a.Vopers, a.Dopes, a.Dopcs," + ;
                       " a.Jobs, a.Usualts, a.Contapgs," + ;
                       " a.Saldos, a.Saldocs, a.Saldons," + ;
                       " a.Valliqs, a.Valocurs, a.Valpags, a.Valprev," + ;
                       " a.Impostos, a.Tpimpostos," + ;
                       " a.Nlancs, a.Ntrans, a.Numes, a.Numcs," + ;
                       " a.Borderos, a.Intconts, a.Nopercancs," + ;
                       " a.Titulos, a.Titbans, a.Titpais," + ;
                       " a.Contages, a.Grupages, a.Contems, a.Grupems," + ;
                       " a.Locals, a.Bcontas, a.Bgrupos, a.Rcontas," + ;
                       " a.Vlancs, a.Cotusus, a.Compet," + ;
                       " a.Empccs, a.Empos, a.Oridopnums," + ;
                       " a.Datalts, a.Datexcs, a.Dataconcs, a.Datatrans," + ;
                       " a.Dtaudits, a.Dtconfs," + ;
                       " a.Usualts, a.Usuexcs, a.Usuconcs, a.Auditors," + ;
                       " a.Usuconfs, a.Usupagos," + ;
                       " a.Tipos, a.Gruconmoes, a.Empdopncs, a.Empdopnums," + ;
                       " a.Dopotps, a.Titcancs, a.Especienfs, a.Tpdocnf," + ;
                       " a.Recor" + ;
                       " FROM SigMvCcr a" + ;
                       " WHERE a.Cidchaves = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    * SEMPRE usar SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves   = TratarNulo(cidchaves, "C")
                THIS.this_cEmps        = TratarNulo(emps, "C")
                THIS.this_nNopers      = TratarNulo(nopers, "N")
                THIS.this_dDatas       = TratarNulo(datas, "D")
                THIS.this_dVencs       = TratarNulo(vencs, "D")
                THIS.this_dDtemis      = TratarNulo(dtemis, "D")

                THIS.this_cGrupos      = TratarNulo(grupos, "C")
                THIS.this_cContas      = TratarNulo(contas, "C")
                THIS.this_cMoedas      = TratarNulo(moedas, "C")
                THIS.this_cOpers       = TratarNulo(opers, "C")
                THIS.this_cSgrupos     = TratarNulo(sgrupos, "C")
                THIS.this_cScontas     = TratarNulo(scontas, "C")
                THIS.this_cSmoedas     = TratarNulo(smoedas, "C")
                THIS.this_cSopers      = TratarNulo(sopers, "C")

                THIS.this_nValors      = TratarNulo(valors, "N")
                THIS.this_nSvalors     = TratarNulo(svalors, "N")
                THIS.this_nCotacaos    = TratarNulo(cotacaos, "N")
                THIS.this_nScotacaos   = TratarNulo(scotacaos, "N")

                THIS.this_cHists       = TratarNulo(hists, "C")
                THIS.this_cHist2s      = TratarNulo(hist2s, "C")
                THIS.this_cShists      = TratarNulo(shists, "C")
                THIS.this_cNfs         = TratarNulo(nfs, "C")
                THIS.this_cDocus       = TratarNulo(docus, "C")

                THIS.this_lAutos       = (IIF(VARTYPE(autos) = "L", autos, (NVL(autos, 0) = 1)))
                THIS.this_lConcs       = (IIF(VARTYPE(concs) = "L", concs, (NVL(concs, 0) = 1)))
                THIS.this_cPagos       = TratarNulo(pagos, "C")

                THIS.this_cVopers      = TratarNulo(vopers, "C")
                THIS.this_cDopes       = TratarNulo(dopes, "C")
                THIS.this_cDopcs       = TratarNulo(dopcs, "C")
                THIS.this_cJobs        = TratarNulo(jobs, "C")
                THIS.this_cUsualts     = TratarNulo(usualts, "C")
                THIS.this_nContapgs    = TratarNulo(contapgs, "N")

                THIS.this_nSaldos      = TratarNulo(saldos, "N")
                THIS.this_nSaldocs     = TratarNulo(saldocs, "N")
                THIS.this_nSaldons     = TratarNulo(saldons, "N")

                *-- Campos adicionais (presentes apenas em CarregarPorCodigo)
                IF PEMSTATUS((par_cAliasCursor), "nlancs", 8)
                    THIS.this_nNlancs    = TratarNulo(nlancs, "N")
                    THIS.this_nNtrans    = TratarNulo(ntrans, "N")
                    THIS.this_nNumes     = TratarNulo(numes, "N")
                    THIS.this_nNumcs     = TratarNulo(numcs, "N")
                    THIS.this_nBorderos  = TratarNulo(borderos, "N")
                    THIS.this_nIntconts  = TratarNulo(intconts, "N")
                    THIS.this_cTitulos   = TratarNulo(titulos, "C")
                    THIS.this_cTitbans   = TratarNulo(titbans, "C")
                    THIS.this_cTitpais   = TratarNulo(titpais, "C")
                    THIS.this_cContages  = TratarNulo(contages, "C")
                    THIS.this_cGrupages  = TratarNulo(grupages, "C")
                    THIS.this_cContems   = TratarNulo(contems, "C")
                    THIS.this_cGrupems   = TratarNulo(grupems, "C")
                    THIS.this_cLocals    = TratarNulo(locals, "C")
                    THIS.this_cBcontas   = TratarNulo(bcontas, "C")
                    THIS.this_cBgrupos   = TratarNulo(bgrupos, "C")
                    THIS.this_cRcontas   = TratarNulo(rcontas, "C")
                    THIS.this_cVlancs    = TratarNulo(vlancs, "C")
                    THIS.this_cCotusus   = TratarNulo(cotusus, "C")
                    THIS.this_cCompet    = TratarNulo(compet, "C")
                    THIS.this_cEmpccs    = TratarNulo(empccs, "C")
                    THIS.this_cEmpos     = TratarNulo(empos, "C")
                    THIS.this_cOridopnums = TratarNulo(oridopnums, "C")
                    THIS.this_dDatalts   = TratarNulo(datalts, "D")
                    THIS.this_dDatexcs   = TratarNulo(datexcs, "D")
                    THIS.this_dDataconcs = TratarNulo(dataconcs, "D")
                    THIS.this_dDatatrans = TratarNulo(datatrans, "D")
                    THIS.this_dDtaudits  = TratarNulo(dtaudits, "D")
                    THIS.this_dDtconfs   = TratarNulo(dtconfs, "D")
                    THIS.this_cUsuexcs   = TratarNulo(usuexcs, "C")
                    THIS.this_cUsuconcs  = TratarNulo(usuconcs, "C")
                    THIS.this_cAuditors  = TratarNulo(auditors, "C")
                    THIS.this_cUsuconfs  = TratarNulo(usuconfs, "C")
                    THIS.this_cUsupagos  = TratarNulo(usupagos, "C")
                    THIS.this_cTipos     = TratarNulo(tipos, "C")
                    THIS.this_cGruconmoes = TratarNulo(gruconmoes, "C")
                    THIS.this_cEmpdopncs  = TratarNulo(empdopncs, "C")
                    THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
                    THIS.this_cDopotps    = TratarNulo(dopotps, "C")
                    THIS.this_nTitcancs   = TratarNulo(titcancs, "N")
                    THIS.this_cEspecienfs = TratarNulo(especienfs, "C")
                    THIS.this_cTpdocnf    = TratarNulo(tpdocnf, "C")
                    THIS.this_nRecor      = TratarNulo(recor, "N")
                    THIS.this_nNopercancs = TratarNulo(nopercancs, "N")
                    THIS.this_nValliqs    = TratarNulo(valliqs, "N")
                    THIS.this_nValocurs   = TratarNulo(valocurs, "N")
                    THIS.this_nValpags    = TratarNulo(valpags, "N")
                    THIS.this_nValprev    = TratarNulo(valprev, "N")
                    THIS.this_nImpostos   = TratarNulo(impostos, "N")
                    THIS.this_nTpimpostos = TratarNulo(tpimpostos, "N")
                ENDIF

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro em SigMvCcr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_nNopers, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Obter proximo nopers para a empresa
            loc_cSQL = "SELECT ISNULL(MAX(Nopers), 0) + 1 AS ProxNopers" + ;
                       " FROM SigMvCcr WITH (UPDLOCK, HOLDLOCK)" + ;
                       " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF USED("cursor_4c_ProxNoper")
                USE IN cursor_4c_ProxNoper
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxNoper")

            IF loc_nResult < 0 OR RECCOUNT("cursor_4c_ProxNoper") = 0
                MsgErro("Erro ao obter numero de operacao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                IF USED("cursor_4c_ProxNoper")
                    USE IN cursor_4c_ProxNoper
                ENDIF
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_ProxNoper
            loc_nNopers = cursor_4c_ProxNoper.ProxNopers
            THIS.this_nNopers = loc_nNopers

            IF USED("cursor_4c_ProxNoper")
                USE IN cursor_4c_ProxNoper
            ENDIF

            *-- Gerar cidchaves: YYYYMMDD + nopers 6 digitos
            THIS.this_cCidchaves = DTOS(THIS.this_dDatas) + ;
                PADL(ALLTRIM(STR(loc_nNopers, 7, 0)), 7, "0")

            *-- Campos computados
            THIS.this_cGruconmoes  = ALLTRIM(THIS.this_cGrupos) + ;
                ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)
            THIS.this_cEmpdopncs   = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopcs) + ALLTRIM(STR(THIS.this_nNumcs, 6, 0))
            THIS.this_cEmpdopnums  = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopes) + ALLTRIM(STR(THIS.this_nNumes, 6, 0))
            THIS.this_cDopotps     = ALLTRIM(THIS.this_cDopes) + ;
                ALLTRIM(THIS.this_cOpers) + ALLTRIM(THIS.this_cTipos) + ;
                ALLTRIM(THIS.this_cPagos)

            *-- INSERT com colunas sem duplicatas (82 colunas)
            loc_cSQL = "INSERT INTO SigMvCcr (" + ;
                       " Emps, Nopers, Cidchaves, Datas, Vencs, Dtemis," + ;
                       " Grupos, Contas, Moedas, Opers," + ;
                       " Sgrupos, Scontas, Smoedas, Sopers," + ;
                       " Valors, Svalors, Cotacaos, Scotacaos," + ;
                       " Hists, Hist2s, Shists, Nfs, Docus," + ;
                       " Autos, Concs, Pagos, Tipos," + ;
                       " Vopers, Dopes, Dopcs, Jobs, Contapgs," + ;
                       " Saldos, Saldocs, Saldons," + ;
                       " Valliqs, Valocurs, Valpags, Valprev, Impostos, Tpimpostos," + ;
                       " Nlancs, Ntrans, Numes, Numcs, Borderos, Intconts, Nopercancs," + ;
                       " Titulos, Titbans, Titpais, Titcancs," + ;
                       " Contages, Grupages, Contems, Grupems," + ;
                       " Locals, Bcontas, Bgrupos, Rcontas, Vlancs, Cotusus," + ;
                       " Compet, Empccs, Empos, Oridopnums, Tpdocnf, Especienfs, Recor," + ;
                       " Gruconmoes, Empdopncs, Empdopnums, Dopotps," + ;
                       " Usualts, Usuexcs, Usuconcs, Auditors, Usuconfs, Usupagos" + ;
                       ") VALUES ("

            *-- Valores linha 1: chaves e datas (6 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopers) + "," + ;
                EscaparSQL(THIS.this_cCidchaves) + "," + ;
                FormatarDataSQL(THIS.this_dDatas) + "," + ;
                FormatarDataSQL(THIS.this_dVencs) + "," + ;
                FormatarDataSQL(THIS.this_dDtemis) + ","

            *-- Valores linha 2: grupos, contas, moedas, operacoes (8 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cGrupos) + "," + ;
                EscaparSQL(THIS.this_cContas) + "," + ;
                EscaparSQL(THIS.this_cMoedas) + "," + ;
                EscaparSQL(THIS.this_cOpers) + "," + ;
                EscaparSQL(THIS.this_cSgrupos) + "," + ;
                EscaparSQL(THIS.this_cScontas) + "," + ;
                EscaparSQL(THIS.this_cSmoedas) + "," + ;
                EscaparSQL(THIS.this_cSopers) + ","

            *-- Valores linha 3: valores e cotacoes (4 valores)
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                FormatarNumeroSQL(THIS.this_nScotacaos) + ","

            *-- Valores linha 4: historico, nf, documento (5 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cHists) + "," + ;
                EscaparSQL(THIS.this_cHist2s) + "," + ;
                EscaparSQL(THIS.this_cShists) + "," + ;
                EscaparSQL(THIS.this_cNfs) + "," + ;
                EscaparSQL(THIS.this_cDocus) + ","

            *-- Valores linha 5: flags, tipos, operacoes (11 valores)
            loc_cSQL = loc_cSQL + ;
                IIF(THIS.this_lAutos, "1", "0") + "," + ;
                IIF(THIS.this_lConcs, "1", "0") + "," + ;
                EscaparSQL(THIS.this_cPagos) + "," + ;
                EscaparSQL(THIS.this_cTipos) + "," + ;
                EscaparSQL(THIS.this_cVopers) + "," + ;
                EscaparSQL(THIS.this_cDopes) + "," + ;
                EscaparSQL(THIS.this_cDopcs) + "," + ;
                EscaparSQL(THIS.this_cJobs) + "," + ;
                FormatarNumeroSQL(THIS.this_nContapgs) + ","

            *-- Valores linha 6: saldos (3 valores)
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nSaldos) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldocs) + "," + ;
                FormatarNumeroSQL(THIS.this_nSaldons) + ","

            *-- Valores linha 7: valores complementares e numeradores (13 valores)
            loc_cSQL = loc_cSQL + ;
                FormatarNumeroSQL(THIS.this_nValliqs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValocurs) + "," + ;
                FormatarNumeroSQL(THIS.this_nValpags) + "," + ;
                FormatarNumeroSQL(THIS.this_nValprev) + "," + ;
                FormatarNumeroSQL(THIS.this_nImpostos) + "," + ;
                FormatarNumeroSQL(THIS.this_nTpimpostos) + "," + ;
                FormatarNumeroSQL(THIS.this_nNlancs) + "," + ;
                FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                FormatarNumeroSQL(THIS.this_nBorderos) + "," + ;
                FormatarNumeroSQL(THIS.this_nIntconts) + "," + ;
                FormatarNumeroSQL(THIS.this_nNopercancs) + ","

            *-- Valores linha 8: titulos (4 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cTitulos) + "," + ;
                EscaparSQL(THIS.this_cTitbans) + "," + ;
                EscaparSQL(THIS.this_cTitpais) + "," + ;
                FormatarNumeroSQL(THIS.this_nTitcancs) + ","

            *-- Valores linha 9: contas gerenciais (6 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cContages) + "," + ;
                EscaparSQL(THIS.this_cGrupages) + "," + ;
                EscaparSQL(THIS.this_cContems) + "," + ;
                EscaparSQL(THIS.this_cGrupems) + "," + ;
                EscaparSQL(THIS.this_cLocals) + "," + ;
                EscaparSQL(THIS.this_cBcontas) + "," + ;
                EscaparSQL(THIS.this_cBgrupos) + "," + ;
                EscaparSQL(THIS.this_cRcontas) + "," + ;
                EscaparSQL(THIS.this_cVlancs) + "," + ;
                EscaparSQL(THIS.this_cCotusus) + ","

            *-- Valores linha 10: empresa/compet e campos computados (17 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(THIS.this_cCompet) + "," + ;
                EscaparSQL(THIS.this_cEmpccs) + "," + ;
                EscaparSQL(THIS.this_cEmpos) + "," + ;
                EscaparSQL(THIS.this_cOridopnums) + "," + ;
                EscaparSQL(THIS.this_cTpdocnf) + "," + ;
                EscaparSQL(THIS.this_cEspecienfs) + "," + ;
                FormatarNumeroSQL(THIS.this_nRecor) + "," + ;
                EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                EscaparSQL(THIS.this_cEmpdopncs) + "," + ;
                EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                EscaparSQL(THIS.this_cDopotps) + ","

            *-- Valores linha 11: usuarios de auditoria (6 valores)
            loc_cSQL = loc_cSQL + ;
                EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + "," + ;
                EscaparSQL("") + ;
                ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente em SigMvCcr
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campos computados
            THIS.this_cGruconmoes  = ALLTRIM(THIS.this_cGrupos) + ;
                ALLTRIM(THIS.this_cContas) + ALLTRIM(THIS.this_cMoedas)
            THIS.this_cEmpdopncs   = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopcs) + ALLTRIM(STR(THIS.this_nNumcs, 6, 0))
            THIS.this_cEmpdopnums  = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                ALLTRIM(THIS.this_cDopes) + ALLTRIM(STR(THIS.this_nNumes, 6, 0))
            THIS.this_cDopotps     = ALLTRIM(THIS.this_cDopes) + ;
                ALLTRIM(THIS.this_cOpers) + ALLTRIM(THIS.this_cTipos) + ;
                ALLTRIM(THIS.this_cPagos)

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                       " Datas = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " Vencs = " + FormatarDataSQL(THIS.this_dVencs) + "," + ;
                       " Dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + "," + ;
                       " Grupos = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                       " Contas = " + EscaparSQL(THIS.this_cContas) + "," + ;
                       " Moedas = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                       " Opers = " + EscaparSQL(THIS.this_cOpers) + "," + ;
                       " Sgrupos = " + EscaparSQL(THIS.this_cSgrupos) + "," + ;
                       " Scontas = " + EscaparSQL(THIS.this_cScontas) + "," + ;
                       " Smoedas = " + EscaparSQL(THIS.this_cSmoedas) + "," + ;
                       " Sopers = " + EscaparSQL(THIS.this_cSopers) + ","

            loc_cSQL = loc_cSQL + ;
                       " Valors = " + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                       " Svalors = " + FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                       " Cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                       " Scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos) + "," + ;
                       " Hists = " + EscaparSQL(THIS.this_cHists) + "," + ;
                       " Hist2s = " + EscaparSQL(THIS.this_cHist2s) + "," + ;
                       " Shists = " + EscaparSQL(THIS.this_cShists) + "," + ;
                       " Nfs = " + EscaparSQL(THIS.this_cNfs) + "," + ;
                       " Docus = " + EscaparSQL(THIS.this_cDocus) + ","

            loc_cSQL = loc_cSQL + ;
                       " Contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs) + "," + ;
                       " Jobs = " + EscaparSQL(THIS.this_cJobs) + "," + ;
                       " Vopers = " + EscaparSQL(THIS.this_cVopers) + "," + ;
                       " Dopes = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                       " Dopcs = " + EscaparSQL(THIS.this_cDopcs) + "," + ;
                       " Gruconmoes = " + EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                       " Empdopncs = " + EscaparSQL(THIS.this_cEmpdopncs) + "," + ;
                       " Empdopnums = " + EscaparSQL(THIS.this_cEmpdopnums) + "," + ;
                       " Dopotps = " + EscaparSQL(THIS.this_cDopotps) + "," + ;
                       " Usualts = " + EscaparSQL(gc_4c_UsuarioLogado) + "," + ;
                       " Datalts = GETDATE()" + ;
                       " WHERE Cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Update")
                    USE IN cursor_4c_Update
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro de SigMvCcr por cidchaves
    * Nota: Registra data/usuario de exclusao antes de deletar fisicamente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Marcar exclusao logica primeiro (DatExcs/UsuExcs)
            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                       " Datexcs = GETDATE()," + ;
                       " Usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE Cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdExc")

            IF loc_nResult < 0
                MsgErro("Erro ao marcar exclusao:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_UpdExc")
                    USE IN cursor_4c_UpdExc
                ENDIF

                *-- Exclusao fisica
                loc_cSQL = "DELETE FROM SigMvCcr" + ;
                           " WHERE Cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir movimento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    IF USED("cursor_4c_Delete")
                        USE IN cursor_4c_Delete
                    ENDIF
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

