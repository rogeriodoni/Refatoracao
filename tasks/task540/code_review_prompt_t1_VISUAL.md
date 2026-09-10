# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 207: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 232: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 257: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 282: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 307: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 346: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 479: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 504: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormTpa.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (990 linhas total):

*-- Linhas 7 a 18:
7: * FASE 6/8: Form - Campos Restantes e Lookups (Page2 - Parte 2)
8: * Inclui: PageFrame (Page1 Lista / Page2 Dados), cabecalhos das duas paginas,
9: *         Page1 completa (cnt_4c_Botoes com 5 botoes CRUD + cnt_4c_Saida com
10: *         cmd_4c_Encerrar + grd_4c_Lista), CarregarLista()/AlternarPagina()
11: *         (PUBLIC - chamados direto por TesteAutomatico.prg), FormatarGridLista()
12: *         e campos Codigo (lbl_4c_Label1 + txt_4c_Codigos) e Descricao
13: *         (lbl_4c_Label2 + txt_4c_Descrs) em Page2 - TODOS os campos do form
14: *         original ja migrados (SigCdTpa so tem Cods/Descrs, sem lookups).
15: * FASE 7/8: Form - Eventos Principais. BINDEVENT dos 4 botoes CRUD de Page1
16: *         (Incluir/Visualizar/Alterar/Excluir) + DblClick do grid -> Visualizar.
17: *         Metodos: BtnIncluirClick(), BtnVisualizarClick(), BtnAlterarClick(),
18: *         BtnExcluirClick() + auxiliares BOParaForm(), LimparCampos(),

*-- Linhas 75 a 86:
75:             ELSE
76:                 THIS.ConfigurarPageFrame()
77: 
78:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
79:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
80:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
81:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
82: 
83:                 THIS.pgf_4c_Paginas.Visible    = .T.
84:                 THIS.pgf_4c_Paginas.ActivePage = 1
85:                 THIS.this_cModoAtual = "LISTA"
86:                 THIS.CarregarLista()

*-- Linhas 105 a 124:
105: 
106:         WITH loc_oPgf
107:             .PageCount = 2
108:             .Top       = -29
109:             .Left      = 0
110:             .Width     = THIS.Width
111:             .Height    = THIS.Height + 29
112:             .Tabs      = .F.
113:             .Visible   = .T.
114: 
115:             .Page1.Caption   = "Lista"
116:             .Page1.BackColor = RGB(100, 100, 100)
117:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118: 
119:             .Page2.Caption   = "Dados"
120:             .Page2.BackColor = RGB(100, 100, 100)
121:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
122:         ENDWITH
123: 
124:         THIS.ConfigurarPaginaLista()

*-- Linhas 138 a 176:
138:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
139:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
140:         WITH loc_oCab
141:             .Top         = 31
142:             .Left        = 0
143:             .Width       = THIS.Width
144:             .Height      = 80
145:             .BackColor   = RGB(100, 100, 100)
146:             .BorderWidth = 0
147:             .Visible     = .T.
148:         ENDWITH
149: 
150:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
151:         WITH loc_oCab.lbl_4c_Sombra
152:             .AutoSize  = .F.
153:             .Caption   = THIS.Caption
154:             .Top       = 15
155:             .Left      = 10
156:             .Width     = THIS.Width
157:             .Height    = 40
158:             .FontName  = "Tahoma"
159:             .FontSize  = 16
160:             .FontBold  = .T.
161:             .ForeColor = RGB(0, 0, 0)
162:             .BackStyle = 0
163:             .Visible   = .T.
164:         ENDWITH
165: 
166:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
167:         WITH loc_oCab.lbl_4c_Titulo
168:             .AutoSize  = .F.
169:             .Caption   = THIS.Caption
170:             .Top       = 18
171:             .Left      = 10
172:             .Width     = THIS.Width
173:             .Height    = 46
174:             .FontName  = "Tahoma"
175:             .FontSize  = 16
176:             .FontBold  = .T.

