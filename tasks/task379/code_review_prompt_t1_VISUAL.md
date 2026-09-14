# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 173: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 194: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 216: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 238: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 260: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 295: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 380: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 401: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCol.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1227 linhas total):

*-- Linhas 69 a 89:
69:         TRY
70:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
71: 
72:             THIS.pgf_4c_Paginas.Top       = -29
73:             THIS.pgf_4c_Paginas.Left      = 0
74:             THIS.pgf_4c_Paginas.Width     = 1000
75:             THIS.pgf_4c_Paginas.Height    = 629
76:             THIS.pgf_4c_Paginas.PageCount = 2
77:             THIS.pgf_4c_Paginas.Tabs      = .F.
78:             THIS.pgf_4c_Paginas.TabStyle  = 0
79:             THIS.pgf_4c_Paginas.Visible   = .T.
80: 
81:             WITH THIS.pgf_4c_Paginas
82:                 .Page1.Caption  = "Lista"
83:                 .Page1.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
84:                 .Page2.Caption  = "Dados"
85:                 .Page2.Picture  = gc_4c_CaminhoIcones + "new_background.jpg"
86:             ENDWITH
87: 
88:             THIS.ConfigurarPaginaLista()
89:             THIS.ConfigurarPaginaDados()

*-- Linhas 108 a 144:
108:             *-- Cabecalho cinza (cntSombra legado: Top=1, Left=-1, Width=1008, Height=80)
109:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
110:             WITH loc_oPagina.cnt_4c_Cabecalho
111:                 .Top         = 30
112:                 .Left        = 0
113:                 .Width       = 1000
114:                 .Height      = 80
115:                 .BackColor   = RGB(100, 100, 100)
116:                 .BorderWidth = 0
117:                 .Visible     = .T.
118: 
119:                 .AddObject("lbl_4c_Sombra", "Label")
120:                 WITH .lbl_4c_Sombra
121:                     .Caption   = "Cadastro de Grupo de Venda"
122:                     .Top       = 15
123:                     .Left      = 10
124:                     .Width     = THIS.Width
125:                     .Height    = 40
126:                     .AutoSize  = .F.
127:                     .FontName  = "Tahoma"
128:                     .FontSize  = 16
129:                     .FontBold  = .T.
130:                     .ForeColor = RGB(0, 0, 0)
131:                     .BackStyle = 0
132:                     .Visible   = .T.
133:                 ENDWITH
134: 
135:                 .AddObject("lbl_4c_Titulo", "Label")
136:                 WITH .lbl_4c_Titulo
137:                     .Caption   = "Cadastro de Grupo de Venda"
138:                     .Top       = 18
139:                     .Left      = 10
140:                     .Width     = THIS.Width
141:                     .Height    = 46
142:                     .AutoSize  = .F.
143:                     .FontName  = "Tahoma"
144:                     .FontSize  = 16

