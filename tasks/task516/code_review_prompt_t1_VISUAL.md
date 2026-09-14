# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 184: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 209: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 234: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 259: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 284: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 322: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 426: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 449: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formrst.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2020 linhas total):

*-- Linhas 47 a 56:
47:                     "Formrst.InicializarForm")
48:             ELSE
49:                 THIS.ConfigurarPageFrame()
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Visible   = .T.
53:                 THIS.pgf_4c_Paginas.ActivePage = 1
54:                 THIS.this_cModoAtual = "LISTA"
55: 
56:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI

*-- Linhas 72 a 99:
72: 
73:     *===========================================================================
74:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
75:     * PageFrame.Top = -29 para esconder abas
76:     * Todos os controles internos compensam +29 no Top
77:     *===========================================================================
78:     PROTECTED PROCEDURE ConfigurarPageFrame()
79:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
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

*-- Linhas 115 a 152:
115:         *-- Top original=2; compensacao PageFrame +29 -> Top=31
116:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
117:         WITH loc_oPagina.cnt_4c_Cabecalho
118:             .Top         = 31
119:             .Left        = 0
120:             .Width       = THIS.Width
121:             .Height      = 80
122:             .BackColor   = RGB(100, 100, 100)
123:             .BorderWidth = 0
124:             .Visible     = .T.
125:         ENDWITH
126: 
127:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
128:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
129:             .Caption   = THIS.Caption
130:             .Top       = 15
131:             .Left      = 10
132:             .Width     = 769
133:             .Height    = 40
134:             .FontName  = "Tahoma"
135:             .FontSize  = 16
136:             .FontBold  = .T.
137:             .ForeColor = RGB(0, 0, 0)
138:             .BackStyle = 0
139:             .AutoSize  = .F.
140:             .Visible   = .T.
141:         ENDWITH
142: 
143:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
145:             .Caption   = THIS.Caption
146:             .Top       = 18
147:             .Left      = 10
148:             .Width     = 769
149:             .Height    = 46
150:             .FontName  = "Tahoma"
151:             .FontSize  = 16
152:             .FontBold  = .T.

*-- Linhas 160 a 350:
160:         *-- Canonico: Left=542, Top=29 (0+29 compensacao), Width=390, Height=85
161:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
162:         WITH loc_oPagina.cnt_4c_Botoes
163:             .Top         = 29
164:             .Left        = 542
165:             .Width       = 390
166:             .Height      = 85
167:             .BackStyle   = 0
168:             .BorderWidth = 0
169:             .Visible     = .T.
170:         ENDWITH
171: 
172:         *-- Botao Incluir
173:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
174:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
175:             .Caption         = "Incluir"
176:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
177:             .PicturePosition = 13
178:             .Top             = 5
179:             .Left            = 5
180:             .Width           = 75
181:             .Height          = 75
182:             .BackColor       = RGB(255, 255, 255)
183:             .ForeColor       = RGB(90, 90, 90)
184:             .FontName        = "Comic Sans MS"
185:             .FontBold        = .T.
186:             .FontItalic      = .T.
187:             .FontSize        = 8
188:             .Themes          = .F.
189:             .SpecialEffect   = 0
190:             .MousePointer    = 15
191:             .WordWrap        = .T.
192:             .AutoSize        = .F.
193:             .Visible         = .T.
194:         ENDWITH
195:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
196: 
197:         *-- Botao Visualizar
198:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .BackColor       = RGB(255, 255, 255)
208:             .ForeColor       = RGB(90, 90, 90)
209:             .FontName        = "Comic Sans MS"
210:             .FontBold        = .T.
211:             .FontItalic      = .T.
212:             .FontSize        = 8
213:             .Themes          = .F.
214:             .SpecialEffect   = 0
215:             .MousePointer    = 15
216:             .WordWrap        = .T.
217:             .AutoSize        = .F.
218:             .Visible         = .T.
219:         ENDWITH
220:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
221: 
222:         *-- Botao Alterar
223:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
224:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
225:             .Caption         = "Alterar"
226:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
227:             .PicturePosition = 13
228:             .Top             = 5
229:             .Left            = 155
230:             .Width           = 75
231:             .Height          = 75
232:             .BackColor       = RGB(255, 255, 255)
233:             .ForeColor       = RGB(90, 90, 90)
234:             .FontName        = "Comic Sans MS"
235:             .FontBold        = .T.
236:             .FontItalic      = .T.
237:             .FontSize        = 8
238:             .Themes          = .F.
239:             .SpecialEffect   = 0
240:             .MousePointer    = 15
241:             .WordWrap        = .T.
242:             .AutoSize        = .F.
243:             .Visible         = .T.
244:         ENDWITH
245:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
246: 
247:         *-- Botao Excluir
248:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
249:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
250:             .Caption         = "Excluir"
251:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
252:             .PicturePosition = 13
253:             .Top             = 5
254:             .Left            = 230
255:             .Width           = 75
256:             .Height          = 75
257:             .BackColor       = RGB(255, 255, 255)
258:             .ForeColor       = RGB(90, 90, 90)
259:             .FontName        = "Comic Sans MS"
260:             .FontBold        = .T.
261:             .FontItalic      = .T.
262:             .FontSize        = 8
263:             .Themes          = .F.
264:             .SpecialEffect   = 0
265:             .MousePointer    = 15
266:             .WordWrap        = .T.
267:             .AutoSize        = .F.
268:             .Visible         = .T.
269:         ENDWITH
270:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
271: 
272:         *-- Botao Buscar
273:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
274:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
275:             .Caption         = "Buscar"
276:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
277:             .PicturePosition = 13
278:             .Top             = 5
279:             .Left            = 305
280:             .Width           = 75
281:             .Height          = 75
282:             .BackColor       = RGB(255, 255, 255)
283:             .ForeColor       = RGB(90, 90, 90)
284:             .FontName        = "Comic Sans MS"
285:             .FontBold        = .T.
286:             .FontItalic      = .T.
287:             .FontSize        = 8
288:             .Themes          = .F.
289:             .SpecialEffect   = 0
290:             .MousePointer    = 15
291:             .WordWrap        = .T.
292:             .AutoSize        = .F.
293:             .Visible         = .T.
294:         ENDWITH
295:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
296: 
297:         *-- Container Saida (Grupo_Saida - padrao canonico: Left=917, Width=90)
298:         *-- Transparente sobre a Page - NAO subtrair da largura do cabecalho/grade
299:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
300:         WITH loc_oPagina.cnt_4c_Saida
301:             .Top         = 29
302:             .Left        = 917
303:             .Width       = 90
304:             .Height      = 85
305:             .BackStyle   = 0
306:             .BorderWidth = 0
307:             .Visible     = .T.
308:         ENDWITH
309: 
310:         *-- Botao Encerrar
311:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
312:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
313:             .Caption         = "Encerrar"
314:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
315:             .PicturePosition = 13
316:             .Top             = 5
317:             .Left            = 5
318:             .Width           = 75
319:             .Height          = 75
320:             .BackColor       = RGB(255, 255, 255)
321:             .ForeColor       = RGB(90, 90, 90)
322:             .FontName        = "Comic Sans MS"
323:             .FontBold        = .T.
324:             .FontItalic      = .T.
325:             .FontSize        = 8
326:             .Themes          = .F.
327:             .SpecialEffect   = 0
328:             .MousePointer    = 15
329:             .WordWrap        = .T.
330:             .AutoSize        = .F.
331:             .Visible         = .T.
332:         ENDWITH
333:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
334: 
335:         *-- Grid grd_4c_Lista - exibe SigCdRst + SigCdCli
336:         *-- Top=88+29=117 (compensacao PageFrame); Width=890; Height=483
337:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
338:         loc_oGrid = loc_oPagina.grd_4c_Lista
339: 
340:         loc_oGrid.RecordSource  = ""
341:         loc_oGrid.ColumnCount   = 3
342: 
343:         WITH loc_oGrid
344:             .Top                = 117
345:             .Left               = 26
346:             .Width              = 890
347:             .Height             = 483
348:             .DeleteMark         = .F.
349:             .RecordMark         = .F.
350:             .RowHeight          = 16

