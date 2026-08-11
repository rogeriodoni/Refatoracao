# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 199: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 224: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 249: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 274: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 299: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 335: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 429: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 454: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormFBI.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2211 linhas total):

*-- Linhas 96 a 105:
96:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
97:         WITH THIS.pgf_4c_Paginas
98:             .PageCount  = 2
99:             .Top        = -29
100:             .Left       = 0
101:             .Width      = THIS.Width
102:             .Height     = THIS.Height + 29
103:             .Tabs       = .F.
104:             .Visible    = .T.
105: 

*-- Linhas 111 a 121:
111:             .Page1.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:             .Page2.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
113: 
114:             .Page1.Caption = "Lista"
115:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
116:             .Page2.Caption = "Dados"
117:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
118:         ENDWITH
119:     ENDPROC
120: 
121:     *====================================================================

*-- Linhas 131 a 359:
131:         *-- Container cabecalho (cntSombra no legado)
132:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
133:         WITH loc_oPagina.cnt_4c_Cabecalho
134:             .Top         = 31
135:             .Left        = 0
136:             .Width       = THIS.Width
137:             .Height      = 80
138:             .BackColor   = RGB(100, 100, 100)
139:             .BorderWidth = 0
140:             .Visible     = .T.
141:         ENDWITH
142: 
143:         *-- Label sombra (efeito visual)
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
146:             .Top       = 15
147:             .Left      = 10
148:             .Width     = 769
149:             .Height    = 40
150:             .Caption   = "Cadastro de Fabrica" + CHR(231) + CHR(227) + "o"
151:             .FontName  = "Tahoma"
152:             .FontSize  = 16
153:             .FontBold  = .T.
154:             .ForeColor = RGB(0, 0, 0)
155:             .BackStyle = 0
156:             .AutoSize  = .F.
157:             .Visible   = .T.
158:         ENDWITH
159: 
160:         *-- Label titulo principal
161:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
162:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
163:             .Top       = 18
164:             .Left      = 10
165:             .Width     = 769
166:             .Height    = 46
167:             .Caption   = "Cadastro de Fabrica" + CHR(231) + CHR(227) + "o"
168:             .FontName  = "Tahoma"
169:             .FontSize  = 16
170:             .FontBold  = .T.
171:             .ForeColor = RGB(255, 255, 255)
172:             .BackStyle = 0
173:             .AutoSize  = .F.
174:             .Visible   = .T.
175:         ENDWITH
176: 
177:         *-- Container botoes CRUD (Grupo_Op no legado) - LADO DIREITO
178:         loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
179:         WITH loc_oPagina.cnt_4c_Botoes
180:             .Top         = 29
181:             .Left        = 542
182:             .Width       = 390
183:             .Height      = 85
184:             .BackStyle = 0
185:             .BorderWidth = 0
186:             .Visible     = .T.
187:         ENDWITH
188: 
189:         *-- Botao Incluir
190:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
191:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
192:             .Caption         = "Incluir"
193:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
194:             .PicturePosition = 13
195:             .Top             = 5
196:             .Left            = 5
197:             .Width           = 75
198:             .Height          = 75
199:             .FontName        = "Comic Sans MS"
200:             .FontSize        = 8
201:             .FontBold        = .T.
202:             .FontItalic      = .T.
203:             .ForeColor       = RGB(90, 90, 90)
204:             .BackColor       = RGB(255, 255, 255)
205:             .Themes          = .F.
206:             .SpecialEffect   = 0
207:             .MousePointer    = 15
208:             .WordWrap        = .T.
209:             .AutoSize        = .F.
210:             .Visible         = .T.
211:         ENDWITH
212:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
213: 
214:         *-- Botao Visualizar
215:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
216:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
217:             .Caption         = "Visualizar"
218:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
219:             .PicturePosition = 13
220:             .Top             = 5
221:             .Left            = 80
222:             .Width           = 75
223:             .Height          = 75
224:             .FontName        = "Comic Sans MS"
225:             .FontSize        = 8
226:             .FontBold        = .T.
227:             .FontItalic      = .T.
228:             .ForeColor       = RGB(90, 90, 90)
229:             .BackColor       = RGB(255, 255, 255)
230:             .Themes          = .F.
231:             .SpecialEffect   = 0
232:             .MousePointer    = 15
233:             .WordWrap        = .T.
234:             .AutoSize        = .F.
235:             .Visible         = .T.
236:         ENDWITH
237:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
238: 
239:         *-- Botao Alterar
240:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
241:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
242:             .Caption         = "Alterar"
243:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
244:             .PicturePosition = 13
245:             .Top             = 5
246:             .Left            = 155
247:             .Width           = 75
248:             .Height          = 75
249:             .FontName        = "Comic Sans MS"
250:             .FontSize        = 8
251:             .FontBold        = .T.
252:             .FontItalic      = .T.
253:             .ForeColor       = RGB(90, 90, 90)
254:             .BackColor       = RGB(255, 255, 255)
255:             .Themes          = .F.
256:             .SpecialEffect   = 0
257:             .MousePointer    = 15
258:             .WordWrap        = .T.
259:             .AutoSize        = .F.
260:             .Visible         = .T.
261:         ENDWITH
262:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
263: 
264:         *-- Botao Excluir
265:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
266:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
267:             .Caption         = "Excluir"
268:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
269:             .PicturePosition = 13
270:             .Top             = 5
271:             .Left            = 230
272:             .Width           = 75
273:             .Height          = 75
274:             .FontName        = "Comic Sans MS"
275:             .FontSize        = 8
276:             .FontBold        = .T.
277:             .FontItalic      = .T.
278:             .ForeColor       = RGB(90, 90, 90)
279:             .BackColor       = RGB(255, 255, 255)
280:             .Themes          = .F.
281:             .SpecialEffect   = 0
282:             .MousePointer    = 15
283:             .WordWrap        = .T.
284:             .AutoSize        = .F.
285:             .Visible         = .T.
286:         ENDWITH
287:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
288: 
289:         *-- Botao Buscar
290:         loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
291:         WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
292:             .Caption         = "Buscar"
293:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
294:             .PicturePosition = 13
295:             .Top             = 5
296:             .Left            = 305
297:             .Width           = 75
298:             .Height          = 75
299:             .FontName        = "Comic Sans MS"
300:             .FontSize        = 8
301:             .FontBold        = .T.
302:             .FontItalic      = .T.
303:             .ForeColor       = RGB(90, 90, 90)
304:             .BackColor       = RGB(255, 255, 255)
305:             .Themes          = .F.
306:             .SpecialEffect   = 0
307:             .MousePointer    = 15
308:             .WordWrap        = .T.
309:             .AutoSize        = .F.
310:             .Visible         = .T.
311:         ENDWITH
312:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
313: 
314:         *-- Container Encerrar (canonico: Left=917, Width=90)
315:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
316:         WITH loc_oPagina.cnt_4c_Saida
317:             .Top         = 29
318:             .Left        = 917
319:             .Width       = 90
320:             .Height      = 85
321:             .BackStyle   = 0
322:             .BorderWidth = 0
323:             .Visible     = .T.
324:         ENDWITH
325: 
326:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
327:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
328:             .Caption         = "Encerrar"
329:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
330:             .PicturePosition = 13
331:             .Top             = 5
332:             .Left            = 5
333:             .Width           = 75
334:             .Height          = 75
335:             .FontName        = "Comic Sans MS"
336:             .FontSize        = 8
337:             .FontBold        = .T.
338:             .FontItalic      = .T.
339:             .ForeColor       = RGB(90, 90, 90)
340:             .BackColor       = RGB(255, 255, 255)
341:             .Themes          = .F.
342:             .SpecialEffect   = 0
343:             .MousePointer    = 15
344:             .WordWrap        = .T.
345:             .AutoSize        = .F.
346:             .Visible         = .T.
347:         ENDWITH
348:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
349: 
350:         *-- Grid de lista
351:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
352:         WITH loc_oPagina.grd_4c_Lista
353:             .Top                  = 121
354:             .Left                 = 12
355:             .Width                = 890
356:             .Height               = 440
357:             .FontName             = "Verdana"
358:             .FontSize             = 8
359:             .ForeColor            = RGB(90, 90, 90)

*-- Linhas 374 a 394:
374:         *-- Configurar colunas do grid apos ColumnCount
375:         WITH loc_oPagina.grd_4c_Lista
376:             .Column1.Width              = 160
377:             .Column1.Header1.Caption    = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o"
378:             .Column1.Alignment          = 0
379: 
380:             .Column2.Width              = 80
381:             .Column2.Header1.Caption    = "Empresa"
382:             .Column2.Alignment          = 0
383: 
384:             .Column3.Width              = 300
385:             .Column3.Header1.Caption    = "Fabrica" + CHR(231) + CHR(227) + "o (Criptografado)"
386:             .Column3.Alignment          = 0
387: 
388:             .Column4.Width              = 120
389:             .Column4.Header1.Caption    = "Caixa"
390:             .Column4.Alignment          = 0
391:         ENDWITH
392: 
393:         *-- Tornar controles visiveis
394:         THIS.TornarControlesVisiveis(loc_oPagina)