*-- Linhas 152 a 266:
152:             *-- Container botoes CRUD (Grupo_op legado: Left=543, Top=-1, Width=385, Height=85)
153:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
154:             WITH loc_oPagina.cnt_4c_Botoes
155:                 .Top         = 28
156:                 .Left        =  542
157:                 .Width       = 385
158:                 .Height      = 85
159:                 .BackColor   = RGB(53, 53, 53)
160:                 .BackStyle   = 1
161:                 .BorderWidth = 0
162:                 .Visible     = .T.
163: 
164:                 .AddObject("cmd_4c_Incluir", "CommandButton")
165:                 WITH .cmd_4c_Incluir
166:                     .Caption         = "Incluir"
167:                     .Top             = 5
168:                     .Left            =  542
169:                     .Width           = 75
170:                     .Height          = 75
171:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
172:                     .PicturePosition = 13
173:                     .FontName        = "Comic Sans MS"
174:                     .FontSize        = 8
175:                     .FontBold        = .T.
176:                     .FontItalic      = .T.
177:                     .ForeColor       = RGB(90, 90, 90)
178:                     .BackColor       = RGB(255, 255, 255)
179:                     .SpecialEffect   = 0
180:                     .MousePointer    = 15
181:                     .WordWrap        = .T.
182:                     .Visible         = .T.
183:                 ENDWITH
184: 
185:                 .AddObject("cmd_4c_Visualizar", "CommandButton")
186:                 WITH .cmd_4c_Visualizar
187:                     .Caption         = "Visualizar"
188:                     .Top             = 5
189:                     .Left            =  542
190:                     .Width           = 75
191:                     .Height          = 75
192:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
193:                     .PicturePosition = 13
194:                     .FontName        = "Comic Sans MS"
195:                     .FontSize        = 8
196:                     .FontBold        = .T.
197:                     .FontItalic      = .T.
198:                     .ForeColor       = RGB(90, 90, 90)
199:                     .BackColor       = RGB(255, 255, 255)
200:                     .Themes          = .F.
201:                     .SpecialEffect   = 0
202:                     .MousePointer    = 15
203:                     .WordWrap        = .T.
204:                     .Visible         = .T.
205:                 ENDWITH
206: 
207:                 .AddObject("cmd_4c_Alterar", "CommandButton")
208:                 WITH .cmd_4c_Alterar
209:                     .Caption         = "Alterar"
210:                     .Top             = 5
211:                     .Left            =  542
212:                     .Width           = 75
213:                     .Height          = 75
214:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
215:                     .PicturePosition = 13
216:                     .FontName        = "Comic Sans MS"
217:                     .FontSize        = 8
218:                     .FontBold        = .T.
219:                     .FontItalic      = .T.
220:                     .ForeColor       = RGB(90, 90, 90)
221:                     .BackColor       = RGB(255, 255, 255)
222:                     .Themes          = .F.
223:                     .SpecialEffect   = 0
224:                     .MousePointer    = 15
225:                     .WordWrap        = .T.
226:                     .Visible         = .T.
227:                 ENDWITH
228: 
229:                 .AddObject("cmd_4c_Excluir", "CommandButton")
230:                 WITH .cmd_4c_Excluir
231:                     .Caption         = "Excluir"
232:                     .Top             = 5
233:                     .Left            =  542
234:                     .Width           = 75
235:                     .Height          = 75
236:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
237:                     .PicturePosition = 13
238:                     .FontName        = "Comic Sans MS"
239:                     .FontSize        = 8
240:                     .FontBold        = .T.
241:                     .FontItalic      = .T.
242:                     .ForeColor       = RGB(90, 90, 90)
243:                     .BackColor       = RGB(255, 255, 255)
244:                     .Themes          = .F.
245:                     .SpecialEffect   = 0
246:                     .MousePointer    = 15
247:                     .WordWrap        = .T.
248:                     .Visible         = .T.
249:                 ENDWITH
250: 
251:                 .AddObject("cmd_4c_Buscar", "CommandButton")
252:                 WITH .cmd_4c_Buscar
253:                     .Caption         = "Buscar"
254:                     .Top             = 5
255:                     .Left            =  542
256:                     .Width           = 75
257:                     .Height          = 75
258:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
259:                     .PicturePosition = 13
260:                     .FontName        = "Comic Sans MS"
261:                     .FontSize        = 8
262:                     .FontBold        = .T.
263:                     .FontItalic      = .T.
264:                     .ForeColor       = RGB(90, 90, 90)
265:                     .BackColor       = RGB(255, 255, 255)
266:                     .Themes          = .F.

*-- Linhas 272 a 301:
272:             ENDWITH
273: 
274:             *-- Container saida - PADRAO CANONICO (prevalece sobre PILAR 1)
275:             *-- Legado: Grupo_Saida.Left=918, Top=-1; Canonico: Left=917, Width=90
276:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
277:             WITH loc_oPagina.cnt_4c_Saida
278:                 .Top         = 29
279:                 .Left        = 917
280:                 .Width       = 90
281:                 .Height      = 85
282:                 .BackStyle   = 0
283:                 .BorderWidth = 0
284:                 .Visible     = .T.
285: 
286:                 .AddObject("cmd_4c_Encerrar", "CommandButton")
287:                 WITH .cmd_4c_Encerrar
288:                     .Caption         = "Encerrar"
289:                     .Top             = 5
290:                     .Left            = 917
291:                     .Width           = 75
292:                     .Height          = 75
293:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
294:                     .PicturePosition = 13
295:                     .FontName        = "Comic Sans MS"
296:                     .FontSize        = 8
297:                     .FontBold        = .T.
298:                     .FontItalic      = .T.
299:                     .ForeColor       = RGB(90, 90, 90)
300:                     .BackColor       = RGB(255, 255, 255)
301:                     .SpecialEffect   = 0

