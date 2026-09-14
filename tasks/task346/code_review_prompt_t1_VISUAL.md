# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (8)
- [FONTNAME-ERRADO] Linha 186: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 209: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 232: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 255: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 278: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 320: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 408: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 431: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormAli.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1268 linhas total):

*-- Linhas 59 a 68:
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61: 
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
66:                     THIS.CarregarLista()
67:                 ENDIF
68: 

*-- Linhas 88 a 105:
88: 
89:         WITH loc_oPgf
90:             .PageCount = 2
91:             .Top       = -29
92:             .Left      = 0
93:             .Width     = THIS.Width
94:             .Height    = THIS.Height + 29
95:             .Tabs      = .F.
96:             .Visible   = .T.
97:             .Page1.Caption   = "Lista"
98:             .Page1.BackColor = RGB(100, 100, 100)
99:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
100:             .Page2.Caption   = "Dados"
101:             .Page2.BackColor = RGB(100, 100, 100)
102:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
103:         ENDWITH
104: 
105:         THIS.ConfigurarPaginaLista()

*-- Linhas 113 a 155:
113:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida
114:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
115: 
116:         *-- Container cabecalho cinza (Top = 2 + 29 = 31, compensacao PageFrame.Top=-29)
117:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
118:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
119:         WITH loc_oCab
120:             .Top         = 31
121:             .Left        = 0
122:             .Width       = THIS.Width
123:             .Height      = 80
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126:             .Visible     = .T.
127:         ENDWITH
128: 
129:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
130:         WITH loc_oCab.lbl_4c_Sombra
131:             .AutoSize  = .F.
132:             .Caption   = THIS.Caption
133:             .Top       = 15
134:             .Left      = 10
135:             .Width     = THIS.Width
136:             .Height    = 40
137:             .FontName  = "Tahoma"
138:             .FontSize  = 16
139:             .FontBold  = .T.
140:             .ForeColor = RGB(0, 0, 0)
141:             .BackStyle = 0
142:             .Visible   = .T.
143:         ENDWITH
144: 
145:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
146:         WITH loc_oCab.lbl_4c_Titulo
147:             .AutoSize  = .F.
148:             .Caption   = THIS.Caption
149:             .Top       = 18
150:             .Left      = 10
151:             .Width     = THIS.Width
152:             .Height    = 46
153:             .FontName  = "Tahoma"
154:             .FontSize  = 16
155:             .FontBold  = .T.

