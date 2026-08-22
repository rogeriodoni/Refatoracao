# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [ALINHAMENTO] Botao 'cmd_4c_MontaLista' tem Top=110 mas grupo usa Top=111 (diferenca de 1px)
- [FONTNAME-ERRADO] Linha 192: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 217: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 242: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 267: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 292: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 328: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 510: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
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

### FORM (C:\4c\projeto\app\forms\cadastros\FormOps.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1589 linhas total):

*-- Linhas 62 a 71:
62:                 THIS.ConfigurarPageFrame()
63: 
64:                 WITH THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho
65:                     .lbl_4c_Sombra.Caption = "Cadastro Simplificado de Movimenta" + CHR(231) + CHR(245) + "es"
66:                     .lbl_4c_Titulo.Caption = "Cadastro Simplificado de Movimenta" + CHR(231) + CHR(245) + "es"
67:                     .Visible = .T.
68:                 ENDWITH
69: 
70:                 THIS.pgf_4c_Paginas.Visible    = .T.
71:                 THIS.pgf_4c_Paginas.ActivePage = 1

*-- Linhas 96 a 113:
96: 
97:         WITH THIS.pgf_4c_Paginas
98:             .PageCount       = 2
99:             .Top             = -29
100:             .Left            = 0
101:             .Width           = THIS.Width
102:             .Height          = THIS.Height + 29
103:             .Tabs            = .F.
104:             .Visible         = .T.
105:             .Page1.Caption   = "Lista"
106:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:             .Page1.BackColor = RGB(255, 255, 255)
108:             .Page2.Caption   = "Dados"
109:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
110:             .Page2.BackColor = RGB(255, 255, 255)
111:         ENDWITH
112: 
113:         THIS.ConfigurarPaginaLista()

