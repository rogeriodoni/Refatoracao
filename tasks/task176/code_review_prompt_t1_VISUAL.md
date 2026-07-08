# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [FONTNAME-ERRADO] Linha 214: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprenv.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1244 linhas total):

*-- Linhas 42 a 62:
42:             THIS.ShowTips    = .T.
43:             THIS.FontName    = "Tahoma"
44:             THIS.FontSize    = 8
45:             THIS.Caption     = "Impress" + CHR(227) + "o de etiquetas de envelopes"
46: 
47:             IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
48:                 THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
49:             ENDIF
50: 
51:             *-- Criar Business Object
52:             THIS.this_oBusinessObject = CREATEOBJECT("sigprenvBO")
53:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
54:                 *-- Layout base
55:                 THIS.ConfigurarPageFrame()
56:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
57:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
58: 
59:                 THIS.TornarControlesVisiveis(THIS)
60: 
61:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
62:                     THIS.CarregarDados()

*-- Linhas 102 a 151:
102:     PROTECTED PROCEDURE ConfigurarCabecalho()
103:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
104:         WITH THIS.cnt_4c_Cabecalho
105:             .Top         = 0
106:             .Left        = 0
107:             .Width       = THIS.Width
108:             .Height      = 80
109:             .BackStyle   = 1
110:             .BackColor   = RGB(100, 100, 100)
111:             .BorderWidth = 0
112:             .Visible     = .T.
113: 
114:             .AddObject("lbl_4c_Sombra", "Label")
115:             WITH .lbl_4c_Sombra
116:                 .Top       = 18
117:                 .Left      = 10
118:                 .Width     = THIS.Width
119:                 .Height    = 40
120:                 .AutoSize  = .F.
121:                 .FontName  = "Tahoma"
122:                 .FontSize  = 18
123:                 .FontBold  = .T.
124:                 .WordWrap  = .T.
125:                 .Alignment = 0
126:                 .BackStyle = 0
127:                 .ForeColor = RGB(0, 0, 0)
128:                 .Caption   = THIS.Caption
129:                 .Visible   = .T.
130:             ENDWITH
131: 
132:             .AddObject("lbl_4c_Titulo", "Label")
133:             WITH .lbl_4c_Titulo
134:                 .Top       = 17
135:                 .Left      = 10
136:                 .Width     = THIS.Width
137:                 .Height    = 46
138:                 .AutoSize  = .F.
139:                 .FontName  = "Tahoma"
140:                 .FontSize  = 18
141:                 .FontBold  = .T.
142:                 .WordWrap  = .T.
143:                 .Alignment = 0
144:                 .BackStyle = 0
145:                 .ForeColor = RGB(255, 255, 255)
146:                 .Caption   = THIS.Caption
147:                 .Visible   = .T.
148:             ENDWITH
149:         ENDWITH
150:     ENDPROC
151: 

*-- Linhas 177 a 199:
177:             *-- CommandGroup: Imprimir + Encerrar (lado direito, topo)
178:             THIS.AddObject("obj_4c_BtnReport", "CommandGroup")
179:             WITH THIS.obj_4c_BtnReport
180:                 .Top           = 0
181:                 .Left          = 820
182:                 .Width         = 171
183:                 .Height        = 110
184:                 .BackStyle     = 0
185:                 .BorderStyle   = 0
186:                 .SpecialEffect = 1
187:                 .Themes        = .F.
188:                 .ButtonCount   = 2
189:                 .Visible       = .T.
190: 
191:                 WITH .Buttons(1)
192:                     .Caption         = "\<Imprimir"
193:                     .Top             = 5
194:                     .Left            = 10
195:                     .Width           = 75
196:                     .Height          = 75
197:                     .FontBold        = .T.
198:                     .FontItalic      = .T.
199:                     .ForeColor       = RGB(90, 90, 90)

