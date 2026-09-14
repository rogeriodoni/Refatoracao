# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 865: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFea.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (5369 linhas total):

*-- Linhas 78 a 86:
78:                 MsgErro("Erro ao criar FeaBO." + CHR(13) + ;
79:                         "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), "Erro")
80:             ELSE
81:                 THIS.Caption = "Balan" + CHR(231) + "o"
82: 
83:                 THIS.this_cPEmps    = ALLTRIM(go_4c_Sistema.cCodEmpresa)
84:                 THIS.this_cAntEmpr  = THIS.this_cPEmps
85: 
86:                 THIS.ConfigurarPageFrame()

*-- Linhas 104 a 130:
104: 
105:     *==========================================================================
106:     * ConfigurarPageFrame - Cria PageFrame principal com 2 paginas
107:     * PageFrame.Top = -29 para ocultar abas (padrao frmcadastro)
108:     *==========================================================================
109:     PROTECTED PROCEDURE ConfigurarPageFrame()
110:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
111: 
112:         WITH THIS.pgf_4c_Paginas
113:             .PageCount = 2
114:             .Top       = -29
115:             .Left      = 0
116:             .Width     = THIS.Width
117:             .Height    = THIS.Height + 29
118:             .Tabs      = .F.
119:             .Visible   = .T.
120: 
121:             .Page1.Caption   = "Lista"
122:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
123:             .Page1.BackColor = RGB(255, 255, 255)
124: 
125:             .Page2.Caption   = "Dados"
126:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
127:             .Page2.BackColor = RGB(255, 255, 255)
128:         ENDWITH
129:     ENDPROC
130: 

*-- Linhas 140 a 180:
140:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
141: 
142:         *-- Container cabecalho escuro (cntSombra no legado)
143:         *-- Top=31 = 2 (original) + 29 (compensacao PageFrame.Top=-29)
144:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
145:         WITH loc_oPagina.cnt_4c_Cabecalho
146:             .Top         = 31
147:             .Left        = 0
148:             .Width       = THIS.Width
149:             .Height      = 80
150:             .BackColor   = RGB(100, 100, 100)
151:             .BorderWidth = 0
152:             .Visible     = .T.
153:         ENDWITH
154: 
155:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
156:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
157:             .Caption   = "Balan" + CHR(231) + "o"
158:             .Top       = 20
159:             .Left      = 12
160:             .Width     = THIS.Width
161:             .Height    = 40
162:             .FontName  = "Tahoma"
163:             .FontSize  = 16
164:             .FontBold  = .T.
165:             .ForeColor = RGB(0, 0, 0)
166:             .BackStyle = 0
167:             .AutoSize  = .F.
168:             .Visible   = .T.
169:         ENDWITH
170: 
171:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
172:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
173:             .Caption   = "Balan" + CHR(231) + "o"
174:             .Top       = 18
175:             .Left      = 10
176:             .Width     = THIS.Width
177:             .Height    = 46
178:             .FontName  = "Tahoma"
179:             .FontSize  = 16
180:             .FontBold  = .T.

*-- Linhas 188 a 212:
188:         *-- Top=29 = 0 (original) + 29 (compensacao); Width=385 acomoda 5 botoes de Width=75
189:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
190:         WITH loc_oPagina.cnt_4c_Botoes
191:             .Top         = 29
192:             .Left        = 542
193:             .Width       = 385
194:             .Height      = 85
195:             .BackStyle   = 0
196:             .BorderWidth = 0
197:             .Visible     = .T.
198:         ENDWITH
199: 
200:         *-- Botao Incluir (Left=5)
201:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
202:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
203:             .Caption         = "Incluir"
204:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
205:             .PicturePosition = 13
206:             .Top             = 5
207:             .Left            = 5
208:             .Width           = 75
209:             .Height          = 75
210:             .FontName        = "Tahoma"
211:             .FontBold        = .T.
212:             .FontItalic      = .T.

*-- Linhas 220 a 237:
220:             .AutoSize        = .F.
221:             .Visible         = .T.
222:         ENDWITH
223:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
224: 
225:         *-- Botao Visualizar (Left=80)
226:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
227:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
228:             .Caption         = "Visualizar"
229:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
230:             .PicturePosition = 13
231:             .Top             = 5
232:             .Left            = 80
233:             .Width           = 75
234:             .Height          = 75
235:             .FontName        = "Tahoma"
236:             .FontBold        = .T.
237:             .FontItalic      = .T.

*-- Linhas 245 a 262:
245:             .AutoSize        = .F.
246:             .Visible         = .T.
247:         ENDWITH
248:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
249: 
250:         *-- Botao Alterar (Left=155)
251:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
252:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
253:             .Caption         = "Alterar"
254:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
255:             .PicturePosition = 13
256:             .Top             = 5
257:             .Left            = 155
258:             .Width           = 75
259:             .Height          = 75
260:             .FontName        = "Tahoma"
261:             .FontBold        = .T.
262:             .FontItalic      = .T.

*-- Linhas 270 a 287:
270:             .AutoSize        = .F.
271:             .Visible         = .T.
272:         ENDWITH
273:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
274: 
275:         *-- Botao Excluir (Left=230)
276:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
277:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
278:             .Caption         = "Excluir"
279:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
280:             .PicturePosition = 13
281:             .Top             = 5
282:             .Left            = 230
283:             .Width           = 75
284:             .Height          = 75
285:             .FontName        = "Tahoma"
286:             .FontBold        = .T.
287:             .FontItalic      = .T.

*-- Linhas 295 a 312:
295:             .AutoSize        = .F.
296:             .Visible         = .T.
297:         ENDWITH
298:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
299: 
300:         *-- Botao Buscar (Left=305)
301:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
302:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
303:             .Caption         = "Buscar"
304:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
305:             .PicturePosition = 13
306:             .Top             = 5
307:             .Left            = 305
308:             .Width           = 75
309:             .Height          = 75
310:             .FontName        = "Tahoma"
311:             .FontBold        = .T.
312:             .FontItalic      = .T.

*-- Linhas 320 a 348:
320:             .AutoSize        = .F.
321:             .Visible         = .T.
322:         ENDWITH
323:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
324: 
325:         *-- Container saida/encerrar - padrao canonico (CLAUDE.md regra #10)
326:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
327:         WITH loc_oPagina.cnt_4c_Saida
328:             .Top         = 29
329:             .Left        = 917
330:             .Width       = 90
331:             .Height      = 85
332:             .BackStyle   = 0
333:             .BorderWidth = 0
334:             .Visible     = .T.
335:         ENDWITH
336: 
337:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
338:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
339:             .Caption         = "Encerrar"
340:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
341:             .PicturePosition = 13
342:             .Top             = 5
343:             .Left            = 5
344:             .Width           = 75
345:             .Height          = 75
346:             .FontName        = "Tahoma"
347:             .FontBold        = .T.
348:             .FontItalic      = .T.

*-- Linhas 356 a 384:
356:             .AutoSize        = .F.
357:             .Visible         = .T.
358:         ENDWITH
359:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
360: 
361:         *-- Container filtro de periodo (Cnt_periodo no legado)
362:         *-- Top=113 = 84 (original) + 29 (compensacao)
363:         loc_oPagina.AddObject("cnt_4c_Periodo", "Container")
364:         WITH loc_oPagina.cnt_4c_Periodo
365:             .Top         = 113
366:             .Left        = 21
367:             .Width       = 332
368:             .Height      = 59
369:             .BackColor   = RGB(255, 255, 255)
370:             .BackStyle   = 0
371:             .Visible     = .T.
372:         ENDWITH
373: 
374:         *-- Label Empresa (Say4 no legado: top=7, left=16)
375:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Empresa", "Label")
376:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Empresa
377:             .Caption   = "Empresa : "
378:             .Top       = 7
379:             .Left      = 16
380:             .Width     = 63
381:             .Height    = 17
382:             .FontName  = "Tahoma"
383:             .FontSize  = 8
384:             .FontBold  = .F.

*-- Linhas 393 a 402:
393:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_Empresa", "TextBox")
394:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_Empresa
395:             .Value         = THIS.this_cPEmps
396:             .Top           = 4
397:             .Left          = 79
398:             .Width         = 35
399:             .Height        = 23
400:             .MaxLength     = 3
401:             .FontName      = "Tahoma"
402:             .FontSize      = 8

*-- Linhas 409 a 421:
409:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_Empresa, "KeyPress", THIS, "EmpresaLostFocus")
410: 
411:         *-- Label Periodo (Label1 no legado: top=32, left=22)
412:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Periodo", "Label")
413:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Periodo
414:             .Caption   = "Per" + CHR(237) + "odo : "
415:             .Top       = 32
416:             .Left      = 22
417:             .Width     = 57
418:             .Height    = 17
419:             .FontName  = "Tahoma"
420:             .FontSize  = 8
421:             .FontBold  = .F.

*-- Linhas 429 a 438:
429:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DtInicial", "TextBox")
430:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial
431:             .Value         = DATE()
432:             .Top           = 29
433:             .Left          = 79
434:             .Width         = 80
435:             .Height        = 23
436:             .Format        = "D"
437:             .FontName      = "Tahoma"
438:             .FontSize      = 8

*-- Linhas 445 a 457:
445:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtInicial, "KeyPress", THIS, "DtInicialLostFocus")
446: 
447:         *-- Label separador entre datas (Say2 no legado: top=32, left=164, caption=CHR(224))
448:         loc_oPagina.cnt_4c_Periodo.AddObject("lbl_4c_Sep", "Label")
449:         WITH loc_oPagina.cnt_4c_Periodo.lbl_4c_Sep
450:             .Caption   = CHR(224)
451:             .Top       = 32
452:             .Left      = 164
453:             .Width     = 12
454:             .Height    = 17
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8
457:             .FontBold  = .F.

*-- Linhas 465 a 474:
465:         loc_oPagina.cnt_4c_Periodo.AddObject("txt_4c_DtFinal", "TextBox")
466:         WITH loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal
467:             .Value         = DATE()
468:             .Top           = 29
469:             .Left          = 177
470:             .Width         = 80
471:             .Height        = 23
472:             .Format        = "D"
473:             .FontName      = "Tahoma"
474:             .FontSize      = 8

