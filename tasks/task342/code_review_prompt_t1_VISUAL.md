# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)

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

### FORM (C:\4c\projeto\app\forms\cadastros\Formacg.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1661 linhas total):

*-- Linhas 73 a 88:
73:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
74:         WITH THIS.pgf_4c_Paginas
75:             .PageCount = 2
76:             .Top       = -29
77:             .Left      = 0
78:             .Width     = 1000
79:             .Height    = 629
80:             .Tabs      = .F.
81:             .Page1.Caption = "Lista"
82:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
83:             .Page2.Caption = "Dados"
84:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
85:         ENDWITH
86:     ENDPROC
87: 
88:     *==========================================================================

*-- Linhas 95 a 127:
95:         *-- Cabecalho cinza (sombra + titulo)
96:         loc_oP1.AddObject("cnt_4c_Cabecalho", "Container")
97:         WITH loc_oP1.cnt_4c_Cabecalho
98:             .Top       = 31
99:             .Left      = 0
100:             .Width     = 1000
101:             .Height    = 85
102:             .BackStyle = 1
103:             .BackColor = RGB(215,215,215)
104:             .BorderWidth = 0
105:             .Visible   = .T.
106:         ENDWITH
107:         loc_oP1.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
108:         WITH loc_oP1.cnt_4c_Cabecalho.lbl_4c_Sombra
109:             .Caption   = ""
110:             .Top       = 0
111:             .Left      = 0
112:             .Width     = 1000
113:             .Height    = 85
114:             .AutoSize  = .F.
115:             .BackStyle = 1
116:             .BackColor = RGB(215,215,215)
117:         ENDWITH
118:         loc_oP1.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
119:         WITH loc_oP1.cnt_4c_Cabecalho.lbl_4c_Titulo
120:             .Caption   = "Acesso de Grupos"
121:             .Top       = 30
122:             .Left      = 10
123:             .Width     = 500
124:             .Height    = 25
125:             .AutoSize  = .F.
126:             .FontName  = "Tahoma"
127:             .FontSize  = 14

