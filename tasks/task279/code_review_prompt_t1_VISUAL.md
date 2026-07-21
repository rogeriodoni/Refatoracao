# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [LAYOUT-POSITION] Controle 'Opt_Tipo' (parent: SIGPRENV): Top original=179 vs migrado 'obj_4c_Opt_Tipo' Top=10 (diff=169px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Tipo' (parent: SIGPRENV): Left original=140 vs migrado 'obj_4c_Opt_Tipo' Left=10 (diff=130px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRENV): Top original=180 vs migrado 'obj_4c_Opt_Impressora' Top=10 (diff=170px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Opt_Impressora' (parent: SIGPRENV): Left original=396 vs migrado 'obj_4c_Opt_Impressora' Left=10 (diff=386px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprenv.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1029 linhas total):

*-- Linhas 30 a 38:
30:         loc_lSucesso = .F.
31: 
32:         TRY
33:             THIS.Caption = "Impress" + CHR(227) + "o de etiquetas de envelopes"
34:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
35: 
36:             THIS.this_oBusinessObject = CREATEOBJECT("sigprenvBO")
37:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
38:                 THIS.ConfigurarPageFrame()

*-- Linhas 77 a 122:
77:     PROTECTED PROCEDURE ConfigurarCabecalho()
78:         THIS.AddObject("cnt_4c_Sombra", "Container")
79:         WITH THIS.cnt_4c_Sombra
80:             .Top         = 0
81:             .Left        = 0
82:             .Width       = THIS.Width
83:             .Height      = 80
84:             .BackStyle   = 1
85:             .BackColor   = RGB(100, 100, 100)
86:             .BorderWidth = 0
87:             .Visible     = .T.
88: 
89:             .AddObject("lbl_4c_LblSombra", "Label")
90:             WITH .lbl_4c_LblSombra
91:                 .Top       = 18
92:                 .Left      = 10
93:                 .Width     = THIS.Width
94:                 .Height    = 40
95:                 .AutoSize  = .F.
96:                 .FontName  = "Tahoma"
97:                 .FontSize  = 18
98:                 .FontBold  = .T.
99:                 .BackStyle = 0
100:                 .ForeColor = RGB(0, 0, 0)
101:                 .Caption   = THIS.Caption
102:                 .Visible   = .T.
103:             ENDWITH
104: 
105:             .AddObject("lbl_4c_LblTitulo", "Label")
106:             WITH .lbl_4c_LblTitulo
107:                 .Top       = 17
108:                 .Left      = 10
109:                 .Width     = THIS.Width
110:                 .Height    = 46
111:                 .AutoSize  = .F.
112:                 .FontName  = "Tahoma"
113:                 .FontSize  = 18
114:                 .FontBold  = .T.
115:                 .BackStyle = 0
116:                 .ForeColor = RGB(255, 255, 255)
117:                 .Caption   = THIS.Caption
118:                 .Visible   = .T.
119:             ENDWITH
120:         ENDWITH
121:     ENDPROC
122: 

*-- Linhas 130 a 170:
130:             .BackStyle     = 0
131:             .BorderStyle   = 0
132:             .Height        = 110
133:             .Left          = 636
134:             .SpecialEffect = 1
135:             .Top           = -2
136:             .Width         = 171
137:             .Themes        = .F.
138:             .Visible       = .T.
139: 
140:             WITH .Buttons(1)
141:                 .Top        = 5
142:                 .Left       = 10
143:                 .Height     = 75
144:                 .Width      = 75
145:                 .FontBold   = .T.
146:                 .FontItalic = .T.
147:                 .Picture    = gc_4c_CaminhoIcones + "geral_impressora_60.jpg"
148:                 .Caption    = "\<Imprimir"
149:                 .ForeColor  = RGB(90, 90, 90)
150:                 .BackColor  = RGB(255, 255, 255)
151:                 .Themes     = .F.
152:             ENDWITH
153: 
154:             WITH .Buttons(2)
155:                 .Top        = 5
156:                 .Left       = 86
157:                 .Height     = 75
158:                 .Width      = 75
159:                 .FontBold   = .T.
160:                 .FontItalic = .T.
161:                 .FontName   = "Tahoma"
162:                 .FontSize   = 8
163:                 .Picture    = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
164:                 .Cancel     = .T.
165:                 .Caption    = "Encerrar"
166:                 .ForeColor  = RGB(90, 90, 90)
167:                 .BackColor  = RGB(255, 255, 255)
168:                 .Themes     = .F.
169:             ENDWITH
170:         ENDWITH