*-- Linhas 184 a 372:
184:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
185:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
186:         WITH loc_oBotoes
187:             .Top         = 29
188:             .Left        = 542
189:             .Width       = 390
190:             .Height      = 85
191:             .BackColor   = RGB(100, 100, 100)
192:             .BackStyle   = 1
193:             .BorderWidth = 0
194:             .Visible     = .T.
195:         ENDWITH
196: 
197:         *-- Botao Incluir
198:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
199:         WITH loc_oBotoes.cmd_4c_Incluir
200:             .Top             = 5
201:             .Left            = 5
202:             .Width           = 75
203:             .Height          = 75
204:             .Caption         = "Incluir"
205:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
206:             .PicturePosition = 13
207:             .FontName        = "Comic Sans MS"
208:             .FontBold        = .T.
209:             .FontItalic      = .T.
210:             .FontSize        = 8
211:             .ForeColor       = RGB(90, 90, 90)
212:             .BackColor       = RGB(255, 255, 255)
213:             .Themes          = .F.
214:             .SpecialEffect   = 0
215:             .MousePointer    = 15
216:             .WordWrap        = .T.
217:             .AutoSize        = .F.
218:             .Visible         = .T.
219:         ENDWITH
220:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
221: 
222:         *-- Botao Visualizar
223:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
224:         WITH loc_oBotoes.cmd_4c_Visualizar
225:             .Top             = 5
226:             .Left            = 80
227:             .Width           = 75
228:             .Height          = 75
229:             .Caption         = "Visualizar"
230:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
231:             .PicturePosition = 13
232:             .FontName        = "Comic Sans MS"
233:             .FontBold        = .T.
234:             .FontItalic      = .T.
235:             .FontSize        = 8
236:             .ForeColor       = RGB(90, 90, 90)
237:             .BackColor       = RGB(255, 255, 255)
238:             .Themes          = .F.
239:             .SpecialEffect   = 0
240:             .MousePointer    = 15
241:             .WordWrap        = .T.
242:             .AutoSize        = .F.
243:             .Visible         = .T.
244:         ENDWITH
245:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
246: 
247:         *-- Botao Alterar
248:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
249:         WITH loc_oBotoes.cmd_4c_Alterar
250:             .Top             = 5
251:             .Left            = 155
252:             .Width           = 75
253:             .Height          = 75
254:             .Caption         = "Alterar"
255:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
256:             .PicturePosition = 13
257:             .FontName        = "Comic Sans MS"
258:             .FontBold        = .T.
259:             .FontItalic      = .T.
260:             .FontSize        = 8
261:             .ForeColor       = RGB(90, 90, 90)
262:             .BackColor       = RGB(255, 255, 255)
263:             .Themes          = .F.
264:             .SpecialEffect   = 0
265:             .MousePointer    = 15
266:             .WordWrap        = .T.
267:             .AutoSize        = .F.
268:             .Visible         = .T.
269:         ENDWITH
270:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
271: 
272:         *-- Botao Excluir
273:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
274:         WITH loc_oBotoes.cmd_4c_Excluir
275:             .Top             = 5
276:             .Left            = 230
277:             .Width           = 75
278:             .Height          = 75
279:             .Caption         = "Excluir"
280:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
281:             .PicturePosition = 13
282:             .FontName        = "Comic Sans MS"
283:             .FontBold        = .T.
284:             .FontItalic      = .T.
285:             .FontSize        = 8
286:             .ForeColor       = RGB(90, 90, 90)
287:             .BackColor       = RGB(255, 255, 255)
288:             .Themes          = .F.
289:             .SpecialEffect   = 0
290:             .MousePointer    = 15
291:             .WordWrap        = .T.
292:             .AutoSize        = .F.
293:             .Visible         = .T.
294:         ENDWITH
295:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
296: 
297:         *-- Botao Buscar
298:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
299:         WITH loc_oBotoes.cmd_4c_Buscar
300:             .Top             = 5
301:             .Left            = 305
302:             .Width           = 75
303:             .Height          = 75
304:             .Caption         = "Buscar"
305:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
306:             .PicturePosition = 13
307:             .FontName        = "Comic Sans MS"
308:             .FontBold        = .T.
309:             .FontItalic      = .T.
310:             .FontSize        = 8
311:             .ForeColor       = RGB(90, 90, 90)
312:             .BackColor       = RGB(255, 255, 255)
313:             .Themes          = .F.
314:             .SpecialEffect   = 0
315:             .MousePointer    = 15
316:             .WordWrap        = .T.
317:             .AutoSize        = .F.
318:             .Visible         = .T.
319:         ENDWITH
320:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
321: 
322:         *-- Container de saida (Grupo_Saida no legado) - PADRAO CANONICO
323:         *-- PREVALECE sobre PILAR 1 (CLAUDE.md regra #10): Left=917, Width=90
324:         *-- Flutuante/transparente sobre a Page (BackStyle=0)
325:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
326:         loc_oSaida = loc_oPg1.cnt_4c_Saida
327:         WITH loc_oSaida
328:             .Top         = 29
329:             .Left        = 917
330:             .Width       = 90
331:             .Height      = 85
332:             .BackStyle   = 0
333:             .BorderWidth = 0
334:             .Visible     = .T.
335:         ENDWITH
336: 
337:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
338:         WITH loc_oSaida.cmd_4c_Encerrar
339:             .Top             = 5
340:             .Left            = 5
341:             .Width           = 75
342:             .Height          = 75
343:             .Caption         = "Encerrar"
344:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
345:             .PicturePosition = 13
346:             .FontName        = "Comic Sans MS"
347:             .FontBold        = .T.
348:             .FontItalic      = .T.
349:             .FontSize        = 8
350:             .ForeColor       = RGB(90, 90, 90)
351:             .BackColor       = RGB(255, 255, 255)
352:             .Themes          = .F.
353:             .SpecialEffect   = 0
354:             .MousePointer    = 15
355:             .WordWrap        = .T.
356:             .AutoSize        = .F.
357:             .Visible         = .T.
358:         ENDWITH
359:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
360: 
361:         *-- Grid de listagem (Grade no legado)
362:         *-- Original Top=88, Left=26, compensacao PageFrame +29 = 117 (framework_frmcadastro_layout.md)
363:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
364:         loc_oGrid = loc_oPg1.grd_4c_Lista
365:         WITH loc_oGrid
366:             .Top                = 117
367:             .Left               = 26
368:             .Width              = 890
369:             .Height             = 498
370:             .FontName           = "Verdana"
371:             .FontSize           = 8
372:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 386 a 396:
386:         ENDWITH
387: 
388:         loc_oGrid.Column1.Width = 100
389:         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
390:         loc_oGrid.Column2.Width = 780
391:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
392: 
393:         BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")
394: 
395:         THIS.TornarControlesVisiveis(loc_oPg1)
396:     ENDPROC

*-- Linhas 410 a 448:
410:         loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
411:         loc_oCab = loc_oPg2.cnt_4c_Cabecalho
412:         WITH loc_oCab
413:             .Top         = 29
414:             .Left        = 0
415:             .Width       = THIS.Width
416:             .Height      = 80
417:             .BackColor   = RGB(100, 100, 100)
418:             .BorderWidth = 0
419:             .Visible     = .T.
420:         ENDWITH
421: 
422:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
423:         WITH loc_oCab.lbl_4c_Sombra
424:             .AutoSize  = .F.
425:             .Caption   = THIS.Caption
426:             .Top       = 15
427:             .Left      = 10
428:             .Width     = THIS.Width
429:             .Height    = 40
430:             .FontName  = "Tahoma"
431:             .FontSize  = 16
432:             .FontBold  = .T.
433:             .ForeColor = RGB(0, 0, 0)
434:             .BackStyle = 0
435:             .Visible   = .T.
436:         ENDWITH
437: 
438:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
439:         WITH loc_oCab.lbl_4c_Titulo
440:             .AutoSize  = .F.
441:             .Caption   = THIS.Caption
442:             .Top       = 18
443:             .Left      = 10
444:             .Width     = THIS.Width
445:             .Height    = 46
446:             .FontName  = "Tahoma"
447:             .FontSize  = 16
448:             .FontBold  = .T.

*-- Linhas 456 a 546:
456:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
457:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
458:         WITH loc_oBotoesAcao
459:             .Top         = 33
460:             .Left        = 842
461:             .Width       = 160
462:             .Height      = 85
463:             .BackColor   = RGB(255, 255, 255)
464:             .BackStyle   = 1
465:             .BorderWidth = 0
466:             .Visible     = .T.
467:         ENDWITH
468: 
469:         *-- Botao Confirmar (Salvar) - icone cadastro_salvar_60.jpg (Problema 16: NAO confirmar_60)
470:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
471:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
472:             .Top             = 5
473:             .Left            = 5
474:             .Width           = 75
475:             .Height          = 75
476:             .Caption         = "Confirmar"
477:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
478:             .PicturePosition = 13
479:             .FontName        = "Comic Sans MS"
480:             .FontBold        = .T.
481:             .FontItalic      = .T.
482:             .FontSize        = 8
483:             .ForeColor       = RGB(90, 90, 90)
484:             .BackColor       = RGB(255, 255, 255)
485:             .Themes          = .F.
486:             .SpecialEffect   = 0
487:             .MousePointer    = 15
488:             .WordWrap        = .T.
489:             .AutoSize        = .F.
490:             .Visible         = .T.
491:         ENDWITH
492:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
493: 
494:         *-- Botao Cancelar
495:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
496:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
497:             .Top             = 5
498:             .Left            = 80
499:             .Width           = 75
500:             .Height          = 75
501:             .Caption         = "Encerrar"
502:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
503:             .PicturePosition = 13
504:             .FontName        = "Comic Sans MS"
505:             .FontBold        = .T.
506:             .FontItalic      = .T.
507:             .FontSize        = 8
508:             .ForeColor       = RGB(90, 90, 90)
509:             .BackColor       = RGB(255, 255, 255)
510:             .Themes          = .F.
511:             .SpecialEffect   = 0
512:             .MousePointer    = 15
513:             .WordWrap        = .T.
514:             .AutoSize        = .F.
515:             .Visible         = .T.
516:         ENDWITH
517:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
518: 
519:         *-- Campo Codigo (Say1/getCodigos no legado) - FASE 5/8
520:         *-- Original: Say1.Top=134/Left=408/Width=42, getCodigos.Top=131/Left=454/Width=31/Height=23
521:         *-- Compensacao PageFrame +29 (CLAUDE.md regra #11 / Problema #1)
522:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
523:         WITH loc_oPg2.lbl_4c_Label1
524:             .AutoSize  = .F.
525:             .Caption   = "C" + CHR(243) + "digo :"
526:             .Top       = 163
527:             .Left      = 408
528:             .Width     = 42
529:             .Height    = 17
530:             .FontName  = "Tahoma"
531:             .FontSize  = 8
532:             .ForeColor = RGB(90, 90, 90)
533:             .BackStyle = 0
534:             .Visible   = .T.
535:         ENDWITH
536: 
537:         loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
538:         WITH loc_oPg2.txt_4c_Codigos
539:             .Value         = ""
540:             .Top           = 160
541:             .Left          = 454
542:             .Width         = 31
543:             .Height        = 23
544:             .MaxLength     = 3
545:             .Format        = "K!"
546:             .BorderStyle   = 1

*-- Linhas 553 a 583:
553:         ENDWITH
554: 
555:         *-- Campo Descricao (Say2/getDescrs no legado) - FASE 6/8
556:         *-- Original: Say2.Top=160/Left=395 (sem Width explicito - alinhado a
557:         *-- direita ate Left=454, mesmo ponto de getCodigos), getDescrs.Top=157/
558:         *-- Left=454/Width=150/MaxLength=20 (compensacao PageFrame +29)
559:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
560:         WITH loc_oPg2.lbl_4c_Label2
561:             .AutoSize  = .F.
562:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
563:             .Top       = 189
564:             .Left      = 395
565:             .Width     = 55
566:             .Height    = 17
567:             .FontName  = "Tahoma"
568:             .FontSize  = 8
569:             .ForeColor = RGB(90, 90, 90)
570:             .BackStyle = 0
571:             .Visible   = .T.
572:         ENDWITH
573: 
574:         loc_oPg2.AddObject("txt_4c_Descrs", "TextBox")
575:         WITH loc_oPg2.txt_4c_Descrs
576:             .Value         = ""
577:             .Top           = 186
578:             .Left          = 454
579:             .Width         = 150
580:             .Height        = 23
581:             .MaxLength     = 20
582:             .Format        = "K!"
583:             .BorderStyle   = 1

*-- Linhas 625 a 634:
625:                     loc_oGrid.Column1.Width = 100
626:                     loc_oGrid.Column2.Width = 780
627: 
628:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
629:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
630: 
631:                     THIS.FormatarGridLista(loc_oGrid)
632: 
633:                     loc_lResultado = .T.
634:                 ENDIF

*-- Linhas 956 a 968:
956:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
957:         loc_lEditando   = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
958: 
959:         IF PEMSTATUS(loc_oBotoesAcao, "cmd_4c_Confirmar", 5)
960:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando OR (THIS.this_cModoAtual = "EXCLUIR")
961:         ENDIF
962:         IF PEMSTATUS(loc_oBotoesAcao, "cmd_4c_Cancelar", 5)
963:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled = .T.
964:         ENDIF
965:     ENDPROC
966: 
967:     *==========================================================================
968:     * Destroy - Libera recursos ao fechar o formulario


### BO (C:\4c\projeto\app\classes\TpaBO.prg):
*====================================================================
* TpaBO.prg
*
* Business Object para Cadastro de Tipo de Acabamento
* Tabela: SigCdAca
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS TpaBO AS BusinessBase

    *-- Propriedades da entidade (mapeamento para tabela SigCdAca)
    this_cCodigo    = ""    && cods char(3) - PK
    this_cDescricao = ""    && descrs char(20)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdAca"
            THIS.this_cCampoChave = "cods"
            loc_lSucesso = .T.
        CATCH TO loException
            MostrarErro(loException, "TpaBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    FUNCTION ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cCodigo)
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    * REGRA CRITICA: SELECT (par_cAliasCursor) ANTES de acessar campos
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cCodigo    = ALLTRIM(TratarNulo(cods,   "C"))
                THIS.this_cDescricao = ALLTRIM(TratarNulo(descrs, "C"))
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao carregar do cursor:" + CHR(13) + loException.Message, "TpaBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ValidarDados - Valida dados antes de salvar
    * Reproduz a validacao do legado (SIGCDTPA - Click Confirmar):
    *   - Codigo obrigatorio
    *   - Codigo nao pode estar duplicado (ChkRegister), apenas em INSERIR
    *====================================================================
    PROTECTED PROCEDURE ValidarDados()
        LOCAL loc_lValido
        loc_lValido = .T.

        IF EMPTY(THIS.this_cCodigo)
            MsgAviso("Obrigat" + CHR(243) + "rio Informar o C" + CHR(243) + "digo!!!")
            loc_lValido = .F.
        ENDIF

        IF loc_lValido AND THIS.this_lNovoRegistro
            IF THIS.VerificarCodigoExistente(THIS.this_cCodigo)
                MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado...")
                loc_lValido = .F.
            ENDIF
        ENDIF

        RETURN loc_lValido
    ENDPROC

    *====================================================================
    * VerificarCodigoExistente - Verifica se cods ja existe no banco
    *====================================================================
    PROCEDURE VerificarCodigoExistente(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS qtd FROM SigCdAca" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkCod")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkCod")
                SELECT cursor_4c_ChkCod
                loc_lExiste = (cursor_4c_ChkCod.qtd > 0)
            ELSE
                MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

            IF USED("cursor_4c_ChkCod")
                USE IN cursor_4c_ChkCod
            ENDIF
        CATCH TO loException
            MostrarErro("Erro ao verificar c" + CHR(243) + "digo:" + CHR(13) + loException.Message, "TpaBO.VerificarCodigoExistente")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *====================================================================
    * Inserir - Insere novo registro na tabela SigCdAca
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                INSERT INTO SigCdAca (cods, descrs)
                VALUES (
                    <<EscaparSQL(THIS.this_cCodigo)>>,
                    <<EscaparSQL(THIS.this_cDescricao)>>
                )
            ENDTEXT

            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir tipo de acabamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao inserir:" + CHR(13) + loException.Message, "TpaBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - Atualiza registro existente na tabela SigCdAca
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            TEXT TO loc_cSQL TEXTMERGE NOSHOW
                UPDATE SigCdAca
                SET descrs = <<EscaparSQL(THIS.this_cDescricao)>>
                WHERE cods = <<EscaparSQL(THIS.this_cCodigo)>>
            ENDTEXT

            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar tipo de acabamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao atualizar:" + CHR(13) + loException.Message, "TpaBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - Exclui registro da tabela SigCdAca
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdAca WHERE cods = " + EscaparSQL(THIS.this_cCodigo)

            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao excluir tipo de acabamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao excluir:" + CHR(13) + loException.Message, "TpaBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Buscar - Busca registros com filtro opcional
    * Retorna cursor_4c_Dados com cods, descrs
    *====================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
                IF !USED("cursor_4c_Dados")
                    SET NULL ON
                    CREATE CURSOR cursor_4c_Dados (cods C(3), descrs C(20))
                    SET NULL OFF
                ENDIF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cods, descrs FROM SigCdAca"

                IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(par_cFiltro)
                    loc_cSQL = loc_cSQL + " WHERE " + par_cFiltro
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY cods"

                IF USED("cursor_4c_Dados")
                    USE IN cursor_4c_Dados
                ENDIF
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
                IF loc_nResultado >= 0
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao buscar tipos de acabamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao buscar:" + CHR(13) + loException.Message, "TpaBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cods)
    *====================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cods, descrs FROM SigCdAca" + ;
                " WHERE cods = " + EscaparSQL(par_cCodigo)

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0
                IF RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ELSE
                    MsgAviso("Tipo de acabamento n" + CHR(227) + "o encontrado!")
                ENDIF

                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MostrarErro("Erro ao carregar tipo de acabamento:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF

        CATCH TO loException
            MostrarErro("Erro ao carregar:" + CHR(13) + loException.Message, "TpaBO.CarregarPorCodigo")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

