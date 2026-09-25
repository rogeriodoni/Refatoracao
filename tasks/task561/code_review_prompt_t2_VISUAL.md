# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [GRID-HEADER] Header Caption ' ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Conta, Contrapartida, Histórico, Débito, Crédito, , NF, Documento, O. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' ' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Conta, Contrapartida, Histórico, Débito, Crédito, , NF, Documento, O. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVCCR.Pagina.Lista.cntFiltros.Cnt_periodo): Top original=10 vs migrado 'lbl_4c_Label17' Top=220 (diff=210px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGMVCCR.Pagina.Lista.cntFiltros.Cnt_periodo): Left original=17 vs migrado 'lbl_4c_Label17' Left=84 (diff=67px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigmvccr.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2555 linhas total):

*-- Linhas 57 a 68:
57:                     "Formsigmvccr.InicializarForm")
58:             ELSE
59:                 THIS.ConfigurarPageFrame()
60:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
61:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
62:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Visible = .T.
65:                 THIS.pgf_4c_Paginas.ActivePage = 1
66:                 THIS.this_cModoAtual = "LISTA"
67:                 THIS.CarregarLista()
68: 

*-- Linhas 88 a 107:
88: 
89:         WITH THIS.pgf_4c_Paginas
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = THIS.Width
94:             .Height    = THIS.Height + 29
95:             .Tabs      = .F.
96:             .Visible   = .T.
97: 
98:             .Page1.Caption   = "Lista"
99:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page1.BackColor = RGB(255, 255, 255)
101: 
102:             .Page2.Caption   = "Dados"
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.BackColor = RGB(255, 255, 255)
105:         ENDWITH
106: 
107:         THIS.ConfigurarPaginaLista()

*-- Linhas 121 a 158:
121:         *-- Container Cabecalho (cntSombra no legado)
122:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
123:         WITH loc_oPagina.cnt_4c_Cabecalho
124:             .Top         = 31
125:             .Left        = 0
126:             .Width       = THIS.Width
127:             .Height      = 80
128:             .BackColor   = RGB(100, 100, 100)
129:             .BorderWidth = 0
130:             .Visible     = .T.
131:         ENDWITH
132: 
133:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
134:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
135:             .Caption   = THIS.Caption
136:             .Top       = 15
137:             .Left      = 10
138:             .Width     = 769
139:             .Height    = 40
140:             .FontName  = "Tahoma"
141:             .FontSize  = 16
142:             .FontBold  = .T.
143:             .ForeColor = RGB(0, 0, 0)
144:             .BackStyle = 0
145:             .AutoSize  = .F.
146:             .Visible   = .T.
147:         ENDWITH
148: 
149:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
150:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
151:             .Caption   = THIS.Caption
152:             .Top       = 18
153:             .Left      = 10
154:             .Width     = 769
155:             .Height    = 46
156:             .FontName  = "Tahoma"
157:             .FontSize  = 16
158:             .FontBold  = .T.