*-- Linhas 162 a 347:
162:         loc_oPg1.AddObject("cnt_4c_Botoes", "Container")
163:         loc_oBotoes = loc_oPg1.cnt_4c_Botoes
164:         WITH loc_oBotoes
165:             .Top         = 29
166:             .Left        = 542
167:             .Width       = 390
168:             .Height      = 85
169:             .BackColor   = RGB(53, 53, 53)
170:             .BackStyle   = 1
171:             .BorderWidth = 0
172:             .Visible     = .T.
173:         ENDWITH
174: 
175:         loc_oBotoes.AddObject("cmd_4c_Incluir", "CommandButton")
176:         WITH loc_oBotoes.cmd_4c_Incluir
177:             .Caption         = "Incluir"
178:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
179:             .PicturePosition = 13
180:             .Top             = 5
181:             .Left            = 5
182:             .Width           = 75
183:             .Height          = 75
184:             .BackColor       = RGB(255, 255, 255)
185:             .ForeColor       = RGB(90, 90, 90)
186:             .FontName        = "Comic Sans MS"
187:             .FontSize        = 8
188:             .FontBold        = .T.
189:             .FontItalic      = .T.
190:             .Themes          = .F.
191:             .SpecialEffect   = 0
192:             .MousePointer    = 15
193:             .WordWrap        = .T.
194:             .AutoSize        = .F.
195:             .Visible         = .T.
196:         ENDWITH
197: 
198:         loc_oBotoes.AddObject("cmd_4c_Visualizar", "CommandButton")
199:         WITH loc_oBotoes.cmd_4c_Visualizar
200:             .Caption         = "Visualizar"
201:             .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
202:             .PicturePosition = 13
203:             .Top             = 5
204:             .Left            = 80
205:             .Width           = 75
206:             .Height          = 75
207:             .BackColor       = RGB(255, 255, 255)
208:             .ForeColor       = RGB(90, 90, 90)
209:             .FontName        = "Comic Sans MS"
210:             .FontSize        = 8
211:             .FontBold        = .T.
212:             .FontItalic      = .T.
213:             .Themes          = .F.
214:             .SpecialEffect   = 0
215:             .MousePointer    = 15
216:             .WordWrap        = .T.
217:             .AutoSize        = .F.
218:             .Visible         = .T.
219:         ENDWITH
220: 
221:         loc_oBotoes.AddObject("cmd_4c_Alterar", "CommandButton")
222:         WITH loc_oBotoes.cmd_4c_Alterar
223:             .Caption         = "Alterar"
224:             .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
225:             .PicturePosition = 13
226:             .Top             = 5
227:             .Left            = 155
228:             .Width           = 75
229:             .Height          = 75
230:             .BackColor       = RGB(255, 255, 255)
231:             .ForeColor       = RGB(90, 90, 90)
232:             .FontName        = "Comic Sans MS"
233:             .FontSize        = 8
234:             .FontBold        = .T.
235:             .FontItalic      = .T.
236:             .Themes          = .F.
237:             .SpecialEffect   = 0
238:             .MousePointer    = 15
239:             .WordWrap        = .T.
240:             .AutoSize        = .F.
241:             .Visible         = .T.
242:         ENDWITH
243: 
244:         loc_oBotoes.AddObject("cmd_4c_Excluir", "CommandButton")
245:         WITH loc_oBotoes.cmd_4c_Excluir
246:             .Caption         = "Excluir"
247:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
248:             .PicturePosition = 13
249:             .Top             = 5
250:             .Left            = 230
251:             .Width           = 75
252:             .Height          = 75
253:             .BackColor       = RGB(255, 255, 255)
254:             .ForeColor       = RGB(90, 90, 90)
255:             .FontName        = "Comic Sans MS"
256:             .FontSize        = 8
257:             .FontBold        = .T.
258:             .FontItalic      = .T.
259:             .Themes          = .F.
260:             .SpecialEffect   = 0
261:             .MousePointer    = 15
262:             .WordWrap        = .T.
263:             .AutoSize        = .F.
264:             .Visible         = .T.
265:         ENDWITH
266: 
267:         loc_oBotoes.AddObject("cmd_4c_Buscar", "CommandButton")
268:         WITH loc_oBotoes.cmd_4c_Buscar
269:             .Caption         = "Buscar"
270:             .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
271:             .PicturePosition = 13
272:             .Top             = 5
273:             .Left            = 305
274:             .Width           = 75
275:             .Height          = 75
276:             .BackColor       = RGB(255, 255, 255)
277:             .ForeColor       = RGB(90, 90, 90)
278:             .FontName        = "Comic Sans MS"
279:             .FontSize        = 8
280:             .FontBold        = .T.
281:             .FontItalic      = .T.
282:             .Themes          = .F.
283:             .SpecialEffect   = 0
284:             .MousePointer    = 15
285:             .WordWrap        = .T.
286:             .AutoSize        = .F.
287:             .Visible         = .T.
288:         ENDWITH
289: 
290:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
291:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
292:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
293:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
294:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
295: 
296:         *-- Container Encerrar (canonico: Left=917, Width=90)
297:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
298:         loc_oSaida = loc_oPg1.cnt_4c_Saida
299:         WITH loc_oSaida
300:             .Top         = 29
301:             .Left        = 917
302:             .Width       = 90
303:             .Height      = 85
304:             .BackStyle   = 0
305:             .BorderWidth = 0
306:             .Visible     = .T.
307:         ENDWITH
308: 
309:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
310:         WITH loc_oSaida.cmd_4c_Encerrar
311:             .Caption         = "Encerrar"
312:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
313:             .PicturePosition = 13
314:             .Top             = 5
315:             .Left            = 5
316:             .Width           = 75
317:             .Height          = 75
318:             .BackColor       = RGB(255, 255, 255)
319:             .ForeColor       = RGB(90, 90, 90)
320:             .FontName        = "Comic Sans MS"
321:             .FontSize        = 8
322:             .FontBold        = .T.
323:             .FontItalic      = .T.
324:             .Themes          = .F.
325:             .SpecialEffect   = 0
326:             .MousePointer    = 15
327:             .WordWrap        = .T.
328:             .AutoSize        = .F.
329:             .Visible         = .T.
330:         ENDWITH
331: 
332:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
333: 
334:         *-- Grid de listagem (Top=88+29=117, Left=12, Width=890, Height=480)
335:         *-- RecordSource e ColumnCount FORA do WITH para criar colunas imediatamente
336:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
337:         loc_oPg1.grd_4c_Lista.RecordSource = ""
338:         loc_oPg1.grd_4c_Lista.ColumnCount  = 4
339: 
340:         WITH loc_oPg1.grd_4c_Lista
341:             .Top                     = 117
342:             .Left                    = 12
343:             .Width                   = 890
344:             .Height                  = 480
345:             .FontName                = "Verdana"
346:             .FontSize                = 8
347:             .ForeColor               = RGB(90, 90, 90)