*-- Linhas 126 a 466:
126:         *-- Container Cabecalho (cntSombra: top=1+29=30)
127:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
128:         WITH loc_oPagina.cnt_4c_Cabecalho
129:             .Top         = 30
130:             .Left        = 0
131:             .Width       = THIS.Width
132:             .Height      = 80
133:             .BackColor   = RGB(100, 100, 100)
134:             .BorderWidth = 0
135:             .Visible     = .T.
136:         ENDWITH
137: 
138:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
139:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
140:             .Caption   = "Cadastro Simplificado de Movimenta" + CHR(231) + CHR(245) + "es"
141:             .Top       = 15
142:             .Left      = 10
143:             .Width     = THIS.Width - 20
144:             .Height    = 40
145:             .FontName  = "Tahoma"
146:             .FontSize  = 16
147:             .FontBold  = .T.
148:             .ForeColor = RGB(0, 0, 0)
149:             .BackStyle = 0
150:             .AutoSize  = .F.
151:             .Visible   = .T.
152:         ENDWITH
153: 
154:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
155:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
156:             .Caption   = "Cadastro Simplificado de Movimenta" + CHR(231) + CHR(245) + "es"
157:             .Top       = 18
158:             .Left      = 10
159:             .Width     = THIS.Width - 20
160:             .Height    = 46
161:             .FontName  = "Tahoma"
162:             .FontSize  = 16
163:             .FontBold  = .T.
164:             .ForeColor = RGB(255, 255, 255)
165:             .BackStyle = 0
166:             .AutoSize  = .F.
167:             .Visible   = .T.
168:         ENDWITH
169: 
170:         *-- Container Botoes CRUD (Grupo_op.Top=0, Left=539; compensado Top=29)
171:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
172:         WITH loc_oPagina.cnt_4c_Botoes
173:             .Top         = 29
174:             .Left        =  542
175:             .Width       = 385
176:             .Height      = 85
177:             .BackStyle   = 0
178:             .BorderWidth = 0
179:             .Visible     = .T.
180:         ENDWITH
181: 
182:         *-- Botao Incluir
183:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
184:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
185:             .Caption         = "Incluir"
186:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
187:             .PicturePosition = 13
188:             .Top             = 5
189:             .Left            = 5
190:             .Width           = 75
191:             .Height          = 75
192:             .FontName        = "Comic Sans MS"
193:             .FontSize        = 8
194:             .FontBold        = .T.
195:             .FontItalic      = .T.
196:             .ForeColor       = RGB(90, 90, 90)
197:             .BackColor       = RGB(255, 255, 255)
198:             .Themes          = .F.
199:             .SpecialEffect   = 0
200:             .MousePointer    = 15
201:             .WordWrap        = .T.
202:             .AutoSize        = .F.
203:             .Visible         = .T.
204:         ENDWITH
205:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
206: 
207:         *-- Botao Visualizar
208:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
209:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
210:             .Caption         = "Visualizar"
211:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
212:             .PicturePosition = 13
213:             .Top             = 5
214:             .Left            = 80
215:             .Width           = 75
216:             .Height          = 75
217:             .FontName        = "Comic Sans MS"
218:             .FontSize        = 8
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .ForeColor       = RGB(90, 90, 90)
222:             .BackColor       = RGB(255, 255, 255)
223:             .Themes          = .F.
224:             .SpecialEffect   = 0
225:             .MousePointer    = 15
226:             .WordWrap        = .T.
227:             .AutoSize        = .F.
228:             .Visible         = .T.
229:         ENDWITH
230:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
231: 
232:         *-- Botao Alterar
233:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
234:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
235:             .Caption         = "Alterar"
236:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
237:             .PicturePosition = 13
238:             .Top             = 5
239:             .Left            = 155
240:             .Width           = 75
241:             .Height          = 75
242:             .FontName        = "Comic Sans MS"
243:             .FontSize        = 8
244:             .FontBold        = .T.
245:             .FontItalic      = .T.
246:             .ForeColor       = RGB(90, 90, 90)
247:             .BackColor       = RGB(255, 255, 255)
248:             .Themes          = .F.
249:             .SpecialEffect   = 0
250:             .MousePointer    = 15
251:             .WordWrap        = .T.
252:             .AutoSize        = .F.
253:             .Visible         = .T.
254:         ENDWITH
255:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
256: 
257:         *-- Botao Excluir
258:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
259:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
260:             .Caption         = "Excluir"
261:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
262:             .PicturePosition = 13
263:             .Top             = 5
264:             .Left            = 230
265:             .Width           = 75
266:             .Height          = 75
267:             .FontName        = "Comic Sans MS"
268:             .FontSize        = 8
269:             .FontBold        = .T.
270:             .FontItalic      = .T.
271:             .ForeColor       = RGB(90, 90, 90)
272:             .BackColor       = RGB(255, 255, 255)
273:             .Themes          = .F.
274:             .SpecialEffect   = 0
275:             .MousePointer    = 15
276:             .WordWrap        = .T.
277:             .AutoSize        = .F.
278:             .Visible         = .T.
279:         ENDWITH
280:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
281: 
282:         *-- Botao Buscar
283:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
284:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
285:             .Caption         = "Buscar"
286:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
287:             .PicturePosition = 13
288:             .Top             = 5
289:             .Left            = 305
290:             .Width           = 75
291:             .Height          = 75
292:             .FontName        = "Comic Sans MS"
293:             .FontSize        = 8
294:             .FontBold        = .T.
295:             .FontItalic      = .T.
296:             .ForeColor       = RGB(90, 90, 90)
297:             .BackColor       = RGB(255, 255, 255)
298:             .Themes          = .F.
299:             .SpecialEffect   = 0
300:             .MousePointer    = 15
301:             .WordWrap        = .T.
302:             .AutoSize        = .F.
303:             .Visible         = .T.
304:         ENDWITH
305:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
306: 
307:         *-- Container Saida - PADRAO CANONICO (Left=917, Width=90; Top compensado=29)
308:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
309:         WITH loc_oPagina.cnt_4c_Saida
310:             .Top         = 29
311:             .Left        = 917
312:             .Width       = 90
313:             .Height      = 85
314:             .BackStyle   = 0
315:             .BorderWidth = 0
316:             .Visible     = .T.
317:         ENDWITH
318: 
319:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
320:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
321:             .Caption         = "Encerrar"
322:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
323:             .PicturePosition = 13
324:             .Top             = 5
325:             .Left            = 5
326:             .Width           = 75
327:             .Height          = 75
328:             .FontName        = "Comic Sans MS"
329:             .FontSize        = 8
330:             .FontBold        = .T.
331:             .FontItalic      = .T.
332:             .ForeColor       = RGB(90, 90, 90)
333:             .BackColor       = RGB(255, 255, 255)
334:             .Themes          = .F.
335:             .SpecialEffect   = 0
336:             .MousePointer    = 15
337:             .WordWrap        = .T.
338:             .AutoSize        = .F.
339:             .Visible         = .T.
340:         ENDWITH
341:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
342: 
343:         *-- OptionGroup Filtro Situacao (optFilSituas: top=85+29=114, left=13)
344:         *-- 1=Geral, 2=Ativos, 3=Inativos (original: pStI/pStF controla WHERE OpeInatvs)
345:         loc_oPagina.AddObject("opt_4c_FilSituas", "OptionGroup")
346:         WITH loc_oPagina.opt_4c_FilSituas
347:             .ButtonCount = 3
348:             .Top         = 114
349:             .Left        = 13
350:             .Width       = 201
351:             .Height      = 26
352:             .BackStyle   = 0
353:             .BorderStyle = 0
354:             .Value       = 1
355:             .Visible     = .T.
356:         ENDWITH
357:         WITH loc_oPagina.opt_4c_FilSituas.Buttons(1)
358:             .Caption   = "Geral"
359:             .BackStyle = 0
360:             .Left      = 5
361:             .Top       = 5
362:             .Width     = 55
363:             .AutoSize  = .T.
364:             .FontName  = "Tahoma"
365:             .FontSize  = 8
366:             .ForeColor = RGB(90, 90, 90)
367:             .Themes    = .F.
368:             .Value     = 1
369:         ENDWITH
370:         WITH loc_oPagina.opt_4c_FilSituas.Buttons(2)
371:             .Caption   = "Ativos"
372:             .BackStyle = 0
373:             .Left      = 63
374:             .Top       = 5
375:             .Width     = 60
376:             .AutoSize  = .T.
377:             .FontName  = "Tahoma"
378:             .FontSize  = 8
379:             .ForeColor = RGB(90, 90, 90)
380:             .Themes    = .F.
381:         ENDWITH
382:         WITH loc_oPagina.opt_4c_FilSituas.Buttons(3)
383:             .Caption   = "Inativos"
384:             .BackStyle = 0
385:             .Left      = 126
386:             .Top       = 5
387:             .Width     = 65
388:             .AutoSize  = .T.
389:             .FontName  = "Tahoma"
390:             .FontSize  = 8
391:             .ForeColor = RGB(90, 90, 90)
392:             .Themes    = .F.
393:         ENDWITH
394:         BINDEVENT(loc_oPagina.opt_4c_FilSituas, "InteractiveChange", THIS, "OptFilSituasChanged")
395: 
396:         *-- Botao Cond. Pagto (cmdFPOper: top=82+29=111, left=510, w=136, h=45)
397:         loc_oPagina.AddObject("cmd_4c_CmdFPOper", "CommandButton")
398:         WITH loc_oPagina.cmd_4c_CmdFPOper
399:             .Caption       = "Cond. Pagto."
400:             .Top           = 111
401:             .Left          = 510
402:             .Width         = 136
403:             .Height        = 45
404:             .FontName      = "Tahoma"
405:             .FontSize      = 8
406:             .FontBold      = .T.
407:             .ForeColor     = RGB(90, 90, 90)
408:             .BackColor     = RGB(255, 255, 255)
409:             .Themes        = .F.
410:             .SpecialEffect = 0
411:             .Visible       = .T.
412:         ENDWITH
413:         BINDEVENT(loc_oPagina.cmd_4c_CmdFPOper, "Click", THIS, "BtnFpOperClick")
414: 
415:         *-- Botao Tabelas (TabDesconto: top=82+29=111, left=647, w=136, h=45)
416:         loc_oPagina.AddObject("cmd_4c_TabDesconto", "CommandButton")
417:         WITH loc_oPagina.cmd_4c_TabDesconto
418:             .Caption       = "Tabelas"
419:             .Top           = 111
420:             .Left          = 647
421:             .Width         = 136
422:             .Height        = 45
423:             .FontName      = "Tahoma"
424:             .FontSize      = 8
425:             .FontBold      = .T.
426:             .ForeColor     = RGB(90, 90, 90)
427:             .BackColor     = RGB(255, 255, 255)
428:             .Themes        = .F.
429:             .SpecialEffect = 0
430:             .Visible       = .T.
431:         ENDWITH
432:         BINDEVENT(loc_oPagina.cmd_4c_TabDesconto, "Click", THIS, "BtnTabDescontoClick")
433: 
434:         *-- Botao Monta Grade (MontaLista: top=81+29=110, left=783, w=136, h=45)
435:         loc_oPagina.AddObject("cmd_4c_MontaLista", "CommandButton")
436:         WITH loc_oPagina.cmd_4c_MontaLista
437:             .Caption       = "Monta Grade"
438:             .Top           = 110
439:             .Left          = 783
440:             .Width         = 136
441:             .Height        = 45
442:             .FontName      = "Tahoma"
443:             .FontSize      = 8
444:             .FontBold      = .T.
445:             .ForeColor     = RGB(90, 90, 90)
446:             .BackColor     = RGB(255, 255, 255)
447:             .Themes        = .F.
448:             .SpecialEffect = 0
449:             .Visible       = .T.
450:         ENDWITH
451:         BINDEVENT(loc_oPagina.cmd_4c_MontaLista, "Click", THIS, "BtnMontaListaClick")
452: 
453:         *-- Grid (Grade: top=130+29=159; left=13; w=938; h=420)
454:         *-- RecordSource/ColumnCount definidos em CarregarLista() - Problema 36/48
455:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
456:         loc_oPagina.grd_4c_Lista.Top            = 159
457:         loc_oPagina.grd_4c_Lista.Left           = 13
458:         loc_oPagina.grd_4c_Lista.Width          = 938
459:         loc_oPagina.grd_4c_Lista.Height         = 420
460:         loc_oPagina.grd_4c_Lista.FontName       = "Tahoma"
461:         loc_oPagina.grd_4c_Lista.FontSize       = 8
462:         loc_oPagina.grd_4c_Lista.ForeColor      = RGB(90, 90, 90)
463:         loc_oPagina.grd_4c_Lista.BackColor      = RGB(255, 255, 255)
464:         loc_oPagina.grd_4c_Lista.GridLineColor  = RGB(238, 238, 238)
465:         loc_oPagina.grd_4c_Lista.HighlightBackColor = RGB(255, 255, 255)
466:         loc_oPagina.grd_4c_Lista.HighlightForeColor = RGB(15, 41, 104)

