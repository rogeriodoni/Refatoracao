# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 171: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 191: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 212: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 254: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 290: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 474: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 494: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormLGR.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1502 linhas total):

*-- Linhas 73 a 137:
73:     PROTECTED PROCEDURE ConfigurarPageFrame()
74:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
75:         WITH THIS.pgf_4c_Paginas
76:             .Top       = -29
77:             .Left      = 0
78:             .Width     = THIS.Width
79:             .Height    = THIS.Height + 29
80:             .PageCount = 2
81:             .Tabs      = .F.
82:             .Visible   = .T.
83:             .Page1.Caption   = "Lista"
84:             .Page1.BackColor = RGB(225, 225, 225)
85:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
86:             .Page2.Caption   = "Dados"
87:             .Page2.BackColor = RGB(225, 225, 225)
88:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
89:         ENDWITH
90:     ENDPROC
91: 
92:     *==========================================================================
93:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, filtros, grid
94:     * Compensacao PageFrame.Top=-29: todos os Tops originais + 29
95:     *==========================================================================
96:     PROTECTED PROCEDURE ConfigurarPaginaLista()
97:         LOCAL loc_oPagina
98:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
99: 
100:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
101:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102: 
103:         *-- Cabecalho cinza escuro com titulo (Top original=2, +29comp=31)
104:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
105:         WITH loc_oPagina.cnt_4c_Cabecalho
106:             .Top         = 31
107:             .Left        = 0
108:             .Width       = THIS.Width
109:             .Height      = 80
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible     = .T.
113:             .AddObject("lbl_4c_Sombra", "Label")
114:             WITH .lbl_4c_Sombra
115:                 .Caption   = THIS.Caption
116:                 .Top       = 15
117:                 .Left      = 10
118:                 .Width     = THIS.Width
119:                 .Height    = 40
120:                 .FontName  = "Tahoma"
121:                 .FontSize  = 16
122:                 .FontBold  = .T.
123:                 .ForeColor = RGB(0, 0, 0)
124:                 .BackStyle = 0
125:                 .AutoSize  = .F.
126:                 .Visible   = .T.
127:             ENDWITH
128:             .AddObject("lbl_4c_Titulo", "Label")
129:             WITH .lbl_4c_Titulo
130:                 .Caption   = THIS.Caption
131:                 .Top       = 18
132:                 .Left      = 10
133:                 .Width     = THIS.Width
134:                 .Height    = 46
135:                 .FontName  = "Tahoma"
136:                 .FontSize  = 16
137:                 .FontBold  = .T.

*-- Linhas 145 a 260:
145:         *-- Container botoes CRUD (Grupo_Op canonico: Top=29, Left=542, Width=390)
146:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
147:         WITH loc_oPagina.cnt_4c_Botoes
148:             .Top         = 29
149:             .Left        = 542
150:             .Width       = 390
151:             .Height      = 85
152:             .BackStyle   = 1
153:             .BackColor   = RGB(53, 53, 53)
154:             .BorderWidth = 0
155:             .Visible     = .T.
156:         ENDWITH
157: 
158:         *-- Botoes CRUD dentro de cnt_4c_Botoes
159:         WITH loc_oPagina.cnt_4c_Botoes
160:             .AddObject("cmd_4c_Incluir", "CommandButton")
161:             WITH .cmd_4c_Incluir
162:                 .Caption         = "Incluir"
163:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
164:                 .PicturePosition = 13
165:                 .Top             = 5
166:                 .Left            = 5
167:                 .Width           = 75
168:                 .Height          = 75
169:                 .BackColor       = RGB(255, 255, 255)
170:                 .ForeColor       = RGB(90, 90, 90)
171:                 .FontName        = "Comic Sans MS"
172:                 .FontSize        = 8
173:                 .FontBold        = .T.
174:                 .FontItalic      = .T.
175:                 .SpecialEffect   = 0
176:                 .MousePointer    = 15
177:                 .WordWrap        = .T.
178:                 .Visible         = .T.
179:             ENDWITH
180:             .AddObject("cmd_4c_Visualizar", "CommandButton")
181:             WITH .cmd_4c_Visualizar
182:                 .Caption         = "Visualizar"
183:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
184:                 .PicturePosition = 13
185:                 .Top             = 5
186:                 .Left            = 80
187:                 .Width           = 75
188:                 .Height          = 75
189:                 .BackColor       = RGB(255, 255, 255)
190:                 .ForeColor       = RGB(90, 90, 90)
191:                 .FontName        = "Comic Sans MS"
192:                 .FontSize        = 8
193:                 .FontBold        = .T.
194:                 .FontItalic      = .T.
195:                 .Themes          = .F.
196:                 .SpecialEffect   = 0
197:                 .MousePointer    = 15
198:                 .WordWrap        = .T.
199:                 .Visible         = .T.
200:             ENDWITH
201:             .AddObject("cmd_4c_Alterar", "CommandButton")
202:             WITH .cmd_4c_Alterar
203:                 .Caption         = "Alterar"
204:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
205:                 .PicturePosition = 13
206:                 .Top             = 5
207:                 .Left            = 155
208:                 .Width           = 75
209:                 .Height          = 75
210:                 .BackColor       = RGB(255, 255, 255)
211:                 .ForeColor       = RGB(90, 90, 90)
212:                 .FontName        = "Comic Sans MS"
213:                 .FontSize        = 8
214:                 .FontBold        = .T.
215:                 .FontItalic      = .T.
216:                 .Themes          = .F.
217:                 .SpecialEffect   = 0
218:                 .MousePointer    = 15
219:                 .WordWrap        = .T.
220:                 .Visible         = .T.
221:             ENDWITH
222:             .AddObject("cmd_4c_Excluir", "CommandButton")
223:             WITH .cmd_4c_Excluir
224:                 .Caption         = "Excluir"
225:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
226:                 .PicturePosition = 13
227:                 .Top             = 5
228:                 .Left            = 230
229:                 .Width           = 75
230:                 .Height          = 75
231:                 .BackColor       = RGB(255, 255, 255)
232:                 .ForeColor       = RGB(90, 90, 90)
233:                 .FontName        = "Comic Sans MS"
234:                 .FontSize        = 8
235:                 .FontBold        = .T.
236:                 .FontItalic      = .T.
237:                 .Themes          = .F.
238:                 .SpecialEffect   = 0
239:                 .MousePointer    = 15
240:                 .WordWrap        = .T.
241:                 .Visible         = .T.
242:             ENDWITH
243:             .AddObject("cmd_4c_Buscar", "CommandButton")
244:             WITH .cmd_4c_Buscar
245:                 .Caption         = "Buscar"
246:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
247:                 .PicturePosition = 13
248:                 .Top             = 5
249:                 .Left            = 305
250:                 .Width           = 75
251:                 .Height          = 75
252:                 .BackColor       = RGB(255, 255, 255)
253:                 .ForeColor       = RGB(90, 90, 90)
254:                 .FontName        = "Comic Sans MS"
255:                 .FontSize        = 8
256:                 .FontBold        = .T.
257:                 .FontItalic      = .T.
258:                 .Themes          = .F.
259:                 .SpecialEffect   = 0
260:                 .MousePointer    = 15

