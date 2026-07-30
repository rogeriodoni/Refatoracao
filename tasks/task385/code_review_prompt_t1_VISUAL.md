# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 177: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 202: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 227: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 252: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 277: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 314: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 417: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 442: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCrt.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1123 linhas total):

*-- Linhas 46 a 55:
46:                 MostrarErro("Erro ao criar CrtBO", "FormCrt.InicializarForm")
47:             ELSE
48:                 THIS.ConfigurarPageFrame()
49:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
50:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
51:                 THIS.pgf_4c_Paginas.ActivePage = 1
52:                 THIS.this_cModoAtual = "LISTA"
53: 
54:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
55:                     THIS.CarregarLista()

*-- Linhas 72 a 91:
72:         TRY
73:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
74: 
75:             THIS.pgf_4c_Paginas.Top       = -29
76:             THIS.pgf_4c_Paginas.Left      = 0
77:             THIS.pgf_4c_Paginas.Width     = 1000
78:             THIS.pgf_4c_Paginas.Height    = 629
79:             THIS.pgf_4c_Paginas.PageCount = 2
80:             THIS.pgf_4c_Paginas.Tabs      = .F.
81:             THIS.pgf_4c_Paginas.Visible   = .T.
82: 
83:             WITH THIS.pgf_4c_Paginas
84:                 .Page1.Caption = "Lista"
85:                 .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
86:                 .Page2.Caption = "Dados"
87:                 .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
88:             ENDWITH
89: 
90:             THIS.ConfigurarPaginaLista()
91:             THIS.ConfigurarPaginaDados()

*-- Linhas 109 a 145:
109:             *-- Cabecalho cinza (cntSombra legado: Top=1, Left=-1, Width=1008, Height=80)
110:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
111:             WITH loc_oPagina.cnt_4c_Cabecalho
112:                 .Top         = 30
113:                 .Left        = 0
114:                 .Width       = 1000
115:                 .Height      = 80
116:                 .BackColor   = RGB(100, 100, 100)
117:                 .BorderWidth = 0
118:                 .Visible     = .T.
119: 
120:                 .AddObject("lbl_4c_Sombra", "Label")
121:                 WITH .lbl_4c_Sombra
122:                     .Caption   = "Cadastro de Retrabalhos"
123:                     .Top       = 15
124:                     .Left      = 10
125:                     .Width     = THIS.Width
126:                     .Height    = 40
127:                     .AutoSize  = .F.
128:                     .FontName  = "Tahoma"
129:                     .FontSize  = 16
130:                     .FontBold  = .T.
131:                     .ForeColor = RGB(0, 0, 0)
132:                     .BackStyle = 0
133:                     .Visible   = .T.
134:                 ENDWITH
135: 
136:                 .AddObject("lbl_4c_Titulo", "Label")
137:                 WITH .lbl_4c_Titulo
138:                     .Caption   = "Cadastro de Retrabalhos"
139:                     .Top       = 18
140:                     .Left      = 10
141:                     .Width     = THIS.Width
142:                     .Height    = 46
143:                     .AutoSize  = .F.
144:                     .FontName  = "Tahoma"
145:                     .FontSize  = 16