*-- Linhas 488 a 600:
488:         *-- Container Botoes Acao (Grupo_Salva: top=7+29=36, left=821, w=160, h=85)
489:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
490:         WITH loc_oPagina.cnt_4c_BotoesAcao
491:             .Top         = 36
492:             .Left        = 821
493:             .Width       = 160
494:             .Height      = 85
495:             .BackStyle   = 0
496:             .BorderWidth = 0
497:             .Visible     = .T.
498:         ENDWITH
499: 
500:         *-- Botao Salvar (cmd_Confirmar: left=5, top=5, w=75, h=75)
501:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Salvar", "CommandButton")
502:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar
503:             .Caption         = "Salvar"
504:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
505:             .PicturePosition = 13
506:             .Top             = 5
507:             .Left            = 5
508:             .Width           = 75
509:             .Height          = 75
510:             .FontName        = "Comic Sans MS"
511:             .FontSize        = 8
512:             .FontBold        = .T.
513:             .FontItalic      = .T.
514:             .ForeColor       = RGB(90, 90, 90)
515:             .BackColor       = RGB(255, 255, 255)
516:             .Themes          = .F.
517:             .SpecialEffect   = 0
518:             .MousePointer    = 15
519:             .WordWrap        = .T.
520:             .AutoSize        = .F.
521:             .Visible         = .T.
522:         ENDWITH
523:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
524: 
525:         *-- Botao Cancelar (cmd_Cancelar: left=80, top=5, w=75, h=75)
526:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
527:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
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
546:             .Visible         = .T.
547:         ENDWITH
548:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
549: 
550:         *-- OptionGroup Movimento (op_ocx: top=61+29=90, left=298, w=123, h=25)
551:         *-- Copers: 1=Entrada, 2=Saida (Value=1 mapeado para Copers=0, Value=2 para Copers=1)
552:         loc_oPagina.AddObject("obj_4c_Op_ocx", "OptionGroup")
553:         WITH loc_oPagina.obj_4c_Op_ocx
554:             .ButtonCount = 2
555:             .Top         = 90
556:             .Left        = 298
557:             .Width       = 128
558:             .Height      = 25
559:             .BackStyle   = 0
560:             .BorderStyle = 0
561:             .Value       = 1
562:             .Visible     = .T.
563:         ENDWITH
564:         WITH loc_oPagina.obj_4c_Op_ocx.Buttons(1)
565:             .Caption   = "Entrada"
566:             .BackStyle = 0
567:             .Left      = 5
568:             .Top       = 5
569:             .Width     = 60
570:             .AutoSize  = .T.
571:             .FontName  = "Tahoma"
572:             .FontSize  = 8
573:             .ForeColor = RGB(90, 90, 90)
574:             .Themes    = .F.
575:             .Value     = 1
576:         ENDWITH
577:         WITH loc_oPagina.obj_4c_Op_ocx.Buttons(2)
578:             .Caption   = "Sa" + CHR(237) + "da"
579:             .BackStyle = 0
580:             .Left      = 63
581:             .Top       = 5
582:             .Width     = 55
583:             .AutoSize  = .T.
584:             .FontName  = "Tahoma"
585:             .FontSize  = 8
586:             .ForeColor = RGB(90, 90, 90)
587:             .Themes    = .F.
588:         ENDWITH
589: 
590:         *-- Label Movimento (Say23: top=65+29=94, left=238, w=61, h=15)
591:         loc_oPagina.AddObject("lbl_4c_Label23", "Label")
592:         WITH loc_oPagina.lbl_4c_Label23
593:             .Caption   = "Movimento :"
594:             .Top       = 94
595:             .Left      = 238
596:             .Width     = 61
597:             .Height    = 15
598:             .FontName  = "Tahoma"
599:             .FontSize  = 8
600:             .FontBold  = .F.

