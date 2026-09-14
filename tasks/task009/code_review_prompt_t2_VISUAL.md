# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH ENDPROC define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: ENDPROC.RecordSource).

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES VISUAIS
- [ALINHAMENTO] Botoes cmd_4c_* com Top diferente no mesmo grupo horizontal
  - Identificar Top mais frequente no grupo, alinhar os desalinhados
- [ALINHAMENTO-CONTAINER] Botoes no mesmo container cnt_4c_* com Top diferente
- [TITULO-NAO-PROPAGADO] Caption do form nao propagado para lbl_4c_Sombra/lbl_4c_Titulo
- [CHECKBOX-TIPO] CheckBox.Value tipo inconsistente (.F. vs 0/1)

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2658 linhas total):

*-- Linhas 68 a 76:
68:                 THIS.ConfigurarPageFrame()
69:                 THIS.ConfigurarPaginaLista()
70:                 THIS.ConfigurarPaginaDados()
71:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
72: 
73:                 *-- Data inicial = hoje
74:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_inicial.Value = DATE()
75:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_final.Value   = DATE()
76: 

*-- Linhas 101 a 121:
101:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
102: 
103:         WITH THIS.pgf_4c_Paginas
104:             .Top       = -29
105:             .Left      = 0
106:             .Width     = 1003
107:             .Height    = 600
108:             .PageCount = 2
109:             .Tabs      = .F.
110:             .Visible   = .T.
111: 
112:             .Page1.Caption  = "Lista"
113:             .Page1.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
114:             .Page1.BackColor = RGB(255, 255, 255)
115: 
116:             .Page2.Caption  = "Dados"
117:             .Page2.Picture  = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118:             .Page2.BackColor = RGB(255, 255, 255)
119:         ENDWITH
120:     ENDPROC
121: 

*-- Linhas 131 a 152:
131:         *-- Cabecalho (cntSombra: Top=1+29=30)
132:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
133:         WITH loc_oPagina.cnt_4c_Cabecalho
134:             .Top         = 30
135:             .Left        = -1
136:             .Width       = 1100
137:             .Height      = 80
138:             .BackStyle   = 1
139:             .BackColor   = RGB(53, 53, 53)
140:             .BorderWidth = 0
141:             .Visible     = .T.
142:         ENDWITH
143:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
144:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
145:             .Caption   = "Conta Corrente Geral"
146:             .Top       = 20
147:             .Left      = 20
148:             .Width     = 400
149:             .Height    = 30
150:             .FontName  = "Tahoma"
151:             .FontSize  = 14
152:             .FontBold  = .T.

*-- Linhas 158 a 319:
158:         *-- Botoes CRUD (Grupo_op: Left=467, Top=-1+29=28)
159:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
160:         WITH loc_oPagina.cnt_4c_Botoes
161:             .Top         = 28
162:             .Left        = 467
163:             .Width       = 385
164:             .Height      = 85
165:             .BackStyle = 1
166:             .BackColor = RGB(53, 53, 53)
167:             .BorderWidth = 0
168:             .Visible     = .T.
169:         ENDWITH
170: 
171:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
172:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
173:             .Caption         = "Incluir"
174:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
175:             .PicturePosition = 13
176:             .Width           = 75
177:             .Height          = 75
178:             .Left            = 5
179:             .Top             = 5
180:             .FontName        = "Comic Sans MS"
181:             .FontSize        = 8
182:             .Themes          = .F.
183:             .SpecialEffect   = 0
184:             .BackColor       = RGB(255, 255, 255)
185:             .ForeColor       = RGB(90, 90, 90)
186:             .Visible         = .T.
187:         ENDWITH
188:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
189: 
190:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
191:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
192:             .Caption         = "Visualizar"
193:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
194:             .PicturePosition = 13
195:             .Width           = 75
196:             .Height          = 75
197:             .Left            = 80
198:             .Top             = 5
199:             .FontName        = "Comic Sans MS"
200:             .FontSize        = 8
201:             .Themes          = .F.
202:             .SpecialEffect   = 0
203:             .BackColor       = RGB(255, 255, 255)
204:             .ForeColor       = RGB(90, 90, 90)
205:             .Visible         = .T.
206:         ENDWITH
207:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
208: 
209:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
210:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
211:             .Caption         = "Alterar"
212:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
213:             .PicturePosition = 13
214:             .Width           = 75
215:             .Height          = 75
216:             .Left            = 155
217:             .Top             = 5
218:             .FontName        = "Comic Sans MS"
219:             .FontSize        = 8
220:             .Themes          = .F.
221:             .SpecialEffect   = 0
222:             .BackColor       = RGB(255, 255, 255)
223:             .ForeColor       = RGB(90, 90, 90)
224:             .Visible         = .T.
225:         ENDWITH
226:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
227: 
228:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
229:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
230:             .Caption         = "Excluir"
231:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
232:             .PicturePosition = 13
233:             .Width           = 75
234:             .Height          = 75
235:             .Left            = 230
236:             .Top             = 5
237:             .FontName        = "Comic Sans MS"
238:             .FontSize        = 8
239:             .Themes          = .F.
240:             .SpecialEffect   = 0
241:             .BackColor       = RGB(255, 255, 255)
242:             .ForeColor       = RGB(90, 90, 90)
243:             .Visible         = .T.
244:         ENDWITH
245:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
246: 
247:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
248:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
249:             .Caption         = "Buscar"
250:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
251:             .PicturePosition = 13
252:             .Width           = 75
253:             .Height          = 75
254:             .Left            = 305
255:             .Top             = 5
256:             .FontName        = "Comic Sans MS"
257:             .FontSize        = 8
258:             .Themes          = .F.
259:             .SpecialEffect   = 0
260:             .BackColor       = RGB(255, 255, 255)
261:             .ForeColor       = RGB(90, 90, 90)
262:             .Visible         = .T.
263:         ENDWITH
264:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
265: 
266:         *-- Botao Sair (Grupo_Saida: Left=917, Top=-1+29=28)
267:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
268:         WITH loc_oPagina.cnt_4c_Saida
269:             .Top         = 28
270:             .Left        = 917
271:             .Width       = 85
272:             .Height      = 85
273:             .BackStyle = 1
274:             .BackColor = RGB(53, 53, 53)
275:             .BorderWidth = 0
276:             .Visible     = .T.
277:         ENDWITH
278:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
279:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
280:             .Caption         = "Encerrar"
281:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
282:             .PicturePosition = 13
283:             .Width           = 75
284:             .Height          = 75
285:             .Left            = 5
286:             .Top             = 5
287:             .FontName        = "Comic Sans MS"
288:             .FontSize        = 8
289:             .Themes          = .F.
290:             .SpecialEffect   = 0
291:             .BackColor       = RGB(255, 255, 255)
292:             .ForeColor       = RGB(90, 90, 90)
293:             .Visible         = .T.
294:         ENDWITH
295:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
296: 
297:         *-- Botao Movimento/Anexa (Anexa: Left=847, Top=4+29=33)
298:         loc_oPagina.AddObject("shp_4c_ShpAnexa", "Shape")
299:         WITH loc_oPagina.shp_4c_ShpAnexa
300:             .Top         = 36
301:             .Left        = 760
302:             .Width       = 55
303:             .Height      = 6
304:             .BackStyle   = 0
305:             .BorderStyle = 0
306:             .BorderColor = RGB(136, 189, 188)
307:             .Visible     = .F.
308:         ENDWITH
309: 
310:         loc_oPagina.AddObject("cmd_4c_Anexa", "CommandButton")
311:         WITH loc_oPagina.cmd_4c_Anexa
312:             .Caption         = "Movimento"
313:             .Top             = 33
314:             .Left            = 847
315:             .Width           = 75
316:             .Height          = 75
317:             .FontBold        = .T.
318:             .FontItalic      = .T.
319:             .FontName        = "Comic Sans MS"

*-- Linhas 326 a 365:
326:             .Themes          = .F.
327:             .Visible         = .F.
328:         ENDWITH
329:         BINDEVENT(loc_oPagina.cmd_4c_Anexa, "Click", THIS, "BtnAnexaClick")
330: 
331:         *-- Filtro de periodo (cntFiltros: Top=83+29=112, Left=5, Width=642, Height=29)
332:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
333:         WITH loc_oPagina.cnt_4c_Filtros
334:             .Top         = 112
335:             .Left        = 5
336:             .Width       = 642
337:             .Height      = 29
338:             .BackStyle   = 0
339:             .BorderWidth = 0
340:             .BorderColor = RGB(90, 90, 90)
341:             .Visible     = .T.
342:         ENDWITH
343: 
344:         *-- Sub-container Cnt_periodo (Top=-3 relativo ao cntFiltros, Left=14)
345:         loc_oPagina.cnt_4c_Filtros.AddObject("cnt_4c_Periodo", "Container")
346:         WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo
347:             .Top         = -3
348:             .Left        = 14
349:             .Width       = 271
350:             .Height      = 36
351:             .BackStyle   = 0
352:             .BorderWidth = 0
353:             .Visible     = .T.
354:         ENDWITH
355: 
356:         loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("lbl_4c_LblPeriodo", "Label")
357:         WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.lbl_4c_LblPeriodo
358:             .Caption   = "Per" + CHR(237) + "odo : "
359:             .Left      = 17
360:             .Top       = 10
361:             .Width     = 54
362:             .Height    = 15
363:             .FontBold  = .T.
364:             .FontName  = "Tahoma"
365:             .FontSize  = 8

