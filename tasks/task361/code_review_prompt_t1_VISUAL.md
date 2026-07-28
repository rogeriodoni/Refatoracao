# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 192: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 217: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 242: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 267: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 292: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 329: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 461: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 486: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCeg.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1570 linhas total):

*-- Linhas 61 a 72:
61:             ELSE
62:                 THIS.ConfigurarPageFrame()
63: 
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
65:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
66:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
67:                 THIS.pgf_4c_Paginas.Page2.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
68: 
69:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
70:                     THIS.CarregarLista()
71:                 ENDIF
72: 

*-- Linhas 92 a 109:
92: 
93:         WITH loc_oPgf
94:             .PageCount       = 2
95:             .Top             = -29
96:             .Left            = 0
97:             .Width           = THIS.Width
98:             .Height          = THIS.Height + 29
99:             .Tabs            = .F.
100:             .Visible         = .T.
101:             .Page1.Caption   = "Lista"
102:             .Page1.BackColor = RGB(100, 100, 100)
103:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:             .Page2.Caption   = "Dados"
105:             .Page2.BackColor = RGB(100, 100, 100)
106:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
107:         ENDWITH
108: 
109:         THIS.ConfigurarPaginaLista()

*-- Linhas 122 a 160:
122:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
123:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
124:         WITH loc_oCab
125:             .Top         = 31
126:             .Left        = 0
127:             .Width       = THIS.Width
128:             .Height      = 80
129:             .BackColor   = RGB(100, 100, 100)
130:             .BorderWidth = 0
131:             .Visible     = .T.
132:         ENDWITH
133: 
134:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
135:         WITH loc_oCab.lbl_4c_Sombra
136:             .AutoSize  = .F.
137:             .Caption   = THIS.Caption
138:             .Top       = 15
139:             .Left      = 10
140:             .Width     = THIS.Width
141:             .Height    = 40
142:             .FontName  = "Tahoma"
143:             .FontSize  = 16
144:             .FontBold  = .T.
145:             .ForeColor = RGB(0, 0, 0)
146:             .BackStyle = 0
147:             .Visible   = .T.
148:         ENDWITH
149: 
150:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
151:         WITH loc_oCab.lbl_4c_Titulo
152:             .AutoSize  = .F.
153:             .Caption   = THIS.Caption
154:             .Top       = 18
155:             .Left      = 10
156:             .Width     = THIS.Width
157:             .Height    = 46
158:             .FontName  = "Tahoma"
159:             .FontSize  = 16
160:             .FontBold  = .T.