*-- Linhas 610 a 619:
610:         loc_oPagina.AddObject("txt_4c_Desc", "TextBox")
611:         WITH loc_oPagina.txt_4c_Desc
612:             .Value     = ""
613:             .Top       = 116
614:             .Left      = 303
615:             .Width     = 179
616:             .Height    = 23
617:             .FontName  = "Tahoma"
618:             .FontSize  = 8
619:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 625 a 657:
625:         ENDWITH
626: 
627:         *-- Label Codigo (Say1: top=91+29=120, left=257, w=42, h=15)
628:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
629:         WITH loc_oPagina.lbl_4c_Label1
630:             .Caption   = "C" + CHR(243) + "digo :"
631:             .Top       = 120
632:             .Left      = 257
633:             .Width     = 42
634:             .Height    = 15
635:             .FontName  = "Tahoma"
636:             .FontSize  = 8
637:             .FontBold  = .F.
638:             .ForeColor = RGB(90, 90, 90)
639:             .BackStyle = 0
640:             .AutoSize  = .F.
641:             .Alignment = 1
642:             .Visible   = .T.
643:         ENDWITH
644: 
645:         *-- CheckBox Inativar (Chk_Inativar/chk_4c_Chk_Inativar: top=91+29=120, left=495, w=65, h=15)
646:         *-- Bind: OpeInatvs (0=Ativa, 1=Inativa) -> Logical
647:         loc_oPagina.AddObject("chk_4c_Chk_Inativar", "CheckBox")
648:         WITH loc_oPagina.chk_4c_Chk_Inativar
649:             .Caption   = "INATIVA"
650:             .Value     = 0
651:             .Top       = 120
652:             .Left      = 495
653:             .Width     = 65
654:             .Height    = 15
655:             .FontName  = "Tahoma"
656:             .FontSize  = 8
657:             .FontBold  = .F.

*-- Linhas 666 a 675:
666:         loc_oPagina.AddObject("txt_4c_1", "TextBox")
667:         WITH loc_oPagina.txt_4c_1
668:             .Value     = ""
669:             .Top       = 141
670:             .Left      = 303
671:             .Width     = 179
672:             .Height    = 23
673:             .FontName  = "Tahoma"
674:             .FontSize  = 8
675:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 681 a 693:
681:         ENDWITH
682: 
683:         *-- Label Descricao (Say28: top=116+29=145, left=244, w=57, h=15)
684:         loc_oPagina.AddObject("lbl_4c_Label28", "Label")
685:         WITH loc_oPagina.lbl_4c_Label28
686:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
687:             .Top       = 145
688:             .Left      = 244
689:             .Width     = 57
690:             .Height    = 15
691:             .FontName  = "Tahoma"
692:             .FontSize  = 8
693:             .FontBold  = .F.

*-- Linhas 703 a 712:
703:         loc_oPagina.AddObject("cbo_4c_CmbMenus", "ComboBox")
704:         WITH loc_oPagina.cbo_4c_CmbMenus
705:             .Value         = ""
706:             .Top           = 166
707:             .Left          = 303
708:             .Width         = 179
709:             .Height        = 23
710:             .FontName      = "Tahoma"
711:             .FontSize      = 8
712:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 719 a 731:
719:         ENDWITH
720: 
721:         *-- Label Menu (Say3: top=141+29=170, left=264, w=35, h=15)
722:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
723:         WITH loc_oPagina.lbl_4c_Label3
724:             .Caption   = "Menu :"
725:             .Top       = 170
726:             .Left      = 264
727:             .Width     = 35
728:             .Height    = 15
729:             .FontName  = "Tahoma"
730:             .FontSize  = 8
731:             .FontBold  = .F.