*-- Linhas 206 a 220:
206:                 ENDWITH
207: 
208:                 WITH .Buttons(2)
209:                     .Caption         = "Encerrar"
210:                     .Top             = 5
211:                     .Left            = 86
212:                     .Width           = 75
213:                     .Height          = 75
214:                     .FontName        = "Comic Sans MS"
215:                     .FontSize        = 8
216:                     .FontBold        = .T.
217:                     .FontItalic      = .T.
218:                     .ForeColor       = RGB(90, 90, 90)
219:                     .BackColor       = RGB(255, 255, 255)
220:                     .Themes          = .F.

*-- Linhas 228 a 254:
228:             ENDWITH
229: 
230:             *-- Label "Impressora"
231:             THIS.AddObject("lbl_4c_Label2", "Label")
232:             WITH THIS.lbl_4c_Label2
233:                 .Top       = 167
234:                 .Left      = 409
235:                 .AutoSize  = .T.
236:                 .FontName  = "Tahoma"
237:                 .FontSize  = 8
238:                 .FontBold  = .T.
239:                 .BackStyle = 0
240:                 .ForeColor = RGB(90, 90, 90)
241:                 .Caption   = "Impressora "
242:                 .Visible   = .T.
243:             ENDWITH
244: 
245:             *-- OptionGroup Impressora (ButtonCount dinamico - populado em CarregarDados)
246:             THIS.AddObject("obj_4c_Opt_Impressora", "OptionGroup")
247:             WITH THIS.obj_4c_Opt_Impressora
248:                 .Top           = 180
249:                 .Left          = 396
250:                 .Width         = 254
251:                 .Height        = 30
252:                 .BackStyle     = 0
253:                 .SpecialEffect = 1
254:                 .Themes        = .F.