*-- Linhas 266 a 323:
266:         *-- Container Encerrar (canonico: Left=917, Width=90, BackStyle=0)
267:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
268:         WITH loc_oPagina.cnt_4c_Saida
269:             .Top         = 29
270:             .Left        = 917
271:             .Width       = 90
272:             .Height      = 85
273:             .BackStyle   = 0
274:             .BorderWidth = 0
275:             .Visible     = .T.
276:         ENDWITH
277: 
278:         WITH loc_oPagina.cnt_4c_Saida
279:             .AddObject("cmd_4c_Encerrar", "CommandButton")
280:             WITH .cmd_4c_Encerrar
281:                 .Caption         = "Encerrar"
282:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
283:                 .PicturePosition = 13
284:                 .Top             = 5
285:                 .Left            = 5
286:                 .Width           = 75
287:                 .Height          = 75
288:                 .BackColor       = RGB(255, 255, 255)
289:                 .ForeColor       = RGB(90, 90, 90)
290:                 .FontName        = "Comic Sans MS"
291:                 .FontSize        = 8
292:                 .FontBold        = .T.
293:                 .FontItalic      = .T.
294:                 .SpecialEffect   = 0
295:                 .MousePointer    = 15
296:                 .WordWrap        = .T.
297:                 .Visible         = .T.
298:             ENDWITH
299:         ENDWITH
300: 
301:         *-- Container visual dos filtros (faixa de fundo, transparente)
302:         loc_oPagina.AddObject("cnt_4c_Filtros", "Container")
303:         WITH loc_oPagina.cnt_4c_Filtros
304:             .Top         = 115
305:             .Left        = 0
306:             .Width       = 730
307:             .Height      = 70
308:             .BackStyle   = 0
309:             .BorderWidth = 0
310:             .Visible     = .T.
311:         ENDWITH
312: 
313:         *-- Label Serie de Fabricacao (original Top=129, Left=36 -> +29=158)
314:         loc_oPagina.AddObject("lbl_4c_SerieFab", "Label")
315:         WITH loc_oPagina.lbl_4c_SerieFab
316:             .Caption   = "S" + CHR(233) + "rie de Fabrica" + CHR(231) + CHR(227) + "o :"
317:             .Top       = 158
318:             .Left      = 36
319:             .Width     = 110
320:             .Height    = 17
321:             .FontName  = "Tahoma"
322:             .FontSize  = 8
323:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 329 a 352:
329:         loc_oPagina.AddObject("txt_4c_SerieFab", "TextBox")
330:         WITH loc_oPagina.txt_4c_SerieFab
331:             .Value     = ""
332:             .Top       = 154
333:             .Left      = 141
334:             .Width     = 150
335:             .Height    = 23
336:             .FontName  = "Tahoma"
337:             .FontSize  = 8
338:             .MaxLength = 20
339:             .Visible   = .T.
340:         ENDWITH
341: 
342:         *-- Label Periodo (original Top=128 -> +29=157)
343:         loc_oPagina.AddObject("lbl_4c_Periodo", "Label")
344:         WITH loc_oPagina.lbl_4c_Periodo
345:             .Caption   = "Per" + CHR(237) + "odo :"
346:             .Top       = 158
347:             .Left      = 319
348:             .Width     = 55
349:             .Height    = 17
350:             .FontName  = "Tahoma"
351:             .FontSize  = 8
352:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 358 a 380:
358:         loc_oPagina.AddObject("txt_4c_Dtini", "TextBox")
359:         WITH loc_oPagina.txt_4c_Dtini
360:             .Value   = DATE()
361:             .Top     = 154
362:             .Left    = 367
363:             .Width   = 80
364:             .Height  = 23
365:             .FontName = "Tahoma"
366:             .FontSize = 8
367:             .Visible = .T.
368:         ENDWITH
369: 
370:         *-- Label Ate (original Top=129 -> +29=158)
371:         loc_oPagina.AddObject("lbl_4c_Ate", "Label")
372:         WITH loc_oPagina.lbl_4c_Ate
373:             .Caption   = "At" + CHR(233)
374:             .Top       = 158
375:             .Left      = 455
376:             .Width     = 22
377:             .Height    = 17
378:             .FontName  = "Tahoma"
379:             .FontSize  = 8
380:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 386 a 408:
386:         loc_oPagina.AddObject("txt_4c_Dtfim", "TextBox")
387:         WITH loc_oPagina.txt_4c_Dtfim
388:             .Value   = DATE()
389:             .Top     = 154
390:             .Left    = 483
391:             .Width   = 80
392:             .Height  = 23
393:             .FontName = "Tahoma"
394:             .FontSize = 8
395:             .Visible = .T.
396:         ENDWITH
397: 
398:         *-- Grid de lista (original Top=157 -> +29=186, Left=12)
399:         *-- Width=893 (form 1000 - left 12 - margem 5 = 983; deixa espaco para cnt_4c_Saida)
400:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
401:         WITH loc_oPagina.grd_4c_Lista
402:             .Top               = 186
403:             .Left              = 12
404:             .Width             = 893
405:             .Height            = 435
406:             .FontName          = "Verdana"
407:             .FontSize          = 8
408:             .ForeColor         = RGB(90, 90, 90)