*-- Linhas 407 a 528:
407:         *-- Container botoes Salvar/Cancelar (Grupo_Salva no legado)
408:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
409:         WITH loc_oPagina.cnt_4c_BotoesAcao
410:             .Top         = 33
411:             .Left        = 842
412:             .Width       = 160
413:             .Height      = 85
414:             .BackStyle   = 0
415:             .BorderWidth = 0
416:             .Visible     = .T.
417:         ENDWITH
418: 
419:         *-- Botao Confirmar (Salvar)
420:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
421:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
422:             .Caption         = "Confirmar"
423:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
424:             .PicturePosition = 13
425:             .Top             = 5
426:             .Left            = 5
427:             .Width           = 75
428:             .Height          = 75
429:             .FontName        = "Comic Sans MS"
430:             .FontSize        = 8
431:             .FontBold        = .T.
432:             .FontItalic      = .T.
433:             .ForeColor       = RGB(90, 90, 90)
434:             .BackColor       = RGB(255, 255, 255)
435:             .Themes          = .F.
436:             .SpecialEffect   = 0
437:             .MousePointer    = 15
438:             .WordWrap        = .T.
439:             .AutoSize        = .F.
440:             .Visible         = .T.
441:         ENDWITH
442:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
443: 
444:         *-- Botao Cancelar
445:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
446:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
447:             .Caption         = "Encerrar"
448:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
449:             .PicturePosition = 13
450:             .Top             = 5
451:             .Left            = 80
452:             .Width           = 75
453:             .Height          = 75
454:             .FontName        = "Comic Sans MS"
455:             .FontSize        = 8
456:             .FontBold        = .T.
457:             .FontItalic      = .T.
458:             .ForeColor       = RGB(90, 90, 90)
459:             .BackColor       = RGB(255, 255, 255)
460:             .Themes          = .F.
461:             .SpecialEffect   = 0
462:             .MousePointer    = 15
463:             .WordWrap        = .T.
464:             .AutoSize        = .F.
465:             .Visible         = .T.
466:         ENDWITH
467:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
468: 
469:         *-- === COLUNA ESQUERDA - Campos da Page2 (Fase 5: primeiros 50%) ===
470: 
471:         *-- NFAB - No. Fabricacao (chave de negocio, desabilitado no ALTERAR)
472:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
473:         WITH loc_oPagina.lbl_4c_Label1
474:             .Top       = 216
475:             .Left      = 137
476:             .Width     = 115
477:             .Height    = 17
478:             .Caption   = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o - NFAB. :"
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .ForeColor = RGB(255, 255, 255)
482:             .BackStyle = 0
483:             .Alignment = 1
484:             .AutoSize  = .F.
485:             .Visible   = .T.
486:         ENDWITH
487: 
488:         loc_oPagina.AddObject("txt_4c_Codigo", "TextBox")
489:         WITH loc_oPagina.txt_4c_Codigo
490:             .Top       = 213
491:             .Left      = 256
492:             .Width     = 157
493:             .Height    = 23
494:             .Value     = ""
495:             .MaxLength = 20
496:             .FontName  = "Tahoma"
497:             .FontSize  = 8
498:             .BackColor = RGB(255, 255, 255)
499:             .ForeColor = RGB(0, 0, 0)
500:             .Visible   = .T.
501:         ENDWITH
502: 
503:         *-- NSEQ - No. do Caixa (obrigatorio 3 digitos)
504:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
505:         WITH loc_oPagina.lbl_4c_Label3
506:             .Top       = 241
507:             .Left      = 146
508:             .Width     = 108
509:             .Height    = 17
510:             .Caption   = "N" + CHR(186) + " do Caixa - NSEQ. :"
511:             .FontName  = "Tahoma"
512:             .FontSize  = 8
513:             .ForeColor = RGB(255, 255, 255)
514:             .BackStyle = 0
515:             .Alignment = 1
516:             .AutoSize  = .F.
517:             .Visible   = .T.
518:         ENDWITH
519: 
520:         loc_oPagina.AddObject("txt_4c_Ncaixa", "TextBox")
521:         WITH loc_oPagina.txt_4c_Ncaixa
522:             .Top       = 238
523:             .Left      = 256
524:             .Width     = 31
525:             .Height    = 21
526:             .Value     = ""
527:             .MaxLength = 3
528:             .FontName  = "Tahoma"

*-- Linhas 534 a 593:
534:         BINDEVENT(loc_oPagina.txt_4c_Ncaixa, "KeyPress", THIS, "NcaixaLostFocus")
535: 
536:         *-- Contador Reinicio de Operacao
537:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
538:         WITH loc_oPagina.lbl_4c_Label4
539:             .Top       = 265
540:             .Left      = 96
541:             .Width     = 158
542:             .Height    = 17
543:             .Caption   = "Contador Reinicio de Opera" + CHR(231) + CHR(227) + "o :"
544:             .FontName  = "Tahoma"
545:             .FontSize  = 8
546:             .ForeColor = RGB(255, 255, 255)
547:             .BackStyle = 0
548:             .Alignment = 1
549:             .AutoSize  = .F.
550:             .Visible   = .T.
551:         ENDWITH
552: 
553:         loc_oPagina.AddObject("txt_4c_Interv", "TextBox")
554:         WITH loc_oPagina.txt_4c_Interv
555:             .Top       = 262
556:             .Left      = 256
557:             .Width     = 38
558:             .Height    = 21
559:             .Value     = ""
560:             .MaxLength = 4
561:             .FontName  = "Tahoma"
562:             .FontSize  = 8
563:             .BackColor = RGB(255, 255, 255)
564:             .ForeColor = RGB(0, 0, 0)
565:             .Visible   = .T.
566:         ENDWITH
567: 
568:         *-- Empresa (lookup em SigCdEmp)
569:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
570:         WITH loc_oPagina.lbl_4c_Label5
571:             .Top       = 290
572:             .Left      = 204
573:             .Width     = 50
574:             .Height    = 17
575:             .Caption   = "Empresa :"
576:             .FontName  = "Tahoma"
577:             .FontSize  = 8
578:             .ForeColor = RGB(255, 255, 255)
579:             .BackStyle = 0
580:             .Alignment = 1
581:             .AutoSize  = .F.
582:             .Visible   = .T.
583:         ENDWITH
584: 
585:         loc_oPagina.AddObject("txt_4c_Emp", "TextBox")
586:         WITH loc_oPagina.txt_4c_Emp
587:             .Top       = 286
588:             .Left      = 256
589:             .Width     = 38
590:             .Height    = 21
591:             .Value     = ""
592:             .MaxLength = 3
593:             .FontName  = "Tahoma"

*-- Linhas 600 a 691:
600:         BINDEVENT(loc_oPagina.txt_4c_Emp, "KeyPress", THIS, "EmpresaKeyPress")
601: 
602:         *-- GT Inicial
603:         loc_oPagina.AddObject("lbl_4c_Label12", "Label")
604:         WITH loc_oPagina.lbl_4c_Label12
605:             .Top       = 314
606:             .Left      = 202
607:             .Width     = 52
608:             .Height    = 17
609:             .Caption   = "GT Inicial :"
610:             .FontName  = "Tahoma"
611:             .FontSize  = 8
612:             .ForeColor = RGB(255, 255, 255)
613:             .BackStyle = 0
614:             .Alignment = 1
615:             .AutoSize  = .F.
616:             .Visible   = .T.
617:         ENDWITH
618: 
619:         loc_oPagina.AddObject("txt_4c_GTInicial", "TextBox")
620:         WITH loc_oPagina.txt_4c_GTInicial
621:             .Top       = 311
622:             .Left      = 256
623:             .Width     = 175
624:             .Height    = 23
625:             .Value     = ""
626:             .MaxLength = 30
627:             .FontName  = "Tahoma"
628:             .FontSize  = 8
629:             .BackColor = RGB(255, 255, 255)
630:             .ForeColor = RGB(0, 0, 0)
631:             .Visible   = .T.
632:         ENDWITH
633: 
634:         *-- GT Atual
635:         loc_oPagina.AddObject("lbl_4c_Label30", "Label")
636:         WITH loc_oPagina.lbl_4c_Label30
637:             .Top       = 339
638:             .Left      = 204
639:             .Width     = 50
640:             .Height    = 17
641:             .Caption   = "GT Atual :"
642:             .FontName  = "Tahoma"
643:             .FontSize  = 8
644:             .ForeColor = RGB(255, 255, 255)
645:             .BackStyle = 0
646:             .Alignment = 1
647:             .AutoSize  = .F.
648:             .Visible   = .T.
649:         ENDWITH
650: 
651:         loc_oPagina.AddObject("txt_4c_Gtatual", "TextBox")
652:         WITH loc_oPagina.txt_4c_Gtatual
653:             .Top       = 336
654:             .Left      = 256
655:             .Width     = 175
656:             .Height    = 23
657:             .Value     = ""
658:             .MaxLength = 30
659:             .FontName  = "Tahoma"
660:             .FontSize  = 8
661:             .BackColor = RGB(255, 255, 255)
662:             .ForeColor = RGB(0, 0, 0)
663:             .Visible   = .T.
664:         ENDWITH
665: 
666:         *-- Modelo ECF (lookup em SigFiMpM)
667:         loc_oPagina.AddObject("lbl_4c_Label16", "Label")
668:         WITH loc_oPagina.lbl_4c_Label16
669:             .Top       = 365
670:             .Left      = 211
671:             .Width     = 43
672:             .Height    = 17
673:             .Caption   = "Modelo :"
674:             .FontName  = "Tahoma"
675:             .FontSize  = 8
676:             .ForeColor = RGB(255, 255, 255)
677:             .BackStyle = 0
678:             .Alignment = 1
679:             .AutoSize  = .F.
680:             .Visible   = .T.
681:         ENDWITH
682: 
683:         loc_oPagina.AddObject("txt_4c_Modelo", "TextBox")
684:         WITH loc_oPagina.txt_4c_Modelo
685:             .Top       = 361
686:             .Left      = 256
687:             .Width     = 220
688:             .Height    = 23
689:             .Value     = ""
690:             .MaxLength = 30
691:             .FontName  = "Tahoma"