*-- Linhas 260 a 388:
260:                     .AutoSize  = .F.
261:                     .BackStyle = 0
262:                     .ForeColor = RGB(90, 90, 90)
263:                     .Caption   = "1. Gen" + CHR(233) + "rico/Somente Texto"
264:                     .Height    = 17
265:                     .Left      = 10
266:                     .Top       = 10
267:                     .Width     = 238
268:                     .Themes    = .F.
269:                 ENDWITH
270:             ENDWITH
271: 
272:             *-- Container de configuracoes da impressora (Cnt_Impressora)
273:             THIS.AddObject("cnt_4c__Impressora", "Container")
274:             WITH THIS.cnt_4c__Impressora
275:                 .Top       = 289
276:                 .Left      = 396
277:                 .Width     = 254
278:                 .Height    = 67
279:                 .BackStyle = 0
280:                 .Visible   = .T.
281: 
282:                 *-- OptionGroup tipo de impressao: Allegro / Zebra ZPL / Zebra EPL
283:                 .AddObject("obj_4c_Opcao_imp", "OptionGroup")
284:                 WITH .obj_4c_Opcao_imp
285:                     .Top         = 3
286:                     .Left        = 3
287:                     .Width       = 249
288:                     .Height      = 22
289:                     .BackStyle   = 0
290:                     .ButtonCount = 3
291:                     .Value       = 1
292:                     .Visible     = .T.
293:                     WITH .Buttons(1)
294:                         .AutoSize  = .F.
295:                         .BackStyle = 0
296:                         .ForeColor = RGB(90, 90, 90)
297:                         .Caption   = "Allegro"
298:                         .Left      = 3
299:                         .Top       = 4
300:                         .Width     = 51
301:                     ENDWITH
302:                     WITH .Buttons(2)
303:                         .AutoSize  = .F.
304:                         .FontName  = "Tahoma"
305:                         .FontSize  = 8
306:                         .BackStyle = 0
307:                         .ForeColor = RGB(90, 90, 90)
308:                         .Caption   = "Zebra ZPL"
309:                         .Left      = 77
310:                         .Top       = 4
311:                         .Width     = 66
312:                         .Themes    = .F.
313:                     ENDWITH
314:                     WITH .Buttons(3)
315:                         .AutoSize  = .F.
316:                         .FontName  = "Tahoma"
317:                         .FontSize  = 8
318:                         .BackStyle = 0
319:                         .ForeColor = RGB(90, 90, 90)
320:                         .Caption   = "Zebra EPL"
321:                         .Left      = 170
322:                         .Top       = 4
323:                         .Width     = 66
324:                         .Themes    = .F.
325:                     ENDWITH
326:                 ENDWITH
327: 
328:                 *-- Labels dos spinners de ajuste
329:                 .AddObject("lbl_4c_LblVertical", "Label")
330:                 WITH .lbl_4c_LblVertical
331:                     .Top       = 25
332:                     .Left      = 12
333:                     .Width     = 55
334:                     .Height    = 13
335:                     .AutoSize  = .F.
336:                     .FontName  = "Tahoma"
337:                     .FontSize  = 7
338:                     .BackStyle = 0
339:                     .Caption   = "Vertical"
340:                     .Visible   = .T.
341:                 ENDWITH
342: 
343:                 .AddObject("lbl_4c_LblHorizontal", "Label")
344:                 WITH .lbl_4c_LblHorizontal
345:                     .Top       = 25
346:                     .Left      = 72
347:                     .AutoSize  = .T.
348:                     .FontName  = "Tahoma"
349:                     .FontSize  = 7
350:                     .BackStyle = 0
351:                     .Caption   = "Horizontal"
352:                     .Visible   = .T.
353:                 ENDWITH
354: 
355:                 .AddObject("lbl_4c_LblDensidade", "Label")
356:                 WITH .lbl_4c_LblDensidade
357:                     .Top       = 25
358:                     .Left      = 132
359:                     .AutoSize  = .T.
360:                     .FontName  = "Tahoma"
361:                     .FontSize  = 7
362:                     .BackStyle = 0
363:                     .Caption   = "Densidade"
364:                     .Visible   = .T.
365:                 ENDWITH
366: 
367:                 .AddObject("lbl_4c_LblVelocidade", "Label")
368:                 WITH .lbl_4c_LblVelocidade
369:                     .Top       = 25
370:                     .Left      = 192
371:                     .AutoSize  = .T.
372:                     .FontName  = "Tahoma"
373:                     .FontSize  = 7
374:                     .BackStyle = 0
375:                     .Caption   = "Velocidade"
376:                     .Visible   = .T.
377:                 ENDWITH
378: 
379:                 *-- Spinner Ajuste Vertical
380:                 .AddObject("obj_4c_Spn_AjVerts", "Spinner")
381:                 WITH .obj_4c_Spn_AjVerts
382:                     .Top               = 36
383:                     .Left              = 10
384:                     .Width             = 56
385:                     .Height            = 26
386:                     .FontName          = "Tahoma"
387:                     .KeyboardHighValue = 999
388:                     .KeyboardLowValue  = 0

*-- Linhas 395 a 404:
395:                 *-- Spinner Ajuste Horizontal
396:                 .AddObject("obj_4c_Spn_AjHorzs", "Spinner")
397:                 WITH .obj_4c_Spn_AjHorzs
398:                     .Top               = 36
399:                     .Left              = 71
400:                     .Width             = 56
401:                     .Height            = 26
402:                     .FontName          = "Tahoma"
403:                     .KeyboardHighValue = 999
404:                     .KeyboardLowValue  = 0

*-- Linhas 411 a 420:
411:                 *-- Spinner Ajuste Densidade (10..20)
412:                 .AddObject("obj_4c_Spn_AjDenss", "Spinner")
413:                 WITH .obj_4c_Spn_AjDenss
414:                     .Top               = 36
415:                     .Left              = 132
416:                     .Width             = 56
417:                     .Height            = 26
418:                     .FontName          = "Tahoma"
419:                     .KeyboardHighValue = 20
420:                     .KeyboardLowValue  = 10

*-- Linhas 427 a 436:
427:                 *-- Spinner Ajuste Velocidade (1..3)
428:                 .AddObject("obj_4c_Spn_AjVelos", "Spinner")
429:                 WITH .obj_4c_Spn_AjVelos
430:                     .Top               = 36
431:                     .Left              = 192
432:                     .Width             = 54
433:                     .Height            = 26
434:                     .FontName          = "Tahoma"
435:                     .KeyboardHighValue = 3
436:                     .KeyboardLowValue  = 1