*-- Linhas 364 a 384:
364:         WITH loc_oGrid.Column1
365:             .Width              = 100
366:             .Resizable          = .T.
367:             .Header1.Caption    = "Conta"
368:         ENDWITH
369: 
370:         WITH loc_oGrid.Column2
371:             .Width              = 450
372:             .Resizable          = .T.
373:             .Header1.Caption    = "Nome"
374:         ENDWITH
375: 
376:         WITH loc_oGrid.Column3
377:             .Width              = 80
378:             .Resizable          = .T.
379:             .Header1.Caption    = "Data"
380:         ENDWITH
381: 
382:         BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")
383: 
384:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 403 a 455:
403:         *-- ===================================================================
404:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
405:         WITH loc_oPagina.cnt_4c_Salva
406:             .Top         = 33
407:             .Left        = 842
408:             .Width       = 160
409:             .Height      = 85
410:             .BackStyle   = 0
411:             .BorderWidth = 0
412:             .Visible     = .T.
413:         ENDWITH
414: 
415:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Confirmar", "CommandButton")
416:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar
417:             .Caption         = "Confirmar"
418:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
419:             .PicturePosition = 13
420:             .Top             = 5
421:             .Left            = 5
422:             .Width           = 75
423:             .Height          = 75
424:             .BackColor       = RGB(255, 255, 255)
425:             .ForeColor       = RGB(90, 90, 90)
426:             .FontName        = "Comic Sans MS"
427:             .FontBold        = .T.
428:             .FontItalic      = .T.
429:             .FontSize        = 8
430:             .Themes          = .F.
431:             .SpecialEffect   = 0
432:             .MousePointer    = 15
433:             .WordWrap        = .T.
434:             .AutoSize        = .F.
435:             .Visible         = .T.
436:         ENDWITH
437: 
438:         loc_oPagina.cnt_4c_Salva.AddObject("cmd_4c_Cancelar", "CommandButton")
439:         WITH loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar
440:             .Caption         = "Encerrar"
441:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
442:             .PicturePosition = 13
443:             .Top             = 5
444:             .Left            = 80
445:             .Width           = 75
446:             .Height          = 75
447:             .BackColor       = RGB(255, 255, 255)
448:             .ForeColor       = RGB(90, 90, 90)
449:             .FontName        = "Comic Sans MS"
450:             .FontBold        = .T.
451:             .FontItalic      = .T.
452:             .FontSize        = 8
453:             .Themes          = .F.
454:             .SpecialEffect   = 0
455:             .MousePointer    = 15