*-- Linhas 698 a 725:
698:         BINDEVENT(loc_oPagina.txt_4c_Modelo, "KeyPress", THIS, "ModeloKeyPress")
699: 
700:         *-- Numero do Usuario do ECF
701:         loc_oPagina.AddObject("lbl_4c_Label17", "Label")
702:         WITH loc_oPagina.lbl_4c_Label17
703:             .Top       = 390
704:             .Left      = 114
705:             .Width     = 140
706:             .Height    = 17
707:             .Caption   = "Numero do Usu" + CHR(225) + "rio do ECF :"
708:             .FontName  = "Tahoma"
709:             .FontSize  = 8
710:             .ForeColor = RGB(255, 255, 255)
711:             .BackStyle = 0
712:             .Alignment = 1
713:             .AutoSize  = .F.
714:             .Visible   = .T.
715:         ENDWITH
716: 
717:         loc_oPagina.AddObject("txt_4c_NumUsu", "TextBox")
718:         WITH loc_oPagina.txt_4c_NumUsu
719:             .Top       = 386
720:             .Left      = 256
721:             .Width     = 25
722:             .Height    = 21
723:             .Value     = ""
724:             .MaxLength = 2
725:             .InputMask = "99"

*-- Linhas 733 a 856:
733:         BINDEVENT(loc_oPagina.txt_4c_NumUsu, "KeyPress", THIS, "NumUsuLostFocus")
734: 
735:         *-- Tipo do ECF
736:         loc_oPagina.AddObject("lbl_4c_Label18", "Label")
737:         WITH loc_oPagina.lbl_4c_Label18
738:             .Top       = 414
739:             .Left      = 188
740:             .Width     = 66
741:             .Height    = 17
742:             .Caption   = "Tipo do ECF :"
743:             .FontName  = "Tahoma"
744:             .FontSize  = 8
745:             .ForeColor = RGB(255, 255, 255)
746:             .BackStyle = 0
747:             .Alignment = 1
748:             .AutoSize  = .F.
749:             .Visible   = .T.
750:         ENDWITH
751: 
752:         loc_oPagina.AddObject("txt_4c_TipoECF", "TextBox")
753:         WITH loc_oPagina.txt_4c_TipoECF
754:             .Top       = 410
755:             .Left      = 256
756:             .Width     = 59
757:             .Height    = 23
758:             .Value     = ""
759:             .MaxLength = 7
760:             .FontName  = "Tahoma"
761:             .FontSize  = 8
762:             .BackColor = RGB(255, 255, 255)
763:             .ForeColor = RGB(0, 0, 0)
764:             .Visible   = .T.
765:         ENDWITH
766: 
767:         *-- Versao do Software Basico
768:         loc_oPagina.AddObject("lbl_4c_Label19", "Label")
769:         WITH loc_oPagina.lbl_4c_Label19
770:             .Top       = 437
771:             .Left      = 121
772:             .Width     = 133
773:             .Height    = 17
774:             .Caption   = "Vers" + CHR(227) + "o do Sofware B" + CHR(225) + "sico :"
775:             .FontName  = "Tahoma"
776:             .FontSize  = 8
777:             .ForeColor = RGB(255, 255, 255)
778:             .BackStyle = 0
779:             .Alignment = 1
780:             .AutoSize  = .F.
781:             .Visible   = .T.
782:         ENDWITH
783: 
784:         loc_oPagina.AddObject("txt_4c_VerSB", "TextBox")
785:         WITH loc_oPagina.txt_4c_VerSB
786:             .Top       = 434
787:             .Left      = 256
788:             .Width     = 80
789:             .Height    = 21
790:             .Value     = ""
791:             .MaxLength = 10
792:             .FontName  = "Tahoma"
793:             .FontSize  = 8
794:             .BackColor = RGB(255, 255, 255)
795:             .ForeColor = RGB(0, 0, 0)
796:             .Visible   = .T.
797:         ENDWITH
798: 
799:         *-- Data do Software Basico
800:         loc_oPagina.AddObject("lbl_4c_Label20", "Label")
801:         WITH loc_oPagina.lbl_4c_Label20
802:             .Top       = 461
803:             .Left      = 131
804:             .Width     = 123
805:             .Height    = 17
806:             .Caption   = "Data do Sofware B" + CHR(225) + "sico :"
807:             .FontName  = "Tahoma"
808:             .FontSize  = 8
809:             .ForeColor = RGB(255, 255, 255)
810:             .BackStyle = 0
811:             .Alignment = 1
812:             .AutoSize  = .F.
813:             .Visible   = .T.
814:         ENDWITH
815: 
816:         loc_oPagina.AddObject("txt_4c_DataSB", "TextBox")
817:         WITH loc_oPagina.txt_4c_DataSB
818:             .Top       = 458
819:             .Left      = 256
820:             .Width     = 80
821:             .Height    = 21
822:             .Value     = {}
823:             .Format    = "D"
824:             .FontName  = "Tahoma"
825:             .FontSize  = 8
826:             .BackColor = RGB(255, 255, 255)
827:             .ForeColor = RGB(0, 0, 0)
828:             .Visible   = .T.
829:         ENDWITH
830: 
831:         *-- Hora do Software Basico
832:         loc_oPagina.AddObject("lbl_4c_Label21", "Label")
833:         WITH loc_oPagina.lbl_4c_Label21
834:             .Top       = 485
835:             .Left      = 131
836:             .Width     = 123
837:             .Height    = 17
838:             .Caption   = "Hora do Sofware B" + CHR(225) + "sico :"
839:             .FontName  = "Tahoma"
840:             .FontSize  = 8
841:             .ForeColor = RGB(255, 255, 255)
842:             .BackStyle = 0
843:             .Alignment = 1
844:             .AutoSize  = .F.
845:             .Visible   = .T.
846:         ENDWITH
847: 
848:         loc_oPagina.AddObject("txt_4c_HoraSB", "TextBox")
849:         WITH loc_oPagina.txt_4c_HoraSB
850:             .Top       = 482
851:             .Left      = 256
852:             .Width     = 64
853:             .Height    = 21
854:             .Value     = ""
855:             .MaxLength = 8
856:             .InputMask = "99:99:99"

*-- Linhas 862 a 921:
862:         ENDWITH
863: 
864:         *-- Comando de Geracao RFD
865:         loc_oPagina.AddObject("lbl_4c_Label22", "Label")
866:         WITH loc_oPagina.lbl_4c_Label22
867:             .Top       = 510
868:             .Left      = 119
869:             .Width     = 135
870:             .Height    = 17
871:             .Caption   = "Comando de Gera" + CHR(231) + CHR(227) + "o RFD :"
872:             .FontName  = "Tahoma"
873:             .FontSize  = 8
874:             .ForeColor = RGB(255, 255, 255)
875:             .BackStyle = 0
876:             .Alignment = 1
877:             .AutoSize  = .F.
878:             .Visible   = .T.
879:         ENDWITH
880: 
881:         loc_oPagina.AddObject("txt_4c_CmdRFD", "TextBox")
882:         WITH loc_oPagina.txt_4c_CmdRFD
883:             .Top       = 506
884:             .Left      = 256
885:             .Width     = 30
886:             .Height    = 23
887:             .Value     = ""
888:             .MaxLength = 3
889:             .FontName  = "Tahoma"
890:             .FontSize  = 8
891:             .BackColor = RGB(255, 255, 255)
892:             .ForeColor = RGB(0, 0, 0)
893:             .Visible   = .T.
894:         ENDWITH
895: 
896:         *-- COO Inicial (Troca Aplicativo)
897:         loc_oPagina.AddObject("lbl_4c_Label27", "Label")
898:         WITH loc_oPagina.lbl_4c_Label27
899:             .Top       = 534
900:             .Left      = 109
901:             .Width     = 145
902:             .Height    = 15
903:             .Caption   = "Coo Inicial (Troca Aplicativo) :"
904:             .FontName  = "Tahoma"
905:             .FontSize  = 8
906:             .ForeColor = RGB(255, 255, 255)
907:             .BackStyle = 0
908:             .Alignment = 1
909:             .AutoSize  = .F.
910:             .Visible   = .T.
911:         ENDWITH
912: 
913:         loc_oPagina.AddObject("txt_4c_Coos", "TextBox")
914:         WITH loc_oPagina.txt_4c_Coos
915:             .Top       = 530
916:             .Left      = 256
917:             .Width     = 52
918:             .Height    = 23
919:             .Value     = ""
920:             .MaxLength = 6
921:             .FontName  = "Tahoma"

*-- Linhas 929 a 956:
929:         *-- === COLUNA DIREITA - primeiros campos (Fase 5) ===
930: 
931:         *-- Data do Cadastro do ECF
932:         loc_oPagina.AddObject("lbl_4c_Label23", "Label")
933:         WITH loc_oPagina.lbl_4c_Label23
934:             .Top       = 216
935:             .Left      = 497
936:             .Width     = 131
937:             .Height    = 17
938:             .Caption   = "Data do Cadastro do ECF :"
939:             .FontName  = "Tahoma"
940:             .FontSize  = 8
941:             .ForeColor = RGB(255, 255, 255)
942:             .BackStyle = 0
943:             .Alignment = 1
944:             .AutoSize  = .F.
945:             .Visible   = .T.
946:         ENDWITH
947: 
948:         loc_oPagina.AddObject("txt_4c_DtCad", "TextBox")
949:         WITH loc_oPagina.txt_4c_DtCad
950:             .Top       = 213
951:             .Left      = 630
952:             .Width     = 80
953:             .Height    = 21
954:             .Value     = {}
955:             .Format    = "D"
956:             .FontName  = "Tahoma"