*-- Linhas 167 a 353:
167:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
168:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
169:         WITH loc_oBotoes
170:             .Top         = 29
171:             .Left        = 542
172:             .Width       = 390
173:             .Height      = 85
174:             .BackColor   = RGB(53, 53, 53)
175:             .BackStyle   = 1
176:             .BorderWidth = 0
177:             .Visible     = .T.
178:         ENDWITH
179: 
180:         *-- Botao Incluir
181:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
182:         WITH loc_oBotoes.cmd_4c_Incluir
183:             .Caption         = "Incluir"
184:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
185:             .PicturePosition = 13
186:             .Top             = 5
187:             .Left            = 5
188:             .Width           = 75
189:             .Height          = 75
190:             .BackColor       = RGB(255, 255, 255)
191:             .ForeColor       = RGB(90, 90, 90)
192:             .FontName        = "Comic Sans MS"
193:             .FontSize        = 8
194:             .FontBold        = .T.
195:             .FontItalic      = .T.
196:             .Themes          = .F.
197:             .SpecialEffect   = 0
198:             .MousePointer    = 15
199:             .WordWrap        = .T.
200:             .AutoSize        = .F.
201:             .Visible         = .T.
202:         ENDWITH
203:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
204: 
205:         *-- Botao Visualizar
206:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
207:         WITH loc_oBotoes.cmd_4c_Visualizar
208:             .Caption         = "Visualizar"
209:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
210:             .PicturePosition = 13
211:             .Top             = 5
212:             .Left            = 80
213:             .Width           = 75
214:             .Height          = 75
215:             .BackColor       = RGB(255, 255, 255)
216:             .ForeColor       = RGB(90, 90, 90)
217:             .FontName        = "Comic Sans MS"
218:             .FontSize        = 8
219:             .FontBold        = .T.
220:             .FontItalic      = .T.
221:             .Themes          = .F.
222:             .SpecialEffect   = 0
223:             .MousePointer    = 15
224:             .WordWrap        = .T.
225:             .AutoSize        = .F.
226:             .Visible         = .T.
227:         ENDWITH
228:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
229: 
230:         *-- Botao Alterar
231:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
232:         WITH loc_oBotoes.cmd_4c_Alterar
233:             .Caption         = "Alterar"
234:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
235:             .PicturePosition = 13
236:             .Top             = 5
237:             .Left            = 155
238:             .Width           = 75
239:             .Height          = 75
240:             .BackColor       = RGB(255, 255, 255)
241:             .ForeColor       = RGB(90, 90, 90)
242:             .FontName        = "Comic Sans MS"
243:             .FontSize        = 8
244:             .FontBold        = .T.
245:             .FontItalic      = .T.
246:             .Themes          = .F.
247:             .SpecialEffect   = 0
248:             .MousePointer    = 15
249:             .WordWrap        = .T.
250:             .AutoSize        = .F.
251:             .Visible         = .T.
252:         ENDWITH
253:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
254: 
255:         *-- Botao Excluir
256:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
257:         WITH loc_oBotoes.cmd_4c_Excluir
258:             .Caption         = "Excluir"
259:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
260:             .PicturePosition = 13
261:             .Top             = 5
262:             .Left            = 230
263:             .Width           = 75
264:             .Height          = 75
265:             .BackColor       = RGB(255, 255, 255)
266:             .ForeColor       = RGB(90, 90, 90)
267:             .FontName        = "Comic Sans MS"
268:             .FontSize        = 8
269:             .FontBold        = .T.
270:             .FontItalic      = .T.
271:             .Themes          = .F.
272:             .SpecialEffect   = 0
273:             .MousePointer    = 15
274:             .WordWrap        = .T.
275:             .AutoSize        = .F.
276:             .Visible         = .T.
277:         ENDWITH
278:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
279: 
280:         *-- Botao Buscar
281:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
282:         WITH loc_oBotoes.cmd_4c_Buscar
283:             .Caption         = "Buscar"
284:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
285:             .PicturePosition = 13
286:             .Top             = 5
287:             .Left            = 305
288:             .Width           = 75
289:             .Height          = 75
290:             .BackColor       = RGB(255, 255, 255)
291:             .ForeColor       = RGB(90, 90, 90)
292:             .FontName        = "Comic Sans MS"
293:             .FontSize        = 8
294:             .FontBold        = .T.
295:             .FontItalic      = .T.
296:             .Themes          = .F.
297:             .SpecialEffect   = 0
298:             .MousePointer    = 15
299:             .WordWrap        = .T.
300:             .AutoSize        = .F.
301:             .Visible         = .T.
302:         ENDWITH
303:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
304: 
305:         *-- Container Saida - canonico: Top=29 (0+29), Left=917, Width=90, Height=85
306:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
307:         loc_oSaida = loc_oPg1.cnt_4c_Saida
308:         WITH loc_oSaida
309:             .Top         = 29
310:             .Left        = 917
311:             .Width       = 90
312:             .Height      = 85
313:             .BackStyle   = 0
314:             .BorderWidth = 0
315:             .Visible     = .T.
316:         ENDWITH
317: 
318:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
319:         WITH loc_oSaida.cmd_4c_Encerrar
320:             .Caption         = "Encerrar"
321:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
322:             .PicturePosition = 13
323:             .Top             = 5
324:             .Left            = 5
325:             .Width           = 75
326:             .Height          = 75
327:             .BackColor       = RGB(255, 255, 255)
328:             .ForeColor       = RGB(90, 90, 90)
329:             .FontName        = "Comic Sans MS"
330:             .FontSize        = 8
331:             .FontBold        = .T.
332:             .FontItalic      = .T.
333:             .Themes          = .F.
334:             .SpecialEffect   = 0
335:             .MousePointer    = 15
336:             .WordWrap        = .T.
337:             .AutoSize        = .F.
338:             .Visible         = .T.
339:         ENDWITH
340:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
341: 
342:         *-- Grid de lista - Top=117 (88+29), Left=26, Width=890, Height=498
343:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
344:         loc_oGrid = loc_oPg1.grd_4c_Lista
345:         loc_oGrid.ColumnCount = 5
346:         WITH loc_oGrid
347:             .Top                = 117
348:             .Left               = 26
349:             .Width              = 890
350:             .Height             = 498
351:             .FontName           = "Verdana"
352:             .FontSize           = 8
353:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 368 a 380:
368:         loc_oGrid.Column3.Width           = 120
369:         loc_oGrid.Column4.Width           = 60
370:         loc_oGrid.Column5.Width           = 490
371:         loc_oGrid.Column1.Header1.Caption = "Prioridade"
372:         loc_oGrid.Column2.Header1.Caption = "Grupo"
373:         loc_oGrid.Column3.Header1.Caption = "Conta"
374:         loc_oGrid.Column4.Header1.Caption = "Empresa"
375:         loc_oGrid.Column5.Header1.Caption = "Nome Empresa"
376:         loc_oGrid.Column1.Alignment       = 2
377:         loc_oGrid.Column4.Alignment       = 2
378: 
379:         THIS.TornarControlesVisiveis(loc_oPg1)
380:     ENDPROC