*-- Linhas 365 a 376:
365:             .Column2.ReadOnly        = .T.
366:             .Column3.ReadOnly        = .T.
367:             .Column4.ReadOnly        = .T.
368:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
369:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
370:             .Column3.Header1.Caption = "Oper. Autom. Cheque"
371:             .Column4.Header1.Caption = "Cond. Pag. Autom."
372:         ENDWITH
373: 
374:         THIS.TornarControlesVisiveis(loc_oPg1)
375:     ENDPROC
376: 

*-- Linhas 385 a 456:
385:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
386:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
387:         WITH loc_oBotoesAcao
388:             .Top         = 33
389:             .Left        = 842
390:             .Width       = 160
391:             .Height      = 85
392:             .BackStyle   = 0
393:             .BorderWidth = 0
394:             .Visible     = .T.
395:         ENDWITH
396: 
397:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
398:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
399:             .Caption         = "Confirmar"
400:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
401:             .PicturePosition = 13
402:             .Top             = 5
403:             .Left            = 5
404:             .Width           = 75
405:             .Height          = 75
406:             .BackColor       = RGB(255, 255, 255)
407:             .ForeColor       = RGB(90, 90, 90)
408:             .FontName        = "Comic Sans MS"
409:             .FontSize        = 8
410:             .FontBold        = .T.
411:             .FontItalic      = .T.
412:             .Themes          = .F.
413:             .SpecialEffect   = 0
414:             .MousePointer    = 15
415:             .WordWrap        = .T.
416:             .AutoSize        = .F.
417:             .Visible         = .T.
418:         ENDWITH
419: 
420:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
421:         WITH loc_oBotoesAcao.cmd_4c_Cancelar
422:             .Caption         = "Encerrar"
423:             .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
424:             .PicturePosition = 13
425:             .Top             = 5
426:             .Left            = 80
427:             .Width           = 75
428:             .Height          = 75
429:             .BackColor       = RGB(255, 255, 255)
430:             .ForeColor       = RGB(90, 90, 90)
431:             .FontName        = "Comic Sans MS"
432:             .FontSize        = 8
433:             .FontBold        = .T.
434:             .FontItalic      = .T.
435:             .Themes          = .F.
436:             .SpecialEffect   = 0
437:             .MousePointer    = 15
438:             .WordWrap        = .T.
439:             .AutoSize        = .F.
440:             .Visible         = .T.
441:         ENDWITH
442: 
443:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
444:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
445: 
446:         *-- Label Codigo (Say1: top=171+29=200, left=288, width=42)
447:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
448:         WITH loc_oPg2.lbl_4c_Label1
449:             .Caption   = "C" + CHR(243) + "digo :"
450:             .Top       = 200
451:             .Left      = 288
452:             .Width     = 42
453:             .Height    = 17
454:             .AutoSize  = .F.
455:             .FontName  = "Tahoma"
456:             .FontSize  = 8

