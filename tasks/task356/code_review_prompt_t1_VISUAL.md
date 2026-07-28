# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (12)
- [FONTNAME-ERRADO] Linha 190: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 213: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 236: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 259: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 282: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 324: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 405: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 428: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 455: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 479: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 761: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 784: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCCJ.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1834 linhas total):

*-- Linhas 60 a 69:
60:             ELSE
61:                 THIS.ConfigurarPageFrame()
62: 
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
64:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
65: 
66:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
67:                     THIS.CarregarLista()
68:                 ENDIF
69: 

*-- Linhas 81 a 107:
81: 
82:     *--------------------------------------------------------------------------
83:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
84:     * PageFrame.Top=-29 compensa abas ocultas; controles internos somam +29
85:     *--------------------------------------------------------------------------
86:     PROTECTED PROCEDURE ConfigurarPageFrame()
87:         LOCAL loc_oPgf
88:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
89:         loc_oPgf = THIS.pgf_4c_Paginas
90: 
91:         WITH loc_oPgf
92:             .PageCount = 2
93:             .Top       = -29
94:             .Left      = 0
95:             .Width     = THIS.Width
96:             .Height    = THIS.Height + 29
97:             .Tabs      = .F.
98:             .Visible   = .T.
99:             .Page1.Caption   = "Lista"
100:             .Page1.BackColor = RGB(100, 100, 100)
101:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
102:             .Page2.Caption   = "Dados"
103:             .Page2.BackColor = RGB(100, 100, 100)
104:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
105:         ENDWITH
106: 
107:         THIS.ConfigurarPaginaLista()

*-- Linhas 117 a 159:
117:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
118:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
119: 
120:         *-- Container cabecalho cinza escuro (Top = 2+29 = 31, compensacao PageFrame.Top=-29)
121:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
122:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
123:         WITH loc_oCab
124:             .Top         = 31
125:             .Left        = 0
126:             .Width       = THIS.Width
127:             .Height      = 80
128:             .BackColor   = RGB(100, 100, 100)
129:             .BorderWidth = 0
130:             .Visible     = .T.
131:         ENDWITH
132: 
133:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
134:         WITH loc_oCab.lbl_4c_Sombra
135:             .AutoSize  = .F.
136:             .Caption   = THIS.Caption
137:             .Top       = 15
138:             .Left      = 10
139:             .Width     = THIS.Width
140:             .Height    = 40
141:             .FontName  = "Tahoma"
142:             .FontSize  = 16
143:             .FontBold  = .T.
144:             .ForeColor = RGB(0, 0, 0)
145:             .BackStyle = 0
146:             .Visible   = .T.
147:         ENDWITH
148: 
149:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
150:         WITH loc_oCab.lbl_4c_Titulo
151:             .AutoSize  = .F.
152:             .Caption   = THIS.Caption
153:             .Top       = 18
154:             .Left      = 10
155:             .Width     = THIS.Width
156:             .Height    = 46
157:             .FontName  = "Tahoma"
158:             .FontSize  = 16
159:             .FontBold  = .T.