*-- Linhas 963 a 990:
963:         *-- === COLUNA DIREITA - campos restantes (Fase 6) ===
964: 
965:         *-- Hora do Cadastro do ECF
966:         loc_oPagina.AddObject("lbl_4c_Label24", "Label")
967:         WITH loc_oPagina.lbl_4c_Label24
968:             .Top       = 240
969:             .Left      = 497
970:             .Width     = 131
971:             .Height    = 17
972:             .Caption   = "Hora do Cadastro do ECF :"
973:             .FontName  = "Tahoma"
974:             .FontSize  = 8
975:             .ForeColor = RGB(255, 255, 255)
976:             .BackStyle = 0
977:             .Alignment = 1
978:             .AutoSize  = .F.
979:             .Visible   = .T.
980:         ENDWITH
981: 
982:         loc_oPagina.AddObject("txt_4c_HrCad", "TextBox")
983:         WITH loc_oPagina.txt_4c_HrCad
984:             .Top       = 237
985:             .Left      = 630
986:             .Width     = 64
987:             .Height    = 21
988:             .Value     = ""
989:             .MaxLength = 8
990:             .InputMask = "99:99:99"

*-- Linhas 997 a 1024:
997:         ENDWITH
998: 
999:         *-- Reinicio de Operacoes / CRO Inicial
1000:         loc_oPagina.AddObject("lbl_4c_Label25", "Label")
1001:         WITH loc_oPagina.lbl_4c_Label25
1002:             .Top       = 264
1003:             .Left      = 513
1004:             .Width     = 115
1005:             .Height    = 17
1006:             .Caption   = "Reinicio de Opera" + CHR(231) + CHR(245) + "es :"
1007:             .FontName  = "Tahoma"
1008:             .FontSize  = 8
1009:             .ForeColor = RGB(255, 255, 255)
1010:             .BackStyle = 0
1011:             .Alignment = 1
1012:             .AutoSize  = .F.
1013:             .Visible   = .T.
1014:         ENDWITH
1015: 
1016:         loc_oPagina.AddObject("txt_4c_CRO", "TextBox")
1017:         WITH loc_oPagina.txt_4c_CRO
1018:             .Top       = 261
1019:             .Left      = 630
1020:             .Width     = 50
1021:             .Height    = 23
1022:             .Value     = ""
1023:             .MaxLength = 6
1024:             .InputMask = "999999"

*-- Linhas 1031 a 1324:
1031:         BINDEVENT(loc_oPagina.txt_4c_CRO, "KeyPress", THIS, "CROLostFocus")
1032: 
1033:         *-- Leitura Mem. Fiscal Automatico
1034:         loc_oPagina.AddObject("lbl_4c_Label13", "Label")
1035:         WITH loc_oPagina.lbl_4c_Label13
1036:             .Top       = 285
1037:             .Left      = 468
1038:             .Width     = 160
1039:             .Height    = 17
1040:             .Caption   = "Leitura Mem. Fiscal Autom" + CHR(225) + "tico :"
1041:             .FontName  = "Tahoma"
1042:             .FontSize  = 8
1043:             .ForeColor = RGB(255, 255, 255)
1044:             .BackStyle = 0
1045:             .Alignment = 1
1046:             .AutoSize  = .F.
1047:             .Visible   = .T.
1048:         ENDWITH
1049: 
1050:         loc_oPagina.AddObject("chk_4c_Chk_LeitMF", "CheckBox")
1051:         WITH loc_oPagina.chk_4c_Chk_LeitMF
1052:             .Top       = 285
1053:             .Left      = 630
1054:             .Width     = 18
1055:             .Height    = 17
1056:             .Caption   = ""
1057:             .Value     = 0
1058:             .Alignment = 0
1059:             .BackStyle = 0
1060:             .AutoSize  = .T.
1061:             .Visible   = .T.
1062:         ENDWITH
1063: 
1064:         *-- Gaveta Acoplada
1065:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
1066:         WITH loc_oPagina.lbl_4c_Label7
1067:             .Top       = 304
1068:             .Left      = 534
1069:             .Width     = 94
1070:             .Height    = 17
1071:             .Caption   = "Gaveta Acoplada :"
1072:             .FontName  = "Tahoma"
1073:             .FontSize  = 8
1074:             .ForeColor = RGB(255, 255, 255)
1075:             .BackStyle = 0
1076:             .Alignment = 1
1077:             .AutoSize  = .F.
1078:             .Visible   = .T.
1079:         ENDWITH
1080: 
1081:         loc_oPagina.AddObject("chk_4c_Chk_gaveta", "CheckBox")
1082:         WITH loc_oPagina.chk_4c_Chk_gaveta
1083:             .Top       = 304
1084:             .Left      = 630
1085:             .Width     = 18
1086:             .Height    = 17
1087:             .Caption   = ""
1088:             .Value     = 0
1089:             .Alignment = 0
1090:             .BackStyle = 0
1091:             .AutoSize  = .T.
1092:             .Visible   = .T.
1093:         ENDWITH
1094: 
1095:         *-- Impressora de Cheques
1096:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
1097:         WITH loc_oPagina.lbl_4c_Label2
1098:             .Top       = 324
1099:             .Left      = 549
1100:             .Width     = 79
1101:             .Height    = 17
1102:             .Caption   = "Imp. Cheques :"
1103:             .FontName  = "Tahoma"
1104:             .FontSize  = 8
1105:             .ForeColor = RGB(255, 255, 255)
1106:             .BackStyle = 0
1107:             .Alignment = 1
1108:             .AutoSize  = .F.
1109:             .Visible   = .T.
1110:         ENDWITH
1111: 
1112:         loc_oPagina.AddObject("chk_4c_Chk_impche", "CheckBox")
1113:         WITH loc_oPagina.chk_4c_Chk_impche
1114:             .Top       = 324
1115:             .Left      = 630
1116:             .Width     = 18
1117:             .Height    = 15
1118:             .Caption   = ""
1119:             .Value     = 0
1120:             .Alignment = 0
1121:             .BackStyle = 0
1122:             .AutoSize  = .T.
1123:             .Visible   = .T.
1124:         ENDWITH
1125: 
1126:         *-- MFD (Memoria de Fita Detalhe)
1127:         loc_oPagina.AddObject("lbl_4c_Label15", "Label")
1128:         WITH loc_oPagina.lbl_4c_Label15
1129:             .Top       = 343
1130:             .Left      = 595
1131:             .Width     = 33
1132:             .Height    = 17
1133:             .Caption   = "MFD :"
1134:             .FontName  = "Tahoma"
1135:             .FontSize  = 8
1136:             .ForeColor = RGB(255, 255, 255)
1137:             .BackStyle = 0
1138:             .Alignment = 1
1139:             .AutoSize  = .F.
1140:             .Visible   = .T.
1141:         ENDWITH
1142: 
1143:         loc_oPagina.AddObject("chk_4c_Fwcheckbox2", "CheckBox")
1144:         WITH loc_oPagina.chk_4c_Fwcheckbox2
1145:             .Top       = 343
1146:             .Left      = 630
1147:             .Width     = 18
1148:             .Height    = 15
1149:             .Caption   = ""
1150:             .Value     = 0
1151:             .Alignment = 0
1152:             .BackStyle = 0
1153:             .AutoSize  = .T.
1154:             .Visible   = .T.
1155:         ENDWITH
1156: 
1157:         *-- Inativa
1158:         loc_oPagina.AddObject("lbl_4c_Label11", "Label")
1159:         WITH loc_oPagina.lbl_4c_Label11
1160:             .Top       = 361
1161:             .Left      = 582
1162:             .Width     = 46
1163:             .Height    = 15
1164:             .Caption   = "Inativa :"
1165:             .FontName  = "Tahoma"
1166:             .FontSize  = 8
1167:             .ForeColor = RGB(255, 255, 255)
1168:             .BackStyle = 0
1169:             .Alignment = 1
1170:             .AutoSize  = .F.
1171:             .Visible   = .T.
1172:         ENDWITH
1173: 
1174:         loc_oPagina.AddObject("chk_4c_Fwcheckbox1", "CheckBox")
1175:         WITH loc_oPagina.chk_4c_Fwcheckbox1
1176:             .Top       = 361
1177:             .Left      = 630
1178:             .Width     = 18
1179:             .Height    = 15
1180:             .Caption   = ""
1181:             .Value     = 0
1182:             .Alignment = 0
1183:             .BackStyle = 0
1184:             .AutoSize  = .T.
1185:             .Visible   = .T.
1186:         ENDWITH
1187: 
1188:         *-- Bom Para (uso cheque)
1189:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
1190:         WITH loc_oPagina.lbl_4c_Label8
1191:             .Top       = 382
1192:             .Left      = 571
1193:             .Width     = 57
1194:             .Height    = 17
1195:             .Caption   = "Bom Para :"
1196:             .FontName  = "Tahoma"
1197:             .FontSize  = 8
1198:             .ForeColor = RGB(255, 255, 255)
1199:             .BackStyle = 0
1200:             .Alignment = 1
1201:             .AutoSize  = .F.
1202:             .Visible   = .T.
1203:         ENDWITH
1204: 
1205:         loc_oPagina.AddObject("chk_4c_Chk_Bompara", "CheckBox")
1206:         WITH loc_oPagina.chk_4c_Chk_Bompara
1207:             .Top       = 382
1208:             .Left      = 630
1209:             .Width     = 18
1210:             .Height    = 15
1211:             .Caption   = ""
1212:             .Value     = 0
1213:             .Alignment = 0
1214:             .BackStyle = 0
1215:             .AutoSize  = .T.
1216:             .Visible   = .T.
1217:         ENDWITH
1218: 
1219:         *-- Nominal
1220:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
1221:         WITH loc_oPagina.lbl_4c_Label9
1222:             .Top       = 403
1223:             .Left      = 579
1224:             .Width     = 49
1225:             .Height    = 17
1226:             .Caption   = "Nominal :"
1227:             .FontName  = "Tahoma"
1228:             .FontSize  = 8
1229:             .ForeColor = RGB(255, 255, 255)
1230:             .BackStyle = 0
1231:             .Alignment = 1
1232:             .AutoSize  = .F.
1233:             .Visible   = .T.
1234:         ENDWITH
1235: 
1236:         loc_oPagina.AddObject("chk_4c_Chk_nominal", "CheckBox")
1237:         WITH loc_oPagina.chk_4c_Chk_nominal
1238:             .Top       = 403
1239:             .Left      = 630
1240:             .Width     = 18
1241:             .Height    = 15
1242:             .Caption   = ""
1243:             .Value     = 0
1244:             .Alignment = 0
1245:             .BackStyle = 0
1246:             .AutoSize  = .T.
1247:             .Visible   = .T.
1248:         ENDWITH
1249: 
1250:         *-- Cruzado
1251:         loc_oPagina.AddObject("lbl_4c_Label10", "Label")
1252:         WITH loc_oPagina.lbl_4c_Label10
1253:             .Top       = 423
1254:             .Left      = 576
1255:             .Width     = 52
1256:             .Height    = 17
1257:             .Caption   = "Cruzado :"
1258:             .FontName  = "Tahoma"
1259:             .FontSize  = 8
1260:             .ForeColor = RGB(255, 255, 255)
1261:             .BackStyle = 0
1262:             .Alignment = 1
1263:             .AutoSize  = .F.
1264:             .Visible   = .T.
1265:         ENDWITH
1266: 
1267:         loc_oPagina.AddObject("chk_4c_Chk_cruzado", "CheckBox")
1268:         WITH loc_oPagina.chk_4c_Chk_cruzado
1269:             .Top       = 423
1270:             .Left      = 630
1271:             .Width     = 18
1272:             .Height    = 15
1273:             .Caption   = ""
1274:             .Value     = 0
1275:             .Alignment = 0
1276:             .BackStyle = 0
1277:             .AutoSize  = .T.
1278:             .Visible   = .T.
1279:         ENDWITH
1280: 
1281:         *-- Pertochek / Check-Pronto
1282:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
1283:         WITH loc_oPagina.lbl_4c_Label6
1284:             .Top       = 442
1285:             .Left      = 493
1286:             .Width     = 135
1287:             .Height    = 17
1288:             .Caption   = "Pertochek / Check-Pronto :"
1289:             .FontName  = "Tahoma"
1290:             .FontSize  = 8
1291:             .ForeColor = RGB(255, 255, 255)
1292:             .BackStyle = 0
1293:             .Alignment = 1
1294:             .AutoSize  = .F.
1295:             .Visible   = .T.
1296:         ENDWITH
1297: 
1298:         loc_oPagina.AddObject("chk_4c_Chk_perto", "CheckBox")
1299:         WITH loc_oPagina.chk_4c_Chk_perto
1300:             .Top       = 442
1301:             .Left      = 630
1302:             .Width     = 18
1303:             .Height    = 15
1304:             .Caption   = ""
1305:             .Value     = 0
1306:             .Alignment = 0
1307:             .BackStyle = 0
1308:             .AutoSize  = .T.
1309:             .Visible   = .T.
1310:         ENDWITH
1311: 
1312:         *-- Autentica (OptionGroup 1=Sim, 2=Nao)
1313:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
1314:         WITH loc_oPagina.lbl_4c_Label14
1315:             .Top       = 461
1316:             .Left      = 573
1317:             .Width     = 55
1318:             .Height    = 17
1319:             .Caption   = "Autentica :"
1320:             .FontName  = "Tahoma"
1321:             .FontSize  = 8
1322:             .ForeColor = RGB(255, 255, 255)
1323:             .BackStyle = 0
1324:             .Alignment = 1