*-- Linhas 741 a 750:
741:         loc_oPagina.AddObject("txt_4c_SubMenus", "TextBox")
742:         WITH loc_oPagina.txt_4c_SubMenus
743:             .Value     = ""
744:             .Top       = 192
745:             .Left      = 303
746:             .Width     = 108
747:             .Height    = 23
748:             .FontName  = "Tahoma"
749:             .FontSize  = 8
750:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 756 a 768:
756:         ENDWITH
757: 
758:         *-- Label Submenu (Say12: top=167+29=196, left=246, w=57, h=15)
759:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
760:         WITH loc_oPagina.lbl_4c_Label12
761:             .Caption   = "Submenu :"
762:             .Top       = 196
763:             .Left      = 246
764:             .Width     = 57
765:             .Height    = 15
766:             .FontName  = "Tahoma"
767:             .FontSize  = 8
768:             .FontBold  = .F.

*-- Linhas 774 a 786:
774:         ENDWITH
775: 
776:         *-- Label Ord. (Say5: top=167+29=196, left=417, w=28, h=15)
777:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
778:         WITH loc_oPagina.lbl_4c_Label5
779:             .Caption   = "Ord.:"
780:             .Top       = 196
781:             .Left      = 417
782:             .Width     = 28
783:             .Height    = 15
784:             .FontName  = "Tahoma"
785:             .FontSize  = 8
786:             .FontBold  = .F.

*-- Linhas 796 a 805:
796:         loc_oPagina.AddObject("txt_4c_Ordem", "TextBox")
797:         WITH loc_oPagina.txt_4c_Ordem
798:             .Value     = 0
799:             .Top       = 192
800:             .Left      = 448
801:             .Width     = 34
802:             .Height    = 23
803:             .FontName  = "Tahoma"
804:             .FontSize  = 8
805:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 811 a 823:
811:         ENDWITH
812: 
813:         *-- Label Tipo (Say4: top=192+29=221, left=270, w=29, h=15)
814:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
815:         WITH loc_oPagina.lbl_4c_Label4
816:             .Caption   = "Tipo :"
817:             .Top       = 221
818:             .Left      = 270
819:             .Width     = 29
820:             .Height    = 15
821:             .FontName  = "Tahoma"
822:             .FontSize  = 8
823:             .FontBold  = .F.

*-- Linhas 833 a 842:
833:         loc_oPagina.AddObject("cbo_4c_CmbTOpers", "ComboBox")
834:         WITH loc_oPagina.cbo_4c_CmbTOpers
835:             .Value         = ""
836:             .Top           = 217
837:             .Left          = 303
838:             .Width         = 179
839:             .Height        = 23
840:             .FontName      = "Tahoma"
841:             .FontSize      = 8
842:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 849 a 861:
849:         ENDWITH
850: 
851:         *-- Label Numero (Say25: top=219+29=248, left=253, w=46, h=15)
852:         loc_oPagina.AddObject("lbl_4c_Label25", "Label")
853:         WITH loc_oPagina.lbl_4c_Label25
854:             .Caption   = "N" + CHR(250) + "mero :"
855:             .Top       = 248
856:             .Left      = 253
857:             .Width     = 46
858:             .Height    = 15
859:             .FontName  = "Tahoma"
860:             .FontSize  = 8
861:             .FontBold  = .F.

*-- Linhas 871 a 880:
871:         loc_oPagina.AddObject("txt_4c_NDopes", "TextBox")
872:         WITH loc_oPagina.txt_4c_NDopes
873:             .Value     = 0
874:             .Top       = 244
875:             .Left      = 303
876:             .Width     = 31
877:             .Height    = 23
878:             .FontName  = "Tahoma"
879:             .FontSize  = 8
880:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 886 a 898:
886:         ENDWITH
887: 
888:         *-- Label Moeda (Say7: top=219+29=248, left=404, w=41, h=15)
889:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
890:         WITH loc_oPagina.lbl_4c_Label7
891:             .Caption   = "Moeda :"
892:             .Top       = 248
893:             .Left      = 404
894:             .Width     = 41
895:             .Height    = 15
896:             .FontName  = "Tahoma"
897:             .FontSize  = 8
898:             .FontBold  = .F.

*-- Linhas 908 a 917:
908:         loc_oPagina.AddObject("txt_4c_Moeda", "TextBox")
909:         WITH loc_oPagina.txt_4c_Moeda
910:             .Value     = ""
911:             .Top       = 244
912:             .Left      = 448
913:             .Width     = 34
914:             .Height    = 23
915:             .FontName  = "Tahoma"
916:             .FontSize  = 8
917:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 923 a 935:
923:         ENDWITH
924: 
925:         *-- Label Observacao (Say2: top=242+29=271, left=232, w=67, h=15)
926:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
927:         WITH loc_oPagina.lbl_4c_Label2
928:             .Caption   = "Observa" + CHR(231) + CHR(227) + "o :"
929:             .Top       = 271
930:             .Left      = 232
931:             .Width     = 67
932:             .Height    = 15
933:             .FontName  = "Tahoma"
934:             .FontSize  = 8
935:             .FontBold  = .F.