*-- Linhas 166 a 353:
166:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
167:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
168:         WITH loc_oBotoes
169:             .Top         = 29
170:             .Left        = 542
171:             .Width       = 390
172:             .Height      = 85
173:             .BackColor   = RGB(53, 53, 53)
174:             .BackStyle   = 1
175:             .BorderWidth = 0
176:             .Visible     = .T.
177:         ENDWITH
178: 
179:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
180:         WITH loc_oBotoes.cmd_4c_Incluir
181:             .Caption         = "Incluir"
182:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
183:             .PicturePosition = 13
184:             .Top             = 5
185:             .Left            = 5
186:             .Width           = 75
187:             .Height          = 75
188:             .BackColor       = RGB(255, 255, 255)
189:             .ForeColor       = RGB(90, 90, 90)
190:             .FontName        = "Comic Sans MS"
191:             .FontSize        = 8
192:             .FontBold        = .T.
193:             .FontItalic      = .T.
194:             .Themes          = .F.
195:             .SpecialEffect   = 0
196:             .MousePointer    = 15
197:             .WordWrap        = .T.
198:             .AutoSize        = .F.
199:             .Visible         = .T.
200:         ENDWITH
201: 
202:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
203:         WITH loc_oBotoes.cmd_4c_Visualizar
204:             .Caption         = "Visualizar"
205:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
206:             .PicturePosition = 13
207:             .Top             = 5
208:             .Left            = 80
209:             .Width           = 75
210:             .Height          = 75
211:             .BackColor       = RGB(255, 255, 255)
212:             .ForeColor       = RGB(90, 90, 90)
213:             .FontName        = "Comic Sans MS"
214:             .FontSize        = 8
215:             .FontBold        = .T.
216:             .FontItalic      = .T.
217:             .Themes          = .F.
218:             .SpecialEffect   = 0
219:             .MousePointer    = 15
220:             .WordWrap        = .T.
221:             .AutoSize        = .F.
222:             .Visible         = .T.
223:         ENDWITH
224: 
225:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
226:         WITH loc_oBotoes.cmd_4c_Alterar
227:             .Caption         = "Alterar"
228:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
229:             .PicturePosition = 13
230:             .Top             = 5
231:             .Left            = 155
232:             .Width           = 75
233:             .Height          = 75
234:             .BackColor       = RGB(255, 255, 255)
235:             .ForeColor       = RGB(90, 90, 90)
236:             .FontName        = "Comic Sans MS"
237:             .FontSize        = 8
238:             .FontBold        = .T.
239:             .FontItalic      = .T.
240:             .Themes          = .F.
241:             .SpecialEffect   = 0
242:             .MousePointer    = 15
243:             .WordWrap        = .T.
244:             .AutoSize        = .F.
245:             .Visible         = .T.
246:         ENDWITH
247: 
248:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
249:         WITH loc_oBotoes.cmd_4c_Excluir
250:             .Caption         = "Excluir"
251:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
252:             .PicturePosition = 13
253:             .Top             = 5
254:             .Left            = 230
255:             .Width           = 75
256:             .Height          = 75
257:             .BackColor       = RGB(255, 255, 255)
258:             .ForeColor       = RGB(90, 90, 90)
259:             .FontName        = "Comic Sans MS"
260:             .FontSize        = 8
261:             .FontBold        = .T.
262:             .FontItalic      = .T.
263:             .Themes          = .F.
264:             .SpecialEffect   = 0
265:             .MousePointer    = 15
266:             .WordWrap        = .T.
267:             .AutoSize        = .F.
268:             .Visible         = .T.
269:         ENDWITH
270: 
271:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
272:         WITH loc_oBotoes.cmd_4c_Buscar
273:             .Caption         = "Buscar"
274:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
275:             .PicturePosition = 13
276:             .Top             = 5
277:             .Left            = 305
278:             .Width           = 75
279:             .Height          = 75
280:             .BackColor       = RGB(255, 255, 255)
281:             .ForeColor       = RGB(90, 90, 90)
282:             .FontName        = "Comic Sans MS"
283:             .FontSize        = 8
284:             .FontBold        = .T.
285:             .FontItalic      = .T.
286:             .Themes          = .F.
287:             .SpecialEffect   = 0
288:             .MousePointer    = 15
289:             .WordWrap        = .T.
290:             .AutoSize        = .F.
291:             .Visible         = .T.
292:         ENDWITH
293: 
294:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
295:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
296:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
297:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
298:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
299: 
300:         *-- Container Encerrar (canonico: Left=917, Width=90, Height=85)
301:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
302:         loc_oSaida = loc_oPg1.cnt_4c_Saida
303:         WITH loc_oSaida
304:             .Top         = 29
305:             .Left        = 917
306:             .Width       = 90
307:             .Height      = 85
308:             .BackStyle   = 0
309:             .BorderWidth = 0
310:             .Visible     = .T.
311:         ENDWITH
312: 
313:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
314:         WITH loc_oSaida.cmd_4c_Encerrar
315:             .Caption         = "Encerrar"
316:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
317:             .PicturePosition = 13
318:             .Top             = 5
319:             .Left            = 5
320:             .Width           = 75
321:             .Height          = 75
322:             .BackColor       = RGB(255, 255, 255)
323:             .ForeColor       = RGB(90, 90, 90)
324:             .FontName        = "Comic Sans MS"
325:             .FontSize        = 8
326:             .FontBold        = .T.
327:             .FontItalic      = .T.
328:             .Themes          = .F.
329:             .SpecialEffect   = 0
330:             .MousePointer    = 15
331:             .WordWrap        = .T.
332:             .AutoSize        = .F.
333:             .Visible         = .T.
334:         ENDWITH
335: 
336:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
337: 
338:         *-- Grid de lista (Top=117=88+29, Left=26)
339:         *-- Colunas: Conta, Descricao, Data Base, Fator, Total, Liquido
340:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
341:         loc_oGrid = loc_oPg1.grd_4c_Lista
342: 
343:         loc_oGrid.RecordSource = ""
344:         loc_oGrid.ColumnCount  = 6
345: 
346:         WITH loc_oGrid
347:             .Top                = 117
348:             .Left               = 26
349:             .Width              = 880
350:             .Height             = 480
351:             .FontName           = "Verdana"
352:             .FontSize           = 8
353:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 382 a 504:
382:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
383:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
384:         WITH loc_oBotoesAcao
385:             .Top         = 33
386:             .Left        = 842
387:             .Width       = 160
388:             .Height      = 85
389:             .BackStyle   = 0
390:             .BorderWidth = 0
391:             .Visible     = .T.
392:         ENDWITH
393: 
394:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
395:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
396:             .Caption         = "Confirmar"
397:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
398:             .PicturePosition = 13
399:             .Top             = 5
400:             .Left            = 5
401:             .Width           = 75
402:             .Height          = 75
403:             .BackColor       = RGB(255, 255, 255)
404:             .ForeColor       = RGB(90, 90, 90)
405:             .FontName        = "Comic Sans MS"
406:             .FontSize        = 8
407:             .FontBold        = .T.
408:             .FontItalic      = .T.
409:             .Themes          = .F.
410:             .SpecialEffect   = 0
411:             .MousePointer    = 15
412:             .WordWrap        = .T.
413:             .AutoSize        = .F.
414:             .Visible         = .T.
415:         ENDWITH
416: 
417:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
418:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
419:             .Caption         = "Encerrar"
420:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
421:             .PicturePosition = 13
422:             .Top             = 5
423:             .Left            = 80
424:             .Width           = 75
425:             .Height          = 75
426:             .BackColor       = RGB(255, 255, 255)
427:             .ForeColor       = RGB(90, 90, 90)
428:             .FontName        = "Comic Sans MS"
429:             .FontSize        = 8
430:             .FontBold        = .T.
431:             .FontItalic      = .T.
432:             .Themes          = .F.
433:             .SpecialEffect   = 0
434:             .MousePointer    = 15
435:             .WordWrap        = .T.
436:             .AutoSize        = .F.
437:             .Visible         = .T.
438:         ENDWITH
439: 
440:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
441:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
442: 
443:         *-- Botao Recalcular (BtnRec: original top=3+29=32, left=499)
444:         loc_oPg2.AddObject("cmd_4c_BtnRec", "CommandButton")
445:         WITH loc_oPg2.cmd_4c_BtnRec
446:             .Caption         = "Recalcular"
447:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
448:             .PicturePosition = 13
449:             .Top             = 32
450:             .Left            = 499
451:             .Width           = 75
452:             .Height          = 75
453:             .BackColor       = RGB(255, 255, 255)
454:             .ForeColor       = RGB(90, 90, 90)
455:             .FontName        = "Comic Sans MS"
456:             .FontSize        = 8
457:             .FontBold        = .T.
458:             .FontItalic      = .T.
459:             .Themes          = .F.
460:             .SpecialEffect   = 0
461:             .MousePointer    = 15
462:             .WordWrap        = .T.
463:             .AutoSize        = .F.
464:             .Visible         = .T.
465:         ENDWITH
466: 
467:         *-- Botao Relatorio/Video (BtnVideo: original top=3+29=32, left=574)
468:         loc_oPg2.AddObject("cmd_4c_BtnVideo", "CommandButton")
469:         WITH loc_oPg2.cmd_4c_BtnVideo
470:             .Caption         = "Relat" + CHR(243) + "rio"
471:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
472:             .PicturePosition = 13
473:             .Top             = 32
474:             .Left            = 574
475:             .Width           = 75
476:             .Height          = 75
477:             .BackColor       = RGB(255, 255, 255)
478:             .ForeColor       = RGB(90, 90, 90)
479:             .FontName        = "Comic Sans MS"
480:             .FontSize        = 8
481:             .FontBold        = .T.
482:             .FontItalic      = .T.
483:             .Themes          = .F.
484:             .SpecialEffect   = 0
485:             .MousePointer    = 15
486:             .WordWrap        = .T.
487:             .AutoSize        = .F.
488:             .Visible         = .T.
489:         ENDWITH
490: 
491:         BINDEVENT(loc_oPg2.cmd_4c_BtnRec,   "Click", THIS, "BtnRecalcularClick")
492:         BINDEVENT(loc_oPg2.cmd_4c_BtnVideo, "Click", THIS, "BtnRelatorioClick")
493: 
494:         *-- Label + TextBox Conta (Say42+Get_Contas: original top=119/115 -> +29=148/144)
495:         loc_oPg2.AddObject("lbl_4c_Label42", "Label")
496:         WITH loc_oPg2.lbl_4c_Label42
497:             .Caption   = "Conta :"
498:             .Top       = 148
499:             .Left      = 220
500:             .Width     = 60
501:             .Height    = 17
502:             .FontName  = "Tahoma"
503:             .FontSize  = 8
504:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 510 a 519:
510:         loc_oPg2.AddObject("txt_4c_Contas", "TextBox")
511:         WITH loc_oPg2.txt_4c_Contas
512:             .Value         = ""
513:             .Top           = 144
514:             .Left          = 260
515:             .Width         = 81
516:             .Height        = 23
517:             .FontName      = "Tahoma"
518:             .FontSize      = 8
519:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 527 a 536:
527:         loc_oPg2.AddObject("txt_4c_DContas", "TextBox")
528:         WITH loc_oPg2.txt_4c_DContas
529:             .Value         = ""
530:             .Top           = 144
531:             .Left          = 345
532:             .Width         = 279
533:             .Height        = 23
534:             .FontName      = "Tahoma"
535:             .FontSize      = 8
536:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 546 a 558:
546:         BINDEVENT(loc_oPg2.txt_4c_Contas, "DblClick",  THIS, "ContasDblClick")
547: 
548:         *-- Label + TextBox Data Base (Say15+Get_DataBase: original top=146/142 -> +29=175/171)
549:         loc_oPg2.AddObject("lbl_4c_Label15", "Label")
550:         WITH loc_oPg2.lbl_4c_Label15
551:             .Caption   = "Data Base :"
552:             .Top       = 175
553:             .Left      = 200
554:             .Width     = 58
555:             .Height    = 17
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8
558:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 564 a 573:
564:         loc_oPg2.AddObject("txt_4c_DataBase", "TextBox")
565:         WITH loc_oPg2.txt_4c_DataBase
566:             .Value         = {}
567:             .Top           = 171
568:             .Left          = 260
569:             .Width         = 81
570:             .Height        = 23
571:             .FontName      = "Tahoma"
572:             .FontSize      = 8
573:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 579 a 591:
579:         ENDWITH
580: 
581:         *-- Label + TextBox Fator (Say1+Get_Fator: original top=173/169 -> +29=202/198)
582:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
583:         WITH loc_oPg2.lbl_4c_Label1
584:             .Caption   = "Fator :"
585:             .Top       = 202
586:             .Left      = 223
587:             .Width     = 35
588:             .Height    = 17
589:             .FontName  = "Tahoma"
590:             .FontSize  = 8
591:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 597 a 606:
597:         loc_oPg2.AddObject("txt_4c_Fator", "TextBox")
598:         WITH loc_oPg2.txt_4c_Fator
599:             .Value         = 0
600:             .Top           = 198
601:             .Left          = 260
602:             .Width         = 81
603:             .Height        = 23
604:             .FontName      = "Tahoma"
605:             .FontSize      = 8
606:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 613 a 688:
613: 
614:         *-- Label "Dias :" + OptionGroup (Say13+optDias: original top=149/144 -> +29=178/173)
615:         *-- Value=1 Corridos (todos os dias), Value=2 Uteis (exclui sab/dom)
616:         loc_oPg2.AddObject("lbl_4c_Label13", "Label")
617:         WITH loc_oPg2.lbl_4c_Label13
618:             .Caption   = "Dias :"
619:             .Top       = 178
620:             .Left      = 357
621:             .Width     = 35
622:             .Height    = 17
623:             .FontName  = "Tahoma"
624:             .FontSize  = 8
625:             .ForeColor = RGB(90, 90, 90)
626:             .BackStyle = 0
627:             .Visible   = .T.
628:         ENDWITH
629: 
630:         loc_oPg2.AddObject("opt_4c_OptDias", "OptionGroup")
631:         WITH loc_oPg2.opt_4c_OptDias
632:             .ButtonCount = 2
633:             .Top         = 173
634:             .Left        = 383
635:             .Width       = 119
636:             .Height      = 25
637:             .BackStyle   = 0
638:             .BorderStyle = 0
639:             .Value       = 1
640:             .Visible     = .T.
641:         ENDWITH
642: 
643:         loc_oPg2.opt_4c_OptDias.Buttons(1).Caption   = "Corridos"
644:         loc_oPg2.opt_4c_OptDias.Buttons(1).Left      = 5
645:         loc_oPg2.opt_4c_OptDias.Buttons(1).Top       = 5
646:         loc_oPg2.opt_4c_OptDias.Buttons(1).Width     = 60
647:         loc_oPg2.opt_4c_OptDias.Buttons(1).AutoSize  = .T.
648:         loc_oPg2.opt_4c_OptDias.Buttons(1).FontName  = "Tahoma"
649:         loc_oPg2.opt_4c_OptDias.Buttons(1).FontSize  = 8
650:         loc_oPg2.opt_4c_OptDias.Buttons(1).ForeColor = RGB(90, 90, 90)
651:         loc_oPg2.opt_4c_OptDias.Buttons(1).Themes    = .F.
652: 
653:         loc_oPg2.opt_4c_OptDias.Buttons(2).Caption   = CHR(218) + "teis"
654:         loc_oPg2.opt_4c_OptDias.Buttons(2).Left      = 63
655:         loc_oPg2.opt_4c_OptDias.Buttons(2).Top       = 5
656:         loc_oPg2.opt_4c_OptDias.Buttons(2).Width     = 50
657:         loc_oPg2.opt_4c_OptDias.Buttons(2).AutoSize  = .T.
658:         loc_oPg2.opt_4c_OptDias.Buttons(2).FontName  = "Tahoma"
659:         loc_oPg2.opt_4c_OptDias.Buttons(2).FontSize  = 8
660:         loc_oPg2.opt_4c_OptDias.Buttons(2).ForeColor = RGB(90, 90, 90)
661:         loc_oPg2.opt_4c_OptDias.Buttons(2).Themes    = .F.
662: 
663:         BINDEVENT(loc_oPg2.opt_4c_OptDias, "InteractiveChange", THIS, "OptDiasChanged")
664: 
665:         *-- Forma decorativa superior (Shape3: original top=-23 -> compensado=6)
666:         loc_oPg2.AddObject("shp_4c_Shape3", "Shape")
667:         WITH loc_oPg2.shp_4c_Shape3
668:             .Top           = 6
669:             .Left          = 0
670:             .Width         = THIS.Width
671:             .Height        = 2
672:             .SpecialEffect = 0
673:             .BackStyle     = 1
674:             .BackColor     = RGB(53, 53, 53)
675:             .BorderStyle   = 0
676:             .Visible       = .T.
677:         ENDWITH
678: 
679:         *-- Forma decorativa separador de secoes (Shape4: original top=219 -> compensado=248)
680:         loc_oPg2.AddObject("shp_4c_Shape4", "Shape")
681:         WITH loc_oPg2.shp_4c_Shape4
682:             .Top           = 248
683:             .Left          = 255
684:             .Width         = 420
685:             .Height        = 2
686:             .SpecialEffect = 0
687:             .BackStyle     = 1
688:             .BackColor     = RGB(150, 150, 150)