*-- Linhas 178 a 225:
178:     PROTECTED PROCEDURE ConfigurarPaginaDados()
179: 
180:         *-- Label e TextBox Etiqueta Inicial
181:         THIS.AddObject("lbl_4c_Lbl_Etq", "Label")
182:         WITH THIS.lbl_4c_Lbl_Etq
183:             .AutoSize  = .T.
184:             .FontName  = "Tahoma"
185:             .FontSize  = 8
186:             .BackStyle = 0
187:             .Caption   = "Etiqueta Inicial :"
188:             .Height    = 15
189:             .Left      = 155
190:             .Top       = 129
191:             .Width     = 79
192:             .ForeColor = RGB(90, 90, 90)
193:             .Visible   = .T.
194:         ENDWITH
195: 
196:         THIS.AddObject("txt_4c_Etq_Ini", "TextBox")
197:         WITH THIS.txt_4c_Etq_Ini
198:             .FontName            = "Tahoma"
199:             .FontSize            = 8
200:             .Height              = 23
201:             .InputMask           = "99999999"
202:             .Left                = 237
203:             .Top                 = 125
204:             .Width               = 66
205:             .Value               = 0
206:             .DisabledBackColor   = RGB(255, 255, 255)
207:             .Visible             = .T.
208:         ENDWITH
209: 
210:         *-- Label e TextBox Quantidade
211:         THIS.AddObject("lbl_4c_Lbl_Qtd", "Label")
212:         WITH THIS.lbl_4c_Lbl_Qtd
213:             .AutoSize  = .T.
214:             .FontName  = "Tahoma"
215:             .FontSize  = 8
216:             .BackStyle = 0
217:             .Caption   = "Quantidade :"
218:             .Height    = 15
219:             .Left      = 328
220:             .Top       = 129
221:             .Width     = 65
222:             .ForeColor = RGB(90, 90, 90)
223:             .Visible   = .T.
224:         ENDWITH
225: 

*-- Linhas 232 a 282:
232:             .Height    = 23
233:             .InputMask = "99999999"
234:             .MaxLength = 8
235:             .Left      = 397
236:             .Top       = 125
237:             .Width     = 66
238:             .Value     = 0
239:             .Visible   = .T.
240:         ENDWITH
241: 
242:         *-- Label Tipo de etiqueta
243:         THIS.AddObject("lbl_4c_Lbl_TpEti", "Label")
244:         WITH THIS.lbl_4c_Lbl_TpEti
245:             .AutoSize  = .T.
246:             .FontBold  = .T.
247:             .FontName  = "Tahoma"
248:             .FontSize  = 8
249:             .BackStyle = 0
250:             .Caption   = "Tipo de etiqueta "
251:             .Height    = 15
252:             .Left      = 150
253:             .Top       = 166
254:             .Width     = 97
255:             .ForeColor = RGB(90, 90, 90)
256:             .Visible   = .T.
257:         ENDWITH
258: 
259:         *-- OptionGroup Tipo de etiqueta (botoes populados dinamicamente em CarregarDados)
260:         THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
261:         WITH THIS.obj_4c_Opt_Tipo
262:             .AutoSize      = .F.
263:             .ButtonCount   = 1
264:             .BackStyle     = 0
265:             .Height        = 182
266:             .Left          = 140
267:             .SpecialEffect = 1
268:             .Top           = 179
269:             .Width         = 240
270:             .Themes        = .F.
271:             WITH .Buttons(1)
272:                 .BackStyle = 0
273:                 .Caption   = "\<a. Rabicho"
274:                 .Height    = 22
275:                 .Left      = 10
276:                 .Style     = 0
277:                 .Top       = 10
278:                 .Width     = 222
279:                 .ForeColor = RGB(90, 90, 90)
280:             ENDWITH
281:             .Value   = 1
282:             .Visible = .T.