*-- Linhas 153 a 357:
153:             *-- Container botoes CRUD (canonico: Left=542, Top=28, Width=385, Height=85)
154:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
155:             WITH loc_oPagina.cnt_4c_Botoes
156:                 .Top         = 28
157:                 .Left        = 542
158:                 .Width       = 385
159:                 .Height      = 85
160:                 .BackStyle = 0
161:                 .BorderWidth = 0
162:                 .Visible     = .T.
163:             ENDWITH
164: 
165:             *-- Botao Incluir
166:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
167:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
168:                 .Caption         = "Incluir"
169:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
170:                 .PicturePosition = 13
171:                 .Top             = 5
172:                 .Left            = 5
173:                 .Width           = 75
174:                 .Height          = 75
175:                 .BackColor       = RGB(255, 255, 255)
176:                 .ForeColor       = RGB(90, 90, 90)
177:                 .FontName        = "Comic Sans MS"
178:                 .FontSize        = 8
179:                 .FontBold        = .T.
180:                 .FontItalic      = .T.
181:                 .Themes          = .F.
182:                 .SpecialEffect   = 0
183:                 .MousePointer    = 15
184:                 .WordWrap        = .T.
185:                 .AutoSize        = .F.
186:                 .Visible         = .T.
187:             ENDWITH
188:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
189: 
190:             *-- Botao Visualizar
191:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
192:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
193:                 .Caption         = "Visualizar"
194:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
195:                 .PicturePosition = 13
196:                 .Top             = 5
197:                 .Left            = 80
198:                 .Width           = 75
199:                 .Height          = 75
200:                 .BackColor       = RGB(255, 255, 255)
201:                 .ForeColor       = RGB(90, 90, 90)
202:                 .FontName        = "Comic Sans MS"
203:                 .FontSize        = 8
204:                 .FontBold        = .T.
205:                 .FontItalic      = .T.
206:                 .Themes          = .F.
207:                 .SpecialEffect   = 0
208:                 .MousePointer    = 15
209:                 .WordWrap        = .T.
210:                 .AutoSize        = .F.
211:                 .Visible         = .T.
212:             ENDWITH
213:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
214: 
215:             *-- Botao Alterar
216:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
217:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
218:                 .Caption         = "Alterar"
219:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
220:                 .PicturePosition = 13
221:                 .Top             = 5
222:                 .Left            = 155
223:                 .Width           = 75
224:                 .Height          = 75
225:                 .BackColor       = RGB(255, 255, 255)
226:                 .ForeColor       = RGB(90, 90, 90)
227:                 .FontName        = "Comic Sans MS"
228:                 .FontSize        = 8
229:                 .FontBold        = .T.
230:                 .FontItalic      = .T.
231:                 .Themes          = .F.
232:                 .SpecialEffect   = 0
233:                 .MousePointer    = 15
234:                 .WordWrap        = .T.
235:                 .AutoSize        = .F.
236:                 .Visible         = .T.
237:             ENDWITH
238:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
239: 
240:             *-- Botao Excluir
241:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
242:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
243:                 .Caption         = "Excluir"
244:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
245:                 .PicturePosition = 13
246:                 .Top             = 5
247:                 .Left            = 230
248:                 .Width           = 75
249:                 .Height          = 75
250:                 .BackColor       = RGB(255, 255, 255)
251:                 .ForeColor       = RGB(90, 90, 90)
252:                 .FontName        = "Comic Sans MS"
253:                 .FontSize        = 8
254:                 .FontBold        = .T.
255:                 .FontItalic      = .T.
256:                 .Themes          = .F.
257:                 .SpecialEffect   = 0
258:                 .MousePointer    = 15
259:                 .WordWrap        = .T.
260:                 .AutoSize        = .F.
261:                 .Visible         = .T.
262:             ENDWITH
263:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
264: 
265:             *-- Botao Buscar
266:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
267:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
268:                 .Caption         = "Buscar"
269:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
270:                 .PicturePosition = 13
271:                 .Top             = 5
272:                 .Left            = 305
273:                 .Width           = 75
274:                 .Height          = 75
275:                 .BackColor       = RGB(255, 255, 255)
276:                 .ForeColor       = RGB(90, 90, 90)
277:                 .FontName        = "Comic Sans MS"
278:                 .FontSize        = 8
279:                 .FontBold        = .T.
280:                 .FontItalic      = .T.
281:                 .Themes          = .F.
282:                 .SpecialEffect   = 0
283:                 .MousePointer    = 15
284:                 .WordWrap        = .T.
285:                 .AutoSize        = .F.
286:                 .Visible         = .T.
287:             ENDWITH
288:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
289: 
290:             *-- Container saida canonico (Left=917, Top=28, Width=90, Height=85)
291:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
292:             WITH loc_oPagina.cnt_4c_Saida
293:                 .Top         = 28
294:                 .Left        = 917
295:                 .Width       = 90
296:                 .Height      = 85
297:                 .BackStyle   = 0
298:                 .BorderWidth = 0
299:                 .Visible     = .T.
300:             ENDWITH
301: 
302:             *-- Botao Encerrar (canonico: Left=5, Top=5, Width=75, Height=75)
303:             loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
304:             WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
305:                 .Caption         = "Encerrar"
306:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
307:                 .PicturePosition = 13
308:                 .Top             = 5
309:                 .Left            = 5
310:                 .Width           = 75
311:                 .Height          = 75
312:                 .BackColor       = RGB(255, 255, 255)
313:                 .ForeColor       = RGB(90, 90, 90)
314:                 .FontName        = "Comic Sans MS"
315:                 .FontSize        = 8
316:                 .FontBold        = .T.
317:                 .FontItalic      = .T.
318:                 .Themes          = .F.
319:                 .SpecialEffect   = 0
320:                 .MousePointer    = 15
321:                 .WordWrap        = .T.
322:                 .AutoSize        = .F.
323:                 .Visible         = .T.
324:             ENDWITH
325:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
326: 
327:             *-- Botao Justificativas (original: Left=604, Top=82 -> +29 compensacao = Top=111)
328:             loc_oPagina.AddObject("cmd_4c_Justifica", "CommandButton")
329:             WITH loc_oPagina.cmd_4c_Justifica
330:                 .Caption       = "\<Justificativas"
331:                 .Top           = 111
332:                 .Left          = 604
333:                 .Width         = 120
334:                 .Height        = 40
335:                 .BackColor     = RGB(255, 255, 255)
336:                 .ForeColor     = RGB(90, 90, 90)
337:                 .FontName      = "Tahoma"
338:                 .FontSize      = 8
339:                 .Themes        = .F.
340:                 .SpecialEffect = 0
341:                 .MousePointer  = 15
342:                 .Visible       = .T.
343:             ENDWITH
344:             BINDEVENT(loc_oPagina.cmd_4c_Justifica, "Click", THIS, "BtnJustificaClick")
345: 
346:             *-- Grid de listagem (Grade: Top=82 -> +29 = 111; framework padrao Top=88+29=117)
347:             *-- Justifica ocupa Left=604..724 na mesma faixa vertical - grid fica abaixo em Top=117
348:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
349:             loc_oPagina.grd_4c_Lista.ColumnCount = 3
350:             WITH loc_oPagina.grd_4c_Lista
351:                 .Top                = 117
352:                 .Left               = 26
353:                 .Width              = 868
354:                 .Height             = 450
355:                 .FontName           = "Verdana"
356:                 .FontSize           = 8
357:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 392 a 465:
392:             *-- Container botoes Confirmar/Cancelar (original Grupo_Salva Top=17+29=46, Left=619)
393:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
394:             WITH loc_oPagina.cnt_4c_BotoesAcao
395:                 .Top         = 46
396:                 .Left        = 619
397:                 .Width       = 165
398:                 .Height      = 85
399:                 .BackStyle = 1
400:                 .BackColor = RGB(255, 255, 255)
401:                 .BorderWidth = 0
402:                 .Visible     = .T.
403:             ENDWITH
404: 
405:             *-- Botao Confirmar (Salvar)
406:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
407:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
408:                 .Caption         = "Confirmar"
409:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
410:                 .PicturePosition = 13
411:                 .Top             = 5
412:                 .Left            = 5
413:                 .Width           = 75
414:                 .Height          = 75
415:                 .BackColor       = RGB(255, 255, 255)
416:                 .ForeColor       = RGB(90, 90, 90)
417:                 .FontName        = "Comic Sans MS"
418:                 .FontSize        = 8
419:                 .FontBold        = .T.
420:                 .FontItalic      = .T.
421:                 .Themes          = .F.
422:                 .SpecialEffect   = 0
423:                 .MousePointer    = 15
424:                 .WordWrap        = .T.
425:                 .AutoSize        = .F.
426:                 .Visible         = .T.
427:             ENDWITH
428:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
429: 
430:             *-- Botao Cancelar
431:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
432:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
433:                 .Caption         = "Encerrar"
434:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
435:                 .PicturePosition = 13
436:                 .Top             = 5
437:                 .Left            = 80
438:                 .Width           = 75
439:                 .Height          = 75
440:                 .BackColor       = RGB(255, 255, 255)
441:                 .ForeColor       = RGB(90, 90, 90)
442:                 .FontName        = "Comic Sans MS"
443:                 .FontSize        = 8
444:                 .FontBold        = .T.
445:                 .FontItalic      = .T.
446:                 .Themes          = .F.
447:                 .SpecialEffect   = 0
448:                 .MousePointer    = 15
449:                 .WordWrap        = .T.
450:                 .AutoSize        = .F.
451:                 .Visible         = .T.
452:             ENDWITH
453:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
454: 
455:             *-- CAMPO 1: Codigo (Say2/Get_codigo - original top=256/254, +29=285/283)
456:             loc_oPagina.AddObject("lbl_4c_Label2", "Label")
457:             WITH loc_oPagina.lbl_4c_Label2
458:                 .Caption   = "C" + CHR(243) + "digo :"
459:                 .Top       = 285
460:                 .Left      = 274
461:                 .Width     = 45
462:                 .Height    = 17
463:                 .AutoSize  = .F.
464:                 .FontName  = "Tahoma"
465:                 .FontSize  = 8