*-- Linhas 697 a 706:
697:         WITH loc_oGrdDet
698:             .RecordSource       = ""
699:             .ColumnCount        = 4
700:             .Top                = 225
701:             .Left               = 260
702:             .Width              = 365
703:             .Height             = 382
704:             .FontName           = "Tahoma"
705:             .FontSize           = 8
706:             .ForeColor          = RGB(90, 90, 90)

*-- Linhas 718 a 824:
718:             .Visible            = .T.
719:         ENDWITH
720: 
721:         loc_oGrdDet.Column1.Header1.Caption  = "Data"
722:         loc_oGrdDet.Column1.Width            = 90
723:         loc_oGrdDet.Column1.Sparse           = .F.
724:         loc_oGrdDet.Column1.ReadOnly         = .F.
725:         loc_oGrdDet.Column1.ControlSource    = ""
726:         loc_oGrdDet.Column1.Text1.InputMask  = "99/99/9999"
727: 
728:         loc_oGrdDet.Column2.Header1.Caption  = "Valor"
729:         loc_oGrdDet.Column2.Width            = 90
730:         loc_oGrdDet.Column2.Sparse           = .F.
731:         loc_oGrdDet.Column2.ReadOnly         = .F.
732:         loc_oGrdDet.Column2.ControlSource    = ""
733: 
734:         loc_oGrdDet.Column3.Header1.Caption  = "Dias"
735:         loc_oGrdDet.Column3.Width            = 45
736:         loc_oGrdDet.Column3.Sparse           = .F.
737:         loc_oGrdDet.Column3.ReadOnly         = .T.
738:         loc_oGrdDet.Column3.ControlSource    = ""
739: 
740:         loc_oGrdDet.Column4.Header1.Caption  = "Valor Liquido"
741:         loc_oGrdDet.Column4.Width            = 130
742:         loc_oGrdDet.Column4.Sparse           = .F.
743:         loc_oGrdDet.Column4.ReadOnly         = .T.
744:         loc_oGrdDet.Column4.ControlSource    = ""
745: 
746:         BINDEVENT(loc_oGrdDet.Column2.Text1, "LostFocus", THIS, "RecalcularItem")
747:         BINDEVENT(loc_oGrdDet.Column1.Text1, "KeyPress", THIS, "ValidarDataDetalhe")
748: 
749:         *-- Botao InserirV (original top=317 -> compensado=346, left=630, 45x45)
750:         loc_oPg2.AddObject("cmd_4c_InserirV", "CommandButton")
751:         WITH loc_oPg2.cmd_4c_InserirV
752:             .Caption         = "Inserir"
753:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
754:             .PicturePosition = 13
755:             .Top             = 346
756:             .Left            = 630
757:             .Width           = 45
758:             .Height          = 45
759:             .BackColor       = RGB(255, 255, 255)
760:             .ForeColor       = RGB(90, 90, 90)
761:             .FontName        = "Comic Sans MS"
762:             .FontSize        = 7
763:             .FontBold        = .T.
764:             .Themes          = .F.
765:             .SpecialEffect   = 0
766:             .MousePointer    = 15
767:             .WordWrap        = .T.
768:             .AutoSize        = .F.
769:             .Visible         = .T.
770:         ENDWITH
771: 
772:         *-- Botao ExcluirV (original top=362 -> compensado=391, left=630, 45x45)
773:         loc_oPg2.AddObject("cmd_4c_ExcluirV", "CommandButton")
774:         WITH loc_oPg2.cmd_4c_ExcluirV
775:             .Caption         = "Excluir"
776:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
777:             .PicturePosition = 13
778:             .Top             = 391
779:             .Left            = 630
780:             .Width           = 45
781:             .Height          = 45
782:             .BackColor       = RGB(255, 255, 255)
783:             .ForeColor       = RGB(90, 90, 90)
784:             .FontName        = "Comic Sans MS"
785:             .FontSize        = 7
786:             .FontBold        = .T.
787:             .Themes          = .F.
788:             .SpecialEffect   = 0
789:             .MousePointer    = 15
790:             .WordWrap        = .T.
791:             .AutoSize        = .F.
792:             .Visible         = .T.
793:         ENDWITH
794: 
795:         BINDEVENT(loc_oPg2.cmd_4c_InserirV, "Click", THIS, "InserirVClick")
796:         BINDEVENT(loc_oPg2.cmd_4c_ExcluirV, "Click", THIS, "ExcluirVClick")
797: 
798:         *-- Secao Totais (direita do grid, esquerda dos botoes de acao)
799:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
800:         WITH loc_oPg2.lbl_4c_Label5
801:             .Caption   = "Totais"
802:             .Top       = 248
803:             .Left      = 690
804:             .Width     = 130
805:             .Height    = 20
806:             .FontName  = "Tahoma"
807:             .FontSize  = 10
808:             .FontBold  = .T.
809:             .ForeColor = RGB(53, 53, 53)
810:             .BackStyle = 0
811:             .Alignment = 2
812:             .Visible   = .T.
813:         ENDWITH
814: 
815:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
816:         WITH loc_oPg2.lbl_4c_Label2
817:             .Caption   = "Qtde :"
818:             .Top       = 278
819:             .Left      = 690
820:             .Width     = 60
821:             .Height    = 17
822:             .FontName  = "Tahoma"
823:             .FontSize  = 8
824:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 830 a 856:
830:         loc_oPg2.AddObject("txt_4c_Qtde", "TextBox")
831:         WITH loc_oPg2.txt_4c_Qtde
832:             .Value         = 0
833:             .Top           = 275
834:             .Left          = 752
835:             .Width         = 68
836:             .Height        = 23
837:             .FontName      = "Tahoma"
838:             .FontSize      = 8
839:             .ForeColor     = RGB(90, 90, 90)
840:             .BackColor     = RGB(255, 255, 230)
841:             .ReadOnly      = .T.
842:             .Themes        = .F.
843:             .SpecialEffect = 0
844:             .Visible       = .T.
845:         ENDWITH
846: 
847:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
848:         WITH loc_oPg2.lbl_4c_Label6
849:             .Caption   = "M" + CHR(233) + "dia :"
850:             .Top       = 305
851:             .Left      = 690
852:             .Width     = 60
853:             .Height    = 17
854:             .FontName  = "Tahoma"
855:             .FontSize  = 8
856:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 862 a 888:
862:         loc_oPg2.AddObject("txt_4c_Media", "TextBox")
863:         WITH loc_oPg2.txt_4c_Media
864:             .Value         = 0
865:             .Top           = 302
866:             .Left          = 752
867:             .Width         = 68
868:             .Height        = 23
869:             .FontName      = "Tahoma"
870:             .FontSize      = 8
871:             .ForeColor     = RGB(90, 90, 90)
872:             .BackColor     = RGB(255, 255, 230)
873:             .ReadOnly      = .T.
874:             .Themes        = .F.
875:             .SpecialEffect = 0
876:             .Visible       = .T.
877:         ENDWITH
878: 
879:         loc_oPg2.AddObject("lbl_4c_Label3", "Label")
880:         WITH loc_oPg2.lbl_4c_Label3
881:             .Caption   = "Total :"
882:             .Top       = 332
883:             .Left      = 690
884:             .Width     = 60
885:             .Height    = 17
886:             .FontName  = "Tahoma"
887:             .FontSize  = 8
888:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 894 a 920:
894:         loc_oPg2.AddObject("txt_4c_Total", "TextBox")
895:         WITH loc_oPg2.txt_4c_Total
896:             .Value         = 0
897:             .Top           = 329
898:             .Left          = 752
899:             .Width         = 68
900:             .Height        = 23
901:             .FontName      = "Tahoma"
902:             .FontSize      = 8
903:             .ForeColor     = RGB(90, 90, 90)
904:             .BackColor     = RGB(255, 255, 230)
905:             .ReadOnly      = .T.
906:             .Themes        = .F.
907:             .SpecialEffect = 0
908:             .Visible       = .T.
909:         ENDWITH
910: 
911:         loc_oPg2.AddObject("lbl_4c_Label4", "Label")
912:         WITH loc_oPg2.lbl_4c_Label4
913:             .Caption   = "Total L" + CHR(237) + "q. :"
914:             .Top       = 359
915:             .Left      = 690
916:             .Width     = 60
917:             .Height    = 17
918:             .FontName  = "Tahoma"
919:             .FontSize  = 8
920:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 926 a 935:
926:         loc_oPg2.AddObject("txt_4c_TotLiq", "TextBox")
927:         WITH loc_oPg2.txt_4c_TotLiq
928:             .Value         = 0
929:             .Top           = 356
930:             .Left          = 752
931:             .Width         = 68
932:             .Height        = 23
933:             .FontName      = "Tahoma"
934:             .FontSize      = 8
935:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 1067 a 1080:
1067:         loc_oGrid.Column5.Width = 100
1068:         loc_oGrid.Column6.Width = 100
1069: 
1070:         loc_oGrid.Column1.Header1.Caption = "Conta"
1071:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1072:         loc_oGrid.Column3.Header1.Caption = "Data Base"
1073:         loc_oGrid.Column4.Header1.Caption = "Fator"
1074:         loc_oGrid.Column5.Header1.Caption = "Total"
1075:         loc_oGrid.Column6.Header1.Caption = "Valor Liquido"
1076: 
1077:         THIS.FormatarGridLista(loc_oGrid)
1078:     ENDPROC
1079: 
1080:     *--------------------------------------------------------------------------