*-- Linhas 945 a 954:
945:         loc_oPagina.AddObject("obj_4c_MemoObs", "EditBox")
946:         WITH loc_oPagina.obj_4c_MemoObs
947:             .Value      = ""
948:             .Top        = 270
949:             .Left       = 302
950:             .Width      = 505
951:             .Height     = 201
952:             .FontName   = "Tahoma"
953:             .FontSize   = 8
954:             .ForeColor  = RGB(90, 90, 90)

*-- Linhas 1000 a 1062:
1000:                         .Column1.ControlSource     = "cursor_4c_Dados.Dopes"
1001:                         .Column1.Width             = 80
1002:                         .Column1.Alignment         = 0
1003:                         .Column1.Header1.Caption   = "C" + CHR(243) + "digo"
1004:                         .Column1.Header1.Alignment = 2
1005: 
1006:                         .Column2.ControlSource     = "cursor_4c_Dados.NDopes"
1007:                         .Column2.Width             = 50
1008:                         .Column2.Alignment         = 1
1009:                         .Column2.Header1.Caption   = "N" + CHR(250) + "m."
1010:                         .Column2.Header1.Alignment = 2
1011: 
1012:                         .Column3.ControlSource     = "cursor_4c_Dados.Abrevs"
1013:                         .Column3.Width             = 60
1014:                         .Column3.Alignment         = 0
1015:                         .Column3.Header1.Caption   = "Abrev."
1016:                         .Column3.Header1.Alignment = 2
1017: 
1018:                         .Column4.ControlSource     = "cursor_4c_Dados.CMoes"
1019:                         .Column4.Width             = 50
1020:                         .Column4.Alignment         = 0
1021:                         .Column4.Header1.Caption   = "Moeda"
1022:                         .Column4.Header1.Alignment = 2
1023: 
1024:                         .Column5.ControlSource     = "cursor_4c_Dados.Menus"
1025:                         .Column5.Width             = 70
1026:                         .Column5.Alignment         = 0
1027:                         .Column5.Header1.Caption   = "Menu"
1028:                         .Column5.Header1.Alignment = 2
1029: 
1030:                         .Column6.ControlSource     = "cursor_4c_Dados.SubMenus"
1031:                         .Column6.Width             = 100
1032:                         .Column6.Alignment         = 0
1033:                         .Column6.Header1.Caption   = "Submenu"
1034:                         .Column6.Header1.Alignment = 2
1035: 
1036:                         .Column7.ControlSource     = "cursor_4c_Dados.Ordes"
1037:                         .Column7.Width             = 50
1038:                         .Column7.Alignment         = 1
1039:                         .Column7.Header1.Caption   = "Ordem"
1040:                         .Column7.Header1.Alignment = 2
1041: 
1042:                         .Column8.ControlSource     = "cursor_4c_Dados.TipoOps"
1043:                         .Column8.Width             = 50
1044:                         .Column8.Alignment         = 1
1045:                         .Column8.Header1.Caption   = "Tipo"
1046:                         .Column8.Header1.Alignment = 2
1047: 
1048:                         .Column9.ControlSource     = "cursor_4c_Dados.DopMenus"
1049:                         .Column9.Width             = 140
1050:                         .Column9.Alignment         = 0
1051:                         .Column9.Header1.Caption   = "Menu Op."
1052:                         .Column9.Header1.Alignment = 2
1053: 
1054:                         .Column10.ControlSource     = "cursor_4c_Dados.Inativas"
1055:                         .Column10.Width             = 50
1056:                         .Column10.Alignment         = 1
1057:                         .Column10.Header1.Caption   = "Inativa"
1058:                         .Column10.Header1.Alignment = 2
1059:                     ENDWITH
1060: 
1061:                     THIS.FormatarGridLista(loc_oGrid)
1062:                     loc_oGrid.Refresh()

*-- Linhas 1494 a 1506:
1494:         loc_lSalvar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1495: 
1496:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1497:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Salvar", 5)
1498:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Salvar.Enabled = loc_lSalvar
1499:             ENDIF
1500:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1501:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1502:             ENDIF
1503:         ENDIF
1504:     ENDPROC
1505: 
1506:     *==========================================================================


### BO (C:\4c\projeto\app\classes\OpsBO.prg):
*==============================================================================
* OpsBO.prg - Business Object para Cadastro de Opera??es
* Tabela: SigCdOpe | PK: dopes
* Gerado: Fase 1/8 - Propriedades e Init
*==============================================================================