*-- Linhas 165 a 396:
165:         *-- Container Botoes CRUD (canonico framework: Left=542, Top=29, Width=390, Height=85)
166:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
167:         WITH loc_oPagina.cnt_4c_Botoes
168:             .Top         = 29
169:             .Left        = 542
170:             .Width       = 390
171:             .Height      = 85
172:             .BackStyle   = 0
173:             .BorderWidth = 0
174:             .Visible     = .T.
175:         ENDWITH
176: 
177:         *-- Botao Incluir
178:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
179:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
180:             .Caption         = "Incluir"
181:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
182:             .PicturePosition = 13
183:             .Top             = 5
184:             .Left            = 5
185:             .Width           = 75
186:             .Height          = 75
187:             .FontName        = "Tahoma"
188:             .FontSize        = 8
189:             .FontBold        = .T.
190:             .FontItalic      = .T.
191:             .ForeColor       = RGB(90, 90, 90)
192:             .BackColor       = RGB(255, 255, 255)
193:             .Themes          = .F.
194:             .SpecialEffect   = 0
195:             .Visible         = .T.
196:         ENDWITH
197:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
198: 
199:         *-- Botao Visualizar
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
210:             .FontSize        = 8
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .ForeColor       = RGB(90, 90, 90)
214:             .BackColor       = RGB(255, 255, 255)
215:             .Themes          = .F.
216:             .SpecialEffect   = 0
217:             .Visible         = .T.
218:         ENDWITH
219:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
220: 
221:         *-- Botao Alterar
222:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
223:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
224:             .Caption         = "Alterar"
225:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:             .PicturePosition = 13
227:             .Top             = 5
228:             .Left            = 155
229:             .Width           = 75
230:             .Height          = 75
231:             .FontName        = "Tahoma"
232:             .FontSize        = 8
233:             .FontBold        = .T.
234:             .FontItalic      = .T.
235:             .ForeColor       = RGB(90, 90, 90)
236:             .BackColor       = RGB(255, 255, 255)
237:             .Themes          = .F.
238:             .SpecialEffect   = 0
239:             .Visible         = .T.
240:         ENDWITH
241:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
242: 
243:         *-- Botao Excluir
244:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
245:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
246:             .Caption         = "Excluir"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 230
251:             .Width           = 75
252:             .Height          = 75
253:             .FontName        = "Tahoma"
254:             .FontSize        = 8
255:             .FontBold        = .T.
256:             .FontItalic      = .T.
257:             .ForeColor       = RGB(90, 90, 90)
258:             .BackColor       = RGB(255, 255, 255)
259:             .Themes          = .F.
260:             .SpecialEffect   = 0
261:             .Visible         = .T.
262:         ENDWITH
263:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
264: 
265:         *-- Botao Buscar
266:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
267:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
268:             .Caption         = "Buscar"
269:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
270:             .PicturePosition = 13
271:             .Top             = 5
272:             .Left            = 305
273:             .Width           = 75
274:             .Height          = 75
275:             .FontName        = "Tahoma"
276:             .FontSize        = 8
277:             .FontBold        = .T.
278:             .FontItalic      = .T.
279:             .ForeColor       = RGB(90, 90, 90)
280:             .BackColor       = RGB(255, 255, 255)
281:             .Themes          = .F.
282:             .SpecialEffect   = 0
283:             .Visible         = .T.
284:         ENDWITH
285:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
286: 
287:         *-- Container de Saida (canonico CLAUDE.md regra #10 - prevalece sobre PILAR 1)
288:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
289:         WITH loc_oPagina.cnt_4c_Saida
290:             .Top         = 29
291:             .Left        = 917
292:             .Width       = 90
293:             .Height      = 85
294:             .BackStyle   = 0
295:             .BorderWidth = 0
296:             .Visible     = .T.
297:         ENDWITH
298: 
299:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
300:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
301:             .Caption         = "Encerrar"
302:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
303:             .PicturePosition = 13
304:             .Top             = 5
305:             .Left            = 5
306:             .Width           = 75
307:             .Height          = 75
308:             .FontName        = "Tahoma"
309:             .FontSize        = 8
310:             .FontBold        = .T.
311:             .FontItalic      = .T.
312:             .ForeColor       = RGB(90, 90, 90)
313:             .BackColor       = RGB(255, 255, 255)
314:             .Themes          = .F.
315:             .SpecialEffect   = 0
316:             .Visible         = .T.
317:         ENDWITH
318:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
319: 
320:         *-- Filtro de periodo (legado: cntFiltros.Top=83, Cnt_periodo Left=14,Top=-3)
321:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
322:         loc_oCnt = loc_oPagina.cnt_4c_Filtros
323:         WITH loc_oCnt
324:             .Top         = 112
325:             .Left        = 5
326:             .Width       = 642
327:             .Height      = 29
328:             .BackStyle   = 0
329:             .BorderWidth = 0
330:             .Visible     = .T.
331:         ENDWITH
332: 
333:         loc_oCnt.AddObject("cnt_4c__periodo", "Container")
334:         loc_oCntP = loc_oCnt.cnt_4c__periodo
335:         WITH loc_oCntP
336:             .Top         = -3
337:             .Left        = 14
338:             .Width       = 271
339:             .Height      = 36
340:             .BackStyle   = 0
341:             .BorderWidth = 0
342:             .Visible     = .T.
343:         ENDWITH
344: 
345:         loc_oCntP.AddObject("lbl_4c_Label1", "Label")
346:         WITH loc_oCntP.lbl_4c_Label1
347:             .Caption   = "Per" + CHR(237) + "odo : "
348:             .Top       = 10
349:             .Left      = 17
350:             .Width     = 54
351:             .Height    = 15
352:             .AutoSize  = .F.
353:             .FontName  = "Tahoma"
354:             .FontSize  = 8
355:             .ForeColor = RGB(90, 90, 90)
356:             .BackStyle = 0
357:             .Visible   = .T.
358:         ENDWITH
359: 
360:         loc_oCntP.AddObject("txt_4c_Dt_inicial", "TextBox")
361:         WITH loc_oCntP.txt_4c_Dt_inicial
362:             .Top       = 6
363:             .Left      = 73
364:             .Width     = 80
365:             .Height    = 21
366:             .Value     = DATE()
367:             .FontName  = "Tahoma"
368:             .FontSize  = 8
369:             .Visible   = .T.
370:         ENDWITH
371:         BINDEVENT(loc_oCntP.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDataInicial")
372: 
373:         loc_oCntP.AddObject("lbl_4c_Label2", "Label")
374:         WITH loc_oCntP.lbl_4c_Label2
375:             .Caption   = "at" + CHR(233)
376:             .Top       = 10
377:             .Left      = 158
378:             .Width     = 20
379:             .Height    = 15
380:             .AutoSize  = .F.
381:             .FontName  = "Tahoma"
382:             .FontSize  = 8
383:             .ForeColor = RGB(90, 90, 90)
384:             .BackStyle = 0
385:             .Visible   = .T.
386:         ENDWITH
387: 
388:         loc_oCntP.AddObject("txt_4c_Dt_final", "TextBox")
389:         WITH loc_oCntP.txt_4c_Dt_final
390:             .Top       = 6
391:             .Left      = 184
392:             .Width     = 80
393:             .Height    = 21
394:             .Value     = DATE()
395:             .FontName  = "Tahoma"
396:             .FontSize  = 8

*-- Linhas 402 a 411:
402:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
403:         loc_oGrid = loc_oPagina.grd_4c_Lista
404:         WITH loc_oGrid
405:             .Top                = 144
406:             .Left               = 23
407:             .Width              = 944
408:             .Height             = 473
409:             .ColumnCount        = 11
410:             .RecordSourceType   = 1
411:             .ReadOnly           = .T.

*-- Linhas 426 a 507:
426:             .Column1.Alignment  = 2
427:             .Column1.FontSize   = 8
428:             .Column1.ReadOnly   = .T.
429:             .Column1.Header1.Caption   = "Data"
430:             .Column1.Header1.Alignment = 2
431:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
432: 
433:             .Column2.Width      = 83
434:             .Column2.FontSize   = 8
435:             .Column2.ReadOnly   = .T.
436:             .Column2.Header1.Caption   = "Conta"
437:             .Column2.Header1.Alignment = 2
438:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
439: 
440:             .Column3.Width      = 83
441:             .Column3.FontSize   = 8
442:             .Column3.ReadOnly   = .T.
443:             .Column3.Header1.Caption   = "Contrapartida"
444:             .Column3.Header1.Alignment = 2
445:             .Column3.Header1.ForeColor = RGB(90, 90, 90)
446: 
447:             .Column4.Width      = 280
448:             .Column4.FontSize   = 7
449:             .Column4.ReadOnly   = .T.
450:             .Column4.Header1.Caption   = "Hist" + CHR(243) + "rico"
451:             .Column4.Header1.Alignment = 2
452:             .Column4.Header1.ForeColor = RGB(90, 90, 90)
453: 
454:             .Column5.Width      = 80
455:             .Column5.FontSize   = 8
456:             .Column5.ReadOnly   = .T.
457:             .Column5.InputMask  = "999,999,999.99"
458:             .Column5.Header1.Caption   = "D" + CHR(233) + "bito"
459:             .Column5.Header1.Alignment = 2
460:             .Column5.Header1.ForeColor = RGB(90, 90, 90)
461: 
462:             .Column6.Width      = 80
463:             .Column6.FontSize   = 8
464:             .Column6.ReadOnly   = .T.
465:             .Column6.InputMask  = "999,999,999.99"
466:             .Column6.Header1.Caption   = "Cr" + CHR(233) + "dito"
467:             .Column6.Header1.Alignment = 2
468:             .Column6.Header1.ForeColor = RGB(90, 90, 90)
469: 
470:             .Column7.Width      = 28
471:             .Column7.FontSize   = 7
472:             .Column7.ReadOnly   = .T.
473:             .Column7.Header1.Caption   = ""
474:             .Column7.Header1.Alignment = 2
475:             .Column7.Header1.ForeColor = RGB(90, 90, 90)
476: 
477:             .Column8.Width      = 28
478:             .Column8.FontSize   = 7
479:             .Column8.ReadOnly   = .T.
480:             .Column8.Header1.Caption   = " "
481:             .Column8.Header1.Alignment = 2
482:             .Column8.Header1.ForeColor = RGB(90, 90, 90)
483: 
484:             .Column9.Width      = 78
485:             .Column9.FontSize   = 8
486:             .Column9.ReadOnly   = .T.
487:             .Column9.Header1.Caption   = "NF"
488:             .Column9.Header1.Alignment = 2
489:             .Column9.Header1.ForeColor = RGB(90, 90, 90)
490: 
491:             .Column10.Width      = 78
492:             .Column10.FontSize   = 8
493:             .Column10.ReadOnly   = .T.
494:             .Column10.Header1.Caption   = "Documento"
495:             .Column10.Header1.Alignment = 2
496:             .Column10.Header1.ForeColor = RGB(90, 90, 90)
497: 
498:             .Column11.Width      = 17
499:             .Column11.Alignment  = 2
500:             .Column11.FontSize   = 8
501:             .Column11.ReadOnly   = .T.
502:             .Column11.Header1.Caption   = "O"
503:             .Column11.Header1.Alignment = 2
504:             .Column11.Header1.ForeColor = RGB(90, 90, 90)
505:         ENDWITH
506: 
507:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 520 a 557:
520:         *-- Cabecalho cinza (identico ao da pagina Lista) - CLAUDE.md regra #11
521:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
522:         WITH loc_oPagina.cnt_4c_Cabecalho
523:             .Top           = 29
524:             .Left          = 0
525:             .Width         = THIS.Width
526:             .Height        = 80
527:             .BackColor     = RGB(100, 100, 100)
528:             .BorderWidth   = 0
529:             .SpecialEffect = 0
530:             .Visible       = .T.
531: 
532:             .AddObject("lbl_4c_Sombra", "Label")
533:             WITH .lbl_4c_Sombra
534:                 .Caption   = THIS.Caption
535:                 .Top       = 15
536:                 .Left      = 10
537:                 .Width     = THIS.Width
538:                 .Height    = 40
539:                 .FontName  = "Tahoma"
540:                 .FontSize  = 16
541:                 .FontBold  = .T.
542:                 .ForeColor = RGB(0, 0, 0)
543:                 .BackStyle = 0
544:                 .AutoSize  = .F.
545:                 .Visible   = .T.
546:             ENDWITH
547: 
548:             .AddObject("lbl_4c_Titulo", "Label")
549:             WITH .lbl_4c_Titulo
550:                 .Caption   = THIS.Caption
551:                 .Top       = 18
552:                 .Left      = 10
553:                 .Width     = THIS.Width
554:                 .Height    = 46
555:                 .FontName  = "Tahoma"
556:                 .FontSize  = 16
557:                 .FontBold  = .T.

*-- Linhas 567 a 1070:
567:         *-- Botoes Confirmar/Cancelar serao adicionados nas proximas fases
568:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
569:         WITH loc_oPagina.cnt_4c_BotoesAcao
570:             .Top       = 33
571:             .Left      = 842
572:             .Width     = 160
573:             .Height    = 85
574:             .BackStyle = 0
575:             .BackColor   = RGB(255, 255, 255)
576:             .BorderWidth = 0
577:             .Visible     = .T.
578:         ENDWITH
579: 
580:         *-- Botao Confirmar
581:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
582:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
583:             .Caption         = "Confirmar"
584:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
585:             .PicturePosition = 13
586:             .Top             = 5
587:             .Left            = 5
588:             .Width           = 75
589:             .Height          = 75
590:             .FontName        = "Tahoma"
591:             .FontSize        = 8
592:             .FontBold        = .T.
593:             .FontItalic      = .T.
594:             .ForeColor       = RGB(90, 90, 90)
595:             .BackColor       = RGB(255, 255, 255)
596:             .Themes          = .F.
597:             .SpecialEffect   = 0
598:             .Visible         = .T.
599:         ENDWITH
600:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
601: 
602:         *-- Botao Cancelar
603:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
604:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
605:             .Caption         = "Encerrar"
606:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
607:             .PicturePosition = 13
608:             .Top             = 5
609:             .Left            = 80
610:             .Width           = 75
611:             .Height          = 75
612:             .FontName        = "Tahoma"
613:             .FontSize        = 8
614:             .FontBold        = .T.
615:             .FontItalic      = .T.
616:             .ForeColor       = RGB(90, 90, 90)
617:             .BackColor       = RGB(255, 255, 255)
618:             .Themes          = .F.
619:             .SpecialEffect   = 0
620:             .Visible         = .T.
621:         ENDWITH
622:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
623: 
624:         *-- Shape1 (legado Top=153,Left=9,Width=980,Height=64) - moldura da linha superior
625:         loc_oPagina.AddObject("shp_4c_Shape1", "Shape")
626:         WITH loc_oPagina.shp_4c_Shape1
627:             .Top    = 182
628:             .Left   = 9
629:             .Width  = 980
630:             .Height = 64
631:             .Visible = .T.
632:         ENDWITH
633: 
634:         *-- Shape3 (legado Top=224,Left=9,Width=485,Height=117) - moldura do painel D (lado esquerdo)
635:         loc_oPagina.AddObject("shp_4c_Shape3", "Shape")
636:         WITH loc_oPagina.shp_4c_Shape3
637:             .Top    = 253
638:             .Left   = 9
639:             .Width  = 485
640:             .Height = 117
641:             .Visible = .T.
642:         ENDWITH
643: 
644:         *-- Linha superior: Lancamento / Vencimento / Emissao / Nota Fiscal / Documento / Usuario / Job
645:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
646:         WITH loc_oPagina.lbl_4c_Label1
647:             .Caption   = "Lan" + CHR(231) + "amento :"
648:             .Top       = 194
649:             .Left      = 43
650:             .Width     = 65
651:             .Height    = 15
652:             .AutoSize  = .F.
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .ForeColor = RGB(90, 90, 90)
656:             .BackStyle = 0
657:             .Visible   = .T.
658:         ENDWITH
659: 
660:         loc_oPagina.AddObject("txt_4c_Fweditdata_DATA", "TextBox")
661:         WITH loc_oPagina.txt_4c_Fweditdata_DATA
662:             .Top      = 190
663:             .Left     = 112
664:             .Width    = 80
665:             .Height   = 21
666:             .Value    = {}
667:             .FontName = "Tahoma"
668:             .FontSize = 8
669:             .Visible  = .T.
670:         ENDWITH
671: 
672:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
673:         WITH loc_oPagina.lbl_4c_Label10
674:             .Caption   = "Vencimento :"
675:             .Top       = 194
676:             .Left      = 234
677:             .Width     = 62
678:             .Height    = 15
679:             .AutoSize  = .F.
680:             .FontName  = "Tahoma"
681:             .FontSize  = 8
682:             .ForeColor = RGB(90, 90, 90)
683:             .BackStyle = 0
684:             .Visible   = .T.
685:         ENDWITH
686: 
687:         loc_oPagina.AddObject("txt_4c_Fweditdata_VENC", "TextBox")
688:         WITH loc_oPagina.txt_4c_Fweditdata_VENC
689:             .Top      = 190
690:             .Left     = 300
691:             .Width    = 80
692:             .Height   = 21
693:             .Value    = {}
694:             .FontName = "Tahoma"
695:             .FontSize = 8
696:             .Visible  = .T.
697:         ENDWITH
698: 
699:         loc_oPagina.AddObject("lbl_4c_Label15", "Label")
700:         WITH loc_oPagina.lbl_4c_Label15
701:             .Caption   = "Emiss" + CHR(227) + "o :"
702:             .Top       = 194
703:             .Left      = 435
704:             .Width     = 45
705:             .Height    = 15
706:             .AutoSize  = .F.
707:             .FontName  = "Tahoma"
708:             .FontSize  = 8
709:             .ForeColor = RGB(90, 90, 90)
710:             .BackStyle = 0
711:             .Visible   = .T.
712:         ENDWITH
713: 
714:         loc_oPagina.AddObject("txt_4c_DtEmis", "TextBox")
715:         WITH loc_oPagina.txt_4c_DtEmis
716:             .Top      = 190
717:             .Left     = 484
718:             .Width    = 80
719:             .Height   = 21
720:             .Value    = {}
721:             .FontName = "Tahoma"
722:             .FontSize = 8
723:             .Visible  = .T.
724:         ENDWITH
725: 
726:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
727:         WITH loc_oPagina.lbl_4c_Label7
728:             .Caption   = "Nota Fiscal :"
729:             .Top       = 194
730:             .Left      = 615
731:             .Width     = 59
732:             .Height    = 15
733:             .AutoSize  = .F.
734:             .FontName  = "Tahoma"
735:             .FontSize  = 8
736:             .ForeColor = RGB(90, 90, 90)
737:             .BackStyle = 0
738:             .Visible   = .T.
739:         ENDWITH
740: 
741:         loc_oPagina.AddObject("txt_4c_Nota", "TextBox")
742:         WITH loc_oPagina.txt_4c_Nota
743:             .Top       = 190
744:             .Left      = 678
745:             .Width     = 80
746:             .Height    = 21
747:             .Value     = ""
748:             .MaxLength = 10
749:             .FontName  = "Tahoma"
750:             .FontSize  = 8
751:             .Visible   = .T.
752:         ENDWITH
753: 
754:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
755:         WITH loc_oPagina.lbl_4c_Label6
756:             .Caption   = "Usu" + CHR(225) + "rio :"
757:             .Top       = 194
758:             .Left      = 818
759:             .Width     = 43
760:             .Height    = 15
761:             .AutoSize  = .F.
762:             .FontName  = "Tahoma"
763:             .FontSize  = 8
764:             .ForeColor = RGB(90, 90, 90)
765:             .BackStyle = 0
766:             .Visible   = .T.
767:         ENDWITH
768: 
769:         loc_oPagina.AddObject("txt_4c__Usuario", "TextBox")
770:         WITH loc_oPagina.txt_4c__Usuario
771:             .Top       = 190
772:             .Left      = 865
773:             .Width     = 80
774:             .Height    = 21
775:             .Value     = ""
776:             .MaxLength = 10
777:             .ReadOnly  = .T.
778:             .FontName  = "Tahoma"
779:             .FontSize  = 8
780:             .Visible   = .T.
781:         ENDWITH
782: 
783:         loc_oPagina.AddObject("lbl_4c_Label17", "Label")
784:         WITH loc_oPagina.lbl_4c_Label17
785:             .Caption   = "Job :"
786:             .Top       = 220
787:             .Left      = 84
788:             .Width     = 24
789:             .Height    = 15
790:             .AutoSize  = .F.
791:             .FontName  = "Tahoma"
792:             .FontSize  = 8
793:             .ForeColor = RGB(90, 90, 90)
794:             .BackStyle = 0
795:             .Visible   = .T.
796:         ENDWITH
797: 
798:         loc_oPagina.AddObject("txt_4c_Job", "TextBox")
799:         WITH loc_oPagina.txt_4c_Job
800:             .Top       = 216
801:             .Left      = 112
802:             .Width     = 80
803:             .Height    = 23
804:             .Value     = ""
805:             .MaxLength = 10
806:             .FontName  = "Tahoma"
807:             .FontSize  = 8
808:             .Visible   = .T.
809:         ENDWITH
810: 
811:         loc_oPagina.AddObject("txt_4c_DJob", "TextBox")
812:         WITH loc_oPagina.txt_4c_DJob
813:             .Top       = 216
814:             .Left      = 195
815:             .Width     = 290
816:             .Height    = 23
817:             .Value     = ""
818:             .MaxLength = 60
819:             .ReadOnly  = .T.
820:             .FontName  = "Tahoma"
821:             .FontSize  = 8
822:             .Visible   = .T.
823:         ENDWITH
824: 
825:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
826:         WITH loc_oPagina.lbl_4c_Label2
827:             .Caption   = "Documento :"
828:             .Top       = 220
829:             .Left      = 613
830:             .Width     = 61
831:             .Height    = 15
832:             .AutoSize  = .F.
833:             .FontName  = "Tahoma"
834:             .FontSize  = 8
835:             .ForeColor = RGB(90, 90, 90)
836:             .BackStyle = 0
837:             .Visible   = .T.
838:         ENDWITH
839: 
840:         loc_oPagina.AddObject("txt_4c_DOCU", "TextBox")
841:         WITH loc_oPagina.txt_4c_DOCU
842:             .Top       = 216
843:             .Left      = 678
844:             .Width     = 80
845:             .Height    = 21
846:             .Value     = ""
847:             .MaxLength = 10
848:             .FontName  = "Tahoma"
849:             .FontSize  = 8
850:             .Visible   = .T.
851:         ENDWITH
852: 
853:         *-- Painel D (lado esquerdo, dentro de shp_4c_Shape3): Movimento/Grupo/Conta/Valor/Moeda/Cambio
854:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
855:         WITH loc_oPagina.lbl_4c_Label3
856:             .Caption   = "Movimento :"
857:             .Top       = 264
858:             .Left      = 49
859:             .Width     = 59
860:             .Height    = 15
861:             .AutoSize  = .F.
862:             .FontName  = "Tahoma"
863:             .FontSize  = 8
864:             .ForeColor = RGB(90, 90, 90)
865:             .BackStyle = 0
866:             .Visible   = .T.
867:         ENDWITH
868: 
869:         loc_oPagina.AddObject("txt_4c_OPER", "TextBox")
870:         WITH loc_oPagina.txt_4c_OPER
871:             .Top       = 260
872:             .Left      = 112
873:             .Width     = 15
874:             .Height    = 21
875:             .Value     = ""
876:             .MaxLength = 1
877:             .InputMask = "!"
878:             .FontName  = "Tahoma"
879:             .FontSize  = 8
880:             .Visible   = .T.
881:         ENDWITH
882: 
883:         loc_oPagina.AddObject("lbl_4c_Label18", "Label")
884:         WITH loc_oPagina.lbl_4c_Label18
885:             .Caption   = "[D/C]"
886:             .Top       = 264
887:             .Left      = 130
888:             .Width     = 40
889:             .Height    = 15
890:             .AutoSize  = .F.
891:             .FontName  = "Tahoma"
892:             .FontSize  = 8
893:             .ForeColor = RGB(90, 90, 90)
894:             .BackStyle = 0
895:             .Visible   = .T.
896:         ENDWITH
897: 
898:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
899:         WITH loc_oPagina.lbl_4c_Label4
900:             .Caption   = "Grupo :"
901:             .Top       = 290
902:             .Left      = 72
903:             .Width     = 36
904:             .Height    = 15
905:             .AutoSize  = .F.
906:             .FontName  = "Tahoma"
907:             .FontSize  = 8
908:             .ForeColor = RGB(90, 90, 90)
909:             .BackStyle = 0
910:             .Visible   = .T.
911:         ENDWITH
912: 
913:         loc_oPagina.AddObject("txt_4c_Grupo", "TextBox")
914:         WITH loc_oPagina.txt_4c_Grupo
915:             .Top       = 286
916:             .Left      = 112
917:             .Width     = 80
918:             .Height    = 23
919:             .Value     = ""
920:             .MaxLength = 10
921:             .FontName  = "Tahoma"
922:             .FontSize  = 8
923:             .Visible   = .T.
924:         ENDWITH
925: 
926:         loc_oPagina.AddObject("txt_4c_Dgrupo", "TextBox")
927:         WITH loc_oPagina.txt_4c_Dgrupo
928:             .Top       = 286
929:             .Left      = 195
930:             .Width     = 290
931:             .Height    = 21
932:             .Value     = ""
933:             .MaxLength = 40
934:             .ReadOnly  = .T.
935:             .FontName  = "Tahoma"
936:             .FontSize  = 8
937:             .Visible   = .T.
938:         ENDWITH
939: 
940:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
941:         WITH loc_oPagina.lbl_4c_Label5
942:             .Caption   = "Conta :"
943:             .Top       = 316
944:             .Left      = 72
945:             .Width     = 36
946:             .Height    = 15
947:             .AutoSize  = .F.
948:             .FontName  = "Tahoma"
949:             .FontSize  = 8
950:             .ForeColor = RGB(90, 90, 90)
951:             .BackStyle = 0
952:             .Visible   = .T.
953:         ENDWITH
954: 
955:         loc_oPagina.AddObject("txt_4c_Conta", "TextBox")
956:         WITH loc_oPagina.txt_4c_Conta
957:             .Top       = 312
958:             .Left      = 112
959:             .Width     = 80
960:             .Height    = 21
961:             .Value     = ""
962:             .MaxLength = 10
963:             .FontName  = "Tahoma"
964:             .FontSize  = 8
965:             .Visible   = .T.
966:         ENDWITH
967: 
968:         loc_oPagina.AddObject("txt_4c_Dconta", "TextBox")
969:         WITH loc_oPagina.txt_4c_Dconta
970:             .Top       = 312
971:             .Left      = 195
972:             .Width     = 290
973:             .Height    = 21
974:             .Value     = ""
975:             .MaxLength = 40
976:             .ReadOnly  = .T.
977:             .FontName  = "Tahoma"
978:             .FontSize  = 8
979:             .Visible   = .T.
980:         ENDWITH
981: 
982:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
983:         WITH loc_oPagina.lbl_4c_Label8
984:             .Caption   = "Valor :"
985:             .Top       = 342
986:             .Left      = 77
987:             .Width     = 31
988:             .Height    = 15
989:             .AutoSize  = .F.
990:             .FontName  = "Tahoma"
991:             .FontSize  = 8
992:             .ForeColor = RGB(90, 90, 90)
993:             .BackStyle = 0
994:             .Visible   = .T.
995:         ENDWITH
996: 
997:         loc_oPagina.AddObject("txt_4c_VALOR", "TextBox")
998:         WITH loc_oPagina.txt_4c_VALOR
999:             .Top       = 338
1000:             .Left      = 112
1001:             .Width     = 128
1002:             .Height    = 23
1003:             .Value     = 0
1004:             .InputMask = "999,999,999.99"
1005:             .FontName  = "Tahoma"
1006:             .FontSize  = 8
1007:             .Visible   = .T.
1008:         ENDWITH
1009: 
1010:         loc_oPagina.AddObject("txt_4c_MOEDA", "TextBox")
1011:         WITH loc_oPagina.txt_4c_MOEDA
1012:             .Top       = 338
1013:             .Left      = 243
1014:             .Width     = 31
1015:             .Height    = 21
1016:             .Value     = ""
1017:             .MaxLength = 3
1018:             .FontName  = "Tahoma"
1019:             .FontSize  = 8
1020:             .Visible   = .T.
1021:         ENDWITH
1022: 
1023:         loc_oPagina.AddObject("lbl_4c__Cotacao", "Label")
1024:         WITH loc_oPagina.lbl_4c__Cotacao
1025:             .Caption   = "C" + CHR(226) + "mbio :"
1026:             .Top       = 342
1027:             .Left      = 303
1028:             .Width     = 42
1029:             .Height    = 15
1030:             .AutoSize  = .F.
1031:             .FontName  = "Tahoma"
1032:             .FontSize  = 8
1033:             .ForeColor = RGB(90, 90, 90)
1034:             .BackStyle = 0
1035:             .Visible   = .T.
1036:         ENDWITH
1037: 
1038:         loc_oPagina.AddObject("txt_4c_COTACAO", "TextBox")
1039:         WITH loc_oPagina.txt_4c_COTACAO
1040:             .Top       = 338
1041:             .Left      = 349
1042:             .Width     = 108
1043:             .Height    = 21
1044:             .Value     = 0
1045:             .InputMask = "999,999.9999999"
1046:             .FontName  = "Tahoma"
1047:             .FontSize  = 8
1048:             .Visible   = .T.
1049:         ENDWITH
1050: 
1051:         loc_oPagina.AddObject("cmd_4c_Alteracotacao", "CommandButton")
1052:         WITH loc_oPagina.cmd_4c_Alteracotacao
1053:             .Caption   = "$"
1054:             .Top       = 338
1055:             .Left      = 461
1056:             .Width     = 24
1057:             .Height    = 23
1058:             .FontName  = "Tahoma"
1059:             .FontSize  = 8
1060:             .FontBold  = .T.
1061:             .ForeColor = RGB(90, 90, 90)
1062:             .Themes    = .F.
1063:             .Visible   = .T.
1064:         ENDWITH
1065:         BINDEVENT(loc_oPagina.cmd_4c_Alteracotacao, "Click", THIS, "BtnAlterarCotacaoClick")
1066: 
1067:         *-- BINDEVENTs dos campos ja criados nesta pagina (Grupo/Conta/Moeda/
1068:         *-- Valor/Cotacao/Job) - LostFocus reproduz o Valid do legado
1069:         BINDEVENT(loc_oPagina.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
1070:         BINDEVENT(loc_oPagina.txt_4c_Conta, "KeyPress", THIS, "ValidarConta")

*-- Linhas 1078 a 1372:
1078:         *-- painel S (contrapartida)
1079:         loc_oPagina.AddObject("shp_4c_Shape2", "Shape")
1080:         WITH loc_oPagina.shp_4c_Shape2
1081:             .Top     = 253
1082:             .Left    = 504
1083:             .Width   = 485
1084:             .Height  = 117
1085:             .Visible = .T.
1086:         ENDWITH
1087: 
1088:         *-- Painel S (lado direito, dentro de shp_4c_Shape2): Movimento/Grupo/
1089:         *-- Conta/Valor/Moeda/Cambio da contrapartida (espelho do painel D)
1090:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
1091:         WITH loc_oPagina.lbl_4c_Label11
1092:             .Caption   = "Movimento :"
1093:             .Top       = 264
1094:             .Left      = 544
1095:             .Width     = 59
1096:             .Height    = 15
1097:             .AutoSize  = .F.
1098:             .FontName  = "Tahoma"
1099:             .FontSize  = 8
1100:             .ForeColor = RGB(90, 90, 90)
1101:             .BackStyle = 0
1102:             .Visible   = .T.
1103:         ENDWITH
1104: 
1105:         loc_oPagina.AddObject("txt_4c_SOPER", "TextBox")
1106:         WITH loc_oPagina.txt_4c_SOPER
1107:             .Top       = 260
1108:             .Left      = 607
1109:             .Width     = 15
1110:             .Height    = 21
1111:             .Value     = ""
1112:             .MaxLength = 1
1113:             .ReadOnly  = .T.
1114:             .FontName  = "Tahoma"
1115:             .FontSize  = 8
1116:             .Visible   = .T.
1117:         ENDWITH
1118: 
1119:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
1120:         WITH loc_oPagina.lbl_4c_Label14
1121:             .Caption   = "[D/C]"
1122:             .Top       = 264
1123:             .Left      = 626
1124:             .Width     = 40
1125:             .Height    = 15
1126:             .AutoSize  = .F.
1127:             .FontName  = "Tahoma"
1128:             .FontSize  = 8
1129:             .ForeColor = RGB(90, 90, 90)
1130:             .BackStyle = 0
1131:             .Visible   = .T.
1132:         ENDWITH
1133: 
1134:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
1135:         WITH loc_oPagina.lbl_4c_Label12
1136:             .Caption   = "Grupo :"
1137:             .Top       = 290
1138:             .Left      = 567
1139:             .Width     = 36
1140:             .Height    = 15
1141:             .AutoSize  = .F.
1142:             .FontName  = "Tahoma"
1143:             .FontSize  = 8
1144:             .ForeColor = RGB(90, 90, 90)
1145:             .BackStyle = 0
1146:             .Visible   = .T.
1147:         ENDWITH
1148: 
1149:         loc_oPagina.AddObject("txt_4c_SGRUPO", "TextBox")
1150:         WITH loc_oPagina.txt_4c_SGRUPO
1151:             .Top       = 286
1152:             .Left      = 607
1153:             .Width     = 80
1154:             .Height    = 23
1155:             .Value     = ""
1156:             .MaxLength = 10
1157:             .FontName  = "Tahoma"
1158:             .FontSize  = 8
1159:             .Visible   = .T.
1160:         ENDWITH
1161:         BINDEVENT(loc_oPagina.txt_4c_SGRUPO, "KeyPress", THIS, "ValidarSGrupo")
1162: 
1163:         loc_oPagina.AddObject("txt_4c_Sdgrupo", "TextBox")
1164:         WITH loc_oPagina.txt_4c_Sdgrupo
1165:             .Top       = 286
1166:             .Left      = 689
1167:             .Width     = 290
1168:             .Height    = 21
1169:             .Value     = ""
1170:             .MaxLength = 40
1171:             .ReadOnly  = .T.
1172:             .FontName  = "Tahoma"
1173:             .FontSize  = 8
1174:             .Visible   = .T.
1175:         ENDWITH
1176: 
1177:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
1178:         WITH loc_oPagina.lbl_4c_Label13
1179:             .Caption   = "Conta :"
1180:             .Top       = 316
1181:             .Left      = 567
1182:             .Width     = 36
1183:             .Height    = 15
1184:             .AutoSize  = .F.
1185:             .FontName  = "Tahoma"
1186:             .FontSize  = 8
1187:             .ForeColor = RGB(90, 90, 90)
1188:             .BackStyle = 0
1189:             .Visible   = .T.
1190:         ENDWITH
1191: 
1192:         loc_oPagina.AddObject("txt_4c_SCONTA", "TextBox")
1193:         WITH loc_oPagina.txt_4c_SCONTA
1194:             .Top       = 312
1195:             .Left      = 607
1196:             .Width     = 80
1197:             .Height    = 21
1198:             .Value     = ""
1199:             .MaxLength = 10
1200:             .FontName  = "Tahoma"
1201:             .FontSize  = 8
1202:             .Visible   = .T.
1203:         ENDWITH
1204:         BINDEVENT(loc_oPagina.txt_4c_SCONTA, "KeyPress", THIS, "ValidarSConta")
1205: 
1206:         loc_oPagina.AddObject("txt_4c_SDCONTA", "TextBox")
1207:         WITH loc_oPagina.txt_4c_SDCONTA
1208:             .Top       = 312
1209:             .Left      = 689
1210:             .Width     = 290
1211:             .Height    = 21
1212:             .Value     = ""
1213:             .MaxLength = 50
1214:             .ReadOnly  = .T.
1215:             .FontName  = "Tahoma"
1216:             .FontSize  = 8
1217:             .Visible   = .T.
1218:         ENDWITH
1219:         BINDEVENT(loc_oPagina.txt_4c_SDCONTA, "KeyPress", THIS, "ValidarSDconta")
1220: 
1221:         loc_oPagina.AddObject("lbl_4c_Label16", "Label")
1222:         WITH loc_oPagina.lbl_4c_Label16
1223:             .Caption   = "Valor :"
1224:             .Top       = 342
1225:             .Left      = 572
1226:             .Width     = 31
1227:             .Height    = 15
1228:             .AutoSize  = .F.
1229:             .FontName  = "Tahoma"
1230:             .FontSize  = 8
1231:             .ForeColor = RGB(90, 90, 90)
1232:             .BackStyle = 0
1233:             .Visible   = .T.
1234:         ENDWITH
1235: 
1236:         loc_oPagina.AddObject("txt_4c_SVALOR", "TextBox")
1237:         WITH loc_oPagina.txt_4c_SVALOR
1238:             .Top       = 338
1239:             .Left      = 607
1240:             .Width     = 128
1241:             .Height    = 23
1242:             .Value     = 0
1243:             .InputMask = "999,999,999.99"
1244:             .FontName  = "Tahoma"
1245:             .FontSize  = 8
1246:             .Visible   = .T.
1247:         ENDWITH
1248:         BINDEVENT(loc_oPagina.txt_4c_SVALOR, "KeyPress", THIS, "ValidarSValor")
1249: 
1250:         loc_oPagina.AddObject("txt_4c_Smoeda", "TextBox")
1251:         WITH loc_oPagina.txt_4c_Smoeda
1252:             .Top       = 338
1253:             .Left      = 737
1254:             .Width     = 31
1255:             .Height    = 21
1256:             .Value     = ""
1257:             .MaxLength = 3
1258:             .FontName  = "Tahoma"
1259:             .FontSize  = 8
1260:             .Visible   = .T.
1261:         ENDWITH
1262:         BINDEVENT(loc_oPagina.txt_4c_Smoeda, "KeyPress", THIS, "ValidarSmoeda")
1263: 
1264:         loc_oPagina.AddObject("lbl_4c__sCotacao", "Label")
1265:         WITH loc_oPagina.lbl_4c__sCotacao
1266:             .Caption   = "C" + CHR(226) + "mbio :"
1267:             .Top       = 342
1268:             .Left      = 797
1269:             .Width     = 42
1270:             .Height    = 15
1271:             .AutoSize  = .F.
1272:             .FontName  = "Tahoma"
1273:             .FontSize  = 8
1274:             .ForeColor = RGB(90, 90, 90)
1275:             .BackStyle = 0
1276:             .Visible   = .T.
1277:         ENDWITH
1278: 
1279:         loc_oPagina.AddObject("txt_4c_SCOTACAO", "TextBox")
1280:         WITH loc_oPagina.txt_4c_SCOTACAO
1281:             .Top       = 338
1282:             .Left      = 843
1283:             .Width     = 108
1284:             .Height    = 21
1285:             .Value     = 0
1286:             .InputMask = "999,999.9999999"
1287:             .FontName  = "Tahoma"
1288:             .FontSize  = 8
1289:             .Visible   = .T.
1290:         ENDWITH
1291:         BINDEVENT(loc_oPagina.txt_4c_SCOTACAO, "KeyPress", THIS, "ValidarSCotacao")
1292: 
1293:         loc_oPagina.AddObject("cmd_4c_Alterascotacao", "CommandButton")
1294:         WITH loc_oPagina.cmd_4c_Alterascotacao
1295:             .Caption   = "$"
1296:             .Top       = 338
1297:             .Left      = 955
1298:             .Width     = 24
1299:             .Height    = 23
1300:             .FontName  = "Tahoma"
1301:             .FontSize  = 8
1302:             .FontBold  = .T.
1303:             .ForeColor = RGB(90, 90, 90)
1304:             .Themes    = .F.
1305:             .Visible   = .T.
1306:         ENDWITH
1307:         BINDEVENT(loc_oPagina.cmd_4c_Alterascotacao, "Click", THIS, "BtnAlterarSCotacaoClick")
1308: 
1309:         *-- Shape6 (legado Top=350,Left=9,Width=980,Height=39) - moldura do
1310:         *-- historico (Get_HIST + Get_Hist2 + Lancar Contas)
1311:         loc_oPagina.AddObject("shp_4c_Shape6", "Shape")
1312:         WITH loc_oPagina.shp_4c_Shape6
1313:             .Top     = 379
1314:             .Left    = 9
1315:             .Width   = 980
1316:             .Height  = 39
1317:             .Visible = .T.
1318:         ENDWITH
1319: 
1320:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
1321:         WITH loc_oPagina.lbl_4c_Label9
1322:             .Caption   = "Hist" + CHR(243) + "rico :"
1323:             .Top       = 391
1324:             .Left      = 60
1325:             .Width     = 52
1326:             .Height    = 15
1327:             .AutoSize  = .F.
1328:             .FontName  = "Tahoma"
1329:             .FontSize  = 8
1330:             .ForeColor = RGB(90, 90, 90)
1331:             .BackStyle = 0
1332:             .Visible   = .T.
1333:         ENDWITH
1334: 
1335:         loc_oPagina.AddObject("txt_4c_HIST", "TextBox")
1336:         WITH loc_oPagina.txt_4c_HIST
1337:             .Top       = 387
1338:             .Left      = 112
1339:             .Width     = 300
1340:             .Height    = 21
1341:             .Value     = ""
1342:             .MaxLength = 60
1343:             .Format    = "K!"
1344:             .FontName  = "Tahoma"
1345:             .FontSize  = 8
1346:             .Visible   = .T.
1347:         ENDWITH
1348: 
1349:         loc_oPagina.AddObject("txt_4c_Hist2", "TextBox")
1350:         WITH loc_oPagina.txt_4c_Hist2
1351:             .Top       = 387
1352:             .Left      = 415
1353:             .Width     = 300
1354:             .Height    = 21
1355:             .Value     = ""
1356:             .MaxLength = 80
1357:             .Format    = "K!"
1358:             .FontName  = "Tahoma"
1359:             .FontSize  = 8
1360:             .Visible   = .T.
1361:         ENDWITH
1362: 
1363:         loc_oPagina.AddObject("lbl_4c_Label19", "Label")
1364:         WITH loc_oPagina.lbl_4c_Label19
1365:             .Caption   = "Lan" + CHR(231) + "ar Contas :"
1366:             .Top       = 391
1367:             .Left      = 758
1368:             .Width     = 76
1369:             .Height    = 15
1370:             .AutoSize  = .F.
1371:             .FontName  = "Tahoma"
1372:             .FontSize  = 8

*-- Linhas 1379 a 1412:
1379:         *-- Value=0, Option2="Nao" Value=1 - ControlSource craltcc.contapgs)
1380:         loc_oPagina.AddObject("obj_4c_Opcao_conta", "OptionGroup")
1381:         WITH loc_oPagina.obj_4c_Opcao_conta
1382:             .Top         = 385
1383:             .Left        = 844
1384:             .Width       = 99
1385:             .Height      = 27
1386:             .ButtonCount = 2
1387:             .BackStyle   = 0
1388:             .BorderStyle = 0
1389:             .Visible     = .T.
1390:         ENDWITH
1391:         WITH loc_oPagina.obj_4c_Opcao_conta.Buttons(1)
1392:             .Caption   = "Sim"
1393:             .Value     = 0
1394:             .Left      = 5
1395:             .Top       = 5
1396:             .AutoSize  = .F.
1397:             .FontName  = "Tahoma"
1398:             .FontSize  = 8
1399:             .ForeColor = RGB(90, 90, 90)
1400:             .BackStyle = 0
1401:             .Themes    = .F.
1402:         ENDWITH
1403:         WITH loc_oPagina.obj_4c_Opcao_conta.Buttons(2)
1404:             .Caption   = "N" + CHR(227) + "o"
1405:             .Value     = 1
1406:             .Left      = 57
1407:             .Top       = 6
1408:             .AutoSize  = .T.
1409:             .Alignment = 0
1410:             .FontName  = "Tahoma"
1411:             .FontSize  = 8
1412:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1480 a 1498:
1480: 
1481:                     *-- RecordSource/ControlSource resetam os cabecalhos (CLAUDE.md
1482:                     *-- FORMCOR_LICOES Problema 2) - reconfigurar SEMPRE apos
1483:                     loc_oGrid.Column1.Header1.Caption  = "Data"
1484:                     loc_oGrid.Column2.Header1.Caption  = "Conta"
1485:                     loc_oGrid.Column3.Header1.Caption  = "Contrapartida"
1486:                     loc_oGrid.Column4.Header1.Caption  = "Hist" + CHR(243) + "rico"
1487:                     loc_oGrid.Column5.Header1.Caption  = "D" + CHR(233) + "bito"
1488:                     loc_oGrid.Column6.Header1.Caption  = "Cr" + CHR(233) + "dito"
1489:                     loc_oGrid.Column7.Header1.Caption  = ""
1490:                     loc_oGrid.Column8.Header1.Caption  = " "
1491:                     loc_oGrid.Column9.Header1.Caption  = "NF"
1492:                     loc_oGrid.Column10.Header1.Caption = "Documento"
1493:                     loc_oGrid.Column11.Header1.Caption = "O"
1494: 
1495:                     IF USED("cursor_4c_Dados")
1496:                         GO TOP IN cursor_4c_Dados
1497:                     ENDIF
1498:                     loc_oGrid.Refresh()

*-- Linhas 1973 a 1986:
1973:         *-- do usuario (crSigCdCrg); sem esse cache local, simplifica-se para
1974:         *-- Modo ALTERAR + moeda com cotacao variavel
1975:         loc_lAlterar = (THIS.this_cModoAtual == "ALTERAR" AND loc_lCotas)
1976:         loc_oPg.lbl_4c__Cotacao.Visible       = loc_lCotas
1977:         loc_oPg.txt_4c_COTACAO.Visible        = loc_lCotas
1978:         loc_oPg.lbl_4c__sCotacao.Visible      = loc_lCotas
1979:         loc_oPg.txt_4c_SCOTACAO.Visible       = loc_lCotas
1980:         loc_oPg.cmd_4c_Alteracotacao.Visible  = loc_lAlterar
1981:         loc_oPg.cmd_4c_Alterascotacao.Visible = loc_lAlterar
1982: 
1983:         IF par_cLado == "D"
1984:             THIS.AvisarPrimeiroLancamento(ALLTRIM(loc_oPg.txt_4c_Grupo.Value), ALLTRIM(loc_oPg.txt_4c_Conta.Value), ALLTRIM(loc_oPg.txt_4c_MOEDA.Value))
1985:         ELSE
1986:             THIS.AvisarPrimeiroLancamento(ALLTRIM(loc_oPg.txt_4c_SGRUPO.Value), ALLTRIM(loc_oPg.txt_4c_SCONTA.Value), ALLTRIM(loc_oPg.txt_4c_Smoeda.Value))

*-- Linhas 2303 a 2312:
2303:         LOCAL loc_oBotoesAcao
2304:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2305: 
2306:         loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
2307:         loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2308:     ENDPROC
2309: 
2310:     *===========================================================================
2311:     * LimparCampos - Limpa todos os campos editaveis da Page2 (modo INCLUIR)
2312:     *===========================================================================

*-- Linhas 2383 a 2392:
2383:         loc_oPg.txt_4c_HIST.Enabled            = par_lHabilitar
2384:         loc_oPg.txt_4c_Hist2.Enabled           = par_lHabilitar
2385:         loc_oPg.obj_4c_Opcao_conta.Enabled     = par_lHabilitar
2386:         loc_oPg.cmd_4c_Alteracotacao.Enabled   = par_lHabilitar
2387:         loc_oPg.cmd_4c_Alterascotacao.Enabled  = par_lHabilitar
2388: 
2389:         RETURN .T.
2390:     ENDPROC
2391: 
2392:     *===========================================================================


### BO (C:\4c\projeto\app\classes\sigmvccrBO.prg):
*====================================================================
* sigmvccrBO.prg
*
* Business Object para Conta Corrente Geral
* Tabela: SigMvCcr
* Chave: cidchaves (PK Fortyus)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS sigmvccrBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigMvCcr)
    this_cCidchaves    = ""    && cidchaves   char(20)   - PK
    this_lAutos        = .F.   && autos       bit
    this_lConcs        = .F.   && concs       bit
    this_cContages     = ""    && contages    char(10)
    this_cContas       = ""    && contas      char(10)
    this_cContems      = ""    && contems     char(10)
    this_nCotacaos     = 0     && cotacaos    numeric(15,7)
    this_dDatalts      = {}    && datalts     datetime
    this_dDatas        = {}    && datas       datetime
    this_dDataconcs    = {}    && dataconcs   datetime
    this_dDatatrans    = {}    && datatrans   datetime
    this_dDatexcs      = {}    && datexcs     datetime
    this_cDocus        = ""    && docus       char(10)
    this_cDopes        = ""    && dopes       char(20)
    this_dDtemis       = {}    && dtemis      datetime
    this_cEmps         = ""    && emps        char(3)
    this_cGrupages     = ""    && grupages    char(10)
    this_cGrupems      = ""    && grupems     char(10)
    this_cGrupos       = ""    && grupos      char(10)
    this_cHists        = ""    && hists       char(60)
    this_cLocals       = ""    && locals      char(10)
    this_cMoedas       = ""    && moedas      char(3)
    this_cNfs          = ""    && nfs         char(10)
    this_nNlancs       = 0     && nlancs      numeric(6,0)
    this_nNopers       = 0     && nopers      numeric(7,0)
    this_nNtrans       = 0     && ntrans      numeric(6,0)
    this_nNumes        = 0     && numes       numeric(6,0)
    this_cOpers        = ""    && opers       char(1) - D/C
    this_nSaldocs      = 0     && saldocs     numeric(15,2)
    this_nSaldons      = 0     && saldons     numeric(15,2)
    this_nSaldos       = 0     && saldos      numeric(15,2)
    this_cScontas      = ""    && scontas     char(10)
    this_nScotacaos    = 0     && scotacaos   numeric(15,7)
    this_cSgrupos      = ""    && sgrupos     char(10)
    this_cShists       = ""    && shists      char(40)
    this_cSmoedas      = ""    && smoedas     char(3)
    this_cSopers       = ""    && sopers      char(1) - D/C
    this_nSvalors      = 0     && svalors     numeric(11,2)
    this_cTipos        = ""    && tipos       char(1)
    this_cTitbans      = ""    && titbans     char(12)
    this_cTitulos      = ""    && titulos     char(10)
    this_cUsualts      = ""    && usualts     char(10)
    this_cUsuexcs      = ""    && usuexcs     char(10)
    this_nValliqs      = 0     && valliqs     numeric(11,2)
    this_nValocurs     = 0     && valocurs    numeric(11,2)
    this_nValors       = 0     && valors      numeric(11,2)
    this_nValpags      = 0     && valpags     numeric(11,2)
    this_dVencs        = {}    && vencs       datetime
    this_cVlancs       = ""    && vlancs      char(10)
    this_cVopers       = ""    && vopers      char(13)
    this_nContapgs     = 0     && contapgs    numeric(1,0)
    this_cDopcs        = ""    && dopcs       char(20)
    this_nNumcs        = 0     && numcs       numeric(6,0)
    this_cCotusus      = ""    && cotusus     char(10)
    this_cBcontas      = ""    && bcontas     char(10)
    this_cBgrupos      = ""    && bgrupos     char(10)
    this_nBorderos     = 0     && borderos    numeric(6,0)
    this_cHist2s       = ""    && hist2s      char(80)
    this_nIntconts     = 0     && intconts    numeric(6,0)
    this_cUsuconcs     = ""    && usuconcs    char(10)
    this_cAuditors     = ""    && auditors    char(10)
    this_dDtaudits     = {}    && dtaudits    datetime
    this_nValprev      = 0     && valprev     numeric(11,2)
    this_cEmpdopncs    = ""    && empdopncs   char(29)
    this_cEmpdopnums   = ""    && empdopnums  char(29)
    this_cGruconmoes   = ""    && gruconmoes  char(23)
    this_cPagos        = ""    && pagos       char(1)
    this_cDopotps      = ""    && dopotps     char(23)
    this_cUsupagos     = ""    && usupagos    char(10)
    this_nTitcancs     = 0     && titcancs    numeric(1,0)
    this_dDtconfs      = {}    && dtconfs     datetime
    this_cUsuconfs     = ""    && usuconfs    char(10)
    this_nNopercancs   = 0     && nopercancs  numeric(7,0)
    this_cEspecienfs   = ""    && especienfs  char(6)
    this_cJobs         = ""    && jobs        char(10)
    this_nImpostos     = 0     && impostos    numeric(11,2)
    this_nTpimpostos   = 0     && tpimpostos  numeric(2,0)
    this_cTitpais      = ""    && titpais     char(10)
    this_cEmpccs       = ""    && empccs      char(3)
    this_nRecor        = 0     && recor       numeric(1,0)
    this_cCompet       = ""    && compet      char(7)
    this_cEmpos        = ""    && empos       char(3)
    this_cOridopnums   = ""    && oridopnums  char(29)
    this_cPastas       = ""    && pastas      text
    this_cRcontas      = ""    && rcontas     char(10)
    this_cTpdocnf      = ""    && tpdocnf     char(2)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigMvCcr"
            THIS.this_cCampoChave = "cidchaves"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "sigmvccrBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna a chave primaria (cidchaves) para
    * uso em RegistrarAuditoria()
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCidchaves)
    ENDPROC

    *====================================================================
    * CarregarDoCursor - Mapeia TODAS as colunas do cursor SQL para as
    * propriedades do BO. SEMPRE usar SELECT (par_cAliasCursor) antes de
    * acessar os campos (regra #8 CLAUDE.md).
    *====================================================================
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)

                THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
                IF VARTYPE(autos) = "L"
                    THIS.this_lAutos = autos
                ELSE
                    THIS.this_lAutos = (NVL(autos, 0) = 1)
                ENDIF
                IF VARTYPE(concs) = "L"
                    THIS.this_lConcs = concs
                ELSE
                    THIS.this_lConcs = (NVL(concs, 0) = 1)
                ENDIF
                THIS.this_cContages = TratarNulo(contages, "C")
                THIS.this_cContas = TratarNulo(contas, "C")
                THIS.this_cContems = TratarNulo(contems, "C")
                THIS.this_nCotacaos = TratarNulo(cotacaos, "N")
                THIS.this_dDatalts = TratarNulo(datalts, "D")
                THIS.this_dDatas = TratarNulo(datas, "D")
                THIS.this_dDataconcs = TratarNulo(dataconcs, "D")
                THIS.this_dDatatrans = TratarNulo(datatrans, "D")
                THIS.this_dDatexcs = TratarNulo(datexcs, "D")
                THIS.this_cDocus = TratarNulo(docus, "C")
                THIS.this_cDopes = TratarNulo(dopes, "C")
                THIS.this_dDtemis = TratarNulo(dtemis, "D")
                THIS.this_cEmps = TratarNulo(emps, "C")
                THIS.this_cGrupages = TratarNulo(grupages, "C")
                THIS.this_cGrupems = TratarNulo(grupems, "C")
                THIS.this_cGrupos = TratarNulo(grupos, "C")
                THIS.this_cHists = TratarNulo(hists, "C")
                THIS.this_cLocals = TratarNulo(locals, "C")
                THIS.this_cMoedas = TratarNulo(moedas, "C")
                THIS.this_cNfs = TratarNulo(nfs, "C")
                THIS.this_nNlancs = TratarNulo(nlancs, "N")
                THIS.this_nNopers = TratarNulo(nopers, "N")
                THIS.this_nNtrans = TratarNulo(ntrans, "N")
                THIS.this_nNumes = TratarNulo(numes, "N")
                THIS.this_cOpers = TratarNulo(opers, "C")
                THIS.this_nSaldocs = TratarNulo(saldocs, "N")
                THIS.this_nSaldons = TratarNulo(saldons, "N")
                THIS.this_nSaldos = TratarNulo(saldos, "N")
                THIS.this_cScontas = TratarNulo(scontas, "C")
                THIS.this_nScotacaos = TratarNulo(scotacaos, "N")
                THIS.this_cSgrupos = TratarNulo(sgrupos, "C")
                THIS.this_cShists = TratarNulo(shists, "C")
                THIS.this_cSmoedas = TratarNulo(smoedas, "C")
                THIS.this_cSopers = TratarNulo(sopers, "C")
                THIS.this_nSvalors = TratarNulo(svalors, "N")
                THIS.this_cTipos = TratarNulo(tipos, "C")
                THIS.this_cTitbans = TratarNulo(titbans, "C")
                THIS.this_cTitulos = TratarNulo(titulos, "C")
                THIS.this_cUsualts = TratarNulo(usualts, "C")
                THIS.this_cUsuexcs = TratarNulo(usuexcs, "C")
                THIS.this_nValliqs = TratarNulo(valliqs, "N")
                THIS.this_nValocurs = TratarNulo(valocurs, "N")
                THIS.this_nValors = TratarNulo(valors, "N")
                THIS.this_nValpags = TratarNulo(valpags, "N")
                THIS.this_dVencs = TratarNulo(vencs, "D")
                THIS.this_cVlancs = TratarNulo(vlancs, "C")
                THIS.this_cVopers = TratarNulo(vopers, "C")
                THIS.this_nContapgs = TratarNulo(contapgs, "N")
                THIS.this_cDopcs = TratarNulo(dopcs, "C")
                THIS.this_nNumcs = TratarNulo(numcs, "N")
                THIS.this_cCotusus = TratarNulo(cotusus, "C")
                THIS.this_cBcontas = TratarNulo(bcontas, "C")
                THIS.this_cBgrupos = TratarNulo(bgrupos, "C")
                THIS.this_nBorderos = TratarNulo(borderos, "N")
                THIS.this_cHist2s = TratarNulo(hist2s, "C")
                THIS.this_nIntconts = TratarNulo(intconts, "N")
                THIS.this_cUsuconcs = TratarNulo(usuconcs, "C")
                THIS.this_cAuditors = TratarNulo(auditors, "C")
                THIS.this_dDtaudits = TratarNulo(dtaudits, "D")
                THIS.this_nValprev = TratarNulo(valprev, "N")
                THIS.this_cEmpdopncs = TratarNulo(empdopncs, "C")
                THIS.this_cEmpdopnums = TratarNulo(empdopnums, "C")
                THIS.this_cGruconmoes = TratarNulo(gruconmoes, "C")
                THIS.this_cPagos = TratarNulo(pagos, "C")
                THIS.this_cDopotps = TratarNulo(dopotps, "C")
                THIS.this_cUsupagos = TratarNulo(usupagos, "C")
                THIS.this_nTitcancs = TratarNulo(titcancs, "N")
                THIS.this_dDtconfs = TratarNulo(dtconfs, "D")
                THIS.this_cUsuconfs = TratarNulo(usuconfs, "C")
                THIS.this_nNopercancs = TratarNulo(nopercancs, "N")
                THIS.this_cEspecienfs = TratarNulo(especienfs, "C")
                THIS.this_cJobs = TratarNulo(jobs, "C")
                THIS.this_nImpostos = TratarNulo(impostos, "N")
                THIS.this_nTpimpostos = TratarNulo(tpimpostos, "N")
                THIS.this_cTitpais = TratarNulo(titpais, "C")
                THIS.this_cEmpccs = TratarNulo(empccs, "C")
                THIS.this_nRecor = TratarNulo(recor, "N")
                THIS.this_cCompet = TratarNulo(compet, "C")
                THIS.this_cEmpos = TratarNulo(empos, "C")
                THIS.this_cOridopnums = TratarNulo(oridopnums, "C")
                THIS.this_cPastas = TratarNulo(pastas, "C")
                THIS.this_cRcontas = TratarNulo(rcontas, "C")
                THIS.this_cTpdocnf = TratarNulo(tpdocnf, "C")

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro(loException.Message, "Erro em sigmvccrBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro em SigMvCcr
    * PK (cidchaves) gerada via fUniqueIds() se ainda nao preenchida
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(NVL(THIS.this_cCidchaves, "")))
                THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)
            ENDIF

            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "INSERT INTO SigMvCcr ("
            loc_cSQL = loc_cSQL + "cidchaves, autos, concs, contages, contas, contems, cotacaos, datalts,"
            loc_cSQL = loc_cSQL + "datas, dataconcs, datatrans, datexcs, docus, dopes, dtemis, emps,"
            loc_cSQL = loc_cSQL + "grupages, grupems, grupos, hists, locals, moedas, nfs, nlancs,"
            loc_cSQL = loc_cSQL + "nopers, ntrans, numes, opers, saldocs, saldons, saldos, scontas,"
            loc_cSQL = loc_cSQL + "scotacaos, sgrupos, shists, smoedas, sopers, svalors, tipos, titbans,"
            loc_cSQL = loc_cSQL + "titulos, usualts, usuexcs, valliqs, valocurs, valors, valpags, vencs,"
            loc_cSQL = loc_cSQL + "vlancs, vopers, contapgs, dopcs, numcs, cotusus, bcontas, bgrupos,"
            loc_cSQL = loc_cSQL + "borderos, hist2s, intconts, usuconcs, auditors, dtaudits, valprev, empdopncs,"
            loc_cSQL = loc_cSQL + "empdopnums, gruconmoes, pagos, dopotps, usupagos, titcancs, dtconfs, usuconfs,"
            loc_cSQL = loc_cSQL + "nopercancs, especienfs, jobs, impostos, tpimpostos, titpais, empccs, recor,"
            loc_cSQL = loc_cSQL + "compet, empos, oridopnums, pastas, rcontas, tpdocnf"
            loc_cSQL = loc_cSQL + ") VALUES ("
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCidchaves, 20)) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lAutos, 1, 0) + ","
            loc_cSQL = loc_cSQL + IIF(THIS.this_lConcs, 1, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2)) + ")"

            IF USED("cursor_4c_Insert")
                USE IN cursor_4c_Insert
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")

            IF loc_nResult < 0
                MsgErro("Erro ao inserir lancamento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
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

    *====================================================================
    * Atualizar - Atualiza registro existente em SigMvCcr (por cidchaves)
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Campo computado: Grupos + Contas + Moedas (chave de grupo/conta/moeda)
            THIS.this_cGruconmoes = PADR(THIS.this_cGrupos, 10) + PADR(THIS.this_cContas, 10) + PADR(THIS.this_cMoedas, 3)

            *-- Campos computados: Emps + Dopes + Numes/Numcs (chave de movimentacao)
            THIS.this_cEmpdopnums = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumes, 6)
            THIS.this_cEmpdopncs = PADR(THIS.this_cEmps, 3) + PADR(THIS.this_cDopes, 20) + STR(THIS.this_nNumcs, 6)

            *-- Data de alteracao
            THIS.this_dDatalts = DATETIME()

            *-- Quebrado em multiplas atribuicoes (nao um unico "+;" continuado):
            *-- VFP9 junta linhas continuadas por ";" numa unica LINHA LOGICA
            *-- com limite de 8192 caracteres ("Line is too long" em runtime).
            loc_cSQL = "UPDATE SigMvCcr SET"
            loc_cSQL = loc_cSQL + " autos = " + IIF(THIS.this_lAutos, 1, 0) + ","
            loc_cSQL = loc_cSQL + " concs = " + IIF(THIS.this_lConcs, 1, 0) + ","
            loc_cSQL = loc_cSQL + " contages = " + EscaparSQL(LEFT(THIS.this_cContages, 10)) + ","
            loc_cSQL = loc_cSQL + " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + ","
            loc_cSQL = loc_cSQL + " contems = " + EscaparSQL(LEFT(THIS.this_cContems, 10)) + ","
            loc_cSQL = loc_cSQL + " cotacaos = " + FormatarNumeroSQL(THIS.this_nCotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " datalts = " + FormatarDataSQL(THIS.this_dDatalts) + ","
            loc_cSQL = loc_cSQL + " datas = " + FormatarDataSQL(THIS.this_dDatas) + ","
            loc_cSQL = loc_cSQL + " dataconcs = " + FormatarDataSQL(THIS.this_dDataconcs) + ","
            loc_cSQL = loc_cSQL + " datatrans = " + FormatarDataSQL(THIS.this_dDatatrans) + ","
            loc_cSQL = loc_cSQL + " datexcs = " + FormatarDataSQL(THIS.this_dDatexcs) + ","
            loc_cSQL = loc_cSQL + " docus = " + EscaparSQL(LEFT(THIS.this_cDocus, 10)) + ","
            loc_cSQL = loc_cSQL + " dopes = " + EscaparSQL(LEFT(THIS.this_cDopes, 20)) + ","
            loc_cSQL = loc_cSQL + " dtemis = " + FormatarDataSQL(THIS.this_dDtemis) + ","
            loc_cSQL = loc_cSQL + " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + ","
            loc_cSQL = loc_cSQL + " grupages = " + EscaparSQL(LEFT(THIS.this_cGrupages, 10)) + ","
            loc_cSQL = loc_cSQL + " grupems = " + EscaparSQL(LEFT(THIS.this_cGrupems, 10)) + ","
            loc_cSQL = loc_cSQL + " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " hists = " + EscaparSQL(LEFT(THIS.this_cHists, 60)) + ","
            loc_cSQL = loc_cSQL + " locals = " + EscaparSQL(LEFT(THIS.this_cLocals, 10)) + ","
            loc_cSQL = loc_cSQL + " moedas = " + EscaparSQL(LEFT(THIS.this_cMoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " nfs = " + EscaparSQL(LEFT(THIS.this_cNfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nlancs = " + FormatarNumeroSQL(THIS.this_nNlancs, 0) + ","
            loc_cSQL = loc_cSQL + " nopers = " + FormatarNumeroSQL(THIS.this_nNopers, 0) + ","
            loc_cSQL = loc_cSQL + " ntrans = " + FormatarNumeroSQL(THIS.this_nNtrans, 0) + ","
            loc_cSQL = loc_cSQL + " numes = " + FormatarNumeroSQL(THIS.this_nNumes, 0) + ","
            loc_cSQL = loc_cSQL + " opers = " + EscaparSQL(LEFT(THIS.this_cOpers, 1)) + ","
            loc_cSQL = loc_cSQL + " saldocs = " + FormatarNumeroSQL(THIS.this_nSaldocs, 2) + ","
            loc_cSQL = loc_cSQL + " saldons = " + FormatarNumeroSQL(THIS.this_nSaldons, 2) + ","
            loc_cSQL = loc_cSQL + " saldos = " + FormatarNumeroSQL(THIS.this_nSaldos, 2) + ","
            loc_cSQL = loc_cSQL + " scontas = " + EscaparSQL(LEFT(THIS.this_cScontas, 10)) + ","
            loc_cSQL = loc_cSQL + " scotacaos = " + FormatarNumeroSQL(THIS.this_nScotacaos, 7) + ","
            loc_cSQL = loc_cSQL + " sgrupos = " + EscaparSQL(LEFT(THIS.this_cSgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " shists = " + EscaparSQL(LEFT(THIS.this_cShists, 40)) + ","
            loc_cSQL = loc_cSQL + " smoedas = " + EscaparSQL(LEFT(THIS.this_cSmoedas, 3)) + ","
            loc_cSQL = loc_cSQL + " sopers = " + EscaparSQL(LEFT(THIS.this_cSopers, 1)) + ","
            loc_cSQL = loc_cSQL + " svalors = " + FormatarNumeroSQL(THIS.this_nSvalors, 2) + ","
            loc_cSQL = loc_cSQL + " tipos = " + EscaparSQL(LEFT(THIS.this_cTipos, 1)) + ","
            loc_cSQL = loc_cSQL + " titbans = " + EscaparSQL(LEFT(THIS.this_cTitbans, 12)) + ","
            loc_cSQL = loc_cSQL + " titulos = " + EscaparSQL(LEFT(THIS.this_cTitulos, 10)) + ","
            loc_cSQL = loc_cSQL + " usualts = " + EscaparSQL(LEFT(THIS.this_cUsualts, 10)) + ","
            loc_cSQL = loc_cSQL + " usuexcs = " + EscaparSQL(LEFT(THIS.this_cUsuexcs, 10)) + ","
            loc_cSQL = loc_cSQL + " valliqs = " + FormatarNumeroSQL(THIS.this_nValliqs, 2) + ","
            loc_cSQL = loc_cSQL + " valocurs = " + FormatarNumeroSQL(THIS.this_nValocurs, 2) + ","
            loc_cSQL = loc_cSQL + " valors = " + FormatarNumeroSQL(THIS.this_nValors, 2) + ","
            loc_cSQL = loc_cSQL + " valpags = " + FormatarNumeroSQL(THIS.this_nValpags, 2) + ","
            loc_cSQL = loc_cSQL + " vencs = " + FormatarDataSQL(THIS.this_dVencs) + ","
            loc_cSQL = loc_cSQL + " vlancs = " + EscaparSQL(LEFT(THIS.this_cVlancs, 10)) + ","
            loc_cSQL = loc_cSQL + " vopers = " + EscaparSQL(LEFT(THIS.this_cVopers, 13)) + ","
            loc_cSQL = loc_cSQL + " contapgs = " + FormatarNumeroSQL(THIS.this_nContapgs, 0) + ","
            loc_cSQL = loc_cSQL + " dopcs = " + EscaparSQL(LEFT(THIS.this_cDopcs, 20)) + ","
            loc_cSQL = loc_cSQL + " numcs = " + FormatarNumeroSQL(THIS.this_nNumcs, 0) + ","
            loc_cSQL = loc_cSQL + " cotusus = " + EscaparSQL(LEFT(THIS.this_cCotusus, 10)) + ","
            loc_cSQL = loc_cSQL + " bcontas = " + EscaparSQL(LEFT(THIS.this_cBcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " bgrupos = " + EscaparSQL(LEFT(THIS.this_cBgrupos, 10)) + ","
            loc_cSQL = loc_cSQL + " borderos = " + FormatarNumeroSQL(THIS.this_nBorderos, 0) + ","
            loc_cSQL = loc_cSQL + " hist2s = " + EscaparSQL(LEFT(THIS.this_cHist2s, 80)) + ","
            loc_cSQL = loc_cSQL + " intconts = " + FormatarNumeroSQL(THIS.this_nIntconts, 0) + ","
            loc_cSQL = loc_cSQL + " usuconcs = " + EscaparSQL(LEFT(THIS.this_cUsuconcs, 10)) + ","
            loc_cSQL = loc_cSQL + " auditors = " + EscaparSQL(LEFT(THIS.this_cAuditors, 10)) + ","
            loc_cSQL = loc_cSQL + " dtaudits = " + FormatarDataSQL(THIS.this_dDtaudits) + ","
            loc_cSQL = loc_cSQL + " valprev = " + FormatarNumeroSQL(THIS.this_nValprev, 2) + ","
            loc_cSQL = loc_cSQL + " empdopncs = " + EscaparSQL(LEFT(THIS.this_cEmpdopncs, 29)) + ","
            loc_cSQL = loc_cSQL + " empdopnums = " + EscaparSQL(LEFT(THIS.this_cEmpdopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " gruconmoes = " + EscaparSQL(LEFT(THIS.this_cGruconmoes, 23)) + ","
            loc_cSQL = loc_cSQL + " pagos = " + EscaparSQL(LEFT(THIS.this_cPagos, 1)) + ","
            loc_cSQL = loc_cSQL + " dopotps = " + EscaparSQL(LEFT(THIS.this_cDopotps, 23)) + ","
            loc_cSQL = loc_cSQL + " usupagos = " + EscaparSQL(LEFT(THIS.this_cUsupagos, 10)) + ","
            loc_cSQL = loc_cSQL + " titcancs = " + FormatarNumeroSQL(THIS.this_nTitcancs, 0) + ","
            loc_cSQL = loc_cSQL + " dtconfs = " + FormatarDataSQL(THIS.this_dDtconfs) + ","
            loc_cSQL = loc_cSQL + " usuconfs = " + EscaparSQL(LEFT(THIS.this_cUsuconfs, 10)) + ","
            loc_cSQL = loc_cSQL + " nopercancs = " + FormatarNumeroSQL(THIS.this_nNopercancs, 0) + ","
            loc_cSQL = loc_cSQL + " especienfs = " + EscaparSQL(LEFT(THIS.this_cEspecienfs, 6)) + ","
            loc_cSQL = loc_cSQL + " jobs = " + EscaparSQL(LEFT(THIS.this_cJobs, 10)) + ","
            loc_cSQL = loc_cSQL + " impostos = " + FormatarNumeroSQL(THIS.this_nImpostos, 2) + ","
            loc_cSQL = loc_cSQL + " tpimpostos = " + FormatarNumeroSQL(THIS.this_nTpimpostos, 0) + ","
            loc_cSQL = loc_cSQL + " titpais = " + EscaparSQL(LEFT(THIS.this_cTitpais, 10)) + ","
            loc_cSQL = loc_cSQL + " empccs = " + EscaparSQL(LEFT(THIS.this_cEmpccs, 3)) + ","
            loc_cSQL = loc_cSQL + " recor = " + FormatarNumeroSQL(THIS.this_nRecor, 0) + ","
            loc_cSQL = loc_cSQL + " compet = " + EscaparSQL(LEFT(THIS.this_cCompet, 7)) + ","
            loc_cSQL = loc_cSQL + " empos = " + EscaparSQL(LEFT(THIS.this_cEmpos, 3)) + ","
            loc_cSQL = loc_cSQL + " oridopnums = " + EscaparSQL(LEFT(THIS.this_cOridopnums, 29)) + ","
            loc_cSQL = loc_cSQL + " pastas = " + EscaparSQL(THIS.this_cPastas) + ","
            loc_cSQL = loc_cSQL + " rcontas = " + EscaparSQL(LEFT(THIS.this_cRcontas, 10)) + ","
            loc_cSQL = loc_cSQL + " tpdocnf = " + EscaparSQL(LEFT(THIS.this_cTpdocnf, 2))
            loc_cSQL = loc_cSQL + " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_Update")
                USE IN cursor_4c_Update
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")

            IF loc_nResult < 0
                MsgErro("Erro ao atualizar lancamento de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
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

    *====================================================================
    * Buscar - Lista lancamentos de conta corrente com filtro opcional
    * par_cFiltro: condicoes WHERE adicionais (ex: "AND a.datas BETWEEN ...")
    * Popula cursor_4c_Dados (usado pelo grd_4c_Lista do form)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.cidchaves, a.datas, a.contas, a.scontas, a.hists," + ;
                " a.valors, a.svalors, a.smoedas, a.moedas, a.nfs, a.docus, a.opers" + ;
                " FROM SigMvCcr a WHERE 1 = 1"

            IF !EMPTY(ALLTRIM(NVL(par_cFiltro, "")))
                loc_cSQL = loc_cSQL + " " + par_cFiltro
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.emps, a.datas"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult < 0
                MsgErro("Erro ao buscar lancamentos de conta corrente:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvccrBO.Buscar:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega um lancamento pela chave primaria (cidchaves)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cChave)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT * FROM SigMvCcr WHERE cidchaves = " + EscaparSQL(ALLTRIM(par_cChave))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                MsgErro("Lan" + CHR(231) + "amento n" + CHR(227) + "o encontrado.", "Erro")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvccrBO.CarregarPorCodigo:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * ExecutarExclusao - Exclui lancamento (por cidchaves)
    * Legado (msv_excluir): marca DatExcs/UsuExcs antes de excluir fisicamente
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigMvCcr SET datexcs = " + GETDATE() + ;
                ", usuexcs = " + EscaparSQL(gc_4c_UsuarioLogado) + ;
                " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

            IF USED("cursor_4c_ExcUpd")
                USE IN cursor_4c_ExcUpd
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExcUpd")

            IF loc_nResult < 0
                MsgErro("Erro ao marcar exclus" + CHR(227) + "o do lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                IF USED("cursor_4c_ExcUpd")
                    USE IN cursor_4c_ExcUpd
                ENDIF

                loc_cSQL = "DELETE FROM SigMvCcr WHERE cidchaves = " + EscaparSQL(THIS.this_cCidchaves)

                IF USED("cursor_4c_ExcDel")
                    USE IN cursor_4c_ExcDel
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ExcDel")

                IF loc_nResult < 0
                    MsgErro("Erro ao excluir lan" + CHR(231) + "amento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ELSE
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ENDIF

                IF USED("cursor_4c_ExcDel")
                    USE IN cursor_4c_ExcDel
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em sigmvccrBO.ExecutarExclusao:" + CHR(13) + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

