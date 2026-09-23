# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (3)
- [FONTNAME-ERRADO] Linha 213: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 239: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 297: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormUsu.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1483 linhas total):

*-- Linhas 58 a 67:
58:             ELSE
59:                 THIS.ConfigurarPageFrame()
60: 
61:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63: 
64:                 THIS.pgf_4c_Paginas.Visible   = .T.
65:                 THIS.pgf_4c_Paginas.ActivePage = 1
66:                 THIS.this_cModoAtual = "LISTA"
67: 

*-- Linhas 88 a 105:
88: 
89:         WITH loc_oPgf
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = THIS.Width
94:             .Height    = THIS.Height + 29
95:             .Tabs      = .F.
96:             .Visible   = .T.
97:             .Page1.Caption   = "Lista"
98:             .Page1.BackColor = RGB(100, 100, 100)
99:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page2.Caption   = "Dados"
101:             .Page2.BackColor = RGB(100, 100, 100)
102:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()

*-- Linhas 118 a 156:
118:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
119:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
120:         WITH loc_oCab
121:             .Top         = 31
122:             .Left        = 0
123:             .Width       = THIS.Width
124:             .Height      = 80
125:             .BackColor   = RGB(100, 100, 100)
126:             .BorderWidth = 0
127:             .Visible     = .T.
128:         ENDWITH
129: 
130:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
131:         WITH loc_oCab.lbl_4c_Sombra
132:             .AutoSize  = .F.
133:             .Caption   = THIS.Caption
134:             .Top       = 15
135:             .Left      = 10
136:             .Width     = THIS.Width
137:             .Height    = 40
138:             .FontName  = "Tahoma"
139:             .FontSize  = 16
140:             .FontBold  = .T.
141:             .ForeColor = RGB(0, 0, 0)
142:             .BackStyle = 0
143:             .Visible   = .T.
144:         ENDWITH
145: 
146:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
147:         WITH loc_oCab.lbl_4c_Titulo
148:             .AutoSize  = .F.
149:             .Caption   = THIS.Caption
150:             .Top       = 18
151:             .Left      = 10
152:             .Width     = THIS.Width
153:             .Height    = 46
154:             .FontName  = "Tahoma"
155:             .FontSize  = 16
156:             .FontBold  = .T.