*-- Linhas 307 a 316:
307: 
308:             *-- Grid de listagem (colecoes=79, descs=290, codcols=75 - do legado Init)
309:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
310:             loc_oPagina.grd_4c_Lista.Top              = 117
311:             loc_oPagina.grd_4c_Lista.Left             = 26
312:             loc_oPagina.grd_4c_Lista.Width            = 890
313:             loc_oPagina.grd_4c_Lista.Height           = 498
314:             loc_oPagina.grd_4c_Lista.ColumnCount      = 3
315:             WITH loc_oPagina.grd_4c_Lista
316:                 .FontName             = "Verdana"

*-- Linhas 329 a 342:
329:                 .Visible              = .T.
330:             ENDWITH
331: 
332:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
333:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
334:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
335:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
336:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
337:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
338: 
339:             THIS.TornarControlesVisiveis(loc_oPagina)
340: 
341:         CATCH TO loc_oErro
342:             MostrarErro("Erro ao configurar Page Lista:" + CHR(13) + loc_oErro.Message, "FormCol.ConfigurarPaginaLista")

*-- Linhas 360 a 428:
360:             *-- Container salvar/cancelar (Grupo_Salva legado: Left=820, Top=8, Width=160)
361:             loc_oPagina.AddObject("cnt_4c_Salva", "Container")
362:             WITH loc_oPagina.cnt_4c_Salva
363:                 .Top         = 37
364:                 .Left        = 820
365:                 .Width       = 160
366:                 .Height      = 85
367:                 .BackStyle   = 0
368:                 .BorderWidth = 0
369:                 .Visible     = .T.
370: 
371:                 .AddObject("cmd_4c_Confirmar", "CommandButton")
372:                 WITH .cmd_4c_Confirmar
373:                     .Caption         = "Confirmar"
374:                     .Top             = 5
375:                     .Left            = 5
376:                     .Width           = 75
377:                     .Height          = 75
378:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
379:                     .PicturePosition = 13
380:                     .FontName        = "Comic Sans MS"
381:                     .FontSize        = 8
382:                     .FontBold        = .T.
383:                     .FontItalic      = .T.
384:                     .ForeColor       = RGB(90, 90, 90)
385:                     .BackColor       = RGB(255, 255, 255)
386:                     .SpecialEffect   = 0
387:                     .MousePointer    = 15
388:                     .WordWrap        = .T.
389:                     .Visible         = .T.
390:                 ENDWITH
391: 
392:                 .AddObject("cmd_4c_Cancelar", "CommandButton")
393:                 WITH .cmd_4c_Cancelar
394:                     .Caption         = "Encerrar"
395:                     .Top             = 5
396:                     .Left            = 80
397:                     .Width           = 75
398:                     .Height          = 75
399:                     .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
400:                     .PicturePosition = 13
401:                     .FontName        = "Comic Sans MS"
402:                     .FontSize        = 8
403:                     .FontBold        = .T.
404:                     .FontItalic      = .T.
405:                     .ForeColor       = RGB(90, 90, 90)
406:                     .BackColor       = RGB(255, 255, 255)
407:                     .Themes          = .F.
408:                     .SpecialEffect   = 0
409:                     .MousePointer    = 15
410:                     .WordWrap        = .T.
411:                     .Visible         = .T.
412:                 ENDWITH
413:             ENDWITH
414: 
415:             BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
416:             BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
417: 
418:             *-- Label "Grupo :" (Say1: Top=127, Left=324, compensacao +29 = 156)
419:             loc_oPagina.AddObject("lbl_4c_Label1", "Label")
420:             WITH loc_oPagina.lbl_4c_Label1
421:                 .Caption   = "Grupo :"
422:                 .Top       = 156
423:                 .Left      = 324
424:                 .Width     = 38
425:                 .Height    = 15
426:                 .AutoSize  = .T.
427:                 .FontName  = "Tahoma"
428:                 .FontSize  = 8