*-- Linhas 1097 a 1109:
1097:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1098: 
1099:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
1100:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1101:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEdicao
1102:             ENDIF
1103:             IF PEMSTATUS(loc_oPg2.cnt_4c_BotoesAcao, "cmd_4c_Cancelar", 5)
1104:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled = .T.
1105:             ENDIF
1106:         ENDIF
1107:     ENDPROC
1108: 
1109:     *--------------------------------------------------------------------------

*-- Linhas 1291 a 1308:
1291:         loc_oPg2.opt_4c_OptDias.Enabled   = loc_lEdicao
1292: 
1293:         *-- BtnRec: habilitado em INCLUIR/ALTERAR; BtnVideo: habilitado em VISUALIZAR
1294:         loc_oPg2.cmd_4c_BtnRec.Enabled   = loc_lEdicao
1295:         loc_oPg2.cmd_4c_BtnVideo.Enabled = !loc_lEdicao
1296: 
1297:         *-- Grade Detalhe e botoes de linha: editaveis em INCLUIR/ALTERAR
1298:         IF PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5)
1299:             loc_oPg2.grd_4c_Detalhe.ReadOnly = !loc_lEdicao
1300:         ENDIF
1301:         IF PEMSTATUS(loc_oPg2, "cmd_4c_InserirV", 5)
1302:             loc_oPg2.cmd_4c_InserirV.Enabled = loc_lEdicao
1303:             loc_oPg2.cmd_4c_ExcluirV.Enabled = loc_lEdicao
1304:         ENDIF
1305:     ENDPROC
1306: 
1307:     *--------------------------------------------------------------------------
1308:     * LimparCampos - Limpa valores dos campos da Page2