*-- Linhas 481 a 493:
481:         BINDEVENT(loc_oPagina.cnt_4c_Periodo.txt_4c_DtFinal, "KeyPress", THIS, "DtFinalLostFocus")
482: 
483:         *-- Botao Posicao Balanco (btnPosicao no legado: top=4+29=33, left=474)
484:         loc_oPagina.AddObject("cmd_4c_PosicaoBal", "CommandButton")
485:         WITH loc_oPagina.cmd_4c_PosicaoBal
486:             .Caption       = "Posi" + CHR(231) + CHR(227) + "o \<Bal."
487:             .Top           = 33
488:             .Left          = 474
489:             .Width         = 64
490:             .Height        = 55
491:             .FontName      = "Tahoma"
492:             .FontSize      = 8
493:             .FontBold      = .F.

*-- Linhas 500 a 516:
500:             .AutoSize      = .F.
501:             .Visible       = .T.
502:         ENDWITH
503:         BINDEVENT(loc_oPagina.cmd_4c_PosicaoBal, "Click", THIS, "BtnPosicaoBalClick")
504: 
505:         *-- Grade de balanco (Grade no legado, Page1)
506:         *-- ColumnCount FORA do WITH (Problema 36: dentro nao cria colunas imediatamente)
507:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
508:         loc_oPagina.grd_4c_Lista.ColumnCount = 5
509:         WITH loc_oPagina.grd_4c_Lista
510:             .Top                = 175
511:             .Left               = 21
512:             .Width              = 884
513:             .Height             = 540
514:             .FontName           = "Tahoma"
515:             .FontSize           = 8
516:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 549 a 572:
549:         *-- Width=90 inicial (Cancelar oculto); 173 quando modo INSERIR com Fechamento
550:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
551:         WITH loc_oPagina.cnt_4c_BotoesAcao
552:             .Top         = 46
553:             .Left        = 817
554:             .Width       = 90
555:             .Height      = 85
556:             .BackStyle   = 0
557:             .Visible     = .T.
558:         ENDWITH
559: 
560:         *-- Botao Confirmar (Salva no legado: left=5, top=5, w=75, h=75)
561:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
562:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
563:             .Caption         = "Confirmar"
564:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
565:             .PicturePosition = 13
566:             .Top             = 5
567:             .Left            = 5
568:             .Width           = 75
569:             .Height          = 75
570:             .FontName        = "Tahoma"
571:             .FontBold        = .T.
572:             .FontItalic      = .T.

*-- Linhas 581 a 598:
581:             .Enabled         = .F.
582:             .Visible         = .T.
583:         ENDWITH
584:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
585: 
586:         *-- Botao Cancelar (Cancelar no legado: left=80, top=5; inicia oculto)
587:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
588:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
589:             .Caption         = "Encerrar"
590:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
591:             .PicturePosition = 13
592:             .Top             = 5
593:             .Left            = 80
594:             .Width           = 75
595:             .Height          = 75
596:             .FontName        = "Tahoma"
597:             .FontBold        = .T.
598:             .FontItalic      = .T.

*-- Linhas 606 a 634:
606:             .AutoSize        = .F.
607:             .Visible         = .F.
608:         ENDWITH
609:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
610: 
611:         *-- Shape de borda ao redor dos campos de entrada (Shape1 no legado)
612:         *-- Top=36 = 7 (original) + 29 (compensacao)
613:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
614:         WITH loc_oPagina.shp_4c_Shape1
615:             .Top         = 36
616:             .Left        = 9
617:             .Width       = 662
618:             .Height      = 110
619:             .BorderColor = RGB(90, 90, 90)
620:             .BackStyle   = 0
621:             .Visible     = .T.
622:         ENDWITH
623: 
624:         *-- Label Codigo (Label4 no legado: top=24+29=53, left=30, w=42)
625:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
626:         WITH loc_oPagina.lbl_4c_Label4
627:             .Caption   = "C" + CHR(243) + "digo :"
628:             .Top       = 53
629:             .Left      = 30
630:             .Width     = 42
631:             .Height    = 15
632:             .FontName  = "Tahoma"
633:             .FontSize  = 8
634:             .FontBold  = .F.

*-- Linhas 643 a 652:
643:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
644:         WITH loc_oPagina.txt_4c_Codigo
645:             .Value         = 0
646:             .Top           = 48
647:             .Left          = 75
648:             .Width         = 54
649:             .Height        = 25
650:             .InputMask     = "999999"
651:             .FontName      = "Tahoma"
652:             .FontSize      = 8

*-- Linhas 659 a 671:
659:         ENDWITH
660: 
661:         *-- Label Data (Label3 no legado: top=24+29=53, left=158, w=32)
662:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
663:         WITH loc_oPagina.lbl_4c_Label3
664:             .Caption   = "Data :"
665:             .Top       = 53
666:             .Left      = 158
667:             .Width     = 32
668:             .Height    = 15
669:             .FontName  = "Tahoma"
670:             .FontSize  = 8
671:             .FontBold  = .F.

*-- Linhas 680 a 689:
680:         loc_oPagina.AddObject("txt_4c_Data", "TextBox")
681:         WITH loc_oPagina.txt_4c_Data
682:             .Value         = {}
683:             .Top           = 48
684:             .Left          = 198
685:             .Width         = 80
686:             .Height        = 25
687:             .Format        = "K"
688:             .FontName      = "Courier New"
689:             .FontSize      = 9

*-- Linhas 697 a 709:
697:         BINDEVENT(loc_oPagina.txt_4c_Data, "KeyPress", THIS, "DataLostFocus")
698: 
699:         *-- Label Grupo (Label1 no legado: top=51+29=80, left=34, w=38)
700:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
701:         WITH loc_oPagina.lbl_4c_Label1
702:             .Caption   = "Grupo :"
703:             .Top       = 80
704:             .Left      = 34
705:             .Width     = 38
706:             .Height    = 15
707:             .FontName  = "Tahoma"
708:             .FontSize  = 8
709:             .FontBold  = .F.

*-- Linhas 717 a 726:
717:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
718:         WITH loc_oPagina.txt_4c_Grupo
719:             .Value         = ""
720:             .Top           = 75
721:             .Left          = 75
722:             .Width         = 80
723:             .Height        = 25
724:             .MaxLength     = 10
725:             .FontName      = "Tahoma"
726:             .FontSize      = 8

*-- Linhas 738 a 747:
738:         loc_oPagina.AddObject("txt_4c_DGrupo", "TextBox")
739:         WITH loc_oPagina.txt_4c_DGrupo
740:             .Value         = ""
741:             .Top           = 75
742:             .Left          = 157
743:             .Width         = 290
744:             .Height        = 25
745:             .MaxLength     = 40
746:             .FontName      = "Tahoma"
747:             .FontSize      = 8

*-- Linhas 756 a 768:
756:         BINDEVENT(loc_oPagina.txt_4c_DGrupo, "InteractiveChange", THIS, "DadosInteractiveChange")
757: 
758:         *-- Label Conta (Label2 no legado: top=78+29=107, left=34, w=38)
759:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
760:         WITH loc_oPagina.lbl_4c_Label2
761:             .Caption   = "Conta :"
762:             .Top       = 107
763:             .Left      = 34
764:             .Width     = 38
765:             .Height    = 15
766:             .FontName  = "Tahoma"
767:             .FontSize  = 8
768:             .FontBold  = .F.

*-- Linhas 776 a 785:
776:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
777:         WITH loc_oPagina.txt_4c_Conta
778:             .Value         = ""
779:             .Top           = 102
780:             .Left          = 75
781:             .Width         = 80
782:             .Height        = 25
783:             .MaxLength     = 10
784:             .FontName      = "Tahoma"
785:             .FontSize      = 8

*-- Linhas 797 a 806:
797:         loc_oPagina.AddObject("txt_4c_DConta", "TextBox")
798:         WITH loc_oPagina.txt_4c_DConta
799:             .Value         = ""
800:             .Top           = 102
801:             .Left          = 157
802:             .Width         = 290
803:             .Height        = 25
804:             .MaxLength     = 80
805:             .FontName      = "Tahoma"
806:             .FontSize      = 8

*-- Linhas 815 a 827:
815:         BINDEVENT(loc_oPagina.txt_4c_DConta, "InteractiveChange", THIS, "DadosInteractiveChange")
816: 
817:         *-- Label Lote (Label5 no legado: top=51+29=80, left=504, w=30)
818:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
819:         WITH loc_oPagina.lbl_4c_Label5
820:             .Caption   = "Lote :"
821:             .Top       = 80
822:             .Left      = 504
823:             .Width     = 30
824:             .Height    = 15
825:             .FontName  = "Tahoma"
826:             .FontSize  = 8
827:             .FontBold  = .F.

*-- Linhas 836 a 845:
836:         loc_oPagina.AddObject("txt_4c_Lote", "TextBox")
837:         WITH loc_oPagina.txt_4c_Lote
838:             .Value         = 0
839:             .Top           = 75
840:             .Left          = 543
841:             .Width         = 54
842:             .Height        = 25
843:             .InputMask     = "999999"
844:             .FontName      = "Tahoma"
845:             .FontSize      = 8