*-- Linhas 1332 a 1376:
1332:             .BackStyle   = 0
1333:             .BorderStyle = 0
1334:             .Value       = 1
1335:             .Top         = 458
1336:             .Left        = 625
1337:             .Width       = 95
1338:             .Height      = 22
1339:             .Visible     = .T.
1340:             WITH .Buttons(1)
1341:                 .Caption   = "Sim"
1342:                 .Left      = 5
1343:                 .Top       = 3
1344:                 .Width     = 44
1345:                 .Height    = 17
1346:                 .AutoSize  = .T.
1347:                 .ForeColor = RGB(90, 90, 90)
1348:                 .BackStyle = 0
1349:             ENDWITH
1350:             WITH .Buttons(2)
1351:                 .Caption   = "N" + CHR(227) + "o"
1352:                 .Left      = 56
1353:                 .Top       = 3
1354:                 .Width     = 61
1355:                 .Height    = 17
1356:                 .AutoSize  = .T.
1357:                 .FontName  = "Tahoma"
1358:                 .FontSize  = 8
1359:                 .ForeColor = RGB(90, 90, 90)
1360:                 .BackStyle = 0
1361:             ENDWITH
1362:         ENDWITH
1363: 
1364:         *-- Imprime Codigo de Barras (OptionGroup 1=Sim, 2=Nao)
1365:         loc_oPagina.AddObject("lbl_4c_Label26", "Label")
1366:         WITH loc_oPagina.lbl_4c_Label26
1367:             .Top       = 483
1368:             .Left      = 496
1369:             .Width     = 132
1370:             .Height    = 17
1371:             .Caption   = "Imprime C" + CHR(243) + "digo de Barras :"
1372:             .FontName  = "Tahoma"
1373:             .FontSize  = 8
1374:             .ForeColor = RGB(255, 255, 255)
1375:             .BackStyle = 0
1376:             .Alignment = 1

*-- Linhas 1384 a 1441:
1384:             .BackStyle   = 0
1385:             .BorderStyle = 0
1386:             .Value       = 1
1387:             .Top         = 480
1388:             .Left        = 624
1389:             .Width       = 95
1390:             .Height      = 22
1391:             .Visible     = .T.
1392:             WITH .Buttons(1)
1393:                 .Caption   = "Sim"
1394:                 .Left      = 5
1395:                 .Top       = 3
1396:                 .Width     = 44
1397:                 .Height    = 17
1398:                 .AutoSize  = .T.
1399:                 .ForeColor = RGB(90, 90, 90)
1400:                 .BackStyle = 0
1401:             ENDWITH
1402:             WITH .Buttons(2)
1403:                 .Caption   = "N" + CHR(227) + "o"
1404:                 .Left      = 56
1405:                 .Top       = 3
1406:                 .Width     = 61
1407:                 .Height    = 17
1408:                 .AutoSize  = .T.
1409:                 .FontName  = "Tahoma"
1410:                 .FontSize  = 8
1411:                 .ForeColor = RGB(90, 90, 90)
1412:                 .BackStyle = 0
1413:             ENDWITH
1414:         ENDWITH
1415: 
1416:         *-- Codigo Nacional do ECF (ReadOnly - getcodnac.When = .F. no legado)
1417:         loc_oPagina.AddObject("lbl_4c_Label28", "Label")
1418:         WITH loc_oPagina.lbl_4c_Label28
1419:             .Top       = 509
1420:             .Left      = 506
1421:             .Width     = 122
1422:             .Height    = 17
1423:             .Caption   = "C" + CHR(243) + "digo Nacional do ECF :"
1424:             .FontName  = "Tahoma"
1425:             .FontSize  = 8
1426:             .ForeColor = RGB(255, 255, 255)
1427:             .BackStyle = 0
1428:             .Alignment = 1
1429:             .AutoSize  = .F.
1430:             .Visible   = .T.
1431:         ENDWITH
1432: 
1433:         loc_oPagina.AddObject("txt_4c_Codnac", "TextBox")
1434:         WITH loc_oPagina.txt_4c_Codnac
1435:             .Top       = 505
1436:             .Left      = 630
1437:             .Width     = 52
1438:             .Height    = 23
1439:             .Value     = ""
1440:             .MaxLength = 6
1441:             .InputMask = "999999"

*-- Linhas 1449 a 1479:
1449:         ENDWITH
1450: 
1451:         *-- Incidencia Desc. ISSQN
1452:         loc_oPagina.AddObject("lbl_4c_Label29", "Label")
1453:         WITH loc_oPagina.lbl_4c_Label29
1454:             .Top       = 534
1455:             .Left      = 507
1456:             .Width     = 121
1457:             .Height    = 17
1458:             .Caption   = "Incid" + CHR(234) + "ncia Desc. ISSQN :"
1459:             .FontName  = "Tahoma"
1460:             .FontSize  = 8
1461:             .ForeColor = RGB(255, 255, 255)
1462:             .BackStyle = 0
1463:             .Alignment = 1
1464:             .AutoSize  = .F.
1465:             .Visible   = .T.
1466:         ENDWITH
1467: 
1468:         loc_oPagina.AddObject("chk_4c_Fwcheckbox3", "CheckBox")
1469:         WITH loc_oPagina.chk_4c_Fwcheckbox3
1470:             .Top       = 534
1471:             .Left      = 629
1472:             .Width     = 18
1473:             .Height    = 15
1474:             .Caption   = ""
1475:             .Value     = 0
1476:             .Alignment = 0
1477:             .BackStyle = 0
1478:             .AutoSize  = .T.
1479:             .Visible   = .T.