*-- Linhas 392 a 430:
392:         loc_oPg2.AddObject("cnt_4c_Cabecalho", "Container")
393:         loc_oCab = loc_oPg2.cnt_4c_Cabecalho
394:         WITH loc_oCab
395:             .Top         = 31
396:             .Left        = 0
397:             .Width       = THIS.Width
398:             .Height      = 80
399:             .BackColor   = RGB(100, 100, 100)
400:             .BorderWidth = 0
401:             .Visible     = .T.
402:         ENDWITH
403: 
404:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
405:         WITH loc_oCab.lbl_4c_Sombra
406:             .AutoSize  = .F.
407:             .Caption   = THIS.Caption
408:             .Top       = 15
409:             .Left      = 10
410:             .Width     = THIS.Width
411:             .Height    = 40
412:             .FontName  = "Tahoma"
413:             .FontSize  = 16
414:             .FontBold  = .T.
415:             .ForeColor = RGB(0, 0, 0)
416:             .BackStyle = 0
417:             .Visible   = .T.
418:         ENDWITH
419: 
420:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
421:         WITH loc_oCab.lbl_4c_Titulo
422:             .AutoSize  = .F.
423:             .Caption   = THIS.Caption
424:             .Top       = 18
425:             .Left      = 10
426:             .Width     = THIS.Width
427:             .Height    = 46
428:             .FontName  = "Tahoma"
429:             .FontSize  = 16
430:             .FontBold  = .T.

*-- Linhas 437 a 510:
437:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
438:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
439:         WITH loc_oBotoesAcao
440:             .Top         = 33
441:             .Left        = 842
442:             .Width       = 160
443:             .Height      = 85
444:             .BackStyle   = 0
445:             .BorderWidth = 0
446:             .Visible     = .T.
447:         ENDWITH
448: 
449:         *-- Botao Confirmar (Salvar)
450:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
451:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
452:             .Caption         = "Confirmar"
453:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
454:             .PicturePosition = 13
455:             .Top             = 5
456:             .Left            = 5
457:             .Width           = 75
458:             .Height          = 75
459:             .BackColor       = RGB(255, 255, 255)
460:             .ForeColor       = RGB(90, 90, 90)
461:             .FontName        = "Comic Sans MS"
462:             .FontSize        = 8
463:             .FontBold        = .T.
464:             .FontItalic      = .T.
465:             .Themes          = .F.
466:             .SpecialEffect   = 0
467:             .MousePointer    = 15
468:             .WordWrap        = .T.
469:             .AutoSize        = .F.
470:             .Visible         = .T.
471:         ENDWITH
472:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
473: 
474:         *-- Botao Cancelar
475:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
476:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
477:             .Caption         = "Encerrar"
478:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
479:             .PicturePosition = 13
480:             .Top             = 5
481:             .Left            = 80
482:             .Width           = 75
483:             .Height          = 75
484:             .BackColor       = RGB(255, 255, 255)
485:             .ForeColor       = RGB(90, 90, 90)
486:             .FontName        = "Comic Sans MS"
487:             .FontSize        = 8
488:             .FontBold        = .T.
489:             .FontItalic      = .T.
490:             .Themes          = .F.
491:             .SpecialEffect   = 0
492:             .MousePointer    = 15
493:             .WordWrap        = .T.
494:             .AutoSize        = .F.
495:             .Visible         = .T.
496:         ENDWITH
497:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
498: 
499:         *-- Label e TextBox: Grupo (Say1 / Get_Grupo no legado - Top=192+29=221)
500:         loc_oPg2.AddObject("lbl_4c_Grupo", "Label")
501:         WITH loc_oPg2.lbl_4c_Grupo
502:             .AutoSize  = .F.
503:             .Caption   = "Grupo :"
504:             .Top       = 221
505:             .Left      = 139
506:             .Width     = 44
507:             .Height    = 17
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8
510:             .FontBold  = .F.