### BO (C:\4c\projeto\app\classes\CCJBO.prg):
*============================================================================
* CCJBO.prg - Business Object para Calculo de Juros
*
* Tabela principal : SigCdCcj  (PK: codigo char(6))
* Tabela detalhe   : SigDtCcj  (PK: cidchaves char(20), FK: codigo char(6))
* Lookup conta     : SigCdCli  (PK: Iclis, desc: Rclis)
*
* Herda de: BusinessBase
* Criado em: Fase 1 - Propriedades e Init
*============================================================================

DEFINE CLASS CCJBO AS BusinessBase

    *==========================================================================
    * Propriedades da entidade SigCdCcj (campos do banco)
    *==========================================================================
    this_cCodigo   = ""    && char(6)       - Chave primaria (gerada externamente)
    this_cContas   = ""    && char(10)      - Conta (FK SigCdCli.Iclis)
    this_dDataBase = {}    && datetime NULL - Data Base para calculo de juros
    this_nFator    = 0     && numeric(5,2)  - Fator de juros (porcentagem)
    this_nTotal    = 0     && numeric(11,2) - Total bruto dos documentos
    this_nTotLiq   = 0     && numeric(11,2) - Total liquido apos calculo de juros

    *==========================================================================
    * Propriedades de exibicao - nao armazenadas no banco
    *==========================================================================
    this_cDContas   = ""   && Descricao da conta (SigCdCli.Rclis, exibicao)
    this_nQtde      = 0    && Quantidade de documentos no detalhe (calculada)
    this_nMedia     = 0    && Media de dias calculados
    this_nTiposDias = 1    && Tipo calculo: 1=Corridos, 2=Uteis (optDias.Value)

    *==========================================================================
    * Init - Inicializa o Business Object configurando tabela e chave primaria
    *==========================================================================
    PROCEDURE Init()
        LOCAL loc_lResultado
        loc_lResultado = .F.

        TRY
            DODEFAULT()
            THIS.this_cTabela     = "SigCdCcj"
            THIS.this_cCampoChave = "codigo"
            loc_lResultado = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *-- Alias do cursor de detalhe (SigDtCcj)
    this_cCursorDetalhe = "cursor_4c_Detalhe"

    *==========================================================================
    * ObterChavePrimaria - Retorna valor da PK para RegistrarAuditoria
    *==========================================================================
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigo
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigo   = ALLTRIM(TratarNulo(codigo, "C"))
            THIS.this_cContas   = ALLTRIM(TratarNulo(contas, "C"))
            THIS.this_dDataBase = TratarNulo(data_base, "D")
            THIS.this_nFator    = TratarNulo(fator, "N")
            THIS.this_nTotal    = TratarNulo(total, "N")
            THIS.this_nTotLiq   = TratarNulo(totliq, "N")
            THIS.this_lNovoRegistro = .F.
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Buscar - SELECT com JOIN SigCdCli para o grid da lista
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cWhere
        loc_lSucesso = .F.
        loc_cWhere   = ""

        TRY
            IF USED("cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            loc_cSQL = "SELECT a.codigo, a.contas, a.data_base, a.fator, a.total, a.totliq," + ;
                       " ISNULL(b.rclis, '') AS desconta" + ;
                       " FROM sigcdccj a" + ;
                       " LEFT JOIN sigcdcli b ON b.iclis = a.contas"

            IF VARTYPE(par_cFiltro) = "C" AND !EMPTY(ALLTRIM(par_cFiltro))
                loc_cWhere = " WHERE a.contas LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%") + ;
                             " OR ISNULL(b.rclis, '') LIKE " + EscaparSQL("%" + ALLTRIM(par_cFiltro) + "%")
                loc_cSQL = loc_cSQL + loc_cWhere
            ENDIF

            loc_cSQL = loc_cSQL + " ORDER BY a.contas, a.data_base DESC"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado > 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - SELECT pelo codigo (PK) para edicao/visualizacao
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF

            loc_cSQL = "SELECT codigo, contas, data_base, fator, total, totliq" + ;
                       " FROM sigcdccj" + ;
                       " WHERE codigo = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * GerarCodigo - Gera codigo unico de 6 chars via SQL Server NEWID()
    *==========================================================================
    PROCEDURE GerarCodigo()
        LOCAL loc_cSQL, loc_nResultado, loc_cNovoCodigo
        loc_cNovoCodigo = ""

        TRY
            IF USED("cursor_4c_GerarCod")
                USE IN cursor_4c_GerarCod
            ENDIF

            loc_cSQL = "SELECT UPPER(LEFT(REPLACE(NEWID(), '-', ''), 6)) AS novoCodigo"
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GerarCod")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_GerarCod") > 0
                SELECT cursor_4c_GerarCod
                loc_cNovoCodigo = ALLTRIM(novoCodigo)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_GerarCod")
            USE IN cursor_4c_GerarCod
        ENDIF

        RETURN loc_cNovoCodigo
    ENDPROC

    *==========================================================================
    * BuscarDetalhe - Carrega linhas de SigDtCcj para cursor de detalhe
    *                 Se par_cCodigo vazio, cria cursor vazio com a estrutura
    *==========================================================================
    PROCEDURE BuscarDetalhe(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED(THIS.this_cCursorDetalhe)
                USE IN (THIS.this_cCursorDetalhe)
            ENDIF

            IF EMPTY(ALLTRIM(par_cCodigo))
                SET NULL ON
                CREATE CURSOR (THIS.this_cCursorDetalhe) ;
                    (cidchaves C(20), codigo C(6), datas T, ;
                     dias N(3,0), liquido N(11,2), valor N(11,2))
                SET NULL OFF
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT cidchaves, codigo, datas, dias, liquido, valor" + ;
                           " FROM sigdtccj" + ;
                           " WHERE codigo = " + EscaparSQL(par_cCodigo) + ;
                           " ORDER BY datas"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DetLoad")

                IF loc_nResultado > 0
                    *-- Converte para READWRITE (SQLEXEC gera somente-leitura por padrao)
                    *-- Necessario para APPEND BLANK (InserirV) e REPLACE (Recalcular)
                    SELECT cidchaves, codigo, datas, dias, liquido, valor ;
                        FROM cursor_4c_DetLoad ;
                        INTO CURSOR (THIS.this_cCursorDetalhe) READWRITE
                    IF USED("cursor_4c_DetLoad")
                        USE IN cursor_4c_DetLoad
                    ENDIF
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * BuscarContaPorCodigo - Valida e retorna descricao de SigCdCli
    *==========================================================================
    PROCEDURE BuscarContaPorCodigo(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(par_cConta))
            THIS.this_cDContas = ""
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_BuscaConta")
                USE IN cursor_4c_BuscaConta
            ENDIF

            loc_cSQL = "SELECT iclis, rclis" + ;
                       " FROM sigcdcli" + ;
                       " WHERE iclis = " + EscaparSQL(par_cConta)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_BuscaConta")

            IF loc_nResultado > 0 AND RECCOUNT("cursor_4c_BuscaConta") > 0
                SELECT cursor_4c_BuscaConta
                THIS.this_cDContas = ALLTRIM(NVL(rclis, ""))
                loc_lSucesso = .T.
            ELSE
                THIS.this_cDContas = ""
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_BuscaConta")
            USE IN cursor_4c_BuscaConta
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * InserirDetalhe - PROTECTED: persiste cursor de detalhe em sigdtccj
    *==========================================================================
    PROTECTED PROCEDURE InserirDetalhe()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cAlias
        LOCAL loc_cCodigo, loc_dDatas, loc_nDias, loc_nLiquido, loc_nValor
        loc_lSucesso = .T.
        loc_cAlias   = THIS.this_cCursorDetalhe

        IF !USED(loc_cAlias)
            RETURN .T.
        ENDIF

        TRY
            SELECT (loc_cAlias)
            GO TOP

            SCAN
                IF EMPTY(datas)
                    LOOP
                ENDIF

                loc_cCodigo  = THIS.this_cCodigo
                loc_dDatas   = datas
                loc_nDias    = NVL(dias, 0)
                loc_nLiquido = NVL(liquido, 0)
                loc_nValor   = NVL(valor, 0)

                loc_cSQL = "INSERT INTO sigdtccj" + ;
                           " (cidchaves, codigo, datas, dias, liquido, valor)" + ;
                           " VALUES (" + ;
                           " LEFT(REPLACE(NEWID(), '-', ''), 20)," + ;
                           EscaparSQL(loc_cCodigo) + "," + ;
                           FormatarDataSQL(loc_dDatas) + "," + ;
                           FormatarNumeroSQL(loc_nDias) + "," + ;
                           FormatarNumeroSQL(loc_nLiquido) + "," + ;
                           FormatarNumeroSQL(loc_nValor) + ")"

                loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

                IF loc_nResultado < 0
                    MsgErro("Erro ao inserir linha de detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                    loc_lSucesso = .F.
                    EXIT
                ENDIF
            ENDSCAN
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - PROTECTED: INSERT em sigcdccj + linhas sigdtccj
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO sigcdccj (codigo, contas, data_base, fator, total, totliq)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       FormatarDataSQL(THIS.this_dDataBase) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFator) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotLiq) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                IF THIS.InserirDetalhe()
                    THIS.RegistrarAuditoria("INSERT")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao inserir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - PROTECTED: DELETE+INSERT (padrao legado msv_alterar)
    *             Delete cabecalho + detalhe antigos, reinsere com novos valores
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- DELETE detalhe primeiro (FK)
            loc_cSQL = "DELETE FROM sigdtccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao remover detalhe para atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- DELETE cabecalho
            loc_cSQL = "DELETE FROM sigcdccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao remover cabecalho para atualizar:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- RE-INSERT cabecalho com valores atualizados
            loc_cSQL = "INSERT INTO sigcdccj (codigo, contas, data_base, fator, total, totliq)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigo) + "," + ;
                       EscaparSQL(THIS.this_cContas) + "," + ;
                       FormatarDataSQL(THIS.this_dDataBase) + "," + ;
                       FormatarNumeroSQL(THIS.this_nFator) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotal) + "," + ;
                       FormatarNumeroSQL(THIS.this_nTotLiq) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                IF THIS.InserirDetalhe()
                    THIS.RegistrarAuditoria("UPDATE")
                    loc_lSucesso = .T.
                ENDIF
            ELSE
                MsgErro("Erro ao reinserir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - PROTECTED: DELETE de sigdtccj e sigcdccj
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- DELETE detalhe primeiro (integridade referencial)
            loc_cSQL = "DELETE FROM sigdtccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MsgErro("Erro ao excluir detalhe:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- DELETE cabecalho
            loc_cSQL = "DELETE FROM sigcdccj WHERE codigo = " + EscaparSQL(THIS.this_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir C" + CHR(225) + "lculo de Juros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Recalcular - Recalcula juros de cada linha do detalhe
    * Prerequisito: this_dDataBase, this_nFator e this_nTiposDias setados
    * Atualiza Dias/Liquido no cursor_4c_Detalhe e acumula this_n* totais
    *==========================================================================
    PROCEDURE Recalcular()
        LOCAL loc_lSucesso, loc_cAlias
        LOCAL loc_dBase, loc_nFator, loc_nTipo
        LOCAL loc_nQtde, loc_nTotalDias, loc_nTotal, loc_nTotLiq
        LOCAL loc_nDias, loc_nLiquido, loc_dDatas_d, loc_dBase_d, loc_nValor

        loc_lSucesso   = .F.
        loc_cAlias     = THIS.this_cCursorDetalhe
        loc_dBase      = THIS.this_dDataBase
        loc_nFator     = THIS.this_nFator
        loc_nTipo      = THIS.this_nTiposDias
        loc_nQtde      = 0
        loc_nTotalDias = 0
        loc_nTotal     = 0
        loc_nTotLiq    = 0

        IF !USED(loc_cAlias)
            MsgErro("Cursor de detalhe n" + CHR(227) + "o dispon" + CHR(237) + "vel.", "Recalcular")
            RETURN .F.
        ENDIF

        IF EMPTY(loc_dBase)
            MsgErro("Data Base n" + CHR(227) + "o informada.", "Recalcular")
            RETURN .F.
        ENDIF

        TRY
            loc_dBase_d = TTOD(loc_dBase)

            SELECT (loc_cAlias)
            GO TOP

            SCAN
                IF EMPTY(datas)
                    LOOP
                ENDIF

                loc_dDatas_d = TTOD(datas)
                loc_nValor   = NVL(valor, 0)
                loc_nDias    = loc_dDatas_d - loc_dBase_d

                IF loc_nDias < 0
                    loc_nDias = 0
                ENDIF

                IF loc_nDias > 0 AND loc_nTipo = 2
                    loc_nDias = THIS.ContarDiasUteis(loc_dBase_d, loc_dDatas_d)
                ENDIF

                loc_nLiquido = loc_nValor + loc_nValor * (loc_nFator / 100) * loc_nDias

                REPLACE dias WITH loc_nDias, liquido WITH loc_nLiquido

                loc_nQtde      = loc_nQtde + 1
                loc_nTotalDias = loc_nTotalDias + loc_nDias
                loc_nTotal     = loc_nTotal + loc_nValor
                loc_nTotLiq    = loc_nTotLiq + loc_nLiquido
            ENDSCAN

            THIS.this_nQtde   = loc_nQtde
            THIS.this_nMedia  = IIF(loc_nQtde > 0, loc_nTotalDias / loc_nQtde, 0)
            THIS.this_nTotal  = loc_nTotal
            THIS.this_nTotLiq = loc_nTotLiq

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Recalcular")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ContarDiasUteis - Conta dias seg-sex entre par_dInicio e par_dFim (inc.)
    *==========================================================================
    PROTECTED PROCEDURE ContarDiasUteis(par_dInicio, par_dFim)
        LOCAL loc_nCount, loc_dCurrent, loc_nDow
        loc_nCount   = 0
        loc_dCurrent = par_dInicio

        DO WHILE loc_dCurrent <= par_dFim
            loc_nDow = DOW(loc_dCurrent)
            IF loc_nDow != 1 AND loc_nDow != 7
                loc_nCount = loc_nCount + 1
            ENDIF
            loc_dCurrent = loc_dCurrent + 1
        ENDDO

        RETURN loc_nCount
    ENDPROC

ENDDEFINE