*-- Linhas 435 a 461:
435:             *-- Editavel apenas em INCLUIR (getColecoes.When = INSERIR no legado)
436:             loc_oPagina.AddObject("txt_4c_Colecoes", "TextBox")
437:             WITH loc_oPagina.txt_4c_Colecoes
438:                 .Top           = 152
439:                 .Left          = 366
440:                 .Width         = 79
441:                 .Height        = 25
442:                 .InputMask     = "XXXXXXXXXX"
443:                 .MaxLength     = 10
444:                 .SpecialEffect = 1
445:                 .FontName      = "Tahoma"
446:                 .FontSize      = 8
447:                 .Value         = ""
448:                 .Visible       = .T.
449:             ENDWITH
450: 
451:             *-- Label "Descricao :" (Say2: Top=155, Left=307, compensacao +29 = 184)
452:             loc_oPagina.AddObject("lbl_4c_Label2", "Label")
453:             WITH loc_oPagina.lbl_4c_Label2
454:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
455:                 .Top       = 184
456:                 .Left      = 307
457:                 .Width     = 55
458:                 .Height    = 15
459:                 .AutoSize  = .T.
460:                 .FontName  = "Tahoma"
461:                 .FontSize  = 8

*-- Linhas 467 a 493:
467:             *-- TextBox Descricao (getDescs: Top=151, Left=366, Width=289, compensacao +29 = 180)
468:             loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
469:             WITH loc_oPagina.txt_4c_Descricao
470:                 .Top           = 180
471:                 .Left          = 366
472:                 .Width         = 289
473:                 .Height        = 25
474:                 .InputMask     = "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
475:                 .MaxLength     = 40
476:                 .SpecialEffect = 1
477:                 .FontName      = "Tahoma"
478:                 .FontSize      = 8
479:                 .Value         = ""
480:                 .Visible       = .T.
481:             ENDWITH
482: 
483:             *-- Label "Usuario :" (Say7: Top=183, Left=317, compensacao +29 = 212)
484:             loc_oPagina.AddObject("lbl_4c_Label7", "Label")
485:             WITH loc_oPagina.lbl_4c_Label7
486:                 .Caption   = "Usu" + CHR(225) + "rio :"
487:                 .Top       = 212
488:                 .Left      = 317
489:                 .Width     = 45
490:                 .Height    = 15
491:                 .AutoSize  = .T.
492:                 .FontName  = "Tahoma"
493:                 .FontSize  = 8

*-- Linhas 500 a 524:
500:             *-- Lookup para SigCdUsu via ValidarUsuars (equivalente ao Valid/fwBuscaExt do legado)
501:             loc_oPagina.AddObject("txt_4c_Usuars", "TextBox")
502:             WITH loc_oPagina.txt_4c_Usuars
503:                 .Top           = 208
504:                 .Left          = 366
505:                 .Width         = 80
506:                 .Height        = 25
507:                 .SpecialEffect = 1
508:                 .FontName      = "Tahoma"
509:                 .FontSize      = 8
510:                 .Value         = ""
511:                 .Visible       = .T.
512:             ENDWITH
513: 
514:             *-- Label "Data de Inicio :" (Say8: Top=211, Left=287, compensacao +29 = 240)
515:             loc_oPagina.AddObject("lbl_4c_Label8", "Label")
516:             WITH loc_oPagina.lbl_4c_Label8
517:                 .Caption   = "Data de In" + CHR(237) + "cio :"
518:                 .Top       = 240
519:                 .Left      = 287
520:                 .Width     = 75
521:                 .Height    = 15
522:                 .AutoSize  = .T.
523:                 .FontName  = "Tahoma"
524:                 .FontSize  = 8

*-- Linhas 531 a 556:
531:             *-- Tipo datetime; auto-setado pelo BO no INSERT
532:             loc_oPagina.AddObject("txt_4c_DtInicial", "TextBox")
533:             WITH loc_oPagina.txt_4c_DtInicial
534:                 .Top           = 236
535:                 .Left          = 366
536:                 .Width         = 100
537:                 .Height        = 25
538:                 .SpecialEffect = 1
539:                 .FontName      = "Tahoma"
540:                 .FontSize      = 8
541:                 .Format        = "D"
542:                 .Value         = {}
543:                 .Visible       = .T.
544:             ENDWITH
545: 
546:             *-- Label "Consulta de Produtos :" (Say5: Top=238, Left=250, compensacao +29 = 267)
547:             loc_oPagina.AddObject("lbl_4c_Label5", "Label")
548:             WITH loc_oPagina.lbl_4c_Label5
549:                 .Caption   = "Consulta de Produtos :"
550:                 .Top       = 267
551:                 .Left      = 250
552:                 .Width     = 112
553:                 .Height    = 15
554:                 .AutoSize  = .F.
555:                 .FontName  = "Tahoma"
556:                 .FontSize  = 8