*-- Linhas 517 a 526:
517:         loc_oPg2.AddObject("txt_4c_Grupo", "TextBox")
518:         WITH loc_oPg2.txt_4c_Grupo
519:             .Value     = ""
520:             .Top       = 219
521:             .Left      = 183
522:             .Width     = 80
523:             .Height    = 23
524:             .FontName  = "Tahoma"
525:             .FontSize  = 8
526:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 532 a 545:
532:         BINDEVENT(loc_oPg2.txt_4c_Grupo, "KeyPress",  THIS, "TeclaGrupo")
533: 
534:         *-- Label e TextBox: Conta (Say3 / get_Conta no legado - Top=224+29=253)
535:         loc_oPg2.AddObject("lbl_4c_Conta", "Label")
536:         WITH loc_oPg2.lbl_4c_Conta
537:             .AutoSize  = .F.
538:             .Caption   = "Conta :"
539:             .Top       = 253
540:             .Left      = 139
541:             .Width     = 44
542:             .Height    = 17
543:             .FontName  = "Tahoma"
544:             .FontSize  = 8
545:             .FontBold  = .F.

*-- Linhas 552 a 561:
552:         loc_oPg2.AddObject("txt_4c_Conta", "TextBox")
553:         WITH loc_oPg2.txt_4c_Conta
554:             .Value     = ""
555:             .Top       = 250
556:             .Left      = 183
557:             .Width     = 80
558:             .Height    = 23
559:             .FontName  = "Tahoma"
560:             .FontSize  = 8
561:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 567 a 580:
567:         BINDEVENT(loc_oPg2.txt_4c_Conta, "KeyPress",  THIS, "TeclaConta")
568: 
569:         *-- Label e TextBox: Prioridade (Say2 / Get_codigo no legado - Top=252+29=281)
570:         loc_oPg2.AddObject("lbl_4c_Priors", "Label")
571:         WITH loc_oPg2.lbl_4c_Priors
572:             .AutoSize  = .F.
573:             .Caption   = "Prioridade :"
574:             .Top       = 281
575:             .Left      = 120
576:             .Width     = 63
577:             .Height    = 17
578:             .FontName  = "Tahoma"
579:             .FontSize  = 8
580:             .FontBold  = .F.

*-- Linhas 587 a 614:
587:         loc_oPg2.AddObject("txt_4c_Priors", "TextBox")
588:         WITH loc_oPg2.txt_4c_Priors
589:             .Value     = 0
590:             .Top       = 279
591:             .Left      = 183
592:             .Width     = 24
593:             .Height    = 23
594:             .FontName  = "Tahoma"
595:             .FontSize  = 8
596:             .ForeColor = RGB(0, 0, 0)
597:             .InputMask = "99"
598:             .MaxLength = 2
599:             .Enabled   = .T.
600:             .Visible   = .T.
601:         ENDWITH
602: 
603:         *-- Label e TextBox: Empresa (Say22/Get_Emps no legado - Top=281+29=310 / 277+29=306)
604:         loc_oPg2.AddObject("lbl_4c_Empresa", "Label")
605:         WITH loc_oPg2.lbl_4c_Empresa
606:             .AutoSize  = .F.
607:             .Caption   = "Empresa :"
608:             .Top       = 310
609:             .Left      = 127
610:             .Width     = 56
611:             .Height    = 17
612:             .FontName  = "Tahoma"
613:             .FontSize  = 8
614:             .FontBold  = .F.