*-- Linhas 465 a 474:
465:         loc_oPg2.AddObject("txt_4c_Codigos", "TextBox")
466:         WITH loc_oPg2.txt_4c_Codigos
467:             .Value         = 0
468:             .Top           = 197
469:             .Left          = 335
470:             .Width         = 33
471:             .Height        = 21
472:             .FontName      = "Tahoma"
473:             .FontSize      = 8
474:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 481 a 493:
481:         ENDWITH
482: 
483:         *-- Label Descricao (Say2: top=196+29=225, left=275, width=60)
484:         loc_oPg2.AddObject("lbl_4c_Label2", "Label")
485:         WITH loc_oPg2.lbl_4c_Label2
486:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
487:             .Top       = 225
488:             .Left      = 275
489:             .Width     = 60
490:             .Height    = 17
491:             .AutoSize  = .F.
492:             .FontName  = "Tahoma"
493:             .FontSize  = 8

*-- Linhas 502 a 528:
502:         loc_oPg2.AddObject("txt_4c_Descrs", "TextBox")
503:         WITH loc_oPg2.txt_4c_Descrs
504:             .Value         = ""
505:             .Top           = 222
506:             .Left          = 335
507:             .Width         = 290
508:             .Height        = 21
509:             .FontName      = "Tahoma"
510:             .FontSize      = 8
511:             .ForeColor     = RGB(90, 90, 90)
512:             .BackColor     = RGB(255, 255, 255)
513:             .BorderStyle   = 1
514:             .SpecialEffect = 0
515:             .Visible       = .T.
516:         ENDWITH
517: 
518:         *-- Label Operacao Cheque Automatica (Say3: top=221+29=250, left=162, width=173)
519:         loc_oPg2.AddObject("lbl_4c_Label3", "Label")
520:         WITH loc_oPg2.lbl_4c_Label3
521:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Cheque Autom" + CHR(225) + "tica :"
522:             .Top       = 250
523:             .Left      = 162
524:             .Width     = 173
525:             .Height    = 17
526:             .AutoSize  = .F.
527:             .FontName  = "Tahoma"
528:             .FontSize  = 8

*-- Linhas 537 a 546:
537:         loc_oPg2.AddObject("txt_4c_OpAutos", "TextBox")
538:         WITH loc_oPg2.txt_4c_OpAutos
539:             .Value         = ""
540:             .Top           = 247
541:             .Left          = 335
542:             .Width         = 115
543:             .Height        = 21
544:             .FontName      = "Tahoma"
545:             .FontSize      = 8
546:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 553 a 565:
553:         BINDEVENT(loc_oPg2.txt_4c_OpAutos, "KeyPress", THIS, "ValidarOpAutos")
554: 
555:         *-- Label Operacao Saida de Cheque (Say4: top=246+29=275, left=175)
556:         loc_oPg2.AddObject("lbl_4c_Label4", "Label")
557:         WITH loc_oPg2.lbl_4c_Label4
558:             .Caption   = "Opera" + CHR(231) + CHR(227) + "o de Saida de Cheque :"
559:             .Top       = 275
560:             .Left      = 175
561:             .Width     = 190
562:             .Height    = 17
563:             .AutoSize  = .F.
564:             .FontName  = "Tahoma"
565:             .FontSize  = 8