*-- Linhas 371 a 380:
371:         loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("txt_4c_Dt_inicial", "TextBox")
372:         WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_inicial
373:             .Value         = DATE()
374:             .Left          = 73
375:             .Top           = 6
376:             .Width         = 80
377:             .Height        = 20
378:             .FontName      = "Tahoma"
379:             .FontSize      = 8
380:             .Format        = "E"

*-- Linhas 386 a 410:
386:         ENDWITH
387:         BINDEVENT(loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_inicial, "KeyPress", THIS, "DtInicialKeyPress")
388: 
389:         loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("lbl_4c_LblAte", "Label")
390:         WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.lbl_4c_LblAte
391:             .Caption   = "at" + CHR(233)
392:             .Left      = 158
393:             .Top       = 10
394:             .FontBold  = .T.
395:             .FontName  = "Tahoma"
396:             .FontSize  = 8
397:             .BackStyle = 0
398:             .ForeColor = RGB(90, 90, 90)
399:         ENDWITH
400: 
401:         loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.AddObject("txt_4c_Dt_final", "TextBox")
402:         WITH loc_oPagina.cnt_4c_Filtros.cnt_4c_Periodo.txt_4c_Dt_final
403:             .Value         = DATE()
404:             .Left          = 184
405:             .Top           = 6
406:             .Width         = 80
407:             .Height        = 20
408:             .FontName      = "Tahoma"
409:             .FontSize      = 8
410:             .Format        = "E"

*-- Linhas 422 a 431:
422:         *-- 6=Debito(80) 7=" "(28) 8=Credito(80) 9="  "(28) 10=NF(78) 11=Doc(78)
423:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
424:         WITH loc_oPagina.grd_4c_Lista
425:             .Top               = 144
426:             .Left              = 23
427:             .Width             = 944
428:             .Height            = 473
429:             .FontName          = "Verdana"
430:             .FontSize          = 8
431:             .ReadOnly          = .T.

*-- Linhas 450 a 458:
450:             .Movable   = .F.
451:             .Resizable = .F.
452:             .ReadOnly  = .T.
453:             .Header1.Caption   = "Data"
454:             .Header1.FontName  = "Tahoma"
455:             .Header1.FontSize  = 8
456:             .Header1.Alignment = 2
457:             .Header1.ForeColor = RGB(90, 90, 90)
458:         ENDWITH

*-- Linhas 466 a 474:
466:             .Movable   = .F.
467:             .Resizable = .F.
468:             .ReadOnly  = .T.
469:             .Header1.Caption   = "O"
470:             .Header1.FontName  = "Tahoma"
471:             .Header1.FontSize  = 8
472:             .Header1.Alignment = 2
473:             .Header1.ForeColor = RGB(90, 90, 90)
474:         ENDWITH

*-- Linhas 481 a 489:
481:             .Movable   = .F.
482:             .Resizable = .F.
483:             .ReadOnly  = .T.
484:             .Header1.Caption   = "Conta"
485:             .Header1.FontName  = "Tahoma"
486:             .Header1.FontSize  = 8
487:             .Header1.Alignment = 2
488:             .Header1.ForeColor = RGB(90, 90, 90)
489:         ENDWITH

*-- Linhas 496 a 504:
496:             .Movable   = .F.
497:             .Resizable = .F.
498:             .ReadOnly  = .T.
499:             .Header1.Caption   = "Contrapartida"
500:             .Header1.FontName  = "Tahoma"
501:             .Header1.FontSize  = 8
502:             .Header1.Alignment = 2
503:             .Header1.ForeColor = RGB(90, 90, 90)
504:         ENDWITH

*-- Linhas 511 a 519:
511:             .Movable   = .F.
512:             .Resizable = .F.
513:             .ReadOnly  = .T.
514:             .Header1.Caption   = "Hist" + CHR(243) + "rico"
515:             .Header1.FontName  = "Tahoma"
516:             .Header1.FontSize  = 8
517:             .Header1.Alignment = 2
518:             .Header1.ForeColor = RGB(90, 90, 90)
519:         ENDWITH

*-- Linhas 527 a 535:
527:             .Resizable = .F.
528:             .ReadOnly  = .T.
529:             .InputMask = "999,999,999.99"
530:             .Header1.Caption   = "D" + CHR(233) + "bito"
531:             .Header1.FontName  = "Tahoma"
532:             .Header1.FontSize  = 8
533:             .Header1.Alignment = 2
534:             .Header1.ForeColor = RGB(90, 90, 90)
535:         ENDWITH

*-- Linhas 542 a 550:
542:             .Movable   = .F.
543:             .Resizable = .F.
544:             .ReadOnly  = .T.
545:             .Header1.Caption   = ""
546:             .Header1.FontName  = "Tahoma"
547:             .Header1.Alignment = 2
548:             .Header1.ForeColor = RGB(90, 90, 90)
549:         ENDWITH
550: 

*-- Linhas 557 a 565:
557:             .Resizable = .F.
558:             .ReadOnly  = .T.
559:             .InputMask = "999,999,999.99"
560:             .Header1.Caption   = "Cr" + CHR(233) + "dito"
561:             .Header1.FontName  = "Tahoma"
562:             .Header1.FontSize  = 8
563:             .Header1.Alignment = 2
564:             .Header1.ForeColor = RGB(90, 90, 90)
565:         ENDWITH

*-- Linhas 572 a 580:
572:             .Movable   = .F.
573:             .Resizable = .F.
574:             .ReadOnly  = .T.
575:             .Header1.Caption   = ""
576:             .Header1.FontName  = "Tahoma"
577:             .Header1.Alignment = 2
578:             .Header1.ForeColor = RGB(90, 90, 90)
579:         ENDWITH
580: 

*-- Linhas 586 a 594:
586:             .Movable   = .F.
587:             .Resizable = .F.
588:             .ReadOnly  = .T.
589:             .Header1.Caption   = "NF"
590:             .Header1.FontName  = "Tahoma"
591:             .Header1.FontSize  = 8
592:             .Header1.Alignment = 2
593:             .Header1.ForeColor = RGB(90, 90, 90)
594:         ENDWITH

*-- Linhas 601 a 609:
601:             .Movable   = .F.
602:             .Resizable = .F.
603:             .ReadOnly  = .T.
604:             .Header1.Caption   = "Documento"
605:             .Header1.FontName  = "Tahoma"
606:             .Header1.FontSize  = 8
607:             .Header1.Alignment = 2
608:             .Header1.ForeColor = RGB(90, 90, 90)
609:         ENDWITH