*-- Linhas 1505 a 1516:
1505:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.cncaixas"
1506: 
1507:                     *-- Redefinir headers apos RecordSource (VFP9 reseta cabecalhos)
1508:                     loc_oGrid.Column1.Header1.Caption = "N" + CHR(186) + " Fabrica" + CHR(231) + CHR(227) + "o"
1509:                     loc_oGrid.Column2.Header1.Caption = "Empresa"
1510:                     loc_oGrid.Column3.Header1.Caption = "Fabrica" + CHR(231) + CHR(227) + "o (Criptografado)"
1511:                     loc_oGrid.Column4.Header1.Caption = "Caixa"
1512: 
1513:                     THIS.FormatarGridLista(loc_oGrid)
1514:                     loc_lResultado = .T.
1515:                 ENDIF
1516:             ENDIF

*-- Linhas 1827 a 1843:
1827:             loc_oBO.this_lLeitMF    = (loc_oPg2.chk_4c_Chk_LeitMF.Value  = 1)
1828:             loc_oBO.this_lGaveta    = (loc_oPg2.chk_4c_Chk_gaveta.Value  = 1)
1829:             loc_oBO.this_lImpCheque = (loc_oPg2.chk_4c_Chk_impche.Value  = 1)
1830:             loc_oBO.this_lMFD       = (loc_oPg2.chk_4c_Fwcheckbox2.Value = 1)
1831:             loc_oBO.this_lInativa   = (loc_oPg2.chk_4c_Fwcheckbox1.Value = 1)
1832:             loc_oBO.this_lBomPara   = (loc_oPg2.chk_4c_Chk_Bompara.Value = 1)
1833:             loc_oBO.this_lNominal   = (loc_oPg2.chk_4c_Chk_nominal.Value = 1)
1834:             loc_oBO.this_lCruzado   = (loc_oPg2.chk_4c_Chk_cruzado.Value = 1)
1835:             loc_oBO.this_lPerto     = (loc_oPg2.chk_4c_Chk_perto.Value   = 1)
1836:             loc_oBO.this_nAutentica = loc_oPg2.obj_4c_Optiongroup1.Value
1837:             loc_oBO.this_nImpBars   = loc_oPg2.obj_4c_Optiongroup2.Value
1838:             loc_oBO.this_lISSQN     = (loc_oPg2.chk_4c_Fwcheckbox3.Value = 1)
1839: 
1840:             loc_lResultado = .T.
1841:         CATCH TO loc_oErro
1842:             MostrarErro(loc_oErro, "FormFBI.FormParaBO")
1843:         ENDTRY

*-- Linhas 1877 a 1893:
1877:             loc_oPg2.chk_4c_Chk_LeitMF.Value  = IIF(loc_oBO.this_lLeitMF,    1, 0)
1878:             loc_oPg2.chk_4c_Chk_gaveta.Value  = IIF(loc_oBO.this_lGaveta,    1, 0)
1879:             loc_oPg2.chk_4c_Chk_impche.Value  = IIF(loc_oBO.this_lImpCheque, 1, 0)
1880:             loc_oPg2.chk_4c_Fwcheckbox2.Value = IIF(loc_oBO.this_lMFD,       1, 0)
1881:             loc_oPg2.chk_4c_Fwcheckbox1.Value = IIF(loc_oBO.this_lInativa,   1, 0)
1882:             loc_oPg2.chk_4c_Chk_Bompara.Value = IIF(loc_oBO.this_lBomPara,   1, 0)
1883:             loc_oPg2.chk_4c_Chk_nominal.Value = IIF(loc_oBO.this_lNominal,   1, 0)
1884:             loc_oPg2.chk_4c_Chk_cruzado.Value = IIF(loc_oBO.this_lCruzado,   1, 0)
1885:             loc_oPg2.chk_4c_Chk_perto.Value   = IIF(loc_oBO.this_lPerto,     1, 0)
1886:             loc_oPg2.obj_4c_Optiongroup1.Value = loc_oBO.this_nAutentica
1887:             loc_oPg2.obj_4c_Optiongroup2.Value = loc_oBO.this_nImpBars
1888:             loc_oPg2.chk_4c_Fwcheckbox3.Value = IIF(loc_oBO.this_lISSQN,     1, 0)
1889: 
1890:             loc_lResultado = .T.
1891:         CATCH TO loc_oErro
1892:             MostrarErro(loc_oErro, "FormFBI.BOParaForm")
1893:         ENDTRY

*-- Linhas 1933 a 1949:
1933:             loc_oPg2.chk_4c_Chk_LeitMF.Enabled  = par_lHabilitar
1934:             loc_oPg2.chk_4c_Chk_gaveta.Enabled  = par_lHabilitar
1935:             loc_oPg2.chk_4c_Chk_impche.Enabled  = par_lHabilitar
1936:             loc_oPg2.chk_4c_Fwcheckbox2.Enabled = par_lHabilitar
1937:             loc_oPg2.chk_4c_Fwcheckbox1.Enabled = par_lHabilitar
1938:             loc_oPg2.chk_4c_Chk_Bompara.Enabled = par_lHabilitar
1939:             loc_oPg2.chk_4c_Chk_nominal.Enabled = par_lHabilitar
1940:             loc_oPg2.chk_4c_Chk_cruzado.Enabled = par_lHabilitar
1941:             loc_oPg2.chk_4c_Chk_perto.Enabled   = par_lHabilitar
1942:             loc_oPg2.obj_4c_Optiongroup1.Enabled = par_lHabilitar
1943:             loc_oPg2.obj_4c_Optiongroup2.Enabled = par_lHabilitar
1944:             loc_oPg2.chk_4c_Fwcheckbox3.Enabled = par_lHabilitar
1945: 
1946:             loc_lResultado = .T.
1947:         CATCH TO loc_oErro
1948:             MostrarErro(loc_oErro, "FormFBI.HabilitarCampos")
1949:         ENDTRY

*-- Linhas 1982 a 1998:
1982:             loc_oPg2.chk_4c_Chk_LeitMF.Value  = 0
1983:             loc_oPg2.chk_4c_Chk_gaveta.Value  = 0
1984:             loc_oPg2.chk_4c_Chk_impche.Value  = 0
1985:             loc_oPg2.chk_4c_Fwcheckbox2.Value = 0
1986:             loc_oPg2.chk_4c_Fwcheckbox1.Value = 0
1987:             loc_oPg2.chk_4c_Chk_Bompara.Value = 0
1988:             loc_oPg2.chk_4c_Chk_nominal.Value = 0
1989:             loc_oPg2.chk_4c_Chk_cruzado.Value = 0
1990:             loc_oPg2.chk_4c_Chk_perto.Value   = 0
1991:             loc_oPg2.obj_4c_Optiongroup1.Value = 1
1992:             loc_oPg2.obj_4c_Optiongroup2.Value = 1
1993:             loc_oPg2.chk_4c_Fwcheckbox3.Value = 0
1994: 
1995:             loc_lResultado = .T.
1996:         CATCH TO loc_oErro
1997:             MostrarErro(loc_oErro, "FormFBI.LimparCampos")
1998:         ENDTRY

*-- Linhas 2006 a 2014:
2006:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2007:         LOCAL loc_lConfirmarAtivo
2008:         loc_lConfirmarAtivo = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2009:         THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lConfirmarAtivo
2010:     ENDPROC
2011: 
2012:     *====================================================================
2013:     * BtnIncluirClick - Prepara formulario para inclusao de novo registro
2014:     *====================================================================


### BO (C:\4c\projeto\app\classes\FBIBO.prg):
*====================================================================
* FBIBO.prg
*
* Business Object para Cadastro de Fabricacao (SigFiMpf)
* Herda de: BusinessBase
*
* Tabela: SigFiMpf
* Chave primaria: cidchaves (gerada por Sys(2015)+Sys(2015))
* Chave de negocio: cImpFabs (No. Fabricacao / NFAB)
*
* Campos GT (cgtinics, cgtatuas) armazenados como strings no legado.
*====================================================================