*-- Linhas 473 a 496:
473:             loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
474:             WITH loc_oPagina.txt_4c_Codigo
475:                 .Value     = ""
476:                 .Top       = 283
477:                 .Left      = 319
478:                 .Width     = 52
479:                 .Height    = 23
480:                 .FontName  = "Tahoma"
481:                 .FontSize  = 8
482:                 .MaxLength = 6
483:                 .Visible   = .T.
484:             ENDWITH
485: 
486:             *-- CAMPO 2: Descricao (Say3/Get_descricao - original top=287/284, +29=316/313)
487:             loc_oPagina.AddObject("lbl_4c_Label3", "Label")
488:             WITH loc_oPagina.lbl_4c_Label3
489:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
490:                 .Top       = 316
491:                 .Left      = 261
492:                 .Width     = 58
493:                 .Height    = 17
494:                 .AutoSize  = .F.
495:                 .FontName  = "Tahoma"
496:                 .FontSize  = 8

*-- Linhas 504 a 527:
504:             loc_oPagina.AddObject("txt_4c_Descricao", "TextBox")
505:             WITH loc_oPagina.txt_4c_Descricao
506:                 .Value     = ""
507:                 .Top       = 313
508:                 .Left      = 319
509:                 .Width     = 220
510:                 .Height    = 23
511:                 .FontName  = "Tahoma"
512:                 .FontSize  = 8
513:                 .MaxLength = 30
514:                 .Visible   = .T.
515:             ENDWITH
516: 
517:             *-- CAMPO 3: Fator (Say1/fwget1 - original top=316/313, +29=345/342)
518:             loc_oPagina.AddObject("lbl_4c_Label1", "Label")
519:             WITH loc_oPagina.lbl_4c_Label1
520:                 .Caption   = "Fator :"
521:                 .Top       = 345
522:                 .Left      = 278
523:                 .Width     = 41
524:                 .Height    = 17
525:                 .AutoSize  = .F.
526:                 .FontName  = "Tahoma"
527:                 .FontSize  = 8