*-- Linhas 291 a 509:
291:     PROTECTED PROCEDURE ConfigurarControlesImpressora()
292: 
293:         *-- Label Impressora
294:         THIS.AddObject("lbl_4c_Label2", "Label")
295:         WITH THIS.lbl_4c_Label2
296:             .AutoSize  = .T.
297:             .FontBold  = .T.
298:             .FontName  = "Tahoma"
299:             .FontSize  = 8
300:             .BackStyle = 0
301:             .Caption   = "Impressora "
302:             .Height    = 15
303:             .Left      = 409
304:             .Top       = 167
305:             .Width     = 71
306:             .ForeColor = RGB(90, 90, 90)
307:             .Visible   = .T.
308:         ENDWITH
309: 
310:         *-- OptionGroup Impressora (botoes populados dinamicamente em CarregarDados)
311:         THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
312:         WITH THIS.obj_4c_Opt_Impressora
313:             .AutoSize      = .F.
314:             .ButtonCount   = 1
315:             .BackStyle     = 0
316:             .Height        = 105
317:             .Left          = 396
318:             .SpecialEffect = 1
319:             .Top           = 180
320:             .Width         = 254
321:             .Themes        = .F.
322:             WITH .Buttons(1)
323:                 .BackStyle = 0
324:                 .Caption   = " \<1. Gen" + CHR(233) + "rico/Somente Texto"
325:                 .Height    = 17
326:                 .Left      = 10
327:                 .Style     = 0
328:                 .Top       = 10
329:                 .Width     = 238
330:                 .ForeColor = RGB(90, 90, 90)
331:             ENDWITH
332:             .Value   = 1
333:             .Visible = .T.
334:         ENDWITH
335: 
336:         *-- Container Ajustes Impressora (Cnt_Impressora)
337:         THIS.AddObject("cnt_4c__Impressora", "Container")
338:         WITH THIS.cnt_4c__Impressora
339:             .Top         = 289
340:             .Left        = 396
341:             .Width       = 254
342:             .Height      = 67
343:             .BackStyle   = 0
344:             .BorderWidth = 0
345:             .Visible     = .T.
346: 
347:             *-- Labels dos spinners
348:             .AddObject("lbl_4c_Say2", "Label")
349:             WITH .lbl_4c_Say2
350:                 .FontName  = "Tahoma"
351:                 .FontSize  = 7
352:                 .BackStyle = 0
353:                 .Caption   = "Vertical"
354:                 .Height    = 13
355:                 .Left      = 12
356:                 .Top       = 25
357:                 .Width     = 33
358:                 .ForeColor = RGB(90, 90, 90)
359:                 .Visible   = .T.
360:             ENDWITH
361: 
362:             .AddObject("lbl_4c_Say3", "Label")
363:             WITH .lbl_4c_Say3
364:                 .FontName  = "Tahoma"
365:                 .FontSize  = 7
366:                 .BackStyle = 0
367:                 .Caption   = "Horizontal"
368:                 .Height    = 13
369:                 .Left      = 72
370:                 .Top       = 25
371:                 .Width     = 50
372:                 .ForeColor = RGB(90, 90, 90)
373:                 .Visible   = .T.
374:             ENDWITH
375: 
376:             .AddObject("lbl_4c_Say1", "Label")
377:             WITH .lbl_4c_Say1
378:                 .FontName  = "Tahoma"
379:                 .FontSize  = 7
380:                 .BackStyle = 0
381:                 .Caption   = "Densidade"
382:                 .Height    = 13
383:                 .Left      = 132
384:                 .Top       = 25
385:                 .Width     = 50
386:                 .ForeColor = RGB(90, 90, 90)
387:                 .Visible   = .T.
388:             ENDWITH
389: 
390:             .AddObject("lbl_4c_Say20", "Label")
391:             WITH .lbl_4c_Say20
392:                 .FontName  = "Tahoma"
393:                 .FontSize  = 7
394:                 .BackStyle = 0
395:                 .Caption   = "Velocidade"
396:                 .Height    = 13
397:                 .Left      = 192
398:                 .Top       = 25
399:                 .Width     = 55
400:                 .ForeColor = RGB(90, 90, 90)
401:                 .Visible   = .T.
402:             ENDWITH
403: 
404:             *-- Spinners de ajuste
405:             .AddObject("obj_4c_Spn_AjVerts", "Spinner")
406:             WITH .obj_4c_Spn_AjVerts
407:                 .FontName          = "Tahoma"
408:                 .Height            = 26
409:                 .KeyboardHighValue = 999
410:                 .KeyboardLowValue  = 0
411:                 .Left              = 10
412:                 .SpinnerHighValue  = 999
413:                 .SpinnerLowValue   = 0
414:                 .Top               = 36
415:                 .Width             = 56
416:                 .Value             = 0
417:                 .Visible           = .T.
418:             ENDWITH
419: 
420:             .AddObject("obj_4c_Spn_AjHorzs", "Spinner")
421:             WITH .obj_4c_Spn_AjHorzs
422:                 .FontName          = "Tahoma"
423:                 .Height            = 26
424:                 .KeyboardHighValue = 999
425:                 .KeyboardLowValue  = 0
426:                 .Left              = 71
427:                 .SpinnerHighValue  = 999
428:                 .SpinnerLowValue   = 0
429:                 .Top               = 36
430:                 .Width             = 56
431:                 .Value             = 0
432:                 .Visible           = .T.
433:             ENDWITH
434: 
435:             .AddObject("obj_4c_Spn_AjDenss", "Spinner")
436:             WITH .obj_4c_Spn_AjDenss
437:                 .FontName          = "Tahoma"
438:                 .Height            = 26
439:                 .KeyboardHighValue = 20
440:                 .KeyboardLowValue  = 10
441:                 .Left              = 132
442:                 .SpinnerHighValue  = 20
443:                 .SpinnerLowValue   = 10
444:                 .Top               = 36
445:                 .Width             = 56
446:                 .Value             = 10
447:                 .Visible           = .T.
448:             ENDWITH
449: 
450:             .AddObject("obj_4c_Spn_AjVelos", "Spinner")
451:             WITH .obj_4c_Spn_AjVelos
452:                 .FontName          = "Tahoma"
453:                 .Height            = 26
454:                 .KeyboardHighValue = 3
455:                 .KeyboardLowValue  = 1
456:                 .Left              = 192
457:                 .SpinnerHighValue  = 3
458:                 .SpinnerLowValue   = 1
459:                 .Top               = 36
460:                 .Width             = 54
461:                 .Value             = 3
462:                 .Visible           = .T.
463:             ENDWITH
464: 
465:             *-- OptionGroup protocolo de impressao (Allegro / Zebra ZPL / Zebra EPL)
466:             .AddObject("obj_4c_Opcao_imp", "OptionGroup")
467:             WITH .obj_4c_Opcao_imp
468:                 .AutoSize    = .F.
469:                 .ButtonCount = 3
470:                 .Height      = 22
471:                 .Left        = 3
472:                 .Top         = 3
473:                 .Width       = 249
474:                 .Enabled     = .F.
475:                 WITH .Buttons(1)
476:                     .BackStyle = 0
477:                     .Caption   = "Allegro"
478:                     .Left      = 3
479:                     .Top       = 4
480:                     .Width     = 51
481:                     .AutoSize  = .T.
482:                     .ForeColor = RGB(90, 90, 90)
483:                     .Themes    = .F.
484:                 ENDWITH
485:                 WITH .Buttons(2)
486:                     .FontName  = "Tahoma"
487:                     .FontSize  = 8
488:                     .BackStyle = 0
489:                     .Caption   = "Zebra ZPL"
490:                     .Left      = 77
491:                     .Top       = 4
492:                     .Width     = 66
493:                     .AutoSize  = .T.
494:                     .ForeColor = RGB(90, 90, 90)
495:                     .Themes    = .F.
496:                 ENDWITH
497:                 WITH .Buttons(3)
498:                     .FontName  = "Tahoma"
499:                     .FontSize  = 8
500:                     .BackStyle = 0
501:                     .Caption   = "Zebra EPL"
502:                     .Height    = 15
503:                     .Left      = 170
504:                     .Top       = 4
505:                     .Width     = 66
506:                     .AutoSize  = .T.
507:                     .ForeColor = RGB(90, 90, 90)
508:                     .Themes    = .F.
509:                 ENDWITH