*-- Linhas 574 a 583:
574:         loc_oPg2.AddObject("txt_4c_OpSaidas", "TextBox")
575:         WITH loc_oPg2.txt_4c_OpSaidas
576:             .Value         = ""
577:             .Top           = 272
578:             .Left          = 335
579:             .Width         = 115
580:             .Height        = 21
581:             .FontName      = "Tahoma"
582:             .FontSize      = 8
583:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 590 a 602:
590:         BINDEVENT(loc_oPg2.txt_4c_OpSaidas, "KeyPress", THIS, "ValidarOpSaidas")
591: 
592:         *-- Label Condicao de Pagamento Automatica (Say5: top=271+29=300, left=148)
593:         loc_oPg2.AddObject("lbl_4c_Label5", "Label")
594:         WITH loc_oPg2.lbl_4c_Label5
595:             .Caption   = "Condi" + CHR(231) + CHR(227) + "o de Pagamento Automatica :"
596:             .Top       = 300
597:             .Left      = 148
598:             .Width     = 215
599:             .Height    = 17
600:             .AutoSize  = .F.
601:             .FontName  = "Tahoma"
602:             .FontSize  = 8

*-- Linhas 611 a 620:
611:         loc_oPg2.AddObject("txt_4c_FPagSAutos", "TextBox")
612:         WITH loc_oPg2.txt_4c_FPagSAutos
613:             .Value         = ""
614:             .Top           = 297
615:             .Left          = 335
616:             .Width         = 94
617:             .Height        = 21
618:             .FontName      = "Tahoma"
619:             .FontSize      = 8
620:             .ForeColor     = RGB(90, 90, 90)

*-- Linhas 627 a 639:
627:         BINDEVENT(loc_oPg2.txt_4c_FPagSAutos, "KeyPress", THIS, "ValidarFPagSAutos")
628: 
629:         *-- Label Gera Pendencias Financeiras (Say6: top=295+29=324, left=184)
630:         loc_oPg2.AddObject("lbl_4c_Label6", "Label")
631:         WITH loc_oPg2.lbl_4c_Label6
632:             .Caption   = "Gera Pend" + CHR(234) + "ncias Financeiras :"
633:             .Top       = 324
634:             .Left      = 184
635:             .Width     = 180
636:             .Height    = 17
637:             .AutoSize  = .F.
638:             .FontName  = "Tahoma"
639:             .FontSize  = 8

*-- Linhas 649 a 679:
649:         loc_oPg2.AddObject("opt_4c_OptPefins", "OptionGroup")
650:         WITH loc_oPg2.opt_4c_OptPefins
651:             .ButtonCount = 2
652:             .Top         = 320
653:             .Left        = 335
654:             .Width       = 96
655:             .Height      = 27
656:             .AutoSize    = .T.
657:             .BackStyle   = 0
658:             .BorderStyle = 0
659:             .Value       = 2
660:             .Visible     = .T.
661:             WITH .Buttons(1)
662:                 .Caption   = "\<Sim"
663:                 .Left      = 5
664:                 .Top       = 5
665:                 .Width     = 40
666:                 .Height    = 17
667:                 .AutoSize  = .F.
668:                 .BackStyle = 0
669:                 .ForeColor = RGB(90, 90, 90)
670:             ENDWITH
671:             WITH .Buttons(2)
672:                 .Caption   = "\<N" + CHR(227) + "o"
673:                 .Left      = 51
674:                 .Top       = 5
675:                 .Width     = 40
676:                 .Height    = 17
677:                 .AutoSize  = .F.
678:                 .FontName  = "Tahoma"
679:                 .FontSize  = 8

*-- Linhas 718 a 729:
718:                         loc_oGrid.Column3.ReadOnly = .T.
719:                         loc_oGrid.Column4.ReadOnly = .T.
720: 
721:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
722:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
723:                         loc_oGrid.Column3.Header1.Caption = "Oper. Autom. Cheque"
724:                         loc_oGrid.Column4.Header1.Caption = "Cond. Pag. Autom."
725: 
726:                         THIS.FormatarGridLista(loc_oGrid)
727:                     ENDIF
728:                     loc_lResultado = .T.
729:                 ENDIF