*-- Linhas 162 a 263:
162:         *-- Container dos botoes CRUD (lado direito, canonico)
163:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
164:         WITH loc_oPg1.cnt_4c_Botoes
165:             .Top         = 29
166:             .Left        = 542
167:             .Width       = 390
168:             .Height      = 85
169:             .BackStyle   = 1
170:             .BackColor   = RGB(53, 53, 53)
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         THIS.CriarBotaoCrud(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Incluir", 5, ;
176:             "Incluir", "cadastro_inserir_26.jpg")
177:         THIS.CriarBotaoCrud(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Visualizar", 80, ;
178:             "Visualizar", "cadastro_vizualizar_60.jpg")
179:         THIS.CriarBotaoCrud(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Alterar", 155, ;
180:             "Alterar", "cadastro_alterar_60.jpg")
181:         THIS.CriarBotaoCrud(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Excluir", 230, ;
182:             "Excluir", "cadastro_excluir_60.jpg")
183:         THIS.CriarBotaoCrud(loc_oPg1.cnt_4c_Botoes, "cmd_4c_Buscar", 305, ;
184:             "Buscar", "cadastro_procurar_60.jpg")
185: 
186:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
187:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
188:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
189:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
190:         BINDEVENT(loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
191: 
192:         *-- Container de saida (canonico - PREVALECE sobre PILAR 1, regra #10)
193:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
194:         WITH loc_oPg1.cnt_4c_Saida
195:             .Top         = 29
196:             .Left        = 917
197:             .Width       = 90
198:             .Height      = 85
199:             .BackStyle   = 0
200:             .BorderWidth = 0
201:             .Visible     = .T.
202:         ENDWITH
203: 
204:         loc_oPg1.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
205:         WITH loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar
206:             .Top             = 5
207:             .Left            = 5
208:             .Width           = 75
209:             .Height          = 75
210:             .Caption         = "Encerrar"
211:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
212:             .PicturePosition = 13
213:             .FontName        = "Comic Sans MS"
214:             .FontBold        = .T.
215:             .FontItalic      = .T.
216:             .FontSize        = 8
217:             .ForeColor       = RGB(90, 90, 90)
218:             .BackColor       = RGB(255, 255, 255)
219:             .Themes          = .F.
220:             .SpecialEffect   = 0
221:             .MousePointer    = 15
222:             .WordWrap        = .T.
223:             .AutoSize        = .F.
224:             .Visible         = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
227: 
228:         *-- Botao "Limpa Senha" (cmdGLimSenha no legado) - standalone, area do Grid
229:         loc_oPg1.AddObject("cmd_4c_LimparSenha", "CommandButton")
230:         WITH loc_oPg1.cmd_4c_LimparSenha
231:             .Top             = 33
232:             .Left            = 472
233:             .Width           = 75
234:             .Height          = 75
235:             .Caption         = "Limpa Senha"
236:             .ToolTipText     = "Limpar Senha"
237:             .Picture         = gc_4c_CaminhoIcones + "geral_cores_60.jpg"
238:             .PicturePosition = 13
239:             .FontName        = "Comic Sans MS"
240:             .FontBold        = .T.
241:             .FontItalic      = .T.
242:             .FontSize        = 8
243:             .ForeColor       = RGB(90, 90, 90)
244:             .BackColor       = RGB(255, 255, 255)
245:             .Themes          = .F.
246:             .SpecialEffect   = 0
247:             .MousePointer    = 15
248:             .WordWrap        = .T.
249:             .AutoSize        = .F.
250:             .Visible         = .T.
251:         ENDWITH
252:         BINDEVENT(loc_oPg1.cmd_4c_LimparSenha, "Click", THIS, "BtnLimparSenhaClick")
253: 
254:         *-- Grid de listagem (Grade no legado)
255:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
256:         WITH loc_oPg1.grd_4c_Lista
257:             .Top                = 117
258:             .Left               = 26
259:             .Width              = 890
260:             .Height             = 498
261:             .ColumnCount        = 5
262:             .FontName           = "Tahoma"
263:             .FontSize           = 8

*-- Linhas 287 a 303:
287:         par_oContainer.AddObject(par_cNome, "CommandButton")
288:         loc_oBtn = EVALUATE("par_oContainer." + par_cNome)
289:         WITH loc_oBtn
290:             .Top             = 5
291:             .Left            = par_nLeft
292:             .Width           = 75
293:             .Height          = 75
294:             .Caption         = par_cCaption
295:             .Picture         = gc_4c_CaminhoIcones + par_cIcone
296:             .PicturePosition = 13
297:             .FontName        = "Comic Sans MS"
298:             .FontBold        = .T.
299:             .FontItalic      = .T.
300:             .FontSize        = 8
301:             .ForeColor       = RGB(90, 90, 90)
302:             .BackColor       = RGB(255, 255, 255)
303:             .Themes          = .F.

*-- Linhas 322 a 360:
322:         loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
323:         loc_oCab = loc_oPg2.cnt_4c_Cabecalho
324:         WITH loc_oCab
325:             .Top         = 31
326:             .Left        = 0
327:             .Width       = THIS.Width
328:             .Height      = 80
329:             .BackColor   = RGB(100, 100, 100)
330:             .BorderWidth = 0
331:             .Visible     = .T.
332:         ENDWITH
333: 
334:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
335:         WITH loc_oCab.lbl_4c_Sombra
336:             .AutoSize  = .F.
337:             .Caption   = THIS.Caption
338:             .Top       = 15
339:             .Left      = 10
340:             .Width     = THIS.Width
341:             .Height    = 40
342:             .FontName  = "Tahoma"
343:             .FontSize  = 16
344:             .FontBold  = .T.
345:             .ForeColor = RGB(0, 0, 0)
346:             .BackStyle = 0
347:             .Visible   = .T.
348:         ENDWITH
349: 
350:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
351:         WITH loc_oCab.lbl_4c_Titulo
352:             .AutoSize  = .F.
353:             .Caption   = THIS.Caption
354:             .Top       = 18
355:             .Left      = 10
356:             .Width     = THIS.Width
357:             .Height    = 46
358:             .FontName  = "Tahoma"
359:             .FontSize  = 16
360:             .FontBold  = .T.

*-- Linhas 368 a 404:
368:         *-- em fase posterior
369:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
370:         WITH loc_oPg2.cnt_4c_BotoesAcao
371:             .Top         = 33
372:             .Left        = 842
373:             .Width       = 160
374:             .Height      = 85
375:             .BackStyle   = 0
376:             .BorderWidth = 0
377:             .Visible     = .T.
378:         ENDWITH
379: 
380:         THIS.CriarBotaoCrud(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5, ;
381:             "Confirmar", "cadastro_salvar_60.jpg")
382:         THIS.CriarBotaoCrud(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 80, ;
383:             "Cancelar", "cadastro_cancelar_60.jpg")
384: 
385:         BINDEVENT(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
386:         BINDEVENT(loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
387: 
388:         *======================================================================
389:         * CAMPOS PRINCIPAIS - PARTE 1 (Fase 5/8)
390:         * Tops compensados +29 (PageFrame.Top=-29). Todos >= 190, portanto
391:         * sem conflito com a faixa do cabecalho (29..109, regra #11).
392:         *======================================================================
393: 
394:         *-- Usuario: Label1.Top=165+29=194, getUsuarios.Top=161+29=190
395:         loc_oPg2.AddObject("lbl_4c_Usuario", "Label")
396:         WITH loc_oPg2.lbl_4c_Usuario
397:             .Caption   = "Usu" + CHR(225) + "rio :"
398:             .Top       = 194
399:             .Left      = 329
400:             .Width     = 45
401:             .Height    = 15
402:             .AutoSize  = .F.
403:             .Alignment = 0
404:             .FontName  = "Tahoma"

*-- Linhas 412 a 439:
412:         loc_oPg2.AddObject("txt_4c_Usuarios", "TextBox")
413:         WITH loc_oPg2.txt_4c_Usuarios
414:             .Value         = ""
415:             .Top           = 190
416:             .Left          = 376
417:             .Width         = 81
418:             .Height        = 24
419:             .MaxLength     = 10
420:             .FontName      = "Tahoma"
421:             .FontSize      = 8
422:             .ForeColor     = RGB(90, 90, 90)
423:             .BackColor     = RGB(255, 255, 255)
424:             .BorderStyle   = 1
425:             .SpecialEffect = 0
426:             .Visible       = .T.
427:         ENDWITH
428: 
429:         *-- Ativo: Say5.Top=166+29=195, optativo.Top=165+29=194 (OptionGroup)
430:         loc_oPg2.AddObject("lbl_4c_Ativo", "Label")
431:         WITH loc_oPg2.lbl_4c_Ativo
432:             .Caption   = "Ativo :"
433:             .Top       = 195
434:             .Left      = 472
435:             .Width     = 38
436:             .Height    = 17
437:             .AutoSize  = .F.
438:             .Alignment = 0
439:             .FontName  = "Tahoma"

*-- Linhas 446 a 495:
446:         loc_oPg2.AddObject("obj_4c_Ativo", "OptionGroup")
447:         WITH loc_oPg2.obj_4c_Ativo
448:             .ButtonCount = 2
449:             .Top         = 194
450:             .Left        = 510
451:             .Width       = 103
452:             .Height      = 17
453:             .BackStyle   = 0
454:             .BorderStyle = 0
455:             .Value       = 1
456:             .Visible     = .T.
457:         ENDWITH
458:         WITH loc_oPg2.obj_4c_Ativo.Buttons(1)
459:             .Caption   = "Sim"
460:             .Left      = 5
461:             .Top       = 1
462:             .Width     = 34
463:             .Height    = 15
464:             .AutoSize  = .T.
465:             .Style     = 0
466:             .FontName  = "Tahoma"
467:             .FontSize  = 8
468:             .ForeColor = RGB(90, 90, 90)
469:             .BackStyle = 0
470:         ENDWITH
471:         WITH loc_oPg2.obj_4c_Ativo.Buttons(2)
472:             .Caption   = "N" + CHR(227) + "o"
473:             .Left      = 56
474:             .Top       = 1
475:             .Width     = 37
476:             .Height    = 15
477:             .AutoSize  = .T.
478:             .Style     = 0
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .ForeColor = RGB(90, 90, 90)
482:             .BackStyle = 0
483:         ENDWITH
484: 
485:         *-- Nome: Label2.Top=191+29=220, getNComps.Top=187+29=216
486:         loc_oPg2.AddObject("lbl_4c_Nome", "Label")
487:         WITH loc_oPg2.lbl_4c_Nome
488:             .Caption   = "Nome :"
489:             .Top       = 220
490:             .Left      = 338
491:             .Width     = 36
492:             .Height    = 15
493:             .AutoSize  = .F.
494:             .Alignment = 0
495:             .FontName  = "Tahoma"

*-- Linhas 503 a 530:
503:         loc_oPg2.AddObject("txt_4c_NComps", "TextBox")
504:         WITH loc_oPg2.txt_4c_NComps
505:             .Value         = ""
506:             .Top           = 216
507:             .Left          = 376
508:             .Width         = 220
509:             .Height        = 24
510:             .MaxLength     = 30
511:             .FontName      = "Tahoma"
512:             .FontSize      = 8
513:             .ForeColor     = RGB(90, 90, 90)
514:             .BackColor     = RGB(255, 255, 255)
515:             .BorderStyle   = 1
516:             .SpecialEffect = 0
517:             .Visible       = .T.
518:         ENDWITH
519: 
520:         *-- Cargo: Say6.Top=216+29=245, getCCargs.Top=213+29=242
521:         loc_oPg2.AddObject("lbl_4c_Cargo", "Label")
522:         WITH loc_oPg2.lbl_4c_Cargo
523:             .Caption   = "Cargo :"
524:             .Top       = 245
525:             .Left      = 336
526:             .Width     = 40
527:             .Height    = 17
528:             .AutoSize  = .F.
529:             .Alignment = 0
530:             .FontName  = "Tahoma"

*-- Linhas 538 a 547:
538:         loc_oPg2.AddObject("txt_4c_CCargs", "TextBox")
539:         WITH loc_oPg2.txt_4c_CCargs
540:             .Value         = ""
541:             .Top           = 242
542:             .Left          = 376
543:             .Width         = 80
544:             .Height        = 23
545:             .MaxLength     = 10
546:             .FontName      = "Tahoma"
547:             .FontSize      = 8

*-- Linhas 554 a 570:
554: 
555:         *======================================================================
556:         * CAMPOS PRINCIPAIS - PARTE 2 (Fase 6/8)
557:         * Tops compensados +29 (PageFrame.Top=-29).
558:         *======================================================================
559: 
560:         *-- Setor: Say2.Top=266+29=295, getSetores.Top=263+29=292
561:         loc_oPg2.AddObject("lbl_4c_Setores", "Label")
562:         WITH loc_oPg2.lbl_4c_Setores
563:             .Caption   = "Setor :"
564:             .Top       = 295
565:             .Left      = 339
566:             .Width     = 35
567:             .Height    = 17
568:             .AutoSize  = .F.
569:             .Alignment = 0
570:             .FontName  = "Tahoma"

*-- Linhas 578 a 607:
578:         loc_oPg2.AddObject("txt_4c_Setores", "TextBox")
579:         WITH loc_oPg2.txt_4c_Setores
580:             .Value         = ""
581:             .Top           = 292
582:             .Left          = 376
583:             .Width         = 80
584:             .Height        = 23
585:             .MaxLength     = 10
586:             .FontName      = "Tahoma"
587:             .FontSize      = 8
588:             .ForeColor     = RGB(90, 90, 90)
589:             .BackColor     = RGB(255, 255, 255)
590:             .BorderStyle   = 1
591:             .SpecialEffect = 0
592:             .Visible       = .T.
593:         ENDWITH
594: 
595:         *-- Departamento: Say1.Top=241+29=270, getDeptos.Top=238+29=267,
596:         *-- getNDeptos.Top=238+29=267 (nome do depto - nao persiste, campo
597:         *-- espelho preenchido pelo lookup)
598:         loc_oPg2.AddObject("lbl_4c_Deptos", "Label")
599:         WITH loc_oPg2.lbl_4c_Deptos
600:             .Caption   = "Departamento :"
601:             .Top       = 270
602:             .Left      = 296
603:             .Width     = 78
604:             .Height    = 17
605:             .AutoSize  = .F.
606:             .Alignment = 0
607:             .FontName  = "Tahoma"

*-- Linhas 615 a 624:
615:         loc_oPg2.AddObject("txt_4c_Deptos", "TextBox")
616:         WITH loc_oPg2.txt_4c_Deptos
617:             .Value         = ""
618:             .Top           = 267
619:             .Left          = 376
620:             .Width         = 80
621:             .Height        = 23
622:             .MaxLength     = 10
623:             .Format        = "!"
624:             .FontName      = "Tahoma"

*-- Linhas 633 a 642:
633:         loc_oPg2.AddObject("txt_4c_NDeptos", "TextBox")
634:         WITH loc_oPg2.txt_4c_NDeptos
635:             .Value         = ""
636:             .Top           = 267
637:             .Left          = 459
638:             .Width         = 290
639:             .Height        = 23
640:             .MaxLength     = 40
641:             .Format        = "!"
642:             .FontName      = "Tahoma"

*-- Linhas 648 a 663:
648:             .Visible       = .T.
649:         ENDWITH
650: 
651:         *-- Cadastro de Contas: Say3.Top=291+29=320, getIClis.Top=288+29=317,
652:         *-- getRClis.Top=288+29=317 (razao social - nao persiste, campo
653:         *-- espelho preenchido pelo lookup)
654:         loc_oPg2.AddObject("lbl_4c_IClis", "Label")
655:         WITH loc_oPg2.lbl_4c_IClis
656:             .Caption   = "Cadastro de Contas :"
657:             .Top       = 320
658:             .Left      = 269
659:             .Width     = 105
660:             .Height    = 17
661:             .AutoSize  = .F.
662:             .Alignment = 0
663:             .FontName  = "Tahoma"

*-- Linhas 671 a 680:
671:         loc_oPg2.AddObject("txt_4c_IClis", "TextBox")
672:         WITH loc_oPg2.txt_4c_IClis
673:             .Value         = ""
674:             .Top           = 317
675:             .Left          = 376
676:             .Width         = 80
677:             .Height        = 23
678:             .MaxLength     = 10
679:             .Format        = "!"
680:             .FontName      = "Tahoma"

*-- Linhas 689 a 718:
689:         loc_oPg2.AddObject("txt_4c_RClis", "TextBox")
690:         WITH loc_oPg2.txt_4c_RClis
691:             .Value         = ""
692:             .Top           = 317
693:             .Left          = 459
694:             .Width         = 290
695:             .Height        = 23
696:             .MaxLength     = 40
697:             .FontName      = "Tahoma"
698:             .FontSize      = 8
699:             .ForeColor     = RGB(90, 90, 90)
700:             .BackColor     = RGB(255, 255, 255)
701:             .BorderStyle   = 1
702:             .SpecialEffect = 0
703:             .Visible       = .T.
704:         ENDWITH
705: 
706:         *-- Obriga Cadastrar Senha: Say4.Top=318+29=347, Optiongroup1.Top=317+29=346
707:         *-- Option1Value=0 / Option2Value=1 - transcrito do SCX
708:         *-- (nao eh indice 1-based, o legado sobrescreve o valor de cada botao)
709:         loc_oPg2.AddObject("lbl_4c_ObrigaSenha", "Label")
710:         WITH loc_oPg2.lbl_4c_ObrigaSenha
711:             .Caption   = "Obriga Cadastrar Senha :"
712:             .Top       = 347
713:             .Left      = 249
714:             .Width     = 120
715:             .Height    = 17
716:             .AutoSize  = .F.
717:             .Alignment = 0
718:             .FontName  = "Tahoma"

*-- Linhas 726 a 761:
726:         loc_oPg2.AddObject("obj_4c_ObrigaSenha", "OptionGroup")
727:         WITH loc_oPg2.obj_4c_ObrigaSenha
728:             .ButtonCount = 2
729:             .Top         = 346
730:             .Left        = 371
731:             .Width       = 103
732:             .Height      = 17
733:             .BackStyle   = 0
734:             .BorderStyle = 0
735:             .Value       = 2
736:             .Visible     = .T.
737:         ENDWITH
738:         WITH loc_oPg2.obj_4c_ObrigaSenha.Buttons(1)
739:             .Caption   = "Sim"
740:             .Value     = 0
741:             .Left      = 5
742:             .Top       = 1
743:             .Width     = 34
744:             .Height    = 15
745:             .AutoSize  = .T.
746:             .Style     = 0
747:             .FontName  = "Tahoma"
748:             .FontSize  = 8
749:             .ForeColor = RGB(90, 90, 90)
750:             .BackStyle = 0
751:         ENDWITH
752:         WITH loc_oPg2.obj_4c_ObrigaSenha.Buttons(2)
753:             .Caption   = "N" + CHR(227) + "o"
754:             .Value     = 1
755:             .Left      = 56
756:             .Top       = 1
757:             .Width     = 37
758:             .Height    = 15
759:             .AutoSize  = .T.
760:             .Style     = 0
761:             .FontName  = "Tahoma"

*-- Linhas 1052 a 1064:
1052:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.deptos"
1053:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.setores"
1054: 
1055:                     loc_oGrid.Column1.Header1.Caption = "Usu" + CHR(225) + "rio"
1056:                     loc_oGrid.Column2.Header1.Caption = "Nome"
1057:                     loc_oGrid.Column3.Header1.Caption = "Cargo"
1058:                     loc_oGrid.Column4.Header1.Caption = "Depto."
1059:                     loc_oGrid.Column5.Header1.Caption = "Setor"
1060: 
1061:                     loc_oGrid.Column1.Width = 80
1062:                     loc_oGrid.Column2.Width = 310
1063:                     loc_oGrid.Column3.Width = 80
1064:                     loc_oGrid.Column4.Width = 80

*-- Linhas 1243 a 1252:
1243:         LOCAL loc_oPg2
1244:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1245: 
1246:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
1247:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1248:     ENDPROC
1249: 
1250:     *--------------------------------------------------------------------------
1251:     * BtnIncluirClick - Prepara BO/Form para INCLUIR e navega para Page2
1252:     *--------------------------------------------------------------------------


### BO (C:\4c\projeto\app\classes\UsuBO.prg):
*====================================================================
* UsuBO.prg
*
* Business Object para Usu (Cadastro de Usuarios)
* Tabela: SigCdUsu (PK: usuarios)
*====================================================================

DEFINE CLASS UsuBO AS BusinessBase

	*-- Propriedades da entidade (colunas de SigCdUsu - docs/schema.sql)
	this_cSupervis                  = ""   && char(1)  NOT NULL
	this_cUsuarios                  = ""   && char(10) NOT NULL - PK
	this_cSenhas                    = ""   && char(10) NOT NULL
	this_cCCargs                    = ""   && char(10) NOT NULL
	this_cLimDescs                  = ""   && char(1)  NOT NULL
	this_cNComps                    = ""   && char(30) NOT NULL
	this_cDeptos                    = ""   && char(10) NOT NULL
	this_cLibPess                   = ""   && char(1)  NOT NULL
	this_cLibProds                  = ""   && char(1)  NOT NULL
	this_cSetores                   = ""   && char(10) NOT NULL
	this_cCAtivos                   = ""   && char(1)  NOT NULL
	this_cMBiodigs                  = ""   && text     NULL
	this_dTDtSenhas                 = {}   && datetime NULL
	this_cIClis                     = ""   && char(10) NOT NULL
	this_nObrigSenhas                = 0    && numeric(1,0) NOT NULL
	this_cLibQtMins                 = ""   && char(1)  NOT NULL
	this_cFigJpgSUser               = ""   && text     NULL

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		LOCAL loc_lSucesso
		loc_lSucesso = .F.
		TRY
			DODEFAULT()
			THIS.this_cTabela = "SigCdUsu"
			THIS.this_cCampoChave = "usuarios"
			loc_lSucesso = .T.
		CATCH TO loException
			MostrarErro(loException, "UsuBO.Init")
		ENDTRY
		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cUsuarios)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de usuarios no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT usuarios, ncomps, ccargs, deptos, setores, cativos, iclis" + ;
				           " FROM SigCdUsu ORDER BY usuarios"
			ELSE
				loc_cSQL = "SELECT usuarios, ncomps, ccargs, deptos, setores, cativos, iclis" + ;
				           " FROM SigCdUsu" + ;
				           " WHERE RTRIM(usuarios) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " ORDER BY usuarios"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK = usuarios)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cUsuarios)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT supervis, usuarios, senhas, ccargs, limdescs," + ;
			           " ncomps, deptos, libpess, libprods, setores, cativos," + ;
			           " mbiodigs, tdtsenhas, iclis, obrigsenhas, libqtmins," + ;
			           " figjpgsuser" + ;
			           " FROM SigCdUsu" + ;
			           " WHERE RTRIM(usuarios) = " + EscaparSQL(ALLTRIM(par_cUsuarios))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cSupervis     = TratarNulo(supervis, "C")
			THIS.this_cUsuarios     = TratarNulo(usuarios, "C")
			THIS.this_cSenhas       = TratarNulo(senhas, "C")
			THIS.this_cCCargs       = TratarNulo(ccargs, "C")
			THIS.this_cLimDescs     = TratarNulo(limdescs, "C")
			THIS.this_cNComps       = TratarNulo(ncomps, "C")
			THIS.this_cDeptos       = TratarNulo(deptos, "C")
			THIS.this_cLibPess      = TratarNulo(libpess, "C")
			THIS.this_cLibProds     = TratarNulo(libprods, "C")
			THIS.this_cSetores      = TratarNulo(setores, "C")
			THIS.this_cCAtivos      = TratarNulo(cativos, "C")
			THIS.this_cMBiodigs     = TratarNulo(mbiodigs, "C")
			THIS.this_dTDtSenhas    = TratarNulo(tdtsenhas, {})
			THIS.this_cIClis        = TratarNulo(iclis, "C")
			THIS.this_nObrigSenhas  = TratarNulo(obrigsenhas, "N")
			THIS.this_cLibQtMins    = TratarNulo(libqtmins, "C")
			THIS.this_cFigJpgSUser  = TratarNulo(figjpgsuser, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdUsu
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdUsu" + ;
			           " (supervis, usuarios, senhas, ccargs, limdescs," + ;
			           " ncomps, deptos, libpess, libprods, setores," + ;
			           " cativos, mbiodigs, tdtsenhas, iclis, obrigsenhas," + ;
			           " libqtmins, figjpgsuser)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cSupervis) + "," + ;
			           EscaparSQL(THIS.this_cUsuarios) + "," + ;
			           EscaparSQL(THIS.this_cSenhas) + "," + ;
			           EscaparSQL(THIS.this_cCCargs) + "," + ;
			           EscaparSQL(THIS.this_cLimDescs) + "," + ;
			           EscaparSQL(THIS.this_cNComps) + "," + ;
			           EscaparSQL(THIS.this_cDeptos) + "," + ;
			           EscaparSQL(THIS.this_cLibPess) + "," + ;
			           EscaparSQL(THIS.this_cLibProds) + "," + ;
			           EscaparSQL(THIS.this_cSetores) + "," + ;
			           EscaparSQL(THIS.this_cCAtivos) + "," + ;
			           EscaparSQL(THIS.this_cMBiodigs) + "," + ;
			           FormatarDataSQL(THIS.this_dTDtSenhas) + "," + ;
			           EscaparSQL(THIS.this_cIClis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nObrigSenhas) + "," + ;
			           EscaparSQL(THIS.this_cLibQtMins) + "," + ;
			           EscaparSQL(THIS.this_cFigJpgSUser) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdUsu
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdUsu SET" + ;
			           " supervis = " + EscaparSQL(THIS.this_cSupervis) + "," + ;
			           " senhas = " + EscaparSQL(THIS.this_cSenhas) + "," + ;
			           " ccargs = " + EscaparSQL(THIS.this_cCCargs) + "," + ;
			           " limdescs = " + EscaparSQL(THIS.this_cLimDescs) + "," + ;
			           " ncomps = " + EscaparSQL(THIS.this_cNComps) + "," + ;
			           " deptos = " + EscaparSQL(THIS.this_cDeptos) + "," + ;
			           " libpess = " + EscaparSQL(THIS.this_cLibPess) + "," + ;
			           " libprods = " + EscaparSQL(THIS.this_cLibProds) + "," + ;
			           " setores = " + EscaparSQL(THIS.this_cSetores) + "," + ;
			           " cativos = " + EscaparSQL(THIS.this_cCAtivos) + "," + ;
			           " mbiodigs = " + EscaparSQL(THIS.this_cMBiodigs) + "," + ;
			           " tdtsenhas = " + FormatarDataSQL(THIS.this_dTDtSenhas) + "," + ;
			           " iclis = " + EscaparSQL(THIS.this_cIClis) + "," + ;
			           " obrigsenhas = " + FormatarNumeroSQL(THIS.this_nObrigSenhas) + "," + ;
			           " libqtmins = " + EscaparSQL(THIS.this_cLibQtMins) + "," + ;
			           " figjpgsuser = " + EscaparSQL(THIS.this_cFigJpgSUser) + ;
			           " WHERE RTRIM(usuarios) = " + EscaparSQL(ALLTRIM(THIS.this_cUsuarios))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE na tabela SigCdUsu
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdUsu WHERE RTRIM(usuarios) = " + ;
			           EscaparSQL(ALLTRIM(THIS.this_cUsuarios))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir usu" + CHR(225) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir usu" + CHR(225) + "rio:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