*-- Linhas 580 a 607:
580:                         loc_oBtn           = loc_oOptTipo.Buttons(loc_lnI)
581:                         loc_oBtn.AutoSize  = .F.
582:                         loc_oBtn.Width     = 160
583:                         loc_oBtn.Caption   = "\<" + CHR(96 + loc_lnI) + ". " + ALLTRIM(cEtiquetas)
584:                         loc_oBtn.FontSize  = 8
585:                         loc_oBtn.Tag       = ALLTRIM(STR(nTipos))
586:                         loc_oBtn.Top       = loc_lnTop
587:                         loc_oBtn.BackStyle = 0
588:                         loc_oBtn.ForeColor = RGB(90, 90, 90)
589:                         loc_lnI      = loc_lnI + 1
590:                         loc_lnTop    = loc_lnTop + 20
591:                         loc_lnHeight = loc_lnHeight + 20
592:                     ENDSCAN
593:                 ENDIF
594:             ELSE
595:                 loc_oOptTipo.ButtonCount = 1
596:                 loc_oBtn           = loc_oOptTipo.Buttons(1)
597:                 loc_oBtn.AutoSize  = .F.
598:                 loc_oBtn.Width     = 160
599:                 loc_oBtn.Caption   = "\<1. Envelope"
600:                 loc_oBtn.FontSize  = 8
601:                 loc_oBtn.Tag       = "6"
602:                 loc_oBtn.Top       = loc_lnTop
603:                 loc_oBtn.BackStyle = 0
604:                 loc_oBtn.ForeColor = RGB(90, 90, 90)
605:                 loc_lnTop    = loc_lnTop + 20
606:                 loc_lnHeight = loc_lnHeight + 20
607:             ENDIF

