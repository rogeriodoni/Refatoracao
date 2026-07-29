# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDCHM.Pagina.Dados): Top original=137 vs migrado 'lbl_4c_Label11' Top=345 (diff=208px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'fwget1' (parent: SIGCDCHM.Pagina.Dados): Top original=133 vs migrado 'txt_4c_Fwget17' Top=366 (diff=233px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCHM.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1600 linhas total):

*-- Linhas 46 a 62:
46:                             "Erro Cr" + CHR(237) + "tico")
47:                 loc_lSucesso = .F.
48:             ELSE
49:                 THIS.Caption = "Cadastro de Configura" + CHR(231) + CHR(227) + ;
50:                                "o do Cheque - Matricial"
51: 
52:                 THIS.ConfigurarPageFrame()
53:                 THIS.ConfigurarPaginaLista()
54:                 THIS.ConfigurarPaginaDados()
55: 
56:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = ;
58:                     THIS.Caption
59: 
60:                 IF NOT (TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
61:                     THIS.CarregarLista()
62:                 ENDIF

*-- Linhas 79 a 113:
79: 
80:     *--------------------------------------------------------------------------
81:     * ConfigurarPageFrame - Configura o PageFrame principal
82:     * Legado: Pagina.Top=-29 (oculta abas), Width=1003, Height=629
83:     *--------------------------------------------------------------------------
84:     PROTECTED PROCEDURE ConfigurarPageFrame()
85:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
86: 
87:         WITH THIS.pgf_4c_Paginas
88:             .Top       = -29
89:             .Left      = 0
90:             .Width     = 1003
91:             .Height    = 629
92:             .PageCount = 2
93:             .Tabs      = .F.
94:             .Visible   = .T.
95: 
96:             .Page1.Caption   = "Lista"
97:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
98:             .Page1.BackColor = RGB(255, 255, 255)
99: 
100:             .Page2.Caption   = "Dados"
101:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page2.BackColor = RGB(255, 255, 255)
103:         ENDWITH
104:     ENDPROC
105: 
106:     *--------------------------------------------------------------------------
107:     * ConfigurarPaginaLista - Configura Page1 (Lista) com Grid e Botoes CRUD
108:     * Compensacao PageFrame.Top=-29: Top_original + 29
109:     * Grade legado: top=119+29=148, left=32, width=940, height=470
110:     * cnt_4c_Botoes canonico: Left=542, Top=29
111:     * cnt_4c_Saida canonico: Left=917 (Rule #10)
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()

*-- Linhas 119 a 156:
119:         *-- Container de cabecalho (cntSombra: Top=2+29=31)
120:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
121:         WITH loc_oPagina.cnt_4c_Cabecalho
122:             .Top         = 31
123:             .Left        = 0
124:             .Width       = THIS.Width
125:             .Height      = 80
126:             .BackStyle   = 0
127:             .BorderWidth = 0
128:             .Visible     = .T.
129:         ENDWITH
130: 
131:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
132:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
133:             .Caption   = THIS.Caption
134:             .Top       = 16
135:             .Left      = 11
136:             .Width     = THIS.Width
137:             .Height    = 40
138:             .AutoSize  = .F.
139:             .FontName  = "Tahoma"
140:             .FontSize  = 16
141:             .FontBold  = .T.
142:             .BackStyle = 0
143:             .ForeColor = RGB(0, 0, 0)
144:             .Visible   = .T.
145:         ENDWITH
146: 
147:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
148:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = THIS.Width
153:             .Height    = 46
154:             .AutoSize  = .F.
155:             .FontName  = "Tahoma"
156:             .FontSize  = 16

*-- Linhas 163 a 187:
163:         *-- Container de botoes CRUD (canonico Left=542, Top=29)
164:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
165:         WITH loc_oPagina.cnt_4c_Botoes
166:             .Top         = 29
167:             .Left        = 542
168:             .Width       = 390
169:             .Height      = 85
170:             .BackStyle   = 0
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         *-- Botao Incluir (Left=5)
176:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
177:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
178:             .Caption         = "Incluir"
179:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:             .PicturePosition = 13
181:             .Top             = 5
182:             .Left            = 5
183:             .Width           = 75
184:             .Height          = 75
185:             .FontName        = "Tahoma"
186:             .FontBold        = .T.
187:             .FontItalic      = .T.

*-- Linhas 197 a 211:
197:         ENDWITH
198: 
199:         *-- Botao Visualizar (Left=80)
200:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
201:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
202:             .Caption         = "Visualizar"
203:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
204:             .PicturePosition = 13
205:             .Top             = 5
206:             .Left            = 80
207:             .Width           = 75
208:             .Height          = 75
209:             .FontName        = "Tahoma"
210:             .FontBold        = .T.
211:             .FontItalic      = .T.

*-- Linhas 221 a 235:
221:         ENDWITH
222: 
223:         *-- Botao Alterar (Left=155)
224:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
225:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
226:             .Caption         = "Alterar"
227:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
228:             .PicturePosition = 13
229:             .Top             = 5
230:             .Left            = 155
231:             .Width           = 75
232:             .Height          = 75
233:             .FontName        = "Tahoma"
234:             .FontBold        = .T.
235:             .FontItalic      = .T.

*-- Linhas 245 a 259:
245:         ENDWITH
246: 
247:         *-- Botao Excluir (Left=230)
248:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
249:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
250:             .Caption         = "Excluir"
251:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
252:             .PicturePosition = 13
253:             .Top             = 5
254:             .Left            = 230
255:             .Width           = 75
256:             .Height          = 75
257:             .FontName        = "Tahoma"
258:             .FontBold        = .T.
259:             .FontItalic      = .T.

*-- Linhas 269 a 283:
269:         ENDWITH
270: 
271:         *-- Botao Buscar (Left=305)
272:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
273:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
274:             .Caption         = "Buscar"
275:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
276:             .PicturePosition = 13
277:             .Top             = 5
278:             .Left            = 305
279:             .Width           = 75
280:             .Height          = 75
281:             .FontName        = "Tahoma"
282:             .FontBold        = .T.
283:             .FontItalic      = .T.

*-- Linhas 295 a 319:
295:         *-- Container de saida/encerrar (canonico Left=917, Width=90, Rule #10)
296:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
297:         WITH loc_oPagina.cnt_4c_Saida
298:             .Top         = 29
299:             .Left        = 917
300:             .Width       = 90
301:             .Height      = 85
302:             .BackStyle   = 0
303:             .BorderWidth = 0
304:             .Visible     = .T.
305:         ENDWITH
306: 
307:         *-- Botao Encerrar (canonico Width=75, Height=75, Caption="Encerrar")
308:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
309:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
310:             .Caption         = "Encerrar"
311:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
312:             .PicturePosition = 13
313:             .Top             = 5
314:             .Left            = 5
315:             .Width           = 75
316:             .Height          = 75
317:             .FontName        = "Tahoma"
318:             .FontBold        = .T.
319:             .FontItalic      = .T.

*-- Linhas 332 a 341:
332:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
333:         loc_oGrid = loc_oPagina.grd_4c_Lista
334: 
335:         loc_oGrid.Top                = 148
336:         loc_oGrid.Left               = 32
337:         loc_oGrid.Width              = 940
338:         loc_oGrid.Height             = 470
339:         loc_oGrid.FontName           = "Verdana"
340:         loc_oGrid.FontSize           = 8
341:         loc_oGrid.ForeColor          = RGB(90, 90, 90)

*-- Linhas 353 a 402:
353:         loc_oGrid.Visible            = .T.
354: 
355:         *-- BINDEVENTs para botoes CRUD (metodos PUBLIC - BINDEVENT exige PUBLIC)
356:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
357:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
358:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
359:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
360:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
361:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
362: 
363:         THIS.TornarControlesVisiveis(loc_oPagina)
364:     ENDPROC
365: 
366:     *--------------------------------------------------------------------------
367:     * ConfigurarPaginaDados - Configura Page2 (Dados)
368:     * Compensacao PageFrame.Top=-29: Top_original + 29
369:     * Legado: Grupo_Salva.Left=627, Top=6+29=35, Width=172, Height=85
370:     * Fase 5/8: Botoes Confirmar/Cancelar + 1a metade dos campos
371:     *--------------------------------------------------------------------------
372:     PROTECTED PROCEDURE ConfigurarPaginaDados()
373:         LOCAL loc_oPagina
374:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
375: 
376:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
377: 
378:         *-- Container botoes Salvar/Cancelar (Grupo_Salva.Left=627, Top=6+29=35)
379:         loc_oPagina.AddObject("cnt_4c_BotoesDados", "Container")
380:         WITH loc_oPagina.cnt_4c_BotoesDados
381:             .Top         = 35
382:             .Left        = 627
383:             .Width       = 172
384:             .Height      = 85
385:             .BackStyle   = 0
386:             .BorderWidth = 0
387:             .Visible     = .T.
388:         ENDWITH
389: 
390:         *-- Botao Confirmar (Salva.Left=11, Top=5)
391:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Confirmar", "CommandButton")
392:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Confirmar
393:             .Caption         = "Confirmar"
394:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
395:             .PicturePosition = 13
396:             .Top             = 5
397:             .Left            = 11
398:             .Width           = 75
399:             .Height          = 75
400:             .FontName        = "Tahoma"
401:             .FontBold        = .T.
402:             .FontItalic      = .T.

*-- Linhas 411 a 426:
411:             .Visible         = .T.
412:         ENDWITH
413: 
414:         *-- Botao Cancelar (Cancelar.Left=88, Top=5)
415:         loc_oPagina.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
416:         WITH loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar
417:             .Caption         = "Encerrar"
418:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
419:             .PicturePosition = 13
420:             .Top             = 5
421:             .Left            = 88
422:             .Width           = 75
423:             .Height          = 75
424:             .FontName        = "Tahoma"
425:             .FontBold        = .T.
426:             .FontItalic      = .T.

*-- Linhas 435 a 453:
435:             .Visible         = .T.
436:         ENDWITH
437: 
438:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
439:         BINDEVENT(loc_oPagina.cnt_4c_BotoesDados.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
440: 
441:         *----------------------------------------------------------------------
442:         *  BANCO (Get_Banco: top=66+29=95, left=251, width=45)
443:         *----------------------------------------------------------------------
444:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
445:         WITH loc_oPagina.lbl_4c_Label2
446:             .Caption   = "Banco :"
447:             .Top       = 99
448:             .Left      = 204
449:             .Width     = 42
450:             .Height    = 15
451:             .AutoSize  = .T.
452:             .FontName  = "Tahoma"
453:             .FontSize  = 8

*-- Linhas 460 a 469:
460:         loc_oPagina.AddObject("txt_4c_Banco", "TextBox")
461:         WITH loc_oPagina.txt_4c_Banco
462:             .Value        = ""
463:             .Top          = 95
464:             .Left         = 251
465:             .Width        = 45
466:             .Height       = 23
467:             .FontName     = "Tahoma"
468:             .FontSize     = 8
469:             .MaxLength    = 10

*-- Linhas 476 a 504:
476:         *  CABECALHOS DAS COLUNAS (Label3 Linha / Label4 Coluna)
477:         *  top=116+29=145 / top=115+29=144
478:         *----------------------------------------------------------------------
479:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
480:         WITH loc_oPagina.lbl_4c_Label3
481:             .Caption   = "Linha"
482:             .Top       = 145
483:             .Left      = 254
484:             .Width     = 32
485:             .Height    = 15
486:             .AutoSize  = .T.
487:             .FontName  = "Tahoma"
488:             .FontSize  = 8
489:             .FontBold  = .T.
490:             .BackStyle = 0
491:             .ForeColor = RGB(90, 90, 90)
492:             .Visible   = .T.
493:         ENDWITH
494: 
495:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
496:         WITH loc_oPagina.lbl_4c_Label4
497:             .Caption   = "Coluna"
498:             .Top       = 144
499:             .Left      = 336
500:             .Width     = 40
501:             .Height    = 15
502:             .AutoSize  = .T.
503:             .FontName  = "Tahoma"
504:             .FontSize  = 8

*-- Linhas 511 a 523:
511:         *----------------------------------------------------------------------
512:         *  VALOR (Label1: top=137+29=166; fwget1/2: top=133+29=162)
513:         *----------------------------------------------------------------------
514:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
515:         WITH loc_oPagina.lbl_4c_Label1
516:             .Caption   = "Valor :"
517:             .Top       = 166
518:             .Left      = 213
519:             .Width     = 33
520:             .Height    = 15
521:             .AutoSize  = .T.
522:             .FontName  = "Tahoma"
523:             .FontSize  = 8

*-- Linhas 530 a 570:
530:         loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
531:         WITH loc_oPagina.txt_4c_Fwget1
532:             .Value     = 0
533:             .Top       = 162
534:             .Left      = 250
535:             .Width     = 51
536:             .Height    = 23
537:             .FontName  = "Tahoma"
538:             .FontSize  = 8
539:             .BackColor = RGB(255, 255, 255)
540:             .ForeColor = RGB(90, 90, 90)
541:             .Visible   = .T.
542:         ENDWITH
543: 
544:         loc_oPagina.AddObject("txt_4c_Fwget2", "TextBox")
545:         WITH loc_oPagina.txt_4c_Fwget2
546:             .Value     = 0
547:             .Top       = 162
548:             .Left      = 335
549:             .Width     = 51
550:             .Height    = 23
551:             .FontName  = "Tahoma"
552:             .FontSize  = 8
553:             .BackColor = RGB(255, 255, 255)
554:             .ForeColor = RGB(90, 90, 90)
555:             .Visible   = .T.
556:         ENDWITH
557: 
558:         *----------------------------------------------------------------------
559:         *  VALOR EXTENSO 1 (Label5: top=163+29=192; fwget3/4: top=159+29=188)
560:         *----------------------------------------------------------------------
561:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
562:         WITH loc_oPagina.lbl_4c_Label5
563:             .Caption   = "Valor Extenso 1 :"
564:             .Top       = 192
565:             .Left      = 162
566:             .Width     = 84
567:             .Height    = 15
568:             .AutoSize  = .T.
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8

*-- Linhas 577 a 617:
577:         loc_oPagina.AddObject("txt_4c_Fwget3", "TextBox")
578:         WITH loc_oPagina.txt_4c_Fwget3
579:             .Value     = 0
580:             .Top       = 188
581:             .Left      = 250
582:             .Width     = 51
583:             .Height    = 23
584:             .FontName  = "Tahoma"
585:             .FontSize  = 8
586:             .BackColor = RGB(255, 255, 255)
587:             .ForeColor = RGB(90, 90, 90)
588:             .Visible   = .T.
589:         ENDWITH
590: 
591:         loc_oPagina.AddObject("txt_4c_Fwget4", "TextBox")
592:         WITH loc_oPagina.txt_4c_Fwget4
593:             .Value     = 0
594:             .Top       = 188
595:             .Left      = 335
596:             .Width     = 51
597:             .Height    = 23
598:             .FontName  = "Tahoma"
599:             .FontSize  = 8
600:             .BackColor = RGB(255, 255, 255)
601:             .ForeColor = RGB(90, 90, 90)
602:             .Visible   = .T.
603:         ENDWITH
604: 
605:         *----------------------------------------------------------------------
606:         *  VALOR EXTENSO 2 (Label6: top=189+29=218; fwget5/6: top=185+29=214)
607:         *----------------------------------------------------------------------
608:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
609:         WITH loc_oPagina.lbl_4c_Label6
610:             .Caption   = "Valor Extenso 2 :"
611:             .Top       = 218
612:             .Left      = 162
613:             .Width     = 84
614:             .Height    = 15
615:             .AutoSize  = .T.
616:             .FontName  = "Tahoma"
617:             .FontSize  = 8

*-- Linhas 624 a 664:
624:         loc_oPagina.AddObject("txt_4c_Fwget5", "TextBox")
625:         WITH loc_oPagina.txt_4c_Fwget5
626:             .Value     = 0
627:             .Top       = 214
628:             .Left      = 250
629:             .Width     = 51
630:             .Height    = 23
631:             .FontName  = "Tahoma"
632:             .FontSize  = 8
633:             .BackColor = RGB(255, 255, 255)
634:             .ForeColor = RGB(90, 90, 90)
635:             .Visible   = .T.
636:         ENDWITH
637: 
638:         loc_oPagina.AddObject("txt_4c_Fwget6", "TextBox")
639:         WITH loc_oPagina.txt_4c_Fwget6
640:             .Value     = 0
641:             .Top       = 214
642:             .Left      = 335
643:             .Width     = 51
644:             .Height    = 23
645:             .FontName  = "Tahoma"
646:             .FontSize  = 8
647:             .BackColor = RGB(255, 255, 255)
648:             .ForeColor = RGB(90, 90, 90)
649:             .Visible   = .T.
650:         ENDWITH
651: 
652:         *----------------------------------------------------------------------
653:         *  FAVORECIDO (Label7: top=215+29=244; fwget7/8: top=211+29=240)
654:         *----------------------------------------------------------------------
655:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
656:         WITH loc_oPagina.lbl_4c_Label7
657:             .Caption   = "Favorecido :"
658:             .Top       = 244
659:             .Left      = 184
660:             .Width     = 62
661:             .Height    = 15
662:             .AutoSize  = .T.
663:             .FontName  = "Tahoma"
664:             .FontSize  = 8

*-- Linhas 671 a 711:
671:         loc_oPagina.AddObject("txt_4c_Fwget7", "TextBox")
672:         WITH loc_oPagina.txt_4c_Fwget7
673:             .Value     = 0
674:             .Top       = 240
675:             .Left      = 250
676:             .Width     = 51
677:             .Height    = 23
678:             .FontName  = "Tahoma"
679:             .FontSize  = 8
680:             .BackColor = RGB(255, 255, 255)
681:             .ForeColor = RGB(90, 90, 90)
682:             .Visible   = .T.
683:         ENDWITH
684: 
685:         loc_oPagina.AddObject("txt_4c_Fwget8", "TextBox")
686:         WITH loc_oPagina.txt_4c_Fwget8
687:             .Value     = 0
688:             .Top       = 240
689:             .Left      = 335
690:             .Width     = 51
691:             .Height    = 23
692:             .FontName  = "Tahoma"
693:             .FontSize  = 8
694:             .BackColor = RGB(255, 255, 255)
695:             .ForeColor = RGB(90, 90, 90)
696:             .Visible   = .T.
697:         ENDWITH
698: 
699:         *----------------------------------------------------------------------
700:         *  LOCALIDADE (Label8: top=241+29=270; fwget9/10: top=236+29=265)
701:         *----------------------------------------------------------------------
702:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
703:         WITH loc_oPagina.lbl_4c_Label8
704:             .Caption   = "Localidade :"
705:             .Top       = 270
706:             .Left      = 187
707:             .Width     = 59
708:             .Height    = 15
709:             .AutoSize  = .T.
710:             .FontName  = "Tahoma"
711:             .FontSize  = 8

*-- Linhas 718 a 758:
718:         loc_oPagina.AddObject("txt_4c_Fwget9", "TextBox")
719:         WITH loc_oPagina.txt_4c_Fwget9
720:             .Value     = 0
721:             .Top       = 265
722:             .Left      = 250
723:             .Width     = 51
724:             .Height    = 23
725:             .FontName  = "Tahoma"
726:             .FontSize  = 8
727:             .BackColor = RGB(255, 255, 255)
728:             .ForeColor = RGB(90, 90, 90)
729:             .Visible   = .T.
730:         ENDWITH
731: 
732:         loc_oPagina.AddObject("txt_4c_Fwget10", "TextBox")
733:         WITH loc_oPagina.txt_4c_Fwget10
734:             .Value     = 0
735:             .Top       = 265
736:             .Left      = 335
737:             .Width     = 51
738:             .Height    = 23
739:             .FontName  = "Tahoma"
740:             .FontSize  = 8
741:             .BackColor = RGB(255, 255, 255)
742:             .ForeColor = RGB(90, 90, 90)
743:             .Visible   = .T.
744:         ENDWITH
745: 
746:         *----------------------------------------------------------------------
747:         *  DIA (Label9: top=266+29=295; fwget11/12: top=261+29=290)
748:         *----------------------------------------------------------------------
749:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
750:         WITH loc_oPagina.lbl_4c_Label9
751:             .Caption   = "Dia :"
752:             .Top       = 295
753:             .Left      = 222
754:             .Width     = 24
755:             .Height    = 15
756:             .AutoSize  = .T.
757:             .FontName  = "Tahoma"
758:             .FontSize  = 8

*-- Linhas 765 a 805:
765:         loc_oPagina.AddObject("txt_4c_Fwget11", "TextBox")
766:         WITH loc_oPagina.txt_4c_Fwget11
767:             .Value     = 0
768:             .Top       = 290
769:             .Left      = 250
770:             .Width     = 51
771:             .Height    = 23
772:             .FontName  = "Tahoma"
773:             .FontSize  = 8
774:             .BackColor = RGB(255, 255, 255)
775:             .ForeColor = RGB(90, 90, 90)
776:             .Visible   = .T.
777:         ENDWITH
778: 
779:         loc_oPagina.AddObject("txt_4c_Fwget12", "TextBox")
780:         WITH loc_oPagina.txt_4c_Fwget12
781:             .Value     = 0
782:             .Top       = 290
783:             .Left      = 335
784:             .Width     = 51
785:             .Height    = 23
786:             .FontName  = "Tahoma"
787:             .FontSize  = 8
788:             .BackColor = RGB(255, 255, 255)
789:             .ForeColor = RGB(90, 90, 90)
790:             .Visible   = .T.
791:         ENDWITH
792: 
793:         *----------------------------------------------------------------------
794:         *  MES (Label10: top=291+29=320; fwget13/14: top=286+29=315)
795:         *----------------------------------------------------------------------
796:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
797:         WITH loc_oPagina.lbl_4c_Label10
798:             .Caption   = "Mes :"
799:             .Top       = 320
800:             .Left      = 218
801:             .Width     = 28
802:             .Height    = 15
803:             .AutoSize  = .T.
804:             .FontName  = "Tahoma"
805:             .FontSize  = 8

*-- Linhas 812 a 852:
812:         loc_oPagina.AddObject("txt_4c_Fwget13", "TextBox")
813:         WITH loc_oPagina.txt_4c_Fwget13
814:             .Value     = 0
815:             .Top       = 315
816:             .Left      = 250
817:             .Width     = 51
818:             .Height    = 23
819:             .FontName  = "Tahoma"
820:             .FontSize  = 8
821:             .BackColor = RGB(255, 255, 255)
822:             .ForeColor = RGB(90, 90, 90)
823:             .Visible   = .T.
824:         ENDWITH
825: 
826:         loc_oPagina.AddObject("txt_4c_Fwget14", "TextBox")
827:         WITH loc_oPagina.txt_4c_Fwget14
828:             .Value     = 0
829:             .Top       = 315
830:             .Left      = 335
831:             .Width     = 51
832:             .Height    = 23
833:             .FontName  = "Tahoma"
834:             .FontSize  = 8
835:             .BackColor = RGB(255, 255, 255)
836:             .ForeColor = RGB(90, 90, 90)
837:             .Visible   = .T.
838:         ENDWITH
839: 
840:         *----------------------------------------------------------------------
841:         *  ANO (Label11: top=316+29=345; fwget15/16: top=311+29=340)
842:         *----------------------------------------------------------------------
843:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
844:         WITH loc_oPagina.lbl_4c_Label11
845:             .Caption   = "Ano :"
846:             .Top       = 345
847:             .Left      = 218
848:             .Width     = 28
849:             .Height    = 15
850:             .AutoSize  = .T.
851:             .FontName  = "Tahoma"
852:             .FontSize  = 8

*-- Linhas 859 a 934:
859:         loc_oPagina.AddObject("txt_4c_Fwget15", "TextBox")
860:         WITH loc_oPagina.txt_4c_Fwget15
861:             .Value     = 0
862:             .Top       = 340
863:             .Left      = 250
864:             .Width     = 51
865:             .Height    = 23
866:             .FontName  = "Tahoma"
867:             .FontSize  = 8
868:             .BackColor = RGB(255, 255, 255)
869:             .ForeColor = RGB(90, 90, 90)
870:             .Visible   = .T.
871:         ENDWITH
872: 
873:         loc_oPagina.AddObject("txt_4c_Fwget16", "TextBox")
874:         WITH loc_oPagina.txt_4c_Fwget16
875:             .Value     = 0
876:             .Top       = 340
877:             .Left      = 335
878:             .Width     = 51
879:             .Height    = 23
880:             .FontName  = "Tahoma"
881:             .FontSize  = 8
882:             .BackColor = RGB(255, 255, 255)
883:             .ForeColor = RGB(90, 90, 90)
884:             .Visible   = .T.
885:         ENDWITH
886: 
887:         *----------------------------------------------------------------------
888:         *  LOCAL (Label12: top=340+29=369; fwget17: top=337+29=366)
889:         *----------------------------------------------------------------------
890:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
891:         WITH loc_oPagina.lbl_4c_Label12
892:             .Caption   = "Local :"
893:             .Top       = 369
894:             .Left      = 213
895:             .Width     = 33
896:             .Height    = 15
897:             .AutoSize  = .T.
898:             .FontName  = "Tahoma"
899:             .FontSize  = 8
900:             .FontBold  = .F.
901:             .BackStyle = 0
902:             .ForeColor = RGB(90, 90, 90)
903:             .Visible   = .T.
904:         ENDWITH
905: 
906:         loc_oPagina.AddObject("txt_4c_Fwget17", "TextBox")
907:         WITH loc_oPagina.txt_4c_Fwget17
908:             .Value     = ""
909:             .Top       = 366
910:             .Left      = 250
911:             .Width     = 160
912:             .Height    = 23
913:             .MaxLength = 20
914:             .FontName  = "Tahoma"
915:             .FontSize  = 8
916:             .BackColor = RGB(255, 255, 255)
917:             .ForeColor = RGB(90, 90, 90)
918:             .Visible   = .T.
919:         ENDWITH
920: 
921:         *----------------------------------------------------------------------
922:         *  TAMANHO FOLHA (Label13: top=364+29=393; fwget18: top=362+29=391)
923:         *  Legado: fwget18.Valid -> GetPaperSize() quando vazio (ValidarTamanhoFolha)
924:         *----------------------------------------------------------------------
925:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
926:         WITH loc_oPagina.lbl_4c_Label13
927:             .Caption   = "Tamanho Folha :"
928:             .Top       = 393
929:             .Left      = 164
930:             .Width     = 82
931:             .Height    = 15
932:             .AutoSize  = .T.
933:             .FontName  = "Tahoma"
934:             .FontSize  = 8

*-- Linhas 941 a 950:
941:         loc_oPagina.AddObject("txt_4c_Fwget18", "TextBox")
942:         WITH loc_oPagina.txt_4c_Fwget18
943:             .Value     = ""
944:             .Top       = 391
945:             .Left      = 250
946:             .Width     = 244
947:             .Height    = 23
948:             .MaxLength = 50
949:             .FontName  = "Tahoma"
950:             .FontSize  = 8

*-- Linhas 959 a 971:
959:         *  NOME IMPRESSORA (Label14: top=392+29=421; fwget19: top=387+29=416)
960:         *  Legado: fwget19.Valid -> GetPrinter() quando vazio (ValidarNomeImpressora)
961:         *----------------------------------------------------------------------
962:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
963:         WITH loc_oPagina.lbl_4c_Label14
964:             .Caption   = "Nome Impressora :"
965:             .Top       = 421
966:             .Left      = 153
967:             .Width     = 93
968:             .Height    = 15
969:             .AutoSize  = .T.
970:             .FontName  = "Tahoma"
971:             .FontSize  = 8

*-- Linhas 978 a 987:
978:         loc_oPagina.AddObject("txt_4c_Fwget19", "TextBox")
979:         WITH loc_oPagina.txt_4c_Fwget19
980:             .Value     = ""
981:             .Top       = 416
982:             .Left      = 250
983:             .Width     = 319
984:             .Height    = 23
985:             .MaxLength = 40
986:             .FontName  = "Tahoma"
987:             .FontSize  = 8

*-- Linhas 1020 a 1043:
1020:                     WITH loc_oGrid
1021:                         .Column1.ControlSource   = "cursor_4c_Dados.banco"
1022:                         .Column1.Width           = 80
1023:                         .Column1.Header1.Caption = "Banco"
1024:                         .Column1.ReadOnly        = .T.
1025: 
1026:                         .Column2.ControlSource   = "cursor_4c_Dados.local"
1027:                         .Column2.Width           = 160
1028:                         .Column2.Header1.Caption = "Local"
1029:                         .Column2.ReadOnly        = .T.
1030: 
1031:                         .Column3.ControlSource   = "cursor_4c_Dados.ctamanho"
1032:                         .Column3.Width           = 200
1033:                         .Column3.Header1.Caption = "Tamanho Folha"
1034:                         .Column3.ReadOnly        = .T.
1035: 
1036:                         .Column4.ControlSource   = "cursor_4c_Dados.cnomimpre"
1037:                         .Column4.Width           = 300
1038:                         .Column4.Header1.Caption = "Nome Impressora"
1039:                         .Column4.ReadOnly        = .T.
1040:                     ENDWITH
1041: 
1042:                     THIS.FormatarGridLista(loc_oGrid)
1043:                     loc_lResultado = .T.

*-- Linhas 1158 a 1166:
1158:             THIS.AlternarPagina(2)
1159: 
1160:             TRY
1161:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados.cmd_4c_Cancelar.SetFocus
1162:             CATCH TO loException
1163:                 MsgErro("Erro ao focar Cancelar: " + loException.Message, "Erro")
1164:             ENDTRY
1165:         ELSE
1166:             MsgAviso("Erro ao carregar o registro selecionado.", "Erro")

*-- Linhas 1189 a 1209:
1189:             THIS.HabilitarCampos(.T.)
1190:             THIS.AjustarBotoesPorModo()
1191:             THIS.AlternarPagina(2)
1192: 
1193:             TRY
1194:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Fwget17.SetFocus
1195:             CATCH TO loException
1196:                 MsgErro("Erro ao focar campo Local: " + loException.Message, "Erro")
1197:             ENDTRY
1198:         ELSE
1199:             MsgAviso("Erro ao carregar o registro para altera" + CHR(231) + CHR(227) + "o.", "Erro")
1200:         ENDIF
1201:     ENDPROC
1202: 
1203:     *--------------------------------------------------------------------------
1204:     * BtnExcluirClick - Confirma e exclui o registro selecionado
1205:     *--------------------------------------------------------------------------
1206:     PROCEDURE BtnExcluirClick()
1207:         LOCAL loc_cBanco
1208: 
1209:         IF !USED("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0 OR EOF("cursor_4c_Dados")

*-- Linhas 1255 a 1269:
1255:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1256:                     WITH loc_oGrid
1257:                         .Column1.ControlSource   = "cursor_4c_Dados.banco"
1258:                         .Column1.Header1.Caption = "Banco"
1259:                         .Column2.ControlSource   = "cursor_4c_Dados.local"
1260:                         .Column2.Header1.Caption = "Local"
1261:                         .Column3.ControlSource   = "cursor_4c_Dados.ctamanho"
1262:                         .Column3.Header1.Caption = "Tamanho Folha"
1263:                         .Column4.ControlSource   = "cursor_4c_Dados.cnomimpre"
1264:                         .Column4.Header1.Caption = "Nome Impressora"
1265:                     ENDWITH
1266:                 ENDIF
1267:             ENDIF
1268: 
1269:             loc_oBusca.Release()

*-- Linhas 1291 a 1333:
1291:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1292: 
1293:         *-- Validacoes FORA do TRY (Problema 16)
1294:         TRY
1295:             loc_cBanco = ALLTRIM(loc_oPagina.txt_4c_Banco.Value)
1296:             loc_cLocal = ALLTRIM(loc_oPagina.txt_4c_Fwget17.Value)
1297:         CATCH TO loException
1298:             MsgErro("Erro ao ler campos do formul" + CHR(225) + "rio: " + loException.Message, "Erro")
1299:             RETURN
1300:         ENDTRY
1301: 
1302:         IF EMPTY(loc_cBanco)
1303:             MsgAviso("Preencher o Banco.", "Aten" + CHR(231) + CHR(227) + "o")
1304: 
1305:             TRY
1306:                 loc_oPagina.txt_4c_Banco.SetFocus
1307:             CATCH
1308:             ENDTRY
1309: 
1310:             RETURN
1311:         ENDIF
1312: 
1313:         IF INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1314:             IF EMPTY(loc_cLocal)
1315:                 MsgAviso("Preencher o Local.", "Aten" + CHR(231) + CHR(227) + "o")
1316: 
1317:                 TRY
1318:                     loc_oPagina.txt_4c_Fwget17.SetFocus
1319:                 CATCH
1320:                 ENDTRY
1321: 
1322:                 RETURN
1323:             ENDIF
1324:         ENDIF
1325: 
1326:         THIS.FormParaBO()
1327: 
1328:         IF THIS.this_oBusinessObject.Salvar()
1329:             MsgInfo("Registro salvo com sucesso!", "Sucesso")
1330:             THIS.this_cModoAtual = "LISTA"
1331:             THIS.AlternarPagina(1)
1332:         ENDIF
1333:     ENDPROC

*-- Linhas 1374 a 1394:
1374:             loc_oBO.this_nCdia     = TRANSFORM(loc_oPagina.txt_4c_Fwget12.Value)
1375:             loc_oBO.this_nLmes     = TRANSFORM(loc_oPagina.txt_4c_Fwget13.Value)
1376:             loc_oBO.this_nCmes     = TRANSFORM(loc_oPagina.txt_4c_Fwget14.Value)
1377:             loc_oBO.this_nLano     = TRANSFORM(loc_oPagina.txt_4c_Fwget15.Value)
1378:             loc_oBO.this_nCano     = TRANSFORM(loc_oPagina.txt_4c_Fwget16.Value)
1379:             loc_oBO.this_cLocal    = ALLTRIM(loc_oPagina.txt_4c_Fwget17.Value)
1380:             loc_oBO.this_cTamanho  = ALLTRIM(loc_oPagina.txt_4c_Fwget18.Value)
1381:             loc_oBO.this_cNomImpre = ALLTRIM(loc_oPagina.txt_4c_Fwget19.Value)
1382:         CATCH TO loException
1383:             MsgErro("Erro em FormParaBO:" + CHR(13) + ;
1384:                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
1385:                     loException.Message, "Erro")
1386:         ENDTRY
1387:     ENDPROC
1388: 
1389:     *--------------------------------------------------------------------------
1390:     * BOParaForm - Transfere valores do BO para os campos do form
1391:     *--------------------------------------------------------------------------
1392:     PROTECTED PROCEDURE BOParaForm()
1393:         LOCAL loc_oPagina, loc_oBO
1394:         loc_oPagina = THIS.pgf_4c_Paginas.Page2

*-- Linhas 1410 a 1430:
1410:             loc_oPagina.txt_4c_Fwget12.Value  = loc_oBO.this_nCdia
1411:             loc_oPagina.txt_4c_Fwget13.Value  = loc_oBO.this_nLmes
1412:             loc_oPagina.txt_4c_Fwget14.Value  = loc_oBO.this_nCmes
1413:             loc_oPagina.txt_4c_Fwget15.Value  = loc_oBO.this_nLano
1414:             loc_oPagina.txt_4c_Fwget16.Value  = loc_oBO.this_nCano
1415:             loc_oPagina.txt_4c_Fwget17.Value  = loc_oBO.this_cLocal
1416:             loc_oPagina.txt_4c_Fwget18.Value  = loc_oBO.this_cTamanho
1417:             loc_oPagina.txt_4c_Fwget19.Value  = loc_oBO.this_cNomImpre
1418:         CATCH TO loException
1419:             MsgErro("Erro em BOParaForm:" + CHR(13) + ;
1420:                     "Linha: " + TRANSFORM(loException.LineNo) + CHR(13) + ;
1421:                     loException.Message, "Erro")
1422:         ENDTRY
1423:     ENDPROC
1424: 
1425:     *--------------------------------------------------------------------------
1426:     * LimparCampos - Limpa todos os campos da Page2
1427:     *--------------------------------------------------------------------------
1428:     PROTECTED PROCEDURE LimparCampos()
1429:         LOCAL loc_oPagina
1430:         loc_oPagina = THIS.pgf_4c_Paginas.Page2

*-- Linhas 1445 a 1465:
1445:             loc_oPagina.txt_4c_Fwget12.Value  = 0
1446:             loc_oPagina.txt_4c_Fwget13.Value  = 0
1447:             loc_oPagina.txt_4c_Fwget14.Value  = 0
1448:             loc_oPagina.txt_4c_Fwget15.Value  = 0
1449:             loc_oPagina.txt_4c_Fwget16.Value  = 0
1450:             loc_oPagina.txt_4c_Fwget17.Value  = ""
1451:             loc_oPagina.txt_4c_Fwget18.Value  = ""
1452:             loc_oPagina.txt_4c_Fwget19.Value  = ""
1453:         CATCH TO loException
1454:             MsgErro("Erro em LimparCampos: " + loException.Message, "Erro")
1455:         ENDTRY
1456:     ENDPROC
1457: 
1458:     *--------------------------------------------------------------------------
1459:     * HabilitarCampos - Habilita/desabilita campos conforme modo
1460:     * Legado: Get_Banco.When retorna .F. nos modos ALTERAR/EXCLUIR/CONSULTAR
1461:     *--------------------------------------------------------------------------
1462:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1463:         LOCAL loc_oPagina
1464:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1465: 

*-- Linhas 1483 a 1523:
1483:             loc_oPagina.txt_4c_Fwget12.ReadOnly  = !par_lHabilitar
1484:             loc_oPagina.txt_4c_Fwget13.ReadOnly  = !par_lHabilitar
1485:             loc_oPagina.txt_4c_Fwget14.ReadOnly  = !par_lHabilitar
1486:             loc_oPagina.txt_4c_Fwget15.ReadOnly  = !par_lHabilitar
1487:             loc_oPagina.txt_4c_Fwget16.ReadOnly  = !par_lHabilitar
1488:             loc_oPagina.txt_4c_Fwget17.ReadOnly  = !par_lHabilitar
1489:             loc_oPagina.txt_4c_Fwget18.ReadOnly  = !par_lHabilitar
1490:             loc_oPagina.txt_4c_Fwget19.ReadOnly  = !par_lHabilitar
1491:         CATCH TO loException
1492:             MsgErro("Erro em HabilitarCampos: " + loException.Message, "Erro")
1493:         ENDTRY
1494:     ENDPROC
1495: 
1496:     *--------------------------------------------------------------------------
1497:     * AjustarBotoesPorModo - Ajusta habilitacao dos botoes Confirmar/Cancelar
1498:     *--------------------------------------------------------------------------
1499:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1500:         LOCAL loc_oPg2Botoes
1501: 
1502:         TRY
1503:             loc_oPg2Botoes = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesDados
1504: 
1505:             DO CASE
1506:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1507:                 IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Confirmar", 5)
1508:                     loc_oPg2Botoes.cmd_4c_Confirmar.Enabled = .T.
1509:                 ENDIF
1510:                 IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Cancelar", 5)
1511:                     loc_oPg2Botoes.cmd_4c_Cancelar.Enabled  = .T.
1512:                 ENDIF
1513:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1514:                 IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Confirmar", 5)
1515:                     loc_oPg2Botoes.cmd_4c_Confirmar.Enabled = .F.
1516:                 ENDIF
1517:                 IF PEMSTATUS(loc_oPg2Botoes, "cmd_4c_Cancelar", 5)
1518:                     loc_oPg2Botoes.cmd_4c_Cancelar.Enabled  = .T.
1519:                 ENDIF
1520:             ENDCASE
1521:         CATCH TO loException
1522:             MsgErro("Erro em AjustarBotoesPorModo: " + loException.Message, "Erro")
1523:         ENDTRY


### BO (C:\4c\projeto\app\classes\CHMBO.prg):
*==============================================================================
* CHMBO.prg - Business Object: Configura??o do Cheque Matricial
* Tabela: SigCqMat
* PK: banco (C3)
* Gerado: 2026-07-28 - Fase 1/8
*==============================================================================
DEFINE CLASS CHMBO AS BusinessBase

    *-- Chave prim?ria
    this_cBanco     = ""   && banco C(3)

    *-- Posi??es de impress?o - Valor
    this_nLvlr      = 0    && lvlr  N - Linha  Valor
    this_nCvlr      = 0    && cvlr  N - Coluna Valor

    *-- Posi??es de impress?o - Valor Extenso 1
    this_nLvext1    = 0    && lvext1 N - Linha  Valor Extenso 1
    this_nCvext1    = 0    && cvext1 N - Coluna Valor Extenso 1

    *-- Posi??es de impress?o - Valor Extenso 2
    this_nLvext2    = 0    && lvext2 N - Linha  Valor Extenso 2
    this_nCvext2    = 0    && cvext2 N - Coluna Valor Extenso 2

    *-- Posi??es de impress?o - Favorecido
    this_nLfavo     = 0    && lfavo N - Linha  Favorecido
    this_nCfavo     = 0    && cfavo N - Coluna Favorecido

    *-- Posi??es de impress?o - Localidade
    this_nLlocal    = 0    && llocal N - Linha  Localidade
    this_nClocal    = 0    && clocal N - Coluna Localidade

    *-- Posi??es de impress?o - Dia
    this_nLdia      = 0    && ldia N - Linha  Dia
    this_nCdia      = 0    && cdia N - Coluna Dia

    *-- Posi??es de impress?o - M?s
    this_nLmes      = 0    && lmes N - Linha  M?s
    this_nCmes      = 0    && cmes N - Coluna M?s

    *-- Posi??es de impress?o - Ano
    this_nLano      = 0    && lano N - Linha  Ano
    this_nCano      = 0    && cano N - Coluna Ano

    *-- Campos de configura??o da impressora
    this_cLocal     = ""   && local      C(20) - Local de emiss?o
    this_cTamanho   = ""   && ctamanho   C(50) - Tamanho da folha
    this_cNomImpre  = ""   && cNomImpre  C(40) - Nome da impressora

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        DODEFAULT()
        THIS.this_cTabela      = "SigCqMat"
        THIS.this_cCampoChave  = "banco"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cBanco
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT banco, [local], ctamanho, cnomimpre" + ;
                           " FROM SigCqMat" + ;
                           " WHERE banco LIKE " + EscaparSQL(ALLTRIM(par_cFiltro) + "%") + ;
                           " ORDER BY banco"
            ELSE
                loc_cSQL = "SELECT banco, [local], ctamanho, cnomimpre" + ;
                           " FROM SigCqMat" + ;
                           " ORDER BY banco"
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cBanco)
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT banco, lvlr, cvlr, lvext1, cvext1," + ;
                       " lvext2, cvext2, lfavo, cfavo, llocal, clocal," + ;
                       " ldia, cdia, lmes, cmes, lano, cano," + ;
                       " [local], ctamanho, cnomimpre" + ;
                       " FROM SigCqMat" + ;
                       " WHERE banco = " + EscaparSQL(par_cBanco)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao carregar: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cBanco    = TratarNulo(banco,    "C")
            THIS.this_nLvlr     = TratarNulo(lvlr,     "N")
            THIS.this_nCvlr     = TratarNulo(cvlr,     "N")
            THIS.this_nLvext1   = TratarNulo(lvext1,   "N")
            THIS.this_nCvext1   = TratarNulo(cvext1,   "N")
            THIS.this_nLvext2   = TratarNulo(lvext2,   "N")
            THIS.this_nCvext2   = TratarNulo(cvext2,   "N")
            THIS.this_nLfavo    = TratarNulo(lfavo,    "N")
            THIS.this_nCfavo    = TratarNulo(cfavo,    "N")
            THIS.this_nLlocal   = TratarNulo(llocal,   "N")
            THIS.this_nClocal   = TratarNulo(clocal,   "N")
            THIS.this_nLdia     = TratarNulo(ldia,     "N")
            THIS.this_nCdia     = TratarNulo(cdia,     "N")
            THIS.this_nLmes     = TratarNulo(lmes,     "N")
            THIS.this_nCmes     = TratarNulo(cmes,     "N")
            THIS.this_nLano     = TratarNulo(lano,     "N")
            THIS.this_nCano     = TratarNulo(cano,     "N")
            THIS.this_cLocal    = TratarNulo(EVALUATE(par_cAliasCursor + ".local"), "C")
            THIS.this_cTamanho  = TratarNulo(ctamanho, "C")
            THIS.this_cNomImpre = TratarNulo(cnomimpre,"C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_cChkSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cChkSQL = "SELECT COUNT(*) AS total FROM SigCqMat" + ;
                          " WHERE banco = " + EscaparSQL(THIS.this_cBanco)
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkDup")
                TABLEREVERT(.T., "cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF

            SQLEXEC(gnConnHandle, loc_cChkSQL, "cursor_4c_ChkDup")

            IF cursor_4c_ChkDup.total > 0
                MsgAviso("Existe esse Banco J" + CHR(225) + " Cadastrado.", ;
                         "Aten" + CHR(231) + CHR(227) + "o")
                USE IN cursor_4c_ChkDup
            ELSE
                USE IN cursor_4c_ChkDup
                loc_cSQL = "INSERT INTO SigCqMat" + ;
                           " (banco, lvlr, cvlr, lvext1, cvext1," + ;
                           "  lvext2, cvext2, lfavo, cfavo, llocal, clocal," + ;
                           "  ldia, cdia, lmes, cmes, lano, cano," + ;
                           "  [local], ctamanho, cnomimpre)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cBanco) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLvlr) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCvlr) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLvext1) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCvext1) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLvext2) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCvext2) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLfavo) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCfavo) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLlocal) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nClocal) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLdia) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCdia) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLmes) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCmes) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nLano) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nCano) + ", " + ;
                           EscaparSQL(THIS.this_cLocal) + ", " + ;
                           EscaparSQL(THIS.this_cTamanho) + ", " + ;
                           EscaparSQL(THIS.this_cNomImpre) + ")"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Insert")
                    TABLEREVERT(.T., "cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

                IF loc_nResultado > 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao inserir: " + CapturarErroSQL(), "Erro SQL")
                ENDIF

                IF USED("cursor_4c_Insert")
                    USE IN cursor_4c_Insert
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao inserir: " + loException.Message, "Erro")
            IF USED("cursor_4c_ChkDup")
                USE IN cursor_4c_ChkDup
            ENDIF
            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCqMat SET" + ;
                       " lvlr = "    + FormatarNumeroSQL(THIS.this_nLvlr)   + "," + ;
                       " cvlr = "    + FormatarNumeroSQL(THIS.this_nCvlr)   + "," + ;
                       " lvext1 = "  + FormatarNumeroSQL(THIS.this_nLvext1) + "," + ;
                       " cvext1 = "  + FormatarNumeroSQL(THIS.this_nCvext1) + "," + ;
                       " lvext2 = "  + FormatarNumeroSQL(THIS.this_nLvext2) + "," + ;
                       " cvext2 = "  + FormatarNumeroSQL(THIS.this_nCvext2) + "," + ;
                       " lfavo = "   + FormatarNumeroSQL(THIS.this_nLfavo)  + "," + ;
                       " cfavo = "   + FormatarNumeroSQL(THIS.this_nCfavo)  + "," + ;
                       " llocal = "  + FormatarNumeroSQL(THIS.this_nLlocal) + "," + ;
                       " clocal = "  + FormatarNumeroSQL(THIS.this_nClocal) + "," + ;
                       " ldia = "    + FormatarNumeroSQL(THIS.this_nLdia)   + "," + ;
                       " cdia = "    + FormatarNumeroSQL(THIS.this_nCdia)   + "," + ;
                       " lmes = "    + FormatarNumeroSQL(THIS.this_nLmes)   + "," + ;
                       " cmes = "    + FormatarNumeroSQL(THIS.this_nCmes)   + "," + ;
                       " lano = "    + FormatarNumeroSQL(THIS.this_nLano)   + "," + ;
                       " cano = "    + FormatarNumeroSQL(THIS.this_nCano)   + "," + ;
                       " [local] = " + EscaparSQL(THIS.this_cLocal)         + "," + ;
                       " ctamanho = "+ EscaparSQL(THIS.this_cTamanho)       + "," + ;
                       " cnomimpre ="+ EscaparSQL(THIS.this_cNomImpre) + ;
                       " WHERE banco = " + EscaparSQL(THIS.this_cBanco)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Update")
                TABLEREVERT(.T., "cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao atualizar: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Update")
            USE IN cursor_4c_Update
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCqMat WHERE banco = " + EscaparSQL(THIS.this_cBanco)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Delete")
                TABLEREVERT(.T., "cursor_4c_Delete")
                USE IN cursor_4c_Delete
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")

            IF loc_nResultado > 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro ao excluir: " + loException.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Delete")
            USE IN cursor_4c_Delete
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