*-- Linhas 535 a 559:
535:             loc_oPagina.AddObject("txt_4c_Fwget1", "TextBox")
536:             WITH loc_oPagina.txt_4c_Fwget1
537:                 .Value     = 0
538:                 .Top       = 342
539:                 .Left      = 319
540:                 .Width     = 60
541:                 .Height    = 23
542:                 .FontName  = "Tahoma"
543:                 .FontSize  = 8
544:                 .InputMask = "9999.99"
545:                 .Alignment = 1
546:                 .Visible   = .T.
547:             ENDWITH
548: 
549:             *-- CAMPO 4: Ordem (Say4/fwget2 - original top=344/341, +29=373/370)
550:             loc_oPagina.AddObject("lbl_4c_Label4", "Label")
551:             WITH loc_oPagina.lbl_4c_Label4
552:                 .Caption   = "Ordem :"
553:                 .Top       = 373
554:                 .Left      = 272
555:                 .Width     = 47
556:                 .Height    = 17
557:                 .AutoSize  = .F.
558:                 .FontName  = "Tahoma"
559:                 .FontSize  = 8

*-- Linhas 567 a 593:
567:             loc_oPagina.AddObject("txt_4c_Fwget2", "TextBox")
568:             WITH loc_oPagina.txt_4c_Fwget2
569:                 .Value     = 0
570:                 .Top       = 370
571:                 .Left      = 319
572:                 .Width     = 24
573:                 .Height    = 23
574:                 .FontName  = "Tahoma"
575:                 .FontSize  = 8
576:                 .InputMask = "99"
577:                 .MaxLength = 2
578:                 .Alignment = 1
579:                 .Visible   = .T.
580:             ENDWITH
581: 
582:             *-- CAMPO 5: Empresa (Say20/Get_EmpPad - original top=372/369, +29=401/398)
583:             *-- Get_EmpPad: FontName=Courier New, Alignment=3, Width=34, SigCdEmp.Cemps (char(3))
584:             loc_oPagina.AddObject("lbl_4c_Label20", "Label")
585:             WITH loc_oPagina.lbl_4c_Label20
586:                 .Caption   = "Empresa :"
587:                 .Top       = 401
588:                 .Left      = 266
589:                 .Width     = 53
590:                 .Height    = 15
591:                 .AutoSize  = .F.
592:                 .FontName  = "Tahoma"
593:                 .FontSize  = 8