*-- Linhas 636 a 660:
636:                 FOR loc_lnIi = 1 TO loc_oOptImp.ButtonCount
637:                     loc_oBtn           = loc_oOptImp.Buttons(loc_lnIi)
638:                     loc_oBtn.AutoSize  = .F.
639:                     loc_oBtn.Caption   = " \<" + ALLTRIM(STR(loc_lnIi)) + ". " + loc_laImpOk(loc_lnIi)
640:                     loc_oBtn.FontSize  = 8
641:                     loc_oBtn.Tag       = loc_laImpOk(loc_lnIi)
642:                     loc_oBtn.Top       = loc_lnTop
643:                     loc_oBtn.Width     = 160
644:                     loc_oBtn.BackStyle = 0
645:                     loc_oBtn.ForeColor = RGB(90, 90, 90)
646:                     loc_lnTop    = loc_lnTop + 20
647:                     loc_lnHeight = loc_lnHeight + 20
648:                 ENDFOR
649:             ELSE
650:                 *-- Fallback: impressora generica do sistema
651:                 loc_oOptImp.ButtonCount = 1
652:                 loc_nOk  = ASCAN(loc_laPrnNames, "GEN" + CHR(201) + "RICO/SOMENTE TEXTO")
653:                 loc_oBtn = loc_oOptImp.Buttons(1)
654:                 loc_oBtn.AutoSize  = .F.
655:                 loc_oBtn.Caption   = " \<0. Gen" + CHR(233) + "rico/Somente Texto"
656:                 loc_oBtn.Enabled   = (loc_nOk > 0)
657:                 loc_oBtn.FontSize  = 8
658:                 loc_oBtn.Tag       = "GEN" + CHR(201) + "RICO/SOMENTE TEXTO"
659:                 loc_oBtn.Width     = 160
660:                 loc_oBtn.BackStyle = 0

*-- Linhas 669 a 677:
669:             loc_oOptImp.Value   = 1
670: 
671:             *-- 9. Reposiciona cnt_4c__Impressora abaixo de Opt_Impressora
672:             THIS.cnt_4c__Impressora.Top = loc_oOptImp.Top + loc_oOptImp.Height - 2
673:             loc_lnBottom2 = THIS.cnt_4c__Impressora.Top + THIS.cnt_4c__Impressora.Height
674: 
675:             *-- 10. Ajusta altura do form ao conteudo dinamico
676:             THIS.Height = MAX(loc_lnBottom1, loc_lnBottom2) + 10
677: 

