# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 177: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 200: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 223: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 246: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 269: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 303: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 512: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 535: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formsigprpre.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1498 linhas total):

*-- Linhas 47 a 55:
47:         LOCAL loc_lSucesso
48:         loc_lSucesso = .F.
49:         TRY
50:             THIS.Caption   = "Cadastro de Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
51:             THIS.BackColor = RGB(100, 100, 100)
52: 
53:             THIS.this_oBusinessObject = CREATEOBJECT("sigprpreBO")
54:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
55:                 MsgErro("Erro ao criar sigprpreBO", "InicializarForm")

*-- Linhas 78 a 98:
78:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
79:         WITH THIS.pgf_4c_Paginas
80:             .PageCount = 2
81:             .Top       = -29
82:             .Left      = 0
83:             .Width     = THIS.Width
84:             .Height    = THIS.Height + 29
85:             .Tabs      = .F.
86:             .Visible   = .T.
87: 
88:             WITH .Page1
89:                 .Caption   = "Lista"
90:             ENDWITH
91: 
92:             WITH .Page2
93:                 .Caption   = "Dados"
94:                 .BackColor = RGB(100, 100, 100)
95:             ENDWITH
96:         ENDWITH
97: 
98:         THIS.ConfigurarPaginaLista()

*-- Linhas 112 a 453:
112:         *-- Container Cabecalho (cntSombra) - Top compensado: 2+29=31
113:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
114:         WITH loc_oPagina.cnt_4c_Cabecalho
115:             .Top         = 31
116:             .Left        = 0
117:             .Width       = THIS.Width
118:             .Height      = 80
119:             .BackColor   = RGB(100, 100, 100)
120:             .BackStyle   = 1
121:             .BorderWidth = 0
122:             .Visible     = .T.
123:         ENDWITH
124:         loc_oCnt = loc_oPagina.cnt_4c_Cabecalho
125:         loc_oCnt.AddObject("lbl_4c_Sombra", "Label")
126:         WITH loc_oCnt.lbl_4c_Sombra
127:             .AutoSize  = .F.
128:             .Caption   = "Cadastro de Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
129:             .Top       = 15
130:             .Left      = 10
131:             .Width     = 769
132:             .Height    = 40
133:             .FontName  = "Tahoma"
134:             .FontSize  = 16
135:             .FontBold  = .T.
136:             .ForeColor = RGB(0, 0, 0)
137:             .BackStyle = 0
138:         ENDWITH
139:         loc_oCnt.AddObject("lbl_4c_Titulo", "Label")
140:         WITH loc_oCnt.lbl_4c_Titulo
141:             .AutoSize  = .F.
142:             .Caption   = "Cadastro de Altera" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "os"
143:             .Top       = 18
144:             .Left      = 10
145:             .Width     = 769
146:             .Height    = 46
147:             .FontName  = "Tahoma"
148:             .FontSize  = 16
149:             .FontBold  = .T.
150:             .ForeColor = RGB(255, 255, 255)
151:             .BackStyle = 0
152:         ENDWITH
153: 
154:         *-- Container Botoes CRUD (Grupo_Op) - Top compensado: 0+29=29
155:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
156:         WITH loc_oPagina.cnt_4c_Botoes
157:             .Top         = 29
158:             .Left        = 542
159:             .Width       = 390
160:             .Height      = 85
161:             .BackColor   = RGB(53, 53, 53)
162:             .BackStyle   = 1
163:             .BorderWidth = 0
164:             .Visible     = .T.
165:         ENDWITH
166:         loc_oCnt = loc_oPagina.cnt_4c_Botoes
167: 
168:         loc_oCnt.AddObject("cmd_4c_Incluir", "CommandButton")
169:         WITH loc_oCnt.cmd_4c_Incluir
170:             .Caption         = "Incluir"
171:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
172:             .PicturePosition = 13
173:             .Top             = 5
174:             .Left            = 5
175:             .Width           = 75
176:             .Height          = 75
177:             .FontName        = "Comic Sans MS"
178:             .FontSize        = 8
179:             .FontBold        = .T.
180:             .FontItalic      = .T.
181:             .ForeColor       = RGB(90, 90, 90)
182:             .BackColor       = RGB(255, 255, 255)
183:             .Themes          = .F.
184:             .SpecialEffect   = 0
185:             .MousePointer    = 15
186:             .WordWrap        = .T.
187:             .AutoSize        = .F.
188:         ENDWITH
189:         BINDEVENT(loc_oCnt.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
190: 
191:         loc_oCnt.AddObject("cmd_4c_Visualizar", "CommandButton")
192:         WITH loc_oCnt.cmd_4c_Visualizar
193:             .Caption         = "Visualizar"
194:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
195:             .PicturePosition = 13
196:             .Top             = 5
197:             .Left            = 80
198:             .Width           = 75
199:             .Height          = 75
200:             .FontName        = "Comic Sans MS"
201:             .FontSize        = 8
202:             .FontBold        = .T.
203:             .FontItalic      = .T.
204:             .ForeColor       = RGB(90, 90, 90)
205:             .BackColor       = RGB(255, 255, 255)
206:             .Themes          = .F.
207:             .SpecialEffect   = 0
208:             .MousePointer    = 15
209:             .WordWrap        = .T.
210:             .AutoSize        = .F.
211:         ENDWITH
212:         BINDEVENT(loc_oCnt.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
213: 
214:         loc_oCnt.AddObject("cmd_4c_Alterar", "CommandButton")
215:         WITH loc_oCnt.cmd_4c_Alterar
216:             .Caption         = "Alterar"
217:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
218:             .PicturePosition = 13
219:             .Top             = 5
220:             .Left            = 155
221:             .Width           = 75
222:             .Height          = 75
223:             .FontName        = "Comic Sans MS"
224:             .FontSize        = 8
225:             .FontBold        = .T.
226:             .FontItalic      = .T.
227:             .ForeColor       = RGB(90, 90, 90)
228:             .BackColor       = RGB(255, 255, 255)
229:             .Themes          = .F.
230:             .SpecialEffect   = 0
231:             .MousePointer    = 15
232:             .WordWrap        = .T.
233:             .AutoSize        = .F.
234:         ENDWITH
235:         BINDEVENT(loc_oCnt.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
236: 
237:         loc_oCnt.AddObject("cmd_4c_Excluir", "CommandButton")
238:         WITH loc_oCnt.cmd_4c_Excluir
239:             .Caption         = "Excluir"
240:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
241:             .PicturePosition = 13
242:             .Top             = 5
243:             .Left            = 230
244:             .Width           = 75
245:             .Height          = 75
246:             .FontName        = "Comic Sans MS"
247:             .FontSize        = 8
248:             .FontBold        = .T.
249:             .FontItalic      = .T.
250:             .ForeColor       = RGB(90, 90, 90)
251:             .BackColor       = RGB(255, 255, 255)
252:             .Themes          = .F.
253:             .SpecialEffect   = 0
254:             .MousePointer    = 15
255:             .WordWrap        = .T.
256:             .AutoSize        = .F.
257:         ENDWITH
258:         BINDEVENT(loc_oCnt.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
259: 
260:         loc_oCnt.AddObject("cmd_4c_Buscar", "CommandButton")
261:         WITH loc_oCnt.cmd_4c_Buscar
262:             .Caption         = "Buscar"
263:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
264:             .PicturePosition = 13
265:             .Top             = 5
266:             .Left            = 305
267:             .Width           = 75
268:             .Height          = 75
269:             .FontName        = "Comic Sans MS"
270:             .FontSize        = 8
271:             .FontBold        = .T.
272:             .FontItalic      = .T.
273:             .ForeColor       = RGB(90, 90, 90)
274:             .BackColor       = RGB(255, 255, 255)
275:             .Themes          = .F.
276:             .SpecialEffect   = 0
277:             .MousePointer    = 15
278:             .WordWrap        = .T.
279:             .AutoSize        = .F.
280:         ENDWITH
281:         BINDEVENT(loc_oCnt.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
282: 
283:         *-- Container Saida (canonico: Left=917, Width=90) - transparente
284:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
285:         WITH loc_oPagina.cnt_4c_Saida
286:             .Top         = 29
287:             .Left        = 917
288:             .Width       = 90
289:             .Height      = 85
290:             .BackStyle   = 0
291:             .BorderWidth = 0
292:             .Visible     = .T.
293:         ENDWITH
294:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
295:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
296:             .Caption         = "Encerrar"
297:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
298:             .PicturePosition = 13
299:             .Top             = 5
300:             .Left            = 5
301:             .Width           = 75
302:             .Height          = 75
303:             .FontName        = "Comic Sans MS"
304:             .FontSize        = 8
305:             .FontBold        = .T.
306:             .FontItalic      = .T.
307:             .ForeColor       = RGB(90, 90, 90)
308:             .BackColor       = RGB(255, 255, 255)
309:             .Themes          = .F.
310:             .SpecialEffect   = 0
311:             .MousePointer    = 15
312:             .WordWrap        = .T.
313:             .AutoSize        = .F.
314:         ENDWITH
315:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
316: 
317:         *-- Container Filtro Periodo (CntPeriodo) - Top compensado: 90+29=119
318:         loc_oPagina.AddObject("cnt_4c_Periodo", "Container")
319:         WITH loc_oPagina.cnt_4c_Periodo
320:             .Top         = 119
321:             .Left        = 701
322:             .Width       = 266
323:             .Height      = 27
324:             .BackStyle   = 0
325:             .BorderWidth = 0
326:             .Visible     = .T.
327:         ENDWITH
328:         loc_oCnt = loc_oPagina.cnt_4c_Periodo
329: 
330:         loc_oCnt.AddObject("lbl_4c_Periodo", "Label")
331:         WITH loc_oCnt.lbl_4c_Periodo
332:             .Caption   = "Per" + CHR(237) + "odo : "
333:             .Top       = 6
334:             .Left      = 15
335:             .Width     = 48
336:             .Height    = 15
337:             .FontName  = "Tahoma"
338:             .FontSize  = 8
339:             .ForeColor = RGB(90, 90, 90)
340:             .BackStyle = 0
341:         ENDWITH
342: 
343:         loc_oCnt.AddObject("txt_4c_Dt_inicial", "TextBox")
344:         WITH loc_oCnt.txt_4c_Dt_inicial
345:             .Top      = 2
346:             .Left     = 65
347:             .Width    = 80
348:             .Height   = 23
349:             .Format   = "D"
350:             .Value    = DATE()
351:             .FontName = "Tahoma"
352:             .FontSize = 8
353:         ENDWITH
354:         BINDEVENT(loc_oCnt.txt_4c_Dt_inicial, "KeyPress", THIS, "ValidarDataInicial")
355: 
356:         loc_oCnt.AddObject("lbl_4c_Sep", "Label")
357:         WITH loc_oCnt.lbl_4c_Sep
358:             .Caption   = "-"
359:             .Top       = 6
360:             .Left      = 151
361:             .Width     = 10
362:             .Height    = 15
363:             .FontName  = "Tahoma"
364:             .FontSize  = 8
365:             .ForeColor = RGB(90, 90, 90)
366:             .BackStyle = 0
367:         ENDWITH
368: 
369:         loc_oCnt.AddObject("txt_4c_Dt_final", "TextBox")
370:         WITH loc_oCnt.txt_4c_Dt_final
371:             .Top      = 2
372:             .Left     = 165
373:             .Width    = 80
374:             .Height   = 23
375:             .Format   = "D"
376:             .Value    = DATE()
377:             .FontName = "Tahoma"
378:             .FontSize = 8
379:         ENDWITH
380:         BINDEVENT(loc_oCnt.txt_4c_Dt_final, "KeyPress", THIS, "ValidarDataFinal")
381: 
382:         *-- Container Filtro Produto/Grupo (cntProd) - Top compensado: 89+29=118
383:         loc_oPagina.AddObject("cnt_4c_Prod", "Container")
384:         WITH loc_oPagina.cnt_4c_Prod
385:             .Top         = 118
386:             .Left        = 16
387:             .Width       = 641
388:             .Height      = 27
389:             .BackStyle   = 0
390:             .BorderWidth = 0
391:             .Visible     = .T.
392:         ENDWITH
393:         loc_oCnt = loc_oPagina.cnt_4c_Prod
394: 
395:         loc_oCnt.AddObject("lbl_4c_GrupoProd", "Label")
396:         WITH loc_oCnt.lbl_4c_GrupoProd
397:             .Caption   = "Grupo/Produto : "
398:             .Top       = 7
399:             .Left      = 38
400:             .Width     = 83
401:             .Height    = 15
402:             .FontName  = "Tahoma"
403:             .FontSize  = 8
404:             .ForeColor = RGB(90, 90, 90)
405:             .BackStyle = 0
406:         ENDWITH
407: 
408:         loc_oCnt.AddObject("txt_4c_Grupo", "TextBox")
409:         WITH loc_oCnt.txt_4c_Grupo
410:             .Top      = 3
411:             .Left     = 123
412:             .Width    = 69
413:             .Height   = 23
414:             .Value    = ""
415:             .FontName = "Tahoma"
416:             .FontSize = 8
417:         ENDWITH
418:         BINDEVENT(loc_oCnt.txt_4c_Grupo, "KeyPress", THIS, "ValidarGrupo")
419: 
420:         loc_oCnt.AddObject("txt_4c_Prod", "TextBox")
421:         WITH loc_oCnt.txt_4c_Prod
422:             .Top      = 3
423:             .Left     = 197
424:             .Width    = 115
425:             .Height   = 23
426:             .Value    = ""
427:             .FontName = "Tahoma"
428:             .FontSize = 8
429:         ENDWITH
430:         BINDEVENT(loc_oCnt.txt_4c_Prod, "KeyPress", THIS, "ValidarProduto")
431: 
432:         loc_oCnt.AddObject("txt_4c_DProd", "TextBox")
433:         WITH loc_oCnt.txt_4c_DProd
434:             .Top      = 3
435:             .Left     = 317
436:             .Width    = 317
437:             .Height   = 23
438:             .Value    = ""
439:             .Enabled  = .F.
440:             .FontName = "Tahoma"
441:             .FontSize = 8
442:         ENDWITH
443: 
444:         *-- Grid de Lista (Grade) - Top compensado: 126+29=155
445:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
446:         loc_oGrid = loc_oPagina.grd_4c_Lista
447:         loc_oGrid.Top                = 155
448:         loc_oGrid.Left               = 29
449:         loc_oGrid.Width              = 940
450:         loc_oGrid.Height             = 459
451:         loc_oGrid.ColumnCount        = 8
452:         loc_oGrid.FontName           = "Verdana"
453:         loc_oGrid.FontSize           = 8

*-- Linhas 490 a 668:
490:         *-- Container botoes Confirmar/Cancelar - Top compensado: 4+29=33
491:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
492:         WITH loc_oPagina.cnt_4c_BotoesAcao
493:             .Top         = 33
494:             .Left        = 842
495:             .Width       = 160
496:             .Height      = 85
497:             .BackStyle   = 0
498:             .BorderWidth = 0
499:             .Visible     = .T.
500:         ENDWITH
501:         loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
502: 
503:         loc_oCnt.AddObject("cmd_4c_Confirmar", "CommandButton")
504:         WITH loc_oCnt.cmd_4c_Confirmar
505:             .Caption         = "Confirmar"
506:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
507:             .PicturePosition = 13
508:             .Top             = 5
509:             .Left            = 5
510:             .Width           = 75
511:             .Height          = 75
512:             .FontName        = "Comic Sans MS"
513:             .FontSize        = 8
514:             .FontBold        = .T.
515:             .FontItalic      = .T.
516:             .ForeColor       = RGB(90, 90, 90)
517:             .BackColor       = RGB(255, 255, 255)
518:             .Themes          = .F.
519:             .SpecialEffect   = 0
520:             .MousePointer    = 15
521:             .WordWrap        = .T.
522:             .AutoSize        = .F.
523:         ENDWITH
524:         BINDEVENT(loc_oCnt.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
525: 
526:         loc_oCnt.AddObject("cmd_4c_Cancelar", "CommandButton")
527:         WITH loc_oCnt.cmd_4c_Cancelar
528:             .Caption         = "Encerrar"
529:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
530:             .PicturePosition = 13
531:             .Top             = 5
532:             .Left            = 80
533:             .Width           = 75
534:             .Height          = 75
535:             .FontName        = "Comic Sans MS"
536:             .FontSize        = 8
537:             .FontBold        = .T.
538:             .FontItalic      = .T.
539:             .ForeColor       = RGB(90, 90, 90)
540:             .BackColor       = RGB(255, 255, 255)
541:             .Themes          = .F.
542:             .SpecialEffect   = 0
543:             .MousePointer    = 15
544:             .WordWrap        = .T.
545:             .AutoSize        = .F.
546:         ENDWITH
547:         BINDEVENT(loc_oCnt.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
548: 
549:         *-- [CAMPO 1/5 - Fase 5] Codigo do Produto (CPros) + Descricao (DPros readonly)
550:         loc_oPagina.AddObject("lbl_4c_CPros", "Label")
551:         WITH loc_oPagina.lbl_4c_CPros
552:             .Caption   = "Produto :"
553:             .Top       = 133
554:             .Left      = 30
555:             .Width     = 100
556:             .Height    = 17
557:             .FontName  = "Tahoma"
558:             .FontSize  = 8
559:             .ForeColor = RGB(90, 90, 90)
560:             .BackStyle = 0
561:             .Alignment = 1
562:         ENDWITH
563: 
564:         loc_oPagina.AddObject("txt_4c_CPros", "TextBox")
565:         WITH loc_oPagina.txt_4c_CPros
566:             .Top           = 129
567:             .Left          = 135
568:             .Width         = 100
569:             .Height        = 23
570:             .Value         = ""
571:             .FontName      = "Tahoma"
572:             .FontSize      = 8
573:             .SpecialEffect = 1
574:         ENDWITH
575:         BINDEVENT(loc_oPagina.txt_4c_CPros, "KeyPress", THIS, "ValidarCPros")
576: 
577:         loc_oPagina.AddObject("txt_4c_DPros", "TextBox")
578:         WITH loc_oPagina.txt_4c_DPros
579:             .Top           = 129
580:             .Left          = 240
581:             .Width         = 400
582:             .Height        = 23
583:             .Value         = ""
584:             .Enabled       = .F.
585:             .FontName      = "Tahoma"
586:             .FontSize      = 8
587:             .SpecialEffect = 1
588:         ENDWITH
589: 
590:         *-- [CAMPO 2/5 - Fase 5] Data
591:         loc_oPagina.AddObject("lbl_4c_Datas", "Label")
592:         WITH loc_oPagina.lbl_4c_Datas
593:             .Caption   = "Data :"
594:             .Top       = 163
595:             .Left      = 30
596:             .Width     = 100
597:             .Height    = 17
598:             .FontName  = "Tahoma"
599:             .FontSize  = 8
600:             .ForeColor = RGB(90, 90, 90)
601:             .BackStyle = 0
602:             .Alignment = 1
603:         ENDWITH
604: 
605:         loc_oPagina.AddObject("txt_4c_Datas", "TextBox")
606:         WITH loc_oPagina.txt_4c_Datas
607:             .Top           = 159
608:             .Left          = 135
609:             .Width         = 80
610:             .Height        = 23
611:             .Format        = "D"
612:             .Value         = DATE()
613:             .FontName      = "Tahoma"
614:             .FontSize      = 8
615:             .SpecialEffect = 1
616:         ENDWITH
617: 
618:         *-- [CAMPO 3/5 - Fase 5] Moeda Atual (Moevs) + Moeda Anterior (MoevsAnt readonly)
619:         loc_oPagina.AddObject("lbl_4c_Moevs", "Label")
620:         WITH loc_oPagina.lbl_4c_Moevs
621:             .Caption   = "Moeda :"
622:             .Top       = 193
623:             .Left      = 30
624:             .Width     = 100
625:             .Height    = 17
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .ForeColor = RGB(90, 90, 90)
629:             .BackStyle = 0
630:             .Alignment = 1
631:         ENDWITH
632: 
633:         loc_oPagina.AddObject("txt_4c_Moevs", "TextBox")
634:         WITH loc_oPagina.txt_4c_Moevs
635:             .Top           = 189
636:             .Left          = 135
637:             .Width         = 60
638:             .Height        = 23
639:             .Value         = ""
640:             .FontName      = "Tahoma"
641:             .FontSize      = 8
642:             .SpecialEffect = 1
643:         ENDWITH
644:         BINDEVENT(loc_oPagina.txt_4c_Moevs, "KeyPress", THIS, "ValidarMoeda")
645: 
646:         loc_oPagina.AddObject("lbl_4c_MoevsAnt", "Label")
647:         WITH loc_oPagina.lbl_4c_MoevsAnt
648:             .Caption   = "Moeda Ant. :"
649:             .Top       = 193
650:             .Left      = 220
651:             .Width     = 100
652:             .Height    = 17
653:             .FontName  = "Tahoma"
654:             .FontSize  = 8
655:             .ForeColor = RGB(90, 90, 90)
656:             .BackStyle = 0
657:             .Alignment = 1
658:         ENDWITH
659: 
660:         loc_oPagina.AddObject("txt_4c_MoevsAnt", "TextBox")
661:         WITH loc_oPagina.txt_4c_MoevsAnt
662:             .Top           = 189
663:             .Left          = 325
664:             .Width         = 60
665:             .Height        = 23
666:             .Value         = ""
667:             .Enabled       = .F.
668:             .FontName      = "Tahoma"

*-- Linhas 677 a 773:
677:         BINDEVENT(loc_oPagina.txt_4c_Moevs, "DblClick", THIS, "MoevsDblClick")
678: 
679:         *-- [CAMPO 4/6 - Fase 6] Preco Atual (PVens) + Preco Anterior (PVensAnt readonly)
680:         loc_oPagina.AddObject("lbl_4c_PVens", "Label")
681:         WITH loc_oPagina.lbl_4c_PVens
682:             .Caption   = "Pre" + CHR(231) + "o Atual :"
683:             .Top       = 223
684:             .Left      = 30
685:             .Width     = 100
686:             .Height    = 17
687:             .FontName  = "Tahoma"
688:             .FontSize  = 8
689:             .ForeColor = RGB(90, 90, 90)
690:             .BackStyle = 0
691:             .Alignment = 1
692:         ENDWITH
693: 
694:         loc_oPagina.AddObject("txt_4c_PVens", "TextBox")
695:         WITH loc_oPagina.txt_4c_PVens
696:             .Top           = 219
697:             .Left          = 135
698:             .Width         = 100
699:             .Height        = 23
700:             .Value         = 0
701:             .InputMask     = "9,999,999.99"
702:             .FontName      = "Tahoma"
703:             .FontSize      = 8
704:             .SpecialEffect = 1
705:         ENDWITH
706: 
707:         loc_oPagina.AddObject("lbl_4c_PVensAnt", "Label")
708:         WITH loc_oPagina.lbl_4c_PVensAnt
709:             .Caption   = "Pre" + CHR(231) + "o Ant. :"
710:             .Top       = 223
711:             .Left      = 250
712:             .Width     = 100
713:             .Height    = 17
714:             .FontName  = "Tahoma"
715:             .FontSize  = 8
716:             .ForeColor = RGB(90, 90, 90)
717:             .BackStyle = 0
718:             .Alignment = 1
719:         ENDWITH
720: 
721:         loc_oPagina.AddObject("txt_4c_PVensAnt", "TextBox")
722:         WITH loc_oPagina.txt_4c_PVensAnt
723:             .Top           = 219
724:             .Left          = 355
725:             .Width         = 100
726:             .Height        = 23
727:             .Value         = 0
728:             .InputMask     = "9,999,999.99"
729:             .Enabled       = .F.
730:             .FontName      = "Tahoma"
731:             .FontSize      = 8
732:             .SpecialEffect = 1
733:         ENDWITH
734: 
735:         *-- [CAMPO 5/6 - Fase 6] Usuario (Usuals - readonly, preenchido automaticamente)
736:         loc_oPagina.AddObject("lbl_4c_Usuals", "Label")
737:         WITH loc_oPagina.lbl_4c_Usuals
738:             .Caption   = "Usu" + CHR(225) + "rio :"
739:             .Top       = 253
740:             .Left      = 30
741:             .Width     = 100
742:             .Height    = 17
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .ForeColor = RGB(90, 90, 90)
746:             .BackStyle = 0
747:             .Alignment = 1
748:         ENDWITH
749: 
750:         loc_oPagina.AddObject("txt_4c_Usuals", "TextBox")
751:         WITH loc_oPagina.txt_4c_Usuals
752:             .Top           = 249
753:             .Left          = 135
754:             .Width         = 150
755:             .Height        = 23
756:             .Value         = ""
757:             .Enabled       = .F.
758:             .FontName      = "Tahoma"
759:             .FontSize      = 8
760:             .SpecialEffect = 1
761:         ENDWITH
762: 
763:         *-- [CAMPO 6/6 - Fase 6] CheckBox Atualizar Site (CKAtuSite)
764:         loc_oPagina.AddObject("chk_4c_CKAtuSite", "CheckBox")
765:         WITH loc_oPagina.chk_4c_CKAtuSite
766:             .Caption   = "Atualizar Site"
767:             .Top       = 283
768:             .Left      = 135
769:             .Width     = 120
770:             .Height    = 23
771:             .Value     = 0
772:             .FontName  = "Tahoma"
773:             .FontSize  = 8

*-- Linhas 826 a 841:
826:                 loc_oGrid.Column8.ControlSource = "crSigPrPre.usuals"
827: 
828:                 *-- Reconfigurar cabecalhos APOS RecordSource (obrigatorio)
829:                 loc_oGrid.Column1.Header1.Caption = "Produto"
830:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
831:                 loc_oGrid.Column3.Header1.Caption = "Grupo"
832:                 loc_oGrid.Column4.Header1.Caption = "Data"
833:                 loc_oGrid.Column5.Header1.Caption = "Moeda"
834:                 loc_oGrid.Column6.Header1.Caption = "Pre" + CHR(231) + "o Ant."
835:                 loc_oGrid.Column7.Header1.Caption = "Pre" + CHR(231) + "o Atual"
836:                 loc_oGrid.Column8.Header1.Caption = "Usu" + CHR(225) + "rio"
837: 
838:                 THIS.FormatarGridLista(loc_oGrid)
839:                 loc_oGrid.Refresh()
840:                 loc_lResultado = .T.
841:             ENDIF

*-- Linhas 1445 a 1484:
1445: 
1446:             IF PEMSTATUS(loc_oPagina, "cnt_4c_Botoes", 5)
1447:                 loc_oCnt = loc_oPagina.cnt_4c_Botoes
1448:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Incluir", 5)
1449:                     loc_oCnt.cmd_4c_Incluir.Enabled    = !loc_lEmEdicao
1450:                 ENDIF
1451:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Visualizar", 5)
1452:                     loc_oCnt.cmd_4c_Visualizar.Enabled = !loc_lEmEdicao
1453:                 ENDIF
1454:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Alterar", 5)
1455:                     loc_oCnt.cmd_4c_Alterar.Enabled    = !loc_lEmEdicao
1456:                 ENDIF
1457:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Excluir", 5)
1458:                     loc_oCnt.cmd_4c_Excluir.Enabled    = !loc_lEmEdicao
1459:                 ENDIF
1460:                 IF PEMSTATUS(loc_oCnt, "cmd_4c_Buscar", 5)
1461:                     loc_oCnt.cmd_4c_Buscar.Enabled     = !loc_lEmEdicao
1462:                 ENDIF
1463:             ENDIF
1464: 
1465:             IF PEMSTATUS(loc_oPagina, "cnt_4c_Saida", 5)
1466:                 IF PEMSTATUS(loc_oPagina.cnt_4c_Saida, "cmd_4c_Encerrar", 5)
1467:                     loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar.Enabled = !loc_lEmEdicao
1468:                 ENDIF
1469:             ENDIF
1470: 
1471:             IF THIS.pgf_4c_Paginas.PageCount >= 2
1472:                 loc_oPagina = THIS.pgf_4c_Paginas.Page2
1473:                 IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1474:                     loc_oCnt = loc_oPagina.cnt_4c_BotoesAcao
1475:                     IF PEMSTATUS(loc_oCnt, "cmd_4c_Confirmar", 5)
1476:                         loc_oCnt.cmd_4c_Confirmar.Enabled = (THIS.this_cModoAtual != "VISUALIZAR")
1477:                     ENDIF
1478:                     IF PEMSTATUS(loc_oCnt, "cmd_4c_Cancelar", 5)
1479:                         loc_oCnt.cmd_4c_Cancelar.Enabled = loc_lEmEdicao
1480:                     ENDIF
1481:                 ENDIF
1482:             ENDIF
1483:         CATCH TO loc_oErro
1484:             MsgErro(loc_oErro.Message, "AjustarBotoesPorModo")


### BO (C:\4c\projeto\app\classes\sigprpreBO.prg):
*=============================================================================
* sigprpreBO.prg - Business Object para Alteracao de Precos
* Herda de: BusinessBase
* Tabela: sigprpre (PK: cidchaves)
* Campos: cidchaves, cpros, datas, moevs, moevsant, pvens, pvensant,
*         usuals, ckatusite
* JOIN display: dpros, cgrus (de SigCdPro)
*=============================================================================

DEFINE CLASS sigprpreBO AS BusinessBase

    *-- Campos da tabela sigprpre
    this_cCidChaves  = ""   && cidchaves char(20) NOT NULL - PK
    this_cCPros      = ""   && cpros char(14) NOT NULL - Codigo do produto
    this_dDatas      = {}   && datas datetime NULL - Data da alteracao
    this_cMoevs      = ""   && moevs char(3) NOT NULL - Moeda atual
    this_cMoevsAnt   = ""   && moevsant char(3) NOT NULL - Moeda anterior
    this_nPVens      = 0    && pvens numeric(11,5) NOT NULL - Preco de venda atual
    this_nPVensAnt   = 0    && pvensant numeric(11,5) NOT NULL - Preco de venda anterior
    this_cUsuals     = ""   && usuals nvarchar(20) NULL - Usuario
    this_nCKAtuSite  = 0    && ckatusite numeric(1,0) NOT NULL - Flag atualizacao site

    *-- Campos auxiliares de exibicao (JOIN com SigCdPro)
    this_cDPros      = ""   && dpros - Descricao do produto
    this_cCGrus      = ""   && cgrus - Codigo do grupo do produto

    *-- Filtros de consulta (usados em Buscar)
    this_dDataInicio = {}   && Data de inicio do periodo
    this_dDataFim    = {}   && Data de fim do periodo
    this_cFiltroCPro = ""   && Filtro por codigo de produto
    this_cFiltroGru  = ""   && Filtro por codigo de grupo

    *--------------------------------------------------------------------------
    * Init - Configura tabela e campo chave
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprpre"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave para registro de auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCidChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves  = TratarNulo(cidchaves,  "C")
            THIS.this_cCPros      = TratarNulo(cpros,      "C")
            THIS.this_dDatas      = TratarNulo(datas,      "D")
            THIS.this_cMoevs      = TratarNulo(moevs,      "C")
            THIS.this_cMoevsAnt   = TratarNulo(moevsant,   "C")
            THIS.this_nPVens      = TratarNulo(pvens,      "N")
            THIS.this_nPVensAnt   = TratarNulo(pvensant,   "N")
            THIS.this_cUsuals     = TratarNulo(usuals,     "C")
            THIS.this_nCKAtuSite  = TratarNulo(ckatusite,  "N")
            IF TYPE("dpros") != "U"
                THIS.this_cDPros  = TratarNulo(dpros,      "C")
            ENDIF
            IF TYPE("cgrus") != "U"
                THIS.this_cCGrus  = TratarNulo(cgrus,      "C")
            ENDIF
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - SELECT com filtros de periodo, produto e grupo
    * Cursor resultante: crSigPrPre (nome legado preservado para binding do grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_cDataIni, loc_cDataFim
        LOCAL loc_cProdF, loc_cGruF, loc_oErro
        loc_lResultado = .F.
        TRY
            *-- Calcular limites para filtros "entre" (padrao do legado)
            IF EMPTY(THIS.this_cFiltroCPro)
                loc_cProdF = "zzzzzzzzzzzzzz"
            ELSE
                loc_cProdF = ALLTRIM(THIS.this_cFiltroCPro)
            ENDIF
            IF EMPTY(THIS.this_cFiltroGru)
                loc_cGruF = "zzz"
            ELSE
                loc_cGruF = ALLTRIM(THIS.this_cFiltroGru)
            ENDIF

            *-- Formatar datas
            IF EMPTY(THIS.this_dDataInicio)
                loc_cDataIni = FormatarDataSQL(DATE())
            ELSE
                loc_cDataIni = FormatarDataSQL(THIS.this_dDataInicio)
            ENDIF
            IF EMPTY(THIS.this_dDataFim)
                loc_cDataFim = "'" + LEFT(DTOS(DATE()), 4) + "-" + SUBSTR(DTOS(DATE()),5,2) + "-" + RIGHT(DTOS(DATE()),2) + " 23:59:59'"
            ELSE
                loc_cDataFim = "'" + LEFT(DTOS(THIS.this_dDataFim), 4) + "-" + SUBSTR(DTOS(THIS.this_dDataFim),5,2) + "-" + RIGHT(DTOS(THIS.this_dDataFim),2) + " 23:59:59'"
            ENDIF

            loc_cSQL = "SELECT a.cidchaves, a.cpros, a.datas, a.moevs, a.moevsant," + ;
                       " a.pvens, a.pvensant, a.usuals, a.ckatusite," + ;
                       " b.dpros, b.cgrus" + ;
                       " FROM sigprpre a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " WHERE a.datas BETWEEN " + loc_cDataIni + " AND " + loc_cDataFim + ;
                       " AND a.cpros BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cFiltroCPro)) + ;
                       " AND " + EscaparSQL(loc_cProdF) + ;
                       " AND b.cgrus BETWEEN " + EscaparSQL(ALLTRIM(THIS.this_cFiltroGru)) + ;
                       " AND " + EscaparSQL(loc_cGruF) + ;
                       " ORDER BY a.datas DESC, a.cpros"

            IF USED("crSigPrPre")
                USE IN crSigPrPre
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "crSigPrPre") > 0
                IF USED("crSigPrPre")
                    SELECT crSigPrPre
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar altera" + CHR(231) + CHR(245) + "es de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCidChaves)
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.cidchaves, a.cpros, a.datas, a.moevs, a.moevsant," + ;
                       " a.pvens, a.pvensant, a.usuals, a.ckatusite," + ;
                       " b.dpros, b.cgrus" + ;
                       " FROM sigprpre a" + ;
                       " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                       " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cCidChaves))

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega") > 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    THIS.this_cMensagemErro = "Registro n" + CHR(227) + "o encontrado."
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                THIS.this_cMensagemErro = "Erro ao carregar registro."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro, loc_cChaveNova
        loc_lResultado = .F.
        TRY
            *-- Gerar chave unica para cidchaves (char 20)
            IF SQLEXEC(gnConnHandle, "SELECT CAST(NEWID() AS CHAR(36)) AS nid", "cursor_4c_NewId") > 0
                SELECT cursor_4c_NewId
                loc_cChaveNova = LEFT(ALLTRIM(nid), 20)
                USE IN cursor_4c_NewId
            ELSE
                loc_cChaveNova = LEFT(SYS(2015) + SYS(2015) + SYS(2015), 20)
            ENDIF
            THIS.this_cCidChaves = loc_cChaveNova

            loc_cSQL = "INSERT INTO sigprpre" + ;
                       " (cidchaves, cpros, datas, moevs, moevsant, pvens, pvensant, usuals, ckatusite)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCidChaves) + ", " + ;
                       EscaparSQL(THIS.this_cCPros)     + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(THIS.this_cMoevs)     + ", " + ;
                       EscaparSQL(THIS.this_cMoevsAnt)  + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPVens)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nPVensAnt) + ", " + ;
                       EscaparSQL(THIS.this_cUsuals)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nCKAtuSite) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigprpre SET" + ;
                       " cpros    = " + EscaparSQL(THIS.this_cCPros)          + ", " + ;
                       " datas    = " + FormatarDataSQL(THIS.this_dDatas)     + ", " + ;
                       " moevs    = " + EscaparSQL(THIS.this_cMoevs)          + ", " + ;
                       " moevsant = " + EscaparSQL(THIS.this_cMoevsAnt)       + ", " + ;
                       " pvens    = " + FormatarNumeroSQL(THIS.this_nPVens)   + ", " + ;
                       " pvensant = " + FormatarNumeroSQL(THIS.this_nPVensAnt)+ ", " + ;
                       " usuals   = " + EscaparSQL(THIS.this_cUsuals)         + ", " + ;
                       " ckatusite= " + FormatarNumeroSQL(THIS.this_nCKAtuSite) + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ATUALIZAR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE FROM sigprpre
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_oErro
        loc_lResultado = .F.
        TRY
            loc_cSQL = "DELETE FROM sigprpre WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cCidChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir altera" + CHR(231) + CHR(227) + "o de pre" + CHR(231) + "o."
                MsgErro(CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

ENDDEFINE