*-- Linhas 461 a 473:
461:         *-- ===================================================================
462:         *-- Say2: "Conta :" - Top=51+29=80, Left=82
463:         *-- ===================================================================
464:         loc_oPagina.AddObject("lbl_4c_Conta", "Label")
465:         WITH loc_oPagina.lbl_4c_Conta
466:             .Caption   = "Conta :"
467:             .Top       = 80
468:             .Left      = 82
469:             .Width     = 55
470:             .Height    = 17
471:             .FontName  = "Tahoma"
472:             .FontSize  = 8
473:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 482 a 491:
482:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
483:         WITH loc_oPagina.txt_4c_Codigo
484:             .Value       = ""
485:             .Top         = 76
486:             .Left        = 129
487:             .Width       = 80
488:             .Height      = 25
489:             .MaxLength   = 10
490:             .FontName    = "Tahoma"
491:             .FontSize    = 8

*-- Linhas 501 a 510:
501:         loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
502:         WITH loc_oPagina.txt_4c_Desc
503:             .Value       = ""
504:             .Top         = 76
505:             .Left        = 212
506:             .Width       = 290
507:             .Height      = 25
508:             .MaxLength   = 40
509:             .FontName    = "Tahoma"
510:             .FontSize    = 8

*-- Linhas 518 a 530:
518:         *-- ===================================================================
519:         *-- Say11: "Checa Matriz :" - Top=79+29=108, Left=42, Width=71
520:         *-- ===================================================================
521:         loc_oPagina.AddObject("lbl_4c_ChkMatrix", "Label")
522:         WITH loc_oPagina.lbl_4c_ChkMatrix
523:             .Caption   = "Checa Matriz :"
524:             .Top       = 108
525:             .Left      = 42
526:             .Width     = 80
527:             .Height    = 17
528:             .FontName  = "Tahoma"
529:             .FontSize  = 8
530:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 540 a 573:
540:         loc_oPagina.AddObject("opt_4c_ChkMatrix", "OptionGroup")
541:         WITH loc_oPagina.opt_4c_ChkMatrix
542:             .ButtonCount = 2
543:             .Top         = 106
544:             .Left        = 124
545:             .Width       = 103
546:             .Height      = 22
547:             .BackStyle   = 0
548:             .BorderStyle = 0
549:             .Value       = 2
550:             .Visible     = .T.
551:         ENDWITH
552:         WITH loc_oPagina.opt_4c_ChkMatrix.Buttons(1)
553:             .Caption   = "Sim"
554:             .BackStyle = 0
555:             .Left      = 5
556:             .Top       = 3
557:             .Width     = 42
558:             .AutoSize  = .T.
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:             .ForeColor = RGB(90, 90, 90)
562:             .Themes    = .F.
563:         ENDWITH
564:         WITH loc_oPagina.opt_4c_ChkMatrix.Buttons(2)
565:             .Caption   = "N" + CHR(227) + "o"
566:             .BackStyle = 0
567:             .Left      = 50
568:             .Top       = 3
569:             .Width     = 43
570:             .AutoSize  = .T.
571:             .FontName  = "Tahoma"
572:             .FontSize  = 8
573:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 580 a 619:
580:         *-- ===================================================================
581:         loc_oPagina.AddObject("shp_4c_Shape4", "Shape")
582:         WITH loc_oPagina.shp_4c_Shape4
583:             .Top         = 39
584:             .Left        = 648
585:             .Width       = 163
586:             .Height      = 111
587:             .BorderStyle = 1
588:             .BorderColor = RGB(128, 128, 128)
589:             .BackStyle   = 0
590:             .Visible     = .T.
591:         ENDWITH
592: 
593:         *-- imgProds: img_4c_ImgProds - Top=12+29=41, Left=650, Width=159, Height=107
594:         *-- Inicia OCULTA - exibida somente quando produto da grade tem imagem
595:         loc_oPagina.AddObject("img_4c_ImgProds", "Image")
596:         WITH loc_oPagina.img_4c_ImgProds
597:             .Top     = 41
598:             .Left    = 650
599:             .Width   = 159
600:             .Height  = 107
601:             .Stretch = 2
602:             .Visible = .F.
603:         ENDWITH
604:         BINDEVENT(loc_oPagina.img_4c_ImgProds, "Click", THIS, "ImgProdsClick")
605: 
606:         *-- ===================================================================
607:         *-- Say3: "Municípios pertencentes a esta restrição:"
608:         *-- Top=116+29=145, Left=44, Width=199, Height=15
609:         *-- ===================================================================
610:         loc_oPagina.AddObject("lbl_4c_TituloMunis", "Label")
611:         WITH loc_oPagina.lbl_4c_TituloMunis
612:             .Caption   = "Munic" + CHR(237) + "pios pertencentes a esta restri" + CHR(231) + CHR(227) + "o:"
613:             .Top       = 145
614:             .Left      = 44
615:             .Width     = 199
616:             .Height    = 15
617:             .FontName  = "Tahoma"
618:             .FontSize  = 8
619:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 626 a 638:
626:         *-- Say4: "Produtos restringidos:"
627:         *-- Top=116+29=145, Left=418, Width=108, Height=15
628:         *-- ===================================================================
629:         loc_oPagina.AddObject("lbl_4c_TituloProds", "Label")
630:         WITH loc_oPagina.lbl_4c_TituloProds
631:             .Caption   = "Produtos restringidos:"
632:             .Top       = 145
633:             .Left      = 418
634:             .Width     = 108
635:             .Height    = 15
636:             .FontName  = "Tahoma"
637:             .FontSize  = 8
638:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 662 a 729:
662:         ENDIF
663: 
664:         *-- ===================================================================
665:         *-- cmd_4c_InserirMuni - Inserir linha no GradMuni (inserir do legado)
666:         *-- Top=305+29=334, Left=356, Width=45, Height=45
667:         *-- ===================================================================
668:         loc_oPagina.AddObject("cmd_4c_InserirMuni", "CommandButton")
669:         WITH loc_oPagina.cmd_4c_InserirMuni
670:             .Caption         = ""
671:             .ToolTipText     = "Inserir Munic" + CHR(237) + "pio"
672:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
673:             .PicturePosition = 0
674:             .Top             = 334
675:             .Left            = 356
676:             .Width           = 45
677:             .Height          = 45
678:             .FontBold        = .T.
679:             .FontName        = "Verdana"
680:             .FontSize        = 8
681:             .ForeColor       = RGB(36, 84, 155)
682:             .BackColor       = RGB(255, 255, 255)
683:             .Themes          = .F.
684:             .SpecialEffect   = 0
685:             .Visible         = .T.
686:         ENDWITH
687:         BINDEVENT(loc_oPagina.cmd_4c_InserirMuni, "Click", THIS, "BtnInserirMuniClick")
688: 
689:         *-- cmd_4c_ExcluirMuni - Excluir linha do GradMuni (excluir do legado)
690:         *-- Top=350+29=379, Left=356, Width=45, Height=45
691:         loc_oPagina.AddObject("cmd_4c_ExcluirMuni", "CommandButton")
692:         WITH loc_oPagina.cmd_4c_ExcluirMuni
693:             .Caption         = ""
694:             .ToolTipText     = "Excluir Munic" + CHR(237) + "pio"
695:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
696:             .PicturePosition = 0
697:             .Top             = 379
698:             .Left            = 356
699:             .Width           = 45
700:             .Height          = 45
701:             .FontBold        = .T.
702:             .FontName        = "Verdana"
703:             .FontSize        = 8
704:             .ForeColor       = RGB(36, 84, 155)
705:             .BackColor       = RGB(255, 255, 255)
706:             .Themes          = .F.
707:             .SpecialEffect   = 0
708:             .Visible         = .T.
709:         ENDWITH
710:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirMuni, "Click", THIS, "BtnExcluirMuniClick")
711: 
712:         *-- ===================================================================
713:         *-- grd_4c_Munis (GradMuni) - Grade de Municipios
714:         *-- Top=133+29=162, Left=41, Width=309, Height=456
715:         *-- Col1=UF(24), Col2=Municipio(263)
716:         *-- ===================================================================
717:         loc_oPagina.AddObject("grd_4c_Munis", "Grid")
718:         loc_oPagina.grd_4c_Munis.ColumnCount = 3
719:         loc_oPagina.grd_4c_Munis.RecordSource = "cursor_4c_Munis"
720:         loc_oPagina.grd_4c_Munis.ColumnCount  = 2
721: 
722:         WITH loc_oPagina.grd_4c_Munis
723:             .Top                = 162
724:             .Left               = 41
725:             .Width              = 309
726:             .Height             = 456
727:             .DeleteMark         = .F.
728:             .RecordMark         = .F.
729:             .RowHeight          = 16