DEFINE CLASS FBIBO AS BusinessBase

    *-- Chave primaria interna
    this_cChaves        = ""   && cidchaves char(30)  - PK gerada automaticamente

    *-- Identificacao do ECF
    this_cCodigo        = ""   && cImpFabs char(20)   - No. Fabricacao / NFAB (chave negocio)
    this_cEmpresa       = ""   && emps char(3)         - Codigo da empresa
    this_cNcaixas       = ""   && cncaixas char(3)     - No. do Caixa / NSEQ

    *-- Contadores e registradores
    this_cInterv        = ""   && cnintervs char(4)    - Contador Reinicio de Operacao
    this_cGTInics       = ""   && cgtinics char(30)    - GT Inicial (string)
    this_cGTAtuas       = ""   && cgtatuas char(30)    - GT Atual (string)

    *-- Modelo e identificacao do ECF
    this_cModelo        = ""   && cModelos char(30)    - Modelo da impressora ECF
    this_cNumUsuars     = ""   && cnumusuars char(2)   - Numero do Usuario do ECF
    this_cTipoECF       = ""   && ctipoecfs char(7)    - Tipo do ECF
    this_cCodNac        = ""   && cidecfs char(6)      - Codigo Nacional do ECF
    this_cIfCoos        = ""   && cIfCoos char(6)      - COO Inicial (Troca Aplicativo)
    this_cCROIniOps     = ""   && ccroiniops char(6)   - CRO Inicial de Operacoes

    *-- Software Basico
    this_cVersaoSB      = ""   && cversaosbs char(10)  - Versao do Software Basico
    this_dDataSB        = {}   && tdatasbs date        - Data do Software Basico
    this_cHoraSB        = ""   && chorasbs char(8)     - Hora do Software Basico (HH:MM:SS)

    *-- Dados de cadastro do ECF
    this_dDtCadECF      = {}   && tdtcadecfs date      - Data do Cadastro do ECF
    this_cHrCadECF      = ""   && chrcadecfs char(8)   - Hora do Cadastro do ECF (HH:MM:SS)

    *-- Comando RFD
    this_cCmdRFD        = ""   && ccmdgers char(3)     - Comando de Geracao RFD

    *-- Flags booleanos (BIT no SQL Server)
    this_lGaveta        = .F.  && gavetas              - Gaveta Acoplada
    this_lImpCheque     = .F.  && impches              - Impressora de Cheques
    this_lPerto         = .F.  && Pertos               - Pertochek / Check-Pronto
    this_lBomPara       = .F.  && bompara              - Bom Para (uso cheque)
    this_lNominal       = .F.  && nominal              - Nominal
    this_lCruzado       = .F.  && cruzado              - Cruzado
    this_lInativa       = .F.  && ImpAtivas            - Impressora Inativa
    this_lLeitMF        = .F.  && MemFautos            - Leitura Mem. Fiscal Automatico
    this_lMFD           = .F.  && impmfds              - MFD (Memoria de Fita Detalhe)
    this_lISSQN         = .F.  && cissqns              - Incidencia Desconto ISSQN

    *-- Opcoes OptionGroup (N: 1=Sim, 2=Nao)
    this_nAutentica     = 1    && Autenticas           - Autentica cheque (1=Sim, 2=Nao)
    this_nImpBars       = 1    && nImpBars             - Imprime Cod. de Barras (1=Sim, 2=Nao)

    *====================================================================
    * Init - Inicializa Business Object
    *====================================================================
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigFiMpf"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *====================================================================
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *====================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cChaves
    ENDPROC

    *====================================================================
    * LimparDados - Limpa propriedades (chamado por NovoRegistro)
    *====================================================================
    PROTECTED PROCEDURE LimparDados()
        THIS.this_cChaves    = ""
        THIS.this_cCodigo    = ""
        THIS.this_cEmpresa   = ""
        THIS.this_cNcaixas   = ""
        THIS.this_cInterv    = ""
        THIS.this_cGTInics   = ""
        THIS.this_cGTAtuas   = ""
        THIS.this_cModelo    = ""
        THIS.this_cNumUsuars = ""
        THIS.this_cTipoECF   = ""
        THIS.this_cCodNac    = ""
        THIS.this_cIfCoos    = ""
        THIS.this_cCROIniOps = ""
        THIS.this_cVersaoSB  = ""
        THIS.this_dDataSB    = {}
        THIS.this_cHoraSB    = ""
        THIS.this_dDtCadECF  = {}
        THIS.this_cHrCadECF  = ""
        THIS.this_cCmdRFD    = ""
        THIS.this_lGaveta    = .F.
        THIS.this_lImpCheque = .F.
        THIS.this_lPerto     = .F.
        THIS.this_lBomPara   = .F.
        THIS.this_lNominal   = .F.
        THIS.this_lCruzado   = .F.
        THIS.this_lInativa   = .F.
        THIS.this_lLeitMF    = .F.
        THIS.this_lMFD       = .F.
        THIS.this_lISSQN     = .F.
        THIS.this_nAutentica = 1
        THIS.this_nImpBars   = 1
    ENDPROC

    *====================================================================
    * Buscar - Retorna lista de registros (cursor_4c_Dados)
    *====================================================================
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_cWhere, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cImpFabs, emps, cncaixas, cnintervs," + ;
                       " cgtinics, cgtatuas, cModelos, cnumusuars, ctipoecfs," + ;
                       " cidecfs, cIfCoos, ccroiniops, cversaosbs," + ;
                       " tdatasbs, chorasbs, tdtcadecfs, chrcadecfs, ccmdgers," + ;
                       " gavetas, impches, Pertos, bompara, nominal, cruzado," + ;
                       " ImpAtivas, MemFautos, Autenticas, impmfds, nImpBars, cissqns" + ;
                       " FROM SigFiMpf"

            IF !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE cImpFabs LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
                loc_cSQL = loc_cSQL + loc_cWhere
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY cImpFabs"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarPorCodigo - Carrega registro pela chave primaria (cidchaves)
    *====================================================================
    FUNCTION CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, cImpFabs, emps, cncaixas, cnintervs," + ;
                       " cgtinics, cgtatuas, cModelos, cnumusuars, ctipoecfs," + ;
                       " cidecfs, cIfCoos, ccroiniops, cversaosbs," + ;
                       " tdatasbs, chorasbs, tdtcadecfs, chrcadecfs, ccmdgers," + ;
                       " gavetas, impches, Pertos, bompara, nominal, cruzado," + ;
                       " ImpAtivas, MemFautos, Autenticas, impmfds, nImpBars, cissqns" + ;
                       " FROM SigFiMpf WHERE cidchaves = " + EscaparSQL(par_cCodigo)

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Carrega")
                TABLEREVERT(.T., "cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                MostrarErro("Registro n" + CHR(227) + "o encontrado.", "")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.CarregarPorCodigo")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *====================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades
    *====================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cChaves    = TratarNulo(cidchaves, "C")
                THIS.this_cCodigo    = TratarNulo(cImpFabs, "C")
                THIS.this_cEmpresa   = TratarNulo(emps, "C")
                THIS.this_cNcaixas   = TratarNulo(cncaixas, "C")
                THIS.this_cInterv    = TratarNulo(cnintervs, "C")
                THIS.this_cGTInics   = TratarNulo(cgtinics, "C")
                THIS.this_cGTAtuas   = TratarNulo(cgtatuas, "C")
                THIS.this_cModelo    = TratarNulo(cModelos, "C")
                THIS.this_cNumUsuars = TratarNulo(cnumusuars, "C")
                THIS.this_cTipoECF   = TratarNulo(ctipoecfs, "C")
                THIS.this_cCodNac    = TratarNulo(cidecfs, "C")
                THIS.this_cIfCoos    = TratarNulo(cIfCoos, "C")
                THIS.this_cCROIniOps = TratarNulo(ccroiniops, "C")
                THIS.this_cVersaoSB  = TratarNulo(cversaosbs, "C")
                THIS.this_dDataSB    = TratarNulo(tdatasbs, "D")
                THIS.this_cHoraSB    = TratarNulo(chorasbs, "C")
                THIS.this_dDtCadECF  = TratarNulo(tdtcadecfs, "D")
                THIS.this_cHrCadECF  = TratarNulo(chrcadecfs, "C")
                THIS.this_cCmdRFD    = TratarNulo(ccmdgers, "C")
                IF VARTYPE(gavetas) = "L"
                    THIS.this_lGaveta = gavetas
                ELSE
                    IF VARTYPE(gavetas) = "L"
                        THIS.this_lGaveta = gavetas
                    ELSE
                        IF VARTYPE(gavetas) = "L"
                            THIS.this_lGaveta = gavetas
                        ELSE
                            THIS.this_lGaveta = (NVL(gavetas, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(impches) = "L"
                    THIS.this_lImpCheque = impches
                ELSE
                    IF VARTYPE(impches) = "L"
                        THIS.this_lImpCheque = impches
                    ELSE
                        IF VARTYPE(impches) = "L"
                            THIS.this_lImpCheque = impches
                        ELSE
                            THIS.this_lImpCheque = (NVL(impches, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(Pertos) = "L"
                    THIS.this_lPerto = Pertos
                ELSE
                    IF VARTYPE(Pertos) = "L"
                        THIS.this_lPerto = Pertos
                    ELSE
                        IF VARTYPE(Pertos) = "L"
                            THIS.this_lPerto = Pertos
                        ELSE
                            THIS.this_lPerto = (NVL(Pertos, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(bompara) = "L"
                    THIS.this_lBomPara = bompara
                ELSE
                    IF VARTYPE(bompara) = "L"
                        THIS.this_lBomPara = bompara
                    ELSE
                        IF VARTYPE(bompara) = "L"
                            THIS.this_lBomPara = bompara
                        ELSE
                            THIS.this_lBomPara = (NVL(bompara, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(nominal) = "L"
                    THIS.this_lNominal = nominal
                ELSE
                    IF VARTYPE(nominal) = "L"
                        THIS.this_lNominal = nominal
                    ELSE
                        IF VARTYPE(nominal) = "L"
                            THIS.this_lNominal = nominal
                        ELSE
                            THIS.this_lNominal = (NVL(nominal, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(cruzado) = "L"
                    THIS.this_lCruzado = cruzado
                ELSE
                    IF VARTYPE(cruzado) = "L"
                        THIS.this_lCruzado = cruzado
                    ELSE
                        IF VARTYPE(cruzado) = "L"
                            THIS.this_lCruzado = cruzado
                        ELSE
                            THIS.this_lCruzado = (NVL(cruzado, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(ImpAtivas) = "L"
                    THIS.this_lInativa = ImpAtivas
                ELSE
                    IF VARTYPE(ImpAtivas) = "L"
                        THIS.this_lInativa = ImpAtivas
                    ELSE
                        IF VARTYPE(ImpAtivas) = "L"
                            THIS.this_lInativa = ImpAtivas
                        ELSE
                            THIS.this_lInativa = (NVL(ImpAtivas, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(MemFautos) = "L"
                    THIS.this_lLeitMF = MemFautos
                ELSE
                    IF VARTYPE(MemFautos) = "L"
                        THIS.this_lLeitMF = MemFautos
                    ELSE
                        IF VARTYPE(MemFautos) = "L"
                            THIS.this_lLeitMF = MemFautos
                        ELSE
                            THIS.this_lLeitMF = (NVL(MemFautos, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(impmfds) = "L"
                    THIS.this_lMFD = impmfds
                ELSE
                    IF VARTYPE(impmfds) = "L"
                        THIS.this_lMFD = impmfds
                    ELSE
                        IF VARTYPE(impmfds) = "L"
                            THIS.this_lMFD = impmfds
                        ELSE
                            THIS.this_lMFD = (NVL(impmfds, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
                IF VARTYPE(cissqns) = "L"
                    THIS.this_lISSQN = cissqns
                ELSE
                    IF VARTYPE(cissqns) = "L"
                        THIS.this_lISSQN = cissqns
                    ELSE
                        IF VARTYPE(cissqns) = "L"
                            THIS.this_lISSQN = cissqns
                        ELSE
                            THIS.this_lISSQN = (NVL(cissqns, 0) = 1)
                        ENDIF
                    ENDIF
                ENDIF
                THIS.this_nAutentica = NVL(Autenticas, 1)
                THIS.this_nImpBars   = NVL(nImpBars, 1)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Inserir - INSERT em SigFiMpf
    *====================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDataSB, loc_cDtCadECF
        loc_lSucesso = .F.

        TRY
            IF EMPTY(THIS.this_cChaves)
                THIS.this_cChaves = SYS(2015) + SYS(2015)
            ENDIF

            loc_cDataSB   = IIF(EMPTY(THIS.this_dDataSB),   "NULL", FormatarDataSQL(THIS.this_dDataSB))
            loc_cDtCadECF = IIF(EMPTY(THIS.this_dDtCadECF), "NULL", FormatarDataSQL(THIS.this_dDtCadECF))

            loc_cSQL = "INSERT INTO SigFiMpf (" + ;
                       " cidchaves, cImpFabs, emps, cncaixas, cnintervs," + ;
                       " cgtinics, cgtatuas, cModelos, cnumusuars, ctipoecfs," + ;
                       " cidecfs, cIfCoos, ccroiniops, cversaosbs," + ;
                       " tdatasbs, chorasbs, tdtcadecfs, chrcadecfs, ccmdgers," + ;
                       " gavetas, impches, Pertos, bompara, nominal, cruzado," + ;
                       " ImpAtivas, MemFautos, Autenticas, impmfds, nImpBars, cissqns" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cChaves) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigo), 20)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpresa), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cNcaixas), 3)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cInterv), 4)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTInics), 30)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTAtuas), 30)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cModelo), 30)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cNumUsuars), 2)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipoECF), 7)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodNac), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cIfCoos), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCROIniOps), 6)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cVersaoSB), 10)) + ", " + ;
                       loc_cDataSB + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cHoraSB), 8)) + ", " + ;
                       loc_cDtCadECF + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cHrCadECF), 8)) + ", " + ;
                       EscaparSQL(LEFT(ALLTRIM(THIS.this_cCmdRFD), 3)) + ", " + ;
                       IIF(THIS.this_lGaveta,    "1", "0") + ", " + ;
                       IIF(THIS.this_lImpCheque, "1", "0") + ", " + ;
                       IIF(THIS.this_lPerto,     "1", "0") + ", " + ;
                       IIF(THIS.this_lBomPara,   "1", "0") + ", " + ;
                       IIF(THIS.this_lNominal,   "1", "0") + ", " + ;
                       IIF(THIS.this_lCruzado,   "1", "0") + ", " + ;
                       IIF(THIS.this_lInativa,   "1", "0") + ", " + ;
                       IIF(THIS.this_lLeitMF,    "1", "0") + ", " + ;
                       FormatarNumeroSQL(THIS.this_nAutentica) + ", " + ;
                       IIF(THIS.this_lMFD,       "1", "0") + ", " + ;
                       FormatarNumeroSQL(THIS.this_nImpBars) + ", " + ;
                       IIF(THIS.this_lISSQN,     "1", "0") + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * Atualizar - UPDATE em SigFiMpf
    *====================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        LOCAL loc_cDataSB, loc_cDtCadECF
        loc_lSucesso = .F.

        TRY
            loc_cDataSB   = IIF(EMPTY(THIS.this_dDataSB),   "NULL", FormatarDataSQL(THIS.this_dDataSB))
            loc_cDtCadECF = IIF(EMPTY(THIS.this_dDtCadECF), "NULL", FormatarDataSQL(THIS.this_dDtCadECF))

            loc_cSQL = "UPDATE SigFiMpf SET" + ;
                       " cImpFabs   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodigo), 20)) + "," + ;
                       " emps       = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cEmpresa), 3)) + "," + ;
                       " cncaixas   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNcaixas), 3)) + "," + ;
                       " cnintervs  = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cInterv), 4)) + "," + ;
                       " cgtinics   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTInics), 30)) + "," + ;
                       " cgtatuas   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGTAtuas), 30)) + "," + ;
                       " cModelos   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cModelo), 30)) + "," + ;
                       " cnumusuars = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cNumUsuars), 2)) + "," + ;
                       " ctipoecfs  = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cTipoECF), 7)) + "," + ;
                       " cidecfs    = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCodNac), 6)) + "," + ;
                       " cIfCoos    = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cIfCoos), 6)) + "," + ;
                       " ccroiniops = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCROIniOps), 6)) + "," + ;
                       " cversaosbs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cVersaoSB), 10)) + "," + ;
                       " tdatasbs   = " + loc_cDataSB + "," + ;
                       " chorasbs   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cHoraSB), 8)) + "," + ;
                       " tdtcadecfs = " + loc_cDtCadECF + "," + ;
                       " chrcadecfs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cHrCadECF), 8)) + "," + ;
                       " ccmdgers   = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCmdRFD), 3)) + "," + ;
                       " gavetas    = " + IIF(THIS.this_lGaveta,    "1", "0") + "," + ;
                       " impches    = " + IIF(THIS.this_lImpCheque, "1", "0") + "," + ;
                       " Pertos     = " + IIF(THIS.this_lPerto,     "1", "0") + "," + ;
                       " bompara    = " + IIF(THIS.this_lBomPara,   "1", "0") + "," + ;
                       " nominal    = " + IIF(THIS.this_lNominal,   "1", "0") + "," + ;
                       " cruzado    = " + IIF(THIS.this_lCruzado,   "1", "0") + "," + ;
                       " ImpAtivas  = " + IIF(THIS.this_lInativa,   "1", "0") + "," + ;
                       " MemFautos  = " + IIF(THIS.this_lLeitMF,    "1", "0") + "," + ;
                       " Autenticas = " + FormatarNumeroSQL(THIS.this_nAutentica) + "," + ;
                       " impmfds    = " + IIF(THIS.this_lMFD,       "1", "0") + "," + ;
                       " nImpBars   = " + FormatarNumeroSQL(THIS.this_nImpBars) + "," + ;
                       " cissqns    = " + IIF(THIS.this_lISSQN,     "1", "0") + ;
                       " WHERE cidchaves = " + EscaparSQL(THIS.this_cChaves)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MostrarErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *====================================================================
    * ExecutarExclusao - DELETE em SigFiMpf com verificacao de dependencias
    *====================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_lMovimento
        loc_lSucesso  = .F.
        loc_lMovimento = .F.

        TRY
            *-- Verificar movimentos em SigMvCab
            loc_cSQL = "SELECT EmpDopNums FROM SigMvCab WHERE nEmps = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_ChkMvCab")
                TABLEREVERT(.T., "cursor_4c_ChkMvCab")
                USE IN cursor_4c_ChkMvCab
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkMvCab")
            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkMvCab") > 0
                loc_lMovimento = .T.
            ENDIF
            IF USED("cursor_4c_ChkMvCab")
                USE IN cursor_4c_ChkMvCab
            ENDIF

            *-- Verificar movimentos em SigExMvc
            IF !loc_lMovimento
                loc_cSQL = "SELECT EmpDopNums FROM SigExMvc WHERE nEmps = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkExMvc")
                    TABLEREVERT(.T., "cursor_4c_ChkExMvc")
                    USE IN cursor_4c_ChkExMvc
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkExMvc")
                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkExMvc") > 0
                    loc_lMovimento = .T.
                ENDIF
                IF USED("cursor_4c_ChkExMvc")
                    USE IN cursor_4c_ChkExMvc
                ENDIF
            ENDIF

            *-- Verificar lancamentos em SigFiRX
            IF !loc_lMovimento
                loc_cSQL = "SELECT datas FROM SigFiRX WHERE serifab = " + EscaparSQL(ALLTRIM(THIS.this_cCodigo))
                *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
                IF USED("cursor_4c_ChkFiRX")
                    TABLEREVERT(.T., "cursor_4c_ChkFiRX")
                    USE IN cursor_4c_ChkFiRX
                ENDIF

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkFiRX")
                IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_ChkFiRX") > 0
                    loc_lMovimento = .T.
                ENDIF
                IF USED("cursor_4c_ChkFiRX")
                    USE IN cursor_4c_ChkFiRX
                ENDIF
            ENDIF

            IF loc_lMovimento
                MsgAviso("Impressora Fiscal N" + CHR(227) + "o Pode Ser Exclui" + CHR(237) + "da, Possui Movimenta" + CHR(231) + CHR(227) + "o !!!")
            ELSE
                loc_cSQL = "DELETE FROM SigFiMpf WHERE cidchaves = " + EscaparSQL(THIS.this_cChaves)
                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResultado >= 0
                    THIS.RegistrarAuditoria("DELETE")
                    loc_lSucesso = .T.
                ELSE
                    MostrarErro("Erro ao excluir registro: " + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loException
            MostrarErro(loException, "FBIBO.ExecutarExclusao")
            IF USED("cursor_4c_ChkMvCab")
                USE IN cursor_4c_ChkMvCab
            ENDIF
            IF USED("cursor_4c_ChkExMvc")
                USE IN cursor_4c_ChkExMvc
            ENDIF
            IF USED("cursor_4c_ChkFiRX")
                USE IN cursor_4c_ChkFiRX
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