*-- Linhas 564 a 607:
564:             loc_oPagina.AddObject("opt_4c_ConProds", "OptionGroup")
565:             WITH loc_oPagina.opt_4c_ConProds
566:                 .ButtonCount = 2
567:                 .Top         = 264
568:                 .Left        = 362
569:                 .Width       = 95
570:                 .Height      = 25
571:                 .BackStyle   = 0
572:                 .BorderStyle = 0
573:                 .Value       = 2
574:                 .Visible     = .T.
575:                 WITH .Buttons(1)
576:                     .Caption   = "S"
577:                     .Left      = 5
578:                     .Top       = 5
579:                     .Width     = 40
580:                     .AutoSize  = .T.
581:                     .ForeColor = RGB(90, 90, 90)
582:                     .Themes    = .F.
583:                 ENDWITH
584:                 WITH .Buttons(2)
585:                     .Caption   = "N"
586:                     .Left      = 48
587:                     .Top       = 5
588:                     .Width     = 40
589:                     .AutoSize  = .T.
590:                     .FontName  = "Tahoma"
591:                     .FontSize  = 8
592:                     .ForeColor = RGB(90, 90, 90)
593:                     .Themes    = .F.
594:                 ENDWITH
595:             ENDWITH
596: 
597:             *-- Label "Alertar ao Alterar Produtos :" (Say6: Top=260, Left=223, comp +29 = 289)
598:             loc_oPagina.AddObject("lbl_4c_Label6", "Label")
599:             WITH loc_oPagina.lbl_4c_Label6
600:                 .Caption   = "Alertar ao Alterar Produtos :"
601:                 .Top       = 289
602:                 .Left      = 223
603:                 .Width     = 139
604:                 .Height    = 15
605:                 .AutoSize  = .F.
606:                 .FontName  = "Tahoma"
607:                 .FontSize  = 8

*-- Linhas 615 a 658:
615:             loc_oPagina.AddObject("opt_4c_AltProds", "OptionGroup")
616:             WITH loc_oPagina.opt_4c_AltProds
617:                 .ButtonCount = 2
618:                 .Top         = 284
619:                 .Left        = 362
620:                 .Width       = 95
621:                 .Height      = 25
622:                 .BackStyle   = 0
623:                 .BorderStyle = 0
624:                 .Value       = 2
625:                 .Visible     = .T.
626:                 WITH .Buttons(1)
627:                     .Caption   = "S"
628:                     .Left      = 5
629:                     .Top       = 5
630:                     .Width     = 40
631:                     .AutoSize  = .T.
632:                     .ForeColor = RGB(90, 90, 90)
633:                     .Themes    = .F.
634:                 ENDWITH
635:                 WITH .Buttons(2)
636:                     .Caption   = "N"
637:                     .Left      = 48
638:                     .Top       = 5
639:                     .Width     = 40
640:                     .AutoSize  = .T.
641:                     .FontName  = "Tahoma"
642:                     .FontSize  = 8
643:                     .ForeColor = RGB(90, 90, 90)
644:                     .Themes    = .F.
645:                 ENDWITH
646:             ENDWITH
647: 
648:             *-- Label "Agrupamento :" (Say9: Top=285, Left=288, comp +29 = 314)
649:             loc_oPagina.AddObject("lbl_4c_Label9", "Label")
650:             WITH loc_oPagina.lbl_4c_Label9
651:                 .Caption   = "Agrupamento :"
652:                 .Top       = 314
653:                 .Left      = 288
654:                 .Width     = 74
655:                 .Height    = 15
656:                 .AutoSize  = .F.
657:                 .FontName  = "Tahoma"
658:                 .FontSize  = 8