*-- Linhas 745 a 828:
745:             .Column1.FontName          = "Tahoma"
746:             .Column1.FontSize          = 8
747:             .Column1.Resizable         = .T.
748:             .Column1.Header1.Caption   = "UF"
749:             .Column1.Header1.Alignment = 2
750: 
751:             .Column2.ControlSource     = "cursor_4c_Munis.munici"
752:             .Column2.Width             = 263
753:             .Column2.FontName          = "Tahoma"
754:             .Column2.FontSize          = 8
755:             .Column2.Resizable         = .T.
756:             .Column2.Header1.Caption   = "Munic" + CHR(237) + "pio"
757:             .Column2.Header1.Alignment = 2
758:         ENDWITH
759: 
760:         BINDEVENT(loc_oPagina.grd_4c_Munis.Column1.Text1, "KeyPress", THIS, "GradMuniUFLostFocus")
761:         BINDEVENT(loc_oPagina.grd_4c_Munis.Column2.Text1, "KeyPress", THIS, "GradMuniMunLostFocus")
762: 
763:         *-- ===================================================================
764:         *-- cmd_4c_InserirProd - Inserir linha no GradProd (InserirV do legado)
765:         *-- Top=305+29=334, Left=912, Width=45, Height=45
766:         *-- ===================================================================
767:         loc_oPagina.AddObject("cmd_4c_InserirProd", "CommandButton")
768:         WITH loc_oPagina.cmd_4c_InserirProd
769:             .Caption         = ""
770:             .ToolTipText     = "Inserir Produto"
771:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
772:             .PicturePosition = 0
773:             .Top             = 334
774:             .Left            = 912
775:             .Width           = 45
776:             .Height          = 45
777:             .FontBold        = .T.
778:             .FontName        = "Verdana"
779:             .FontSize        = 8
780:             .ForeColor       = RGB(36, 84, 155)
781:             .BackColor       = RGB(255, 255, 255)
782:             .Themes          = .F.
783:             .SpecialEffect   = 0
784:             .Visible         = .T.
785:         ENDWITH
786:         BINDEVENT(loc_oPagina.cmd_4c_InserirProd, "Click", THIS, "BtnInserirProdClick")
787: 
788:         *-- cmd_4c_ExcluirProd - Excluir linha do GradProd (ExcluirV do legado)
789:         *-- Top=350+29=379, Left=912, Width=45, Height=45
790:         loc_oPagina.AddObject("cmd_4c_ExcluirProd", "CommandButton")
791:         WITH loc_oPagina.cmd_4c_ExcluirProd
792:             .Caption         = ""
793:             .ToolTipText     = "Excluir Produto"
794:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
795:             .PicturePosition = 0
796:             .Top             = 379
797:             .Left            = 912
798:             .Width           = 45
799:             .Height          = 45
800:             .FontBold        = .T.
801:             .FontName        = "Verdana"
802:             .FontSize        = 8
803:             .ForeColor       = RGB(36, 84, 155)
804:             .BackColor       = RGB(255, 255, 255)
805:             .Themes          = .F.
806:             .SpecialEffect   = 0
807:             .Visible         = .T.
808:         ENDWITH
809:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirProd, "Click", THIS, "BtnExcluirProdClick")
810: 
811:         *-- ===================================================================
812:         *-- grd_4c_Prods (GradProd) - Grade de Produtos
813:         *-- Top=133+29=162, Left=417, Width=490, Height=456
814:         *-- Col1=Codigo(108), Col2=Descricao(360)
815:         *-- ===================================================================
816:         loc_oPagina.AddObject("grd_4c_Prods", "Grid")
817:         loc_oPagina.grd_4c_Prods.ColumnCount = 3
818:         loc_oPagina.grd_4c_Prods.RecordSource = "cursor_4c_Prods"
819:         loc_oPagina.grd_4c_Prods.ColumnCount  = 2
820: 
821:         WITH loc_oPagina.grd_4c_Prods
822:             .Top                = 162
823:             .Left               = 417
824:             .Width              = 490
825:             .Height             = 456
826:             .DeleteMark         = .F.
827:             .RecordMark         = .F.
828:             .RowHeight          = 16