*-- Linhas 945 a 963:
945:     *--------------------------------------------------------------------------
946:     PROTECTED PROCEDURE BOParaForm()
947:         WITH THIS.this_oBusinessObject
948:             THIS.txt_4c_Etq_Ini.Value = .this_nEtqIni
949:             THIS.txt_4c_Etq_Qtd.Value = .this_nEtqQtd
950: 
951:             WITH THIS.cnt_4c__Impressora
952:                 IF .this_nOpcaoImp >= 1 AND .this_nOpcaoImp <= 3
953:                     .obj_4c_Opcao_imp.Value = .this_nOpcaoImp
954:                 ENDIF
955:                 .obj_4c_Spn_AjVerts.Value = .this_nAjVerts
956:                 .obj_4c_Spn_AjHorzs.Value = .this_nAjHorzs
957:                 .obj_4c_Spn_AjDenss.Value = .this_nAjDenss
958:                 .obj_4c_Spn_AjVelos.Value = .this_nAjVelos
959:                 .Visible     = .T.
960:             ENDWITH
961:             .Visible     = .T.
962:         ENDWITH
963:     ENDPROC


### BO (C:\4c\projeto\app\classes\sigprenvBO.prg):
*==============================================================================
* sigprenvBO.prg - Business Object para Impressao de Etiquetas de Envelopes
* Herda de: BusinessBase
* Form original: SIGPRENV.SCX
* Tipo: OPERACIONAL (sem entidade CRUD - impressao de etiquetas)
*==============================================================================
DEFINE CLASS sigprenvBO AS BusinessBase

    *-- Dados da sessao de impressao
    this_nEtqIni       = 0    && Etiqueta Inicial (Etq_Ini)
    this_nEtqQtd       = 0    && Quantidade de etiquetas (Etq_Qtd)

    *-- Tipo de etiqueta selecionado (Opt_Tipo)
    this_nTipoEtq      = 6    && nTipos do SigCdTpe (6 = Envelope)
    this_cDescTipoEtq  = ""   && cEtiquetas do SigCdTpe

    *-- Impressora selecionada (Opt_Impressora)
    this_cNomeImpressora = ""  && Tag do botao = nome da impressora (UPPER)
    this_nTpImpressora   = 0   && nTpImpres do SigCdMp

    *-- Opcao de protocolo de impressao (Opcao_Imp: 1=Allegro, 2=Zebra ZPL, 3=Zebra EPL)
    this_nOpcaoImp     = 1

    *-- Ajustes de impressao (de SigCdPam e SigCdPac)
    this_nAjVerts      = 0
    this_nAjHorzs      = 0
    this_nAjDenss      = 10
    this_nAjVelos      = 1

    *-- Parametros gerais carregados de SigCdPam
    this_nMaxTpEtis    = 5    && nMaxTpEtis - maximo de tipos de etiqueta exibidos
    this_nMaxImpEti    = 5    && nMaxImpEti - maximo de impressoras exibidas
    this_nImpEtis      = 1    && ImpEtis - impressora padrao
    this_cTpCBars      = ""   && TpCBars - tipo codigo de barras

    *-- Campos da etiqueta individual (cursor_4c_Impressao)
    this_cCpros        = ""   && Codigo da etiqueta (Cpros)
    this_cDPros        = ""   && Descricao do produto (DPros)
    this_nQtds         = 0    && Quantidade (Qtds)
    this_nQtdeEtiq     = 0    && Quantidade de etiquetas (QtdeEtiq)
    this_cPedido       = ""   && Numero do pedido (Pedido)
    this_cObs          = ""   && Observacao (Obs)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        this_cTabela     = ""
        this_cCampoChave = ""
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarParametros - Carrega SigCdPam e SigCdPac (ajustes e parametros)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarParametros()
        LOCAL loc_cSQL, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT nMaxTpEtis, TpEtiPads, nMaxImpEti, ImpEtis, " + ;
                       "AjVerts, AjHorzs, TpCBars FROM SigCdPam"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pam") > 0
                IF USED("cursor_4c_Pam") AND !EOF("cursor_4c_Pam")
                    SELECT cursor_4c_Pam
                    GO TOP
                    this_nMaxTpEtis = NVL(nMaxTpEtis, 5)
                    this_nMaxImpEti = NVL(nMaxImpEti, 5)
                    this_nImpEtis   = NVL(ImpEtis, 1)
                    this_nAjVerts   = NVL(AjVerts, 0)
                    this_nAjHorzs   = NVL(AjHorzs, 0)
                    this_cTpCBars   = ALLTRIM(NVL(TpCBars, ""))
                ENDIF
                IF USED("cursor_4c_Pam")
                    USE IN cursor_4c_Pam
                ENDIF
            ENDIF

            loc_cSQL = "SELECT AjDens, AjVelos FROM SigCdPac"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Pac") > 0
                IF USED("cursor_4c_Pac") AND !EOF("cursor_4c_Pac")
                    SELECT cursor_4c_Pac
                    GO TOP
                    this_nAjDenss = IIF(NVL(AjDens, 0) < 10, 10, NVL(AjDens, 0))
                    this_nAjVelos = IIF(EMPTY(NVL(AjVelos, 0)), 1, NVL(AjVelos, 0))
                ENDIF
                IF USED("cursor_4c_Pac")
                    USE IN cursor_4c_Pac
                ENDIF
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Carrega tipos de etiqueta de SigCdTpe (nTipos=6)
    * Retorna: numero de tipos encontrados
    *--------------------------------------------------------------------------
    PROCEDURE CarregarTiposEtiqueta()
        LOCAL loc_cSQL, loc_nTipos, loc_oErro
        loc_nTipos = 0

        TRY
            IF USED("cursor_4c_Tpe")
                USE IN cursor_4c_Tpe
            ENDIF

            loc_cSQL = "SELECT cOrdems, cEtiquetas, nTipos, nSituas " + ;
                       "FROM SigCdTpe " + ;
                       "WHERE nSituas = 1 AND nTipos = 6 " + ;
                       "ORDER BY cOrdems"
            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Tpe") > 0
                IF USED("cursor_4c_Tpe")
                    SELECT cursor_4c_Tpe
                    GO TOP
                    loc_nTipos = RECCOUNT("cursor_4c_Tpe")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nTipos
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Carrega impressoras autorizadas do usuario em SigCdMp
    * par_cUsuario: codigo do usuario logado
    * Retorna: numero de impressoras encontradas
    *--------------------------------------------------------------------------
    PROCEDURE CarregarImpressoras(par_cUsuario)
        LOCAL loc_cSQL, loc_nImpres, loc_oErro
        loc_nImpres = 0

        TRY
            IF USED("cursor_4c_Imp")
                USE IN cursor_4c_Imp
            ENDIF
            IF USED("cursor_4c_ImpTemp")
                USE IN cursor_4c_ImpTemp
            ENDIF

            loc_cSQL = "SELECT b.Impres, b.nTpImpres FROM SigSyImp a " + ;
                       "INNER JOIN SigCdMp b ON a.cimps = b.Impres " + ;
                       "WHERE a.UsuAcess = " + EscaparSQL(par_cUsuario) + " " + ;
                       "UNION ALL " + ;
                       "SELECT c.Impres, c.nTpImpres FROM SigCdAcG a " + ;
                       "INNER JOIN SigSyImp b ON a.Grupos = b.GrAcess " + ;
                       "INNER JOIN SigCdMp c ON b.Cimps = c.Impres " + ;
                       "WHERE a.Usuarios = " + EscaparSQL(par_cUsuario)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
                IF USED("cursor_4c_ImpTemp") AND RECCOUNT("cursor_4c_ImpTemp") > 0
                    SELECT DISTINCT Impres, nTpImpres FROM cursor_4c_ImpTemp ;
                        INTO CURSOR cursor_4c_Imp READWRITE
                ELSE
                    loc_cSQL = "SELECT Impres, nTpImpres FROM SigCdMp"
                    SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Imp")
                ENDIF

                IF USED("cursor_4c_ImpTemp")
                    USE IN cursor_4c_ImpTemp
                ENDIF

                IF USED("cursor_4c_Imp")
                    SELECT cursor_4c_Imp
                    GO TOP
                    loc_nImpres = RECCOUNT("cursor_4c_Imp")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_nImpres
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararImpressao - Monta o cursor de itens a imprimir (dbImpressao)
    * par_nEtqIni: numero da etiqueta inicial
    * par_nEtqQtd: quantidade de etiquetas
    *--------------------------------------------------------------------------
    PROCEDURE PrepararImpressao(par_nEtqIni, par_nEtqQtd)
        LOCAL loc_nI, loc_cCpros, loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Impressao")
                SELECT cursor_4c_Impressao
                ZAP
            ELSE
                SET NULL ON
                CREATE CURSOR cursor_4c_Impressao ;
                    (Cpros C(10) NULL, DPros C(40) NULL, Qtds N(10,3) NULL, ;
                     QtdeEtiq N(10,3) NULL, Pedido C(30) NULL, Obs C(10) NULL)
                SET NULL OFF
                INDEX ON Cpros TAG Cpros
                SET ORDER TO
            ENDIF

            FOR loc_nI = par_nEtqIni TO par_nEtqIni + (par_nEtqQtd - 1)
                loc_cCpros = PADL(ALLTRIM(STR(loc_nI, 8)), 8, "0")
                INSERT INTO cursor_4c_Impressao ;
                    (Cpros, Qtds, Pedido, QtdeEtiq) ;
                    VALUES (loc_cCpros, 1, "", 1)
            ENDFOR

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparImpressao - Limpa o cursor de impressao apos concluir
    *--------------------------------------------------------------------------
    PROCEDURE LimparImpressao()
        IF USED("cursor_4c_Impressao")
            SELECT cursor_4c_Impressao
            ZAP
            APPEND BLANK
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * InicializarCursorImpressao - Cria cursor vazio de impressao no Init do form
    *--------------------------------------------------------------------------
    PROCEDURE InicializarCursorImpressao()
        IF USED("cursor_4c_Impressao")
            USE IN cursor_4c_Impressao
        ENDIF

        SET NULL ON
        CREATE CURSOR cursor_4c_Impressao ;
            (Cpros C(10) NULL, DPros C(40) NULL, Qtds N(10,3) NULL, ;
             QtdeEtiq N(10,3) NULL, Pedido C(30) NULL, Obs C(10) NULL)
        SET NULL OFF
        INDEX ON Cpros TAG Cpros
        SET ORDER TO
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades a partir de cursor_4c_Impressao
    * par_cAliasCursor: alias do cursor origem
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            this_cCpros    = ALLTRIM(NVL(Cpros,    ""))
            this_cDPros    = ALLTRIM(NVL(DPros,    ""))
            this_nQtds     = NVL(Qtds,    0)
            this_nQtdeEtiq = NVL(QtdeEtiq, 0)
            this_cPedido   = ALLTRIM(NVL(Pedido,  ""))
            this_cObs      = ALLTRIM(NVL(Obs,     ""))
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna a chave primaria da etiqueta corrente
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN this_cCpros
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - Insere etiqueta no cursor_4c_Impressao local
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF !USED("cursor_4c_Impressao")
                THIS.InicializarCursorImpressao()
            ENDIF

            SELECT cursor_4c_Impressao
            INSERT INTO cursor_4c_Impressao ;
                (Cpros, DPros, Qtds, QtdeEtiq, Pedido, Obs) ;
                VALUES (this_cCpros, this_cDPros, this_nQtds, ;
                        this_nQtdeEtiq, this_cPedido, this_cObs)

            THIS.RegistrarAuditoria("INSERIR")
            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza etiqueta existente no cursor_4c_Impressao
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Impressao")
                SELECT cursor_4c_Impressao
                SET ORDER TO TAG Cpros
                IF SEEK(this_cCpros, "cursor_4c_Impressao", "Cpros")
                    REPLACE Qtds     WITH this_nQtds, ;
                            QtdeEtiq WITH this_nQtdeEtiq, ;
                            DPros    WITH this_cDPros, ;
                            Pedido   WITH this_cPedido, ;
                            Obs      WITH this_cObs
                    THIS.RegistrarAuditoria("ATUALIZAR")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de impressao em LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_oErro

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, Operacao, ChaveRegistro, Usuario, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL("SigOpEtq") + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(this_cCpros) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE())"
            SQLEXEC(gnConnHandle, loc_cSQL)
        CATCH TO loc_oErro
            *-- Falha de auditoria nao interrompe a operacao principal
        ENDTRY
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores ao encerrar
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Tpe")
            USE IN cursor_4c_Tpe
        ENDIF
        IF USED("cursor_4c_Imp")
            USE IN cursor_4c_Imp
        ENDIF
        IF USED("cursor_4c_ImpTemp")
            USE IN cursor_4c_ImpTemp
        ENDIF
        IF USED("cursor_4c_Impressao")
            USE IN cursor_4c_Impressao
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