DEFINE CLASS OpsBO AS BusinessBase

    *-- Identidade da entidade
    this_cTabela      = "SigCdOpe"
    this_cCampoChave  = "dopes"

    *--------------------------------------------------------------------------
    * Propriedades - SigCdOpe (campos do formul?rio)
    *--------------------------------------------------------------------------
    this_cDopes     = ""    && dopes    char(20) - C�digo / chave prim�ria
    this_nNDopes    = 0     && ndopes   numeric(4,0) - N�mero da opera��o
    this_cTitOpes   = ""    && titopes  char(30) - T�tulo / descri��o
    this_cMenus     = ""    && menus    char(10) - Menu
    this_cSubMenus  = ""    && submenus char(15) - Submenu
    this_nOrdes     = 0     && ordes    numeric(4,0) - Ordem
    this_cCmoes     = ""    && cmoes    char(3)  - Moeda
    this_nCopers    = 0     && copers   numeric(1,0) - Tipo movimento (0=Entrada,1=Sa�da)
    this_cObsOpes   = ""    && obsopes  text     - Observa��o
    this_nTipoOps   = 0     && tipoops  numeric(2,0) - Tipo de opera��o
    this_cAbrevs    = ""    && abrevs   char(3)  - Abreviatura / reduzida
    this_cNivels    = ""    && nivels   char(20) - Sub-n�vel
    this_nNFiscals  = 0     && nfiscals numeric(1,0) - Fiscal

    *--------------------------------------------------------------------------
    * Propriedades - SigOpCdc (cursor secund?rio - inativa??o)
    *--------------------------------------------------------------------------
    this_nOpeInatvs = 0     && opeinatvs numeric(1,0) - Opera��o inativa (0=Ativa,1=Inativa)

    *==========================================================================
    * Init - Configura tabela e campo chave
    *==========================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdOpe"
        THIS.this_cCampoChave = "dopes"
        RETURN .T.
    ENDPROC

    *==========================================================================
    * ObterChavePrimaria - Retorna chave prim?ria para auditoria
    *==========================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cDopes)
    ENDFUNC

    *==========================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cDopes    = TratarNulo(Dopes,    "C")
                THIS.this_nNDopes   = TratarNulo(NDopes,   "N")
                THIS.this_cTitOpes  = TratarNulo(TitOpes,  "C")
                THIS.this_cMenus    = TratarNulo(Menus,    "C")
                THIS.this_cSubMenus = TratarNulo(SubMenus, "C")
                THIS.this_nOrdes    = TratarNulo(Ordes,    "N")
                THIS.this_cCmoes    = TratarNulo(CMoes,    "C")
                THIS.this_nCopers   = TratarNulo(Copers,   "N")
                THIS.this_cObsOpes  = TratarNulo(ObsOpes,  "C")
                THIS.this_nTipoOps  = TratarNulo(TipoOps,  "N")
                THIS.this_cAbrevs   = TratarNulo(Abrevs,   "C")
                THIS.this_cNivels   = TratarNulo(Nivels,   "C")
                THIS.this_nNFiscals = TratarNulo(NFiscals, "N")
                IF TYPE("OpeInatvs") != "U"
                    THIS.this_nOpeInatvs = TratarNulo(OpeInatvs, "N")
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar cursor:" + CHR(13) + loException.Message, "OpsBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ValidarDados - Valida campos obrigatorios antes de salvar
    *==========================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(ALLTRIM(THIS.this_cDopes))
            MsgAviso("C" + CHR(243) + "digo da Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cDopes)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado!")
                loc_lValido = .F.
            ENDIF
        ENDIF

        IF loc_lValido AND EMPTY(ALLTRIM(THIS.this_cTitOpes))
            MsgAviso("Descri" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o pode ficar em branco!")
            loc_lValido = .F.
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *==========================================================================
    * VerificarCodigoExistente - Verifica se dopes ja existe no banco
    *==========================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdOpe" + ;
                " WHERE Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkOps")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkOps")
                SELECT cursor_4c_ChkOps
                loc_lExiste = (cursor_4c_ChkOps.qtd > 0)
                USE IN cursor_4c_ChkOps
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "OpsBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *==========================================================================
    * AtualizarSigOpCdc - Insere ou atualiza status de inativacao em SigOpCdc
    *==========================================================================
    PROTECTED PROCEDURE AtualizarSigOpCdc()
        LOCAL loc_cSQL, loc_nResultado, loc_nExiste
        loc_nExiste = 0

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpCdc WHERE Dopes = " + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCdc")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCdc")
                SELECT cursor_4c_ChkCdc
                loc_nExiste = NVL(cursor_4c_ChkCdc.qtd, 0)
                USE IN cursor_4c_ChkCdc
            ENDIF

            IF loc_nExiste > 0
                loc_cSQL = "UPDATE SigOpCdc SET OpeInatvs = " + ;
                    FormatarNumeroSQL(THIS.this_nOpeInatvs, 0) + ;
                    " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))
            ELSE
                loc_cSQL = "INSERT INTO SigOpCdc (Dopes, OpeInatvs)" + ;
                    " VALUES (" + ;
                    EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                    FormatarNumeroSQL(THIS.this_nOpeInatvs, 0) + ")"
            ENDIF

            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loException
            MostrarErro("Erro ao atualizar SigOpCdc:" + CHR(13) + loException.Message, "OpsBO.AtualizarSigOpCdc")
        ENDTRY
    ENDPROC

    *==========================================================================
    * Inserir - Insere novo registro em SigCdOpe + SigOpCdc
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdOpe" + ;
                " (Dopes, NDopes, TitOpes, Menus, SubMenus," + ;
                "  Ordes, CMoes, Copers, ObsOpes, TipoOps, Abrevs, Nivels, NFiscals)" + ;
                " VALUES (" + ;
                EscaparSQL(ALLTRIM(THIS.this_cDopes)) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNDopes, 0) + ", " + ;
                EscaparSQL(THIS.this_cTitOpes) + ", " + ;
                EscaparSQL(THIS.this_cMenus) + ", " + ;
                EscaparSQL(THIS.this_cSubMenus) + ", " + ;
                FormatarNumeroSQL(THIS.this_nOrdes, 0) + ", " + ;
                EscaparSQL(THIS.this_cCmoes) + ", " + ;
                FormatarNumeroSQL(THIS.this_nCopers, 0) + ", " + ;
                EscaparSQL(THIS.this_cObsOpes) + ", " + ;
                FormatarNumeroSQL(THIS.this_nTipoOps, 0) + ", " + ;
                EscaparSQL(THIS.this_cAbrevs) + ", " + ;
                EscaparSQL(THIS.this_cNivels) + ", " + ;
                FormatarNumeroSQL(THIS.this_nNFiscals, 0) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.AtualizarSigOpCdc()
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "OpsBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza registro existente em SigCdOpe + SigOpCdc
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdOpe SET" + ;
                " NDopes   = " + FormatarNumeroSQL(THIS.this_nNDopes, 0) + "," + ;
                " TitOpes  = " + EscaparSQL(THIS.this_cTitOpes) + "," + ;
                " Menus    = " + EscaparSQL(THIS.this_cMenus) + "," + ;
                " SubMenus = " + EscaparSQL(THIS.this_cSubMenus) + "," + ;
                " Ordes    = " + FormatarNumeroSQL(THIS.this_nOrdes, 0) + "," + ;
                " CMoes    = " + EscaparSQL(THIS.this_cCmoes) + "," + ;
                " Copers   = " + FormatarNumeroSQL(THIS.this_nCopers, 0) + "," + ;
                " ObsOpes  = " + EscaparSQL(THIS.this_cObsOpes) + "," + ;
                " TipoOps  = " + FormatarNumeroSQL(THIS.this_nTipoOps, 0) + "," + ;
                " Abrevs   = " + EscaparSQL(THIS.this_cAbrevs) + "," + ;
                " Nivels   = " + EscaparSQL(THIS.this_cNivels) + "," + ;
                " NFiscals = " + FormatarNumeroSQL(THIS.this_nNFiscals, 0) + ;
                " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.AtualizarSigOpCdc()
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "OpsBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui registro de SigCdOpe e tabelas relacionadas
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_nUso
        loc_lSucesso = .F.
        loc_nUso     = 0

        TRY
            *-- Verificar uso em SigOpFin (lancamentos financeiros)
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigOpFin" + ;
                " WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFin")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkFin")
                SELECT cursor_4c_ChkFin
                loc_nUso = NVL(cursor_4c_ChkFin.qtd, 0)
                USE IN cursor_4c_ChkFin
            ENDIF

            IF loc_nUso > 0
                MsgAviso("Opera" + CHR(231) + CHR(227) + "o utilizada em lan" + CHR(231) + "amentos e n" + CHR(227) + "o pode ser exclu" + CHR(237) + "da!")
            ELSE
                *-- Excluir registros filhos antes do principal
                SQLEXEC(gnConnHandle, "DELETE FROM SigOpCdd WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)))
                SQLEXEC(gnConnHandle, "DELETE FROM SigOpCdc WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes)))

                *-- Excluir registro principal
                loc_cSQL = "DELETE FROM SigCdOpe WHERE Dopes = " + EscaparSQL(ALLTRIM(THIS.this_cDopes))
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "OpsBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - Lista operacoes com filtro de status
    * par_cFiltro: "" = todos | "Ativo" = ativos | "Inativo" = inativos
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (Dopes C(20), NDopes N(4,0), ;
                        Abrevs C(20), CMoes C(3), Nivels C(20), Menus C(10), ;
                        SubMenus C(15), Ordes N(4,0), TipoOps N(2,0), ;
                        DopMenus C(30), Inativas N(1,0))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cWhere = ""
                IF VARTYPE(par_cFiltro) = "C"
                    DO CASE
                        CASE UPPER(ALLTRIM(par_cFiltro)) = "ATIVO"
                            loc_cWhere = " WHERE NVL(b.OpeInatvs, 0) = 0"
                        CASE UPPER(ALLTRIM(par_cFiltro)) = "INATIVO"
                            loc_cWhere = " WHERE NVL(b.OpeInatvs, 0) = 1"
                    ENDCASE
                ENDIF

                loc_cSQL = "SELECT a.Dopes, a.NDopes, a.Abrevs, a.CMoes," + ;
                    " a.Nivels, a.Menus, a.SubMenus, a.Ordes, a.TipoOps," + ;
                    " LEFT(RIGHT(d.ConfigGers, 89), 30) AS DopMenus," + ;
                    " NVL(b.OpeInatvs, 0) AS Inativas" + ;
                    " FROM SigCdOpe a" + ;
                    " LEFT JOIN SigOpCdc b ON b.Dopes = a.Dopes" + ;
                    " LEFT JOIN SigOpCdd d ON d.Dopes = a.Dopes" + ;
                    loc_cWhere + ;
                    " ORDER BY a.Dopes"

                IF USED("cursor_4c_Dados")
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTmp")
                    IF loc_nResultado >= 0
                        SELECT cursor_4c_Dados
                        ZAP
                        SET NULL ON
                        APPEND FROM DBF("cursor_4c_DadosTmp")
                        SET NULL OFF
                        IF USED("cursor_4c_DadosTmp")
                            USE IN cursor_4c_DadosTmp
                        ENDIF
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ELSE
                    loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                    IF loc_nResultado >= 0
                        GO TOP IN cursor_4c_Dados
                        loc_lSucesso = .T.
                    ELSE
                        MostrarErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    ENDIF
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "OpsBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (Dopes)
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT a.Dopes, a.NDopes, a.TitOpes, a.Menus, a.SubMenus," + ;
                " a.Ordes, a.CMoes, a.Copers, a.ObsOpes, a.TipoOps," + ;
                " a.Abrevs, a.Nivels, a.NFiscals," + ;
                " NVL(b.OpeInatvs, 0) AS OpeInatvs" + ;
                " FROM SigCdOpe a" + ;
                " LEFT JOIN SigOpCdc b ON b.Dopes = a.Dopes" + ;
                " WHERE a.Dopes = " + EscaparSQL(ALLTRIM(par_cCodigo))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Opera" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada!")
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "OpsBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