*-- Linhas 601 a 610:
601:             loc_oPagina.AddObject("txt_4c_EmpPad", "TextBox")
602:             WITH loc_oPagina.txt_4c_EmpPad
603:                 .Value     = ""
604:                 .Top       = 398
605:                 .Left      = 319
606:                 .Width     = 34
607:                 .Height    = 23
608:                 .FontName  = "Courier New"
609:                 .FontSize  = 8
610:                 .MaxLength = 3

*-- Linhas 645 a 655:
645:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Fators"
646: 
647:                     *-- Reconfigurar cabecalhos APOS RecordSource (VFP9 reseta cabecalhos)
648:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
649:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
650:                     loc_oGrid.Column3.Header1.Caption = "Fator"
651:                     loc_oGrid.Column3.Header1.Alignment = 1
652: 
653:                     THIS.FormatarGridLista(loc_oGrid)
654:                     loc_lResultado = .T.
655:                 ENDIF

*-- Linhas 1018 a 1026:
1018:         loc_oPagina.txt_4c_Fwget2.ReadOnly    = !par_lHabilitar
1019:         loc_oPagina.txt_4c_EmpPad.ReadOnly    = !par_lHabilitar
1020: 
1021:         loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
1022:     ENDPROC
1023: 
1024:     *--------------------------------------------------------------------------
1025:     * LimparCampos - Reseta valores de todos os campos do formulario
1026:     *--------------------------------------------------------------------------

*-- Linhas 1044 a 1061:
1044: 
1045:         DO CASE
1046:             CASE INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1047:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .T.
1048:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1049: 
1050:             CASE THIS.this_cModoAtual = "VISUALIZAR"
1051:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1052:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1053: 
1054:             OTHERWISE
1055:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = .F.
1056:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1057:         ENDCASE
1058:     ENDPROC
1059: 
1060:     *--------------------------------------------------------------------------
1061:     * EmpPadLookupKeyPress - Handler KeyPress para lookup de Empresa (F4)


### BO (C:\4c\projeto\app\classes\CrtBO.prg):
*==============================================================================
* CRTBO.PRG
* Business Object para Cadastro de Retrabalhos (SigPrCrt)
* Herda de: BusinessBase
*==============================================================================