*-- Linhas 421 a 516:
421:         ENDWITH
422: 
423:         *-- BINDEVENTs dos botoes CRUD (PUBLIC methods - sem PROTECTED)
424:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
425:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
426:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
427:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
428:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
429:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar,    "Click", THIS, "BtnEncerrarClick")
430: 
431:         *-- BINDEVENTs dos campos de filtro
432:         BINDEVENT(loc_oPagina.txt_4c_SerieFab, "KeyPress", THIS, "ValidarSerieFab")
433:         BINDEVENT(loc_oPagina.txt_4c_Dtini,    "KeyPress", THIS, "ValidarDtini")
434:         BINDEVENT(loc_oPagina.txt_4c_Dtfim,    "KeyPress", THIS, "ValidarDtfim")
435: 
436:         THIS.TornarControlesVisiveis(loc_oPagina)
437:     ENDPROC
438: 
439:     *==========================================================================
440:     * ConfigurarPaginaDados - Page2: campos de edicao e botoes salvar/cancelar
441:     * Compensacao PageFrame.Top=-29: todos os Tops originais + 29
442:     *==========================================================================
443:     PROTECTED PROCEDURE ConfigurarPaginaDados()
444:         LOCAL loc_oPagina
445:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
446: 
447:         *-- Fundo padrao do framework frmcadastro (sem isso a pagina fica branca)
448:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
449: 
450:         *-- Container botoes Confirmar/Cancelar (grupo_salva canonico)
451:         loc_oPagina.AddObject("cnt_4c_Salva", "Container")
452:         WITH loc_oPagina.cnt_4c_Salva
453:             .Top         = 33
454:             .Left        = 842
455:             .Width       = 160
456:             .Height      = 85
457:             .BackStyle   = 0
458:             .BorderWidth = 0
459:             .Visible     = .T.
460:         ENDWITH
461: 
462:         WITH loc_oPagina.cnt_4c_Salva
463:             .AddObject("cmd_4c_Confirmar", "CommandButton")
464:             WITH .cmd_4c_Confirmar
465:                 .Caption         = "Confirmar"
466:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
467:                 .PicturePosition = 13
468:                 .Top             = 5
469:                 .Left            = 5
470:                 .Width           = 75
471:                 .Height          = 75
472:                 .BackColor       = RGB(255, 255, 255)
473:                 .ForeColor       = RGB(90, 90, 90)
474:                 .FontName        = "Comic Sans MS"
475:                 .FontSize        = 8
476:                 .FontBold        = .T.
477:                 .FontItalic      = .T.
478:                 .SpecialEffect   = 0
479:                 .MousePointer    = 15
480:                 .WordWrap        = .T.
481:                 .Visible         = .T.
482:             ENDWITH
483:             .AddObject("cmd_4c_Cancelar", "CommandButton")
484:             WITH .cmd_4c_Cancelar
485:                 .Caption         = "Encerrar"
486:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
487:                 .PicturePosition = 13
488:                 .Top             = 5
489:                 .Left            = 80
490:                 .Width           = 75
491:                 .Height          = 75
492:                 .BackColor       = RGB(255, 255, 255)
493:                 .ForeColor       = RGB(90, 90, 90)
494:                 .FontName        = "Comic Sans MS"
495:                 .FontSize        = 8
496:                 .FontBold        = .T.
497:                 .FontItalic      = .T.
498:                 .Themes          = .F.
499:                 .SpecialEffect   = 0
500:                 .MousePointer    = 15
501:                 .WordWrap        = .T.
502:                 .Visible         = .T.
503:             ENDWITH
504:         ENDWITH
505: 
506:         *-- Label NFAB (Say1: original top=151 -> +29=180, left=167)
507:         loc_oPagina.AddObject("lbl_4c_Nfab", "Label")
508:         WITH loc_oPagina.lbl_4c_Nfab
509:             .Caption   = "No Fabrica" + CHR(231) + CHR(227) + "o - NFAB. :"
510:             .Top       = 180
511:             .Left      = 167
512:             .Width     = 140
513:             .Height    = 17
514:             .FontName  = "Tahoma"
515:             .FontSize  = 8
516:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 522 a 546:
522:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
523:         WITH loc_oPagina.txt_4c_Codigo
524:             .Value     = ""
525:             .Top       = 177
526:             .Left      = 312
527:             .Width     = 157
528:             .Height    = 23
529:             .FontName  = "Tahoma"
530:             .FontSize  = 8
531:             .ReadOnly  = .T.
532:             .MaxLength = 40
533:             .Visible   = .T.
534:         ENDWITH
535: 
536:         *-- Label Modelo (Say16: original top=178 -> +29=207, left=253)
537:         loc_oPagina.AddObject("lbl_4c_Modelo", "Label")
538:         WITH loc_oPagina.lbl_4c_Modelo
539:             .Caption   = "Modelo :"
540:             .Top       = 207
541:             .Left      = 253
542:             .Width     = 55
543:             .Height    = 17
544:             .FontName  = "Tahoma"
545:             .FontSize  = 8
546:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 552 a 575:
552:         loc_oPagina.AddObject("txt_4c_Modelo", "TextBox")
553:         WITH loc_oPagina.txt_4c_Modelo
554:             .Value     = ""
555:             .Top       = 204
556:             .Left      = 312
557:             .Width     = 150
558:             .Height    = 23
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:             .MaxLength = 20
562:             .Visible   = .T.
563:         ENDWITH
564: 
565:         *-- Label COO (Say2: original top=205 -> +29=234, left=266)
566:         loc_oPagina.AddObject("lbl_4c_Coo", "Label")
567:         WITH loc_oPagina.lbl_4c_Coo
568:             .Caption   = "COO :"
569:             .Top       = 234
570:             .Left      = 266
571:             .Width     = 40
572:             .Height    = 17
573:             .FontName  = "Tahoma"
574:             .FontSize  = 8
575:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 581 a 604:
581:         loc_oPagina.AddObject("txt_4c_Coo", "TextBox")
582:         WITH loc_oPagina.txt_4c_Coo
583:             .Value     = "000000"
584:             .Top       = 231
585:             .Left      = 312
586:             .Width     = 50
587:             .Height    = 23
588:             .FontName  = "Tahoma"
589:             .FontSize  = 8
590:             .MaxLength = 6
591:             .Visible   = .T.
592:         ENDWITH
593: 
594:         *-- Label Cupom nao Fiscal (Say3: original top=232 -> +29=261, left=192)
595:         loc_oPagina.AddObject("lbl_4c_Cnf", "Label")
596:         WITH loc_oPagina.lbl_4c_Cnf
597:             .Caption   = "Cupom n" + CHR(227) + "o Fiscal :"
598:             .Top       = 261
599:             .Left      = 192
600:             .Width     = 115
601:             .Height    = 17
602:             .FontName  = "Tahoma"
603:             .FontSize  = 8
604:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 610 a 633:
610:         loc_oPagina.AddObject("txt_4c_Cnf", "TextBox")
611:         WITH loc_oPagina.txt_4c_Cnf
612:             .Value     = ""
613:             .Top       = 258
614:             .Left      = 312
615:             .Width     = 50
616:             .Height    = 23
617:             .FontName  = "Tahoma"
618:             .FontSize  = 8
619:             .MaxLength = 6
620:             .Visible   = .T.
621:         ENDWITH
622: 
623:         *-- Label Relatorios Gerenciais (Say4: original top=259 -> +29=288, left=171)
624:         loc_oPagina.AddObject("lbl_4c_Rg", "Label")
625:         WITH loc_oPagina.lbl_4c_Rg
626:             .Caption   = "Relat" + CHR(243) + "rios Gerenciais :"
627:             .Top       = 288
628:             .Left      = 171
629:             .Width     = 135
630:             .Height    = 17
631:             .FontName  = "Tahoma"
632:             .FontSize  = 8
633:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 639 a 662:
639:         loc_oPagina.AddObject("txt_4c_Rg", "TextBox")
640:         WITH loc_oPagina.txt_4c_Rg
641:             .Value     = ""
642:             .Top       = 285
643:             .Left      = 312
644:             .Width     = 50
645:             .Height    = 23
646:             .FontName  = "Tahoma"
647:             .FontSize  = 8
648:             .MaxLength = 6
649:             .Visible   = .T.
650:         ENDWITH
651: 
652:         *-- Label Demonstrativo Credito/Debito (Say5: original top=286 -> +29=315, left=92)
653:         loc_oPagina.AddObject("lbl_4c_Dcd", "Label")
654:         WITH loc_oPagina.lbl_4c_Dcd
655:             .Caption   = "Demonstrativo de Cr" + CHR(233) + "dito e D" + CHR(233) + "bito :"
656:             .Top       = 315
657:             .Left      = 92
658:             .Width     = 215
659:             .Height    = 17
660:             .FontName  = "Tahoma"
661:             .FontSize  = 8
662:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 668 a 691:
668:         loc_oPagina.AddObject("txt_4c_Dcd", "TextBox")
669:         WITH loc_oPagina.txt_4c_Dcd
670:             .Value     = ""
671:             .Top       = 312
672:             .Left      = 312
673:             .Width     = 38
674:             .Height    = 23
675:             .FontName  = "Tahoma"
676:             .FontSize  = 8
677:             .MaxLength = 4
678:             .Visible   = .T.
679:         ENDWITH
680: 
681:         *-- Label Reducao Z (Say6: original top=313 -> +29=342, left=231)
682:         loc_oPagina.AddObject("lbl_4c_Rz", "Label")
683:         WITH loc_oPagina.lbl_4c_Rz
684:             .Caption   = "Redu" + CHR(231) + CHR(227) + "o Z :"
685:             .Top       = 342
686:             .Left      = 231
687:             .Width     = 75
688:             .Height    = 17
689:             .FontName  = "Tahoma"
690:             .FontSize  = 8
691:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 697 a 720:
697:         loc_oPagina.AddObject("txt_4c_Rz", "TextBox")
698:         WITH loc_oPagina.txt_4c_Rz
699:             .Value     = ""
700:             .Top       = 339
701:             .Left      = 312
702:             .Width     = 50
703:             .Height    = 23
704:             .FontName  = "Tahoma"
705:             .FontSize  = 8
706:             .MaxLength = 6
707:             .Visible   = .T.
708:         ENDWITH
709: 
710:         *-- Label Tipo de Documento (Say7: original top=340 -> +29=369, left=181)
711:         loc_oPagina.AddObject("lbl_4c_Tipo", "Label")
712:         WITH loc_oPagina.lbl_4c_Tipo
713:             .Caption   = "Tipo de Documento :"
714:             .Top       = 369
715:             .Left      = 181
716:             .Width     = 125
717:             .Height    = 17
718:             .FontName  = "Tahoma"
719:             .FontSize  = 8
720:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 726 a 749:
726:         loc_oPagina.AddObject("txt_4c_Tipo", "TextBox")
727:         WITH loc_oPagina.txt_4c_Tipo
728:             .Value     = ""
729:             .Top       = 366
730:             .Left      = 312
731:             .Width     = 50
732:             .Height    = 23
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .MaxLength = 2
736:             .Visible   = .T.
737:         ENDWITH
738: 
739:         *-- Label Data do Movimento (Say23: original top=367 -> +29=396, left=181)
740:         loc_oPagina.AddObject("lbl_4c_Dtmov", "Label")
741:         WITH loc_oPagina.lbl_4c_Dtmov
742:             .Caption   = "Data do Movimento :"
743:             .Top       = 396
744:             .Left      = 181
745:             .Width     = 125
746:             .Height    = 17
747:             .FontName  = "Tahoma"
748:             .FontSize  = 8
749:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 755 a 777:
755:         loc_oPagina.AddObject("txt_4c_Dtmov", "TextBox")
756:         WITH loc_oPagina.txt_4c_Dtmov
757:             .Value   = DATE()
758:             .Top     = 393
759:             .Left    = 312
760:             .Width   = 80
761:             .Height  = 23
762:             .FontName = "Tahoma"
763:             .FontSize = 8
764:             .Visible = .T.
765:         ENDWITH
766: 
767:         *-- Label Hora do Movimento (Say24: original top=394 -> +29=423, left=181)
768:         loc_oPagina.AddObject("lbl_4c_Hrmov", "Label")
769:         WITH loc_oPagina.lbl_4c_Hrmov
770:             .Caption   = "Hora do Movimento :"
771:             .Top       = 423
772:             .Left      = 181
773:             .Width     = 125
774:             .Height    = 17
775:             .FontName  = "Tahoma"
776:             .FontSize  = 8
777:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 783 a 803:
783:         loc_oPagina.AddObject("txt_4c_Hrmov", "TextBox")
784:         WITH loc_oPagina.txt_4c_Hrmov
785:             .Value     = ""
786:             .Top       = 420
787:             .Left      = 312
788:             .Width     = 80
789:             .Height    = 23
790:             .FontName  = "Tahoma"
791:             .FontSize  = 8
792:             .MaxLength = 8
793:             .Visible   = .T.
794:         ENDWITH
795: 
796:         *-- BINDEVENTs botoes Page2 (PUBLIC methods)
797:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
798:         BINDEVENT(loc_oPagina.cnt_4c_Salva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
799: 
800:         *-- BINDEVENTs formatadores e lookups de campos Page2
801:         BINDEVENT(loc_oPagina.txt_4c_Modelo, "KeyPress", THIS, "ValidarModelo")
802:         BINDEVENT(loc_oPagina.txt_4c_Coo,    "LostFocus", THIS, "FormatarCoo")
803:         BINDEVENT(loc_oPagina.txt_4c_Cnf,    "LostFocus", THIS, "FormatarCnf")

*-- Linhas 853 a 896:
853:                     WITH loc_oGrid
854:                         .Column1.ControlSource    = "cursor_4c_Dados.cserifab"
855:                         .Column1.Width            = 120
856:                         .Column1.Header1.Caption  = "S" + CHR(233) + "rie"
857:                         .Column1.ReadOnly         = .T.
858: 
859:                         .Column2.ControlSource    = "cursor_4c_Dados.cmarcas"
860:                         .Column2.Width            = 120
861:                         .Column2.Header1.Caption  = "Marca"
862:                         .Column2.ReadOnly         = .T.
863: 
864:                         .Column3.ControlSource    = "cursor_4c_Dados.cmodelos"
865:                         .Column3.Width            = 100
866:                         .Column3.Header1.Caption  = "Modelo"
867:                         .Column3.ReadOnly         = .T.
868: 
869:                         .Column4.ControlSource    = "cursor_4c_Dados.ccoos"
870:                         .Column4.Width            = 60
871:                         .Column4.Header1.Caption  = "COO"
872:                         .Column4.ReadOnly         = .T.
873: 
874:                         .Column5.ControlSource    = "cursor_4c_Dados.cdatas"
875:                         .Column5.Width            = 80
876:                         .Column5.Header1.Caption  = "Data"
877:                         .Column5.ReadOnly         = .T.
878: 
879:                         .Column6.ControlSource    = "cursor_4c_Dados.choras"
880:                         .Column6.Width            = 60
881:                         .Column6.Header1.Caption  = "Hora"
882:                         .Column6.ReadOnly         = .T.
883: 
884:                         .Column7.ControlSource    = "cursor_4c_Dados.ctipos"
885:                         .Column7.Width            = 60
886:                         .Column7.Header1.Caption  = "Tipo"
887:                         .Column7.ReadOnly         = .T.
888: 
889:                         .Column8.ControlSource    = "cursor_4c_Dados.cincmans"
890:                         .Column8.Width            = 60
891:                         .Column8.Header1.Caption  = "Inc.Man."
892:                         .Column8.ReadOnly         = .T.
893:                     ENDWITH
894: 
895:                     THIS.FormatarGridLista(loc_oGrid)
896:                     loc_oGrid.Refresh()

*-- Linhas 1134 a 1149:
1134:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1135: 
1136:         WITH THIS.this_oBusinessObject
1137:             loc_oPg2.txt_4c_Codigo.Value = .this_cIdChaves
1138:             loc_oPg2.txt_4c_Modelo.Value = .this_cModelos
1139:             loc_oPg2.txt_4c_Coo.Value    = .this_cCoos
1140:             loc_oPg2.txt_4c_Cnf.Value    = .this_cGnfs
1141:             loc_oPg2.txt_4c_Rg.Value     = .this_cGrgs
1142:             loc_oPg2.txt_4c_Dcd.Value    = .this_cCdcs
1143:             loc_oPg2.txt_4c_Rz.Value     = .this_cCrzs
1144:             loc_oPg2.txt_4c_Tipo.Value   = .this_cDoctos
1145: 
1146:             *-- Data: string YYYYMMDD -> Date (via STOD)
1147:             loc_cDatas = ALLTRIM(.this_cDatas)
1148:             IF LEN(loc_cDatas) = 8
1149:                 loc_oPg2.txt_4c_Dtmov.Value = STOD(loc_cDatas)

*-- Linhas 1209 a 1218:
1209:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1210:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1211: 
1212:         loc_oPg2.cnt_4c_Salva.cmd_4c_Confirmar.Enabled = loc_lEditar
1213:         loc_oPg2.cnt_4c_Salva.cmd_4c_Cancelar.Enabled  = .T.
1214:     ENDPROC
1215: 
1216:     *==========================================================================
1217:     * ValidarSerieFab - LostFocus do campo serie em Page1
1218:     * Valida serie contra SigFiMpf e abre picker se nao encontrar exato


### BO (C:\4c\projeto\app\classes\LGRBO.prg):
*==============================================================================
* LGRBO.prg - Business Object para Livro de Gerenciamento Fiscal (SigFiGfd)
* Herda de: BusinessBase
* Tabela: SigFiGfd
* PK: cidchaves (gerado via SYS(2015)+SYS(2015))
*==============================================================================

DEFINE CLASS LGRBO AS BusinessBase

    *-- Propriedades da classe
    this_cTabela      = "SigFiGfd"
    this_cCampoChave  = "cidchaves"

    *--------------------------------------------------------------------------
    * Propriedades mapeadas da tabela SigFiGfd
    *--------------------------------------------------------------------------
    this_cIdChaves  = ""    && cidchaves char(20) - PK
    this_cSerifab   = ""    && cserifab  char(20) - Serie de Fabricacao (FK SigFiMpf)
    this_cModelos   = ""    && cmodelos  char(20) - Modelo (FK SigFiMpm)
    this_cCoos      = ""    && ccoos     char(6)  - COO
    this_cGnfs      = ""    && cgnfs     char(6)  - Cupom nao Fiscal
    this_cGrgs      = ""    && cgrgs     char(6)  - Relatorios Gerenciais
    this_cCdcs      = ""    && ccdcs     char(4)  - Demonstrativo Credito e Debito
    this_cCrzs      = ""    && ccrzs     char(6)  - Reducao Z
    this_cDoctos    = ""    && cdoctos   char(2)  - Tipo de Documento
    this_cDatas     = ""    && cdatas    char(8)  - Data YYYYMMDD (sem barras)
    this_cHoras     = ""    && choras    char(6)  - Hora HHMMSS
    this_cIncMans   = ""    && cincmans  char(1)  - Flag inclusao manual ('M')
    this_cTipos     = ""    && ctipos    char(3)  - Tipo (ex: 'E16')
    this_cMfs       = ""    && cmfs      char(1)  - Memoria Fiscal
    this_cUsuarios  = ""    && cusuarios char(2)  - Usuario
    this_cCancel    = ""    && ccancel   char(1)  - Flag cancelamento
    this_cDescons   = ""    && cdescons  char(13) - Desconto
    this_cDescrs    = ""    && cdescrs   char(100) - Descricao
    this_cFpagtos   = ""    && cfpagtos  char(14) - Forma de Pagamento
    this_cItems     = ""    && citems    char(4)  - Item
    this_cPros      = ""    && cpros     char(14) - Pro
    this_cQtds      = ""    && cqtds     char(7)  - Quantidade
    this_cTribs     = ""    && ctribs    char(7)  - Tributos
    this_cUnids     = ""    && cunids    char(3)  - Unidade
    this_cValors    = ""    && cvalors   char(14) - Valor
    this_cLocals    = ""    && locals    char(10) - Local
    this_cDocorigs  = ""    && cdocorigs char(10) - Documento de origem
    this_cConcatda  = ""    && concatda  text     - Concatenado
    this_lCopias    = .F.   && copias    bit      - Copias
    this_nNtrans    = 0     && ntrans    numeric(6,0) - Numero transacao
    this_dDatatrans = {}    && datatrans datetime - Data transacao auditoria

    *-- Propriedade auxiliar da juncao (SigFiMpm.cmarcas - apenas para exibicao no grid)
    this_cMarcas    = ""    && cmarcas (vem de SigFiMpm via JOIN)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiGfd"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Para o sistema de auditoria do BusinessBase
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cIdChaves
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros com JOIN SigFiMpm para exibir marca
    * par_cFiltro: filtro WHERE adicional (sem a palavra WHERE)
    * par_cSerifab: serie de fabricacao para filtrar
    * par_dDtini: data inicio do periodo
    * par_dDtfim: data fim do periodo
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cSerifab, par_dDtini, par_dDtfim)
        LOCAL loc_cSQL, loc_cSerifab, loc_cDtini, loc_cDtfim, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSerifab = IIF(VARTYPE(par_cSerifab) = "C", ALLTRIM(par_cSerifab), "")
            loc_cDtini   = IIF(VARTYPE(par_dDtini) = "D" AND !EMPTY(par_dDtini), ;
                               STRTRAN(DTOC(par_dDtini), "/", ""), "")
            loc_cDtfim   = IIF(VARTYPE(par_dDtfim) = "D" AND !EMPTY(par_dDtfim), ;
                               STRTRAN(DTOC(par_dDtfim), "/", ""), "")

            loc_cSQL = "SELECT b.cmarcas, a.cidchaves, a.cserifab, a.cmodelos," + ;
                       " a.ccoos, a.cgnfs, a.cgrgs, a.ccdcs, a.ccrzs, a.cdoctos," + ;
                       " a.cdatas, a.choras, a.cincmans, a.ctipos, a.cmfs," + ;
                       " a.cusuarios, a.ccancel, a.cdescons, a.cdescrs," + ;
                       " a.cfpagtos, a.citems, a.cpros, a.cqtds, a.ctribs," + ;
                       " a.cunids, a.cvalors, a.locals, a.ntrans, a.cdocorigs" + ;
                       " FROM SigFiGfd a" + ;
                       " INNER JOIN SigFiMpm b ON a.cmodelos = b.cModelos"

            IF !EMPTY(loc_cSerifab) OR !EMPTY(loc_cDtini) OR !EMPTY(loc_cDtfim)
                loc_cSQL = loc_cSQL + " WHERE"
                IF !EMPTY(loc_cSerifab)
                    loc_cSQL = loc_cSQL + " a.cserifab = " + EscaparSQL(loc_cSerifab)
                    IF !EMPTY(loc_cDtini) OR !EMPTY(loc_cDtfim)
                        loc_cSQL = loc_cSQL + " AND"
                    ENDIF
                ENDIF
                IF !EMPTY(loc_cDtini) AND !EMPTY(loc_cDtfim)
                    loc_cSQL = loc_cSQL + " a.cdatas BETWEEN " + EscaparSQL(loc_cDtini) + ;
                               " AND " + EscaparSQL(loc_cDtfim)
                ELSE
                    IF !EMPTY(loc_cDtini)
                    loc_cSQL = loc_cSQL + " a.cdatas >= " + EscaparSQL(loc_cDtini)
                ELSE
                    IF !EMPTY(loc_cDtfim)
                    loc_cSQL = loc_cSQL + " a.cdatas <= " + EscaparSQL(loc_cDtfim)
                    ENDIF
                    ENDIF
                ENDIF
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.cdatas, a.ccoos"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.Buscar: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo cidchaves (PK)
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cIdChaves)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF VARTYPE(par_cIdChaves) <> "C" OR EMPTY(par_cIdChaves)
                MsgErro("Chave inv" + CHR(225) + "lida para carregamento.", "Erro")
            ELSE
                loc_cSQL = "SELECT b.cmarcas, a.*" + ;
                           " FROM SigFiGfd a" + ;
                           " INNER JOIN SigFiMpm b ON a.cmodelos = b.cModelos" + ;
                           " WHERE a.cidchaves = " + EscaparSQL(ALLTRIM(par_cIdChaves))

                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_Carrega")
                    TABLEREVERT(.T., "cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
                IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgErro("Registro n" + CHR(227) + "o encontrado.", "Aviso")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.CarregarPorCodigo: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Popula propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cIdChaves  = TratarNulo(cidchaves, "C")
            THIS.this_cSerifab   = TratarNulo(cserifab,  "C")
            THIS.this_cModelos   = TratarNulo(cmodelos,  "C")
            THIS.this_cCoos      = TratarNulo(ccoos,     "C")
            THIS.this_cGnfs      = TratarNulo(cgnfs,     "C")
            THIS.this_cGrgs      = TratarNulo(cgrgs,     "C")
            THIS.this_cCdcs      = TratarNulo(ccdcs,     "C")
            THIS.this_cCrzs      = TratarNulo(ccrzs,     "C")
            THIS.this_cDoctos    = TratarNulo(cdoctos,   "C")
            THIS.this_cDatas     = TratarNulo(cdatas,    "C")
            THIS.this_cHoras     = TratarNulo(choras,    "C")
            THIS.this_cIncMans   = TratarNulo(cincmans,  "C")
            THIS.this_cTipos     = TratarNulo(ctipos,    "C")
            THIS.this_cMfs       = TratarNulo(cmfs,      "C")
            THIS.this_cUsuarios  = TratarNulo(cusuarios, "C")
            THIS.this_cCancel    = TratarNulo(ccancel,   "C")
            THIS.this_cDescons   = TratarNulo(cdescons,  "C")
            THIS.this_cDescrs    = TratarNulo(cdescrs,   "C")
            THIS.this_cFpagtos   = TratarNulo(cfpagtos,  "C")
            THIS.this_cItems     = TratarNulo(citems,    "C")
            THIS.this_cPros      = TratarNulo(cpros,     "C")
            THIS.this_cQtds      = TratarNulo(cqtds,     "C")
            THIS.this_cTribs     = TratarNulo(ctribs,    "C")
            THIS.this_cUnids     = TratarNulo(cunids,    "C")
            THIS.this_cValors    = TratarNulo(cvalors,   "C")
            THIS.this_cLocals    = TratarNulo(locals,    "C")
            THIS.this_nNtrans    = TratarNulo(ntrans,    "N")
            THIS.this_cDocorigs  = TratarNulo(cdocorigs, "C")
            THIS.this_lCopias    = (TratarNulo(copias,   "N") <> 0)
            IF TYPE("cmarcas") = "C"
                THIS.this_cMarcas = TratarNulo(cmarcas, "C")
            ENDIF
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT na tabela SigFiGfd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cNovaChave
        loc_lSucesso = .F.

        TRY
            loc_cNovaChave = SYS(2015) + SYS(2015)
            THIS.this_cIdChaves = loc_cNovaChave

            loc_cSQL = "INSERT INTO SigFiGfd" + ;
                       " (cidchaves, cserifab, cmodelos, ccoos, cgnfs, cgrgs," + ;
                       "  ccdcs, ccrzs, cdoctos, cdatas, choras, cincmans," + ;
                       "  ctipos, cmfs, cusuarios, ccancel, cdescons, cdescrs," + ;
                       "  cfpagtos, citems, cpros, cqtds, ctribs, cunids," + ;
                       "  cvalors, locals, ntrans, cdocorigs, copias)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cIdChaves)  + ", " + ;
                       EscaparSQL(THIS.this_cSerifab)   + ", " + ;
                       EscaparSQL(THIS.this_cModelos)   + ", " + ;
                       EscaparSQL(THIS.this_cCoos)      + ", " + ;
                       EscaparSQL(THIS.this_cGnfs)      + ", " + ;
                       EscaparSQL(THIS.this_cGrgs)      + ", " + ;
                       EscaparSQL(THIS.this_cCdcs)      + ", " + ;
                       EscaparSQL(THIS.this_cCrzs)      + ", " + ;
                       EscaparSQL(THIS.this_cDoctos)    + ", " + ;
                       EscaparSQL(THIS.this_cDatas)     + ", " + ;
                       EscaparSQL(THIS.this_cHoras)     + ", " + ;
                       EscaparSQL(THIS.this_cIncMans)   + ", " + ;
                       EscaparSQL(THIS.this_cTipos)     + ", " + ;
                       EscaparSQL(THIS.this_cMfs)       + ", " + ;
                       EscaparSQL(THIS.this_cUsuarios)  + ", " + ;
                       EscaparSQL(THIS.this_cCancel)    + ", " + ;
                       EscaparSQL(THIS.this_cDescons)   + ", " + ;
                       EscaparSQL(THIS.this_cDescrs)    + ", " + ;
                       EscaparSQL(THIS.this_cFpagtos)   + ", " + ;
                       EscaparSQL(THIS.this_cItems)     + ", " + ;
                       EscaparSQL(THIS.this_cPros)      + ", " + ;
                       EscaparSQL(THIS.this_cQtds)      + ", " + ;
                       EscaparSQL(THIS.this_cTribs)     + ", " + ;
                       EscaparSQL(THIS.this_cUnids)     + ", " + ;
                       EscaparSQL(THIS.this_cValors)    + ", " + ;
                       EscaparSQL(THIS.this_cLocals)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNtrans) + ", " + ;
                       EscaparSQL(THIS.this_cDocorigs)  + ", " + ;
                       IIF(THIS.this_lCopias, "1", "0") + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.Inserir: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE na tabela SigFiGfd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigFiGfd SET" + ;
                       "  cserifab  = " + EscaparSQL(THIS.this_cSerifab)  + "," + ;
                       "  cmodelos  = " + EscaparSQL(THIS.this_cModelos)  + "," + ;
                       "  ccoos     = " + EscaparSQL(THIS.this_cCoos)     + "," + ;
                       "  cgnfs     = " + EscaparSQL(THIS.this_cGnfs)     + "," + ;
                       "  cgrgs     = " + EscaparSQL(THIS.this_cGrgs)     + "," + ;
                       "  ccdcs     = " + EscaparSQL(THIS.this_cCdcs)     + "," + ;
                       "  ccrzs     = " + EscaparSQL(THIS.this_cCrzs)     + "," + ;
                       "  cdoctos   = " + EscaparSQL(THIS.this_cDoctos)   + "," + ;
                       "  cdatas    = " + EscaparSQL(THIS.this_cDatas)    + "," + ;
                       "  choras    = " + EscaparSQL(THIS.this_cHoras)    + "," + ;
                       "  cincmans  = " + EscaparSQL(THIS.this_cIncMans)  + "," + ;
                       "  ctipos    = " + EscaparSQL(THIS.this_cTipos)    + "," + ;
                       "  cmfs      = " + EscaparSQL(THIS.this_cMfs)      + "," + ;
                       "  cusuarios = " + EscaparSQL(THIS.this_cUsuarios) + "," + ;
                       "  ccancel   = " + EscaparSQL(THIS.this_cCancel)   + "," + ;
                       "  cdescons  = " + EscaparSQL(THIS.this_cDescons)  + "," + ;
                       "  cdescrs   = " + EscaparSQL(THIS.this_cDescrs)   + "," + ;
                       "  cfpagtos  = " + EscaparSQL(THIS.this_cFpagtos)  + "," + ;
                       "  citems    = " + EscaparSQL(THIS.this_cItems)    + "," + ;
                       "  cpros     = " + EscaparSQL(THIS.this_cPros)     + "," + ;
                       "  cqtds     = " + EscaparSQL(THIS.this_cQtds)     + "," + ;
                       "  ctribs    = " + EscaparSQL(THIS.this_cTribs)    + "," + ;
                       "  cunids    = " + EscaparSQL(THIS.this_cUnids)    + "," + ;
                       "  cvalors   = " + EscaparSQL(THIS.this_cValors)   + "," + ;
                       "  locals    = " + EscaparSQL(THIS.this_cLocals)   + "," + ;
                       "  ntrans    = " + FormatarNumeroSQL(THIS.this_nNtrans) + "," + ;
                       "  cdocorigs = " + EscaparSQL(THIS.this_cDocorigs) + "," + ;
                       "  copias    = " + IIF(THIS.this_lCopias, "1", "0") + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cIdChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.Atualizar: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE na tabela SigFiGfd
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigFiGfd WHERE cidchaves = " + ;
                       EscaparSQL(THIS.this_cIdChaves)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ExecutarExclusao: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarAntesDeSalvar - Validacoes de negocio antes do INSERT/UPDATE
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarAntesDeSalvar()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cSerifab)
            MsgErro("S" + CHR(233) + "rie de Fabrica" + CHR(231) + CHR(227) + "o n" + ;
                    CHR(227) + "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_cCoos = "000000"
            MsgErro("COO n" + CHR(227) + "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cGnfs)
            MsgErro("Cupom n" + CHR(227) + "o Fiscal n" + CHR(227) + ;
                    "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cGrgs)
            MsgErro("Relat" + CHR(243) + "rios Gerenciais n" + CHR(227) + ;
                    "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCdcs)
            MsgErro("Demonstrativo D" + CHR(233) + "bito e Cr" + CHR(233) + "dito n" + ;
                    CHR(227) + "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cCrzs)
            MsgErro("Redu" + CHR(231) + CHR(227) + "o Z n" + CHR(227) + ;
                    "o pode estar em branco.", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDoctos)
            MsgErro("Tipo de Documento n" + CHR(227) + "o pode estar em branco.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cDatas)
            MsgErro("Data do Movimento n" + CHR(227) + "o pode estar em branco.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(THIS.this_cHoras)
            MsgErro("Hora do Movimento n" + CHR(227) + "o pode estar em branco.", ;
                    "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarCOODuplicado - Verifica se COO ja existe para a serie (INSERT)
    *--------------------------------------------------------------------------
    FUNCTION VerificarCOODuplicado(par_cSerifab, par_cCoos)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT ccoos FROM SigFiGfd" + ;
                       " WHERE cserifab = " + EscaparSQL(ALLTRIM(par_cSerifab)) + ;
                       " AND ccoos = " + EscaparSQL(ALLTRIM(par_cCoos))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_VerCoo")
                TABLEREVERT(.T., "cursor_4c_VerCoo")
                USE IN cursor_4c_VerCoo
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerCoo")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_VerCoo") > 0
                loc_lDuplicado = .T.
            ENDIF

            IF USED("cursor_4c_VerCoo")
                USE IN cursor_4c_VerCoo
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.VerificarCOODuplicado: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lDuplicado
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterModeloDaSerie - Busca o modelo associado a uma serie de fabricacao
    * (faz query em SigFiMpf pois cserifab e criptografado)
    *--------------------------------------------------------------------------
    FUNCTION ObterModeloDaSerie(par_cSerifab)
        LOCAL loc_cSQL, loc_nResult, loc_cModelo
        loc_cModelo = ""

        TRY
            loc_cSQL = "SELECT cModelos FROM SigFiMpf WHERE cImpFabs = " + ;
                       EscaparSQL(ALLTRIM(par_cSerifab))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmpFab")
                TABLEREVERT(.T., "cursor_4c_TmpFab")
                USE IN cursor_4c_TmpFab
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpFab")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpFab") > 0
                SELECT cursor_4c_TmpFab
                loc_cModelo = ALLTRIM(cModelos)
            ENDIF

            IF USED("cursor_4c_TmpFab")
                USE IN cursor_4c_TmpFab
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ObterModeloDaSerie: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cModelo
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterMFAdis - Busca o cMFAdis do modelo (tabela SigFiMpm)
    *--------------------------------------------------------------------------
    FUNCTION ObterMFAdis(par_cModelos)
        LOCAL loc_cSQL, loc_nResult, loc_cMFAdis
        loc_cMFAdis = ""

        TRY
            loc_cSQL = "SELECT cMFAdis FROM SigFiMpm WHERE cModelos = " + ;
                       EscaparSQL(ALLTRIM(par_cModelos))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmpMpm")
                TABLEREVERT(.T., "cursor_4c_TmpMpm")
                USE IN cursor_4c_TmpMpm
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMpm")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpMpm") > 0
                SELECT cursor_4c_TmpMpm
                loc_cMFAdis = ALLTRIM(cMFAdis)
            ENDIF

            IF USED("cursor_4c_TmpMpm")
                USE IN cursor_4c_TmpMpm
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ObterMFAdis: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cMFAdis
    ENDFUNC

    *--------------------------------------------------------------------------
    * ObterNumUsuars - Busca o cNumUsuars de uma serie (tabela SigFiMpf)
    *--------------------------------------------------------------------------
    FUNCTION ObterNumUsuars(par_cSerifabDecriptografada)
        LOCAL loc_cSQL, loc_nResult, loc_cNumUsuars
        loc_cNumUsuars = ""

        TRY
            loc_cSQL = "SELECT cNumUsuars FROM SigFiMpf WHERE cImpFabs = " + ;
                       EscaparSQL(ALLTRIM(par_cSerifabDecriptografada))

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_TmpMpf")
                TABLEREVERT(.T., "cursor_4c_TmpMpf")
                USE IN cursor_4c_TmpMpf
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpMpf")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_TmpMpf") > 0
                SELECT cursor_4c_TmpMpf
                loc_cNumUsuars = ALLTRIM(cNumUsuars)
            ENDIF

            IF USED("cursor_4c_TmpMpf")
                USE IN cursor_4c_TmpMpf
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.ObterNumUsuars: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cNumUsuars
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarImpressoras - Busca lista de impressoras (SigFiMpf JOIN SigFiMpm)
    * Retorna cursor cursor_4c_Impressoras com campos: cimpfabs, cmarcas, cmodelos
    *--------------------------------------------------------------------------
    FUNCTION BuscarImpressoras(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT b.cmarcas, a.cmodelos, a.cimpfabs" + ;
                       " FROM SigFiMpf a" + ;
                       " INNER JOIN SigFiMpm b ON a.cmodelos = b.cmodelos"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Impressoras")
                TABLEREVERT(.T., "cursor_4c_Impressoras")
                USE IN cursor_4c_Impressoras
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Impressoras")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar impressoras: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.BuscarImpressoras: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarModelos - Busca lista de modelos (SigFiMpm)
    * Retorna cursor cursor_4c_Modelos com campos: cModelos, cMarcas
    *--------------------------------------------------------------------------
    FUNCTION BuscarModelos(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cModelos, cMarcas FROM SigFiMpm"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
            ENDIF

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Modelos")
                TABLEREVERT(.T., "cursor_4c_Modelos")
                USE IN cursor_4c_Modelos
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Modelos")
            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar modelos: " + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em LGRBO.BuscarModelos: " + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