*-- Linhas 133 a 346:
133:         *-- Container botoes CRUD (Incluir, Alterar, Excluir, Buscar, Copiar)
134:         loc_oP1.AddObject("cnt_4c_Botoes", "Container")
135:         WITH loc_oP1.cnt_4c_Botoes
136:             .Top       = 29
137:             .Left      =  542
138:             .Width     = 465
139:             .Height    = 85
140:             .BackStyle = 0
141:             .BorderWidth = 0
142:             .Visible   = .T.
143:         ENDWITH
144: 
145:         loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Incluir", "CommandButton")
146:         WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Incluir
147:             .Caption         = "Incluir"
148:             .Left            = 5
149:             .Top             = 5
150:             .Width           = 75
151:             .Height          = 75
152:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
153:             .PicturePosition = 13
154:             .FontName        = "Tahoma"
155:             .FontSize        = 8
156:             .Themes          = .F.
157:             .SpecialEffect   = 0
158:             .BackColor       = RGB(255,255,255)
159:             .ForeColor       = RGB(90,90,90)
160:             .Visible         = .T.
161:         ENDWITH
162:         BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
163: 
164:         loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Alterar", "CommandButton")
165:         WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Alterar
166:             .Caption         = "Alterar"
167:             .Left            = 85
168:             .Top             = 5
169:             .Width           = 75
170:             .Height          = 75
171:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
172:             .PicturePosition = 13
173:             .FontName        = "Tahoma"
174:             .FontSize        = 8
175:             .Themes          = .F.
176:             .SpecialEffect   = 0
177:             .BackColor       = RGB(255,255,255)
178:             .ForeColor       = RGB(90,90,90)
179:             .Visible         = .T.
180:         ENDWITH
181:         BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
182: 
183:         loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Excluir", "CommandButton")
184:         WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Excluir
185:             .Caption         = "Excluir"
186:             .Left            = 165
187:             .Top             = 5
188:             .Width           = 75
189:             .Height          = 75
190:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
191:             .PicturePosition = 13
192:             .FontName        = "Tahoma"
193:             .FontSize        = 8
194:             .Themes          = .F.
195:             .SpecialEffect   = 0
196:             .BackColor       = RGB(255,255,255)
197:             .ForeColor       = RGB(90,90,90)
198:             .Visible         = .T.
199:         ENDWITH
200:         BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
201: 
202:         loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_Buscar", "CommandButton")
203:         WITH loc_oP1.cnt_4c_Botoes.cmd_4c_Buscar
204:             .Caption         = "Buscar"
205:             .Left            = 245
206:             .Top             = 5
207:             .Width           = 75
208:             .Height          = 75
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
210:             .PicturePosition = 13
211:             .FontName        = "Tahoma"
212:             .FontSize        = 8
213:             .Themes          = .F.
214:             .SpecialEffect   = 0
215:             .BackColor       = RGB(255,255,255)
216:             .ForeColor       = RGB(90,90,90)
217:             .Visible         = .T.
218:         ENDWITH
219:         BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
220: 
221:         loc_oP1.cnt_4c_Botoes.AddObject("cmd_4c_CopiarAcesso", "CommandButton")
222:         WITH loc_oP1.cnt_4c_Botoes.cmd_4c_CopiarAcesso
223:             .Caption         = "Copiar" + CHR(13) + "Acessos"
224:             .Left            = 325
225:             .Top             = 5
226:             .Width           = 75
227:             .Height          = 75
228:             .Picture         = gc_4c_CaminhoIcones + "geral_copiar_26.jpg"
229:             .PicturePosition = 13
230:             .FontName        = "Tahoma"
231:             .FontSize        = 8
232:             .Themes          = .F.
233:             .SpecialEffect   = 0
234:             .BackColor       = RGB(255,255,255)
235:             .ForeColor       = RGB(90,90,90)
236:             .Visible         = .T.
237:         ENDWITH
238:         BINDEVENT(loc_oP1.cnt_4c_Botoes.cmd_4c_CopiarAcesso, "Click", THIS, "BtnCopiarAcessoClick")
239: 
240:         *-- Painel de copia (oculto por padrao - ativado por BtnCopiarAcessoClick)
241:         loc_oP1.AddObject("cnt_4c_PainelCopia", "Container")
242:         WITH loc_oP1.cnt_4c_PainelCopia
243:             .Top       = 29
244:             .Left      = 480
245:             .Width     = 430
246:             .Height    = 85
247:             .BackStyle = 1
248:             .BackColor = RGB(235,235,255)
249:             .BorderWidth = 1
250:             .Visible   = .F.
251:         ENDWITH
252:         loc_oP1.cnt_4c_PainelCopia.AddObject("lbl_4c_CopiarDe", "Label")
253:         WITH loc_oP1.cnt_4c_PainelCopia.lbl_4c_CopiarDe
254:             .Caption   = "Copiar do Grupo:"
255:             .Top       = 10
256:             .Left      = 10
257:             .Width     = 120
258:             .Height    = 17
259:             .AutoSize  = .F.
260:             .FontName  = "Tahoma"
261:             .FontSize  = 8
262:             .BackStyle = 0
263:             .ForeColor = RGB(60,60,60)
264:         ENDWITH
265:         loc_oP1.cnt_4c_PainelCopia.AddObject("txt_4c_GrupoOrigem", "TextBox")
266:         WITH loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem
267:             .Top           = 30
268:             .Left          = 10
269:             .Width         = 120
270:             .Height        = 23
271:             .MaxLength     = 10
272:             .Value         = ""
273:             .FontName      = "Tahoma"
274:             .FontSize      = 8
275:             .BorderStyle   = 1
276:             .SpecialEffect = 1
277:             .BackColor     = RGB(255,255,255)
278:         ENDWITH
279:         BINDEVENT(loc_oP1.cnt_4c_PainelCopia.txt_4c_GrupoOrigem, "KeyPress", THIS, "TxtGrupoOrigemValid")
280:         loc_oP1.cnt_4c_PainelCopia.AddObject("cmd_4c_CopiarOk", "CommandButton")
281:         WITH loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarOk
282:             .Caption = "Copiar"
283:             .Left    = 145
284:             .Top     = 18
285:             .Width   = 75
286:             .Height  = 50
287:             .FontName = "Tahoma"
288:             .FontSize = 8
289:             .Themes  = .T.
290:             .Visible = .T.
291:         ENDWITH
292:         BINDEVENT(loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarOk, "Click", THIS, "BtnCopiarOkClick")
293:         loc_oP1.cnt_4c_PainelCopia.AddObject("cmd_4c_CopiarCancelar", "CommandButton")
294:         WITH loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarCancelar
295:             .Caption = "Cancelar"
296:             .Left    = 235
297:             .Top     = 18
298:             .Width   = 75
299:             .Height  = 50
300:             .FontName = "Tahoma"
301:             .FontSize = 8
302:             .Themes  = .T.
303:             .Visible = .T.
304:         ENDWITH
305:         BINDEVENT(loc_oP1.cnt_4c_PainelCopia.cmd_4c_CopiarCancelar, "Click", THIS, "BtnCopiarCancelarClick")
306: 
307:         *-- Container Saida canonico (Left=917, Width=90)
308:         loc_oP1.AddObject("cnt_4c_Saida", "Container")
309:         WITH loc_oP1.cnt_4c_Saida
310:             .Top       = 29
311:             .Left      = 917
312:             .Width     = 90
313:             .Height    = 85
314:             .BackStyle = 0
315:             .BorderWidth = 0
316:             .Visible   = .T.
317:         ENDWITH
318:         loc_oP1.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
319:         WITH loc_oP1.cnt_4c_Saida.cmd_4c_Encerrar
320:             .Caption         = "Encerrar"
321:             .Left            = 5
322:             .Top             = 5
323:             .Width           = 75
324:             .Height          = 75
325:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
326:             .PicturePosition = 13
327:             .FontName        = "Tahoma"
328:             .FontSize        = 8
329:             .Themes          = .F.
330:             .SpecialEffect   = 0
331:             .BackColor       = RGB(255,255,255)
332:             .ForeColor       = RGB(90,90,90)
333:             .Visible         = .T.
334:         ENDWITH
335:         BINDEVENT(loc_oP1.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
336: 
337:         *-- Grid principal
338:         loc_oP1.AddObject("grd_4c_Lista", "Grid")
339:         WITH loc_oP1.grd_4c_Lista
340:             .Top             = 121
341:             .Left            = 12
342:             .Width           = 976
343:             .Height          = 455
344:             .ColumnCount     = 2
345:             .RecordSourceType = 1
346:             .ReadOnly        = .T.

*-- Linhas 354 a 364:
354:             .GridLineColor   = RGB(238,238,238)
355:             .Visible         = .T.
356:             .Column1.Width   = 120
357:             .Column1.Header1.Caption = ""
358:             .Column2.Width   = 500
359:             .Column2.Header1.Caption = ""
360:         ENDWITH
361: 
362:         THIS.TornarControlesVisiveis(loc_oP1)
363:         loc_oP1.cnt_4c_PainelCopia.Visible = .F.
364:     ENDPROC

*-- Linhas 373 a 405:
373:         *-- Cabecalho cinza
374:         loc_oP2.AddObject("cnt_4c_Cabecalho", "Container")
375:         WITH loc_oP2.cnt_4c_Cabecalho
376:             .Top       = 29
377:             .Left      = 0
378:             .Width     = 1000
379:             .Height    = 85
380:             .BackStyle = 1
381:             .BackColor = RGB(215,215,215)
382:             .BorderWidth = 0
383:             .Visible   = .T.
384:         ENDWITH
385:         loc_oP2.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
386:         WITH loc_oP2.cnt_4c_Cabecalho.lbl_4c_Sombra
387:             .Caption   = ""
388:             .Top       = 0
389:             .Left      = 0
390:             .Width     = 1000
391:             .Height    = 85
392:             .AutoSize  = .F.
393:             .BackStyle = 1
394:             .BackColor = RGB(215,215,215)
395:         ENDWITH
396:         loc_oP2.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
397:         WITH loc_oP2.cnt_4c_Cabecalho.lbl_4c_Titulo
398:             .Caption   = "Acesso de Grupos - Dados"
399:             .Top       = 30
400:             .Left      = 10
401:             .Width     = 500
402:             .Height    = 25
403:             .AutoSize  = .F.
404:             .FontName  = "Tahoma"
405:             .FontSize  = 14

*-- Linhas 411 a 482:
411:         *-- Botoes Salvar/Cancelar (sobrepostos ao cabecalho, lado direito)
412:         loc_oP2.AddObject("cnt_4c_BotoesDados", "Container")
413:         WITH loc_oP2.cnt_4c_BotoesDados
414:             .Top       = 29
415:             .Left      = 830
416:             .Width     = 170
417:             .Height    = 85
418:             .BackStyle = 0
419:             .BorderWidth = 0
420:             .Visible   = .T.
421:         ENDWITH
422:         loc_oP2.cnt_4c_BotoesDados.AddObject("cmd_4c_Salvar", "CommandButton")
423:         WITH loc_oP2.cnt_4c_BotoesDados.cmd_4c_Salvar
424:             .Caption         = "Salvar"
425:             .Left            = 5
426:             .Top             = 5
427:             .Width           = 75
428:             .Height          = 75
429:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
430:             .PicturePosition = 13
431:             .FontName        = "Tahoma"
432:             .FontSize        = 8
433:             .Themes          = .F.
434:             .SpecialEffect   = 0
435:             .BackColor       = RGB(255,255,255)
436:             .ForeColor       = RGB(90,90,90)
437:             .Visible         = .T.
438:         ENDWITH
439:         BINDEVENT(loc_oP2.cnt_4c_BotoesDados.cmd_4c_Salvar, "Click", THIS, "BtnSalvarClick")
440:         loc_oP2.cnt_4c_BotoesDados.AddObject("cmd_4c_Cancelar", "CommandButton")
441:         WITH loc_oP2.cnt_4c_BotoesDados.cmd_4c_Cancelar
442:             .Caption         = "Encerrar"
443:             .Left            = 85
444:             .Top             = 5
445:             .Width           = 75
446:             .Height          = 75
447:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
448:             .PicturePosition = 13
449:             .FontName        = "Tahoma"
450:             .FontSize        = 8
451:             .Themes          = .F.
452:             .SpecialEffect   = 0
453:             .BackColor       = RGB(255,255,255)
454:             .ForeColor       = RGB(90,90,90)
455:             .Visible         = .T.
456:         ENDWITH
457:         BINDEVENT(loc_oP2.cnt_4c_BotoesDados.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
458: 
459:         *-- Campo Grupo
460:         loc_oP2.AddObject("lbl_4c_Grupo", "Label")
461:         WITH loc_oP2.lbl_4c_Grupo
462:             .Caption   = "Grupo:"
463:             .Top       = 126
464:             .Left      = 200
465:             .Width     = 50
466:             .Height    = 17
467:             .AutoSize  = .F.
468:             .FontName  = "Tahoma"
469:             .FontSize  = 8
470:             .BackStyle = 0
471:             .ForeColor = RGB(60,60,60)
472:             .Alignment = 1
473:         ENDWITH
474:         loc_oP2.AddObject("txt_4c_Grupo", "TextBox")
475:         WITH loc_oP2.txt_4c_Grupo
476:             .Top           = 122
477:             .Left          = 255
478:             .Width         = 100
479:             .Height        = 23
480:             .MaxLength     = 10
481:             .Value         = ""
482:             .FontName      = "Tahoma"

*-- Linhas 489 a 514:
489:         ENDWITH
490: 
491:         *-- Campo NomeCompleto
492:         loc_oP2.AddObject("lbl_4c_NomeCompleto", "Label")
493:         WITH loc_oP2.lbl_4c_NomeCompleto
494:             .Caption   = "Nome:"
495:             .Top       = 126
496:             .Left      = 375
497:             .Width     = 45
498:             .Height    = 17
499:             .AutoSize  = .F.
500:             .FontName  = "Tahoma"
501:             .FontSize  = 8
502:             .BackStyle = 0
503:             .ForeColor = RGB(60,60,60)
504:             .Alignment = 1
505:         ENDWITH
506:         loc_oP2.AddObject("txt_4c_NomeCompleto", "TextBox")
507:         WITH loc_oP2.txt_4c_NomeCompleto
508:             .Top           = 122
509:             .Left          = 425
510:             .Width         = 280
511:             .Height        = 23
512:             .MaxLength     = 30
513:             .Value         = ""
514:             .FontName      = "Tahoma"

*-- Linhas 523 a 540:
523:         *-- Inner PageFrame com 4 abas (COM tabs visiveis)
524:         loc_oP2.AddObject("pgf_4c_Abas", "PageFrame")
525:         WITH loc_oP2.pgf_4c_Abas
526:             .Top       = 151
527:             .Left      = 0
528:             .Width     = 1000
529:             .Height    = 465
530:             .PageCount = 4
531:             .Tabs      = .T.
532:             .Page1.Caption = "Usu" + CHR(225) + "rios"
533:             .Page2.Caption = "Programas"
534:             .Page3.Caption = "Barra de Ferramentas"
535:             .Page4.Caption = "Acesso a Telas"
536:             .Visible   = .T.
537:         ENDWITH
538: 
539:         THIS.ConfigurarAbaUsuarios()
540:         THIS.ConfigurarAbaProgramas()

*-- Linhas 551 a 734:
551:         LOCAL loc_oAba
552:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
553: 
554:         loc_oAba.AddObject("lbl_4c_Disponiveis", "Label")
555:         WITH loc_oAba.lbl_4c_Disponiveis
556:             .Caption  = "Usu" + CHR(225) + "rios Dispon" + CHR(237) + "veis"
557:             .Top      = 8
558:             .Left     = 80
559:             .Width    = 200
560:             .Height   = 17
561:             .AutoSize = .F.
562:             .FontName = "Tahoma"
563:             .FontSize = 8
564:             .FontBold = .T.
565:             .BackStyle = 0
566:             .ForeColor = RGB(60,60,60)
567:         ENDWITH
568: 
569:         loc_oAba.AddObject("lbx_4c_Disponiveis", "ListBox")
570:         WITH loc_oAba.lbx_4c_Disponiveis
571:             .Top           = 28
572:             .Left          = 80
573:             .Width         = 200
574:             .Height        = 350
575:             .MultiSelect   = .T.
576:             .RowSourceType = 0
577:             .FontName      = "Tahoma"
578:             .FontSize      = 8
579:             .Visible       = .T.
580:         ENDWITH
581:         BINDEVENT(loc_oAba.lbx_4c_Disponiveis, "Click", THIS, "LbxDisponiveisClick")
582: 
583:         loc_oAba.AddObject("lbl_4c_StatusDisp", "Label")
584:         WITH loc_oAba.lbl_4c_StatusDisp
585:             .Caption   = ""
586:             .Top       = 382
587:             .Left      = 80
588:             .Width     = 200
589:             .Height    = 17
590:             .AutoSize  = .F.
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8
593:             .BackStyle = 0
594:             .ForeColor = RGB(0,128,0)
595:         ENDWITH
596: 
597:         *-- Botoes de transferencia
598:         loc_oAba.AddObject("cmd_4c_AddUsu", "CommandButton")
599:         WITH loc_oAba.cmd_4c_AddUsu
600:             .Caption     = CHR(187)
601:             .Top         = 75
602:             .Left        = 295
603:             .Width       = 45
604:             .Height      = 30
605:             .FontName    = "Tahoma"
606:             .FontSize    = 10
607:             .FontBold    = .T.
608:             .Themes      = .T.
609:             .Visible     = .T.
610:             .ToolTipText = "Adicionar selecionados"
611:         ENDWITH
612:         BINDEVENT(loc_oAba.cmd_4c_AddUsu, "Click", THIS, "BtnAddUsuClick")
613: 
614:         loc_oAba.AddObject("cmd_4c_AddAllUsu", "CommandButton")
615:         WITH loc_oAba.cmd_4c_AddAllUsu
616:             .Caption     = CHR(187) + CHR(187)
617:             .Top         = 120
618:             .Left        = 295
619:             .Width       = 45
620:             .Height      = 30
621:             .FontName    = "Tahoma"
622:             .FontSize    = 10
623:             .FontBold    = .T.
624:             .Themes      = .T.
625:             .Visible     = .T.
626:             .ToolTipText = "Adicionar todos"
627:         ENDWITH
628:         BINDEVENT(loc_oAba.cmd_4c_AddAllUsu, "Click", THIS, "BtnAddAllUsuClick")
629: 
630:         loc_oAba.AddObject("cmd_4c_RemUsu", "CommandButton")
631:         WITH loc_oAba.cmd_4c_RemUsu
632:             .Caption     = CHR(171)
633:             .Top         = 170
634:             .Left        = 295
635:             .Width       = 45
636:             .Height      = 30
637:             .FontName    = "Tahoma"
638:             .FontSize    = 10
639:             .FontBold    = .T.
640:             .Themes      = .T.
641:             .Visible     = .T.
642:             .ToolTipText = "Remover selecionados"
643:         ENDWITH
644:         BINDEVENT(loc_oAba.cmd_4c_RemUsu, "Click", THIS, "BtnRemUsuClick")
645: 
646:         loc_oAba.AddObject("cmd_4c_RemAllUsu", "CommandButton")
647:         WITH loc_oAba.cmd_4c_RemAllUsu
648:             .Caption     = CHR(171) + CHR(171)
649:             .Top         = 215
650:             .Left        = 295
651:             .Width       = 45
652:             .Height      = 30
653:             .FontName    = "Tahoma"
654:             .FontSize    = 10
655:             .FontBold    = .T.
656:             .Themes      = .T.
657:             .Visible     = .T.
658:             .ToolTipText = "Remover todos"
659:         ENDWITH
660:         BINDEVENT(loc_oAba.cmd_4c_RemAllUsu, "Click", THIS, "BtnRemAllUsuClick")
661: 
662:         loc_oAba.AddObject("lbl_4c_Selecionados", "Label")
663:         WITH loc_oAba.lbl_4c_Selecionados
664:             .Caption  = "Usu" + CHR(225) + "rios do Grupo"
665:             .Top      = 8
666:             .Left     = 356
667:             .Width    = 200
668:             .Height   = 17
669:             .AutoSize = .F.
670:             .FontName = "Tahoma"
671:             .FontSize = 8
672:             .FontBold = .T.
673:             .BackStyle = 0
674:             .ForeColor = RGB(60,60,60)
675:         ENDWITH
676: 
677:         loc_oAba.AddObject("lbx_4c_Selecionados", "ListBox")
678:         WITH loc_oAba.lbx_4c_Selecionados
679:             .Top           = 28
680:             .Left          = 356
681:             .Width         = 200
682:             .Height        = 350
683:             .MultiSelect   = .T.
684:             .RowSourceType = 0
685:             .FontName      = "Tahoma"
686:             .FontSize      = 8
687:             .Visible       = .T.
688:         ENDWITH
689:         BINDEVENT(loc_oAba.lbx_4c_Selecionados, "Click", THIS, "LbxSelecionadosClick")
690: 
691:         loc_oAba.AddObject("lbl_4c_StatusSel", "Label")
692:         WITH loc_oAba.lbl_4c_StatusSel
693:             .Caption   = ""
694:             .Top       = 382
695:             .Left      = 356
696:             .Width     = 200
697:             .Height    = 17
698:             .AutoSize  = .F.
699:             .FontName  = "Tahoma"
700:             .FontSize  = 8
701:             .BackStyle = 0
702:             .ForeColor = RGB(0,128,0)
703:         ENDWITH
704:     ENDPROC
705: 
706:     *==========================================================================
707:     * ConfigurarAbaProgramas - Page2 interna: grid de programas com checkbox
708:     *==========================================================================
709:     PROTECTED PROCEDURE ConfigurarAbaProgramas()
710:         LOCAL loc_oAba, loc_oGrid
711:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2
712: 
713:         loc_oAba.AddObject("lbl_4c_FiltroAcesso", "Label")
714:         WITH loc_oAba.lbl_4c_FiltroAcesso
715:             .Caption   = "Filtro:"
716:             .Top       = 10
717:             .Left      = 10
718:             .Width     = 45
719:             .Height    = 17
720:             .AutoSize  = .F.
721:             .FontName  = "Tahoma"
722:             .FontSize  = 8
723:             .BackStyle = 0
724:             .ForeColor = RGB(60,60,60)
725:         ENDWITH
726:         loc_oAba.AddObject("txt_4c_FiltroAcesso", "TextBox")
727:         WITH loc_oAba.txt_4c_FiltroAcesso
728:             .Top           = 7
729:             .Left          = 60
730:             .Width         = 300
731:             .Height        = 23
732:             .Value         = ""
733:             .FontName      = "Tahoma"
734:             .FontSize      = 8

*-- Linhas 741 a 750:
741:         loc_oAba.AddObject("grd_4c_Programas", "Grid")
742:         loc_oGrid = loc_oAba.grd_4c_Programas
743:         WITH loc_oGrid
744:             .Top              = 35
745:             .Left             = 5
746:             .Width            = 990
747:             .Height           = 400
748:             .ColumnCount      = 4
749:             .RecordSourceType = 1
750:             .ReadOnly         = .F.

*-- Linhas 759 a 783:
759:             .Visible          = .T.
760:             .Column1.Width    = 380
761:             .Column1.ReadOnly = .T.
762:             .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
763:             .Column2.Width    = 120
764:             .Column2.ReadOnly = .T.
765:             .Column2.Header1.Caption = "Programa"
766:             .Column3.Width    = 65
767:             .Column3.ReadOnly = .F.
768:             .Column3.Sparse   = .F.
769:             .Column3.Header1.Caption = ""
770:             .Column4.Width    = 120
771:             .Column4.ReadOnly = .T.
772:             .Column4.Header1.Caption = "Parametro"
773:         ENDWITH
774:         WITH loc_oGrid.Column3
775:             .AddObject("chk_4c_Marcas", "CheckBox")
776:         ENDWITH
777:         WITH loc_oGrid.Column3.chk_4c_Marcas
778:             .Caption   = ""
779:             .Width     = 60
780:             .Height    = 17
781:             .BackStyle = 0
782:             .Themes    = .F.
783:         ENDWITH

*-- Linhas 794 a 803:
794:         loc_oAba.AddObject("grd_4c_Barra", "Grid")
795:         loc_oGrid = loc_oAba.grd_4c_Barra
796:         WITH loc_oGrid
797:             .Top              = 10
798:             .Left             = 5
799:             .Width            = 990
800:             .Height           = 430
801:             .ColumnCount      = 2
802:             .RecordSourceType = 1
803:             .ReadOnly         = .F.

*-- Linhas 812 a 830:
812:             .Visible          = .T.
813:             .Column1.Width    = 550
814:             .Column1.ReadOnly = .T.
815:             .Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
816:             .Column2.Width    = 80
817:             .Column2.ReadOnly = .F.
818:             .Column2.Sparse   = .F.
819:             .Column2.Header1.Caption = ""
820:         ENDWITH
821:         WITH loc_oGrid.Column2
822:             .AddObject("chk_4c_SelBarras", "CheckBox")
823:         ENDWITH
824:         WITH loc_oGrid.Column2.chk_4c_SelBarras
825:             .Caption   = ""
826:             .Width     = 75
827:             .Height    = 17
828:             .BackStyle = 0
829:             .Themes    = .F.
830:         ENDWITH

*-- Linhas 841 a 850:
841:         loc_oAba.AddObject("grd_4c_Telas", "Grid")
842:         loc_oGrid = loc_oAba.grd_4c_Telas
843:         WITH loc_oGrid
844:             .Top              = 10
845:             .Left             = 5
846:             .Width            = 990
847:             .Height           = 430
848:             .ColumnCount      = 3
849:             .RecordSourceType = 1
850:             .ReadOnly         = .F.

*-- Linhas 859 a 880:
859:             .Visible          = .T.
860:             .Column1.Width    = 280
861:             .Column1.ReadOnly = .T.
862:             .Column1.Header1.Caption = "Tela"
863:             .Column2.Width    = 250
864:             .Column2.ReadOnly = .T.
865:             .Column2.Header1.Caption = "Campo"
866:             .Column3.Width    = 80
867:             .Column3.ReadOnly = .F.
868:             .Column3.Sparse   = .F.
869:             .Column3.Header1.Caption = "Status"
870:         ENDWITH
871:         WITH loc_oGrid.Column3
872:             .AddObject("chk_4c_Status", "CheckBox")
873:         ENDWITH
874:         WITH loc_oGrid.Column3.chk_4c_Status
875:             .Caption   = ""
876:             .Width     = 75
877:             .Height    = 17
878:             .BackStyle = 0
879:             .Themes    = .F.
880:         ENDWITH

*-- Linhas 894 a 903:
894:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
895:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Grupos"
896:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.NComps"
897:                 loc_oGrid.Column1.Header1.Caption = ""
898:                 loc_oGrid.Column2.Header1.Caption = ""
899:                 loc_oGrid.Column1.Width = 120
900:                 loc_oGrid.Column2.Width = 500
901:                 loc_oGrid.FontName = "Tahoma"
902:                 loc_oGrid.FontSize = 8
903:                 loc_oGrid.Refresh()

*-- Linhas 936 a 945:
936:             loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
937:             loc_oAba.lbx_4c_Disponiveis.Clear()
938:             loc_oAba.lbx_4c_Selecionados.Clear()
939:             loc_oAba.lbl_4c_StatusDisp.Caption = ""
940:             loc_oAba.lbl_4c_StatusSel.Caption  = ""
941: 
942:             loc_lNovoGrupo = EMPTY(ALLTRIM(par_cGrupos))
943: 
944:             *-- Carregar usuarios do grupo (se grupo existente)
945:             IF !loc_lNovoGrupo

*-- Linhas 992 a 1003:
992:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Programas.Programas"
993:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Programas.Marcas"
994:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Programas.Parametros"
995:                 loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
996:                 loc_oGrid.Column2.Header1.Caption = "Programa"
997:                 loc_oGrid.Column3.Header1.Caption = ""
998:                 loc_oGrid.Column4.Header1.Caption = "Parametro"
999:                 loc_oGrid.Column1.Width = 380
1000:                 loc_oGrid.Column2.Width = 120
1001:                 loc_oGrid.Column3.Width = 65
1002:                 loc_oGrid.Column4.Width = 120
1003:                 loc_oGrid.FontName = "Tahoma"

*-- Linhas 1021 a 1030:
1021:                 loc_oGrid.RecordSource = "TmpBarra"
1022:                 loc_oGrid.Column1.ControlSource = "TmpBarra.Descricaos"
1023:                 loc_oGrid.Column2.ControlSource = "TmpBarra.SelBarras"
1024:                 loc_oGrid.Column1.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1025:                 loc_oGrid.Column2.Header1.Caption = ""
1026:                 loc_oGrid.Column1.Width = 550
1027:                 loc_oGrid.Column2.Width = 80
1028:                 loc_oGrid.FontName = "Tahoma"
1029:                 loc_oGrid.FontSize = 8
1030:                 loc_oGrid.Refresh()

*-- Linhas 1047 a 1057:
1047:                 loc_oGrid.Column1.ControlSource = "crSigAcTel.cDescTelas"
1048:                 loc_oGrid.Column2.ControlSource = "crSigAcTel.cCampos"
1049:                 loc_oGrid.Column3.ControlSource = "crSigAcTel.nStatus"
1050:                 loc_oGrid.Column1.Header1.Caption = "Tela"
1051:                 loc_oGrid.Column2.Header1.Caption = "Campo"
1052:                 loc_oGrid.Column3.Header1.Caption = "Status"
1053:                 loc_oGrid.Column1.Width = 280
1054:                 loc_oGrid.Column2.Width = 250
1055:                 loc_oGrid.Column3.Width = 80
1056:                 loc_oGrid.FontName = "Tahoma"
1057:                 loc_oGrid.FontSize = 8

*-- Linhas 1093 a 1102:
1093:         loc_oP2.txt_4c_NomeCompleto.Value = ""
1094:         loc_oAbas.Page1.lbx_4c_Disponiveis.Clear()
1095:         loc_oAbas.Page1.lbx_4c_Selecionados.Clear()
1096:         loc_oAbas.Page1.lbl_4c_StatusDisp.Caption = ""
1097:         loc_oAbas.Page1.lbl_4c_StatusSel.Caption  = ""
1098:         loc_oAbas.Page2.txt_4c_FiltroAcesso.Value = ""
1099:         loc_oAbas.Page2.grd_4c_Programas.RecordSource = ""
1100:         loc_oAbas.Page3.grd_4c_Barra.RecordSource = ""
1101:         loc_oAbas.Page4.grd_4c_Telas.RecordSource = ""
1102:         THIS.this_cFiltroPrograma = ""

*-- Linhas 1121 a 1136:
1121:     PROTECTED PROCEDURE HabilitarAbaUsuarios(par_lHabilitar)
1122:         LOCAL loc_oAba
1123:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1124:         loc_oAba.cmd_4c_AddUsu.Enabled    = par_lHabilitar
1125:         loc_oAba.cmd_4c_AddAllUsu.Enabled = par_lHabilitar
1126:         loc_oAba.cmd_4c_RemUsu.Enabled    = par_lHabilitar
1127:         loc_oAba.cmd_4c_RemAllUsu.Enabled = par_lHabilitar
1128:     ENDPROC
1129: 
1130:     *==========================================================================
1131:     * HabilitarColunasGrid - Habilita/desabilita colunas de checkbox nos grids
1132:     *==========================================================================
1133:     PROTECTED PROCEDURE HabilitarColunasGrid(par_lHabilitar)
1134:         TRY
1135:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page2.grd_4c_Programas.Column3.ReadOnly = !par_lHabilitar
1136:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page3.grd_4c_Barra.Column2.ReadOnly     = !par_lHabilitar

*-- Linhas 1338 a 1347:
1338:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
1339:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.ControlSource = "cursor_4c_Dados.Grupos"
1340:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.ControlSource = "cursor_4c_Dados.NComps"
1341:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column1.Header1.Caption = ""
1342:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Column2.Header1.Caption = ""
1343:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
1344:             ELSE
1345:                 IF USED("cursor_4c_Busca")
1346:                     USE IN cursor_4c_Busca
1347:                 ENDIF

*-- Linhas 1483 a 1503:
1483:         IF loc_oAba.lbx_4c_Disponiveis.ListIndex > 0
1484:             loc_cUsu    = ALLTRIM(loc_oAba.lbx_4c_Disponiveis.List(loc_oAba.lbx_4c_Disponiveis.ListIndex))
1485:             loc_cStatus = THIS.ObterStatusUsuario(loc_cUsu)
1486:             loc_oAba.lbl_4c_StatusDisp.Caption  = loc_cStatus
1487:             loc_oAba.lbl_4c_StatusDisp.ForeColor = IIF(loc_cStatus = "Inativo", RGB(200,0,0), RGB(0,128,0))
1488:         ENDIF
1489:     ENDPROC
1490: 
1491:     PROCEDURE LbxSelecionadosClick()
1492:         LOCAL loc_oAba, loc_cUsu, loc_cStatus
1493:         loc_oAba = THIS.pgf_4c_Paginas.Page2.pgf_4c_Abas.Page1
1494:         IF loc_oAba.lbx_4c_Selecionados.ListIndex > 0
1495:             loc_cUsu    = ALLTRIM(loc_oAba.lbx_4c_Selecionados.List(loc_oAba.lbx_4c_Selecionados.ListIndex))
1496:             loc_cStatus = THIS.ObterStatusUsuario(loc_cUsu)
1497:             loc_oAba.lbl_4c_StatusSel.Caption  = loc_cStatus
1498:             loc_oAba.lbl_4c_StatusSel.ForeColor = IIF(loc_cStatus = "Inativo", RGB(200,0,0), RGB(0,128,0))
1499:         ENDIF
1500:     ENDPROC
1501: 
1502:     *==========================================================================
1503:     * --- HANDLERS DE TRANSFERENCIA DE USUARIOS ---

*-- Linhas 1576 a 1598:
1576:     ENDPROC
1577: 
1578:     *==========================================================================
1579:     * ChkMarcasWhen - Permite editar checkbox Marcas somente em INCLUIR/ALTERAR
1580:     *==========================================================================
1581:     PROCEDURE ChkMarcasWhen()
1582:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1583:     ENDPROC
1584: 
1585:     *==========================================================================
1586:     * ChkSelBarrasWhen - Permite editar checkbox SelBarras somente em INCLUIR/ALTERAR
1587:     *==========================================================================
1588:     PROCEDURE ChkSelBarrasWhen()
1589:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1590:     ENDPROC
1591: 
1592:     *==========================================================================
1593:     * ChkStatusWhen - Permite editar checkbox nStatus somente em INCLUIR/ALTERAR
1594:     *==========================================================================
1595:     PROCEDURE ChkStatusWhen()
1596:         RETURN INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1597:     ENDPROC
1598: 


### BO (C:\4c\projeto\app\classes\acgBO.prg):
*==============================================================================
* acgBO.prg - Business Object para Acesso de Grupos (SIGCDACG)
* Tabela Principal: sigcdgra (PK: Grupos)
* Tabelas Relacionadas:
*   - sigcdacg (usuarios do grupo)
*   - sigcdacu (acessos de programa por grupo/usuario)
*   - sigcdacb (barra de ferramentas por grupo)
*   - sigactel (acesso a campos em telas por grupo)
*   - sigcdprg (programas disponiveis)
*   - sigcdusu (usuarios cadastrados)
*==============================================================================
SET SAFETY OFF
SET RESOURCE OFF

DEFINE CLASS acgBO AS BusinessBase

    *-- Propriedades: sigcdgra
    this_cGrupos    = ""   && grupos char(10) NOT NULL - PK
    this_cNComps    = ""   && ncomps char(30) NOT NULL - nome do grupo

    *--------------------------------------------------------------------------
    * Init - Configura tabela e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigcdgra"
        THIS.this_cCampoChave = "Grupos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna PK para auditoria (BusinessBase)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN ALLTRIM(THIS.this_cGrupos)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cGrupos = TratarNulo(Grupos, "C")
            THIS.this_cNComps = TratarNulo(NComps, "C")
            loc_lResultado = .T.
        ENDIF
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Busca grupos com filtro opcional para exibir no grid
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra"
            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = loc_cSQL + ;
                    " WHERE Grupos LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
            ENDIF
            loc_cSQL = loc_cSQL + " ORDER BY Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dados")
                    SELECT cursor_4c_Dados
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega grupo pela PK
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cGrupos)
        LOCAL loc_cSQL, loc_lResultado, loc_nResult
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra WHERE Grupos = " + ;
                EscaparSQL(ALLTRIM(par_cGrupos))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Carrega") AND RECCOUNT("cursor_4c_Carrega") > 0
                    loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
                    THIS.this_lNovoRegistro = .F.
                ENDIF
                IF USED("cursor_4c_Carrega")
                    USE IN cursor_4c_Carrega
                ENDIF
            ELSE
                MsgErro("Erro ao carregar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - INSERT sigcdgra (registro principal)
    * Dados relacionados sao salvos separadamente via SalvarUsuarios,
    * SalvarProgramas, SalvarBarra, SalvarAcessoTelas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "INSERT INTO sigcdgra (Grupos, NComps) VALUES (" + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10)) + ", " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cNComps), 30)) + ")"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Ins")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                IF USED("cursor_4c_Ins")
                    USE IN cursor_4c_Ins
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - UPDATE sigcdgra (registro principal)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "UPDATE sigcdgra SET NComps = " + ;
                EscaparSQL(LEFT(ALLTRIM(THIS.this_cNComps), 30)) + ;
                " WHERE Grupos = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                IF USED("cursor_4c_Upd")
                    USE IN cursor_4c_Upd
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - DELETE sigcdgra e todas as tabelas relacionadas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        loc_lResultado = .F.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
        TRY
            *-- Excluir dependencias (ordem importa para FK)
            loc_cSQL = "DELETE FROM sigactel WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del1")
            IF USED("cursor_4c_Del1")
                USE IN cursor_4c_Del1
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacb WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del2")
            IF USED("cursor_4c_Del2")
                USE IN cursor_4c_Del2
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacu WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del3")
            IF USED("cursor_4c_Del3")
                USE IN cursor_4c_Del3
            ENDIF

            loc_cSQL = "DELETE FROM sigcdacg WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del4")
            IF USED("cursor_4c_Del4")
                USE IN cursor_4c_Del4
            ENDIF

            *-- Excluir registro principal
            loc_cSQL = "DELETE FROM sigcdgra WHERE Grupos = " + loc_cGrupoSQL
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del5")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("DELETE")
                IF USED("cursor_4c_Del5")
                    USE IN cursor_4c_Del5
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao excluir grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTodosGrupos - Lista todos os grupos (para listbox de copia)
    * Retorna cursor: cursor_4c_ListaGrupos (Grupos, NComps)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTodosGrupos()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Grupos, NComps FROM sigcdgra ORDER BY Grupos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ListaGrupos")
            IF loc_nResult >= 0
                IF USED("cursor_4c_ListaGrupos")
                    SELECT cursor_4c_ListaGrupos
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar grupos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar grupos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarTodosUsuarios - Lista todos os usuarios do sistema
    * Retorna cursor: cursor_4c_TodosUsuarios (Usuarios, NComps, cAtivos)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarTodosUsuarios()
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT Usuarios, NComps, cAtivos FROM sigcdusu ORDER BY NComps"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TodosUsuarios")
            IF loc_nResult >= 0
                IF USED("cursor_4c_TodosUsuarios")
                    SELECT cursor_4c_TodosUsuarios
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarUsuariosDoGrupo - Carrega usuarios pertencentes ao grupo
    * Retorna cursor: cursor_4c_UsuariosGrupo (Usuarios, NComps, cAtivos)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarUsuariosDoGrupo(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.Usuarios, u.NComps, u.cAtivos" + ;
                " FROM sigcdacg a" + ;
                " LEFT JOIN sigcdusu u ON u.Usuarios = a.Usuarios" + ;
                " WHERE a.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " ORDER BY a.Usuarios"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_UsuariosGrupo")
            IF loc_nResult >= 0
                IF USED("cursor_4c_UsuariosGrupo")
                    SELECT cursor_4c_UsuariosGrupo
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar usu" + CHR(225) + "rios do grupo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar usu" + CHR(225) + "rios do grupo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarProgramas - Carrega programas disponiveis com marcacao do grupo
    * Retorna cursor: cursor_4c_Programas (Descricaos, Programas, Parametros,
    *                 BarraForms, Marcas)
    * Marcas=1: programa ja liberado ao grupo; Marcas=0: nao liberado
    *--------------------------------------------------------------------------
    PROCEDURE CarregarProgramas(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT a.Descricaos, a.Programas, a.Parametros, a.BarraForms," + ;
                " CASE WHEN b.pkchaves IS NOT NULL THEN 1 ELSE 0 END AS Marcas" + ;
                " FROM sigcdprg a" + ;
                " LEFT JOIN sigcdacu b ON b.Programas = a.Programas" + ;
                " AND b.Parametros = a.Parametros" + ;
                " AND b.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " AND b.usuarios = ''" + ;
                " ORDER BY a.Descricaos, a.Programas, a.Parametros"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Programas")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Programas")
                    SELECT cursor_4c_Programas
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar programas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar programas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarBarra - Carrega itens de barra de ferramentas com marcacao do grupo
    * Retorna cursor: TmpBarra (BarraOrdem, Descricaos, BarraForms, Programas,
    *                           Parametros, SelBarras, Usuarios)
    * SelBarras=1: item ativo no grupo; SelBarras=0: inativo
    *--------------------------------------------------------------------------
    PROCEDURE CarregarBarra(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        loc_lResultado = .F.
        TRY
            loc_cSQL = "SELECT DISTINCT a.BarraOrdem, a.Descricaos, a.BarraForms," + ;
                " a.Programas, a.Parametros," + ;
                " CASE WHEN b.pkchaves IS NOT NULL THEN 1 ELSE 0 END AS SelBarras," + ;
                " '' AS Usuarios" + ;
                " FROM sigcdacb a" + ;
                " LEFT JOIN sigcdacb b ON b.Programas = a.Programas" + ;
                " AND b.Parametros = a.Parametros" + ;
                " AND b.grupos = " + EscaparSQL(ALLTRIM(par_cGrupos)) + ;
                " AND b.usuarios = ''" + ;
                " WHERE a.grupos = '' AND a.usuarios = ''" + ;
                " ORDER BY a.BarraOrdem, a.Descricaos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpBarra")
            IF loc_nResult >= 0
                IF USED("TmpBarra")
                    SELECT TmpBarra
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar barra:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar barra:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarAcessoTelas - Carrega controle de acesso a campos nas telas
    * par_cGrupos: codigo do grupo (vazio = inserindo novo, traz template com nStatus=1)
    * Retorna cursor: crSigAcTel (cCodigos, cDescTelas, cCampos, cObjetos,
    *                              cDescCamps, nStatus, Grupos, Usuarios, pkchaves)
    * nStatus=0: campo liberado; nStatus=1: campo bloqueado (default)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarAcessoTelas(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        loc_lResultado = .F.
        loc_cGrupoSQL = EscaparSQL(ALLTRIM(par_cGrupos))
        TRY
            IF EMPTY(ALLTRIM(par_cGrupos))
                *-- Novo grupo: retorna template com todos os campos bloqueados
                loc_cSQL = "SELECT cCodigos, cDescTelas, cCampos, cObjetos, cDescCamps," + ;
                    " 1 AS nStatus, '' AS Grupos, '' AS Usuarios, '' AS pkchaves" + ;
                    " FROM sigactel WHERE grupos = '' AND usuarios = ''" + ;
                    " ORDER BY cCodigos"
            ELSE
                *-- Grupo existente: mostra estado real com defaults bloqueados
                loc_cSQL = "SELECT a.cCodigos, a.cDescTelas, a.cCampos, a.cObjetos, a.cDescCamps," + ;
                    " ISNULL(b.nStatus, 1) AS nStatus," + ;
                    " ISNULL(b.Grupos, '') AS Grupos," + ;
                    " ISNULL(b.Usuarios, '') AS Usuarios," + ;
                    " ISNULL(b.pkchaves, '') AS pkchaves" + ;
                    " FROM sigactel a" + ;
                    " LEFT JOIN sigactel b ON b.cCodigos = a.cCodigos" + ;
                    " AND b.cCampos = a.cCampos" + ;
                    " AND b.grupos = " + loc_cGrupoSQL + ;
                    " AND b.usuarios = ''" + ;
                    " WHERE a.grupos = '' AND a.usuarios = ''" + ;
                    " ORDER BY a.cCodigos"
            ENDIF
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crSigAcTel")
            IF loc_nResult >= 0
                IF USED("crSigAcTel")
                    SELECT crSigAcTel
                    GO TOP
                ENDIF
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao carregar acesso telas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar acesso telas:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarUsuarios - Salva lista de usuarios do grupo (delete + reinsert)
    * par_cGrupos: codigo do grupo
    * par_cCursorUsuarios: cursor com campo Usuarios char(10)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarUsuarios(par_cGrupos, par_cCursorUsuarios)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL, loc_cUsuario
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar usuarios existentes do grupo
            loc_cSQL = "DELETE FROM sigcdacg WHERE grupos = " + loc_cGrupoSQL
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcg")
            IF USED("cursor_4c_DelAcg")
                USE IN cursor_4c_DelAcg
            ENDIF

            *-- Reinserir usuarios selecionados
            IF USED(par_cCursorUsuarios) AND RECCOUNT(par_cCursorUsuarios) > 0
                SELECT (par_cCursorUsuarios)
                GO TOP
                SCAN
                    loc_cUsuario = ALLTRIM(Usuarios)
                    IF !EMPTY(loc_cUsuario)
                        loc_cSQL = "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", " + ;
                            EscaparSQL(LEFT(loc_cUsuario, 10)) + ", " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcg")
                        IF USED("cursor_4c_InsAcg")
                            USE IN cursor_4c_InsAcg
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorUsuarios)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar usu" + CHR(225) + "rios:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarProgramas - Salva acessos de programa do grupo (delete + reinsert)
    * par_cGrupos: codigo do grupo
    * par_cCursorProgramas: cursor com campos Programas, Parametros, Marcas
    *   Marcas=1: programa liberado ao grupo
    *--------------------------------------------------------------------------
    PROCEDURE SalvarProgramas(par_cGrupos, par_cCursorProgramas)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cProg, loc_cParam, loc_nMarcas
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar acessos de programa do grupo (somente nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigcdacu WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcu")
            IF USED("cursor_4c_DelAcu")
                USE IN cursor_4c_DelAcu
            ENDIF

            *-- Reinserir programas selecionados (Marcas=1)
            IF USED(par_cCursorProgramas) AND RECCOUNT(par_cCursorProgramas) > 0
                SELECT (par_cCursorProgramas)
                GO TOP
                SCAN
                    loc_nMarcas = Marcas
                    loc_cProg   = ALLTRIM(Programas)
                    loc_cParam  = ALLTRIM(Parametros)
                    IF loc_nMarcas = 1 AND !EMPTY(loc_cProg)
                        loc_cSQL = "INSERT INTO sigcdacu (grupos, programas, parametros, usuarios, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", " + ;
                            EscaparSQL(LEFT(loc_cProg, 15)) + ", " + ;
                            EscaparSQL(LEFT(loc_cParam, 10)) + ", '', " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcu")
                        IF USED("cursor_4c_InsAcu")
                            USE IN cursor_4c_InsAcu
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorProgramas)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar programas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarBarra - Salva configuracao da barra de ferramentas do grupo
    * par_cGrupos: codigo do grupo
    * par_cCursorBarra: cursor TmpBarra com campos BarraOrdem, Descricaos,
    *   BarraForms, Programas, Parametros, SelBarras
    *   SelBarras=.T./1: item selecionado para o grupo
    *--------------------------------------------------------------------------
    PROCEDURE SalvarBarra(par_cGrupos, par_cCursorBarra)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cDescricaos, loc_cBarraForms, loc_nBarraOrdem
        LOCAL loc_cProg, loc_cParam, loc_lSel
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar barra existente do grupo (nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigcdacb WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcb")
            IF USED("cursor_4c_DelAcb")
                USE IN cursor_4c_DelAcb
            ENDIF

            *-- Reinserir itens selecionados
            IF USED(par_cCursorBarra) AND RECCOUNT(par_cCursorBarra) > 0
                SELECT (par_cCursorBarra)
                GO TOP
                SCAN
                    loc_lSel        = SelBarras
                    loc_cDescricaos = ALLTRIM(Descricaos)
                    loc_cBarraForms = ALLTRIM(BarraForms)
                    loc_nBarraOrdem = BarraOrdem
                    loc_cProg       = ALLTRIM(Programas)
                    loc_cParam      = ALLTRIM(Parametros)
                    IF loc_lSel
                        loc_cSQL = "INSERT INTO sigcdacb" + ;
                            " (grupos, usuarios, descricaos, barraforms, barraordem, programas, parametros, selbarras, pkchaves)" + ;
                            " VALUES (" + loc_cGrupoSQL + ", '', " + ;
                            EscaparSQL(LEFT(loc_cDescricaos, 73)) + ", " + ;
                            EscaparSQL(LEFT(loc_cBarraForms, 50)) + ", " + ;
                            FormatarNumeroSQL(loc_nBarraOrdem) + ", " + ;
                            EscaparSQL(LEFT(loc_cProg, 15)) + ", " + ;
                            EscaparSQL(LEFT(loc_cParam, 10)) + ", 1, " + ;
                            EscaparSQL(fUniqueIds()) + ")"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcb")
                        IF USED("cursor_4c_InsAcb")
                            USE IN cursor_4c_InsAcb
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorBarra)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar barra:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarAcessoTelas - Salva configuracao de acesso a campos nas telas
    * par_cGrupos: codigo do grupo
    * par_cCursorAcTel: cursor crSigAcTel com campos cCodigos, cDescTelas,
    *   cCampos, cObjetos, cDescCamps, nStatus
    *   nStatus=0: campo liberado (salva); nStatus=1: bloqueado (nao salva)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarAcessoTelas(par_cGrupos, par_cCursorAcTel)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado, loc_cGrupoSQL
        LOCAL loc_cCampos, loc_cCodigos, loc_cDescCamps, loc_cDescTelas
        LOCAL loc_cObjetos, loc_nStatus
        loc_lResultado = .T.
        loc_cGrupoSQL = EscaparSQL(LEFT(ALLTRIM(par_cGrupos), 10))
        TRY
            *-- Deletar registros existentes do grupo (nivel grupo, usuarios='')
            loc_cSQL = "DELETE FROM sigactel WHERE grupos = " + loc_cGrupoSQL + ;
                " AND usuarios = ''"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelAcTel")
            IF USED("cursor_4c_DelAcTel")
                USE IN cursor_4c_DelAcTel
            ENDIF

            *-- Reinserir apenas campos liberados (nStatus=0)
            IF USED(par_cCursorAcTel) AND RECCOUNT(par_cCursorAcTel) > 0
                SELECT (par_cCursorAcTel)
                GO TOP
                SCAN
                    loc_nStatus    = nStatus
                    loc_cCodigos   = ALLTRIM(cCodigos)
                    loc_cCampos    = ALLTRIM(cCampos)
                    loc_cDescCamps = ALLTRIM(cDescCamps)
                    loc_cDescTelas = ALLTRIM(cDescTelas)
                    loc_cObjetos   = ALLTRIM(cObjetos)
                    IF loc_nStatus <> 1
                        loc_cSQL = "INSERT INTO sigactel" + ;
                            " (ccampos, ccodigos, cdesccamps, cdesctelas, cobjetos, nstatus, grupos, pkchaves, usuarios)" + ;
                            " VALUES (" + ;
                            EscaparSQL(LEFT(loc_cCampos, 30)) + ", " + ;
                            EscaparSQL(LEFT(loc_cCodigos, 10)) + ", " + ;
                            EscaparSQL(LEFT(loc_cDescCamps, 50)) + ", " + ;
                            EscaparSQL(LEFT(loc_cDescTelas, 50)) + ", " + ;
                            EscaparSQL(LEFT(loc_cObjetos, 100)) + ", " + ;
                            FormatarNumeroSQL(loc_nStatus) + ", " + ;
                            loc_cGrupoSQL + ", " + ;
                            EscaparSQL(fUniqueIds()) + ", '')"
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsAcTel")
                        IF USED("cursor_4c_InsAcTel")
                            USE IN cursor_4c_InsAcTel
                        ENDIF
                        IF loc_nResult < 0
                            loc_lResultado = .F.
                        ENDIF
                    ENDIF
                    SELECT (par_cCursorAcTel)
                ENDSCAN
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao salvar acesso telas:" + CHR(13) + loc_oErro.Message, "Erro")
            loc_lResultado = .F.
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CopiarAcessos - Copia todos os acessos de par_cGrupoOrigem para THIS.this_cGrupos
    * Usa INSERT ... SELECT direto no SQL Server para eficiencia
    *--------------------------------------------------------------------------
    PROCEDURE CopiarAcessos(par_cGrupoOrigem)
        LOCAL loc_cSQL, loc_nResult, loc_lResultado
        LOCAL loc_cGrupoDest, loc_cGrupoOri
        loc_lResultado = .F.
        loc_cGrupoDest = EscaparSQL(LEFT(ALLTRIM(THIS.this_cGrupos), 10))
        loc_cGrupoOri  = EscaparSQL(LEFT(ALLTRIM(par_cGrupoOrigem), 10))
        TRY
            *-- Copiar usuarios: apenas os que o destino ainda nao tem
            loc_cSQL = "INSERT INTO sigcdacg (grupos, usuarios, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", a.usuarios, LEFT(NEWID(), 20)" + ;
                " FROM sigcdacg a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacg b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = a.usuarios)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcg")
            IF USED("cursor_4c_CpAcg")
                USE IN cursor_4c_CpAcg
            ENDIF

            *-- Copiar acessos de programa (nivel grupo)
            loc_cSQL = "INSERT INTO sigcdacu (grupos, programas, parametros, usuarios, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", a.programas, a.parametros, '', LEFT(NEWID(), 45)" + ;
                " FROM sigcdacu a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacu b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.programas = a.programas AND b.parametros = a.parametros)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcu")
            IF USED("cursor_4c_CpAcu")
                USE IN cursor_4c_CpAcu
            ENDIF

            *-- Copiar barra de ferramentas (nivel grupo)
            loc_cSQL = "INSERT INTO sigcdacb" + ;
                " (grupos, usuarios, descricaos, barraforms, barraordem, programas, parametros, selbarras, pkchaves)" + ;
                " SELECT " + loc_cGrupoDest + ", '', a.descricaos, a.barraforms, a.barraordem," + ;
                " a.programas, a.parametros, a.selbarras, LEFT(NEWID(), 20)" + ;
                " FROM sigcdacb a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigcdacb b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.programas = a.programas AND b.parametros = a.parametros)"
            SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcb")
            IF USED("cursor_4c_CpAcb")
                USE IN cursor_4c_CpAcb
            ENDIF

            *-- Copiar acesso a telas (nivel grupo)
            loc_cSQL = "INSERT INTO sigactel" + ;
                " (ccampos, ccodigos, cdesccamps, cdesctelas, cobjetos, nstatus, grupos, pkchaves, usuarios)" + ;
                " SELECT a.ccampos, a.ccodigos, a.cdesccamps, a.cdesctelas, a.cobjetos," + ;
                " a.nstatus, " + loc_cGrupoDest + ", LEFT(NEWID(), 20), ''" + ;
                " FROM sigactel a" + ;
                " WHERE a.grupos = " + loc_cGrupoOri + " AND a.usuarios = ''" + ;
                " AND NOT EXISTS (SELECT 1 FROM sigactel b" + ;
                " WHERE b.grupos = " + loc_cGrupoDest + " AND b.usuarios = ''" + ;
                " AND b.ccodigos = a.ccodigos AND b.ccampos = a.ccampos)"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CpAcTel")
            IF USED("cursor_4c_CpAcTel")
                USE IN cursor_4c_CpAcTel
            ENDIF

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao copiar acessos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao copiar acessos:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarDuplicidade - Verifica se codigo de grupo ja existe
    * Retorna .T. se ja existe (duplicado), .F. se disponivel
    *--------------------------------------------------------------------------
    PROCEDURE VerificarDuplicidade(par_cGrupos)
        LOCAL loc_cSQL, loc_nResult, loc_lDuplicado
        loc_lDuplicado = .F.
        TRY
            loc_cSQL = "SELECT Grupos FROM sigcdgra WHERE Grupos = " + ;
                EscaparSQL(ALLTRIM(par_cGrupos))
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dup")
            IF loc_nResult >= 0
                IF USED("cursor_4c_Dup") AND RECCOUNT("cursor_4c_Dup") > 0
                    loc_lDuplicado = .T.
                ENDIF
                IF USED("cursor_4c_Dup")
                    USE IN cursor_4c_Dup
                ENDIF
            ELSE
                MsgErro("Erro ao verificar duplicidade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY
        RETURN loc_lDuplicado
    ENDPROC

ENDDEFINE