*-- Linhas 665 a 674:
665:             *-- Mapeado em this_cAgrupas (agrupas char(10))
666:             loc_oPagina.AddObject("txt_4c_Agrupa", "TextBox")
667:             WITH loc_oPagina.txt_4c_Agrupa
668:                 .Top           = 310
669:                 .Left          = 367
670:                 .Width         = 79
671:                 .Height        = 25
672:                 .MaxLength     = 10
673:                 .SpecialEffect = 1
674:                 .FontName      = "Tahoma"

*-- Linhas 712 a 722:
712:                         loc_oGrid.Column3.Width = 75
713: 
714:                         *-- Reconfigurar cabecalhos APOS RecordSource (VFP reseta captions)
715:                         loc_oGrid.Column1.Header1.Caption = "Grupo"
716:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
717:                         loc_oGrid.Column3.Header1.Caption = "Cod. Coletor"
718: 
719:                         THIS.FormatarGridLista(loc_oGrid)
720:                         loc_lResultado = .T.
721:                     ENDIF
722:                 ENDIF

*-- Linhas 834 a 843:
834: 
835:         TRY
836:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
837:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = par_lHabilitar
838:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
839:             ENDIF
840: 
841:             *-- Colecoes: editavel apenas em INCLUIR (getColecoes.When = INSERIR no legado)
842:             IF PEMSTATUS(loc_oPg2, "txt_4c_Colecoes", 5)
843:                 loc_oPg2.txt_4c_Colecoes.ReadOnly = ;

*-- Linhas 912 a 922:
912: 
913:         TRY
914:             IF PEMSTATUS(loc_oPg2, "cnt_4c_Salva", 5)
915:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = ;
916:                     INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
917:                 loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled = .T.
918:             ENDIF
919:         CATCH TO loc_oErro
920:             MostrarErro("Erro em AjustarBotoesPorModo:" + CHR(13) + loc_oErro.Message, "FormCol.AjustarBotoesPorModo")
921:         ENDTRY
922:     ENDPROC


### BO (C:\4c\projeto\app\classes\ColBO.prg):
*------------------------------------------------------------------------------
* ColBO.prg - Business Object para Cadastro de Grupo de Venda
* Tabela: SigCdCol | PK: colecoes
* Herda de: BusinessBase
*------------------------------------------------------------------------------