*-- Linhas 463 a 547:
463:         LOCAL loc_oErro
464:         TRY
465:             *-- Label "Etiqueta Inicial :"
466:             THIS.AddObject("lbl_4c_Lbl_Etq", "Label")
467:             WITH THIS.lbl_4c_Lbl_Etq
468:                 .Top       = 129
469:                 .Left      = 155
470:                 .AutoSize  = .T.
471:                 .FontName  = "Tahoma"
472:                 .FontSize  = 8
473:                 .BackStyle = 0
474:                 .ForeColor = RGB(90, 90, 90)
475:                 .Caption   = "Etiqueta Inicial :"
476:                 .Visible   = .T.
477:             ENDWITH
478: 
479:             *-- TextBox Etiqueta Inicial (valor inicial da numeracao das etiquetas)
480:             THIS.AddObject("txt_4c_Etq_Ini", "TextBox")
481:             WITH THIS.txt_4c_Etq_Ini
482:                 .Top                = 125
483:                 .Left               = 237
484:                 .Width              = 66
485:                 .Height             = 23
486:                 .FontName           = "Tahoma"
487:                 .InputMask          = "99999999"
488:                 .DisabledBackColor  = RGB(255, 255, 255)
489:                 .Value              = 1
490:                 .Visible            = .T.
491:             ENDWITH
492: 
493:             *-- Label "Quantidade :"
494:             THIS.AddObject("lbl_4c_Lbl_Qtd", "Label")
495:             WITH THIS.lbl_4c_Lbl_Qtd
496:                 .Top       = 129
497:                 .Left      = 328
498:                 .AutoSize  = .T.
499:                 .FontName  = "Tahoma"
500:                 .FontSize  = 8
501:                 .BackStyle = 0
502:                 .ForeColor = RGB(90, 90, 90)
503:                 .Caption   = "Quantidade :"
504:                 .Visible   = .T.
505:             ENDWITH
506: 
507:             *-- TextBox Quantidade (quantas etiquetas serao impressas)
508:             THIS.AddObject("txt_4c_Etq_Qtd", "TextBox")
509:             WITH THIS.txt_4c_Etq_Qtd
510:                 .Top       = 125
511:                 .Left      = 397
512:                 .Width     = 66
513:                 .Height    = 23
514:                 .FontName  = "Tahoma"
515:                 .Alignment = 1
516:                 .Format    = "K!"
517:                 .InputMask = "99999999"
518:                 .MaxLength = 8
519:                 .Value     = 0
520:                 .Visible   = .T.
521:             ENDWITH
522: 
523:             *-- Label "Tipo de etiqueta"
524:             THIS.AddObject("lbl_4c_Lbl_TpEti", "Label")
525:             WITH THIS.lbl_4c_Lbl_TpEti
526:                 .Top       = 166
527:                 .Left      = 150
528:                 .AutoSize  = .T.
529:                 .FontName  = "Tahoma"
530:                 .FontSize  = 8
531:                 .FontBold  = .T.
532:                 .BackStyle = 0
533:                 .ForeColor = RGB(90, 90, 90)
534:                 .Caption   = "Tipo de etiqueta "
535:                 .Visible   = .T.
536:             ENDWITH
537: 
538:             *-- OptionGroup Tipo de Etiqueta (ButtonCount dinamico - populado em CarregarDados)
539:             THIS.AddObject("obj_4c_Opt_Tipo", "OptionGroup")
540:             WITH THIS.obj_4c_Opt_Tipo
541:                 .Top           = 179
542:                 .Left          = 140
543:                 .Width         = 240
544:                 .Height        = 30
545:                 .BackStyle     = 0
546:                 .SpecialEffect = 1
547:                 .Themes        = .F.

*-- Linhas 553 a 564:
553:                     .AutoSize  = .F.
554:                     .BackStyle = 0
555:                     .ForeColor = RGB(90, 90, 90)
556:                     .Caption   = ""
557:                     .Height    = 22
558:                     .Left      = 10
559:                     .Top       = 10
560:                     .Width     = 222
561:                     .Themes    = .F.
562:                 ENDWITH
563:             ENDWITH
564: 

