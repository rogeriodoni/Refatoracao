# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (14)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 213: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 236: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 259: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 282: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 305: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 340: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 418: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 441: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 516: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 539: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 562: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1564: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 1587: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormRPT.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2827 linhas total):

*-- Linhas 59 a 67:
59:             SET DATE TO BRITISH
60:             SET CENTURY ON
61: 
62:             THIS.Caption = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"
63: 
64:             IF TYPE("gnConnHandle") != "N" OR gnConnHandle <= 0
65:                 IF !(TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI)
66:                     MsgErro("Conex" + CHR(227) + "o com banco de dados n" + CHR(227) + ;
67:                             "o estabelecida.", "Erro")

*-- Linhas 104 a 127:
104:         TRY
105:             THIS.AddObject("pgf_4c_Paginas", "PageFrame")
106:             WITH THIS.pgf_4c_Paginas
107:                 .Top       = -29
108:                 .Left      = 0
109:                 .Width     = THIS.Width
110:                 .Height    = THIS.Height + 29
111:                 .PageCount = 2
112:                 .Tabs      = .F.
113:             ENDWITH
114: 
115:             WITH THIS.pgf_4c_Paginas.Page1
116:                 .Caption = "Lista"
117:                 .Width   = THIS.Width
118:                 .Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
119:             ENDWITH
120: 
121:             WITH THIS.pgf_4c_Paginas.Page2
122:                 .Caption = "Dados"
123:                 .Width   = THIS.Width
124:             ENDWITH
125: 
126:             THIS.ConfigurarPaginaLista()
127:             THIS.ConfigurarPaginaDados()