DEFINE CLASS ColBO AS BusinessBase

    *-- Propriedades mapeadas da tabela SigCdCol (schema.sql)
    *-- colecoes char(10) NOT NULL (PK)
    this_cColecoes  = ""
    *-- descs char(40) NOT NULL
    this_cDescs     = ""
    *-- codcols char(1) NOT NULL
    this_cCodcols   = ""
    *-- repoauts numeric(1,0) NOT NULL
    this_nRepoauts  = 0
    *-- conprods numeric(1,0) NOT NULL
    this_nConprods  = 0
    *-- altprods numeric(1,0) NOT NULL
    this_nAltProds  = 0
    *-- dtincs datetime NULL
    this_tDtIncs    = {}
    *-- usuars char(10) NOT NULL
    this_cUsuars    = ""
    *-- agrupas char(10) NOT NULL
    this_cAgrupas   = ""

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCol"
            THIS.this_cCampoChave = "colecoes"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "ColBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cColecoes)
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cColecoes  = TratarNulo(colecoes, "C")
                THIS.this_cDescs     = TratarNulo(descs,    "C")
                THIS.this_cCodcols   = TratarNulo(codcols,  "C")
                THIS.this_nRepoauts  = TratarNulo(repoauts, "N")
                THIS.this_nConprods  = TratarNulo(conprods, "N")
                THIS.this_nAltProds  = TratarNulo(altprods, "N")
                THIS.this_tDtIncs    = TratarNulo(dtincs,   "T")
                THIS.this_cUsuars    = TratarNulo(usuars,   "C")
                THIS.this_cAgrupas   = TratarNulo(agrupas,  "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "ColBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de salvar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cColecoes)
            MsgAviso("Grupo de Venda Inv" + CHR(225) + "lido.")
            loc_lValido = .F.
        ENDIF

        IF EMPTY(THIS.this_cDescs)
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida.")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro na tabela SigCdCol
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Definir usuario e data/hora de inclusao automaticamente
            THIS.this_cUsuars = ALLTRIM(gc_4c_UsuarioLogado)
            THIS.this_tDtIncs = DATETIME()

            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdCol (colecoes, descs, codcols, repoauts, conprods, altprods, dtincs, usuars, agrupas)
                VALUES (
                    <<EscaparSQL(THIS.this_cColecoes)>>,
                    <<EscaparSQL(THIS.this_cDescs)>>,
                    <<EscaparSQL(THIS.this_cCodcols)>>,
                    <<FormatarNumeroSQL(THIS.this_nRepoauts, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nConprods, 0)>>,
                    <<FormatarNumeroSQL(THIS.this_nAltProds, 0)>>,
                    GETDATE(),
                    <<EscaparSQL(THIS.this_cUsuars)>>,
                    <<EscaparSQL(THIS.this_cAgrupas)>>
                )
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "ColBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente na tabela SigCdCol
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdCol
                SET descs    = <<EscaparSQL(THIS.this_cDescs)>>,
                    codcols  = <<EscaparSQL(THIS.this_cCodcols)>>,
                    repoauts = <<FormatarNumeroSQL(THIS.this_nRepoauts, 0)>>,
                    conprods = <<FormatarNumeroSQL(THIS.this_nConprods, 0)>>,
                    altprods = <<FormatarNumeroSQL(THIS.this_nAltProds, 0)>>,
                    agrupas  = <<EscaparSQL(THIS.this_cAgrupas)>>
                WHERE colecoes = <<EscaparSQL(THIS.this_cColecoes)>>
            ENDTEXT

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "ColBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro da tabela SigCdCol
    * Verifica dependencia em SigCdPro antes de excluir
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se produtos utilizam este grupo de venda
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdPro WHERE Colecoes = " + ;
                EscaparSQL(THIS.this_cColecoes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkPro")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkPro")
                SELECT cursor_4c_ChkPro
                loc_nUso = cursor_4c_ChkPro.qtd
                USE IN cursor_4c_ChkPro
                IF loc_nUso > 0
                    MsgAviso("Existem Produtos Utilizando Esse Grupo de Venda.")
                    loc_lSucesso = .F.
                ELSE
                    loc_cSQL = "DELETE FROM SigCdCol WHERE colecoes = " + ;
                        EscaparSQL(THIS.this_cColecoes)
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResultado >= 0
                        THIS.RegistrarAuditoria("DELETE")
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao excluir grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ELSE
                MostrarErro("Erro ao verificar depend" + CHR(234) + "ncias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "ColBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com colecoes, descs, codcols
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (colecoes C(10), descs C(40), codcols C(1))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT colecoes, descs, codcols FROM SigCdCol"

                IF !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY colecoes"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        USE IN cursor_4c_DadosTmp
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar grupos de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "ColBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pela chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT colecoes, descs, codcols, repoauts, conprods, altprods," + ;
                " dtincs, usuars, agrupas" + ;
                " FROM SigCdCol WHERE colecoes = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Grupo de Venda n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar grupo de venda:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "ColBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarCodigoColetor - Verifica se codcols ja existe em outro registro
    *--------------------------------------------------------------------------
    PROCEDURE VerificarCodigoColetor(par_cCodcols)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            IF !EMPTY(par_cCodcols)
                loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCol" + ;
                    " WHERE codcols = " + EscaparSQL(par_cCodcols) + ;
                    " AND colecoes <> " + EscaparSQL(THIS.this_cColecoes)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
                IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                    SELECT cursor_4c_ChkCod
                    loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
                    USE IN cursor_4c_ChkCod
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo coletor:" + CHR(13) + loException.Message, "ColBO.VerificarCodigoColetor")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarColecaoExistente - Verifica se colecoes ja existe (para INSERT)
    *--------------------------------------------------------------------------
    PROCEDURE VerificarColecaoExistente(par_cColecoes)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdCol" + ;
                " WHERE colecoes = " + EscaparSQL(par_cColecoes)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCol")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCol")
                SELECT cursor_4c_ChkCol
                loc_lExiste = (cursor_4c_ChkCol.qtd > 0)
                USE IN cursor_4c_ChkCol
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar cole" + CHR(231) + CHR(227) + "o:" + CHR(13) + loException.Message, "ColBO.VerificarColecaoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

ENDDEFINE