*-- Linhas 1117 a 1126:
1117: 
1118:         TRY
1119:             *-- Confirmar habilitado em INCLUIR, ALTERAR e BUSCAR; desabilitado em VISUALIZAR
1120:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
1121:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
1122:         CATCH TO loc_oErro
1123:             MsgErro(loc_oErro.Message, "FormAli.AjustarBotoesPorModo")
1124:         ENDTRY
1125:     ENDPROC
1126: 


### BO (C:\4c\projeto\app\classes\AliBO.prg):
*====================================================================
* AliBO.prg
*
* Business Object para Alineas
* Tabela: SIGCDALI
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS AliBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDALI)
	this_nCodigos    = 0    && codigos numeric(3,0) - PK
	this_cDescrs     = ""   && descrs char(40)
	this_cOpAutos    = ""   && opautos char(15) - FK SigCdOpt.Operacaos
	this_cOpSaidas   = ""   && opsaidas char(15) - FK SigCdOpt.Operacaos
	this_cFPagSAutos = ""   && fpagsautos char(12) - FK SigOpFp.Fpags
	this_nPefins     = 2    && pefins numeric(1,0) - 1=Sim, 2=Nao
	this_nReincids   = 0    && reincids numeric(4,2) - nao exibido no form

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDALI"
		THIS.this_cCampoChave = "codigos"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN TRANSFORM(THIS.this_nCodigos)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de alineas no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
				           " FROM SigCdAli" + ;
				           " ORDER BY codigos"
			ELSE
				loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
				           " FROM SigCdAli" + ;
				           " WHERE codigos = " + FormatarNumeroSQL(VAL(ALLTRIM(par_cFiltro))) + ;
				           " ORDER BY codigos"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar al" + CHR(237) + "neas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar al" + CHR(237) + "neas:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_nCodigo)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT codigos, descrs, opautos, fpagsautos, opsaidas, pefins, reincids" + ;
			           " FROM SigCdAli" + ;
			           " WHERE codigos = " + FormatarNumeroSQL(par_nCodigo)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_nCodigos    = TratarNulo(codigos, "N")
			THIS.this_cDescrs     = TratarNulo(descrs, "C")
			THIS.this_cOpAutos    = TratarNulo(opautos, "C")
			THIS.this_cOpSaidas   = TratarNulo(opsaidas, "C")
			THIS.this_cFPagSAutos = TratarNulo(fpagsautos, "C")
			THIS.this_nPefins     = TratarNulo(pefins, "N")
			THIS.this_nReincids   = TratarNulo(reincids, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SigCdAli (codigos, descrs, opautos, opsaidas, fpagsautos, pefins)" + ;
			           " VALUES (" + ;
			           FormatarNumeroSQL(THIS.this_nCodigos) + "," + ;
			           EscaparSQL(THIS.this_cDescrs) + "," + ;
			           EscaparSQL(THIS.this_cOpAutos) + "," + ;
			           EscaparSQL(THIS.this_cOpSaidas) + "," + ;
			           EscaparSQL(THIS.this_cFPagSAutos) + "," + ;
			           FormatarNumeroSQL(THIS.this_nPefins) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SigCdAli SET" + ;
			           " descrs = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
			           " opautos = " + EscaparSQL(THIS.this_cOpAutos) + "," + ;
			           " opsaidas = " + EscaparSQL(THIS.this_cOpSaidas) + "," + ;
			           " fpagsautos = " + EscaparSQL(THIS.this_cFPagSAutos) + "," + ;
			           " pefins = " + FormatarNumeroSQL(THIS.this_nPefins) + ;
			           " WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE da tabela SigCdAli
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "DELETE FROM SigCdAli WHERE codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("DELETE")
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao excluir al" + CHR(237) + "nea:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir al" + CHR(237) + "nea:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