*-- Linhas 844 a 870:
844:             .Column1.FontName          = "Tahoma"
845:             .Column1.FontSize          = 8
846:             .Column1.Resizable         = .T.
847:             .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
848:             .Column1.Header1.Alignment = 2
849: 
850:             .Column2.ControlSource     = "cursor_4c_Prods.dpros"
851:             .Column2.Width             = 360
852:             .Column2.FontName          = "Tahoma"
853:             .Column2.FontSize          = 8
854:             .Column2.Resizable         = .T.
855:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
856:             .Column2.Header1.Alignment = 2
857:         ENDWITH
858: 
859:         BINDEVENT(loc_oPagina.grd_4c_Prods.Column1.Text1, "KeyPress", THIS, "GradProdCodLostFocus")
860:         BINDEVENT(loc_oPagina.grd_4c_Prods.Column2.Text1, "KeyPress", THIS, "GradProdDescLostFocus")
861:         BINDEVENT(loc_oPagina.grd_4c_Prods, "AfterRowColChange", THIS, "GradProdAfterRowColChange")
862: 
863:         *-- BINDEVENTs para Confirmar e Cancelar (criados acima no cnt_4c_Salva)
864:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
865:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
866: 
867:         THIS.TornarControlesVisiveis(loc_oPagina)
868: 
869:         *-- img_4c_ImgProds inicia oculta (TornarControlesVisiveis setou .T. acima)
870:         loc_oPagina.img_4c_ImgProds.Visible = .F.

*-- Linhas 896 a 912:
896:                     WITH loc_oGrid
897:                         .Column1.ControlSource   = "cursor_4c_Dados.iclis"
898:                         .Column1.Width           = 100
899:                         .Column1.Header1.Caption = "Conta"
900: 
901:                         .Column2.ControlSource   = "cursor_4c_Dados.Rclis"
902:                         .Column2.Width           = 450
903:                         .Column2.Header1.Caption = "Nome"
904: 
905:                         .Column3.ControlSource   = "cursor_4c_Dados.datas"
906:                         .Column3.Width           = 80
907:                         .Column3.Header1.Caption = "Data"
908:                     ENDWITH
909: 
910:                     THIS.FormatarGridLista(loc_oGrid)
911: 
912:                     IF USED("cursor_4c_Dados") AND RECCOUNT("cursor_4c_Dados") > 0

*-- Linhas 1253 a 1261:
1253: 
1254:     *===========================================================================
1255:     * BtnSalvarClick - Valida e persiste o registro (INCLUIR ou ALTERAR)
1256:     * Chamado via BINDEVENT cnt_4c_Salva.cmd_4c_Confirmar Click
1257:     *===========================================================================
1258:     PROCEDURE BtnSalvarClick()
1259:         LOCAL loc_lResultado, loc_cIclis, loc_nQtdProd, loc_oPg2, loc_lValido, loc_nRec
1260:         loc_lResultado = .F.
1261:         loc_lValido    = .F.

*-- Linhas 1315 a 1323:
1315: 
1316:     *===========================================================================
1317:     * BtnCancelarClick - Cancela edicao e retorna para lista
1318:     * Chamado via BINDEVENT cnt_4c_Salva.cmd_4c_Cancelar Click
1319:     *===========================================================================
1320:     PROCEDURE BtnCancelarClick()
1321:         THIS.this_cModoAtual = "LISTA"
1322:         THIS.AlternarPagina(1)
1323:     ENDPROC

*-- Linhas 1422 a 1433:
1422:             WITH loc_oGrid
1423:                 .Column1.ControlSource   = "cursor_4c_Munis.uf"
1424:                 .Column1.Width           = 24
1425:                 .Column1.Header1.Caption = "UF"
1426:                 .Column2.ControlSource   = "cursor_4c_Munis.munici"
1427:                 .Column2.Width           = 263
1428:                 .Column2.Header1.Caption = "Munic" + CHR(237) + "pio"
1429:             ENDWITH
1430:             loc_oGrid.Refresh()
1431:         CATCH TO loException
1432:             MsgErro("Erro ao atualizar grade munic" + CHR(237) + "pios:" + CHR(13) + ;
1433:                 loException.Message, "Formrst.RefreshGridMunis")

