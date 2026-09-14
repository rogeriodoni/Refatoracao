# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [FONTNAME-ERRADO] Linha 423: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 447: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormICM.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1351 linhas total):

*-- Linhas 28 a 36:
28:         LOCAL loc_lResultado
29:         loc_lResultado = .F.
30:         TRY
31:             THIS.Caption = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
32:             loc_lResultado = DODEFAULT()
33:         CATCH TO loc_oErro
34:             MsgErro(loc_oErro.Message + CHR(13) + ;
35:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.Init")
36:         ENDTRY

*-- Linhas 50 a 61:
50:             ELSE
51:                 *-- Estrutura PageFrame + Containers
52:                 THIS.ConfigurarPageFrame()
53:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
54:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
55:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
56:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
57: 
58:                 *-- Carregar lista inicial (pular se validando UI)
59:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
60:                     THIS.CarregarLista()
61:                 ENDIF

*-- Linhas 76 a 96:
76:     PROTECTED PROCEDURE ConfigurarPageFrame()
77:     *==========================================================================
78:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
79:         THIS.pgf_4c_Paginas.Top       = -29
80:         THIS.pgf_4c_Paginas.Left      = 0
81:         THIS.pgf_4c_Paginas.Width     = THIS.Width
82:         THIS.pgf_4c_Paginas.Height    = THIS.Height + 29
83:         THIS.pgf_4c_Paginas.PageCount = 2
84:         THIS.pgf_4c_Paginas.Tabs      = .F.
85:         THIS.pgf_4c_Paginas.Visible   = .T.
86: 
87:         WITH THIS.pgf_4c_Paginas
88:             .Page1.Caption    = "Lista"
89:             .Page1.BackColor  = RGB(100, 100, 100)
90:             .Page1.Picture    = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
91:             .Page2.Caption    = "Dados"
92:             .Page2.BackColor  = RGB(100, 100, 100)
93:             .Page2.Picture    = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
94:         ENDWITH
95: 
96:         THIS.ConfigurarPaginaLista()

*-- Linhas 109 a 146:
109:         *-- Cabecalho escuro com titulo (cntSombra no legado)
110:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
111:         WITH loc_oPagina.cnt_4c_Cabecalho
112:             .Top         = 31
113:             .Left        = 0
114:             .Width       = THIS.Width
115:             .Height      = 80
116:             .BackColor   = RGB(100, 100, 100)
117:             .BorderWidth = 0
118:             .Visible     = .T.
119:         ENDWITH
120: 
121:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
122:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
123:             .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
124:             .Top       = 15
125:             .Left      = 10
126:             .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
127:             .Height    = 40
128:             .FontName  = "Tahoma"
129:             .FontSize  = 16
130:             .FontBold  = .T.
131:             .ForeColor = RGB(0, 0, 0)
132:             .BackStyle = 0
133:             .AutoSize  = .F.
134:             .Visible   = .T.
135:         ENDWITH
136: 
137:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
138:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
139:             .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
140:             .Top       = 18
141:             .Left      = 10
142:             .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
143:             .Height    = 46
144:             .FontName  = "Tahoma"
145:             .FontSize  = 16
146:             .FontBold  = .T.

*-- Linhas 153 a 177:
153:         *-- Container botoes CRUD (Grupo_op no legado)
154:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
155:         WITH loc_oPagina.cnt_4c_Botoes
156:             .Top         = 29
157:             .Left        = 542
158:             .Width       = 390
159:             .Height      = 85
160:             .BackStyle = 0
161:             .BorderWidth = 0
162:             .Visible     = .T.
163:         ENDWITH
164: 
165:         *-- Incluir
166:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
167:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
168:             .Caption         = "Incluir"
169:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
170:             .PicturePosition = 13
171:             .Top = 5
172:             .Left = 5
173:             .Width = 75
174:             .Height = 75
175:             .BackColor   = RGB(255, 255, 255)
176:             .ForeColor   = RGB(90, 90, 90)
177:             .FontName    = "Tahoma"

*-- Linhas 184 a 201:
184:             .AutoSize    = .F.
185:             .MousePointer = 15
186:         ENDWITH
187:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
188: 
189:         *-- Visualizar
190:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
191:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
192:             .Caption         = "Visualizar"
193:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
194:             .PicturePosition = 13
195:             .Top = 5
196:             .Left = 80
197:             .Width = 75
198:             .Height = 75
199:             .BackColor   = RGB(255, 255, 255)
200:             .ForeColor   = RGB(90, 90, 90)
201:             .FontName    = "Tahoma"

*-- Linhas 208 a 225:
208:             .AutoSize    = .F.
209:             .MousePointer = 15
210:         ENDWITH
211:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
212: 
213:         *-- Alterar
214:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
215:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
216:             .Caption         = "Alterar"
217:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
218:             .PicturePosition = 13
219:             .Top = 5
220:             .Left = 155
221:             .Width = 75
222:             .Height = 75
223:             .BackColor   = RGB(255, 255, 255)
224:             .ForeColor   = RGB(90, 90, 90)
225:             .FontName    = "Tahoma"

*-- Linhas 232 a 249:
232:             .AutoSize    = .F.
233:             .MousePointer = 15
234:         ENDWITH
235:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
236: 
237:         *-- Excluir
238:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
239:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
240:             .Caption         = "Excluir"
241:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
242:             .PicturePosition = 13
243:             .Top = 5
244:             .Left = 230
245:             .Width = 75
246:             .Height = 75
247:             .BackColor   = RGB(255, 255, 255)
248:             .ForeColor   = RGB(90, 90, 90)
249:             .FontName    = "Tahoma"

*-- Linhas 256 a 273:
256:             .AutoSize    = .F.
257:             .MousePointer = 15
258:         ENDWITH
259:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
260: 
261:         *-- Buscar
262:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
263:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
264:             .Caption         = "Buscar"
265:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
266:             .PicturePosition = 13
267:             .Top = 5
268:             .Left = 305
269:             .Width = 75
270:             .Height = 75
271:             .BackColor   = RGB(255, 255, 255)
272:             .ForeColor   = RGB(90, 90, 90)
273:             .FontName    = "Tahoma"

*-- Linhas 280 a 308:
280:             .AutoSize    = .F.
281:             .MousePointer = 15
282:         ENDWITH
283:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
284: 
285:         *-- Container Encerrar (padrao canonico)
286:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
287:         WITH loc_oPagina.cnt_4c_Saida
288:             .Top         = 29
289:             .Left        = 917
290:             .Width       = 90
291:             .Height      = 85
292:             .BackStyle   = 0
293:             .BorderWidth = 0
294:             .Visible     = .T.
295:         ENDWITH
296: 
297:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
298:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
299:             .Caption         = "Encerrar"
300:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
301:             .PicturePosition = 13
302:             .Top = 5
303:             .Left = 5
304:             .Width = 75
305:             .Height = 75
306:             .BackColor   = RGB(255, 255, 255)
307:             .ForeColor   = RGB(90, 90, 90)
308:             .FontName    = "Tahoma"

*-- Linhas 315 a 329:
315:             .AutoSize    = .F.
316:             .MousePointer = 15
317:         ENDWITH
318:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
319: 
320:         *-- Grid de listagem (Grade no legado): Top=88+29, Left=12, Width=940
321:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
322:         loc_oGrid = loc_oPagina.grd_4c_Lista
323:         loc_oGrid.Top              = 117
324:         loc_oGrid.Left             = 12
325:         loc_oGrid.Width            = 940
326:         loc_oGrid.Height           = 470
327:         loc_oGrid.ColumnCount      = 9
328:         loc_oGrid.FontName         = "Verdana"
329:         loc_oGrid.FontSize         = 8

*-- Linhas 356 a 393:
356:         *-- Cabecalho escuro (igual Page1)
357:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
358:         WITH loc_oPagina.cnt_4c_Cabecalho
359:             .Top         = 31
360:             .Left        = 0
361:             .Width       = THIS.Width
362:             .Height      = 80
363:             .BackColor   = RGB(100, 100, 100)
364:             .BorderWidth = 0
365:             .Visible     = .T.
366:         ENDWITH
367: 
368:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
369:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
370:             .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
371:             .Top       = 15
372:             .Left      = 10
373:             .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
374:             .Height    = 40
375:             .FontName  = "Tahoma"
376:             .FontSize  = 16
377:             .FontBold  = .T.
378:             .ForeColor = RGB(0, 0, 0)
379:             .BackStyle = 0
380:             .AutoSize  = .F.
381:             .Visible   = .T.
382:         ENDWITH
383: 
384:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
385:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
386:             .Caption   = "Cadastro de " + CHR(205) + "ndices de Comiss" + CHR(227) + "o"
387:             .Top       = 18
388:             .Left      = 10
389:             .Width     = loc_oPagina.cnt_4c_Cabecalho.Width - 20
390:             .Height    = 46
391:             .FontName  = "Tahoma"
392:             .FontSize  = 16
393:             .FontBold  = .T.

*-- Linhas 400 a 473:
400:         *-- Container botoes Confirmar/Cancelar (Grupo_Salva no legado)
401:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
402:         WITH loc_oPagina.cnt_4c_BotoesAcao
403:             .Top         = 33   && 4 + 29
404:             .Left        = 842
405:             .Width       = 160
406:             .Height      = 85
407:             .BackStyle   = 0
408:             .Visible     = .T.
409:         ENDWITH
410: 
411:         *-- Confirmar (Salvar)
412:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
413:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
414:             .Caption         = "Confirmar"
415:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
416:             .PicturePosition = 13
417:             .Top             = 5
418:             .Left            = 5
419:             .Width           = 75
420:             .Height          = 75
421:             .BackColor       = RGB(255, 255, 255)
422:             .ForeColor       = RGB(90, 90, 90)
423:             .FontName        = "Comic Sans MS"
424:             .FontSize        = 8
425:             .FontBold        = .T.
426:             .FontItalic      = .T.
427:             .Themes          = .F.
428:             .SpecialEffect   = 0
429:             .WordWrap        = .T.
430:             .AutoSize        = .F.
431:             .MousePointer    = 15
432:         ENDWITH
433:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
434: 
435:         *-- Cancelar
436:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
437:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
438:             .Caption         = "Encerrar"
439:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
440:             .PicturePosition = 13
441:             .Top             = 5
442:             .Left            = 80
443:             .Width           = 75
444:             .Height          = 75
445:             .BackColor       = RGB(255, 255, 255)
446:             .ForeColor       = RGB(90, 90, 90)
447:             .FontName        = "Comic Sans MS"
448:             .FontSize        = 8
449:             .FontBold        = .T.
450:             .FontItalic      = .T.
451:             .Themes          = .F.
452:             .SpecialEffect   = 0
453:             .WordWrap        = .T.
454:             .AutoSize        = .F.
455:             .MousePointer    = 15
456:         ENDWITH
457:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
458: 
459:         *--------------------------------------------------------------------------
460:         *-- CAMPOS PARTE 1: Empresa, Tabela de Desconto, Cargo
461:         *--------------------------------------------------------------------------
462: 
463:         *-- [Empresa] Label
464:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
465:         WITH loc_oPagina.lbl_4c_Label3
466:             .Caption   = "Empresa :"
467:             .Top       = 206   && 177 + 29
468:             .Left      = 145
469:             .Width     = 60
470:             .Height    = 17
471:             .FontName  = "Tahoma"
472:             .FontSize  = 8
473:             .FontBold  = .F.

*-- Linhas 482 a 491:
482:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
483:         WITH loc_oPagina.txt_4c_Empresa
484:             .Value       = ""
485:             .Top         = 203   && 174 + 29
486:             .Left        = 207
487:             .Width       = 31
488:             .Height      = 20
489:             .FontName    = "Tahoma"
490:             .FontSize    = 8
491:             .MaxLength   = 3

*-- Linhas 499 a 508:
499:         loc_oPagina.AddObject("txt_4c_DEmpresa", "TextBox")
500:         WITH loc_oPagina.txt_4c_DEmpresa
501:             .Value       = ""
502:             .Top         = 203   && 174 + 29
503:             .Left        = 240
504:             .Width       = 290
505:             .Height      = 20
506:             .FontName    = "Tahoma"
507:             .FontSize    = 8
508:             .MaxLength   = 60

*-- Linhas 514 a 526:
514:         ENDWITH
515: 
516:         *-- [Tabela de Desconto] Label
517:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
518:         WITH loc_oPagina.lbl_4c_Label5
519:             .Caption   = "Tabela de Desconto :"
520:             .Top       = 231   && 202 + 29
521:             .Left      = 91
522:             .Width     = 115
523:             .Height    = 17
524:             .FontName  = "Tahoma"
525:             .FontSize  = 8
526:             .FontBold  = .F.

*-- Linhas 535 a 544:
535:         loc_oPagina.AddObject("txt_4c_TabDes", "TextBox")
536:         WITH loc_oPagina.txt_4c_TabDes
537:             .Value       = ""
538:             .Top         = 228   && 199 + 29
539:             .Left        = 207
540:             .Width       = 80
541:             .Height      = 20
542:             .FontName    = "Tahoma"
543:             .FontSize    = 8
544:             .MaxLength   = 10

*-- Linhas 552 a 561:
552:         loc_oPagina.AddObject("txt_4c_DTabDes", "TextBox")
553:         WITH loc_oPagina.txt_4c_DTabDes
554:             .Value       = ""
555:             .Top         = 228   && 199 + 29
556:             .Left        = 289
557:             .Width       = 220
558:             .Height      = 20
559:             .FontName    = "Tahoma"
560:             .FontSize    = 8
561:             .MaxLength   = 40

*-- Linhas 567 a 579:
567:         ENDWITH
568: 
569:         *-- [Cargo] Label
570:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
571:         WITH loc_oPagina.lbl_4c_Label4
572:             .Caption   = "Cargo :"
573:             .Top       = 256   && 227 + 29
574:             .Left      = 157
575:             .Width     = 49
576:             .Height    = 17
577:             .FontName  = "Tahoma"
578:             .FontSize  = 8
579:             .FontBold  = .F.

*-- Linhas 588 a 597:
588:         loc_oPagina.AddObject("txt_4c_Cargo", "TextBox")
589:         WITH loc_oPagina.txt_4c_Cargo
590:             .Value       = ""
591:             .Top         = 253   && 224 + 29
592:             .Left        = 207
593:             .Width       = 80
594:             .Height      = 20
595:             .FontName    = "Tahoma"
596:             .FontSize    = 8
597:             .MaxLength   = 10

*-- Linhas 605 a 614:
605:         loc_oPagina.AddObject("txt_4c_DCargo", "TextBox")
606:         WITH loc_oPagina.txt_4c_DCargo
607:             .Value       = ""
608:             .Top         = 253   && 224 + 29
609:             .Left        = 289
610:             .Width       = 150
611:             .Height      = 20
612:             .FontName    = "Tahoma"
613:             .FontSize    = 8
614:             .MaxLength   = 40

*-- Linhas 620 a 632:
620:         ENDWITH
621: 
622:         *-- [Condição] Label
623:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
624:         WITH loc_oPagina.lbl_4c_Label7
625:             .Caption   = "Condi" + CHR(231) + CHR(227) + "o :"
626:             .Top       = 281   && 252 + 29
627:             .Left      = 142
628:             .Width     = 64
629:             .Height    = 17
630:             .FontName  = "Tahoma"
631:             .FontSize  = 8
632:             .FontBold  = .F.

*-- Linhas 641 a 667:
641:         loc_oPagina.AddObject("txt_4c_FPags", "TextBox")
642:         WITH loc_oPagina.txt_4c_FPags
643:             .Value       = ""
644:             .Top         = 278   && 249 + 29
645:             .Left        = 207
646:             .Width       = 94
647:             .Height      = 20
648:             .FontName    = "Tahoma"
649:             .FontSize    = 8
650:             .MaxLength   = 12
651:             .BackColor   = RGB(255, 255, 255)
652:             .ForeColor   = RGB(0, 0, 0)
653:             .Alignment   = 0
654:             .Visible     = .T.
655:         ENDWITH
656: 
657:         *-- [Comissão] Label
658:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
659:         WITH loc_oPagina.lbl_4c_Label6
660:             .Caption   = "Comiss" + CHR(227) + "o :"
661:             .Top       = 318   && 289 + 29
662:             .Left      = 141
663:             .Width     = 65
664:             .Height    = 17
665:             .FontName  = "Tahoma"
666:             .FontSize  = 8
667:             .FontBold  = .F.

*-- Linhas 673 a 685:
673:         ENDWITH
674: 
675:         *-- [Período] Label
676:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
677:         WITH loc_oPagina.lbl_4c_Label1
678:             .Caption   = "Per" + CHR(237) + "odo :"
679:             .Top       = 318   && 289 + 29
680:             .Left      = 285
681:             .Width     = 55
682:             .Height    = 17
683:             .FontName  = "Tahoma"
684:             .FontSize  = 8
685:             .FontBold  = .F.

*-- Linhas 691 a 703:
691:         ENDWITH
692: 
693:         *-- [à] Separador periodo
694:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
695:         WITH loc_oPagina.lbl_4c_Label2
696:             .Caption   = CHR(224)
697:             .Top       = 318   && 289 + 29
698:             .Left      = 430
699:             .Width     = 15
700:             .Height    = 17
701:             .FontName  = "Tahoma"
702:             .FontSize  = 8
703:             .FontBold  = .F.

*-- Linhas 712 a 721:
712:         loc_oPagina.AddObject("txt_4c_Comiss", "TextBox")
713:         WITH loc_oPagina.txt_4c_Comiss
714:             .Value       = 0
715:             .Top         = 315   && 286 + 29
716:             .Left        = 207
717:             .Width       = 45
718:             .Height      = 20
719:             .FontName    = "Tahoma"
720:             .FontSize    = 8
721:             .InputMask   = "99.99"

*-- Linhas 729 a 738:
729:         loc_oPagina.AddObject("txt_4c_DtIni", "TextBox")
730:         WITH loc_oPagina.txt_4c_DtIni
731:             .Value       = {}
732:             .Top         = 315   && 286 + 29
733:             .Left        = 340
734:             .Width       = 80
735:             .Height      = 20
736:             .FontName    = "Tahoma"
737:             .FontSize    = 8
738:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 745 a 754:
745:         loc_oPagina.AddObject("txt_4c_DtFin", "TextBox")
746:         WITH loc_oPagina.txt_4c_DtFin
747:             .Value       = {}
748:             .Top         = 315   && 286 + 29
749:             .Left        = 450
750:             .Width       = 80
751:             .Height      = 20
752:             .FontName    = "Tahoma"
753:             .FontSize    = 8
754:             .BackColor   = RGB(255, 255, 255)

*-- Linhas 802 a 818:
802:                     loc_oGrid.Column8.Width      = 80
803:                     loc_oGrid.Column9.Width      = 55
804:                     loc_oGrid.Column9.Alignment  = 2
805:                     loc_oGrid.Column1.Header1.Caption = "Emp"
806:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
807:                     loc_oGrid.Column3.Header1.Caption = "Tb.Desconto"
808:                     loc_oGrid.Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o Tabela"
809:                     loc_oGrid.Column5.Header1.Caption = "Cargo"
810:                     loc_oGrid.Column6.Header1.Caption = "Condi" + CHR(231) + CHR(227) + "o"
811:                     loc_oGrid.Column7.Header1.Caption = "Data Inicial"
812:                     loc_oGrid.Column8.Header1.Caption = "Data Final"
813:                     loc_oGrid.Column9.Header1.Caption = "Comiss.%"
814:                     THIS.FormatarGridLista(loc_oGrid)
815:                     loc_oGrid.Refresh()
816:                     loc_lResultado = .T.
817:                 ENDIF
818:             ENDIF

*-- Linhas 1072 a 1080:
1072:         loc_oPg2.txt_4c_DCargo.ReadOnly   = .T.
1073: 
1074:         *-- Botao Confirmar: habilitado somente em INCLUIR/ALTERAR
1075:         loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1076:     ENDPROC
1077: 
1078:     *==========================================================================
1079:     PROTECTED PROCEDURE BOParaForm()
1080:     *==========================================================================

*-- Linhas 1327 a 1340:
1327:         TRY
1328:             loc_oPg1     = THIS.pgf_4c_Paginas.Page1
1329:             loc_lEmLista = (THIS.this_cModoAtual = "LISTA")
1330:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = loc_lEmLista
1331:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = loc_lEmLista
1332:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = loc_lEmLista
1333:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = loc_lEmLista
1334:             loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = loc_lEmLista
1335:             loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = loc_lEmLista
1336:         CATCH TO loc_oErro
1337:             MsgErro(loc_oErro.Message + CHR(13) + ;
1338:                     "Linha: " + TRANSFORM(loc_oErro.LineNo), "FormICM.AjustarBotoesPorModo")
1339:         ENDTRY
1340:     ENDPROC


### BO (C:\4c\projeto\app\classes\ICMBO.prg):
*==============================================================================
* ICMBO.prg - Business Object: Cadastro de Indices de Comissao
* Tabela: SigCdCmi
* PK: cidchaves (char 20, gerado via fUniqueIds)
*==============================================================================

DEFINE CLASS ICMBO AS BusinessBase

    *-- Campos da tabela SigCdCmi
    this_cEmps      = ""    && char(3)  - Empresa
    this_cCargos    = ""    && char(10) - Cargo
    this_cFPags     = ""    && char(12) - Condicao de Pagamento
    this_cTabDes    = ""    && char(10) - Tabela de Desconto
    this_dDtInis    = {}    && datetime - Data Inicial do Periodo
    this_dDtFins    = {}    && datetime - Data Final do Periodo
    this_nComiss    = 0     && numeric(4,2) - Percentual de Comissao
    this_cIdChaves  = ""    && char(20) - Chave unica (PK, gerado por fUniqueIds)
    this_tDtAlts    = {}    && datetime - Data/hora ultima alteracao

    *-- Campos descricao (lookup, nao armazenados no banco)
    this_cDEmpresa  = ""    && Razao social da empresa (SigCdEmp.Razas)
    this_cDCargo    = ""    && Descricao do cargo (SigCdCrg.DCargs)
    this_cDTabDes   = ""    && Descricao da tabela de desconto (SigOpTdz.Descrs)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCmi"
            THIS.this_cCampoChave = "cidchaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "ICMBO.Init")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
    *--------------------------------------------------------------------------
        RETURN THIS.this_cIdChaves
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cWhere = ""
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE " + par_cFiltro
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.emps, a.tabdes, a.cargos, a.fpags," + ;
                       " a.dtinis, a.dtfins, a.comiss, a.dtalts," + ;
                       " ISNULL(b.razas, '') AS razas," + ;
                       " ISNULL(c.dcargs, '') AS dcargs," + ;
                       " ISNULL(d.descrs, '') AS descrs_tabdes" + ;
                       " FROM SigCdCmi a" + ;
                       " LEFT JOIN SigCdEmp b ON b.cemps = a.cemps" + ;
                       " LEFT JOIN SigCdCrg c ON c.ccargs = a.cargos" + ;
                       " LEFT JOIN SigOpTdz d ON d.codigos = a.tabdes" + ;
                       loc_cWhere + ;
                       " ORDER BY a.emps, a.tabdes, a.cargos, a.fpags"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult > 0
                GO TOP IN cursor_4c_Dados
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar " + CHR(237) + "ndices de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Buscar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cIdChaves)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.tabdes, a.cargos, a.fpags," + ;
                       " a.dtinis, a.dtfins, a.comiss, a.dtalts," + ;
                       " ISNULL(b.razas, '') AS razas," + ;
                       " ISNULL(c.dcargs, '') AS dcargs," + ;
                       " ISNULL(d.descrs, '') AS descrs_tabdes" + ;
                       " FROM SigCdCmi a" + ;
                       " LEFT JOIN SigCdEmp b ON b.cemps = a.cemps" + ;
                       " LEFT JOIN SigCdCrg c ON c.ccargs = a.cargos" + ;
                       " LEFT JOIN SigOpTdz d ON d.codigos = a.tabdes" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cIdChaves))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                GO TOP IN cursor_4c_Carrega
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "ICMBO.CarregarPorCodigo")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.CarregarPorCodigo")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = ALLTRIM(TratarNulo(cidchaves,  "C"))
            THIS.this_cEmps      = ALLTRIM(TratarNulo(emps,       "C"))
            THIS.this_cTabDes    = ALLTRIM(TratarNulo(tabdes,     "C"))
            THIS.this_cCargos    = ALLTRIM(TratarNulo(cargos,     "C"))
            THIS.this_cFPags     = ALLTRIM(TratarNulo(fpags,      "C"))
            THIS.this_dDtInis    = TratarNulo(dtinis, "D")
            THIS.this_dDtFins    = TratarNulo(dtfins, "D")
            THIS.this_nComiss    = TratarNulo(comiss, "N")
            THIS.this_tDtAlts    = TratarNulo(dtalts, "D")
            IF TYPE(par_cAliasCursor + ".razas") != "U"
                THIS.this_cDEmpresa = ALLTRIM(TratarNulo(razas,         "C"))
                THIS.this_cDCargo   = ALLTRIM(TratarNulo(dcargs,        "C"))
                THIS.this_cDTabDes  = ALLTRIM(TratarNulo(descrs_tabdes, "C"))
            ENDIF
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cId
        LOCAL loc_nResultDup, loc_cSQLDup, loc_lDuplicado
        loc_lResultado = .F.
        loc_lDuplicado = .F.

        TRY
            *-- Verificar duplicidade (Emps+Cargos+FPags+TabDes+DtInis+DtFins)
            loc_cSQLDup = "SELECT cidchaves FROM SigCdCmi" + ;
                          " WHERE emps = "   + EscaparSQL(THIS.this_cEmps)   + ;
                          " AND cargos = "   + EscaparSQL(THIS.this_cCargos) + ;
                          " AND fpags = "    + EscaparSQL(THIS.this_cFPags)  + ;
                          " AND tabdes = "   + EscaparSQL(THIS.this_cTabDes) + ;
                          " AND dtinis = "   + FormatarDataSQL(THIS.this_dDtInis) + ;
                          " AND dtfins = "   + FormatarDataSQL(THIS.this_dDtFins)

            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF
            loc_nResultDup = SQLEXEC(gnConnHandle, loc_cSQLDup, "cursor_4c_DupVerif")
            IF loc_nResultDup > 0 AND RECCOUNT("cursor_4c_DupVerif") > 0
                loc_lDuplicado = .T.
                MsgAviso("Dados j" + CHR(225) + " cadastrados para esta combina" + CHR(231) + CHR(227) + "o!", "")
            ENDIF
            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF

            IF !loc_lDuplicado
                *-- Gerar chave unica
                loc_cId = fUniqueIds()
                THIS.this_cIdChaves = loc_cId

                loc_cSQL = "INSERT INTO SigCdCmi (cidchaves, emps, tabdes, cargos, fpags," + ;
                           " dtinis, dtfins, comiss, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(loc_cId) + ", " + ;
                           EscaparSQL(THIS.this_cEmps)   + ", " + ;
                           EscaparSQL(THIS.this_cTabDes)  + ", " + ;
                           EscaparSQL(THIS.this_cCargos)  + ", " + ;
                           EscaparSQL(THIS.this_cFPags)   + ", " + ;
                           FormatarDataSQL(THIS.this_dDtInis) + ", " + ;
                           FormatarDataSQL(THIS.this_dDtFins) + ", " + ;
                           FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                           "GETDATE())"

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Ins")
                    TABLEREVERT(.T., "cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
                IF loc_nResult > 0
                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    IF USED("cursor_4c_Ins")
                        USE IN cursor_4c_Ins
                    ENDIF
                    MsgErro("Erro ao inserir " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_DupVerif")
                USE IN cursor_4c_DupVerif
            ENDIF
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Inserir")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdCmi SET" + ;
                       " emps = "   + EscaparSQL(THIS.this_cEmps)   + ", " + ;
                       " tabdes = " + EscaparSQL(THIS.this_cTabDes)  + ", " + ;
                       " cargos = " + EscaparSQL(THIS.this_cCargos)  + ", " + ;
                       " fpags = "  + EscaparSQL(THIS.this_cFPags)   + ", " + ;
                       " dtinis = " + FormatarDataSQL(THIS.this_dDtInis) + ", " + ;
                       " dtfins = " + FormatarDataSQL(THIS.this_dDtFins) + ", " + ;
                       " comiss = " + FormatarNumeroSQL(THIS.this_nComiss) + ", " + ;
                       " dtalts = GETDATE()" + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Upd")
                TABLEREVERT(.T., "cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult > 0
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                MsgErro("Erro ao atualizar " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.Atualizar")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
    *--------------------------------------------------------------------------
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdCmi WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cIdChaves)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Del")
                TABLEREVERT(.T., "cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF loc_nResult > 0
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                IF USED("cursor_4c_Del")
                    USE IN cursor_4c_Del
                ENDIF
                MsgErro("Erro ao excluir " + CHR(237) + "ndice de comiss" + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
            MsgErro(loc_oErro.Message + CHR(13) + "Linha: " + TRANSFORM(loc_oErro.LineNo), "ICMBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