*-- Linhas 853 a 891:
853: 
854:         *-- Botao Processar (Processar no legado: top=22+29=51, left=747, w=75, h=75)
855:         *-- FontName="Comic Sans MS" FontBold=.T. do legado
856:         loc_oPagina.AddObject("cmd_4c_Processar", "CommandButton")
857:         WITH loc_oPagina.cmd_4c_Processar
858:             .Caption         = "\<Processar"
859:             .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
860:             .PicturePosition = 13
861:             .Top             = 51
862:             .Left            = 747
863:             .Width           = 75
864:             .Height          = 75
865:             .FontName        = "Comic Sans MS"
866:             .FontBold        = .T.
867:             .FontItalic      = .T.
868:             .FontSize        = 8
869:             .ForeColor       = RGB(90, 90, 90)
870:             .BackColor       = RGB(255, 255, 255)
871:             .Themes          = .F.
872:             .SpecialEffect   = 0
873:             .MousePointer    = 15
874:             .WordWrap        = .T.
875:             .AutoSize        = .F.
876:             .Visible         = .T.
877:         ENDWITH
878:         BINDEVENT(loc_oPagina.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
879: 
880:         *-- Container resultado (Resultado no legado)
881:         *-- INICIA OCULTO - torna-se visivel apos BtnProcessarClick executar
882:         *-- Top=152 = 123 (original) + 29 (compensacao)
883:         loc_oPagina.AddObject("cnt_4c_Resultado", "Container")
884:         WITH loc_oPagina.cnt_4c_Resultado
885:             .Top         = 152
886:             .Left        = 10
887:             .Width       = 980
888:             .Height      = 460
889:             .BackColor   = RGB(255, 255, 255)
890:             .BackStyle   = 1
891:             .Visible     = .F.

*-- Linhas 1000 a 1012:
1000:                 loc_oGrid.Column4.Width = 200
1001:                 loc_oGrid.Column5.Width = 200
1002: 
1003:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "d."
1004:                 loc_oGrid.Column2.Header1.Caption = "Grupo"
1005:                 loc_oGrid.Column3.Header1.Caption = "Conta"
1006:                 loc_oGrid.Column4.Header1.Caption = "Data Encerramento"
1007:                 loc_oGrid.Column5.Header1.Caption = "Data In" + CHR(237) + "cio"
1008: 
1009:                 THIS.FormatarGridLista(loc_oGrid)
1010: 
1011:                 THIS.this_cAntEmpr  = loc_cEmp
1012:                 THIS.this_dAntDtIni = loc_dDtI

*-- Linhas 1050 a 1060:
1050:         loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0
1051: 
1052:         WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1053:             .cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1054:             .cmd_4c_Alterar.Enabled    = loc_lTemRegistro
1055:             .cmd_4c_Excluir.Enabled    = loc_lTemRegistro
1056:             .Visible     = .T.
1057:         ENDWITH
1058:     ENDPROC
1059: 
1060:     *==========================================================================

*-- Linhas 1266 a 1283:
1266:             loc_lCancelarVisivel = (THIS.this_cPcEscolha <> "CONSULTAR") AND THIS.this_lFechamento
1267: 
1268:             *-- Cancelar: visivel apenas quando pode cancelar uma edicao real
1269:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Visible = loc_lCancelarVisivel
1270: 
1271:             *-- Confirmar.Cancel: ativado por ESC quando nao se pode confirmar
1272:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Cancel = loc_lConsultar
1273: 
1274:             *-- Width do container: 90 so Confirmar / 173 Confirmar + Cancelar
1275:             loc_oPagina.cnt_4c_BotoesAcao.Width = IIF(loc_lConsultar, 90, 173)
1276: 
1277:             *-- Processar: visivel somente em INSERIR
1278:             loc_oPagina.cmd_4c_Processar.Visible = (THIS.this_cPcEscolha = "INSERIR")
1279: 
1280:             *-- txt_4c_Data: editavel em INSERIR/ALTERAR ou quando !Fechamento
1281:             loc_oPagina.txt_4c_Data.ReadOnly = loc_lSomenteVisual AND THIS.this_lFechamento
1282: 
1283:             *-- Popula campos da BOParaForm (crSigCdFcx -> form)

*-- Linhas 1293 a 1301:
1293: 
1294:             *-- Para INSERIR e !Fechamento (posicao): Confirmar habilitado
1295:             IF THIS.this_cPcEscolha <> "INSERIR" OR !THIS.this_lFechamento
1296:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1297:             ENDIF
1298: 
1299:             loc_lResultado = .T.
1300:         CATCH TO loc_oErro
1301:             MsgErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message + ;

*-- Linhas 1524 a 1532:
1524:             IF PEMSTATUS(loc_oPagina, "txt_4c_Lote", 5)
1525:                 loc_oPagina.txt_4c_Lote.Value = 0
1526:             ENDIF
1527:             loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1528:             loc_oPagina.cnt_4c_Resultado.Visible = .F.
1529:         CATCH TO loc_oErro
1530:             MsgErro("Erro em LimparCampos:" + CHR(13) + loc_oErro.Message, "FormFea")
1531:         ENDTRY
1532:     ENDPROC

*-- Linhas 1598 a 1606:
1598:     PROCEDURE DadosInteractiveChange()
1599:         TRY
1600:             IF THIS.this_lFechamento
1601:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1602:             ENDIF
1603:             THIS.pgf_4c_Paginas.Page2.cnt_4c_Resultado.Visible = .F.
1604:         CATCH TO loc_oErro
1605:             MsgErro("Erro em DadosInteractiveChange:" + CHR(13) + loc_oErro.Message, "FormFea")
1606:         ENDTRY

*-- Linhas 1726 a 1734:
1726: 
1727:     *==========================================================================
1728:     * BtnSalvarClick - Alias canonico de BtnConfirmarClick
1729:     * O botao real e cmd_4c_Confirmar (padrao CLAUDE.md regra #10 para SAIDA).
1730:     * Este metodo existe para atender contratos que esperam o nome "Salvar".
1731:     * PUBLIC: BINDEVENT exige metodo publico (CLAUDE.md regra #3)
1732:     *==========================================================================
1733:     PROCEDURE BtnSalvarClick()
1734:         RETURN THIS.BtnConfirmarClick()

*-- Linhas 3516 a 3524:
3516:         ENDIF
3517: 
3518:         *-- Habilitar Confirmar
3519:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
3520: 
3521:         *-- Exibir resultado (Fase 6: GradeMat refresh via PEMSTATUS)
3522:         IF PEMSTATUS(loc_oPagina.cnt_4c_Resultado, "GradeMat", 5)
3523:             loc_oPagina.cnt_4c_Resultado.GradeMat.AfterRowColChange(1)
3524:             loc_oPagina.cnt_4c_Resultado.GradeMat.Refresh

*-- Linhas 3549 a 3574:
3549:             *-- Shape3: barra de cabecalho periodo (top=7,left=8,w=434,h=31)
3550:             par_oCnt.AddObject("shp_4c_Shape3", "Shape")
3551:             WITH par_oCnt.shp_4c_Shape3
3552:                 .Top           = 7
3553:                 .Left          = 8
3554:                 .Width         = 434
3555:                 .Height        = 31
3556:                 .SpecialEffect = 1
3557:                 .BackColor     = RGB(204, 204, 204)
3558:                 .BackStyle     = 1
3559:                 .BorderStyle   = 1
3560:                 .Curvature     = 0
3561:                 .Visible       = .T.
3562:             ENDWITH
3563: 
3564:             *-- Label18: "Periodo :" (top=15,left=19,w=45,h=15)
3565:             par_oCnt.AddObject("lbl_4c_Label18", "Label")
3566:             WITH par_oCnt.lbl_4c_Label18
3567:                 .Caption   = "Per" + CHR(237) + "odo :"
3568:                 .Top       = 15
3569:                 .Left      = 19
3570:                 .Width     = 45
3571:                 .Height    = 15
3572:                 .FontName  = "Tahoma"
3573:                 .FontSize  = 8
3574:                 .BackStyle = 0

*-- Linhas 3580 a 3589:
3580:             par_oCnt.AddObject("Get_Datai", "TextBox")
3581:             WITH par_oCnt.Get_Datai
3582:                 .Value         = DATE()
3583:                 .Top           = 12
3584:                 .Left          = 79
3585:                 .Width         = 72
3586:                 .Height        = 21
3587:                 .Format        = "K"
3588:                 .ReadOnly      = .T.
3589:                 .FontName      = "Tahoma"

*-- Linhas 3595 a 3607:
3595:             ENDWITH
3596: 
3597:             *-- Label4: "e" separador (top=15,left=157,w=8)
3598:             par_oCnt.AddObject("lbl_4c_Label4", "Label")
3599:             WITH par_oCnt.lbl_4c_Label4
3600:                 .Caption   = CHR(233)
3601:                 .Top       = 15
3602:                 .Left      = 157
3603:                 .Width     = 8
3604:                 .Height    = 15
3605:                 .FontName  = "Tahoma"
3606:                 .FontSize  = 8
3607:                 .BackStyle = 0

*-- Linhas 3613 a 3622:
3613:             par_oCnt.AddObject("Get_Dataf", "TextBox")
3614:             WITH par_oCnt.Get_Dataf
3615:                 .Value         = DATE()
3616:                 .Top           = 12
3617:                 .Left          = 170
3618:                 .Width         = 72
3619:                 .Height        = 21
3620:                 .Format        = "K"
3621:                 .ReadOnly      = .T.
3622:                 .FontName      = "Tahoma"

*-- Linhas 3630 a 3783:
3630:             *-- Shape4: area de resumo numerico (top=46,left=193,w=248,h=241)
3631:             par_oCnt.AddObject("shp_4c_Shape4", "Shape")
3632:             WITH par_oCnt.shp_4c_Shape4
3633:                 .Top           = 46
3634:                 .Left          = 193
3635:                 .Width         = 248
3636:                 .Height        = 241
3637:                 .SpecialEffect = 1
3638:                 .BackColor     = RGB(204, 204, 204)
3639:                 .BackStyle     = 1
3640:                 .BorderStyle   = 1
3641:                 .Curvature     = 0
3642:                 .Visible       = .T.
3643:             ENDWITH
3644: 
3645:             *-- Label1: " Resumos " (top=49,left=205,w=60,h=15)
3646:             par_oCnt.AddObject("lbl_4c_Label1", "Label")
3647:             WITH par_oCnt.lbl_4c_Label1
3648:                 .Caption   = " Resumos "
3649:                 .Top       = 49
3650:                 .Left      = 205
3651:                 .Width     = 60
3652:                 .Height    = 15
3653:                 .FontName  = "Tahoma"
3654:                 .FontSize  = 8
3655:                 .FontBold  = .T.
3656:                 .BackStyle = 0
3657:                 .AutoSize  = .F.
3658:                 .Visible   = .T.
3659:             ENDWITH
3660: 
3661:             *-- Labels dos campos numericos
3662:             par_oCnt.AddObject("lbl_4c_Label5", "Label")
3663:             WITH par_oCnt.lbl_4c_Label5
3664:                 .Caption   = "Saldo Inicial : "
3665:                 .Top       = 79
3666:                 .Left      = 235
3667:                 .Width     = 68
3668:                 .Height    = 15
3669:                 .FontName  = "Tahoma"
3670:                 .FontSize  = 8
3671:                 .BackStyle = 0
3672:                 .AutoSize  = .F.
3673:                 .Visible   = .T.
3674:             ENDWITH
3675: 
3676:             par_oCnt.AddObject("lbl_4c_Label6", "Label")
3677:             WITH par_oCnt.lbl_4c_Label6
3678:                 .Caption   = "Entradas : "
3679:                 .Top       = 102
3680:                 .Left      = 248
3681:                 .Width     = 55
3682:                 .Height    = 15
3683:                 .FontName  = "Tahoma"
3684:                 .FontSize  = 8
3685:                 .BackStyle = 0
3686:                 .AutoSize  = .F.
3687:                 .Visible   = .T.
3688:             ENDWITH
3689: 
3690:             par_oCnt.AddObject("lbl_4c_Label7", "Label")
3691:             WITH par_oCnt.lbl_4c_Label7
3692:                 .Caption   = "Total Entradas : "
3693:                 .Top       = 125
3694:                 .Left      = 221
3695:                 .Width     = 82
3696:                 .Height    = 15
3697:                 .FontName  = "Tahoma"
3698:                 .FontSize  = 8
3699:                 .BackStyle = 0
3700:                 .AutoSize  = .F.
3701:                 .Visible   = .T.
3702:             ENDWITH
3703: 
3704:             par_oCnt.AddObject("lbl_4c_Label8", "Label")
3705:             WITH par_oCnt.lbl_4c_Label8
3706:                 .Caption   = "Total Sa" + CHR(237) + "das : "
3707:                 .Top       = 148
3708:                 .Left      = 233
3709:                 .Width     = 70
3710:                 .Height    = 15
3711:                 .FontName  = "Tahoma"
3712:                 .FontSize  = 8
3713:                 .BackStyle = 0
3714:                 .AutoSize  = .F.
3715:                 .Visible   = .T.
3716:             ENDWITH
3717: 
3718:             par_oCnt.AddObject("lbl_4c_Label9", "Label")
3719:             WITH par_oCnt.lbl_4c_Label9
3720:                 .Caption   = "Pesagem F" + CHR(237) + "sica : "
3721:                 .Top       = 171
3722:                 .Left      = 219
3723:                 .Width     = 84
3724:                 .Height    = 15
3725:                 .FontName  = "Tahoma"
3726:                 .FontSize  = 8
3727:                 .BackStyle = 0
3728:                 .AutoSize  = .F.
3729:                 .Visible   = .T.
3730:             ENDWITH
3731: 
3732:             par_oCnt.AddObject("lbl_4c_Label10", "Label")
3733:             WITH par_oCnt.lbl_4c_Label10
3734:                 .Caption   = "Falha Real : "
3735:                 .Top       = 194
3736:                 .Left      = 241
3737:                 .Width     = 62
3738:                 .Height    = 15
3739:                 .FontName  = "Tahoma"
3740:                 .FontSize  = 8
3741:                 .BackStyle = 0
3742:                 .AutoSize  = .F.
3743:                 .Visible   = .T.
3744:             ENDWITH
3745: 
3746:             par_oCnt.AddObject("lbl_4c_Label11", "Label")
3747:             WITH par_oCnt.lbl_4c_Label11
3748:                 .Caption   = "Falha Admitida : "
3749:                 .Top       = 217
3750:                 .Left      = 221
3751:                 .Width     = 82
3752:                 .Height    = 15
3753:                 .FontName  = "Tahoma"
3754:                 .FontSize  = 8
3755:                 .BackStyle = 0
3756:                 .AutoSize  = .F.
3757:                 .Visible   = .T.
3758:             ENDWITH
3759: 
3760:             par_oCnt.AddObject("lbl_4c_Label12", "Label")
3761:             WITH par_oCnt.lbl_4c_Label12
3762:                 .Caption   = "Saldo Final : "
3763:                 .Top       = 239
3764:                 .Left      = 240
3765:                 .Width     = 63
3766:                 .Height    = 15
3767:                 .FontName  = "Tahoma"
3768:                 .FontSize  = 8
3769:                 .BackStyle = 0
3770:                 .AutoSize  = .F.
3771:                 .Visible   = .T.
3772:             ENDWITH
3773: 
3774:             par_oCnt.AddObject("lbl_4c_Label2", "Label")
3775:             WITH par_oCnt.lbl_4c_Label2
3776:                 .Caption   = "%Falha/Trab. :"
3777:                 .Top       = 262
3778:                 .Left      = 227
3779:                 .Width     = 76
3780:                 .Height    = 15
3781:                 .FontName  = "Tahoma"
3782:                 .FontSize  = 8
3783:                 .BackStyle = 0

*-- Linhas 3789 a 3798:
3789:             par_oCnt.AddObject("Get_Saldo", "TextBox")
3790:             WITH par_oCnt.Get_Saldo
3791:                 .Value         = 0
3792:                 .Top           = 75
3793:                 .Left          = 307
3794:                 .Width         = 109
3795:                 .Height        = 21
3796:                 .InputMask     = "999,999.999"
3797:                 .ReadOnly      = .T.
3798:                 .FontName      = "Tahoma"

*-- Linhas 3806 a 3815:
3806:             par_oCnt.AddObject("Get_TEntradas", "TextBox")
3807:             WITH par_oCnt.Get_TEntradas
3808:                 .Value         = 0
3809:                 .Top           = 98
3810:                 .Left          = 307
3811:                 .Width         = 109
3812:                 .Height        = 21
3813:                 .InputMask     = "999,999.999"
3814:                 .ReadOnly      = .T.
3815:                 .FontName      = "Tahoma"

*-- Linhas 3823 a 3832:
3823:             par_oCnt.AddObject("Get_SEntradas", "TextBox")
3824:             WITH par_oCnt.Get_SEntradas
3825:                 .Value         = 0
3826:                 .Top           = 121
3827:                 .Left          = 307
3828:                 .Width         = 109
3829:                 .Height        = 21
3830:                 .InputMask     = "999,999.999"
3831:                 .ReadOnly      = .T.
3832:                 .FontName      = "Tahoma"

*-- Linhas 3840 a 3849:
3840:             par_oCnt.AddObject("Get_SSaidas", "TextBox")
3841:             WITH par_oCnt.Get_SSaidas
3842:                 .Value         = 0
3843:                 .Top           = 144
3844:                 .Left          = 307
3845:                 .Width         = 109
3846:                 .Height        = 21
3847:                 .InputMask     = "999,999.999"
3848:                 .ReadOnly      = .T.
3849:                 .FontName      = "Tahoma"

*-- Linhas 3857 a 3866:
3857:             par_oCnt.AddObject("Get_Pesagem", "TextBox")
3858:             WITH par_oCnt.Get_Pesagem
3859:                 .Value         = 0
3860:                 .Top           = 167
3861:                 .Left          = 307
3862:                 .Width         = 109
3863:                 .Height        = 21
3864:                 .InputMask     = "999,999.999"
3865:                 .ReadOnly      = .T.
3866:                 .FontName      = "Tahoma"

*-- Linhas 3875 a 3884:
3875:             par_oCnt.AddObject("Get_FReal", "TextBox")
3876:             WITH par_oCnt.Get_FReal
3877:                 .Value         = 0
3878:                 .Top           = 190
3879:                 .Left          = 307
3880:                 .Width         = 109
3881:                 .Height        = 21
3882:                 .InputMask     = "999,999.999"
3883:                 .ReadOnly      = .T.
3884:                 .FontName      = "Tahoma"

*-- Linhas 3892 a 3901:
3892:             par_oCnt.AddObject("Get_FAdmitida", "TextBox")
3893:             WITH par_oCnt.Get_FAdmitida
3894:                 .Value         = 0
3895:                 .Top           = 213
3896:                 .Left          = 307
3897:                 .Width         = 109
3898:                 .Height        = 21
3899:                 .InputMask     = "999,999.999"
3900:                 .ReadOnly      = .T.
3901:                 .FontName      = "Tahoma"

*-- Linhas 3909 a 3918:
3909:             par_oCnt.AddObject("Get_Saldof", "TextBox")
3910:             WITH par_oCnt.Get_Saldof
3911:                 .Value         = 0
3912:                 .Top           = 235
3913:                 .Left          = 307
3914:                 .Width         = 109
3915:                 .Height        = 21
3916:                 .InputMask     = "999,999.999"
3917:                 .ReadOnly      = .T.
3918:                 .FontName      = "Tahoma"

*-- Linhas 3926 a 3935:
3926:             par_oCnt.AddObject("Get_Pfalha", "TextBox")
3927:             WITH par_oCnt.Get_Pfalha
3928:                 .Value         = 0
3929:                 .Top           = 258
3930:                 .Left          = 307
3931:                 .Width         = 109
3932:                 .Height        = 21
3933:                 .InputMask     = "999.99"
3934:                 .ReadOnly      = .T.
3935:                 .FontName      = "Tahoma"

*-- Linhas 3943 a 4141:
3943:             *-- Shape5: area de impressao (top=286,left=459,w=416,h=171)
3944:             par_oCnt.AddObject("shp_4c_Shape5", "Shape")
3945:             WITH par_oCnt.shp_4c_Shape5
3946:                 .Top           = 286
3947:                 .Left          = 459
3948:                 .Width         = 416
3949:                 .Height        = 171
3950:                 .SpecialEffect = 1
3951:                 .BackColor     = RGB(204, 204, 204)
3952:                 .BackStyle     = 1
3953:                 .BorderStyle   = 1
3954:                 .Curvature     = 0
3955:                 .Visible       = .T.
3956:             ENDWITH
3957: 
3958:             *-- Label15: " Impressao " (top=288,left=474,w=69,h=15)
3959:             par_oCnt.AddObject("lbl_4c_Label15", "Label")
3960:             WITH par_oCnt.lbl_4c_Label15
3961:                 .Caption   = " Impress" + CHR(227) + "o "
3962:                 .Top       = 288
3963:                 .Left      = 474
3964:                 .Width     = 69
3965:                 .Height    = 15
3966:                 .FontName  = "Tahoma"
3967:                 .FontSize  = 8
3968:                 .FontBold  = .T.
3969:                 .BackStyle = 0
3970:                 .AutoSize  = .F.
3971:                 .Visible   = .T.
3972:             ENDWITH
3973: 
3974:             *-- CheckBoxes de opcoes de impressao
3975:             par_oCnt.AddObject("Resumido", "CheckBox")
3976:             WITH par_oCnt.Resumido
3977:                 .Caption   = "Resumido"
3978:                 .Top       = 304
3979:                 .Left      = 469
3980:                 .Width     = 64
3981:                 .Height    = 15
3982:                 .Value     = 1
3983:                 .FontName  = "Tahoma"
3984:                 .FontSize  = 8
3985:                 .BackStyle = 0
3986:                 .Visible   = .T.
3987:             ENDWITH
3988: 
3989:             par_oCnt.AddObject("chkServ", "CheckBox")
3990:             WITH par_oCnt.chkServ
3991:                 .Caption   = "Servi" + CHR(231) + "os"
3992:                 .Top       = 304
3993:                 .Left      = 559
3994:                 .Width     = 58
3995:                 .Height    = 15
3996:                 .Value     = 0
3997:                 .FontName  = "Tahoma"
3998:                 .FontSize  = 8
3999:                 .BackStyle = 0
4000:                 .Visible   = .T.
4001:             ENDWITH
4002: 
4003:             par_oCnt.AddObject("porMov", "CheckBox")
4004:             WITH par_oCnt.porMov
4005:                 .Caption   = "por Mov."
4006:                 .Top       = 304
4007:                 .Left      = 645
4008:                 .Width     = 61
4009:                 .Height    = 15
4010:                 .Value     = 0
4011:                 .FontName  = "Tahoma"
4012:                 .FontSize  = 8
4013:                 .BackStyle = 0
4014:                 .Visible   = .T.
4015:             ENDWITH
4016: 
4017:             par_oCnt.AddObject("porenv", "CheckBox")
4018:             WITH par_oCnt.porenv
4019:                 .Caption   = "por Env."
4020:                 .Top       = 304
4021:                 .Left      = 735
4022:                 .Width     = 59
4023:                 .Height    = 15
4024:                 .Value     = 0
4025:                 .FontName  = "Tahoma"
4026:                 .FontSize  = 8
4027:                 .BackStyle = 0
4028:                 .Visible   = .T.
4029:             ENDWITH
4030: 
4031:             par_oCnt.AddObject("MovLote", "CheckBox")
4032:             WITH par_oCnt.MovLote
4033:                 .Caption   = "Mov Lote"
4034:                 .Top       = 304
4035:                 .Left      = 805
4036:                 .Width     = 62
4037:                 .Height    = 15
4038:                 .Value     = 0
4039:                 .FontName  = "Tahoma"
4040:                 .FontSize  = 8
4041:                 .BackStyle = 0
4042:                 .Visible   = .T.
4043:             ENDWITH
4044: 
4045:             par_oCnt.AddObject("Historico", "CheckBox")
4046:             WITH par_oCnt.Historico
4047:                 .Caption   = "Hist" + CHR(243) + "rico"
4048:                 .Top       = 319
4049:                 .Left      = 469
4050:                 .Width     = 59
4051:                 .Height    = 15
4052:                 .Value     = 0
4053:                 .FontName  = "Tahoma"
4054:                 .FontSize  = 8
4055:                 .BackStyle = 0
4056:                 .Visible   = .T.
4057:             ENDWITH
4058: 
4059:             par_oCnt.AddObject("Analitico", "CheckBox")
4060:             WITH par_oCnt.Analitico
4061:                 .Caption   = "Anal" + CHR(237) + "tico"
4062:                 .Top       = 319
4063:                 .Left      = 559
4064:                 .Width     = 58
4065:                 .Height    = 15
4066:                 .Value     = 0
4067:                 .FontName  = "Tahoma"
4068:                 .FontSize  = 8
4069:                 .BackStyle = 0
4070:                 .Visible   = .T.
4071:             ENDWITH
4072: 
4073:             par_oCnt.AddObject("MovAgru", "CheckBox")
4074:             WITH par_oCnt.MovAgru
4075:                 .Caption   = "Mov Agrupa"
4076:                 .Top       = 319
4077:                 .Left      = 645
4078:                 .Width     = 76
4079:                 .Height    = 15
4080:                 .Value     = 0
4081:                 .FontName  = "Tahoma"
4082:                 .FontSize  = 8
4083:                 .BackStyle = 0
4084:                 .Visible   = .T.
4085:             ENDWITH
4086: 
4087:             par_oCnt.AddObject("pormat", "CheckBox")
4088:             WITH par_oCnt.pormat
4089:                 .Caption   = "por Mat"
4090:                 .Top       = 319
4091:                 .Left      = 735
4092:                 .Width     = 55
4093:                 .Height    = 15
4094:                 .Value     = 0
4095:                 .FontName  = "Tahoma"
4096:                 .FontSize  = 8
4097:                 .BackStyle = 0
4098:                 .Visible   = .T.
4099:             ENDWITH
4100: 
4101:             *-- op_ordem OptionGroup (top=318,left=801,w=49,h=36 - 2 botoes)
4102:             par_oCnt.AddObject("op_ordem", "OptionGroup")
4103:             WITH par_oCnt.op_ordem
4104:                 .Top         = 318
4105:                 .Left        = 801
4106:                 .Width       = 49
4107:                 .Height      = 36
4108:                 .Value       = 1
4109:                 .BackStyle   = 0
4110:                 .ButtonCount = 2
4111:                 WITH .Buttons(1)
4112:                     .Caption   = "1"
4113:                     .Top       = 2
4114:                     .Left      = 2
4115:                     .Width     = 45
4116:                     .Height    = 15
4117:                     .BackStyle = 0
4118:                 ENDWITH
4119:                 WITH .Buttons(2)
4120:                     .Caption   = "2"
4121:                     .Top       = 19
4122:                     .Left      = 2
4123:                     .Width     = 45
4124:                     .Height    = 15
4125:                     .BackStyle = 0
4126:                     .FontName  = "Tahoma"
4127:                     .FontSize  = 8
4128:                 ENDWITH
4129:             ENDWITH
4130: 
4131:             *-- chkPerdas (top=335,left=469,w=139,h=15)
4132:             par_oCnt.AddObject("chkPerdas", "CheckBox")
4133:             WITH par_oCnt.chkPerdas
4134:                 .Caption   = "Demonstrativo de Perdas"
4135:                 .Top       = 335
4136:                 .Left      = 469
4137:                 .Width     = 139
4138:                 .Height    = 15
4139:                 .Value     = 0
4140:                 .FontName  = "Tahoma"
4141:                 .FontSize  = 8

*-- Linhas 4147 a 4159:
4147:             *-- SelTudo (top=371,left=191,w=40,h=40)
4148:             par_oCnt.AddObject("SelTudo", "CommandButton")
4149:             WITH par_oCnt.SelTudo
4150:                 .Caption         = ""
4151:                 .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
4152:                 .PicturePosition = 4
4153:                 .Top             = 371
4154:                 .Left            = 191
4155:                 .Width           = 40
4156:                 .Height          = 40
4157:                 .ToolTipText     = "Selecionar Todos"
4158:                 .Themes          = .T.
4159:                 .SpecialEffect   = 0

*-- Linhas 4165 a 4177:
4165:             *-- apaga (top=411,left=191,w=40,h=40)
4166:             par_oCnt.AddObject("apaga", "CommandButton")
4167:             WITH par_oCnt.apaga
4168:                 .Caption         = ""
4169:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
4170:                 .PicturePosition = 4
4171:                 .Top             = 411
4172:                 .Left            = 191
4173:                 .Width           = 40
4174:                 .Height          = 40
4175:                 .ToolTipText     = "Desmarcar Todos"
4176:                 .Themes          = .T.
4177:                 .SpecialEffect   = 0

*-- Linhas 4183 a 4195:
4183:             *-- Visualizar (top=370,left=476,w=75,h=75)
4184:             par_oCnt.AddObject("Visualizar", "CommandButton")
4185:             WITH par_oCnt.Visualizar
4186:                 .Caption         = "Visualizar"
4187:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"
4188:                 .PicturePosition = 13
4189:                 .Top             = 370
4190:                 .Left            = 476
4191:                 .Width           = 75
4192:                 .Height          = 75
4193:                 .FontName        = "Tahoma"
4194:                 .FontSize        = 8
4195:                 .Themes          = .T.

*-- Linhas 4203 a 4215:
4203:             *-- Imprimir (top=370,left=551,w=75,h=75)
4204:             par_oCnt.AddObject("Imprimir", "CommandButton")
4205:             WITH par_oCnt.Imprimir
4206:                 .Caption         = "Imprimir"
4207:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_impressora_26.jpg"
4208:                 .PicturePosition = 13
4209:                 .Top             = 370
4210:                 .Left            = 551
4211:                 .Width           = 75
4212:                 .Height          = 75
4213:                 .FontName        = "Tahoma"
4214:                 .FontSize        = 8
4215:                 .Themes          = .T.

*-- Linhas 4223 a 4235:
4223:             *-- Pesagem (top=294,left=892,w=75,h=75) - inicia oculto
4224:             par_oCnt.AddObject("Pesagem", "CommandButton")
4225:             WITH par_oCnt.Pesagem
4226:                 .Caption         = "Pesagem"
4227:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
4228:                 .PicturePosition = 13
4229:                 .Top             = 294
4230:                 .Left            = 892
4231:                 .Width           = 75
4232:                 .Height          = 75
4233:                 .FontName        = "Tahoma"
4234:                 .FontSize        = 8
4235:                 .Themes          = .T.

*-- Linhas 4241 a 4253:
4241:             BINDEVENT(par_oCnt.Pesagem, "Click", THIS, "BtnPesagemClick")
4242: 
4243:             *-- Label3: "Movimentacoes" (top=352,left=652,w=76,h=15)
4244:             par_oCnt.AddObject("lbl_4c_Label3", "Label")
4245:             WITH par_oCnt.lbl_4c_Label3
4246:                 .Caption   = "Movimenta" + CHR(231) + CHR(245) + "es"
4247:                 .Top       = 352
4248:                 .Left      = 652
4249:                 .Width     = 76
4250:                 .Height    = 15
4251:                 .FontName  = "Tahoma"
4252:                 .FontSize  = 8
4253:                 .BackStyle = 0

*-- Linhas 4261 a 4369:
4261:             par_oCnt.grdMov.ColumnCount  = 2
4262:             par_oCnt.grdMov.RecordSource = ""
4263:             WITH par_oCnt.grdMov
4264:                 .Top         = 370
4265:                 .Left        = 649
4266:                 .Width       = 189
4267:                 .Height      = 82
4268:                 .GridLines   = 1
4269:                 .HeaderHeight = 20
4270:                 .FontName    = "Tahoma"
4271:                 .FontSize    = 8
4272:                 .Visible     = .T.
4273:             ENDWITH
4274:             WITH par_oCnt.grdMov.Column1
4275:                 .Header1.Caption = ""
4276:                 .Width           = 20
4277:                 .Sparse          = .F.
4278:             ENDWITH
4279:             par_oCnt.grdMov.Column1.AddObject("Check1", "CheckBox")
4280:             WITH par_oCnt.grdMov.Column1.Check1
4281:                 .Caption   = ""
4282:                 .Alignment = 0
4283:                 .ReadOnly  = .F.
4284:                 .Visible   = .T.
4285:                 .Top       = 9
4286:                 .Left      = 2
4287:                 .Height    = 17
4288:                 .Width     = 17
4289:             ENDWITH
4290:             par_oCnt.grdMov.Column1.CurrentControl = "Check1"
4291:             WITH par_oCnt.grdMov.Column2
4292:                 .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
4293:                 .Width           = 160
4294:             ENDWITH
4295:             BINDEVENT(par_oCnt.grdMov.Column1.Check1, "KeyPress", THIS, "GrdMovCheck1KeyPress")
4296: 
4297:             *-- Pagina pageframe interno (top=5,left=462,w=510,h=275,3 paginas)
4298:             par_oCnt.AddObject("Pagina", "PageFrame")
4299:             WITH par_oCnt.Pagina
4300:                 .Top       = 5
4301:                 .Left      = 462
4302:                 .Width     = 510
4303:                 .Height    = 275
4304:                 .PageCount = 3
4305:                 .Tabs      = .T.
4306:                 .FontName  = "Tahoma"
4307:                 .FontSize  = 8
4308:                 .Visible   = .T.
4309:             ENDWITH
4310:             par_oCnt.Pagina.Pages(1).Caption = "Entradas"
4311:             par_oCnt.Pagina.Pages(2).Caption = "Sa" + CHR(237) + "das"
4312:             par_oCnt.Pagina.Pages(3).Caption = "Resumo"
4313: 
4314:             *-- GradeEntradas (Pagina.Page1 top=7,left=10,w=484,h=207,5 cols)
4315:             par_oCnt.Pagina.Pages(1).AddObject("GradeEntradas", "Grid")
4316:             par_oCnt.Pagina.Pages(1).GradeEntradas.ColumnCount  = 5
4317:             par_oCnt.Pagina.Pages(1).GradeEntradas.RecordSource = "TmpOpera"
4318:             loc_oGrd = par_oCnt.Pagina.Pages(1).GradeEntradas
4319:             WITH loc_oGrd
4320:                 .Top          = 7
4321:                 .Left         = 10
4322:                 .Width        = 484
4323:                 .Height       = 207
4324:                 .ReadOnly     = .T.
4325:                 .GridLines    = 1
4326:                 .HeaderHeight = 20
4327:                 .FontName     = "Tahoma"
4328:                 .FontSize     = 8
4329:                 .Visible      = .T.
4330:             ENDWITH
4331:             WITH loc_oGrd.Column1
4332:                 .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
4333:                 .ControlSource   = "TmpOpera.TpOps"
4334:                 .Width           = 120
4335:             ENDWITH
4336:             WITH loc_oGrd.Column2
4337:                 .Header1.Caption = "Qtde"
4338:                 .ControlSource   = "TmpOpera.QtdeEnts"
4339:                 .Width           = 80
4340:             ENDWITH
4341:             WITH loc_oGrd.Column3
4342:                 .Header1.Caption = "F.Adm"
4343:                 .ControlSource   = "TmpOpera.PFalha"
4344:                 .Width           = 60
4345:             ENDWITH
4346:             WITH loc_oGrd.Column4
4347:                 .Header1.Caption = "Falha"
4348:                 .ControlSource   = "TmpOpera.Falha"
4349:                 .Width           = 60
4350:             ENDWITH
4351:             WITH loc_oGrd.Column5
4352:                 .Header1.Caption = "Base Falha"
4353:                 .ControlSource   = "TmpOpera.PesoBEnts"
4354:                 .Width           = 80
4355:             ENDWITH
4356:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeEntradasAfterRowColChange")
4357:             BINDEVENT(par_oCnt.Pagina.Pages(1), "Activate", THIS, "PaginaResultadoPage1Activate")
4358: 
4359:             *-- Get_TpOperacao em Page1 (top=220,left=10,w=484,h=23)
4360:             par_oCnt.Pagina.Pages(1).AddObject("Get_TpOperacao", "TextBox")
4361:             WITH par_oCnt.Pagina.Pages(1).Get_TpOperacao
4362:                 .Value         = ""
4363:                 .Top           = 220
4364:                 .Left          = 10
4365:                 .Width         = 484
4366:                 .Height        = 23
4367:                 .ReadOnly      = .T.
4368:                 .FontName      = "Tahoma"
4369:                 .FontSize      = 8

*-- Linhas 4379 a 4431:
4379:             par_oCnt.Pagina.Pages(2).GradeSaidas.RecordSource = "TmpOpera"
4380:             loc_oGrd = par_oCnt.Pagina.Pages(2).GradeSaidas
4381:             WITH loc_oGrd
4382:                 .Top          = 7
4383:                 .Left         = 10
4384:                 .Width        = 484
4385:                 .Height       = 207
4386:                 .ReadOnly     = .T.
4387:                 .GridLines    = 1
4388:                 .HeaderHeight = 20
4389:                 .FontName     = "Tahoma"
4390:                 .FontSize     = 8
4391:                 .Visible      = .T.
4392:             ENDWITH
4393:             WITH loc_oGrd.Column1
4394:                 .Header1.Caption = "Tipo Opera" + CHR(231) + CHR(227) + "o"
4395:                 .ControlSource   = "TmpOpera.TpOps"
4396:                 .Width           = 120
4397:             ENDWITH
4398:             WITH loc_oGrd.Column2
4399:                 .Header1.Caption = "Qtde"
4400:                 .ControlSource   = "TmpOpera.QtdeSais"
4401:                 .Width           = 80
4402:             ENDWITH
4403:             WITH loc_oGrd.Column3
4404:                 .Header1.Caption = "F.Adm"
4405:                 .ControlSource   = "TmpOpera.PFalha"
4406:                 .Width           = 60
4407:             ENDWITH
4408:             WITH loc_oGrd.Column4
4409:                 .Header1.Caption = "Falha"
4410:                 .ControlSource   = "TmpOpera.Falha"
4411:                 .Width           = 60
4412:             ENDWITH
4413:             WITH loc_oGrd.Column5
4414:                 .Header1.Caption = "Base Falha"
4415:                 .ControlSource   = "TmpOpera.PesoBSais"
4416:                 .Width           = 80
4417:             ENDWITH
4418:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeSaidasAfterRowColChange")
4419:             BINDEVENT(par_oCnt.Pagina.Pages(2), "Activate", THIS, "PaginaResultadoPage2Activate")
4420: 
4421:             *-- Get_TpOperacao em Page2 (top=220,left=10,w=484,h=23)
4422:             par_oCnt.Pagina.Pages(2).AddObject("Get_TpOperacao", "TextBox")
4423:             WITH par_oCnt.Pagina.Pages(2).Get_TpOperacao
4424:                 .Value         = ""
4425:                 .Top           = 220
4426:                 .Left          = 10
4427:                 .Width         = 484
4428:                 .Height        = 23
4429:                 .ReadOnly      = .T.
4430:                 .FontName      = "Tahoma"
4431:                 .FontSize      = 8

*-- Linhas 4441 a 4536:
4441:             par_oCnt.Pagina.Pages(3).GradeResumo.RecordSource = "TmpResFas"
4442:             loc_oGrd = par_oCnt.Pagina.Pages(3).GradeResumo
4443:             WITH loc_oGrd
4444:                 .Top          = 7
4445:                 .Left         = 10
4446:                 .Width        = 484
4447:                 .Height       = 241
4448:                 .ReadOnly     = .T.
4449:                 .GridLines    = 1
4450:                 .HeaderHeight = 20
4451:                 .FontName     = "Tahoma"
4452:                 .FontSize     = 8
4453:                 .Visible      = .T.
4454:             ENDWITH
4455:             WITH loc_oGrd.Column1
4456:                 .Header1.Caption = "Fases"
4457:                 .ControlSource   = "TmpResFas.Fases"
4458:                 .Width           = 120
4459:             ENDWITH
4460:             WITH loc_oGrd.Column2
4461:                 .Header1.Caption = "Qtde"
4462:                 .ControlSource   = "TmpResFas.Qtds"
4463:                 .Width           = 120
4464:             ENDWITH
4465:             WITH loc_oGrd.Column3
4466:                 .Header1.Caption = "Pe" + CHR(231) + "as"
4467:                 .ControlSource   = "TmpResFas.QtdPcs"
4468:                 .Width           = 120
4469:             ENDWITH
4470:             WITH loc_oGrd.Column4
4471:                 .Header1.Caption = "Pesos"
4472:                 .ControlSource   = "TmpResFas.Pesos"
4473:                 .Width           = 120
4474:             ENDWITH
4475: 
4476:             *-- cnt_4c_Conversao (top=292,left=192,w=248,h=66) - inicia oculto
4477:             par_oCnt.AddObject("cnt_4c_Conversao", "Container")
4478:             WITH par_oCnt.cnt_4c_Conversao
4479:                 .Top         = 292
4480:                 .Left        = 192
4481:                 .Width       = 248
4482:                 .Height      = 66
4483:                 .BackColor   = RGB(240, 240, 240)
4484:                 .BackStyle   = 1
4485:                 .Visible     = .F.
4486:             ENDWITH
4487:             par_oCnt.cnt_4c_Conversao.AddObject("lbl_4c_TituloConv", "Label")
4488:             WITH par_oCnt.cnt_4c_Conversao.lbl_4c_TituloConv
4489:                 .Caption   = "Convers" + CHR(227) + "o"
4490:                 .Top       = 3
4491:                 .Left      = 13
4492:                 .Width     = 62
4493:                 .Height    = 15
4494:                 .FontName  = "Tahoma"
4495:                 .FontSize  = 8
4496:                 .FontBold  = .T.
4497:                 .BackStyle = 0
4498:                 .AutoSize  = .F.
4499:                 .Visible   = .T.
4500:             ENDWITH
4501:             par_oCnt.cnt_4c_Conversao.AddObject("lbl_4c_DataLabel", "Label")
4502:             WITH par_oCnt.cnt_4c_Conversao.lbl_4c_DataLabel
4503:                 .Caption   = "Data:"
4504:                 .Top       = 33
4505:                 .Left      = 4
4506:                 .Width     = 30
4507:                 .Height    = 15
4508:                 .FontName  = "Tahoma"
4509:                 .FontSize  = 8
4510:                 .BackStyle = 0
4511:                 .AutoSize  = .F.
4512:                 .Visible   = .T.
4513:             ENDWITH
4514:             par_oCnt.cnt_4c_Conversao.AddObject("lbl_4c_MoedaLabel", "Label")
4515:             WITH par_oCnt.cnt_4c_Conversao.lbl_4c_MoedaLabel
4516:                 .Caption   = "Moeda:"
4517:                 .Top       = 33
4518:                 .Left      = 122
4519:                 .Width     = 40
4520:                 .Height    = 15
4521:                 .FontName  = "Tahoma"
4522:                 .FontSize  = 8
4523:                 .BackStyle = 0
4524:                 .AutoSize  = .F.
4525:                 .Visible   = .T.
4526:             ENDWITH
4527:             par_oCnt.cnt_4c_Conversao.AddObject("txt_4c_DataCc", "TextBox")
4528:             WITH par_oCnt.cnt_4c_Conversao.txt_4c_DataCc
4529:                 .Value         = DATE()
4530:                 .Top           = 28
4531:                 .Left          = 36
4532:                 .Width         = 80
4533:                 .Height        = 25
4534:                 .Format        = "K"
4535:                 .FontName      = "Tahoma"
4536:                 .FontSize      = 8

*-- Linhas 4542 a 4636:
4542:             par_oCnt.cnt_4c_Conversao.AddObject("txt_4c_MOEDA", "TextBox")
4543:             WITH par_oCnt.cnt_4c_Conversao.txt_4c_MOEDA
4544:                 .Value         = ""
4545:                 .Top           = 28
4546:                 .Left          = 166
4547:                 .Width         = 31
4548:                 .Height        = 25
4549:                 .MaxLength     = 10
4550:                 .FontName      = "Tahoma"
4551:                 .FontSize      = 8
4552:                 .BackColor     = RGB(255, 255, 255)
4553:                 .BorderStyle   = 1
4554:                 .SpecialEffect = 0
4555:                 .Visible       = .T.
4556:             ENDWITH
4557:             BINDEVENT(par_oCnt.cnt_4c_Conversao.txt_4c_MOEDA, "KeyPress", THIS, "MoedaLostFocus")
4558:             par_oCnt.cnt_4c_Conversao.AddObject("cmd_4c_Cotacao", "CommandButton")
4559:             WITH par_oCnt.cnt_4c_Conversao.cmd_4c_Cotacao
4560:                 .Caption         = ""
4561:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_26.jpg"
4562:                 .PicturePosition = 4
4563:                 .Top             = 20
4564:                 .Left            = 202
4565:                 .Width           = 40
4566:                 .Height          = 40
4567:                 .ToolTipText     = "Cota" + CHR(231) + CHR(227) + "o"
4568:                 .Themes          = .T.
4569:                 .SpecialEffect   = 0
4570:                 .MousePointer    = 15
4571:                 .Visible         = .T.
4572:             ENDWITH
4573:             BINDEVENT(par_oCnt.cnt_4c_Conversao.cmd_4c_Cotacao, "Click", THIS, "CotacaoClick")
4574: 
4575:             *-- GradeMat (top=46,left=6,w=178,h=409,3 cols)
4576:             *-- RecordSource/ColumnCount FORA de WITH (Problema 36)
4577:             par_oCnt.AddObject("GradeMat", "Grid")
4578:             par_oCnt.GradeMat.ColumnCount  = 3
4579:             par_oCnt.GradeMat.RecordSource = "TmpResumo"
4580:             loc_oGrd = par_oCnt.GradeMat
4581:             WITH loc_oGrd
4582:                 .Top          = 46
4583:                 .Left         = 6
4584:                 .Width        = 178
4585:                 .Height       = 409
4586:                 .ReadOnly     = .F.
4587:                 .GridLines    = 1
4588:                 .HeaderHeight = 20
4589:                 .FontName     = "Tahoma"
4590:                 .FontSize     = 8
4591:                 .Visible      = .T.
4592:             ENDWITH
4593:             WITH loc_oGrd.Column1
4594:                 .Header1.Caption = "Material"
4595:                 .ControlSource   = "TmpResumo.CMats"
4596:                 .Width           = 110
4597:                 .ReadOnly        = .T.
4598:             ENDWITH
4599:             WITH loc_oGrd.Column2
4600:                 .Header1.Caption = ""
4601:                 .ControlSource   = "TmpResumo.Flag3"
4602:                 .Width           = 32
4603:                 .Sparse          = .F.
4604:             ENDWITH
4605:             loc_oGrd.Column2.AddObject("Check1", "CheckBox")
4606:             WITH loc_oGrd.Column2.Check1
4607:                 .Caption   = ""
4608:                 .Alignment = 0
4609:                 .ReadOnly  = .F.
4610:                 .Visible   = .T.
4611:                 .Top       = 9
4612:                 .Left      = 2
4613:                 .Height    = 17
4614:                 .Width     = 22
4615:             ENDWITH
4616:             loc_oGrd.Column2.CurrentControl = "Check1"
4617:             WITH loc_oGrd.Column3
4618:                 .Header1.Caption = "I"
4619:                 .ControlSource   = "TmpResumo.Flag2"
4620:                 .Width           = 32
4621:                 .Sparse          = .F.
4622:                 .ReadOnly        = .T.
4623:             ENDWITH
4624:             loc_oGrd.Column3.AddObject("Check1", "CheckBox")
4625:             WITH loc_oGrd.Column3.Check1
4626:                 .Caption   = ""
4627:                 .Alignment = 0
4628:                 .ReadOnly  = .T.
4629:                 .Visible   = .T.
4630:                 .Top       = 9
4631:                 .Left      = 2
4632:                 .Height    = 17
4633:                 .Width     = 22
4634:             ENDWITH
4635:             loc_oGrd.Column3.CurrentControl = "Check1"
4636:             BINDEVENT(loc_oGrd, "AfterRowColChange", THIS, "GradeMatAfterRowColChange")

*-- Linhas 4880 a 4888:
4880: 
4881:     *==========================================================================
4882:     * CotacaoClick - Abre form de cotacao de moeda
4883:     * PUBLIC: BINDEVENT em cmd_4c_Cotacao.Click
4884:     *==========================================================================
4885:     PROCEDURE CotacaoClick()
4886:         TRY
4887:             IF USED("crSigCdFcx") AND !EOF("crSigCdFcx")
4888:                 DO FORM SigOpCot WITH THISFORM, crSigCdFcx.Datas

*-- Linhas 5030 a 5038:
5030:     ENDPROC
5031: 
5032:     *==========================================================================
5033:     * chkPerdasClick - Desabilita outros checkboxes quando Perdas marcado
5034:     * PUBLIC: BINDEVENT exige metodo publico
5035:     *==========================================================================
5036:     PROCEDURE chkPerdasClick()
5037:         LOCAL loc_oCnt
5038:         TRY


### BO (C:\4c\projeto\app\classes\FeaBO.prg):
*==============================================================================
* FeaBO.prg - Business Object: Fechamento de Estoque (Balanco)
* Tabela principal: SigCdFcx
* Formulario origem: SIGCDFEA.SCX (frmcadastro)
* Criado: 2026-08-02
*
* Schema SigCdFcx:
*   emps char(3), codigos numeric(6,0), grupos char(10), contas char(10),
*   datais datetime, datas datetime, cpros char(14), entradas numeric(11,3),
*   fadmins numeric(11,3), freals numeric(11,3), pesagems numeric(11,3),
*   saidas numeric(11,3), saldos numeric(11,3), usuars char(10),
*   cidchaves char(20) PK
*==============================================================================

DEFINE CLASS FeaBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades da tabela SigCdFcx (schema exato)
    *--------------------------------------------------------------------------
    this_cEmps      = ""   && emps char(3) - empresa
    this_nCodigos   = 0    && codigos numeric(6,0) - codigo negocio
    this_cGrupos    = ""   && grupos char(10)
    this_cContas    = ""   && contas char(10)
    this_dDatais    = {}   && datais datetime - data inicial
    this_dDatas     = {}   && datas datetime - data final
    this_cCpros     = ""   && cpros char(14) - codigo produto
    this_nEntradas  = 0    && entradas numeric(11,3)
    this_nFadmins   = 0    && fadmins numeric(11,3) - falha admitida
    this_nFreals    = 0    && freals numeric(11,3) - falha real
    this_nPesagems  = 0    && pesagems numeric(11,3)
    this_nSaidas    = 0    && saidas numeric(11,3)
    this_nSaldos    = 0    && saldos numeric(11,3)
    this_cUsuars    = ""   && usuars char(10)
    this_cCidChaves = ""   && cidchaves char(20) - PK

    *--------------------------------------------------------------------------
    * Propriedades de descricao (lookup - nao armazenadas na tabela)
    *--------------------------------------------------------------------------
    this_cDGrupos   = ""   && descricao do grupo (TmpGccr.Descrs)
    this_cDContas   = ""   && descricao da conta (TmpCli.RClis)

    *--------------------------------------------------------------------------
    * Propriedades de filtro de periodo (Page1/Lista)
    *--------------------------------------------------------------------------
    this_cEmpFiltro  = ""  && empresa do filtro (Get_cd_empresa)
    this_dDtInicial  = {}  && data inicial do filtro
    this_dDtFinal    = {}  && data final do filtro

    *--------------------------------------------------------------------------
    * Propriedades de estado do processo
    *--------------------------------------------------------------------------
    this_nLote      = 0    && lote de processamento (getlote - numeric 6)
    this_lFechamento = .T. && registro esta aberto para processamento
    this_lAcInserir  = .F. && acao de insercao ativa
    this_lEntraPeso  = .F. && entrada de peso via balanca

    *--------------------------------------------------------------------------
    * Propriedades de resultado (populadas apos ProcessarBalanco via TmpResumo)
    *--------------------------------------------------------------------------
    this_nSaldoi    = 0    && saldo inicial (TmpResumo.Saldoi)
    this_nQtdeEnts  = 0    && quantidade de entradas (TmpResumo.QtdeEnts)
    this_nSEntradas = 0    && saldo + entradas (calculado: Saldoi + QtdeEnts)
    this_nQtdeSais  = 0    && quantidade de saidas (TmpResumo.QtdeSais)
    this_nPesagem   = 0    && pesagem fisica (TmpResumo.Pesagem)
    this_nFReal     = 0    && falha real (TmpResumo.FReal)
    this_nFAdmin    = 0    && falha admitida (TmpResumo.FAdmin)
    this_nSaldof    = 0    && saldo final (TmpResumo.Saldof)
    this_nPfTrabs   = 0    && percentual falha/trabalhado (TmpResumo.PfTrabs)

    *--------------------------------------------------------------------------
    * Propriedades de filtros de impressao (checkboxes/opcoes do Resultado)
    *--------------------------------------------------------------------------
    this_lPerdas    = .F.  && demonstrativo de perdas (chkPerdas)
    this_lHistorico = .F.  && historico (Historico)
    this_lResumido  = .T.  && resumido - default ativo (Resumido)
    this_lAnalitico = .F.  && analitico (Analitico)
    this_lServicos  = .F.  && servicos (chkServ)
    this_lPorMov    = .F.  && por movimentacao (porMov)
    this_lPorEnv    = .F.  && por envio (porenv)
    this_lPorMat    = .F.  && por material (pormat)
    this_lMovAgru   = .F.  && movimentacao agrupada (MovAgru)
    this_lMovLote   = .F.  && movimentacao por lote (MovLote)
    this_nOrdem     = 1    && opcao de ordem do relatorio (op_ordem)

    *--------------------------------------------------------------------------
    * Propriedades de conversao de moeda (Cnt_Conversao)
    *--------------------------------------------------------------------------
    this_cMoeda     = ""   && codigo da moeda (Get_MOEDA / SigCdMoe.CMoes)
    this_dDataCc    = {}   && data de conversao (Get_DataCc)

    *--------------------------------------------------------------------------
    * Propriedades de tipo de operacao selecionada (AfterRowColChange GradeMat)
    *--------------------------------------------------------------------------
    this_cTpOperacao = ""  && tipo de operacao do grid (TmpOpera.TpOps)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdFcx"
            THIS.this_cCampoChave = "CidChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros de SigCdFcx filtrados por empresa e periodo
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cDtF
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Codigos, a.Grupos, a.Contas," + ;
                       " a.Datais, a.Datas, a.Cpros, a.Entradas," + ;
                       " a.Fadmins, a.Freals, a.Pesagems, a.Saidas," + ;
                       " a.Saldos, a.Usuars, a.CidChaves" + ;
                       " FROM SigCdFcx a" + ;
                       " WHERE a.Emps = " + EscaparSQL(ALLTRIM(THIS.this_cEmpFiltro))

            IF VARTYPE(THIS.this_dDtInicial) = "D" AND !EMPTY(THIS.this_dDtInicial)
                loc_cSQL = loc_cSQL + " AND a.Datas >= " + FormatarDataSQL(THIS.this_dDtInicial)
            ENDIF

            IF VARTYPE(THIS.this_dDtFinal) = "D" AND !EMPTY(THIS.this_dDtFinal)
                loc_cDtF = FormatarDataSQL(THIS.this_dDtFinal)
                loc_cDtF = LEFT(loc_cDtF, LEN(loc_cDtF) - 1) + " 23:59:59'"
                loc_cSQL = loc_cSQL + " AND a.Datas <= " + loc_cDtF
            ENDIF

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + " AND (" + par_cFiltro + ")"
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.Grupos, a.Contas, a.Datas"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao listar Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro por CidChaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.Emps, a.Codigos, a.Grupos, a.Contas," + ;
                       " a.Datais, a.Datas, a.Cpros, a.Entradas," + ;
                       " a.Fadmins, a.Freals, a.Pesagems, a.Saidas," + ;
                       " a.Saldos, a.Usuars, a.CidChaves" + ;
                       " FROM SigCdFcx a" + ;
                       " WHERE a.CidChaves = " + EscaparSQL(ALLTRIM(par_cCodigo))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

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
                THIS.this_cEmps      = TratarNulo(Emps,      "C")
                THIS.this_nCodigos   = TratarNulo(Codigos,   "N")
                THIS.this_cGrupos    = TratarNulo(Grupos,    "C")
                THIS.this_cContas    = TratarNulo(Contas,    "C")
                THIS.this_dDatais    = IIF(ISNULL(Datais),   {}, TTOD(Datais))
                THIS.this_dDatas     = IIF(ISNULL(Datas),    {}, TTOD(Datas))
                THIS.this_cCpros     = TratarNulo(Cpros,     "C")
                THIS.this_nEntradas  = TratarNulo(Entradas,  "N")
                THIS.this_nFadmins   = TratarNulo(Fadmins,   "N")
                THIS.this_nFreals    = TratarNulo(Freals,    "N")
                THIS.this_nPesagems  = TratarNulo(Pesagems,  "N")
                THIS.this_nSaidas    = TratarNulo(Saidas,    "N")
                THIS.this_nSaldos    = TratarNulo(Saldos,    "N")
                THIS.this_cUsuars    = TratarNulo(Usuars,    "C")
                THIS.this_cCidChaves = TratarNulo(CidChaves, "C")
                loc_lResultado = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SigCdFcx (chamado pelo Salvar do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            *-- Gerar chave primaria unica via SQL Server
            SQLEXEC(gnConnHandle, "SELECT REPLACE(CAST(NEWID() AS VARCHAR(36)),'-','') AS chave", "cursor_4c_ChaveNova")
            IF USED("cursor_4c_ChaveNova") AND RECCOUNT("cursor_4c_ChaveNova") > 0
                SELECT cursor_4c_ChaveNova
                THIS.this_cCidChaves = LEFT(ALLTRIM(chave), 20)
                USE IN cursor_4c_ChaveNova
            ELSE
                IF USED("cursor_4c_ChaveNova")
                    USE IN cursor_4c_ChaveNova
                ENDIF
                THIS.this_cCidChaves = LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa) + "FCX" + TRANSFORM(SECONDS()), 20)
            ENDIF

            THIS.this_cEmps   = LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "INSERT INTO SigCdFcx" + ;
                       " (Emps, Codigos, Grupos, Contas, Datais, Datas," + ;
                       "  Cpros, Entradas, Fadmins, Freals, Pesagems," + ;
                       "  Saidas, Saldos, Usuars, CidChaves)" + ;
                       " VALUES (" + ;
                       EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cContas, 10)) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatais) + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCpros, 14)) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nEntradas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFadmins) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFreals) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPesagems) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSaidas) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSaldos) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ", " + ;
                       EscaparSQL(LEFT(THIS.this_cCidChaves, 20)) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdFcx (chamado pelo Salvar do BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            THIS.this_cUsuars = LEFT(ALLTRIM(gc_4c_UsuarioLogado), 10)

            loc_cSQL = "UPDATE SigCdFcx SET" + ;
                       " Grupos   = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
                       " Contas   = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
                       " Datais   = " + FormatarDataSQL(THIS.this_dDatais) + "," + ;
                       " Datas    = " + FormatarDataSQL(THIS.this_dDatas) + "," + ;
                       " Cpros    = " + EscaparSQL(LEFT(THIS.this_cCpros, 14)) + "," + ;
                       " Entradas = " + FormatarNumeroSQL(THIS.this_nEntradas) + "," + ;
                       " Fadmins  = " + FormatarNumeroSQL(THIS.this_nFadmins) + "," + ;
                       " Freals   = " + FormatarNumeroSQL(THIS.this_nFreals) + "," + ;
                       " Pesagems = " + FormatarNumeroSQL(THIS.this_nPesagems) + "," + ;
                       " Saidas   = " + FormatarNumeroSQL(THIS.this_nSaidas) + "," + ;
                       " Saldos   = " + FormatarNumeroSQL(THIS.this_nSaldos) + "," + ;
                       " Usuars   = " + EscaparSQL(LEFT(THIS.this_cUsuars, 10)) + ;
                       " WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar Fechamento de Estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SigCdFcx e movimentos relacionados
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cEdns
        loc_lResultado = .F.

        TRY
            *-- Chave composta usada em SigMvCab/SigMvItn
            loc_cEdns = LEFT(ALLTRIM(THIS.this_cEmps), 3) + PADL(TRANSFORM(THIS.this_nCodigos), 6, "0")

            *-- Excluir itens de movimentos (SigMvItn)
            loc_cSQL    = "DELETE FROM SigMvItn WHERE EmpDopNums = " + EscaparSQL(loc_cEdns)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                *-- Excluir cabecalho de movimentos (SigMvCab)
                loc_cSQL    = "DELETE FROM SigMvCab WHERE EmpDopNums = " + EscaparSQL(loc_cEdns)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResult >= 0
                    *-- Excluir registro principal (SigCdFcx)
                    loc_cSQL    = "DELETE FROM SigCdFcx WHERE CidChaves = " + EscaparSQL(THIS.this_cCidChaves)
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

                    IF loc_nResult >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lResultado = .T.
                    ELSE
                        MsgErro("Erro ao excluir Fechamento de Estoque (SigCdFcx):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    MsgErro("Erro ao excluir cabecalho de movimentos (SigMvCab):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens de movimentos (SigMvItn):" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * PreencherFiltro - Define parametros de filtro empresa + periodo
    *--------------------------------------------------------------------------
    PROCEDURE PreencherFiltro(par_cEmp, par_dDtI, par_dDtF)
        THIS.this_cEmpFiltro = ALLTRIM(par_cEmp)
        THIS.this_dDtInicial = par_dDtI
        THIS.this_dDtFinal   = par_dDtF
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarGrupos - Carrega cursor de grupos de conta corrente para lookup
    *--------------------------------------------------------------------------
    FUNCTION BuscarGrupos(par_cValor)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT g.Codigos, g.Descrs FROM SigCdGcr g"

            IF VARTYPE(par_cValor) = "C" AND !EMPTY(ALLTRIM(par_cValor))
                loc_cSQL = loc_cSQL + " WHERE g.Codigos LIKE " + EscaparSQL(ALLTRIM(par_cValor) + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY g.Descrs"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaGrupo")
                TABLEREVERT(.T., "cursor_4c_BuscaGrupo")
                USE IN cursor_4c_BuscaGrupo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaGrupo")
            loc_lResultado = (loc_nResult >= 0)
            IF !loc_lResultado
                MsgErro("Erro ao buscar grupos de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarContas - Carrega cursor de contas/clientes para lookup (SigCdCli)
    *--------------------------------------------------------------------------
    FUNCTION BuscarContas(par_cGrupo, par_cValor)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT c.Iclis, c.RClis, c.Inativas FROM SigCdCli c ORDER BY c.RClis"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_BuscaConta")
                TABLEREVERT(.T., "cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")
            loc_lResultado = (loc_nResult >= 0)
            IF !loc_lResultado
                MsgErro("Erro ao buscar contas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDFUNC

ENDDEFINE