*-- Linhas 624 a 719:
624:         *-- Botoes Salvar/Cancelar (Grupo_Salva: Left=842, Top=-4+29=25)
625:         loc_oPagina.AddObject("cnt_4c_Salvar", "Container")
626:         WITH loc_oPagina.cnt_4c_Salvar
627:             .Top         = 25
628:             .Left        = 842
629:             .Width       = 160
630:             .Height      = 85
631:             .BackStyle   = 0
632:             .BorderWidth = 0
633:             .Visible     = .T.
634:         ENDWITH
635:         loc_oPagina.cnt_4c_Salvar.AddObject("cmd_4c_Salvar", "CommandButton")
636:         WITH loc_oPagina.cnt_4c_Salvar.cmd_4c_Salvar
637:             .Caption         = "Salvar"
638:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
639:             .PicturePosition = 13
640:             .Width           = 75
641:             .Height          = 75
642:             .Left            = 6
643:             .Top             = 5
644:             .FontName        = "Comic Sans MS"
645:             .FontSize        = 8
646:             .Themes          = .F.
647:             .SpecialEffect   = 0
648:             .BackColor       = RGB(255, 255, 255)
649:             .ForeColor       = RGB(90, 90, 90)
650:             .Visible         = .T.
651:         ENDWITH
652:         BINDEVENT(loc_oPagina.cnt_4c_Salvar.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
653: 
654:         loc_oPagina.cnt_4c_Salvar.AddObject("cmd_4c_Cancelar", "CommandButton")
655:         WITH loc_oPagina.cnt_4c_Salvar.cmd_4c_Cancelar
656:             .Caption         = "Cancelar"
657:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
658:             .PicturePosition = 13
659:             .Width           = 75
660:             .Height          = 75
661:             .Left            = 81
662:             .Top             = 5
663:             .FontName        = "Comic Sans MS"
664:             .FontSize        = 8
665:             .Themes          = .F.
666:             .SpecialEffect   = 0
667:             .BackColor       = RGB(255, 255, 255)
668:             .ForeColor       = RGB(90, 90, 90)
669:             .Visible         = .T.
670:         ENDWITH
671:         BINDEVENT(loc_oPagina.cnt_4c_Salvar.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
672: 
673:         *-- Shapes divisores visuais (+29 em todos os Tops)
674:         *-- Shape1: Top=153+29=182, secao superior (datas/nf/doc)
675:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
676:         WITH loc_oPagina.shp_4c_Shape1
677:             .Top         = 182
678:             .Left        = 9
679:             .Width       = 980
680:             .Height      = 64
681:             .BackStyle   = 0
682:             .Curvature   = 0
683:             .BorderColor = RGB(90, 90, 90)
684:         ENDWITH
685: 
686:         *-- Shape3: Top=224+29=253, secao debito (esquerda)
687:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
688:         WITH loc_oPagina.shp_4c_Shape3
689:             .Top         = 253
690:             .Left        = 9
691:             .Width       = 485
692:             .Height      = 117
693:             .BackStyle   = 0
694:             .Curvature   = 0
695:             .BorderColor = RGB(90, 90, 90)
696:         ENDWITH
697: 
698:         *-- Shape2: Top=224+29=253, secao credito (direita)
699:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
700:         WITH loc_oPagina.shp_4c_Shape2
701:             .Top         = 253
702:             .Left        = 504
703:             .Width       = 485
704:             .Height      = 117
705:             .BackStyle   = 0
706:             .Curvature   = 0
707:             .BorderColor = RGB(90, 90, 90)
708:         ENDWITH
709: 
710:         *-- Shape6: Top=350+29=379, secao historico
711:         loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
712:         WITH loc_oPagina.shp_4c_Shape6
713:             .Top         = 379
714:             .Left        = 9
715:             .Width       = 980
716:             .Height      = 39
717:             .BackStyle   = 0
718:             .Curvature   = 0
719:             .BorderColor = RGB(90, 90, 90)

*-- Linhas 725 a 739:
725:         *======================================================================
726: 
727:         *-- Label "Lancamento :" (Say1: Left=43, Top=165+29=194)
728:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label1", "Lan" + CHR(231) + "amento :", 43, 194)
729:         *-- txt_4c_Fweditdata_DATA (Top=161+29=190, Left=112, Width=80)
730:         loc_oPagina.AddObject("txt_4c_Fweditdata_DATA", "TextBox")
731:         WITH loc_oPagina.txt_4c_Fweditdata_DATA
732:             .Value         = DATE()
733:             .Left          = 112
734:             .Top           = 190
735:             .Width         = 80
736:             .Height        = 20
737:             .FontName      = "Tahoma"
738:             .FontSize      = 8
739:             .Format        = "E"

*-- Linhas 745 a 759:
745:         ENDWITH
746: 
747:         *-- Label "Vencimento :" (Say10: Left=234, Top=165+29=194)
748:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label10", "Vencimento :", 234, 194)
749:         *-- txt_4c_Fweditdata_VENC (Top=161+29=190, Left=300, Width=80)
750:         loc_oPagina.AddObject("txt_4c_Fweditdata_VENC", "TextBox")
751:         WITH loc_oPagina.txt_4c_Fweditdata_VENC
752:             .Value         = {}
753:             .Left          = 300
754:             .Top           = 190
755:             .Width         = 80
756:             .Height        = 20
757:             .FontName      = "Tahoma"
758:             .FontSize      = 8
759:             .Format        = "E"

*-- Linhas 765 a 779:
765:         ENDWITH
766: 
767:         *-- Label "Emissao :" (Say15: Left=435, Top=194)
768:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label15", "Emiss" + CHR(227) + "o :", 435, 194)
769:         *-- txt_4c_DtEmis (Top=161+29=190, Left=484, Width=80)
770:         loc_oPagina.AddObject("txt_4c_DtEmis", "TextBox")
771:         WITH loc_oPagina.txt_4c_DtEmis
772:             .Value         = {}
773:             .Left          = 484
774:             .Top           = 190
775:             .Width         = 80
776:             .Height        = 20
777:             .FontName      = "Tahoma"
778:             .FontSize      = 8
779:             .Format        = "E"

*-- Linhas 785 a 836:
785:         ENDWITH
786: 
787:         *-- Label "Nota Fiscal :" (Say7: Left=615, Top=194)
788:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label7", "Nota Fiscal :", 615, 194)
789:         *-- txt_4c_Nota (Top=161+29=190, Left=678, Width=80)
790:         loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
791:         WITH loc_oPagina.txt_4c_Nota
792:             .Value         = ""
793:             .Left          = 678
794:             .Top           = 190
795:             .Width         = 80
796:             .Height        = 20
797:             .FontName      = "Tahoma"
798:             .FontSize      = 8
799:             .MaxLength     = 15
800:             .SpecialEffect = 1
801:             .ForeColor     = RGB(0, 0, 0)
802:             .BorderColor   = RGB(100, 100, 100)
803:         ENDWITH
804: 
805:         *-- Label "Usuario :" (Say6: Left=818, Top=194)
806:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label6", "Usu" + CHR(225) + "rio :", 818, 194)
807:         *-- txt_4c__Usuario (Top=161+29=190, Left=865, Width=80 - readonly)
808:         loc_oPagina.AddObject("txt_4c__Usuario", "TextBox")
809:         WITH loc_oPagina.txt_4c__Usuario
810:             .Value         = ""
811:             .Left          = 865
812:             .Top           = 190
813:             .Width         = 80
814:             .Height        = 20
815:             .FontName      = "Tahoma"
816:             .FontSize      = 8
817:             .MaxLength     = 10
818:             .SpecialEffect = 1
819:             .ReadOnly      = .T.
820:             .ForeColor     = RGB(0, 0, 0)
821:             .BorderColor   = RGB(100, 100, 100)
822:         ENDWITH
823: 
824:         *-- Label "Job :" (Say17: Left=84, Top=191+29=220)
825:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label17", "Job :", 84, 220)
826:         *-- txt_4c_Job (Top=187+29=216, Left=112, Width=80 - F4 lookup)
827:         loc_oPagina.AddObject("txt_4c_Job", "TextBox")
828:         WITH loc_oPagina.txt_4c_Job
829:             .Value         = ""
830:             .Left          = 112
831:             .Top           = 216
832:             .Width         = 80
833:             .Height        = 20
834:             .FontName      = "Tahoma"
835:             .FontSize      = 8
836:             .MaxLength     = 10

*-- Linhas 844 a 872:
844:         loc_oPagina.AddObject("txt_4c_DJob", "TextBox")
845:         WITH loc_oPagina.txt_4c_DJob
846:             .Value         = ""
847:             .Left          = 195
848:             .Top           = 216
849:             .Width         = 290
850:             .Height        = 20
851:             .FontName      = "Tahoma"
852:             .FontSize      = 8
853:             .MaxLength     = 50
854:             .SpecialEffect = 1
855:             .ReadOnly      = .T.
856:             .ForeColor     = RGB(0, 0, 0)
857:             .BorderColor   = RGB(100, 100, 100)
858:         ENDWITH
859: 
860:         *-- Label "Documento :" (Say2: Left=613, Top=191+29=220)
861:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label2", "Documento :", 613, 220)
862:         *-- txt_4c_DOCU (Top=187+29=216, Left=678, Width=80)
863:         loc_oPagina.AddObject("txt_4c_DOCU", "TextBox")
864:         WITH loc_oPagina.txt_4c_DOCU
865:             .Value         = ""
866:             .Left          = 678
867:             .Top           = 216
868:             .Width         = 80
869:             .Height        = 20
870:             .FontName      = "Tahoma"
871:             .FontSize      = 8
872:             .MaxLength     = 20

*-- Linhas 881 a 917:
881:         *======================================================================
882: 
883:         *-- Label "Movimento :" (Say3: Left=49, Top=235+29=264)
884:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label3", "Movimento :", 49, 264)
885:         *-- Label "[D/C]" (Say18: Left=130, Top=264)
886:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label18", "[D/C]", 130, 264)
887: 
888:         *-- txt_4c_OPER (Top=231+29=260, Left=112, Width=15)
889:         loc_oPagina.AddObject("txt_4c_OPER", "TextBox")
890:         WITH loc_oPagina.txt_4c_OPER
891:             .Value         = ""
892:             .Left          = 112
893:             .Top           = 260
894:             .Width         = 15
895:             .Height        = 20
896:             .FontName      = "Tahoma"
897:             .FontSize      = 8
898:             .MaxLength     = 1
899:             .SpecialEffect = 1
900:             .ForeColor     = RGB(0, 0, 0)
901:             .BorderColor   = RGB(100, 100, 100)
902:         ENDWITH
903:         BINDEVENT(loc_oPagina.txt_4c_OPER, "KeyPress", THIS, "OperKeyPress")
904: 
905:         *-- Label "Grupo :" (Say4: Left=72, Top=261+29=290)
906:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label4", "Grupo :", 72, 290)
907:         *-- txt_4c_Grupo (Top=257+29=286, Left=112, Width=80 - F4)
908:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
909:         WITH loc_oPagina.txt_4c_Grupo
910:             .Value         = ""
911:             .Left          = 112
912:             .Top           = 286
913:             .Width         = 80
914:             .Height        = 20
915:             .FontName      = "Tahoma"
916:             .FontSize      = 8
917:             .MaxLength     = 10

*-- Linhas 925 a 953:
925:         loc_oPagina.AddObject("txt_4c_Dgrupo", "TextBox")
926:         WITH loc_oPagina.txt_4c_Dgrupo
927:             .Value         = ""
928:             .Left          = 195
929:             .Top           = 286
930:             .Width         = 290
931:             .Height        = 20
932:             .FontName      = "Tahoma"
933:             .FontSize      = 8
934:             .MaxLength     = 50
935:             .SpecialEffect = 1
936:             .ReadOnly      = .T.
937:             .ForeColor     = RGB(0, 0, 0)
938:             .BorderColor   = RGB(100, 100, 100)
939:         ENDWITH
940: 
941:         *-- Label "Conta :" (Say5: Left=72, Top=287+29=316)
942:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label5", "Conta :", 72, 316)
943:         *-- txt_4c_Conta (Top=283+29=312, Left=112, Width=80 - F4)
944:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
945:         WITH loc_oPagina.txt_4c_Conta
946:             .Value         = ""
947:             .Left          = 112
948:             .Top           = 312
949:             .Width         = 80
950:             .Height        = 20
951:             .FontName      = "Tahoma"
952:             .FontSize      = 8
953:             .MaxLength     = 10

*-- Linhas 961 a 989:
961:         loc_oPagina.AddObject("txt_4c_Dconta", "TextBox")
962:         WITH loc_oPagina.txt_4c_Dconta
963:             .Value         = ""
964:             .Left          = 195
965:             .Top           = 312
966:             .Width         = 290
967:             .Height        = 20
968:             .FontName      = "Tahoma"
969:             .FontSize      = 8
970:             .MaxLength     = 50
971:             .SpecialEffect = 1
972:             .ReadOnly      = .T.
973:             .ForeColor     = RGB(0, 0, 0)
974:             .BorderColor   = RGB(100, 100, 100)
975:         ENDWITH
976: 
977:         *-- Label "Valor :" (Say8: Left=77, Top=313+29=342)
978:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label8", "Valor :", 77, 342)
979:         *-- txt_4c_VALOR (Top=309+29=338, Left=112, Width=128)
980:         loc_oPagina.AddObject("txt_4c_VALOR", "TextBox")
981:         WITH loc_oPagina.txt_4c_VALOR
982:             .Value         = 0
983:             .Left          = 112
984:             .Top           = 338
985:             .Width         = 128
986:             .Height        = 20
987:             .FontName      = "Tahoma"
988:             .FontSize      = 8
989:             .InputMask     = "999,999,999.99"

*-- Linhas 998 a 1092:
998:         loc_oPagina.AddObject("txt_4c_MOEDA", "TextBox")
999:         WITH loc_oPagina.txt_4c_MOEDA
1000:             .Value         = ""
1001:             .Left          = 243
1002:             .Top           = 338
1003:             .Width         = 31
1004:             .Height        = 20
1005:             .FontName      = "Tahoma"
1006:             .FontSize      = 8
1007:             .MaxLength     = 3
1008:             .SpecialEffect = 1
1009:             .ForeColor     = RGB(0, 0, 0)
1010:             .BorderColor   = RGB(100, 100, 100)
1011:         ENDWITH
1012:         BINDEVENT(loc_oPagina.txt_4c_MOEDA, "KeyPress", THIS, "MoedaKeyPress")
1013: 
1014:         *-- Label "Cambio :" (Say_Cotacao: Left=303, Top=313+29=342)
1015:         THIS.AddLabelP2(loc_oPagina, "lbl_4c__Cotacao", "C" + CHR(226) + "mbio :", 303, 342)
1016:         *-- txt_4c_COTACAO (Top=309+29=338, Left=349, Width=108)
1017:         loc_oPagina.AddObject("txt_4c_COTACAO", "TextBox")
1018:         WITH loc_oPagina.txt_4c_COTACAO
1019:             .Value         = 1
1020:             .Left          = 349
1021:             .Top           = 338
1022:             .Width         = 108
1023:             .Height        = 20
1024:             .FontName      = "Tahoma"
1025:             .FontSize      = 8
1026:             .InputMask     = "99,999.9999999"
1027:             .SpecialEffect = 1
1028:             .Alignment     = 3
1029:             .ForeColor     = RGB(0, 0, 0)
1030:             .BorderColor   = RGB(100, 100, 100)
1031:             .Visible       = .F.
1032:         ENDWITH
1033: 
1034:         *-- cmd_4c_Alteracotacao (Top=309+29=338, Left=461, Width=24, Height=23)
1035:         loc_oPagina.AddObject("cmd_4c_Alteracotacao", "CommandButton")
1036:         WITH loc_oPagina.cmd_4c_Alteracotacao
1037:             .Caption       = "$"
1038:             .Top           = 338
1039:             .Left          = 461
1040:             .Width         = 24
1041:             .Height        = 23
1042:             .FontBold      = .T.
1043:             .FontName      = "Tahoma"
1044:             .FontSize      = 12
1045:             .ForeColor     = RGB(90, 90, 90)
1046:             .BackColor     = RGB(255, 255, 255)
1047:             .Themes        = .F.
1048:             .TabStop       = .F.
1049:             .Visible       = .F.
1050:         ENDWITH
1051:         BINDEVENT(loc_oPagina.cmd_4c_Alteracotacao, "Click", THIS, "BtnAlteracotacaoClick")
1052: 
1053:         *======================================================================
1054:         * SECAO CREDITO (direita): SOper, SGrupo, SConta, SValor, SMoeda, SCotacao
1055:         * Shape2 cobre Top=253, Left=504, Width=485
1056:         *======================================================================
1057: 
1058:         *-- Label "Movimento :" (Say11: Left=544, Top=235+29=264)
1059:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label11", "Movimento :", 544, 264)
1060:         *-- Label "[D/C]" (Say14: Left=626, Top=264)
1061:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label14", "[D/C]", 626, 264)
1062: 
1063:         *-- txt_4c_SOPER (Top=231+29=260, Left=607, Width=15)
1064:         loc_oPagina.AddObject("txt_4c_SOPER", "TextBox")
1065:         WITH loc_oPagina.txt_4c_SOPER
1066:             .Value         = ""
1067:             .Left          = 607
1068:             .Top           = 260
1069:             .Width         = 15
1070:             .Height        = 20
1071:             .FontName      = "Tahoma"
1072:             .FontSize      = 8
1073:             .MaxLength     = 1
1074:             .SpecialEffect = 1
1075:             .ReadOnly      = .T.
1076:             .ForeColor     = RGB(0, 0, 0)
1077:             .BorderColor   = RGB(100, 100, 100)
1078:         ENDWITH
1079: 
1080:         *-- Label "Grupo :" (Say12: Left=567, Top=261+29=290)
1081:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label12", "Grupo :", 567, 290)
1082:         *-- txt_4c_SGRUPO (Top=257+29=286, Left=607, Width=80 - F4)
1083:         loc_oPagina.AddObject("txt_4c_SGRUPO", "TextBox")
1084:         WITH loc_oPagina.txt_4c_SGRUPO
1085:             .Value         = ""
1086:             .Left          = 607
1087:             .Top           = 286
1088:             .Width         = 80
1089:             .Height        = 20
1090:             .FontName      = "Tahoma"
1091:             .FontSize      = 8
1092:             .MaxLength     = 10

*-- Linhas 1100 a 1128:
1100:         loc_oPagina.AddObject("txt_4c_Sdgrupo", "TextBox")
1101:         WITH loc_oPagina.txt_4c_Sdgrupo
1102:             .Value         = ""
1103:             .Left          = 689
1104:             .Top           = 286
1105:             .Width         = 290
1106:             .Height        = 20
1107:             .FontName      = "Tahoma"
1108:             .FontSize      = 8
1109:             .MaxLength     = 50
1110:             .SpecialEffect = 1
1111:             .ReadOnly      = .T.
1112:             .ForeColor     = RGB(0, 0, 0)
1113:             .BorderColor   = RGB(100, 100, 100)
1114:         ENDWITH
1115: 
1116:         *-- Label "Conta :" (Say13: Left=567, Top=287+29=316)
1117:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label13", "Conta :", 567, 316)
1118:         *-- txt_4c_SCONTA (Top=283+29=312, Left=607, Width=80 - F4)
1119:         loc_oPagina.AddObject("txt_4c_SCONTA", "TextBox")
1120:         WITH loc_oPagina.txt_4c_SCONTA
1121:             .Value         = ""
1122:             .Left          = 607
1123:             .Top           = 312
1124:             .Width         = 80
1125:             .Height        = 20
1126:             .FontName      = "Tahoma"
1127:             .FontSize      = 8
1128:             .MaxLength     = 10

*-- Linhas 1136 a 1164:
1136:         loc_oPagina.AddObject("txt_4c_SDCONTA", "TextBox")
1137:         WITH loc_oPagina.txt_4c_SDCONTA
1138:             .Value         = ""
1139:             .Left          = 689
1140:             .Top           = 312
1141:             .Width         = 290
1142:             .Height        = 20
1143:             .FontName      = "Tahoma"
1144:             .FontSize      = 8
1145:             .MaxLength     = 50
1146:             .SpecialEffect = 1
1147:             .ReadOnly      = .T.
1148:             .ForeColor     = RGB(0, 0, 0)
1149:             .BorderColor   = RGB(100, 100, 100)
1150:         ENDWITH
1151: 
1152:         *-- Label "Valor :" (Say16: Left=572, Top=313+29=342)
1153:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label16", "Valor :", 572, 342)
1154:         *-- txt_4c_SVALOR (Top=309+29=338, Left=607, Width=128)
1155:         loc_oPagina.AddObject("txt_4c_SVALOR", "TextBox")
1156:         WITH loc_oPagina.txt_4c_SVALOR
1157:             .Value         = 0
1158:             .Left          = 607
1159:             .Top           = 338
1160:             .Width         = 128
1161:             .Height        = 20
1162:             .FontName      = "Tahoma"
1163:             .FontSize      = 8
1164:             .InputMask     = "999,999,999.99"

*-- Linhas 1172 a 1244:
1172:         loc_oPagina.AddObject("txt_4c_Smoeda", "TextBox")
1173:         WITH loc_oPagina.txt_4c_Smoeda
1174:             .Value         = ""
1175:             .Left          = 737
1176:             .Top           = 338
1177:             .Width         = 31
1178:             .Height        = 20
1179:             .FontName      = "Tahoma"
1180:             .FontSize      = 8
1181:             .MaxLength     = 3
1182:             .SpecialEffect = 1
1183:             .ForeColor     = RGB(0, 0, 0)
1184:             .BorderColor   = RGB(100, 100, 100)
1185:         ENDWITH
1186:         BINDEVENT(loc_oPagina.txt_4c_Smoeda, "KeyPress", THIS, "SMoedaKeyPress")
1187: 
1188:         *-- Label "Cambio :" (Say_sCotacao: Left=797, Top=313+29=342)
1189:         THIS.AddLabelP2(loc_oPagina, "lbl_4c__sCotacao", "C" + CHR(226) + "mbio :", 797, 342)
1190:         *-- txt_4c_SCOTACAO (Top=309+29=338, Left=843, Width=108)
1191:         loc_oPagina.AddObject("txt_4c_SCOTACAO", "TextBox")
1192:         WITH loc_oPagina.txt_4c_SCOTACAO
1193:             .Value         = 1
1194:             .Left          = 843
1195:             .Top           = 338
1196:             .Width         = 108
1197:             .Height        = 20
1198:             .FontName      = "Tahoma"
1199:             .FontSize      = 8
1200:             .InputMask     = "99,999.9999999"
1201:             .SpecialEffect = 1
1202:             .Alignment     = 3
1203:             .ForeColor     = RGB(0, 0, 0)
1204:             .BorderColor   = RGB(100, 100, 100)
1205:             .Visible       = .F.
1206:         ENDWITH
1207: 
1208:         *-- cmd_4c_Alterascotacao (Top=309+29=338, Left=955, Width=24, Height=23)
1209:         loc_oPagina.AddObject("cmd_4c_Alterascotacao", "CommandButton")
1210:         WITH loc_oPagina.cmd_4c_Alterascotacao
1211:             .Caption       = "$"
1212:             .Top           = 338
1213:             .Left          = 955
1214:             .Width         = 24
1215:             .Height        = 23
1216:             .FontBold      = .T.
1217:             .FontName      = "Tahoma"
1218:             .FontSize      = 12
1219:             .ForeColor     = RGB(90, 90, 90)
1220:             .BackColor     = RGB(255, 255, 255)
1221:             .Themes        = .F.
1222:             .TabStop       = .F.
1223:             .Visible       = .F.
1224:         ENDWITH
1225:         BINDEVENT(loc_oPagina.cmd_4c_Alterascotacao, "Click", THIS, "BtnAlterascotacaoClick")
1226: 
1227:         *======================================================================
1228:         * SECAO HISTORICO: Hist, Hist2, Opcao_conta
1229:         * Shape6 cobre Top=379, Left=9, Width=980, Height=39
1230:         *======================================================================
1231: 
1232:         *-- Label "Historico :" (Say9: Left=60, Top=362+29=391)
1233:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label9", "Hist" + CHR(243) + "rico :", 60, 391)
1234:         *-- txt_4c_HIST (Top=358+29=387, Left=112, Width=300)
1235:         loc_oPagina.AddObject("txt_4c_HIST", "TextBox")
1236:         WITH loc_oPagina.txt_4c_HIST
1237:             .Value         = ""
1238:             .Left          = 112
1239:             .Top           = 387
1240:             .Width         = 300
1241:             .Height        = 20
1242:             .FontName      = "Tahoma"
1243:             .FontSize      = 8
1244:             .MaxLength     = 50

*-- Linhas 1251 a 1299:
1251:         loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
1252:         WITH loc_oPagina.txt_4c_Hist2
1253:             .Value         = ""
1254:             .Left          = 415
1255:             .Top           = 387
1256:             .Width         = 300
1257:             .Height        = 20
1258:             .FontName      = "Tahoma"
1259:             .FontSize      = 8
1260:             .MaxLength     = 50
1261:             .SpecialEffect = 1
1262:             .ForeColor     = RGB(0, 0, 0)
1263:             .BorderColor   = RGB(100, 100, 100)
1264:         ENDWITH
1265: 
1266:         *-- Label "Lancar Contas :" (Say19: Left=758, Top=362+29=391)
1267:         THIS.AddLabelP2(loc_oPagina, "lbl_4c_Label19", "Lan" + CHR(231) + "ar Contas :", 758, 391)
1268:         *-- OptionGroup Opcao_conta (Top=356+29=385, Left=844, Width=99, Height=27)
1269:         loc_oPagina.AddObject("obj_4c_Opcao_conta", "OptionGroup")
1270:         WITH loc_oPagina.obj_4c_Opcao_conta
1271:             .Top         = 385
1272:             .Left        = 844
1273:             .Width       = 99
1274:             .Height      = 27
1275:             .AutoSize    = .T.
1276:             .BorderStyle = 0
1277:             .ButtonCount = 2
1278:             .Value       = 2
1279: 
1280:             .Buttons(1).Caption   = "Sim"
1281:             .Buttons(1).Left      = 5
1282:             .Buttons(1).Top       = 5
1283:             .Buttons(1).AutoSize  = .F.
1284:             .Buttons(1).Width     = 40
1285:             .Buttons(1).Height    = 17
1286:             .Buttons(1).BackStyle = 0
1287:             .Buttons(1).FontName  = "Tahoma"
1288:             .Buttons(1).FontSize  = 8
1289:             .Buttons(1).ForeColor = RGB(90, 90, 90)
1290:             .Buttons(1).Themes    = .F.
1291: 
1292:             .Buttons(2).Caption   = "N" + CHR(227) + "o"
1293:             .Buttons(2).Left      = 57
1294:             .Buttons(2).Top       = 6
1295:             .Buttons(2).AutoSize  = .T.
1296:             .Buttons(2).BackStyle = 0
1297:             .Buttons(2).FontName  = "Tahoma"
1298:             .Buttons(2).FontSize  = 8
1299:             .Buttons(2).ForeColor = RGB(90, 90, 90)

*-- Linhas 1309 a 1319:
1309:     PROTECTED PROCEDURE AddLabelP2(par_oPagina, par_cNome, par_cCaption, par_nLeft, par_nTop)
1310:         par_oPagina.AddObject(par_cNome, "Label")
1311:         WITH par_oPagina.&par_cNome
1312:             .Caption   = par_cCaption
1313:             .Left      = par_nLeft
1314:             .Top       = par_nTop
1315:             .AutoSize  = .T.
1316:             .Height    = 15
1317:             .FontName  = "Tahoma"
1318:             .FontSize  = 8
1319:             .BackStyle = 0

*-- Linhas 1368 a 1386:
1368:                 loc_oGrade.Column11.ControlSource = "cursor_4c_Dados.docus"
1369: 
1370:                 *-- Redefinir Header1.Caption APOS RecordSource (OBRIGATORIO - Problema 32)
1371:                 loc_oGrade.Column1.Header1.Caption  = "Data"
1372:                 loc_oGrade.Column2.Header1.Caption  = "O"
1373:                 loc_oGrade.Column3.Header1.Caption  = "Conta"
1374:                 loc_oGrade.Column4.Header1.Caption  = "Contrapartida"
1375:                 loc_oGrade.Column5.Header1.Caption  = "Hist" + CHR(243) + "rico"
1376:                 loc_oGrade.Column6.Header1.Caption  = "D" + CHR(233) + "bito"
1377:                 loc_oGrade.Column7.Header1.Caption  = ""
1378:                 loc_oGrade.Column8.Header1.Caption  = "Cr" + CHR(233) + "dito"
1379:                 loc_oGrade.Column9.Header1.Caption  = ""
1380:                 loc_oGrade.Column10.Header1.Caption = "NF"
1381:                 loc_oGrade.Column11.Header1.Caption = "Documento"
1382: 
1383:                 *-- DynamicForeColor: azul para registros conciliados
1384:                 LOCAL loc_cExprFore
1385:                 loc_cExprFore = "IIF(cursor_4c_Dados.concs, RGB(0,0,255), RGB(0,0,0))"
1386:                 loc_oGrade.Column1.DynamicForeColor  = loc_cExprFore

*-- Linhas 1460 a 1490:
1460:             loc_oPagina.txt_4c_Fweditdata_DATA.Value = NVL(.this_dDatas, DATE())
1461:             loc_oPagina.txt_4c_Fweditdata_VENC.Value = NVL(.this_dVencs, {})
1462:             loc_oPagina.txt_4c_DtEmis.Value          = NVL(.this_dDtEmiss, {})
1463:             loc_oPagina.txt_4c_Nota.Value             = .this_cNotas
1464:             loc_oPagina.txt_4c_DOCU.Value             = .this_cDocus
1465:             loc_oPagina.txt_4c_Job.Value              = .this_cJobs
1466:             loc_oPagina.txt_4c_DJob.Value             = .this_cDJobs
1467:             loc_oPagina.txt_4c__Usuario.Value         = .this_cUsuario
1468:             loc_oPagina.txt_4c_OPER.Value             = .this_cOpers
1469:             loc_oPagina.txt_4c_Grupo.Value            = .this_cGrupos
1470:             loc_oPagina.txt_4c_Dgrupo.Value           = .this_cDGrupos
1471:             loc_oPagina.txt_4c_Conta.Value            = .this_cContas
1472:             loc_oPagina.txt_4c_Dconta.Value           = .this_cDContas
1473:             loc_oPagina.txt_4c_VALOR.Value            = .this_nValors
1474:             loc_oPagina.txt_4c_MOEDA.Value            = .this_cMoedas
1475:             loc_oPagina.txt_4c_COTACAO.Value          = .this_nCotacaos
1476:             loc_oPagina.txt_4c_SOPER.Value            = .this_cSopers
1477:             loc_oPagina.txt_4c_SGRUPO.Value           = .this_cSgrupos
1478:             loc_oPagina.txt_4c_Sdgrupo.Value          = .this_cDSgrupos
1479:             loc_oPagina.txt_4c_SCONTA.Value           = .this_cScontas
1480:             loc_oPagina.txt_4c_SDCONTA.Value          = .this_cDScontas
1481:             loc_oPagina.txt_4c_SVALOR.Value           = .this_nSvalors
1482:             loc_oPagina.txt_4c_Smoeda.Value           = .this_cSmoedas
1483:             loc_oPagina.txt_4c_SCOTACAO.Value         = .this_nScotacaos
1484:             loc_oPagina.txt_4c_HIST.Value             = .this_cHists
1485:             loc_oPagina.txt_4c_Hist2.Value            = .this_cHist2s
1486:             IF !EMPTY(.this_nContapgs)
1487:                 loc_oPagina.obj_4c_Opcao_conta.Value = IIF(.this_nContapgs = 1, 1, 2)
1488:             ENDIF
1489:         ENDWITH
1490: 

*-- Linhas 1554 a 1563:
1554:         loc_oPagina.obj_4c_Opcao_conta.Enabled       = par_lHabilitar
1555: 
1556:         *-- Botoes Salvar/Cancelar
1557:         loc_oPagina.cnt_4c_Salvar.cmd_4c_Salvar.Visible  = par_lHabilitar
1558:         loc_oPagina.cnt_4c_Salvar.cmd_4c_Cancelar.Visible = .T.
1559:     ENDPROC
1560: 
1561:     *--------------------------------------------------------------------------
1562:     * AtualizarVisibilidadeCotacao - Controla visibilidade dos campos de cotacao
1563:     * Legado: Verifica crSigCdMoe.Cotas para mostrar/ocultar cotacao

*-- Linhas 1584 a 1593:
1584:         ENDIF
1585: 
1586:         loc_oPagina.txt_4c_COTACAO.Visible         = loc_lCotas
1587:         loc_oPagina.lbl_4c__Cotacao.Visible        = loc_lCotas
1588:         loc_oPagina.cmd_4c_Alteracotacao.Visible   = loc_lCotas AND THIS.this_cModoAtual = "ALTERAR"
1589:     ENDPROC
1590: 
1591:     *--------------------------------------------------------------------------
1592:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1593:     *--------------------------------------------------------------------------

*-- Linhas 2450 a 2459:
2450:         ENDIF
2451: 
2452:         loc_oPagina.txt_4c_SCOTACAO.Visible       = loc_lCotas
2453:         loc_oPagina.lbl_4c__sCotacao.Visible      = loc_lCotas
2454:         loc_oPagina.cmd_4c_Alterascotacao.Visible = loc_lCotas AND THIS.this_cModoAtual = "ALTERAR"
2455:     ENDPROC
2456: 
2457:     *==========================================================================
2458:     * HANDLERS DE LOOKUP - JOB
2459:     *==========================================================================

*-- Linhas 2566 a 2574:
2566:             loc_lMostraAnexa = .F.
2567:         ENDTRY
2568: 
2569:         loc_oPagina.cmd_4c_Anexa.Visible    = loc_lMostraAnexa
2570:         loc_oPagina.shp_4c_ShpAnexa.Visible = loc_lMostraAnexa
2571:     ENDPROC
2572: 
2573:     *==========================================================================
2574:     * UTILITARIOS

*-- Linhas 2585 a 2602:
2585:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2586: 
2587:         *-- Botoes da Page1
2588:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Incluir.Enabled    = .T.
2589:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Visualizar.Enabled = .T.
2590:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Alterar.Enabled    = .T.
2591:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Excluir.Enabled    = .T.
2592:         loc_oPg1.cnt_4c_Botoes.cmd_4c_Buscar.Enabled     = .T.
2593:         loc_oPg1.cnt_4c_Saida.cmd_4c_Encerrar.Enabled    = .T.
2594: 
2595:         *-- Botoes da Page2 (Salvar visivel apenas em edicao)
2596:         loc_oPg2.cnt_4c_Salvar.cmd_4c_Salvar.Visible  = loc_lEditar
2597:         loc_oPg2.cnt_4c_Salvar.cmd_4c_Cancelar.Visible = .T.
2598: 
2599:         *-- Botoes de cotacao visiveis apenas em modo ALTERAR
2600:         THIS.AtualizarVisibilidadeCotacao()
2601:         THIS.AtualizarVisibilidadeSCotacao()
2602:     ENDPROC

*-- Linhas 2627 a 2637:
2627:             loc_oControl = par_oContainer.Controls(i)
2628:             *-- Pular containers com nome especifico que devem permanecer ocultos
2629:             IF PEMSTATUS(loc_oControl, "Name", 5) AND ;
2630:                !INLIST(loc_oControl.Name, "cmd_4c_Anexa", "shp_4c_ShpAnexa", ;
2631:                        "txt_4c_COTACAO", "lbl_4c__Cotacao", "cmd_4c_Alteracotacao", ;
2632:                        "txt_4c_SCOTACAO", "lbl_4c__sCotacao", "cmd_4c_Alterascotacao", ;
2633:                        "cnt_4c_Cabecalho", "cnt_4c_Filtros")
2634:                 loc_oControl.Visible = .T.
2635:             ENDIF
2636: 
2637:             IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND loc_oControl.ControlCount > 0


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*==============================================================================
* sigmvccrBO.prg - Business Object para Movimentos de Conta Corrente Geral
*
* Tabela principal : SigMvCcr
* Chave primaria   : Emps + Nopers (composta)
* Herda de         : BusinessBase
*
* FASE 1/8 - Declaracoes de propriedades e Init()
* Fases seguintes adicionarao: CarregarDoCursor, Inserir, Atualizar,
*   ExecutarExclusao, Buscar, CarregarPorCodigo
*==============================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Identificacao da tabela (nomes CORRETOS do BusinessBase)
    *--------------------------------------------------------------------------
    this_cTabela      = "SigMvCcr"
    this_cCampoChave  = "Nopers"

    *--------------------------------------------------------------------------
    * Chave primaria composta: Emps + Nopers
    *--------------------------------------------------------------------------
    this_cEmps        = ""    && C(3)  - Empresa (parte 1 da PK)
    this_nNopers      = 0     && N     - Numero da Operacao (parte 2 da PK)

    *--------------------------------------------------------------------------
    * Operacao e vinculo com outros documentos
    *--------------------------------------------------------------------------
    this_cOpers       = ""    && C(1)  - Tipo: D=Debito / C=Credito
    this_cSopers      = ""    && C(1)  - Contra-operacao: C/D (espelho)
    this_cDopes       = ""    && C     - Tipo documento debito vinculado
    this_nNumes       = 0     && N     - Numero documento debito vinculado
    this_cDopcs       = ""    && C     - Tipo documento credito vinculado
    this_nNumcs       = 0     && N     - Numero documento credito vinculado
    this_cVOpers      = ""    && C     - Vinculo de operacao externa

    *--------------------------------------------------------------------------
    * Datas
    *--------------------------------------------------------------------------
    this_dDatas       = {}    && T     - Data do lancamento
    this_dVencs       = {}    && T     - Data de vencimento
    this_dDtEmiss     = {}    && T     - Data de emissao
    this_dDatAlts     = {}    && T     - Data de alteracao
    this_dDatExcs     = {}    && T     - Data de exclusao

    *--------------------------------------------------------------------------
    * Lado Debito
    *--------------------------------------------------------------------------
    this_cGrupos      = ""    && C     - Grupo debito
    this_cContas      = ""    && C     - Conta debito
    this_cMoedas      = ""    && C     - Moeda debito
    this_nCotacaos    = 0     && N     - Cotacao debito
    this_nValors      = 0     && N     - Valor debito

    *--------------------------------------------------------------------------
    * Lado Credito (S = S-side / contra-partida)
    *--------------------------------------------------------------------------
    this_cSgrupos     = ""    && C     - Grupo credito
    this_cScontas     = ""    && C     - Conta credito
    this_cSmoedas     = ""    && C     - Moeda credito
    this_nScotacaos   = 0     && N     - Cotacao credito
    this_nSvalors     = 0     && N     - Valor credito

    *--------------------------------------------------------------------------
    * Historico e documentacao
    *--------------------------------------------------------------------------
    this_cHists       = ""    && C     - Historico linha 1
    this_cHist2s      = ""    && C     - Historico linha 2
    this_cNotas       = ""    && C     - Numero da nota fiscal
    this_cDocus       = ""    && C     - Numero do documento

    *--------------------------------------------------------------------------
    * Job / Centro de custo
    *--------------------------------------------------------------------------
    this_cJobs        = ""    && C     - Codigo do job (conta tipo 10)

    *--------------------------------------------------------------------------
    * Campos de controle interno
    *--------------------------------------------------------------------------
    this_lAutos       = .F.   && L     - Flag auto-lancamento
    this_cGruconmoes  = ""    && C     - Concatenacao Grupo+Conta+Moeda
    this_cCidchaves   = ""    && C     - Chave unica do registro (gerada por fGerUniqueKey)
    this_cCotUsus     = ""    && C     - Cotacao definida manualmente pelo usuario
    this_nContapgs    = 0     && N     - Opcao Lancar Contas (0=Nao)
    this_nConcs       = 0     && N     - Flag conciliado

    *--------------------------------------------------------------------------
    * Auditoria
    *--------------------------------------------------------------------------
    this_cUsualts     = ""    && C     - Usuario que fez a ultima alteracao
    this_cUsuExcs     = ""    && C     - Usuario que fez a exclusao

    *--------------------------------------------------------------------------
    * Propriedades de exibicao (lookup - nao armazenadas na tabela SigMvCcr)
    *--------------------------------------------------------------------------
    this_cDGrupos     = ""    && C     - Descricao do grupo debito (SigCdGcr)
    this_cDContas     = ""    && C     - Descricao da conta debito
    this_cDSgrupos    = ""    && C     - Descricao do grupo credito (SigCdGcr)
    this_cDScontas    = ""    && C     - Descricao da conta credito
    this_cUsuario     = ""    && C     - Nome/login do usuario logado (exibicao)
    this_cDJobs       = ""    && C     - Descricao do job (conta tipo 10)

    *--------------------------------------------------------------------------
    * Propriedades de filtro para Buscar() - periodo
    *--------------------------------------------------------------------------
    this_dDtInicial   = {}    && D     - Data inicial para filtro de periodo
    this_dDtFinal     = {}    && D     - Data final para filtro de periodo

    *==========================================================================
    * METODOS
    *==========================================================================

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
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista movimentos de conta corrente filtrados por periodo e WHERE
    * par_cFiltro: clausula WHERE adicional (ex: "a.Datas BETWEEN '...' AND '...'")
    *              Se vazio, usa this_dDtInicial e this_dDtFinal como filtro
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cWhere
        LOCAL loc_cDtI, loc_cDtF
        loc_lResultado = .F.

        IF VARTYPE(par_cFiltro) != "C"
            par_cFiltro = ""
        ENDIF

        TRY
            IF !EMPTY(par_cFiltro)
                loc_cWhere = " WHERE " + par_cFiltro
            ELSE
                *-- Usar datas do BO como filtro
                IF !EMPTY(THIS.this_dDtInicial) AND !EMPTY(THIS.this_dDtFinal)
                    loc_cDtI = FormatarDataSQL(THIS.this_dDtInicial)
                    loc_cDtF = FormatarDataSQL(THIS.this_dDtFinal)
                ELSE
                    *-- Padrao: mes atual
                    loc_cDtI = FormatarDataSQL(DATE() - DAY(DATE()) + 1)
                    loc_cDtF = FormatarDataSQL(DATE())
                ENDIF
                loc_cWhere = " WHERE a.Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                             " AND a.Opers = 'D'" + ;
                             " AND a.Datas BETWEEN " + loc_cDtI + " AND " + loc_cDtF
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.nopers, a.opers, a.datas," + ;
                       " a.contas, a.scontas, a.hists, a.hist2s," + ;
                       " a.valors, a.svalors, a.nfs, a.docus," + ;
                       " a.grupos, a.sgrupos, a.moedas, a.smoedas," + ;
                       " a.concs, a.emps, a.vencs, a.cotacaos," + ;
                       " a.scotacaos, a.contapgs, a.jobs, a.dtemis," + ;
                       " a.sopers, a.tipos" + ;
                       " FROM SigMvCcr a" + loc_cWhere + ;
                       " ORDER BY a.datas, a.nopers"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados") >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar movimentos: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (chave primaria)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidchaves)
        LOCAL loc_lResultado, loc_cSQL
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.nopers, a.opers, a.sopers," + ;
                       " a.dopes, a.numes, a.dopcs, a.numcs, a.vopers," + ;
                       " a.datas, a.vencs, a.dtemis, a.datalts, a.datexcs," + ;
                       " a.grupos, a.contas, a.moedas, a.cotacaos, a.valors," + ;
                       " a.sgrupos, a.scontas, a.smoedas, a.scotacaos, a.svalors," + ;
                       " a.hists, a.hist2s, a.nfs, a.docus, a.jobs," + ;
                       " a.autos, a.gruconmoes, a.cotusus, a.contapgs, a.concs," + ;
                       " a.usualts, a.usuexcs" + ;
                       " FROM SigMvCcr a" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(par_cCidchaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Transfere dados do cursor para propriedades do BO
    * OBRIGATORIO: SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidchaves   = ALLTRIM(TratarNulo(cidchaves,   "C"))
            THIS.this_cEmps        = ALLTRIM(TratarNulo(emps,        "C"))
            THIS.this_nNopers      = TratarNulo(nopers,      "N")
            THIS.this_cOpers       = ALLTRIM(TratarNulo(opers,       "C"))
            THIS.this_cSopers      = ALLTRIM(TratarNulo(sopers,      "C"))
            THIS.this_cDopes       = ALLTRIM(TratarNulo(dopes,       "C"))
            THIS.this_nNumes       = TratarNulo(numes,       "N")
            THIS.this_cDopcs       = ALLTRIM(TratarNulo(dopcs,       "C"))
            THIS.this_nNumcs       = TratarNulo(numcs,       "N")
            THIS.this_cVOpers      = ALLTRIM(TratarNulo(vopers,      "C"))
            THIS.this_dDatas       = TratarNulo(datas,       "D")
            THIS.this_dVencs       = TratarNulo(vencs,       "D")
            THIS.this_dDtEmiss     = TratarNulo(dtemis,      "D")
            THIS.this_dDatAlts     = TratarNulo(datalts,     "D")
            THIS.this_dDatExcs     = TratarNulo(datexcs,     "D")
            THIS.this_cGrupos      = ALLTRIM(TratarNulo(grupos,      "C"))
            THIS.this_cContas      = ALLTRIM(TratarNulo(contas,      "C"))
            THIS.this_cMoedas      = ALLTRIM(TratarNulo(moedas,      "C"))
            THIS.this_nCotacaos    = TratarNulo(cotacaos,    "N")
            THIS.this_nValors      = TratarNulo(valors,      "N")
            THIS.this_cSgrupos     = ALLTRIM(TratarNulo(sgrupos,     "C"))
            THIS.this_cScontas     = ALLTRIM(TratarNulo(scontas,     "C"))
            THIS.this_cSmoedas     = ALLTRIM(TratarNulo(smoedas,     "C"))
            THIS.this_nScotacaos   = TratarNulo(scotacaos,   "N")
            THIS.this_nSvalors     = TratarNulo(svalors,     "N")
            THIS.this_cHists       = ALLTRIM(TratarNulo(hists,       "C"))
            THIS.this_cHist2s      = ALLTRIM(TratarNulo(hist2s,      "C"))
            THIS.this_cNotas       = ALLTRIM(TratarNulo(nfs,         "C"))
            THIS.this_cDocus       = ALLTRIM(TratarNulo(docus,       "C"))
            THIS.this_cJobs        = ALLTRIM(TratarNulo(jobs,        "C"))
            THIS.this_lAutos       = (TratarNulo(autos,      "N") = 1)
            THIS.this_cGruconmoes  = ALLTRIM(TratarNulo(gruconmoes,  "C"))
            THIS.this_cCotUsus     = ALLTRIM(TratarNulo(cotusus,     "C"))
            THIS.this_nContapgs    = TratarNulo(contapgs,    "N")
            THIS.this_nConcs       = TratarNulo(concs,       "N")
            THIS.this_cUsualts     = ALLTRIM(TratarNulo(usualts,     "C"))
            THIS.this_cUsuExcs     = ALLTRIM(TratarNulo(usuexcs,     "C"))
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo movimento de conta corrente
    * Gera nopers sequencial e cidchaves = DTOS(datas)+PADL(nopers,12,'0')
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nNopers, loc_cCidchaves
        LOCAL loc_cDtDados, loc_cDtVencs, loc_cDtEmis, loc_nRes
        loc_lResultado = .F.

        *-- Validacoes fora do TRY
        IF EMPTY(THIS.this_cGrupos) OR EMPTY(THIS.this_cContas)
            MsgErro("Grupo e Conta (D" + CHR(233) + "bito) s" + CHR(227) + "o obrigat" + ;
                    CHR(243) + "rios.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cSgrupos) OR EMPTY(THIS.this_cScontas)
            MsgErro("Grupo e Conta (Cr" + CHR(233) + "dito) s" + CHR(227) + "o obrigat" + ;
                    CHR(243) + "rios.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cOpers)
            MsgErro("O tipo de opera" + CHR(231) + CHR(227) + "o (D/C) " + CHR(233) + ;
                    " obrigat" + CHR(243) + "rio.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Gerar proximo nopers para a empresa
            loc_cSQL = "SELECT ISNULL(MAX(nopers), 0) + 1 AS proxNopers" + ;
                       " FROM SigMvCcr WHERE emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_NextNoper") >= 0
                SELECT cursor_4c_NextNoper
                loc_nNopers = cursor_4c_NextNoper.proxNopers
                IF USED("cursor_4c_NextNoper")
                    USE IN cursor_4c_NextNoper
                ENDIF

                *-- Gerar cidchaves: DTOS(datas) + PADL(nopers,12,'0')
                loc_cDtDados = DTOS(IIF(EMPTY(THIS.this_dDatas), DATE(), THIS.this_dDatas))
                loc_cCidchaves = loc_cDtDados + PADL(TRANSFORM(loc_nNopers), 12, "0")
                THIS.this_cCidchaves = loc_cCidchaves
                THIS.this_nNopers    = loc_nNopers

                *-- Formatar datas para SQL
                loc_cDtDados = FormatarDataSQL(THIS.this_dDatas)
                loc_cDtVencs = FormatarDataSQL(THIS.this_dVencs)
                loc_cDtEmis  = FormatarDataSQL(THIS.this_dDtEmiss)

                *-- gruconmoes = grupos + contas + moedas
                THIS.this_cGruconmoes = ALLTRIM(THIS.this_cGrupos) + ;
                                        ALLTRIM(THIS.this_cContas) + ;
                                        ALLTRIM(THIS.this_cMoedas)

                *-- Montar INSERT com todos os campos NOT NULL da tabela
                loc_cSQL = "INSERT INTO SigMvCcr" + ;
                    " (cidchaves, emps, nopers, opers, sopers," + ;
                    " datas, vencs, dtemis," + ;
                    " grupos, contas, moedas, cotacaos, valors," + ;
                    " sgrupos, scontas, smoedas, scotacaos, svalors," + ;
                    " hists, hist2s, nfs, docus, jobs," + ;
                    " contapgs, concs, autos, usualts, usuexcs," + ;
                    " gruconmoes, cotusus, tipos, shists," + ;
                    " dopes, numes, dopcs, numcs, vopers," + ;
                    " contages, contems, saldocs, saldons, saldos," + ;
                    " valliqs, valocurs, valpags, vlancs," + ;
                    " bcontas, bgrupos, borderos, intconts, nlancs, ntrans," + ;
                    " usuconcs, auditors, valprev," + ;
                    " empdopncs, empdopnums, dopotps," + ;
                    " pagos, usupagos, titcancs, usuconfs," + ;
                    " nopercancs, especienfs, impostos, tpimpostos, titpais," + ;
                    " empccs, locals, titbans, titulos, grupages, grupems)" + ;
                    " VALUES (" + ;
                    EscaparSQL(loc_cCidchaves) + "," + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa) + "," + ;
                    FormatarNumeroSQL(loc_nNopers) + "," + ;
                    EscaparSQL(THIS.this_cOpers) + "," + ;
                    EscaparSQL(THIS.this_cSopers) + "," + ;
                    loc_cDtDados + "," + loc_cDtVencs + "," + loc_cDtEmis + "," + ;
                    EscaparSQL(THIS.this_cGrupos) + "," + ;
                    EscaparSQL(THIS.this_cContas) + "," + ;
                    EscaparSQL(THIS.this_cMoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                    EscaparSQL(THIS.this_cSgrupos) + "," + ;
                    EscaparSQL(THIS.this_cScontas) + "," + ;
                    EscaparSQL(THIS.this_cSmoedas) + "," + ;
                    FormatarNumeroSQL(THIS.this_nScotacaos) + "," + ;
                    FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                    EscaparSQL(THIS.this_cHists) + "," + ;
                    EscaparSQL(THIS.this_cHist2s) + "," + ;
                    EscaparSQL(THIS.this_cNotas) + "," + ;
                    EscaparSQL(THIS.this_cDocus) + "," + ;
                    EscaparSQL(THIS.this_cJobs) + "," + ;
                    FormatarNumeroSQL(THIS.this_nContapgs) + "," + ;
                    FormatarNumeroSQL(THIS.this_nConcs) + "," + ;
                    IIF(THIS.this_lAutos, "1", "0") + "," + ;
                    EscaparSQL(gc_4c_UsuarioLogado) + ",''" + "," + ;
                    EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                    EscaparSQL(THIS.this_cCotUsus) + ",''" + "," + ;
                    "''" + "," + ;
                    EscaparSQL(THIS.this_cDopes) + "," + ;
                    FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                    EscaparSQL(THIS.this_cDopcs) + "," + ;
                    FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                    EscaparSQL(THIS.this_cVOpers) + "," + ;
                    "'','',0,0,0," + ;
                    "0,0,0,''" + "," + ;
                    "'','',0,0,0,0," + ;
                    "'','',0," + ;
                    "'','',''" + "," + ;
                    "'','',0,''," + ;
                    "0,'',0,0,''" + "," + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa) + ",'','','','','')"

                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nRes >= 0
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao inserir movimento: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ELSE
                MsgErro("Erro ao gerar n" + CHR(250) + "mero de opera" + CHR(231) + CHR(227) + "o: " + ;
                        CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza movimento de conta corrente existente
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        LOCAL loc_cDtDados, loc_cDtVencs, loc_cDtEmis
        loc_lResultado = .F.

        *-- Validacoes fora do TRY
        IF EMPTY(THIS.this_cCidchaves)
            MsgErro("Chave do registro n" + CHR(227) + "o informada para atualiza" + ;
                    CHR(231) + CHR(227) + "o.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(THIS.this_cGrupos) OR EMPTY(THIS.this_cContas)
            MsgErro("Grupo e Conta (D" + CHR(233) + "bito) s" + CHR(227) + "o obrigat" + ;
                    CHR(243) + "rios.", "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            *-- Formatar datas para SQL
            loc_cDtDados = FormatarDataSQL(THIS.this_dDatas)
            loc_cDtVencs = FormatarDataSQL(THIS.this_dVencs)
            loc_cDtEmis  = FormatarDataSQL(THIS.this_dDtEmiss)

            *-- Recalcular gruconmoes
            THIS.this_cGruconmoes = ALLTRIM(THIS.this_cGrupos) + ;
                                    ALLTRIM(THIS.this_cContas) + ;
                                    ALLTRIM(THIS.this_cMoedas)

            loc_cSQL = "UPDATE SigMvCcr SET" + ;
                " opers       = " + EscaparSQL(THIS.this_cOpers) + "," + ;
                " sopers      = " + EscaparSQL(THIS.this_cSopers) + "," + ;
                " datas       = " + loc_cDtDados + "," + ;
                " vencs       = " + loc_cDtVencs + "," + ;
                " dtemis      = " + loc_cDtEmis + "," + ;
                " grupos      = " + EscaparSQL(THIS.this_cGrupos) + "," + ;
                " contas      = " + EscaparSQL(THIS.this_cContas) + "," + ;
                " moedas      = " + EscaparSQL(THIS.this_cMoedas) + "," + ;
                " cotacaos    = " + FormatarNumeroSQL(THIS.this_nCotacaos) + "," + ;
                " valors      = " + FormatarNumeroSQL(THIS.this_nValors) + "," + ;
                " sgrupos     = " + EscaparSQL(THIS.this_cSgrupos) + "," + ;
                " scontas     = " + EscaparSQL(THIS.this_cScontas) + "," + ;
                " smoedas     = " + EscaparSQL(THIS.this_cSmoedas) + "," + ;
                " scotacaos   = " + FormatarNumeroSQL(THIS.this_nScotacaos) + "," + ;
                " svalors     = " + FormatarNumeroSQL(THIS.this_nSvalors) + "," + ;
                " hists       = " + EscaparSQL(THIS.this_cHists) + "," + ;
                " hist2s      = " + EscaparSQL(THIS.this_cHist2s) + "," + ;
                " nfs         = " + EscaparSQL(THIS.this_cNotas) + "," + ;
                " docus       = " + EscaparSQL(THIS.this_cDocus) + "," + ;
                " jobs        = " + EscaparSQL(THIS.this_cJobs) + "," + ;
                " contapgs    = " + FormatarNumeroSQL(THIS.this_nContapgs) + "," + ;
                " cotusus     = " + EscaparSQL(THIS.this_cCotUsus) + "," + ;
                " gruconmoes  = " + EscaparSQL(THIS.this_cGruconmoes) + "," + ;
                " dopes       = " + EscaparSQL(THIS.this_cDopes) + "," + ;
                " numes       = " + FormatarNumeroSQL(THIS.this_nNumes) + "," + ;
                " dopcs       = " + EscaparSQL(THIS.this_cDopcs) + "," + ;
                " numcs       = " + FormatarNumeroSQL(THIS.this_nNumcs) + "," + ;
                " vopers      = " + EscaparSQL(THIS.this_cVOpers) + "," + ;
                " datalts     = GETDATE()," + ;
                " usualts     = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nRes >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar movimento: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui movimento: marca DatExcs e deleta o registro
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nRes
        loc_lResultado = .F.

        TRY
            *-- Primeiro: marcar data/usuario de exclusao (soft delete marker)
            loc_cSQL = "UPDATE SigMvCcr" + ;
                       " SET datexcs = GETDATE()," + ;
                       " usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
            loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nRes < 0
                MsgErro("Erro ao marcar exclus" + CHR(227) + "o: " + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Segundo: deletar o registro definitivamente
                loc_cSQL = "DELETE FROM SigMvCcr" + ;
                           " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)
                loc_nRes = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nRes >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lResultado = .T.
                ELSE
                    MsgErro("Erro ao excluir movimento: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