*-- Linhas 600 a 611:
600:                     loc_cTag     = ALLTRIM(STR(cursor_4c_SigCdTpe.ntipos))
601:                     WITH THIS.obj_4c_Opt_Tipo.Buttons(loc_nI)
602:                         .AutoSize  = .F.
603:                         .Left      = 10
604:                         .Top       = loc_nTop
605:                         .Width     = 160
606:                         .Caption   = loc_cCaption
607:                         .FontSize  = 8
608:                         .FontName  = "Tahoma"
609:                         .Tag       = loc_cTag
610:                         .BackStyle = 0
611:                         .ForeColor = RGB(90, 90, 90)

*-- Linhas 624 a 635:
624:                 THIS.obj_4c_Opt_Tipo.ButtonCount = 1
625:                 WITH THIS.obj_4c_Opt_Tipo.Buttons(1)
626:                     .AutoSize  = .F.
627:                     .Left      = 10
628:                     .Top       = 10
629:                     .Width     = 160
630:                     .Caption   = "\<1. Envelope"
631:                     .FontSize  = 8
632:                     .FontName  = "Tahoma"
633:                     .Tag       = ALLTRIM(STR(6))
634:                     .BackStyle = 0
635:                     .ForeColor = RGB(90, 90, 90)

*-- Linhas 685 a 696:
685:                 FOR loc_nJ = 1 TO THIS.obj_4c_Opt_Impressora.ButtonCount
686:                     WITH THIS.obj_4c_Opt_Impressora.Buttons(loc_nJ)
687:                         .AutoSize  = .F.
688:                         .Left      = 10
689:                         .Top       = loc_nTop
690:                         .Width     = 160
691:                         .Caption   = " \<" + ALLTRIM(STR(loc_nJ)) + ". " + loc_laImpOk(loc_nJ)
692:                         .FontSize  = 8
693:                         .FontName  = "Tahoma"
694:                         .Tag       = UPPER(loc_laImpOk(loc_nJ))
695:                         .BackStyle = 0
696:                         .ForeColor = RGB(90, 90, 90)

*-- Linhas 716 a 727:
716:                 THIS.obj_4c_Opt_Impressora.ButtonCount = 1
717:                 WITH THIS.obj_4c_Opt_Impressora.Buttons(1)
718:                     .AutoSize  = .F.
719:                     .Left      = 10
720:                     .Top       = 10
721:                     .Width     = 160
722:                     .Caption   = " \<0. Gen" + CHR(233) + "rico/Somente Texto"
723:                     .Enabled   = (loc_nOk > 0)
724:                     .FontSize  = 8
725:                     .FontName  = "Tahoma"
726:                     .Tag       = "GEN" + CHR(201) + "RICO/SOMENTE TEXTO"
727:                     .BackStyle = 0

*-- Linhas 734 a 742:
734:             ENDIF
735: 
736:             *-- Posicionar cnt_4c__Impressora logo abaixo de obj_4c_Opt_Impressora
737:             THIS.cnt_4c__Impressora.Top = THIS.obj_4c_Opt_Impressora.Top + ;
738:                                            THIS.obj_4c_Opt_Impressora.Height - 2
739:             loc_nBottom2 = THIS.cnt_4c__Impressora.Top + THIS.cnt_4c__Impressora.Height
740: 
741:             *-- Inicializar spinners e opcao de impressao com valores de SigCdPam/SigCdPac
742:             WITH THIS.cnt_4c__Impressora


### BO (C:\4c\projeto\app\classes\sigprenvBO.prg):
*==============================================================================
* sigprenvBO.prg
* Business Object - Impressao de Etiquetas de Envelopes
* Tipo: OPERACIONAL
* Migrado de: sigprenv.SCX
*==============================================================================