*-- Linhas 149 a 360:
149:         TRY
150:             loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
151:             WITH loc_oPagina.cnt_4c_Cabecalho
152:                 .Top        = 31
153:                 .Left       = 0
154:                 .Width      = 1003
155:                 .Height     = 80
156:                 .BackColor  = RGB(100, 100, 100)
157:                 .BorderWidth = 0
158:                 .Visible    = .T.
159:             ENDWITH
160: 
161:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
162:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
163:                 .Top       = 15
164:                 .Left      = 10
165:                 .Width     = 980
166:                 .Height    = 40
167:                 .Caption   = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"
168:                 .FontName  = "Tahoma"
169:                 .FontSize  = 16
170:                 .FontBold  = .T.
171:                 .ForeColor = RGB(0, 0, 0)
172:                 .BackStyle = 0
173:                 .Visible   = .T.
174:             ENDWITH
175: 
176:             loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
177:             WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
178:                 .Top       = 18
179:                 .Left      = 10
180:                 .Width     = 980
181:                 .Height    = 46
182:                 .Caption   = "Cadastro Customizado de Relat" + CHR(243) + "rios 4Report"
183:                 .FontName  = "Tahoma"
184:                 .FontSize  = 16
185:                 .FontBold  = .T.
186:                 .ForeColor = RGB(255, 255, 255)
187:                 .BackStyle = 0
188:                 .Visible   = .T.
189:             ENDWITH
190: 
191:             loc_oPagina.AddObject("cnt_4c_Botoes", "Container")
192:             WITH loc_oPagina.cnt_4c_Botoes
193:                 .Top        = 29
194:                 .Left       = 542
195:                 .Width      = 375
196:                 .Height     = 85
197:                 .BackStyle = 0
198:                 .BorderWidth = 0
199:                 .Visible    = .T.
200:             ENDWITH
201: 
202:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
203:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir
204:                 .Caption         = "Incluir"
205:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
206:                 .PicturePosition = 13
207:                 .Top             = 5
208:                 .Left            = 5
209:                 .Width           = 75
210:                 .Height          = 75
211:                 .BackColor       = RGB(255, 255, 255)
212:                 .ForeColor       = RGB(90, 90, 90)
213:                 .FontName        = "Comic Sans MS"
214:                 .FontSize        = 8
215:                 .FontBold        = .T.
216:                 .FontItalic      = .T.
217:                 .Themes          = .F.
218:                 .SpecialEffect   = 0
219:                 .MousePointer    = 15
220:                 .WordWrap        = .T.
221:                 .Visible         = .T.
222:             ENDWITH
223:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
224: 
225:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Visualizar", "CommandButton")
226:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar
227:                 .Caption         = "Visualizar"
228:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
229:                 .PicturePosition = 13
230:                 .Top             = 5
231:                 .Left            = 80
232:                 .Width           = 75
233:                 .Height          = 75
234:                 .BackColor       = RGB(255, 255, 255)
235:                 .ForeColor       = RGB(90, 90, 90)
236:                 .FontName        = "Comic Sans MS"
237:                 .FontSize        = 8
238:                 .FontBold        = .T.
239:                 .FontItalic      = .T.
240:                 .Themes          = .F.
241:                 .SpecialEffect   = 0
242:                 .MousePointer    = 15
243:                 .WordWrap        = .T.
244:                 .Visible         = .T.
245:             ENDWITH
246:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
247: 
248:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
249:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar
250:                 .Caption         = "Alterar"
251:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
252:                 .PicturePosition = 13
253:                 .Top             = 5
254:                 .Left            = 155
255:                 .Width           = 75
256:                 .Height          = 75
257:                 .BackColor       = RGB(255, 255, 255)
258:                 .ForeColor       = RGB(90, 90, 90)
259:                 .FontName        = "Comic Sans MS"
260:                 .FontSize        = 8
261:                 .FontBold        = .T.
262:                 .FontItalic      = .T.
263:                 .Themes          = .F.
264:                 .SpecialEffect   = 0
265:                 .MousePointer    = 15
266:                 .WordWrap        = .T.
267:                 .Visible         = .T.
268:             ENDWITH
269:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
270: 
271:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
272:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir
273:                 .Caption         = "Excluir"
274:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
275:                 .PicturePosition = 13
276:                 .Top             = 5
277:                 .Left            = 230
278:                 .Width           = 75
279:                 .Height          = 75
280:                 .BackColor       = RGB(255, 255, 255)
281:                 .ForeColor       = RGB(90, 90, 90)
282:                 .FontName        = "Comic Sans MS"
283:                 .FontSize        = 8
284:                 .FontBold        = .T.
285:                 .FontItalic      = .T.
286:                 .Themes          = .F.
287:                 .SpecialEffect   = 0
288:                 .MousePointer    = 15
289:                 .WordWrap        = .T.
290:                 .Visible         = .T.
291:             ENDWITH
292:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
293: 
294:             loc_oPagina.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
295:             WITH loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar
296:                 .Caption         = "Buscar"
297:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
298:                 .PicturePosition = 13
299:                 .Top             = 5
300:                 .Left            = 305
301:                 .Width           = 75
302:                 .Height          = 75
303:                 .BackColor       = RGB(255, 255, 255)
304:                 .ForeColor       = RGB(90, 90, 90)
305:                 .FontName        = "Comic Sans MS"
306:                 .FontSize        = 8
307:                 .FontBold        = .T.
308:                 .FontItalic      = .T.
309:                 .Themes          = .F.
310:                 .SpecialEffect   = 0
311:                 .MousePointer    = 15
312:                 .WordWrap        = .T.
313:                 .Visible         = .T.
314:             ENDWITH
315:             BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
316: 
317:             *-- Container saida - padrao canonico (CLAUDE.md regra #10)
318:             loc_oPagina.AddObject("cnt_4c_Saida", "Container")
319:             WITH loc_oPagina.cnt_4c_Saida
320:                 .Top        = 29
321:                 .Left       = 917
322:                 .Width      = 90
323:                 .Height     = 85
324:                 .BackStyle  = 0
325:                 .BorderWidth = 0
326:                 .Visible    = .T.
327:             ENDWITH
328: 
329:             loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
330:             WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
331:                 .Caption         = "Encerrar"
332:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
333:                 .PicturePosition = 13
334:                 .Top             = 5
335:                 .Left            = 5
336:                 .Width           = 75
337:                 .Height          = 75
338:                 .BackColor       = RGB(255, 255, 255)
339:                 .ForeColor       = RGB(90, 90, 90)
340:                 .FontName        = "Comic Sans MS"
341:                 .FontSize        = 8
342:                 .FontBold        = .T.
343:                 .FontItalic      = .T.
344:                 .Themes          = .F.
345:                 .SpecialEffect   = 0
346:                 .MousePointer    = 15
347:                 .WordWrap        = .T.
348:                 .Visible         = .T.
349:             ENDWITH
350:             BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
351: 
352:             loc_oPagina.AddObject("grd_4c_Lista", "Grid")
353:             WITH loc_oPagina.grd_4c_Lista
354:                 .Top                = 117
355:                 .Left               = 2
356:                 .Width              = 998
357:                 .Height             = 498
358:                 .FontName           = "Verdana"
359:                 .FontSize           = 8
360:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 394 a 477:
394:             *-- Botoes Confirmar + Cancelar (Grupo_Salva no legado)
395:             loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
396:             WITH loc_oPagina.cnt_4c_BotoesAcao
397:                 .Top        = 33
398:                 .Left       = 842
399:                 .Width      = 160
400:                 .Height     = 85
401:                 .BackStyle = 1
402:                 .BackColor = RGB(255, 255, 255)
403:                 .BorderWidth = 0
404:                 .Visible    = .T.
405:             ENDWITH
406: 
407:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
408:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
409:                 .Caption         = "Confirmar"
410:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
411:                 .PicturePosition = 13
412:                 .Top             = 5
413:                 .Left            = 5
414:                 .Width           = 75
415:                 .Height          = 75
416:                 .BackColor       = RGB(255, 255, 255)
417:                 .ForeColor       = RGB(90, 90, 90)
418:                 .FontName        = "Comic Sans MS"
419:                 .FontSize        = 8
420:                 .FontBold        = .T.
421:                 .FontItalic      = .T.
422:                 .Themes          = .F.
423:                 .SpecialEffect   = 0
424:                 .MousePointer    = 15
425:                 .WordWrap        = .T.
426:                 .Visible         = .T.
427:             ENDWITH
428:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
429: 
430:             loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
431:             WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar
432:                 .Caption         = "Encerrar"
433:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
434:                 .PicturePosition = 13
435:                 .Top             = 5
436:                 .Left            = 80
437:                 .Width           = 75
438:                 .Height          = 75
439:                 .BackColor       = RGB(255, 255, 255)
440:                 .ForeColor       = RGB(90, 90, 90)
441:                 .FontName        = "Comic Sans MS"
442:                 .FontSize        = 8
443:                 .FontBold        = .T.
444:                 .FontItalic      = .T.
445:                 .Themes          = .F.
446:                 .SpecialEffect   = 0
447:                 .MousePointer    = 15
448:                 .WordWrap        = .T.
449:                 .Visible         = .T.
450:             ENDWITH
451:             BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
452: 
453:             *-- PageFrame interno (Pageframe1 no legado)
454:             *-- Top=-29 oculta abas; conteudo de Page1 usa coords SCX direto (sem offset adicional)
455:             loc_oPagina.AddObject("pgf_4c_Dados", "PageFrame")
456:             WITH loc_oPagina.pgf_4c_Dados
457:                 .Top       = -29
458:                 .Left      = 0
459:                 .Width     = THIS.Width
460:                 .Height    = 631
461:                 .PageCount = 2
462:                 .Tabs      = .F.
463:                 .Visible   = .T.
464:             ENDWITH
465: 
466:             WITH loc_oPagina.pgf_4c_Dados.Page1
467:                 .Caption = "Editor SQL"
468:                 .Width   = THIS.Width
469:             ENDWITH
470: 
471:             WITH loc_oPagina.pgf_4c_Dados.Page2
472:                 .Caption = "Designer"
473:                 .Width   = THIS.Width
474:             ENDWITH
475: 
476:             THIS.ConfigurarEditorSQL(loc_oPagina.pgf_4c_Dados.Page1)
477:             THIS.ConfigurarDesignerLayout(loc_oPagina.pgf_4c_Dados.Page2)

*-- Linhas 492 a 890:
492:             *-- Container botoes de acao SQL (CmdGrp_Acoes no legado - 3 botoes)
493:             par_oPage.AddObject("cnt_4c_AcoesSQL", "Container")
494:             WITH par_oPage.cnt_4c_AcoesSQL
495:                 .Top        = 9
496:                 .Left       = 15
497:                 .Width      = 235
498:                 .Height     = 85
499:                 .BackColor  = RGB(53, 53, 53)
500:                 .BackStyle  = 1
501:                 .BorderWidth = 0
502:                 .Visible    = .T.
503:             ENDWITH
504: 
505:             par_oPage.cnt_4c_AcoesSQL.AddObject("cmd_4c_Processar", "CommandButton")
506:             WITH par_oPage.cnt_4c_AcoesSQL.cmd_4c_Processar
507:                 .Caption         = "Processar"
508:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
509:                 .PicturePosition = 13
510:                 .Top             = 5
511:                 .Left            = 5
512:                 .Width           = 75
513:                 .Height          = 75
514:                 .BackColor       = RGB(255, 255, 255)
515:                 .ForeColor       = RGB(90, 90, 90)
516:                 .FontName        = "Comic Sans MS"
517:                 .FontSize        = 8
518:                 .FontBold        = .T.
519:                 .FontItalic      = .T.
520:                 .Themes          = .F.
521:                 .SpecialEffect   = 0
522:                 .MousePointer    = 15
523:                 .WordWrap        = .T.
524:                 .Visible         = .T.
525:             ENDWITH
526:             BINDEVENT(par_oPage.cnt_4c_AcoesSQL.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
527: 
528:             par_oPage.cnt_4c_AcoesSQL.AddObject("cmd_4c_VisualizarRpt", "CommandButton")
529:             WITH par_oPage.cnt_4c_AcoesSQL.cmd_4c_VisualizarRpt
530:                 .Caption         = "Visualizar"
531:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
532:                 .PicturePosition = 13
533:                 .Top             = 5
534:                 .Left            = 80
535:                 .Width           = 75
536:                 .Height          = 75
537:                 .BackColor       = RGB(255, 255, 255)
538:                 .ForeColor       = RGB(90, 90, 90)
539:                 .FontName        = "Comic Sans MS"
540:                 .FontSize        = 8
541:                 .FontBold        = .T.
542:                 .FontItalic      = .T.
543:                 .Themes          = .F.
544:                 .SpecialEffect   = 0
545:                 .MousePointer    = 15
546:                 .WordWrap        = .T.
547:                 .Visible         = .T.
548:             ENDWITH
549:             BINDEVENT(par_oPage.cnt_4c_AcoesSQL.cmd_4c_VisualizarRpt, "Click", THIS, "BtnVisualizarRptClick")
550: 
551:             par_oPage.cnt_4c_AcoesSQL.AddObject("cmd_4c_Estrutura", "CommandButton")
552:             WITH par_oPage.cnt_4c_AcoesSQL.cmd_4c_Estrutura
553:                 .Caption         = "Layout"
554:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
555:                 .PicturePosition = 13
556:                 .Top             = 5
557:                 .Left            = 155
558:                 .Width           = 75
559:                 .Height          = 75
560:                 .BackColor       = RGB(255, 255, 255)
561:                 .ForeColor       = RGB(90, 90, 90)
562:                 .FontName        = "Comic Sans MS"
563:                 .FontSize        = 8
564:                 .FontBold        = .T.
565:                 .FontItalic      = .T.
566:                 .Themes          = .F.
567:                 .SpecialEffect   = 0
568:                 .MousePointer    = 15
569:                 .WordWrap        = .T.
570:                 .Visible         = .T.
571:             ENDWITH
572:             BINDEVENT(par_oPage.cnt_4c_AcoesSQL.cmd_4c_Estrutura, "Click", THIS, "BtnLayoutClick")
573: 
574:             *-- Label "Nome do Arquivo do Report:"
575:             par_oPage.AddObject("lbl_4c_NmReport", "Label")
576:             WITH par_oPage.lbl_4c_NmReport
577:                 .Top       = 2
578:                 .Left      = 326
579:                 .Width     = 139
580:                 .Height    = 15
581:                 .Caption   = "Nome do Arquivo do Report:"
582:                 .FontName  = "Tahoma"
583:                 .FontSize  = 8
584:                 .BackStyle = 0
585:                 .Visible   = .T.
586:             ENDWITH
587: 
588:             *-- TextBox nome do relatorio (Txt_NmReport no legado)
589:             par_oPage.AddObject("txt_4c_NmReport", "TextBox")
590:             WITH par_oPage.txt_4c_NmReport
591:                 .Top       = 14
592:                 .Left      = 326
593:                 .Width     = 361
594:                 .Height    = 23
595:                 .FontName  = "Tahoma"
596:                 .FontSize  = 8
597:                 .MaxLength = 100
598:                 .Visible   = .T.
599:             ENDWITH
600: 
601:             *-- ComboBox para selecionar report existente (Cbo_NmReports no legado)
602:             par_oPage.AddObject("cbo_4c_NmReports", "ComboBox")
603:             WITH par_oPage.cbo_4c_NmReports
604:                 .Top           = 13
605:                 .Left          = 691
606:                 .Width         = 200
607:                 .Height        = 24
608:                 .Style         = 2
609:                 .FontName      = "Tahoma"
610:                 .FontSize      = 8
611:                 .RowSourceType = 0
612:                 .Visible       = .T.
613:             ENDWITH
614:             BINDEVENT(par_oPage.cbo_4c_NmReports, "InteractiveChange", THIS, "CboNmReportsChange")
615:             BINDEVENT(par_oPage.txt_4c_NmReport, "KeyPress", THIS, "NmReportLostFocus")
616: 
617:             *-- CheckBox Ativo (Chk_Ativo no legado)
618:             par_oPage.AddObject("chk_4c_Ativo", "CheckBox")
619:             WITH par_oPage.chk_4c_Ativo
620:                 .Top       = 19
621:                 .Left      = 733
622:                 .Width     = 48
623:                 .Height    = 15
624:                 .Caption   = "Ativo"
625:                 .FontName  = "Tahoma"
626:                 .FontSize  = 8
627:                 .Value     = 1
628:                 .BackStyle = 0
629:                 .Visible   = .T.
630:             ENDWITH
631: 
632:             *-- Label "Descricao desse Report:"
633:             par_oPage.AddObject("lbl_4c_Descr", "Label")
634:             WITH par_oPage.lbl_4c_Descr
635:                 .Top       = 38
636:                 .Left      = 326
637:                 .Width     = 119
638:                 .Height    = 15
639:                 .Caption   = "Descri" + CHR(231) + CHR(227) + "o desse Report:"
640:                 .FontName  = "Tahoma"
641:                 .FontSize  = 8
642:                 .BackStyle = 0
643:                 .Visible   = .T.
644:             ENDWITH
645: 
646:             *-- EditBox descricao (Edt_Descricao no legado)
647:             par_oPage.AddObject("edt_4c_Descricao", "EditBox")
648:             WITH par_oPage.edt_4c_Descricao
649:                 .Top        = 50
650:                 .Left       = 326
651:                 .Width      = 454
652:                 .Height     = 41
653:                 .FontName   = "Tahoma"
654:                 .FontSize   = 8
655:                 .ScrollBars = 3
656:                 .Visible    = .T.
657:             ENDWITH
658: 
659:             *-- Label "Data de Criacao:"
660:             par_oPage.AddObject("lbl_4c_DtCriacao", "Label")
661:             WITH par_oPage.lbl_4c_DtCriacao
662:                 .Top       = 92
663:                 .Left      = 326
664:                 .Width     = 83
665:                 .Height    = 15
666:                 .Caption   = "Data de Cria" + CHR(231) + CHR(227) + "o:"
667:                 .FontName  = "Tahoma"
668:                 .FontSize  = 8
669:                 .BackStyle = 0
670:                 .Visible   = .T.
671:             ENDWITH
672: 
673:             *-- TextBox data criacao - somente leitura (Txt_DtCriacao no legado)
674:             par_oPage.AddObject("txt_4c_DtCriacao", "TextBox")
675:             WITH par_oPage.txt_4c_DtCriacao
676:                 .Top       = 104
677:                 .Left      = 326
678:                 .Width     = 184
679:                 .Height    = 23
680:                 .FontName  = "Tahoma"
681:                 .FontSize  = 8
682:                 .ReadOnly  = .T.
683:                 .BackColor = RGB(240, 240, 240)
684:                 .Visible   = .T.
685:             ENDWITH
686: 
687:             *-- Label "Data de Alteracao:"
688:             par_oPage.AddObject("lbl_4c_DtAlteracao", "Label")
689:             WITH par_oPage.lbl_4c_DtAlteracao
690:                 .Top       = 92
691:                 .Left      = 596
692:                 .Width     = 93
693:                 .Height    = 15
694:                 .Caption   = "Data de Altera" + CHR(231) + CHR(227) + "o:"
695:                 .FontName  = "Tahoma"
696:                 .FontSize  = 8
697:                 .BackStyle = 0
698:                 .Visible   = .T.
699:             ENDWITH
700: 
701:             *-- TextBox data alteracao - somente leitura (Txt_DtAlteracao no legado)
702:             par_oPage.AddObject("txt_4c_DtAlteracao", "TextBox")
703:             WITH par_oPage.txt_4c_DtAlteracao
704:                 .Top       = 104
705:                 .Left      = 596
706:                 .Width     = 184
707:                 .Height    = 23
708:                 .FontName  = "Tahoma"
709:                 .FontSize  = 8
710:                 .ReadOnly  = .T.
711:                 .BackColor = RGB(240, 240, 240)
712:                 .Visible   = .T.
713:             ENDWITH
714: 
715:             *-- Labels "De:" e "Ate:" para filtros de data da query SQL
716:             par_oPage.AddObject("lbl_4c_De", "Label")
717:             WITH par_oPage.lbl_4c_De
718:                 .Top       = 132
719:                 .Left      = 26
720:                 .Width     = 25
721:                 .Height    = 16
722:                 .Caption   = "De:"
723:                 .FontName  = "Tahoma"
724:                 .FontSize  = 8
725:                 .BackStyle = 0
726:                 .Visible   = .T.
727:             ENDWITH
728: 
729:             par_oPage.AddObject("txt_4c_DtDe", "TextBox")
730:             WITH par_oPage.txt_4c_DtDe
731:                 .Top       = 128
732:                 .Left      = 53
733:                 .Width     = 100
734:                 .Height    = 23
735:                 .FontName  = "Tahoma"
736:                 .FontSize  = 8
737:                 .Visible   = .T.
738:             ENDWITH
739: 
740:             par_oPage.AddObject("lbl_4c_Ate", "Label")
741:             WITH par_oPage.lbl_4c_Ate
742:                 .Top       = 131
743:                 .Left      = 164
744:                 .Width     = 28
745:                 .Height    = 16
746:                 .Caption   = "At" + CHR(233) + ":"
747:                 .FontName  = "Tahoma"
748:                 .FontSize  = 8
749:                 .BackStyle = 0
750:                 .Visible   = .T.
751:             ENDWITH
752: 
753:             par_oPage.AddObject("txt_4c_DtAte", "TextBox")
754:             WITH par_oPage.txt_4c_DtAte
755:                 .Top       = 128
756:                 .Left      = 195
757:                 .Width     = 100
758:                 .Height    = 23
759:                 .FontName  = "Tahoma"
760:                 .FontSize  = 8
761:                 .Visible   = .T.
762:             ENDWITH
763: 
764:             *-- Container dica F8/F9 (Container1 no legado)
765:             par_oPage.AddObject("cnt_4c_HintF8F9", "Container")
766:             WITH par_oPage.cnt_4c_HintF8F9
767:                 .Top        = 141
768:                 .Left       = 326
769:                 .Width      = 397
770:                 .Height     = 24
771:                 .BackStyle  = 0
772:                 .BorderWidth = 0
773:                 .Visible    = .T.
774:             ENDWITH
775: 
776:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_HintTexto", "Label")
777:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_HintTexto
778:                 .Top       = 2
779:                 .Left      = 3
780:                 .Width     = 392
781:                 .Height    = 15
782:                 .Caption   = "Use: F8 para listar as Tabelas, e F9 para listar as Vari" + CHR(225) + "veis."
783:                 .FontName  = "Verdana"
784:                 .FontSize  = 8
785:                 .FontBold  = .T.
786:                 .ForeColor = RGB(90, 90, 90)
787:                 .BackStyle = 0
788:                 .Visible   = .T.
789:             ENDWITH
790: 
791:             *-- Lbl_F8: "F8" azul clicavel (overlay sobre texto do lbl_4c_HintTexto)
792:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_F8", "Label")
793:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F8
794:                 .AutoSize     = .T.
795:                 .Top          = 2
796:                 .Left         = 35
797:                 .Height       = 15
798:                 .Width        = 18
799:                 .Caption      = "F8"
800:                 .FontName     = "Verdana"
801:                 .FontSize     = 8
802:                 .FontBold     = .T.
803:                 .ForeColor    = RGB(0, 0, 255)
804:                 .BackStyle    = 0
805:                 .MousePointer = 15
806:                 .Visible      = .T.
807:             ENDWITH
808:             BINDEVENT(par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F8, "Click", THIS, "LblF8Click")
809: 
810:             *-- Lbl_Tabelas: "Tabelas" sublinhado (overlay)
811:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_Tabelas", "Label")
812:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_Tabelas
813:                 .AutoSize      = .T.
814:                 .Top           = 2
815:                 .Left          = 146
816:                 .Height        = 15
817:                 .Width         = 53
818:                 .Caption       = "Tabelas"
819:                 .FontName      = "Verdana"
820:                 .FontSize      = 8
821:                 .FontBold      = .T.
822:                 .FontUnderline = .T.
823:                 .ForeColor     = RGB(90, 90, 90)
824:                 .BackStyle     = 0
825:                 .Visible       = .T.
826:             ENDWITH
827: 
828:             *-- Lbl_F9: "F9" azul clicavel (overlay)
829:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_F9", "Label")
830:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F9
831:                 .AutoSize     = .T.
832:                 .Top          = 2
833:                 .Left         = 217
834:                 .Height       = 15
835:                 .Width        = 18
836:                 .Caption      = "F9"
837:                 .FontName     = "Verdana"
838:                 .FontSize     = 8
839:                 .FontBold     = .T.
840:                 .ForeColor    = RGB(0, 0, 255)
841:                 .BackStyle    = 0
842:                 .MousePointer = 15
843:                 .Visible      = .T.
844:             ENDWITH
845:             BINDEVENT(par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_F9, "Click", THIS, "LblF9Click")
846: 
847:             *-- Lbl_Variaveis: "Variaveis" sublinhado (overlay)
848:             par_oPage.cnt_4c_HintF8F9.AddObject("lbl_4c_Lbl_Variaveis", "Label")
849:             WITH par_oPage.cnt_4c_HintF8F9.lbl_4c_Lbl_Variaveis
850:                 .AutoSize      = .T.
851:                 .Top           = 2
852:                 .Left          = 328
853:                 .Height        = 15
854:                 .Width         = 63
855:                 .Caption       = "Vari" + CHR(225) + "veis"
856:                 .FontName      = "Verdana"
857:                 .FontSize      = 8
858:                 .FontBold      = .T.
859:                 .FontUnderline = .T.
860:                 .ForeColor     = RGB(90, 90, 90)
861:                 .BackStyle     = 0
862:                 .Visible       = .T.
863:             ENDWITH
864: 
865:             *-- Indicador SQL modificado (Lbl_SQL_Alterado no legado - asterisco vermelho)
866:             par_oPage.AddObject("lbl_4c_SqlAlterado", "Label")
867:             WITH par_oPage.lbl_4c_SqlAlterado
868:                 .Top       = 147
869:                 .Left      = 8
870:                 .Width     = 27
871:                 .Height    = 17
872:                 .Caption   = ""
873:                 .FontName  = "Tahoma"
874:                 .FontSize  = 12
875:                 .FontBold  = .T.
876:                 .ForeColor = RGB(255, 0, 0)
877:                 .BackStyle = 0
878:                 .Visible   = .T.
879:             ENDWITH
880: 
881:             *-- EditBox SQL (OleRTF_SqlCMD no legado - substituido por EditBox nativo)
882:             par_oPage.AddObject("edt_4c_SqlCMD", "EditBox")
883:             WITH par_oPage.edt_4c_SqlCMD
884:                 .Top        = 158
885:                 .Left       = 8
886:                 .Width      = 986
887:                 .Height     = 214
888:                 .FontName   = "Courier New"
889:                 .FontSize   = 9
890:                 .ScrollBars = 3

*-- Linhas 896 a 905:
896:             *-- Grade de resultados SQL (FwGrade1_Resultado no legado)
897:             par_oPage.AddObject("grd_4c_Resultado", "Grid")
898:             WITH par_oPage.grd_4c_Resultado
899:                 .Top                = 379
900:                 .Left               = 8
901:                 .Width              = 986
902:                 .Height             = 218
903:                 .FontName           = "Verdana"
904:                 .FontSize           = 8
905:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 946 a 958:
946:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
947: 
948:                     *-- Redefinir headers APOS RecordSource (CRITICO - Problema 6)
949:                     loc_oGrid.Column1.Header1.Caption = "Titulo"
950:                     loc_oGrid.Column2.Header1.Caption = "Descr"
951:                     loc_oGrid.Column3.Header1.Caption = "DtCriacao"
952:                     loc_oGrid.Column4.Header1.Caption = "DtAlteracao"
953:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
954: 
955:                     loc_oGrid.Column1.Width = 350
956:                     loc_oGrid.Column2.Width = 350
957:                     loc_oGrid.Column3.Width = 90
958:                     loc_oGrid.Column4.Width = 90

*-- Linhas 1139 a 1151:
1139:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.DtAlteracao"
1140:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Ativo"
1141: 
1142:                     loc_oGrid.Column1.Header1.Caption = "Titulo"
1143:                     loc_oGrid.Column2.Header1.Caption = "Descr"
1144:                     loc_oGrid.Column3.Header1.Caption = "DtCriacao"
1145:                     loc_oGrid.Column4.Header1.Caption = "DtAlteracao"
1146:                     loc_oGrid.Column5.Header1.Caption = "Ativo"
1147: 
1148:                     loc_oGrid.Column1.Width = 350
1149:                     loc_oGrid.Column2.Width = 350
1150:                     loc_oGrid.Column3.Width = 90
1151:                     loc_oGrid.Column4.Width = 90

*-- Linhas 1247 a 1259:
1247: 
1248:                     FOR loc_nI = 1 TO loc_nCols
1249:                         loc_oGrid.Columns(loc_nI).ControlSource = "cursor_4c_SqlResult." + laFields[loc_nI, 1]
1250:                         loc_oGrid.Columns(loc_nI).Header1.Caption = laFields[loc_nI, 1]
1251:                         loc_oGrid.Columns(loc_nI).Width = 100
1252:                     ENDFOR
1253: 
1254:                     loc_oPage.lbl_4c_SqlAlterado.Caption = ""
1255:                     THIS.this_oBusinessObject.this_cSqlQuery = loc_cSQL
1256:                     loc_oGrid.Refresh()
1257: 
1258:                     MsgInfo(ALLTRIM(STR(RECCOUNT("cursor_4c_SqlResult"))) + ;
1259:                             " registro(s) retornado(s).")

*-- Linhas 1430 a 1438:
1430:     *==========================================================================
1431:     PROCEDURE SqlCMDChange()
1432:         TRY
1433:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Dados.Page1.lbl_4c_SqlAlterado.Caption = "*"
1434:         CATCH TO loc_oErro
1435:             *-- Indicador nao critico; silencioso
1436:         ENDTRY
1437:     ENDPROC
1438: 

*-- Linhas 1492 a 1500:
1492:             ENDIF
1493:             loc_oPage.edt_4c_SqlCMD.Value = loc_cSqlQuery
1494: 
1495:             loc_oPage.lbl_4c_SqlAlterado.Caption = ""
1496: 
1497:             THIS.PopularComboReports()
1498:         CATCH TO loc_oErro
1499:             MsgErro(loc_oErro.Message, "FormRPT.BOParaForm")
1500:         ENDTRY

*-- Linhas 1515 a 1523:
1515:             loc_oPage.edt_4c_SqlCMD.ReadOnly    = loc_lRO
1516:             loc_oPage.cbo_4c_NmReports.Enabled  = !loc_lRO
1517: 
1518:             THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = !loc_lRO
1519:         CATCH TO loc_oErro
1520:             MsgErro(loc_oErro.Message, "FormRPT.ConfigurarModoEditor")
1521:         ENDTRY
1522:     ENDPROC
1523: 

*-- Linhas 1560 a 1609:
1560:     PROTECTED PROCEDURE ConfigurarDesignerLayout(par_oPage)
1561:         TRY
1562:             *-- Container botoes de acao do designer (CmdGrp_Acoes no legado - 2 botoes)
1563:             par_oPage.AddObject("cnt_4c_AcoesDesigner", "Container")
1564:             WITH par_oPage.cnt_4c_AcoesDesigner
1565:                 .Top         = 8
1566:                 .Left        = 11
1567:                 .Width       = 160
1568:                 .Height      = 85
1569:                 .BackColor   = RGB(53, 53, 53)
1570:                 .BackStyle   = 1
1571:                 .BorderWidth = 0
1572:                 .Visible     = .T.
1573:             ENDWITH
1574: 
1575:             par_oPage.cnt_4c_AcoesDesigner.AddObject("cmd_4c_VoltarEditor", "CommandButton")
1576:             WITH par_oPage.cnt_4c_AcoesDesigner.cmd_4c_VoltarEditor
1577:                 .Caption         = "Voltar"
1578:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
1579:                 .PicturePosition = 13
1580:                 .Top             = 5
1581:                 .Left            = 5
1582:                 .Width           = 75
1583:                 .Height          = 75
1584:                 .BackColor       = RGB(255, 255, 255)
1585:                 .ForeColor       = RGB(90, 90, 90)
1586:                 .FontName        = "Comic Sans MS"
1587:                 .FontSize        = 8
1588:                 .FontBold        = .T.
1589:                 .FontItalic      = .T.
1590:                 .Themes          = .F.
1591:                 .SpecialEffect   = 0
1592:                 .MousePointer    = 15
1593:                 .WordWrap        = .T.
1594:                 .Visible         = .T.
1595:             ENDWITH
1596:             BINDEVENT(par_oPage.cnt_4c_AcoesDesigner.cmd_4c_VoltarEditor, "Click", THIS, "BtnVoltarEditorClick")
1597: 
1598:             par_oPage.cnt_4c_AcoesDesigner.AddObject("cmd_4c_SalvarRPT", "CommandButton")
1599:             WITH par_oPage.cnt_4c_AcoesDesigner.cmd_4c_SalvarRPT
1600:                 .Caption         = "Salvar RPT"
1601:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
1602:                 .PicturePosition = 13
1603:                 .Top             = 5
1604:                 .Left            = 80
1605:                 .Width           = 75
1606:                 .Height          = 75
1607:                 .BackColor       = RGB(255, 255, 255)
1608:                 .ForeColor       = RGB(90, 90, 90)
1609:                 .FontName        = "Comic Sans MS"

*-- Linhas 1616 a 1693:
1616:                 .WordWrap        = .T.
1617:                 .Visible         = .T.
1618:             ENDWITH
1619:             BINDEVENT(par_oPage.cnt_4c_AcoesDesigner.cmd_4c_SalvarRPT, "Click", THIS, "BtnSalvarRPTClick")
1620: 
1621:             *-- Imagem orientacao (Img_Orientacao no legado)
1622:             par_oPage.AddObject("img_4c_Orientacao", "Image")
1623:             WITH par_oPage.img_4c_Orientacao
1624:                 .Top     = 6
1625:                 .Left    = 603
1626:                 .Width   = 130
1627:                 .Height  = 116
1628:                 .Stretch = 2
1629:                 .Picture = gc_4c_CaminhoIcones + "rpt_orientacao_retrato_26.jpg"
1630:                 .Visible = .T.
1631:             ENDWITH
1632: 
1633:             *-- OptionGroup orientacao Retrato/Paisagem (OptGrp_Orientacao no legado)
1634:             par_oPage.AddObject("opt_4c_Orientacao", "OptionGroup")
1635:             WITH par_oPage.opt_4c_Orientacao
1636:                 .Top         = 126
1637:                 .Left        = 580
1638:                 .Width       = 185
1639:                 .Height      = 28
1640:                 .ButtonCount = 2
1641:                 .BackStyle   = 0
1642:                 .BorderStyle = 0
1643:                 .Value       = 1
1644:                 .Visible     = .T.
1645:             ENDWITH
1646:             WITH par_oPage.opt_4c_Orientacao.Buttons(1)
1647:                 .Caption   = "Retrato"
1648:                 .BackStyle = 0
1649:                 .Left      = 5
1650:                 .Top       = 5
1651:                 .Width     = 72
1652:                 .AutoSize  = .T.
1653:                 .FontName  = "Tahoma"
1654:                 .FontSize  = 8
1655:                 .ForeColor = RGB(90, 90, 90)
1656:             ENDWITH
1657:             WITH par_oPage.opt_4c_Orientacao.Buttons(2)
1658:                 .Caption   = "Paisagem"
1659:                 .BackStyle = 0
1660:                 .Left      = 90
1661:                 .Top       = 5
1662:                 .Width     = 85
1663:                 .AutoSize  = .T.
1664:                 .FontName  = "Tahoma"
1665:                 .FontSize  = 8
1666:                 .ForeColor = RGB(90, 90, 90)
1667:             ENDWITH
1668:             BINDEVENT(par_oPage.opt_4c_Orientacao, "InteractiveChange", THIS, "OptOrientacaoChanged")
1669: 
1670:             *-- Label "Tamanho do Papel:" (Lbl_TamPapel no legado)
1671:             par_oPage.AddObject("lbl_4c_TamPapel", "Label")
1672:             WITH par_oPage.lbl_4c_TamPapel
1673:                 .Top       = 48
1674:                 .Left      = 202
1675:                 .Width     = 108
1676:                 .Height    = 16
1677:                 .Caption   = "Tamanho do Papel:"
1678:                 .FontName  = "Tahoma"
1679:                 .FontSize  = 8
1680:                 .BackStyle = 0
1681:                 .Visible   = .T.
1682:             ENDWITH
1683: 
1684:             *-- ComboBox tamanho papel (Cbo_TamPapel no legado)
1685:             par_oPage.AddObject("cbo_4c_TamPapel", "ComboBox")
1686:             WITH par_oPage.cbo_4c_TamPapel
1687:                 .Top           = 71
1688:                 .Left          = 202
1689:                 .Width         = 348
1690:                 .Height        = 24
1691:                 .Style         = 2
1692:                 .FontName      = "Tahoma"
1693:                 .FontSize      = 8

*-- Linhas 1699 a 1728:
1699:             THIS.PopularCboTamPapel(par_oPage.cbo_4c_TamPapel)
1700: 
1701:             *-- Label nome do relatorio (Lbl_Nm_Relatorio no legado)
1702:             par_oPage.AddObject("lbl_4c_NmRelatorio", "Label")
1703:             WITH par_oPage.lbl_4c_NmRelatorio
1704:                 .Top       = 131
1705:                 .Left      = 10
1706:                 .Width     = 540
1707:                 .Height    = 22
1708:                 .Caption   = ""
1709:                 .FontName  = "Tahoma"
1710:                 .FontSize  = 10
1711:                 .FontBold  = .T.
1712:                 .BackStyle = 0
1713:                 .Visible   = .T.
1714:             ENDWITH
1715: 
1716:             *-- Label "Titulo do Relatorio:" (Label1 no legado)
1717:             par_oPage.AddObject("lbl_4c_TituloRel", "Label")
1718:             WITH par_oPage.lbl_4c_TituloRel
1719:                 .Top       = 162
1720:                 .Left      = 10
1721:                 .Width     = 110
1722:                 .Height    = 16
1723:                 .Caption   = "T" + CHR(237) + "tulo do Relat" + CHR(243) + "rio: "
1724:                 .FontName  = "Tahoma"
1725:                 .FontSize  = 8
1726:                 .BackStyle = 0
1727:                 .Visible   = .T.
1728:             ENDWITH

*-- Linhas 1857 a 1866:
1857:             par_oPage.AddObject("grd_4c_TIT", "Grid")
1858:             loc_oGrd = par_oPage.grd_4c_TIT
1859:             WITH loc_oGrd
1860:                 .Top              = 180
1861:                 .Left             = 4
1862:                 .Width            = 990
1863:                 .Height           = 65
1864:                 .ColumnCount      = 5
1865:                 .RecordSourceType = 1
1866:                 .RecordSource     = ""

*-- Linhas 1875 a 1943:
1875: 
1876:             *- Col1: LblCaption - "Titulo" (EditBox)
1877:             loc_oCol = loc_oGrd.Column1
1878:             loc_oCol.Header1.Caption = "Titulo"
1879:             loc_oCol.Width  = 300
1880:             loc_oCol.Sparse = .F.
1881:             loc_oCol.AddObject("edt_4c_TitCaption", "EditBox")
1882:             loc_oCol.CurrentControl = "edt_4c_TitCaption"
1883:             WITH loc_oCol.edt_4c_TitCaption
1884:                 .Width      = 298
1885:                 .Height     = 28
1886:                 .ScrollBars = 0
1887:             ENDWITH
1888: 
1889:             *- Col2: LblFonte - "Fonte" (EditBox - string "FontName,Size,Style")
1890:             loc_oCol = loc_oGrd.Column2
1891:             loc_oCol.Header1.Caption = "Fonte"
1892:             loc_oCol.Width  = 230
1893:             loc_oCol.Sparse = .F.
1894:             loc_oCol.AddObject("edt_4c_TitFonte", "EditBox")
1895:             loc_oCol.CurrentControl = "edt_4c_TitFonte"
1896:             WITH loc_oCol.edt_4c_TitFonte
1897:                 .Width      = 228
1898:                 .Height     = 28
1899:                 .ScrollBars = 0
1900:             ENDWITH
1901: 
1902:             *- Col3: BtFonte - "Fte" (CommandButton - abre dialogo GETFONT)
1903:             loc_oCol = loc_oGrd.Column3
1904:             loc_oCol.Header1.Caption = "Fte"
1905:             loc_oCol.Width  = 80
1906:             loc_oCol.Sparse = .F.
1907:             loc_oCol.AddObject("cmd_4c_FonteTIT", "CommandButton")
1908:             loc_oCol.CurrentControl = "cmd_4c_FonteTIT"
1909:             WITH loc_oCol.cmd_4c_FonteTIT
1910:                 .Caption       = "..."
1911:                 .Width         = 75
1912:                 .Height        = 25
1913:                 .SpecialEffect = 0
1914:                 .FontName      = "Tahoma"
1915:                 .FontSize      = 8
1916:             ENDWITH
1917:             BINDEVENT(loc_oCol.cmd_4c_FonteTIT, "Click", THIS, "BtnFonteTITClick")
1918: 
1919:             *- Col4: BtCor - "Cor" (CommandButton - abre GETCOLOR)
1920:             loc_oCol = loc_oGrd.Column4
1921:             loc_oCol.Header1.Caption = "Cor"
1922:             loc_oCol.Width  = 80
1923:             loc_oCol.Sparse = .F.
1924:             loc_oCol.AddObject("cmd_4c_CorTIT", "CommandButton")
1925:             loc_oCol.CurrentControl = "cmd_4c_CorTIT"
1926:             WITH loc_oCol.cmd_4c_CorTIT
1927:                 .Caption       = "..."
1928:                 .Width         = 75
1929:                 .Height        = 25
1930:                 .SpecialEffect = 0
1931:                 .FontName      = "Tahoma"
1932:                 .FontSize      = 8
1933:             ENDWITH
1934:             BINDEVENT(loc_oCol.cmd_4c_CorTIT, "Click", THIS, "BtnCorTITClick")
1935: 
1936:             *- Col5: LblAlinhar - "Alinhar" (ComboBox Esq./Cen./Dir.)
1937:             loc_oCol = loc_oGrd.Column5
1938:             loc_oCol.Header1.Caption = "Alinhar"
1939:             loc_oCol.Width  = 300
1940:             loc_oCol.Sparse = .F.
1941:             loc_oCol.AddObject("cbo_4c_AlinharTIT", "ComboBox")
1942:             loc_oCol.CurrentControl = "cbo_4c_AlinharTIT"
1943:             WITH loc_oCol.cbo_4c_AlinharTIT

*-- Linhas 1954 a 1963:
1954:             par_oPage.AddObject("grd_4c_CMPs", "Grid")
1955:             loc_oGrd = par_oPage.grd_4c_CMPs
1956:             WITH loc_oGrd
1957:                 .Top              = 258
1958:                 .Left             = 4
1959:                 .Width            = 990
1960:                 .Height           = 238
1961:                 .ColumnCount      = 12
1962:                 .RecordSourceType = 1
1963:                 .RecordSource     = ""

*-- Linhas 1972 a 1980:
1972: 
1973:             *- Col1: NmCampo - "Campo" (TextBox, readonly - nome do campo do SQL)
1974:             loc_oCol = loc_oGrd.Column1
1975:             loc_oCol.Header1.Caption = "Campo"
1976:             loc_oCol.Width    = 140
1977:             loc_oCol.Sparse   = .F.
1978:             loc_oCol.ReadOnly = .T.
1979:             loc_oCol.AddObject("txt_4c_NmCampo", "TextBox")
1980:             loc_oCol.CurrentControl = "txt_4c_NmCampo"

*-- Linhas 1989 a 1997:
1989: 
1990:             *- Col2: TpCampo - "Tipo" (TextBox, readonly - tipo do campo)
1991:             loc_oCol = loc_oGrd.Column2
1992:             loc_oCol.Header1.Caption = "Tipo"
1993:             loc_oCol.Width    = 75
1994:             loc_oCol.Sparse   = .F.
1995:             loc_oCol.ReadOnly = .T.
1996:             loc_oCol.AddObject("txt_4c_TpCampo", "TextBox")
1997:             loc_oCol.CurrentControl = "txt_4c_TpCampo"

*-- Linhas 2004 a 2086:
2004:                 .FontSize  = 8
2005:             ENDWITH
2006: 
2007:             *- Col3: CkOutRPT - "Saida Rel." (CheckBox - inclui campo na saida do relatorio)
2008:             loc_oCol = loc_oGrd.Column3
2009:             loc_oCol.Header1.Caption = "Sa" + CHR(237) + "da Rel."
2010:             loc_oCol.Width  = 60
2011:             loc_oCol.Sparse = .F.
2012:             loc_oCol.AddObject("chk_4c_SaidaRPT", "CheckBox")
2013:             loc_oCol.CurrentControl = "chk_4c_SaidaRPT"
2014:             WITH loc_oCol.chk_4c_SaidaRPT
2015:                 .Caption   = ""
2016:                 .Alignment = 0
2017:                 .ReadOnly  = .F.
2018:                 .Visible   = .T.
2019:                 .Top       = 9
2020:                 .Left      = 2
2021:                 .Height    = 17
2022:                 .Width     = 22
2023:             ENDWITH
2024: 
2025:             *- Col4: CkFiltro - "Filtro" (CheckBox - habilita como filtro)
2026:             loc_oCol = loc_oGrd.Column4
2027:             loc_oCol.Header1.Caption = "Filtro"
2028:             loc_oCol.Width  = 50
2029:             loc_oCol.Sparse = .F.
2030:             loc_oCol.AddObject("chk_4c_CkFiltro", "CheckBox")
2031:             loc_oCol.CurrentControl = "chk_4c_CkFiltro"
2032:             WITH loc_oCol.chk_4c_CkFiltro
2033:                 .Caption   = ""
2034:                 .Alignment = 0
2035:                 .ReadOnly  = .F.
2036:                 .Visible   = .T.
2037:                 .Top       = 9
2038:                 .Left      = 2
2039:                 .Height    = 17
2040:                 .Width     = 22
2041:             ENDWITH
2042: 
2043:             *- Col5: CkSubTot - "SubTot" (CheckBox - subtotalizar)
2044:             loc_oCol = loc_oGrd.Column5
2045:             loc_oCol.Header1.Caption = "SubTot"
2046:             loc_oCol.Width  = 55
2047:             loc_oCol.Sparse = .F.
2048:             loc_oCol.AddObject("chk_4c_CkSubTot", "CheckBox")
2049:             loc_oCol.CurrentControl = "chk_4c_CkSubTot"
2050:             WITH loc_oCol.chk_4c_CkSubTot
2051:                 .Caption   = ""
2052:                 .Alignment = 0
2053:                 .ReadOnly  = .F.
2054:                 .Visible   = .T.
2055:                 .Top       = 9
2056:                 .Left      = 2
2057:                 .Height    = 17
2058:                 .Width     = 22
2059:             ENDWITH
2060: 
2061:             *- Col6: CkTotal - "Total" (CheckBox - total final)
2062:             loc_oCol = loc_oGrd.Column6
2063:             loc_oCol.Header1.Caption = "Total"
2064:             loc_oCol.Width  = 50
2065:             loc_oCol.Sparse = .F.
2066:             loc_oCol.AddObject("chk_4c_CkTotal", "CheckBox")
2067:             loc_oCol.CurrentControl = "chk_4c_CkTotal"
2068:             WITH loc_oCol.chk_4c_CkTotal
2069:                 .Caption   = ""
2070:                 .Alignment = 0
2071:                 .ReadOnly  = .F.
2072:                 .Visible   = .T.
2073:                 .Top       = 9
2074:                 .Left      = 2
2075:                 .Height    = 17
2076:                 .Width     = 22
2077:             ENDWITH
2078: 
2079:             *- Col7: LblCaption - "Titulo do Campo" (EditBox - rotulo da coluna no relatorio)
2080:             loc_oCol = loc_oGrd.Column7
2081:             loc_oCol.Header1.Caption = "Titulo do Campo"
2082:             loc_oCol.Width  = 130
2083:             loc_oCol.Sparse = .F.
2084:             loc_oCol.AddObject("edt_4c_LblCaption", "EditBox")
2085:             loc_oCol.CurrentControl = "edt_4c_LblCaption"
2086:             WITH loc_oCol.edt_4c_LblCaption

*-- Linhas 2093 a 2101:
2093: 
2094:             *- Col8: LblFonte - "Fonte" (EditBox - fonte da coluna)
2095:             loc_oCol = loc_oGrd.Column8
2096:             loc_oCol.Header1.Caption = "Fonte"
2097:             loc_oCol.Width  = 130
2098:             loc_oCol.Sparse = .F.
2099:             loc_oCol.AddObject("edt_4c_LblFonte", "EditBox")
2100:             loc_oCol.CurrentControl = "edt_4c_LblFonte"
2101:             WITH loc_oCol.edt_4c_LblFonte

*-- Linhas 2108 a 2150:
2108: 
2109:             *- Col9: LblBtFonte - "Fte" (CommandButton - abre GETFONT)
2110:             loc_oCol = loc_oGrd.Column9
2111:             loc_oCol.Header1.Caption = "Fte"
2112:             loc_oCol.Width  = 65
2113:             loc_oCol.Sparse = .F.
2114:             loc_oCol.AddObject("cmd_4c_FonteCMP", "CommandButton")
2115:             loc_oCol.CurrentControl = "cmd_4c_FonteCMP"
2116:             WITH loc_oCol.cmd_4c_FonteCMP
2117:                 .Caption       = "..."
2118:                 .Width         = 60
2119:                 .Height        = 25
2120:                 .SpecialEffect = 0
2121:                 .FontName      = "Tahoma"
2122:                 .FontSize      = 8
2123:             ENDWITH
2124:             BINDEVENT(loc_oCol.cmd_4c_FonteCMP, "Click", THIS, "BtnFonteCMPClick")
2125: 
2126:             *- Col10: LblBtCor - "Cor" (CommandButton - abre GETCOLOR)
2127:             loc_oCol = loc_oGrd.Column10
2128:             loc_oCol.Header1.Caption = "Cor"
2129:             loc_oCol.Width  = 65
2130:             loc_oCol.Sparse = .F.
2131:             loc_oCol.AddObject("cmd_4c_CorCMP", "CommandButton")
2132:             loc_oCol.CurrentControl = "cmd_4c_CorCMP"
2133:             WITH loc_oCol.cmd_4c_CorCMP
2134:                 .Caption       = "..."
2135:                 .Width         = 60
2136:                 .Height        = 25
2137:                 .SpecialEffect = 0
2138:                 .FontName      = "Tahoma"
2139:                 .FontSize      = 8
2140:             ENDWITH
2141:             BINDEVENT(loc_oCol.cmd_4c_CorCMP, "Click", THIS, "BtnCorCMPClick")
2142: 
2143:             *- Col11: LblAlinhar - "Alinhar" (ComboBox)
2144:             loc_oCol = loc_oGrd.Column11
2145:             loc_oCol.Header1.Caption = "Alinhar"
2146:             loc_oCol.Width  = 80
2147:             loc_oCol.Sparse = .F.
2148:             loc_oCol.AddObject("cbo_4c_AlinharCMP", "ComboBox")
2149:             loc_oCol.CurrentControl = "cbo_4c_AlinharCMP"
2150:             WITH loc_oCol.cbo_4c_AlinharCMP

*-- Linhas 2159 a 2167:
2159: 
2160:             *- Col12: LblTamCmp - "Tam." (Spinner - tamanho da fonte)
2161:             loc_oCol = loc_oGrd.Column12
2162:             loc_oCol.Header1.Caption = "Tam."
2163:             loc_oCol.Width  = 90
2164:             loc_oCol.Sparse = .F.
2165:             loc_oCol.AddObject("spn_4c_TamCMP", "Spinner")
2166:             loc_oCol.CurrentControl = "spn_4c_TamCMP"
2167:             WITH loc_oCol.spn_4c_TamCMP

*-- Linhas 2173 a 2200:
2173:             ENDWITH
2174: 
2175:             *=== Label "Totalizar pelo Campo:..." (Lbl_CmpGrupo) ===
2176:             par_oPage.AddObject("lbl_4c_CmpGrupo", "Label")
2177:             WITH par_oPage.lbl_4c_CmpGrupo
2178:                 .Top       = 510
2179:                 .Left      = 10
2180:                 .Width     = 316
2181:                 .Height    = 16
2182:                 .Caption   = "Totalizar pelo Campo: ( Use o clique direito, para apagar )"
2183:                 .FontName  = "Tahoma"
2184:                 .FontSize  = 8
2185:                 .FontBold  = .T.
2186:                 .BackStyle = 0
2187:                 .Visible   = .T.
2188:             ENDWITH
2189: 
2190:             *=== GRADE 3: grd_4c_GRP (FwGrade3_GRP) - grupos/totalizacao, 7 colunas ===
2191:             par_oPage.AddObject("grd_4c_GRP", "Grid")
2192:             loc_oGrd = par_oPage.grd_4c_GRP
2193:             WITH loc_oGrd
2194:                 .Top              = 529
2195:                 .Left             = 4
2196:                 .Width            = 989
2197:                 .Height           = 67
2198:                 .ColumnCount      = 7
2199:                 .RecordSourceType = 1
2200:                 .RecordSource     = ""

*-- Linhas 2209 a 2217:
2209: 
2210:             *- Col1: NmCampo - "Grupo" (ComboBox - escolhe campo do SQL como agrupador)
2211:             loc_oCol = loc_oGrd.Column1
2212:             loc_oCol.Header1.Caption = "Grupo"
2213:             loc_oCol.Width  = 200
2214:             loc_oCol.Sparse = .F.
2215:             loc_oCol.AddObject("cbo_4c_NmCampoGRP", "ComboBox")
2216:             loc_oCol.CurrentControl = "cbo_4c_NmCampoGRP"
2217:             WITH loc_oCol.cbo_4c_NmCampoGRP

*-- Linhas 2226 a 2234:
2226: 
2227:             *- Col2: LblCaption - "Titulo do Campo" (EditBox)
2228:             loc_oCol = loc_oGrd.Column2
2229:             loc_oCol.Header1.Caption = "Titulo do Campo"
2230:             loc_oCol.Width  = 160
2231:             loc_oCol.Sparse = .F.
2232:             loc_oCol.AddObject("edt_4c_GrpCaption", "EditBox")
2233:             loc_oCol.CurrentControl = "edt_4c_GrpCaption"
2234:             WITH loc_oCol.edt_4c_GrpCaption

*-- Linhas 2241 a 2249:
2241: 
2242:             *- Col3: LblFonte - "Fonte" (EditBox)
2243:             loc_oCol = loc_oGrd.Column3
2244:             loc_oCol.Header1.Caption = "Fonte"
2245:             loc_oCol.Width  = 160
2246:             loc_oCol.Sparse = .F.
2247:             loc_oCol.AddObject("edt_4c_GrpFonte", "EditBox")
2248:             loc_oCol.CurrentControl = "edt_4c_GrpFonte"
2249:             WITH loc_oCol.edt_4c_GrpFonte

*-- Linhas 2256 a 2298:
2256: 
2257:             *- Col4: LblBtFonte - "Fte" (CommandButton - abre GETFONT)
2258:             loc_oCol = loc_oGrd.Column4
2259:             loc_oCol.Header1.Caption = "Fte"
2260:             loc_oCol.Width  = 80
2261:             loc_oCol.Sparse = .F.
2262:             loc_oCol.AddObject("cmd_4c_FonteGRP", "CommandButton")
2263:             loc_oCol.CurrentControl = "cmd_4c_FonteGRP"
2264:             WITH loc_oCol.cmd_4c_FonteGRP
2265:                 .Caption       = "..."
2266:                 .Width         = 75
2267:                 .Height        = 25
2268:                 .SpecialEffect = 0
2269:                 .FontName      = "Tahoma"
2270:                 .FontSize      = 8
2271:             ENDWITH
2272:             BINDEVENT(loc_oCol.cmd_4c_FonteGRP, "Click", THIS, "BtnFonteGRPClick")
2273: 
2274:             *- Col5: BtCor - "Cor" (CommandButton - abre GETCOLOR)
2275:             loc_oCol = loc_oGrd.Column5
2276:             loc_oCol.Header1.Caption = "Cor"
2277:             loc_oCol.Width  = 80
2278:             loc_oCol.Sparse = .F.
2279:             loc_oCol.AddObject("cmd_4c_CorGRP", "CommandButton")
2280:             loc_oCol.CurrentControl = "cmd_4c_CorGRP"
2281:             WITH loc_oCol.cmd_4c_CorGRP
2282:                 .Caption       = "..."
2283:                 .Width         = 75
2284:                 .Height        = 25
2285:                 .SpecialEffect = 0
2286:                 .FontName      = "Tahoma"
2287:                 .FontSize      = 8
2288:             ENDWITH
2289:             BINDEVENT(loc_oCol.cmd_4c_CorGRP, "Click", THIS, "BtnCorGRPClick")
2290: 
2291:             *- Col6: LblAlinhar - "Alinhar" (ComboBox)
2292:             loc_oCol = loc_oGrd.Column6
2293:             loc_oCol.Header1.Caption = "Alinhar"
2294:             loc_oCol.Width  = 160
2295:             loc_oCol.Sparse = .F.
2296:             loc_oCol.AddObject("cbo_4c_AlinharGRP", "ComboBox")
2297:             loc_oCol.CurrentControl = "cbo_4c_AlinharGRP"
2298:             WITH loc_oCol.cbo_4c_AlinharGRP

*-- Linhas 2307 a 2315:
2307: 
2308:             *- Col7: LblTamCmp - "Tam." (Spinner)
2309:             loc_oCol = loc_oGrd.Column7
2310:             loc_oCol.Header1.Caption = "Tam."
2311:             loc_oCol.Width  = 149
2312:             loc_oCol.Sparse = .F.
2313:             loc_oCol.AddObject("spn_4c_TamGRP", "Spinner")
2314:             loc_oCol.CurrentControl = "spn_4c_TamGRP"
2315:             WITH loc_oCol.spn_4c_TamGRP

*-- Linhas 2603 a 2611:
2603:             loc_oPage.txt_4c_DtCriacao.Value     = ""
2604:             loc_oPage.txt_4c_DtAlteracao.Value   = ""
2605:             loc_oPage.edt_4c_SqlCMD.Value        = ""
2606:             loc_oPage.lbl_4c_SqlAlterado.Caption = ""
2607:         CATCH TO loc_oErro
2608:             MsgErro(loc_oErro.Message, "FormRPT.LimparCampos")
2609:         ENDTRY
2610:     ENDPROC
2611: 

*-- Linhas 2619 a 2635:
2619:             loc_lModoEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2620: 
2621:             loc_oCnt = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
2622:             loc_oCnt.cmd_4c_Incluir.Enabled    = loc_lModoLista
2623:             loc_oCnt.cmd_4c_Visualizar.Enabled = loc_lModoLista
2624:             loc_oCnt.cmd_4c_Alterar.Enabled    = loc_lModoLista
2625:             loc_oCnt.cmd_4c_Excluir.Enabled    = loc_lModoLista
2626:             loc_oCnt.cmd_4c_Buscar.Enabled     = loc_lModoLista
2627: 
2628:             WITH THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2629:                 .cmd_4c_Confirmar.Enabled = loc_lModoEdicao
2630:                 .cmd_4c_Cancelar.Enabled  = !loc_lModoLista
2631:                 .Visible     = .T.
2632:             ENDWITH
2633:         CATCH TO loc_oErro
2634:             MsgErro(loc_oErro.Message, "FormRPT.AjustarBotoesPorModo")
2635:         ENDTRY

*-- Linhas 2646 a 2669:
2646:             THIS.this_oWLstTABs = CREATEOBJECT("Form")
2647:             WITH THIS.this_oWLstTABs
2648:                 .BorderStyle       = 1
2649:                 .Caption           = "Tabelas (ESC para fechar)"
2650:                 .HalfHeightCaption = .T.
2651:                 .Left              = 0
2652:                 .Top               = 0
2653:                 .Height            = 280
2654:                 .Width             = 180
2655:                 .Closable          = .F.
2656:                 .MaxButton         = .F.
2657:                 .MinButton         = .F.
2658:                 .Name              = "FrmLstTABs"
2659:                 .ShowTips          = .T.
2660:             ENDWITH
2661:             THIS.this_oWLstTABs.AddObject("Lst_TABs", "ListBox")
2662:             WITH THIS.this_oWLstTABs.Lst_TABs
2663:                 .Left    = 0
2664:                 .Top     = 0
2665:                 .Height  = 280
2666:                 .Width   = 180
2667:                 .Visible = .T.
2668:             ENDWITH
2669:             BINDEVENT(THIS.this_oWLstTABs.Lst_TABs, "DblClick", THIS, "LstTABsDblClick")

*-- Linhas 2687 a 2710:
2687:             THIS.this_oWLstVARs = CREATEOBJECT("Form")
2688:             WITH THIS.this_oWLstVARs
2689:                 .BorderStyle       = 1
2690:                 .Caption           = "Vari" + CHR(225) + "veis (ESC para fechar)"
2691:                 .HalfHeightCaption = .T.
2692:                 .Left              = 0
2693:                 .Top               = 0
2694:                 .Height            = 100
2695:                 .Width             = 180
2696:                 .Closable          = .F.
2697:                 .MaxButton         = .F.
2698:                 .MinButton         = .F.
2699:                 .Name              = "FrmLstVARs"
2700:                 .ShowTips          = .T.
2701:             ENDWITH
2702:             THIS.this_oWLstVARs.AddObject("Lst_VARs", "ListBox")
2703:             WITH THIS.this_oWLstVARs.Lst_VARs
2704:                 .Left    = 0
2705:                 .Top     = 0
2706:                 .Height  = 100
2707:                 .Width   = 180
2708:                 .Visible = .T.
2709:             ENDWITH
2710:             THIS.this_oWLstVARs.Lst_VARs.AddItem("?_vp_DtInicial")

*-- Linhas 2744 a 2753:
2744:                 IF loc_oWLst.Visible
2745:                     loc_oWLst.Hide()
2746:                 ELSE
2747:                     loc_oWLst.Top  = 420
2748:                     loc_oWLst.Left = 20
2749:                     loc_oWLst.Show()
2750:                 ENDIF
2751:             ENDIF
2752:         CATCH TO loc_oErro
2753:             MsgErro(loc_oErro.Message, "FormRPT.AtivarListas")


### BO (C:\4c\projeto\app\classes\RPTBO.prg):
*------------------------------------------------------------------------------
* RPTBO.prg - Business Object para Cadastro Customizado de Relatorios 4Report
* Herda de BusinessBase
* Tabelas principais: SIGCDRLC (cabecalho), SIGCDRLD (detalhes/layout FRX)
* Migrado de: SIGCDRPT (tasks/task512)
*------------------------------------------------------------------------------
DEFINE CLASS RPTBO AS BusinessBase

    *-- Propriedades: Cabecalho do Relatorio (SIGCDRLC)
    this_cRptId        = ""    && RPT_ID - Chave Primaria: DTOS(Date())+"_"+STRTRAN(TIME(),":","")
    this_cNmReport     = ""    && NmReport - Nome do arquivo do report
    this_cDescr        = ""    && Descr - Descricao do report
    this_lAtivo        = .T.   && Ativo - Flag ativo (1=Ativo, 0=Inativo)
    this_dDtCriacao    = {}    && DtCriacao - Data de criacao do report
    this_dDtAlteracao  = {}    && DtAlteracao - Data da ultima alteracao
    this_cSqlQuery     = ""    && SqlQuery - Comando SQL do report (memo)

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SIGCDRLC"
        THIS.this_cCampoChave = "RPT_ID"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna valor da PK para auditoria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cRptId
    ENDFUNC

    *--------------------------------------------------------------------------
    * GerarRptId - Gera novo RPT_ID no formato original: DTOS(Date())+"_"+STRTRAN(TIME(),":","")
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION GerarRptId()
        RETURN DTOS(DATE()) + "_" + STRTRAN(TIME(), ":", "")
    ENDFUNC

    *--------------------------------------------------------------------------
    * Buscar - SELECT para listar relatorios no grid
    *--------------------------------------------------------------------------
    FUNCTION Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso  = .F.
        loc_cFiltro   = IIF(VARTYPE(par_cFiltro) = "C", ALLTRIM(par_cFiltro), "")

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao" + ;
                       " FROM SIGCDRLC"

            IF !EMPTY(loc_cFiltro)
                loc_cSQL = loc_cSQL + " WHERE NmReport LIKE " + EscaparSQL("%" + loc_cFiltro + "%")
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY NmReport"

            *-- Fechar cursor anterior se existir (evita "Table buffer contains uncommitted changes")
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar relat" + CHR(243) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega cabecalho do relatorio por RPT_ID
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorCodigo(par_cRptId)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            MsgErro("RPT_ID inv" + CHR(225) + "lido para carregamento.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
                       " FROM SIGCDRLC" + ;
                       " WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResultado < 0
                    MsgErro("Erro ao carregar relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarPorNome - Carrega cabecalho do relatorio por NmReport
    *--------------------------------------------------------------------------
    FUNCTION CarregarPorNome(par_cNmReport)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cNmReport) != "C" OR EMPTY(ALLTRIM(par_cNmReport))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery" + ;
                       " FROM SIGCDRLC" + ;
                       " WHERE NmReport = " + EscaparSQL(ALLTRIM(par_cNmReport))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarPorNome:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarSqlQuery - Carrega apenas o SqlQuery de um relatorio (campo memo)
    *--------------------------------------------------------------------------
    FUNCTION CarregarSqlQuery(par_cRptId)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.
        loc_cQuery   = ""

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            RETURN ""
        ENDIF

        TRY
            IF USED("cursor_4c_SqlQuery")
                USE IN cursor_4c_SqlQuery
            ENDIF

            loc_cSQL = "SELECT SqlQuery FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SqlQuery")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_SqlQuery") > 0
                SELECT cursor_4c_SqlQuery
                loc_cQuery = NVL(SqlQuery, "")
            ENDIF

            IF USED("cursor_4c_SqlQuery")
                USE IN cursor_4c_SqlQuery
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_cQuery
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades this_
    * SEMPRE usa SELECT (par_cAliasCursor) antes de acessar campos
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
            THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
            THIS.this_cDescr       = TratarNulo(Descr,       "C")
            THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
            THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
            THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")

            IF PEMSTATUS(ALIAS() + "", "SqlQuery", 5) OR ;
               AFIELDS(laFields, par_cAliasCursor) > 0
                IF ASCAN(laFields, "SQLQUERY") > 0
                    THIS.this_cSqlQuery = TratarNulo(SqlQuery, "C")
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarDoCursor:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursorCompleto - Mapeia TODOS os campos incluindo SqlQuery
    *--------------------------------------------------------------------------
    FUNCTION CarregarDoCursorCompleto(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF !USED(par_cAliasCursor)
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            THIS.this_cRptId       = TratarNulo(RPT_ID,      "C")
            THIS.this_cNmReport    = TratarNulo(NmReport,    "C")
            THIS.this_cDescr       = TratarNulo(Descr,       "C")
            THIS.this_lAtivo       = (NVL(Ativo, 1) = 1)
            THIS.this_dDtCriacao   = TratarNulo(DtCriacao,   "D")
            THIS.this_dDtAlteracao = TratarNulo(DtAlteracao, "D")
            THIS.this_cSqlQuery    = TratarNulo(SqlQuery,    "C")
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.CarregarDoCursorCompleto:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida campos antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    FUNCTION ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cNmReport))
            MsgAviso("Campo NOME do Report n" + CHR(227) + "o preenchido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cSqlQuery))
            MsgAviso("Campo SQL do Report n" + CHR(227) + "o preenchido!", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - INSERT INTO SIGCDRLC (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cRptId
        loc_lSucesso = .F.

        TRY
            *-- Gerar RPT_ID unico no formato original
            loc_cRptId = THIS.GerarRptId()
            THIS.this_cRptId      = loc_cRptId
            THIS.this_dDtCriacao  = DATE()
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "INSERT INTO SIGCDRLC" + ;
                       " (RPT_ID, NmReport, Descr, Ativo, DtCriacao, DtAlteracao, SqlQuery)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cRptId) + ", " + ;
                       EscaparSQL(THIS.this_cNmReport) + ", " + ;
                       EscaparSQL(THIS.this_cDescr) + ", " + ;
                       IIF(THIS.this_lAtivo, "1", "0") + ", " + ;
                       FormatarDataSQL(THIS.this_dDtCriacao) + ", " + ;
                       FormatarDataSQL(THIS.this_dDtAlteracao) + ", " + ;
                       EscaparSQL(THIS.this_cSqlQuery) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE SIGCDRLC (PROTECTED)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cRptId))
            MsgErro("RPT_ID n" + CHR(227) + "o definido para atualiza" + CHR(231) + CHR(227) + "o.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                       " NmReport = " + EscaparSQL(THIS.this_cNmReport) + "," + ;
                       " Descr = " + EscaparSQL(THIS.this_cDescr) + "," + ;
                       " Ativo = " + IIF(THIS.this_lAtivo, "1", "0") + "," + ;
                       " DtAlteracao = " + FormatarDataSQL(THIS.this_dDtAlteracao) + "," + ;
                       " SqlQuery = " + EscaparSQL(THIS.this_cSqlQuery) + ;
                       " WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE de SIGCDRLD + SIGCDRLC (PROTECTED)
    * Ordem obrigatoria: SIGCDRLD primeiro (filhos), depois SIGCDRLC (pai)
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(THIS.this_cRptId))
            MsgErro("RPT_ID n" + CHR(227) + "o definido para exclus" + CHR(227) + "o.", "Erro")
            RETURN .F.
        ENDIF

        TRY
            *-- 1. Excluir detalhes/layout FRX (SIGCDRLD) - filhos primeiro
            loc_cSQL = "DELETE FROM SIGCDRLD WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir detalhes do relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- 2. Excluir cabecalho (SIGCDRLC) - pai depois
            loc_cSQL = "DELETE FROM SIGCDRLC WHERE RPT_ID = " + EscaparSQL(THIS.this_cRptId)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * SalvarSqlQuery - Atualiza apenas o campo SqlQuery de um relatorio existente
    * Chamado pelo editor SQL quando o usuario edita a query sem alterar outros campos
    *--------------------------------------------------------------------------
    FUNCTION SalvarSqlQuery(par_cRptId, par_cSqlQuery)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cRptId) != "C" OR EMPTY(ALLTRIM(par_cRptId))
            RETURN .F.
        ENDIF

        TRY
            THIS.this_dDtAlteracao = DATE()

            loc_cSQL = "UPDATE SIGCDRLC SET" + ;
                       " SqlQuery = " + EscaparSQL(par_cSqlQuery) + "," + ;
                       " DtAlteracao = " + FormatarDataSQL(THIS.this_dDtAlteracao) + ;
                       " WHERE RPT_ID = " + EscaparSQL(ALLTRIM(par_cRptId))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao salvar SQL do relat" + CHR(243) + "rio:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.SalvarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * ExecutarSqlQuery - Executa o SqlQuery e retorna cursor com resultado
    * Usado pelo editor SQL para pre-visualizar resultados
    *--------------------------------------------------------------------------
    FUNCTION ExecutarSqlQuery(par_cSqlQuery, par_cCursorDestino)
        LOCAL loc_nResultado, loc_lSucesso, loc_cCursor
        loc_lSucesso = .F.
        loc_cCursor  = IIF(VARTYPE(par_cCursorDestino) = "C" AND !EMPTY(par_cCursorDestino), ;
                           par_cCursorDestino, "cursor_4c_SqlResult")

        IF VARTYPE(par_cSqlQuery) != "C" OR EMPTY(ALLTRIM(par_cSqlQuery))
            MsgAviso("SQL n" + CHR(227) + "o informado.", "Aten" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        TRY
            IF USED(loc_cCursor)
                USE IN (loc_cCursor)
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, ALLTRIM(par_cSqlQuery), loc_cCursor)

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao executar SQL:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.ExecutarSqlQuery:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarTabelasSqlServer - Lista tabelas do banco para o editor SQL (F8)
    *--------------------------------------------------------------------------
    FUNCTION BuscarTabelasSqlServer()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Tabelas")
                USE IN cursor_4c_Tabelas
            ENDIF

            loc_cSQL = "SELECT UPPER(Name) AS NmTable, Object_ID, Modify_Date" + ;
                       " FROM sys.tables" + ;
                       " ORDER BY Name"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tabelas")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar tabelas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.BuscarTabelasSqlServer:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarColunasDaTabela - Lista colunas de uma tabela especifica (F9)
    *--------------------------------------------------------------------------
    FUNCTION BuscarColunasDaTabela(par_cNomeTabela)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF VARTYPE(par_cNomeTabela) != "C" OR EMPTY(ALLTRIM(par_cNomeTabela))
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_Colunas")
                USE IN cursor_4c_Colunas
            ENDIF

            loc_cSQL = "SELECT c.Column_ID, c.Name AS Column_Name, t.Name AS Type, c.Max_Length" + ;
                       " FROM sys.all_Columns c" + ;
                       " JOIN sys.types t ON t.System_Type_ID = c.System_Type_ID" + ;
                       " WHERE c.Object_ID = OBJECT_ID(" + EscaparSQL(ALLTRIM(par_cNomeTabela)) + ")" + ;
                       " ORDER BY c.Column_ID"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Colunas")

            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar colunas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em RPTBO.BuscarColunasDaTabela:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

ENDDEFINE