*-- Linhas 621 a 630:
621:         loc_oPg2.AddObject("txt_4c_Emps", "TextBox")
622:         WITH loc_oPg2.txt_4c_Emps
623:             .Value             = ""
624:             .Top               = 306
625:             .Left              = 183
626:             .Width             = 31
627:             .Height            = 23
628:             .FontName          = "Tahoma"
629:             .FontSize          = 8
630:             .ForeColor         = RGB(0, 0, 0)

*-- Linhas 642 a 651:
642:         loc_oPg2.AddObject("txt_4c_DEmps", "TextBox")
643:         WITH loc_oPg2.txt_4c_DEmps
644:             .Value     = ""
645:             .Top       = 306
646:             .Left      = 215
647:             .Width     = 290
648:             .Height    = 23
649:             .FontName  = "Tahoma"
650:             .FontSize  = 8
651:             .ForeColor = RGB(0, 0, 0)

*-- Linhas 657 a 670:
657:         BINDEVENT(loc_oPg2.txt_4c_DEmps, "KeyPress",  THIS, "TeclaDEmps")
658: 
659:         *-- Label: Tipo (Say4 no legado - Top=309+29=338)
660:         loc_oPg2.AddObject("lbl_4c_TpCad", "Label")
661:         WITH loc_oPg2.lbl_4c_TpCad
662:             .AutoSize  = .F.
663:             .Caption   = "Tipo :"
664:             .Top       = 338
665:             .Left      = 148
666:             .Width     = 35
667:             .Height    = 17
668:             .FontName  = "Tahoma"
669:             .FontSize  = 8
670:             .FontBold  = .F.

*-- Linhas 683 a 721:
683:             .BackStyle   = 0
684:             .BorderStyle = 0
685:             .Value       = 2
686:             .Top         = 334
687:             .Left        = 177
688:             .Width       = 322
689:             .Height      = 28
690:             .Visible     = .T.
691:             WITH .Buttons(1)
692:                 .Caption   = "\<Pedido Autom" + CHR(225) + "tico"
693:                 .Left      = 5
694:                 .Top       = 5
695:                 .Height    = 15
696:                 .AutoSize  = .T.
697:                 .BackStyle = 0
698:                 .ForeColor = RGB(90, 90, 90)
699:                 .Themes    = .F.
700:             ENDWITH
701:             WITH .Buttons(2)
702:                 .Caption   = "\<Globaliza" + CHR(231) + CHR(227) + "o"
703:                 .Left      = 134
704:                 .Top       = 5
705:                 .Height    = 15
706:                 .AutoSize  = .T.
707:                 .FontName  = "Tahoma"
708:                 .FontSize  = 8
709:                 .BackStyle = 0
710:                 .ForeColor = RGB(90, 90, 90)
711:                 .Themes    = .F.
712:             ENDWITH
713:             WITH .Buttons(3)
714:                 .Caption   = "Distribui" + CHR(231) + CHR(227) + "o"
715:                 .Left      = 233
716:                 .Top       = 5
717:                 .Height    = 15
718:                 .Width     = 73
719:                 .AutoSize  = .T.
720:                 .FontName  = "Tahoma"
721:                 .FontSize  = 8

*-- Linhas 754 a 766:
754:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.emps"
755:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Razas"
756:                     *-- Redefinir cabecalhos apos RecordSource (VFP reseta headers)
757:                     loc_oGrid.Column1.Header1.Caption = "Prioridade"
758:                     loc_oGrid.Column2.Header1.Caption = "Grupo"
759:                     loc_oGrid.Column3.Header1.Caption = "Conta"
760:                     loc_oGrid.Column4.Header1.Caption = "Empresa"
761:                     loc_oGrid.Column5.Header1.Caption = "Nome Empresa"
762:                     THIS.FormatarGridLista(loc_oGrid)
763:                     loc_lResultado = .T.
764:                 ENDIF
765:                 ENDIF
766:             ENDIF