*-- Linhas 1448 a 1459:
1448:             WITH loc_oGrid
1449:                 .Column1.ControlSource   = "cursor_4c_Prods.cpros"
1450:                 .Column1.Width           = 108
1451:                 .Column1.Header1.Caption = CHR(67) + CHR(243) + "digo"
1452:                 .Column2.ControlSource   = "cursor_4c_Prods.dpros"
1453:                 .Column2.Width           = 360
1454:                 .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1455:             ENDWITH
1456:             loc_oGrid.Refresh()
1457:         CATCH TO loException
1458:             MsgErro("Erro ao atualizar grade produtos:" + CHR(13) + loException.Message, ;
1459:                 "Formrst.RefreshGridProds")

*-- Linhas 2002 a 2016:
2002:             loc_oPg2      = THIS.pgf_4c_Paginas.Page2
2003:             loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2004: 
2005:             loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
2006:             loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
2007: 
2008:             loc_oPg2.cmd_4c_InserirMuni.Enabled = loc_lEditando
2009:             loc_oPg2.cmd_4c_ExcluirMuni.Enabled = loc_lEditando
2010:             loc_oPg2.cmd_4c_InserirProd.Enabled = loc_lEditando
2011:             loc_oPg2.cmd_4c_ExcluirProd.Enabled = loc_lEditando
2012:             loc_oPg2.grd_4c_Munis.ReadOnly       = !loc_lEditando
2013:             loc_oPg2.grd_4c_Prods.ReadOnly       = !loc_lEditando
2014:         CATCH TO loException
2015:             MsgErro("Erro ao ajustar bot" + CHR(245) + "es:" + CHR(13) + loException.Message, ;
2016:                 "Formrst.AjustarBotoesPorModo")


### BO (C:\4c\projeto\app\classes\rstBO.prg):
*==============================================================================
* rstBO.prg - Business Object para Exclusividade Por Contas (SigCdRst/SigCdRsi)
* Herda de BusinessBase
*==============================================================================