DEFINE CLASS sigprenvBO AS BusinessBase

    *-- Campos de entrada do usuario
    this_nEtqIni           = 1     && Etiqueta Inicial
    this_nEtqQtd           = 0     && Quantidade de etiquetas

    *-- Selecao de tipo de etiqueta (Opt_Tipo)
    this_nTipoEtq          = 1     && Value do OptionGroup de tipo
    this_cTagTipoEtq       = ""    && Tag da opcao selecionada (nTipos como string)

    *-- Selecao de impressora (Opt_Impressora)
    this_nImpressora       = 1     && Value do OptionGroup de impressora
    this_cNomeImpressora   = ""    && Tag/nome da impressora selecionada

    *-- Configuracoes de impressao (Cnt_Impressora)
    this_nTpImp            = 1     && Tipo: 1=Allegro, 2=Zebra ZPL, 3=Zebra EPL
    this_nAjVerts          = 0     && Ajuste Vertical (Spn_AjVerts)
    this_nAjHorzs          = 0     && Ajuste Horizontal (Spn_AjHorzs)
    this_nAjDenss          = 10    && Ajuste Densidade (Spn_AjDenss)
    this_nAjVelos          = 3     && Ajuste Velocidade (spn_AjVelos)

    *-- Flags de estado
    this_lImpressorasOk    = .F.   && .T. se ha impressoras disponiveis
    this_lTiposOk          = .F.   && .T. se ha tipos de etiqueta configurados
    this_nTotalTipos       = 0     && Total de tipos de etiqueta disponiveis
    this_nTotalImpressoras = 0     && Total de impressoras disponiveis

    *-- Configuracoes lidas de SigCdPam/SigCdPac
    this_nMaxTpEtis        = 5     && Maximo de tipos de etiqueta (SigCdPam.nMaxTpEtis)
    this_nMaxImpEti        = 5     && Maximo de impressoras para etiqueta (SigCdPam.nMaxImpEti)
    this_nImpEtis          = 1     && Tipo de impressao padrao (SigCdPam.ImpEtis)
    this_nAjVertsPad       = 0     && Ajuste vertical padrao (SigCdPam.AjVerts)
    this_nAjHorzsPad       = 0     && Ajuste horizontal padrao (SigCdPam.AjHorzs)
    this_nAjDensPad        = 10    && Ajuste densidade padrao (SigCdPac.AjDens)
    this_nAjVelosPad       = 1     && Ajuste velocidade padrao (SigCdPac.AjVelos)

    *--------------------------------------------------------------------------
    * Init - Inicializa o BO; form operacional sem tabela/chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional sem chave primaria
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia configuracoes de SigCdPam para propriedades
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nMaxTpEtis  = NVL(nmaxtpetis, 5)
            THIS.this_nMaxImpEti  = NVL(nmaximpeti, 5)
            THIS.this_nImpEtis    = NVL(impetis, 1)
            THIS.this_nAjVertsPad = NVL(ajverts, 0)
            THIS.this_nAjHorzsPad = NVL(ajhorzs, 0)
            loc_lSucesso = .T.
        ENDIF
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Nao aplicavel para form OPERACIONAL sem tabela principal
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Inserir()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para form OPERACIONAL sem tabela principal
    *--------------------------------------------------------------------------
    PROTECTED FUNCTION Atualizar()
        RETURN .T.
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfiguracoes - Le SigCdPam e SigCdPac, popula propriedades this_
    * Retorna .T. se sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarConfiguracoes()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigCdPam")
                USE IN cursor_4c_SigCdPam
            ENDIF

            loc_cSQL = "SELECT TOP 1 nmaxtpetis, nmaximpeti, impetis, ajverts, ajhorzs, " + ;
                       "tpetipads, tpcbars FROM SigCdPam"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPam") > 0
                IF USED("cursor_4c_SigCdPam") AND !EOF("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    THIS.this_nMaxTpEtis  = NVL(nmaxtpetis, 5)
                    THIS.this_nMaxImpEti  = NVL(nmaximpeti, 5)
                    THIS.this_nImpEtis    = NVL(impetis, 1)
                    THIS.this_nAjVertsPad = NVL(ajverts, 0)
                    THIS.this_nAjHorzsPad = NVL(ajhorzs, 0)
                ENDIF
            ENDIF

            IF USED("cursor_4c_SigCdPac")
                USE IN cursor_4c_SigCdPac
            ENDIF

            loc_cSQL = "SELECT TOP 1 ajdens, ajvelos FROM SigCdPac"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdPac") > 0
                IF USED("cursor_4c_SigCdPac") AND !EOF("cursor_4c_SigCdPac")
                    SELECT cursor_4c_SigCdPac
                    THIS.this_nAjDensPad  = IIF(NVL(ajdens, 0) < 10, 10, NVL(ajdens, 0))
                    THIS.this_nAjVelosPad = IIF(NVL(ajvelos, 0) = 0, 1, NVL(ajvelos, 0))
                ENDIF
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar configura" + CHR(231) + CHR(245) + "es")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarTiposEtiqueta - Carrega tipos de etiqueta (ntipos=6, nsituas=1)
    * Cria cursor_4c_SigCdTpe ordenado por cordems
    * Retorna .T. se sucesso (mesmo sem registros)
    *--------------------------------------------------------------------------
    FUNCTION CarregarTiposEtiqueta()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL
        loc_lSucesso = .F.
        TRY
            IF USED("cursor_4c_SigCdTpe")
                USE IN cursor_4c_SigCdTpe
            ENDIF

            loc_cSQL = "SELECT cetiquetas, ntipos, nsituas, cordems " + ;
                       "FROM SigCdTpe " + ;
                       "WHERE ntipos = 6 AND nsituas = 1 " + ;
                       "ORDER BY cordems"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdTpe") > 0
                SELECT cursor_4c_SigCdTpe
                THIS.this_lTiposOk     = !EOF()
                THIS.this_nTotalTipos  = _TALLY
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar tipos de etiqueta")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarImpressoras - Carrega impressoras acessiveis pelo usuario logado
    * Cria cursor_4c_ImpAcessiveis com colunas impres, ntpimpres
    * Retorna .T. se sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarImpressoras()
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cUsuario
        loc_lSucesso = .F.
        TRY
            loc_cUsuario = EscaparSQL(ALLTRIM(gc_4c_UsuarioLogado))

            IF USED("cursor_4c_ImpAcessiveis")
                USE IN cursor_4c_ImpAcessiveis
            ENDIF
            IF USED("cursor_4c_ImpTemp")
                USE IN cursor_4c_ImpTemp
            ENDIF

            loc_cSQL = "SELECT DISTINCT b.impres, b.ntpimpres " + ;
                       "FROM SIGSYIMP a " + ;
                       "INNER JOIN SIGCDMP b ON a.cimps = b.impres " + ;
                       "WHERE a.usuacess = " + loc_cUsuario + ;
                       " UNION " + ;
                       "SELECT DISTINCT c.impres, c.ntpimpres " + ;
                       "FROM sigcdacg a " + ;
                       "INNER JOIN SIGSYIMP b ON a.grupos = b.gracess " + ;
                       "INNER JOIN SIGCDMP c ON b.cimps = c.impres " + ;
                       "WHERE a.usuarios = " + loc_cUsuario

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ImpTemp") > 0
                IF USED("cursor_4c_ImpTemp") AND !EOF("cursor_4c_ImpTemp")
                    SELECT impres, ntpimpres FROM cursor_4c_ImpTemp ;
                        INTO CURSOR cursor_4c_ImpAcessiveis READWRITE
                    SELECT cursor_4c_ImpAcessiveis
                    IF USED("cursor_4c_ImpTemp")
                        USE IN cursor_4c_ImpTemp
                    ENDIF
                    THIS.this_lImpressorasOk     = !EOF()
                    THIS.this_nTotalImpressoras  = _TALLY
                ELSE
                    THIS.this_lImpressorasOk    = .F.
                    THIS.this_nTotalImpressoras = 0
                    IF USED("cursor_4c_ImpTemp")
                        USE IN cursor_4c_ImpTemp
                    ENDIF
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar impressoras")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarConfigImpressora - Carrega ajustes de uma impressora especifica
    * Substitui fCarregarImps do Framework legado
    * Popula this_nTpImp, this_nAjVerts, this_nAjHorzs, this_nAjDenss, this_nAjVelos
    * Retorna .T. se sucesso
    *--------------------------------------------------------------------------
    FUNCTION CarregarConfigImpressora(par_cNomeImpressora)
        LOCAL loc_lSucesso, loc_oErro, loc_cSQL, loc_cNome
        loc_lSucesso = .F.
        TRY
            loc_cNome = EscaparSQL(UPPER(ALLTRIM(par_cNomeImpressora)))

            IF USED("cursor_4c_ConfigImp")
                USE IN cursor_4c_ConfigImp
            ENDIF

            loc_cSQL = "SELECT TOP 1 impetis, ajverts, ajhorzs, ajdens, ajvelos " + ;
                       "FROM SIGCDMP " + ;
                       "WHERE UPPER(RTRIM(impres)) = " + loc_cNome

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ConfigImp") > 0
                IF USED("cursor_4c_ConfigImp") AND !EOF("cursor_4c_ConfigImp")
                    SELECT cursor_4c_ConfigImp
                    THIS.this_nTpImp   = NVL(impetis, THIS.this_nImpEtis)
                    THIS.this_nAjVerts = NVL(ajverts, THIS.this_nAjVertsPad)
                    THIS.this_nAjHorzs = NVL(ajhorzs, THIS.this_nAjHorzsPad)
                    THIS.this_nAjDenss = IIF(NVL(ajdens, 0) < 10, 10, NVL(ajdens, 0))
                    THIS.this_nAjVelos = IIF(NVL(ajvelos, 0) = 0, 1, NVL(ajvelos, 0))
                ELSE
                    *-- Impressora sem config especifica: usar valores padrao
                    THIS.this_nTpImp   = THIS.this_nImpEtis
                    THIS.this_nAjVerts = THIS.this_nAjVertsPad
                    THIS.this_nAjHorzs = THIS.this_nAjHorzsPad
                    THIS.this_nAjDenss = THIS.this_nAjDensPad
                    THIS.this_nAjVelos = THIS.this_nAjVelosPad
                ENDIF
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao carregar config da impressora")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * PrepararCursorImpressao - Cria/limpa dbImpressao e insere registros
    * par_nIni - numero inicial da etiqueta
    * par_nQtd - quantidade de etiquetas
    * Retorna .T. se sucesso; cursor dbImpressao fica disponivel para SigOpEtq
    *--------------------------------------------------------------------------
    FUNCTION PrepararCursorImpressao(par_nIni, par_nQtd)
        LOCAL loc_lSucesso, loc_oErro, loc_nI, loc_nFim, loc_cCpro
        loc_lSucesso = .F.
        TRY
            IF par_nQtd <= 0
                MsgAviso("A Quantidade de Etiquetas Precisa Ser Maior Que 0 (Zero)!!!")
            ELSE
                IF USED("dbImpressao")
                    SELECT dbImpressao
                    ZAP
                ELSE
                    SET NULL ON
                    CREATE CURSOR dbImpressao ;
                        (Cpros C(10), DPros C(40) NULL, Qtds N(10,3), ;
                         QtdeEtiq N(10,3), Pedido C(30) NULL, Obs C(10) NULL)
                    SET NULL OFF
                    INDEX ON Cpros TAG Cpros
                    SET ORDER TO
                ENDIF

                loc_nFim = par_nIni + par_nQtd - 1
                FOR loc_nI = par_nIni TO loc_nFim
                    loc_cCpro = PADL(ALLTRIM(STR(loc_nI, 8)), 8, "0")
                    INSERT INTO dbImpressao (Cpros, Qtds, Pedido, QtdeEtiq) ;
                        VALUES (loc_cCpro, 1, "", 1)
                ENDFOR

                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro ao preparar cursor de impress" + CHR(227) + "o")
        ENDTRY
        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * LimparCursorImpressao - Limpa dbImpressao apos impressao concluida
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursorImpressao()
        IF USED("dbImpressao")
            SELECT dbImpressao
            ZAP
        ENDIF
    ENDPROC

ENDDEFINE