*-- Linhas 941 a 953:
941:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.contas"
942:                     loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.emps"
943:                     loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.Razas"
944:                     loc_oGrid.Column1.Header1.Caption = "Prioridade"
945:                     loc_oGrid.Column2.Header1.Caption = "Grupo"
946:                     loc_oGrid.Column3.Header1.Caption = "Conta"
947:                     loc_oGrid.Column4.Header1.Caption = "Empresa"
948:                     loc_oGrid.Column5.Header1.Caption = "Nome Empresa"
949:                     loc_lResultado = .T.
950:                 ENDIF
951:             ENDIF
952:         CATCH TO loc_oErro
953:             MsgErro(loc_oErro.Message, "FormCeg.BtnBuscarClick")

*-- Linhas 1213 a 1222:
1213:                 ENDIF
1214:             ENDIF
1215:             *-- Botao Confirmar: habilitado em INCLUIR/ALTERAR; desabilitado em VISUALIZAR
1216:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1217:                 loc_oCtrl = loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar
1218:                 IF VARTYPE(loc_oCtrl) = "O"
1219:                     loc_oCtrl.Enabled = par_lHabilitar
1220:                 ENDIF
1221:             ENDIF
1222:         CATCH TO loc_oErro

*-- Linhas 1528 a 1543:
1528:             loc_oBotoes    = THIS.pgf_4c_Paginas.Page1.cnt_4c_Botoes
1529:             loc_lTemRegistro = USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1530: 
1531:             IF PEMSTATUS(loc_oBotoes, "cmd_4c_Visualizar", 5)
1532:                 loc_oBotoes.cmd_4c_Visualizar.Enabled = loc_lTemRegistro
1533:             ENDIF
1534:             IF PEMSTATUS(loc_oBotoes, "cmd_4c_Alterar", 5)
1535:                 loc_oBotoes.cmd_4c_Alterar.Enabled = loc_lTemRegistro
1536:             ENDIF
1537:             IF PEMSTATUS(loc_oBotoes, "cmd_4c_Excluir", 5)
1538:                 loc_oBotoes.cmd_4c_Excluir.Enabled = loc_lTemRegistro
1539:             ENDIF
1540:         CATCH TO loc_oErro
1541:             MsgErro(loc_oErro.Message, "FormCeg.AjustarBotoesPorModo")
1542:         ENDTRY
1543:     ENDPROC