DEFINE CLASS rstBO AS BusinessBase

    *-- SigCdRst - Propriedades principais
    this_cSkChaves  = ""    && skchaves  C(20) PK
    this_cIclis     = ""    && iclis     C(10) FK SigCdCli
    this_nChkMatrs  = 0     && chkmatrs  N(1,0) Checa Matriz (op_con)
    this_dDatas     = {}    && datas     D nullable
    this_dDtAlts    = {}    && dtalts    D nullable (auditoria)

    *-- Propriedade derivada (JOIN SigCdCli) - somente exibicao
    this_cRclis     = ""    && Rclis C(40) nome do cliente

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdRst"
            THIS.this_cCampoChave = "skChaves"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cSkChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT lista de exclusividades com nome do cliente
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF
            loc_cSQL = "SELECT a.skchaves, a.iclis, ISNULL(b.Rclis,'') AS Rclis," + ;
                       " a.chkmatrs, a.datas, a.dtalts" + ;
                       " FROM SigCdRst a" + ;
                       " LEFT JOIN SigCdCli b ON b.Iclis = a.Iclis" + ;
                       " ORDER BY b.Rclis"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar exclusividades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados (skchaves C(20), iclis C(10), Rclis C(40), ;
                    chkmatrs N(1,0), datas T, dtalts T)
                SET NULL OFF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro SigCdRst por skChaves
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.skchaves, a.iclis, ISNULL(b.Rclis,'') AS Rclis," + ;
                       " a.chkmatrs, a.datas, a.dtalts" + ;
                       " FROM SigCdRst a" + ;
                       " LEFT JOIN SigCdCli b ON b.Iclis = a.Iclis" + ;
                       " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves)
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
                MsgErro("Registro n" + CHR(227) + "o encontrado.", "Aviso")
            ENDIF
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia colunas do cursor para propriedades
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cSkChaves = TratarNulo(skchaves, "C")
            THIS.this_cIclis    = TratarNulo(iclis,    "C")
            THIS.this_cRclis    = TratarNulo(Rclis,    "C")
            THIS.this_nChkMatrs = TratarNulo(chkmatrs, "N")
            THIS.this_dDatas    = TratarNulo(datas,    "D")
            THIS.this_dDtAlts   = TratarNulo(dtalts,   "D")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarMunicipios - Carrega SigCdRsi tipo 'M' para o skChaves dado
    * Popula cursor_4c_Munis com: skchaves, pkchaves, codibges, tipos, UFIBGEs, munici, uf
    *--------------------------------------------------------------------------
    FUNCTION BuscarMunicipios(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Munis")
                USE IN cursor_4c_Munis
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Munis (skchaves C(20), pkchaves C(20), codibges C(7), ;
                tipos C(1), UFIBGEs N(2,0), munici C(40), uf C(2))
            SET NULL OFF

            IF !EMPTY(par_cSkChaves)
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkchaves, a.codibges, a.tipos," + ;
                           " a.ufibges AS UFIBGEs," + ;
                           " ISNULL(c.descs,'') AS munici, ISNULL(d.estados,'') AS uf" + ;
                           " FROM SigCdRsi a" + ;
                           " LEFT JOIN SigCdMun c ON c.codigos = a.codibges" + ;
                           " LEFT JOIN SigCdUfs d ON d.ufibges = a.ufibges" + ;
                           " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves) + " AND a.tipos = 'M'"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_MunisTmp")
                    TABLEREVERT(.T., "cursor_4c_MunisTmp")
                    USE IN cursor_4c_MunisTmp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_MunisTmp")
                IF loc_nResult >= 0
                    SELECT cursor_4c_MunisTmp
                    SCAN
                        SELECT cursor_4c_Munis
                        APPEND BLANK
                        REPLACE skchaves WITH ALLTRIM(NVL(cursor_4c_MunisTmp.skchaves, "")), ;
                                pkchaves WITH ALLTRIM(NVL(cursor_4c_MunisTmp.pkchaves, "")), ;
                                codibges WITH ALLTRIM(NVL(cursor_4c_MunisTmp.codibges, "")), ;
                                tipos    WITH ALLTRIM(NVL(cursor_4c_MunisTmp.tipos, "")), ;
                                UFIBGEs  WITH NVL(cursor_4c_MunisTmp.UFIBGEs, 0), ;
                                munici   WITH ALLTRIM(NVL(cursor_4c_MunisTmp.munici, "")), ;
                                uf       WITH ALLTRIM(NVL(cursor_4c_MunisTmp.uf, ""))
                        SELECT cursor_4c_MunisTmp
                    ENDSCAN
                    IF USED("cursor_4c_MunisTmp")
                        USE IN cursor_4c_MunisTmp
                    ENDIF
                ENDIF
            ENDIF

            SELECT cursor_4c_Munis
            IF RECCOUNT() = 0
                APPEND BLANK
            ENDIF
            GO TOP IN cursor_4c_Munis
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar munic" + CHR(237) + "pios:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_MunisTmp")
                USE IN cursor_4c_MunisTmp
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarProdutos - Carrega SigCdRsi tipo 'P' para o skChaves dado
    * Popula cursor_4c_Prods com: skchaves, pkchaves, cpros, dpros, tipos
    *--------------------------------------------------------------------------
    FUNCTION BuscarProdutos(par_cSkChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            IF USED("cursor_4c_Prods")
                USE IN cursor_4c_Prods
            ENDIF
            SET NULL ON
            CREATE CURSOR cursor_4c_Prods (skchaves C(20), pkchaves C(20), cpros C(14), ;
                dpros C(40), tipos C(1))
            SET NULL OFF

            IF !EMPTY(par_cSkChaves)
                loc_cSQL = "SELECT DISTINCT a.skchaves, a.pkchaves, a.cpros," + ;
                           " ISNULL(c.dpros,'') AS dpros, a.tipos" + ;
                           " FROM SigCdRsi a" + ;
                           " LEFT JOIN SigCdPro c ON c.cpros = a.cpros" + ;
                           " WHERE a.skchaves = " + EscaparSQL(par_cSkChaves) + " AND a.tipos = 'P'"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ProdsTmp")
                    TABLEREVERT(.T., "cursor_4c_ProdsTmp")
                    USE IN cursor_4c_ProdsTmp
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProdsTmp")
                IF loc_nResult >= 0
                    SELECT cursor_4c_ProdsTmp
                    SCAN
                        SELECT cursor_4c_Prods
                        APPEND BLANK
                        REPLACE skchaves WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.skchaves, "")), ;
                                pkchaves WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.pkchaves, "")), ;
                                cpros    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.cpros, "")), ;
                                dpros    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.dpros, "")), ;
                                tipos    WITH ALLTRIM(NVL(cursor_4c_ProdsTmp.tipos, ""))
                        SELECT cursor_4c_ProdsTmp
                    ENDSCAN
                    IF USED("cursor_4c_ProdsTmp")
                        USE IN cursor_4c_ProdsTmp
                    ENDIF
                ENDIF
            ENDIF

            SELECT cursor_4c_Prods
            IF RECCOUNT() = 0
                APPEND BLANK
            ENDIF
            GO TOP IN cursor_4c_Prods
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar produtos:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ProdsTmp")
                USE IN cursor_4c_ProdsTmp
            ENDIF
        ENDTRY
        RETURN loc_lResultado
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarContaCadastrada - Checa se Iclis ja tem exclusividade em SigCdRst
    *--------------------------------------------------------------------------
    FUNCTION VerificarContaCadastrada(par_cIclis)
        LOCAL loc_lExiste, loc_nResult
        loc_lExiste = .F.
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT TOP 1 skchaves FROM SigCdRst WHERE iclis = " + EscaparSQL(par_cIclis), ;
                "cursor_4c_ChkRst")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ChkRst") > 0
                loc_lExiste = .T.
            ENDIF
            IF USED("cursor_4c_ChkRst")
                USE IN cursor_4c_ChkRst
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_ChkRst")
                USE IN cursor_4c_ChkRst
            ENDIF
        ENDTRY
        RETURN loc_lExiste
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarChaveUnica - Gera chave C(20) via NEWID do SQL Server
    *--------------------------------------------------------------------------
    FUNCTION GerarChaveUnica()
        LOCAL loc_cChave, loc_nResult
        loc_cChave = ""
        TRY
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT LEFT(REPLACE(CAST(NEWID() AS VARCHAR(36)),'-',''),20) AS novachave", ;
                "cursor_4c_NewId")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cChave = ALLTRIM(novachave)
            ENDIF
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao gerar chave:" + CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_NewId")
                USE IN cursor_4c_NewId
            ENDIF
        ENDTRY
        RETURN loc_cChave
    ENDFUNC

    *--------------------------------------------------------------------------
    * InserirItensSigCdRsi - INSERT SigCdRsi de cursor_4c_Munis e cursor_4c_Prods
    * Metodo auxiliar compartilhado por Inserir() e Atualizar()
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE InserirItensSigCdRsi()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cPkChave
        loc_lResultado = .T.

        *-- INSERT municipios (tipo 'M')
        IF USED("cursor_4c_Munis")
            SELECT cursor_4c_Munis
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(cursor_4c_Munis.codibges)) OR cursor_4c_Munis.UFIBGEs <> 0
                    loc_cPkChave = THIS.GerarChaveUnica()
                    IF EMPTY(loc_cPkChave)
                        loc_lResultado = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdRsi" + ;
                                   " (skchaves, pkchaves, codibges, tipos, ufibges, cpros, dtalts)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cSkChaves) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Munis.codibges)) + "," + ;
                                   "'M'," + ;
                                   FormatarNumeroSQL(cursor_4c_Munis.UFIBGEs) + "," + ;
                                   "''," + ;
                                   "GETDATE())"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_InsRsi")
                            TABLEREVERT(.T., "cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRsi")
                        IF USED("cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir munic" + CHR(237) + "pio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                ENDIF
                SELECT cursor_4c_Munis
            ENDSCAN
        ENDIF

        *-- INSERT produtos (tipo 'P')
        IF USED("cursor_4c_Prods")
            SELECT cursor_4c_Prods
            GO TOP
            SCAN
                IF !EMPTY(ALLTRIM(cursor_4c_Prods.cpros))
                    loc_cPkChave = THIS.GerarChaveUnica()
                    IF EMPTY(loc_cPkChave)
                        loc_lResultado = .F.
                    ELSE
                        loc_cSQL = "INSERT INTO SigCdRsi" + ;
                                   " (skchaves, pkchaves, codibges, tipos, ufibges, cpros, dtalts)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(THIS.this_cSkChaves) + "," + ;
                                   EscaparSQL(loc_cPkChave) + "," + ;
                                   "''," + ;
                                   "'P'," + ;
                                   "0," + ;
                                   EscaparSQL(ALLTRIM(cursor_4c_Prods.cpros)) + "," + ;
                                   "GETDATE())"
                        *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                        IF USED("cursor_4c_InsRsi")
                            TABLEREVERT(.T., "cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF

                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRsi")
                        IF USED("cursor_4c_InsRsi")
                            USE IN cursor_4c_InsRsi
                        ENDIF
                        IF loc_nResult < 0
                            MsgErro("Erro ao inserir produto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                ENDIF
                SELECT cursor_4c_Prods
            ENDSCAN
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigCdRst + INSERT SigCdRsi de cursor_4c_Munis e cursor_4c_Prods
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = THIS.GerarChaveUnica()
            IF EMPTY(loc_cSQL)
                MsgErro("Erro ao gerar chave prim" + CHR(225) + "ria.", "Erro")
            ELSE
                THIS.this_cSkChaves = loc_cSQL

                loc_cSQL = "INSERT INTO SigCdRst (skchaves, iclis, chkmatrs, datas, dtalts)" + ;
                           " VALUES (" + ;
                           EscaparSQL(THIS.this_cSkChaves) + "," + ;
                           EscaparSQL(THIS.this_cIclis) + "," + ;
                           FormatarNumeroSQL(THIS.this_nChkMatrs) + "," + ;
                           "GETDATE(), NULL)"
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_InsRst")
                    TABLEREVERT(.T., "cursor_4c_InsRst")
                    USE IN cursor_4c_InsRst
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsRst")
                IF USED("cursor_4c_InsRst")
                    USE IN cursor_4c_InsRst
                ENDIF

                IF loc_nResult >= 0
                    IF THIS.InserirItensSigCdRsi()
                        THIS.RegistrarAuditoria("INSERT")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao inserir exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SigCdRst + DELETE SigCdRsi + INSERT SigCdRsi novos itens
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.
        TRY
            *-- DELETE SigCdRsi antigos
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdRsi WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                "cursor_4c_DelRsi")
            IF USED("cursor_4c_DelRsi")
                USE IN cursor_4c_DelRsi
            ENDIF

            IF loc_nResult >= 0
                *-- UPDATE SigCdRst
                loc_cSQL = "UPDATE SigCdRst SET" + ;
                           " iclis = " + EscaparSQL(THIS.this_cIclis) + "," + ;
                           " chkmatrs = " + FormatarNumeroSQL(THIS.this_nChkMatrs) + "," + ;
                           " dtalts = GETDATE()" + ;
                           " WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves)
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_UpdRst")
                    TABLEREVERT(.T., "cursor_4c_UpdRst")
                    USE IN cursor_4c_UpdRst
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UpdRst")
                IF USED("cursor_4c_UpdRst")
                    USE IN cursor_4c_UpdRst
                ENDIF

                IF loc_nResult >= 0
                    IF THIS.InserirItensSigCdRsi()
                        THIS.RegistrarAuditoria("UPDATE")
                        loc_lResultado = .T.
                    ENDIF
                ELSE
                    MsgErro("Erro ao atualizar exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao limpar itens da exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigCdRsi e SigCdRst (nesta ordem - FK constraint)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            *-- DELETE SigCdRsi primeiro (filho)
            loc_nResult = SQLEXEC(gnConnHandle, ;
                "DELETE FROM SigCdRsi WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                "cursor_4c_DelRsi2")
            IF USED("cursor_4c_DelRsi2")
                USE IN cursor_4c_DelRsi2
            ENDIF

            IF loc_nResult >= 0
                *-- DELETE SigCdRst (pai)
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "DELETE FROM SigCdRst WHERE skchaves = " + EscaparSQL(THIS.this_cSkChaves), ;
                    "cursor_4c_DelRst")
                IF USED("cursor_4c_DelRst")
                    USE IN cursor_4c_DelRst
                ENDIF

                IF loc_nResult >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao excluir itens da exclusividade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