DEFINE CLASS CrtBO AS BusinessBase

    *-- Propriedades de dados da tabela SigPrCrt
    this_cCodigo    = ""    && cods   CHAR(6)  - Codigo do Retrabalho (PK)
    this_cDescricao = ""    && descs  CHAR(30) - Descricao
    this_nFator     = 0     && fators NUMERIC  - Fator (9999.99)
    this_nSeq       = 0     && Seqs   NUMERIC  - Sequencia/Ordem
    this_cEmpresa   = ""    && Cemps   CHAR(3)  - Empresa Padrao (FK SigCdEmp)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigPrCrt"
        THIS.this_cCampoChave = "cods"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparDados - Reseta propriedades para valores padrao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cCodigo    = ""
        THIS.this_cDescricao = ""
        THIS.this_nFator     = 0
        THIS.this_nSeq       = 0
        THIS.this_cEmpresa   = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo    = TratarNulo(cods,  "C")
            THIS.this_cDescricao = TratarNulo(descs, "C")
            THIS.this_nFator     = TratarNulo(fators,"N")
            THIS.this_nSeq       = TratarNulo(Seqs,  "N")
            THIS.this_cEmpresa   = TratarNulo(Emps,  "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista retrabalhos (SELECT para o grid)
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Cods, Descs, Fators, Seqs, Emps" + ;
                       " FROM SigPrCrt" + ;
                       " WHERE Emps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       " OR Emps = ' '" + ;
                       " ORDER BY Cods"

            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao buscar retrabalhos: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Cods, Descs, Fators, Seqs, Emps" + ;
                       " FROM SigPrCrt" + ;
                       " WHERE Cods = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ELSE
                THIS.this_cMensagemErro = "Retrabalho n" + CHR(227) + "o encontrado."
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        FINALLY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT em SigPrCrt (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigPrCrt (Cods, Descs, Fators, Seqs, Emps)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + ", " + ;
                       EscaparSQL(THIS.this_cDescricao) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nFator) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nSeq) + ", " + ;
                       EscaparSQL(THIS.this_cEmpresa) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao inserir retrabalho: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE em SigPrCrt (chamado por BusinessBase.Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigPrCrt SET" + ;
                       " Descs = " + EscaparSQL(THIS.this_cDescricao) + "," + ;
                       " Fators = " + FormatarNumeroSQL(THIS.this_nFator) + "," + ;
                       " Seqs = " + FormatarNumeroSQL(THIS.this_nSeq) + "," + ;
                       " Emps = " + EscaparSQL(THIS.this_cEmpresa) + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao atualizar retrabalho: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE em SigPrCrt (chamado por BusinessBase.Excluir)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResultado
        loc_lResultado = .F.

        TRY
            loc_cSQL = "DELETE FROM SigPrCrt" + ;
                       " WHERE Cods = " + EscaparSQL(THIS.this_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lResultado = .T.
            ELSE
                THIS.this_cMensagemErro = "Erro ao excluir retrabalho: " + CapturarErroSQL()
                MsgErro(THIS.this_cMensagemErro, "Erro SQL")
            ENDIF

        CATCH TO loc_oErro
            MsgErro("Erro em CrtBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Validacoes de negocio antes de Salvar
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cCodigo))
            MsgAviso("C" + CHR(243) + "digo n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cDescricao))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!", "Valida" + CHR(231) + CHR(227) + "o")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            LOCAL loc_lExiste, loc_nVerif
            loc_lExiste = .F.
            TRY
                loc_nVerif = SQLEXEC(gnConnHandle, ;
                    "SELECT Cods FROM SigPrCrt WHERE Cods = " + EscaparSQL(THIS.this_cCodigo), ;
                    "cursor_4c_Verif")
                IF loc_nVerif > 0 AND RECCOUNT("cursor_4c_Verif") > 0
                    MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!", "Valida" + CHR(231) + CHR(227) + "o")
                    loc_lValido = .F.
                    loc_lExiste = .T.
                ENDIF
            CATCH TO loc_oErro
                MsgErro("Erro ao verificar c" + CHR(243) + "digo: " + loc_oErro.Message, "Erro")
                loc_lValido = .F.
            FINALLY
                IF USED("cursor_4c_Verif")
                    USE IN cursor_4c_Verif
                ENDIF
            ENDTRY
        ENDIF

        RETURN loc_lValido
    ENDFUNC

ENDDEFINE