### BO (C:\4c\projeto\app\classes\CegBO.prg):
*====================================================================
* CegBO.prg
*
* Business Object para Prioridade de Estoque p/Globaliza??o
* Tabela principal: SigCdCeg (cidchaves PK)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CegBO AS BusinessBase

	*-- Propriedades da entidade (SigCdCeg)
	this_cCidchaves   = ""   && cidchaves char(?)      - PK (gerado por fUniqueIds)
	this_cGrupos      = ""   && grupos char(?)         - Grupo (FK SigCdGcr.Codigos)
	this_cContas      = ""   && contas char(?)         - Conta (via fAcessoContas)
	this_cEmps        = ""   && Cemps char(3)           - Empresa (FK SigCdEmp.CEmps)
	this_nPriors      = 0    && priors numeric(2,0)    - Prioridade (InputMask "99")
	this_nTpCads      = 0    && TpCads numeric(1,0)    - Tipo (OptionGroup 3 opcoes)

	*-- Propriedade auxiliar de exibicao (NAO persiste no banco)
	this_cDEmps       = ""   && descricao da empresa (SigCdEmp.Razas - display only)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SigCdCeg"
		THIS.this_cCampoChave = "cidchaves"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCidchaves)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de registros no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.cidchaves, a.priors, a.grupos, a.contas, a.emps," + ;
			           " ISNULL(b.Razas, '') AS Razas" + ;
			           " FROM SIGCDCEG a" + ;
			           " LEFT JOIN SigCdEmp b ON RTRIM(b.Cemps) = RTRIM(a.cemps)"

			IF !EMPTY(par_cFiltro)
				loc_cSQL = loc_cSQL + " WHERE RTRIM(a.grupos) LIKE " + ;
				           EscaparSQL(ALLTRIM(par_cFiltro) + "%")
			ENDIF

			loc_cSQL = loc_cSQL + " ORDER BY a.grupos, a.contas, a.priors"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar prioridades:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar prioridades:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pela chave primaria
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCidchaves)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT a.cidchaves, a.contas, a.grupos, a.priors," + ;
			           " a.emps, a.tpcads," + ;
			           " ISNULL(b.Razas, '') AS Razas" + ;
			           " FROM SIGCDCEG a" + ;
			           " LEFT JOIN SigCdEmp b ON RTRIM(b.Cemps) = RTRIM(a.cemps)" + ;
			           " WHERE RTRIM(a.cidchaves) = " + EscaparSQL(ALLTRIM(par_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
	*====================================================================
	PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
		LOCAL loc_lSucesso
		loc_lSucesso = .F.

		IF USED(par_cAliasCursor)
			SELECT (par_cAliasCursor)
			THIS.this_cCidchaves = TratarNulo(cidchaves, "C")
			THIS.this_cContas    = TratarNulo(contas, "C")
			THIS.this_cGrupos    = TratarNulo(grupos, "C")
			THIS.this_nPriors    = TratarNulo(priors, "N")
			THIS.this_cEmps      = TratarNulo(emps, "C")
			THIS.this_nTpCads    = TratarNulo(tpcads, "N")
			THIS.this_cDEmps     = TratarNulo(Razas, "C")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* VerificarDuplicidade - Verifica se grupos+contas ja existem (INSERT)
	*====================================================================
	PROCEDURE VerificarDuplicidade()
		LOCAL loc_cSQL, loc_nResultado, loc_lDuplicado
		loc_lDuplicado = .F.

		TRY
			loc_cSQL = "SELECT COUNT(*) AS Total FROM SIGCDCEG" + ;
			           " WHERE RTRIM(grupos) = " + EscaparSQL(ALLTRIM(THIS.this_cGrupos)) + ;
			           " AND RTRIM(contas) = " + EscaparSQL(ALLTRIM(THIS.this_cContas))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Duplic")
			IF loc_nResultado >= 0 AND !EOF("cursor_4c_Duplic")
				loc_lDuplicado = (cursor_4c_Duplic.Total > 0)
			ENDIF

			IF USED("cursor_4c_Duplic")
				USE IN cursor_4c_Duplic
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao verificar duplicidade:" + CHR(13) + loc_oErro.Message, "Erro")
			IF USED("cursor_4c_Duplic")
				USE IN cursor_4c_Duplic
			ENDIF
		ENDTRY

		RETURN loc_lDuplicado
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDCEG
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			THIS.this_cCidchaves = LEFT(fUniqueIds(), 20)

			loc_cSQL = "INSERT INTO SIGCDCEG" + ;
			           " (cidchaves, contas, grupos, priors, emps, tpcads)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCidchaves) + "," + ;
			           EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
			           EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPriors) + "," + ;
			           EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTpCads) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir prioridade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDCEG
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDCEG SET" + ;
			           " contas = " + EscaparSQL(LEFT(THIS.this_cContas, 10)) + "," + ;
			           " grupos = " + EscaparSQL(LEFT(THIS.this_cGrupos, 10)) + "," + ;
			           " priors = " + FormatarNumeroSQL(THIS.this_nPriors) + "," + ;
			           " emps = " + EscaparSQL(LEFT(THIS.this_cEmps, 3)) + "," + ;
			           " tpcads = " + FormatarNumeroSQL(THIS.this_nTpCads) + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar prioridade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE na tabela SIGCDCEG
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SIGCDCEG" + ;
			           " WHERE RTRIM(cidchaves) = " + EscaparSQL(ALLTRIM(THIS.this_cCidchaves))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir prioridade:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir prioridade:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

