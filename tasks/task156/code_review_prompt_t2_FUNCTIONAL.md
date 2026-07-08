# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (1)
- [CONTAINER-VISIVEL] TornarControlesVisiveis() NAO filtra containers ocultos: CNT_4C_SOMBRA. Estes containers tem Visible=.F. mas serao forcados a Visible=.T. pelo metodo recursivo.

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES FUNCIONAIS
- [CONTAINER-VISIVEL] TornarControlesVisiveis nao filtra containers ocultos (Visible=.F.). Adicionar INLIST
- [BUSCA-CURSOR] FormBuscaAuxiliar sem this_cCursorDestino no Modo 2
- [OPTIONGROUP-LEFT] Buttons sobrepostos - definir .Left, .Top, .AutoSize em CADA Button
- [CARGA-DADOS] Validar* sem chamada de carga / OptionGroup sem InteractiveChange
- [BINDEVENT-PARAMS] Handler sem LPARAMETERS (AfterRowColChange(par_nColIndex), KeyPress(par_nKeyCode, par_nShift))
- [STUB-MSGAVISO] Btn*Click com MsgAviso placeholder ao inves de logica real
- [LOSTFOCUS-SEM-GUARDIA] Handler abre busca sem verificar se valor mudou
- [INIT-DUPLICADO] Init() chama DODEFAULT() + InicializarForm() (duplicado)
- [METODO-INEXISTENTE] THIS.Metodo() chamado mas nao definido no Form. LLM pode ter inventado. IMPLEMENTAR ou REMOVER.

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2728 linhas total):

*-- Linhas 31 a 177:
31:     *==========================================================================
32:     * Init
33:     *==========================================================================
34:     PROCEDURE Init()
35:         RETURN DODEFAULT()
36:     ENDPROC
37: 
38:     *==========================================================================
39:     * Destroy - Libera cursores de trabalho
40:     *==========================================================================
41:     PROCEDURE Destroy()
42:         LOCAL loc_aCursors, loc_nI
43:         DIMENSION loc_aCursors[5]
44:         loc_aCursors[1] = "cursor_4c_Produtos"
45:         loc_aCursors[2] = "cursor_4c_TmpPro"
46:         loc_aCursors[3] = "cursor_4c_Pam"
47:         loc_aCursors[4] = "cursor_4c_Pac"
48:         loc_aCursors[5] = "cursor_4c_Grp"
49:         FOR loc_nI = 1 TO 5
50:             IF USED(loc_aCursors[loc_nI])
51:                 USE IN (loc_aCursors[loc_nI])
52:             ENDIF
53:         ENDFOR
54:         DODEFAULT()
55:     ENDPROC
56: 
57:     *==========================================================================
58:     * InicializarForm - Constru" + CHR(231) + CHR(227) + "o do form operacional
59:     *==========================================================================
60:     PROTECTED PROCEDURE InicializarForm()
61:         LOCAL loc_lSucesso, loc_oErro
62:         loc_lSucesso = .F.
63: 
64:         TRY
65:             THIS.this_oBusinessObject = CREATEOBJECT("SigPrAprBO")
66:             IF VARTYPE(THIS.this_oBusinessObject) # "O"
67:                 MsgErro("Erro ao criar SigPrAprBO.", "Erro")
68:             ELSE
69:                 IF !THIS.this_oBusinessObject.CarregarParametros()
70:                     MsgErro("Falha ao carregar par" + CHR(226) + "metros do sistema.", "Erro")
71:                 ELSE
72:                     THIS.this_oBusinessObject.this_lLibValAtu = ;
73:                         THIS.this_oBusinessObject.VerificarAcessoEdicaoManual()
74: 
75:                     *-- Cursor de produtos para o grid (vazio no inicio)
76:                     IF USED("cursor_4c_Produtos")
77:                         USE IN cursor_4c_Produtos
78:                     ENDIF
79:                     SET NULL ON
80:                     CREATE CURSOR cursor_4c_Produtos ( ;
81:                         lMarca  N(1)    NULL, ;
82:                         CPros   C(14)   NULL, ;
83:                         DPros   C(40)   NULL, ;
84:                         ValAnt  N(14,2) NULL, ;
85:                         ValAtu  N(14,2) NULL, ;
86:                         fCustos N(8,3)  NULL, ;
87:                         MoePcs  C(3)    NULL, ;
88:                         CustoFs N(12,3) NULL, ;
89:                         Manual  N(1)    NULL  ;
90:                     )
91:                     SET NULL OFF
92:                     INDEX ON CPros TAG CPros
93:                     SELECT cursor_4c_Produtos
94:                     SET ORDER TO
95:                     GO TOP
96: 
97:                     *-- Cursor de produtos temp (SigCdPro) vazio
98:                     IF USED("cursor_4c_TmpPro")
99:                         USE IN cursor_4c_TmpPro
100:                     ENDIF
101:                     LOCAL loc_nR
102:                     loc_nR = SQLEXEC(gnConnHandle, ;
103:                         "SELECT * FROM SigCdPro WHERE 0 = 1", "cursor_4c_TmpPro")
104:                     IF loc_nR > 0
105:                         SELECT cursor_4c_TmpPro
106:                         INDEX ON CPros TAG CPros
107:                         GO TOP
108:                     ENDIF
109: 
110:                     THIS.ConfigurarPageFrame()
111:                     THIS.Caption = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
112:                     THIS.ConfigurarPaginaLista()
113:                     THIS.ConfigurarPaginaDados()
114: 
115:                     THIS.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption
116:                     THIS.cnt_4c_Sombra.lbl_4c_Titulo.Caption = THIS.Caption
117: 
118:                     THIS.TornarControlesVisiveis(THIS)
119: 
120:                     *-- Visibilidade inicial por tipo (Tipo 1 = Variacao)
121:                     THIS.AtualizarVisibilidade(1)
122: 
123:                     loc_lSucesso = .T.
124:                 ENDIF
125:             ENDIF
126: 
127:         CATCH TO loc_oErro
128:             MsgErro(loc_oErro.Message, "Erro em InicializarForm")
129:         ENDTRY
130: 
131:         RETURN loc_lSucesso
132:     ENDPROC
133: 
134:     *==========================================================================
135:     * ConfigurarPageFrame - Fundo + container cabecalho cinza
136:     *==========================================================================
137:     PROTECTED PROCEDURE ConfigurarPageFrame()
138:         THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
139: 
140:         THIS.AddObject("cnt_4c_Sombra", "Container")
141:         WITH THIS.cnt_4c_Sombra
142:             .Top         = 0
143:             .Left        = 0
144:             .Width       = THIS.Width
145:             .Height      = 80
146:             .BackColor   = RGB(100, 100, 100)
147:             .BackStyle   = 1
148:             .BorderWidth = 0
149: 
150:             .AddObject("lbl_4c_Sombra", "Label")
151:             WITH .lbl_4c_Sombra
152:                 .Top       = 18
153:                 .Left      = 10
154:                 .Width     = THIS.Width
155:                 .Height    = 40
156:                 .AutoSize  = .F.
157:                 .FontBold  = .T.
158:                 .FontName  = "Tahoma"
159:                 .FontSize  = 18
160:                 .BackStyle = 0
161:                 .ForeColor = RGB(0, 0, 0)
162:                 .WordWrap  = .T.
163:                 .Caption   = "Reajuste de Precifica" + CHR(231) + CHR(227) + "o"
164:             ENDWITH
165: 
166:             .AddObject("lbl_4c_Titulo", "Label")
167:             WITH .lbl_4c_Titulo
168:                 .Top       = 17
169:                 .Left      = 10
170:                 .Width     = THIS.Width
171:                 .Height    = 46
172:                 .AutoSize  = .F.
173:                 .FontBold  = .T.
174:                 .FontName  = "Tahoma"
175:                 .FontSize  = 18
176:                 .BackStyle = 0
177:                 .ForeColor = RGB(255, 255, 255)

*-- Linhas 184 a 227:
184:     *==========================================================================
185:     * ConfigurarPaginaLista - Todos os controles do form operacional
186:     *==========================================================================
187:     PROTECTED PROCEDURE ConfigurarPaginaLista()
188: 
189:         *----------------------------------------------------------------------
190:         * CommandGroup: Processar | Atualizar | Encerrar
191:         *----------------------------------------------------------------------
192:         THIS.AddObject("cmg_4c_Acao", "CommandGroup")
193:         WITH THIS.cmg_4c_Acao
194:             .Top           = 0
195:             .Left          = 770
196:             .Width         = 225
197:             .Height        = 85
198:             .BackStyle     = 0
199:             .BorderStyle   = 0
200:             .SpecialEffect = 1
201:             .ButtonCount   = 3
202:             .Themes        = .F.
203:             .AutoSize      = .F.
204: 
205:             WITH .Buttons(1)
206:                 .Top             = 5
207:                 .Left            = 5
208:                 .Width           = 75
209:                 .Height          = 75
210:                 .Caption         = "Processar"
211:                 .FontBold        = .T.
212:                 .FontItalic      = .T.
213:                 .ForeColor       = RGB(90, 90, 90)
214:                 .BackColor       = RGB(255, 255, 255)
215:                 .Themes          = .F.
216:                 .SpecialEffect   = 0
217:                 .PicturePosition = 13
218:                 .WordWrap        = .T.
219:                 .AutoSize        = .F.
220:                 .MousePointer    = 15
221:                 .Picture         = gc_4c_CaminhoIcones + "geral_processar_60.jpg"
222:             ENDWITH
223: 
224:             WITH .Buttons(2)
225:                 .Top             = 5
226:                 .Left            = 80
227:                 .Width           = 75

*-- Linhas 265 a 433:
265:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
266:             ENDWITH
267:         ENDWITH
268:         BINDEVENT(THIS.cmg_4c_Acao.Buttons(1), "Click", THIS, "BtnProcessarClick")
269:         BINDEVENT(THIS.cmg_4c_Acao.Buttons(2), "Click", THIS, "BtnAtualizarClick")
270:         BINDEVENT(THIS.cmg_4c_Acao.Buttons(3), "Click", THIS, "BtnEncerrarClick")
271: 
272:         *----------------------------------------------------------------------
273:         * OptionGroup: Tipo de reajuste
274:         *----------------------------------------------------------------------
275:         THIS.AddObject("opt_4c_Tipo", "OptionGroup")
276:         WITH THIS.opt_4c_Tipo
277:             .Top           = 134
278:             .Left          = 159
279:             .Width         = 208
280:             .Height        = 24
281:             .BackStyle     = 0
282:             .BorderStyle   = 0
283:             .AutoSize      = .F.
284:             .ButtonCount   = 3
285:             .Value         = 1
286: 
287:             WITH .Buttons(1)
288:                 .Left      = 5
289:                 .Top       = 5
290:                 .Width     = 59
291:                 .Height    = 15
292:                 .Caption   = "Varia" + CHR(231) + CHR(227) + "o"
293:                 .BackStyle = 0
294:                 .AutoSize  = .T.
295:                 .ForeColor = RGB(90, 90, 90)
296:             ENDWITH
297: 
298:             WITH .Buttons(2)
299:                 .Left      = 74
300:                 .Top       = 5
301:                 .Height    = 15
302:                 .Caption   = "MarkUp"
303:                 .BackStyle = 0
304:                 .AutoSize  = .T.
305:                 .ForeColor = RGB(90, 90, 90)
306:                 .FontName  = "Tahoma"
307:                 .FontSize  = 8
308:             ENDWITH
309: 
310:             WITH .Buttons(3)
311:                 .Left      = 139
312:                 .Top       = 5
313:                 .Width     = 53
314:                 .Height    = 15
315:                 .Caption   = "C" + CHR(226) + "mbio"
316:                 .BackStyle = 0
317:                 .AutoSize  = .T.
318:                 .ForeColor = RGB(90, 90, 90)
319:                 .FontName  = "Tahoma"
320:                 .FontSize  = 8
321:             ENDWITH
322:         ENDWITH
323:         BINDEVENT(THIS.opt_4c_Tipo, "InteractiveChange", THIS, "OptTipoInteractiveChange")
324: 
325:         *----------------------------------------------------------------------
326:         * Label: "Grupo de Produto :"
327:         *----------------------------------------------------------------------
328:         THIS.AddObject("lbl_4c_Grupo", "Label")
329:         WITH THIS.lbl_4c_Grupo
330:             .Top       = 113
331:             .Left      = 69
332:             .Width     = 94
333:             .Height    = 15
334:             .AutoSize  = .T.
335:             .Caption   = "Grupo de Produto :"
336:             .FontName  = "Tahoma"
337:             .FontSize  = 8
338:             .BackStyle = 0
339:             .ForeColor = RGB(90, 90, 90)
340:         ENDWITH
341: 
342:         *-- TextBox: Grupo de (codigo)
343:         THIS.AddObject("txt_4c_CdGrupo", "TextBox")
344:         WITH THIS.txt_4c_CdGrupo
345:             .Top           = 109
346:             .Left          = 165
347:             .Width         = 31
348:             .Height        = 23
349:             .MaxLength     = 3
350:             .Format        = "K!"
351:             .SpecialEffect = 1
352:             .FontName      = "Tahoma"
353:             .FontSize      = 8
354:             .ForeColor     = RGB(0, 0, 0)
355:             .BackColor     = RGB(255, 255, 255)
356:             .BorderColor   = RGB(100, 100, 100)
357:         ENDWITH
358:         BINDEVENT(THIS.txt_4c_CdGrupo, "DblClick", THIS, "AbrirBuscaCdGrupo")
359:         BINDEVENT(THIS.txt_4c_CdGrupo, "KeyPress", THIS, "TeclaLookupCdGrupo")
360: 
361:         *-- Label: "at" + CHR(233)
362:         THIS.AddObject("lbl_4c_Ate", "Label")
363:         WITH THIS.lbl_4c_Ate
364:             .Top       = 113
365:             .Left      = 203
366:             .Width     = 18
367:             .Height    = 15
368:             .AutoSize  = .T.
369:             .Caption   = "at" + CHR(233)
370:             .FontName  = "Tahoma"
371:             .FontSize  = 8
372:             .BackStyle = 0
373:             .ForeColor = RGB(90, 90, 90)
374:         ENDWITH
375: 
376:         *-- TextBox: Grupo ate (codigo)
377:         THIS.AddObject("txt_4c_AteGrupo", "TextBox")
378:         WITH THIS.txt_4c_AteGrupo
379:             .Top           = 109
380:             .Left          = 228
381:             .Width         = 31
382:             .Height        = 23
383:             .MaxLength     = 3
384:             .Format        = "K!"
385:             .SpecialEffect = 1
386:             .FontName      = "Tahoma"
387:             .FontSize      = 8
388:             .ForeColor     = RGB(0, 0, 0)
389:             .BackColor     = RGB(255, 255, 255)
390:             .BorderColor   = RGB(100, 100, 100)
391:         ENDWITH
392:         BINDEVENT(THIS.txt_4c_AteGrupo, "DblClick", THIS, "AbrirBuscaAteGrupo")
393:         BINDEVENT(THIS.txt_4c_AteGrupo, "KeyPress", THIS, "TeclaLookupAteGrupo")
394: 
395:         *-- Label: "Ignorar Componentes" (CheckBox)
396:         THIS.AddObject("chk_4c_Ignorar", "CheckBox")
397:         WITH THIS.chk_4c_Ignorar
398:             .Top       = 112
399:             .Left      = 609
400:             .Width     = 123
401:             .Height    = 15
402:             .AutoSize  = .T.
403:             .Caption   = "Ignorar Componentes"
404:             .BackStyle = 0
405:             .Value     = 0
406:             .FontName  = "Tahoma"
407:             .FontSize  = 8
408:             .ForeColor = RGB(90, 90, 90)
409:             .ToolTipText = "N" + CHR(227) + "o Checa Se o Produto Est" + CHR(225) + ;
410:                            " em Uso Como Componente de Outros Produtos"
411:         ENDWITH
412: 
413:         *-- Label: "Grupo de Venda :" (Colecao)
414:         THIS.AddObject("lbl_4c_GrupoVd", "Label")
415:         WITH THIS.lbl_4c_GrupoVd
416:             .Top       = 113
417:             .Left      = 399
418:             .Width     = 86
419:             .Height    = 15
420:             .AutoSize  = .T.
421:             .Caption   = "Cole" + CHR(231) + CHR(227) + "o :"
422:             .FontName  = "Tahoma"
423:             .FontSize  = 8
424:             .BackStyle = 0
425:             .ForeColor = RGB(90, 90, 90)
426:         ENDWITH
427: 
428:         *-- TextBox: Colecao
429:         THIS.AddObject("txt_4c_Col", "TextBox")
430:         WITH THIS.txt_4c_Col
431:             .Top           = 109
432:             .Left          = 487
433:             .Width         = 94

*-- Linhas 440 a 484:
440:             .ForeColor     = RGB(0, 0, 0)
441:             .BorderColor   = RGB(100, 100, 100)
442:         ENDWITH
443:         BINDEVENT(THIS.txt_4c_Col, "DblClick", THIS, "AbrirBuscaCol")
444:         BINDEVENT(THIS.txt_4c_Col, "KeyPress", THIS, "TeclaLookupCol")
445: 
446:         *----------------------------------------------------------------------
447:         * Label: "Reajuste por :"
448:         *----------------------------------------------------------------------
449:         THIS.AddObject("lbl_4c_TipoLabel", "Label")
450:         WITH THIS.lbl_4c_TipoLabel
451:             .Top       = 139
452:             .Left      = 92
453:             .Width     = 71
454:             .Height    = 15
455:             .AutoSize  = .T.
456:             .Caption   = "Reajuste por :"
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:             .BackStyle = 0
460:             .ForeColor = RGB(90, 90, 90)
461:         ENDWITH
462: 
463:         *-- Label: "Variacao de Preco :" (Tipo 1)
464:         THIS.AddObject("lbl_4c_Variacao", "Label")
465:         WITH THIS.lbl_4c_Variacao
466:             .Top       = 139
467:             .Left      = 390
468:             .Width     = 95
469:             .Height    = 15
470:             .AutoSize  = .T.
471:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o de Pre" + CHR(231) + "o :"
472:             .FontName  = "Tahoma"
473:             .FontSize  = 8
474:             .BackStyle = 0
475:             .ForeColor = RGB(90, 90, 90)
476:         ENDWITH
477: 
478:         *-- TextBox: Variacao (Tipo 1)
479:         THIS.AddObject("txt_4c_Variacao", "TextBox")
480:         WITH THIS.txt_4c_Variacao
481:             .Top           = 135
482:             .Left          = 487
483:             .Width         = 94
484:             .Height        = 23

*-- Linhas 494 a 537:
494:             .BorderColor   = RGB(100, 100, 100)
495:             .Value         = 0
496:         ENDWITH
497:         BINDEVENT(THIS.txt_4c_Variacao, "KeyPress", THIS, "TxtVariacaoLostFocus")
498: 
499:         *-- Label: "%" (Tipo 1)
500:         THIS.AddObject("lbl_4c_Pct", "Label")
501:         WITH THIS.lbl_4c_Pct
502:             .Top       = 139
503:             .Left      = 585
504:             .Width     = 13
505:             .Height    = 15
506:             .AutoSize  = .T.
507:             .Caption   = "%"
508:             .FontName  = "Tahoma"
509:             .FontSize  = 8
510:             .BackStyle = 0
511:             .ForeColor = RGB(90, 90, 90)
512:         ENDWITH
513: 
514:         *-- CheckBox: "Incluir Custos" (Tipo 1)
515:         THIS.AddObject("chk_4c_IncCusts", "CheckBox")
516:         WITH THIS.chk_4c_IncCusts
517:             .Top       = 139
518:             .Left      = 609
519:             .Width     = 83
520:             .Height    = 15
521:             .AutoSize  = .T.
522:             .Caption   = "Incluir Custos"
523:             .BackStyle = 0
524:             .Value     = 0
525:             .FontName  = "Tahoma"
526:             .FontSize  = 8
527:             .ForeColor = RGB(90, 90, 90)
528:         ENDWITH
529: 
530:         *-- Label: "Moeda :" (Tipo 2)
531:         THIS.AddObject("lbl_4c_Moeda", "Label")
532:         WITH THIS.lbl_4c_Moeda
533:             .Top       = 139
534:             .Left      = 444
535:             .Width     = 41
536:             .Height    = 15
537:             .AutoSize  = .T.

*-- Linhas 557 a 601:
557:             .ForeColor     = RGB(0, 0, 0)
558:             .BorderColor   = RGB(100, 100, 100)
559:         ENDWITH
560:         BINDEVENT(THIS.txt_4c_Moeda, "DblClick", THIS, "AbrirBuscaMoeda")
561:         BINDEVENT(THIS.txt_4c_Moeda, "KeyPress", THIS, "TeclaLookupMoeda")
562: 
563:         *----------------------------------------------------------------------
564:         * Row 2: Fator de Custo / MarkUp de / para
565:         *----------------------------------------------------------------------
566: 
567:         *-- Label: "Fator de Custo:" (Tipo 2)
568:         THIS.AddObject("lbl_4c_Fator", "Label")
569:         WITH THIS.lbl_4c_Fator
570:             .Top       = 165
571:             .Left      = 85
572:             .Width     = 78
573:             .Height    = 15
574:             .AutoSize  = .T.
575:             .Caption   = "Fator de Custo:"
576:             .FontName  = "Tahoma"
577:             .FontSize  = 8
578:             .BackStyle = 0
579:             .ForeColor = RGB(90, 90, 90)
580:         ENDWITH
581: 
582:         *-- TextBox: Fator (Tipo 2)
583:         THIS.AddObject("txt_4c_Fator", "TextBox")
584:         WITH THIS.txt_4c_Fator
585:             .Top           = 161
586:             .Left          = 165
587:             .Width         = 73
588:             .Height        = 23
589:             .Alignment     = 3
590:             .InputMask     = "9999.999"
591:             .MaxLength     = 8
592:             .SpecialEffect = 1
593:             .FontName      = "Tahoma"
594:             .FontSize      = 8
595:             .ForeColor     = RGB(0, 0, 0)
596:             .BorderColor   = RGB(100, 100, 100)
597:             .Value         = 0
598:         ENDWITH
599: 
600:         *-- TextBox: Moeda Custo (Tipo 2)
601:         THIS.AddObject("txt_4c_MoeCusto", "TextBox")

*-- Linhas 611 a 655:
611:             .FontSize      = 8
612:             .BorderColor   = RGB(90, 90, 90)
613:         ENDWITH
614:         BINDEVENT(THIS.txt_4c_MoeCusto, "DblClick", THIS, "AbrirBuscaMoeCusto")
615:         BINDEVENT(THIS.txt_4c_MoeCusto, "KeyPress", THIS, "TeclaLookupMoeCusto")
616: 
617:         *-- Label: "MarkUp :" (Tipo 2)
618:         THIS.AddObject("lbl_4c_MarkUp", "Label")
619:         WITH THIS.lbl_4c_MarkUp
620:             .Top       = 165
621:             .Left      = 440
622:             .Width     = 45
623:             .Height    = 15
624:             .AutoSize  = .T.
625:             .Caption   = "MarkUp :"
626:             .FontName  = "Tahoma"
627:             .FontSize  = 8
628:             .BackStyle = 0
629:             .ForeColor = RGB(90, 90, 90)
630:         ENDWITH
631: 
632:         *-- TextBox: MarkUp1 (Tipo 2)
633:         THIS.AddObject("txt_4c_MarkUp1", "TextBox")
634:         WITH THIS.txt_4c_MarkUp1
635:             .Top           = 161
636:             .Left          = 487
637:             .Width         = 52
638:             .Height        = 23
639:             .Alignment     = 3
640:             .InputMask     = "999.99"
641:             .MaxLength     = 6
642:             .SpecialEffect = 1
643:             .FontName      = "Tahoma"
644:             .FontSize      = 8
645:             .ForeColor     = RGB(0, 0, 0)
646:             .BorderColor   = RGB(100, 100, 100)
647:             .Value         = 0
648:         ENDWITH
649: 
650:         *-- Label: "para" (Tipo 2)
651:         THIS.AddObject("lbl_4c_Para", "Label")
652:         WITH THIS.lbl_4c_Para
653:             .Top       = 165
654:             .Left      = 547
655:             .Width     = 24

*-- Linhas 715 a 759:
715:             .BackColor     = RGB(255, 255, 255)
716:             .BorderColor   = RGB(100, 100, 100)
717:         ENDWITH
718:         BINDEVENT(THIS.txt_4c_Promo, "DblClick", THIS, "AbrirBuscaPromo")
719:         BINDEVENT(THIS.txt_4c_Promo, "KeyPress", THIS, "TeclaLookupPromo")
720: 
721:         *-- CheckBox: "Limpar Promo" + CHR(231) + CHR(245) + "es Anteriores"
722:         THIS.AddObject("chk_4c_Limpar", "CheckBox")
723:         WITH THIS.chk_4c_Limpar
724:             .Top       = 191
725:             .Left      = 362
726:             .Width     = 157
727:             .Height    = 15
728:             .AutoSize  = .T.
729:             .Caption   = "Limpar Promo" + CHR(231) + CHR(245) + "es Anteriores"
730:             .BackStyle = 0
731:             .Value     = 0
732:             .FontName  = "Tahoma"
733:             .FontSize  = 8
734:             .ForeColor = RGB(90, 90, 90)
735:         ENDWITH
736: 
737:         *----------------------------------------------------------------------
738:         * Row 4: Fornecedor
739:         *----------------------------------------------------------------------
740: 
741:         *-- Label: "Fornecedor :"
742:         THIS.AddObject("lbl_4c_Forne", "Label")
743:         WITH THIS.lbl_4c_Forne
744:             .Top       = 216
745:             .Left      = 99
746:             .Width     = 64
747:             .Height    = 15
748:             .AutoSize  = .T.
749:             .Caption   = "Fornecedor :"
750:             .FontName  = "Tahoma"
751:             .FontSize  = 8
752:             .BackStyle = 0
753:             .ForeColor = RGB(90, 90, 90)
754:         ENDWITH
755: 
756:         *-- TextBox: Conta (codigo fornecedor)
757:         THIS.AddObject("txt_4c_Conta", "TextBox")
758:         WITH THIS.txt_4c_Conta
759:             .Top           = 213

*-- Linhas 766 a 1023:
766:             .ForeColor     = RGB(0, 0, 0)
767:             .BorderColor   = RGB(100, 100, 100)
768:         ENDWITH
769:         BINDEVENT(THIS.txt_4c_Conta, "DblClick", THIS, "AbrirBuscaConta")
770:         BINDEVENT(THIS.txt_4c_Conta, "KeyPress", THIS, "TeclaLookupConta")
771: 
772:         *-- TextBox: DConta (descricao fornecedor)
773:         THIS.AddObject("txt_4c_DConta", "TextBox")
774:         WITH THIS.txt_4c_DConta
775:             .Top           = 213
776:             .Left          = 248
777:             .Width         = 290
778:             .Height        = 23
779:             .MaxLength     = 50
780:             .SpecialEffect = 1
781:             .FontName      = "Tahoma"
782:             .FontSize      = 8
783:             .ForeColor     = RGB(0, 0, 0)
784:             .BorderColor   = RGB(100, 100, 100)
785:         ENDWITH
786:         BINDEVENT(THIS.txt_4c_DConta, "DblClick", THIS, "AbrirBuscaDConta")
787:         BINDEVENT(THIS.txt_4c_DConta, "KeyPress", THIS, "TeclaLookupDConta")
788: 
789:         *----------------------------------------------------------------------
790:         * Row 5: Moeda Custo Compo / Moeda Preco Ideal / Feitio
791:         *----------------------------------------------------------------------
792: 
793:         *-- Label: "Moeda Custo Compo. :" (Tipo 2)
794:         THIS.AddObject("lbl_4c_Moecs", "Label")
795:         WITH THIS.lbl_4c_Moecs
796:             .Top       = 244
797:             .Left      = 51
798:             .Width     = 112
799:             .Height    = 15
800:             .AutoSize  = .T.
801:             .Caption   = "Moeda Custo Compo. :"
802:             .FontName  = "Tahoma"
803:             .FontSize  = 8
804:             .BackStyle = 0
805:             .ForeColor = RGB(90, 90, 90)
806:         ENDWITH
807: 
808:         *-- TextBox: Moecs (Tipo 2)
809:         THIS.AddObject("txt_4c_Moecs", "TextBox")
810:         WITH THIS.txt_4c_Moecs
811:             .Top           = 240
812:             .Left          = 165
813:             .Width         = 31
814:             .Height        = 23
815:             .MaxLength     = 3
816:             .Format        = "K!"
817:             .SpecialEffect = 1
818:             .FontName      = "Tahoma"
819:             .FontSize      = 8
820:             .ForeColor     = RGB(0, 0, 0)
821:             .BorderColor   = RGB(100, 100, 100)
822:         ENDWITH
823:         BINDEVENT(THIS.txt_4c_Moecs, "DblClick", THIS, "AbrirBuscaMoecs")
824:         BINDEVENT(THIS.txt_4c_Moecs, "KeyPress", THIS, "TeclaLookupMoecs")
825: 
826:         *-- Label: "Moeda Pre" + CHR(231) + "o Ideal :" (Tipo 2)
827:         THIS.AddObject("lbl_4c_Moedas", "Label")
828:         WITH THIS.lbl_4c_Moedas
829:             .Top       = 244
830:             .Left      = 320
831:             .Width     = 98
832:             .Height    = 15
833:             .AutoSize  = .T.
834:             .Caption   = "Moeda Pre" + CHR(231) + "o Ideal :"
835:             .FontName  = "Tahoma"
836:             .FontSize  = 8
837:             .BackStyle = 0
838:             .ForeColor = RGB(90, 90, 90)
839:         ENDWITH
840: 
841:         *-- TextBox: Moedas (Tipo 2)
842:         THIS.AddObject("txt_4c_Moedas", "TextBox")
843:         WITH THIS.txt_4c_Moedas
844:             .Top           = 240
845:             .Left          = 420
846:             .Width         = 31
847:             .Height        = 23
848:             .MaxLength     = 3
849:             .Format        = "K!"
850:             .SpecialEffect = 1
851:             .FontName      = "Tahoma"
852:             .FontSize      = 8
853:             .ForeColor     = RGB(0, 0, 0)
854:             .BorderColor   = RGB(100, 100, 100)
855:         ENDWITH
856:         BINDEVENT(THIS.txt_4c_Moedas, "DblClick", THIS, "AbrirBuscaMoedas")
857:         BINDEVENT(THIS.txt_4c_Moedas, "KeyPress", THIS, "TeclaLookupMoedas")
858: 
859:         *-- Label: "Feitio :" (Tipo 2)
860:         THIS.AddObject("lbl_4c_CFtios", "Label")
861:         WITH THIS.lbl_4c_CFtios
862:             .Top       = 244
863:             .Left      = 531
864:             .Width     = 35
865:             .Height    = 15
866:             .AutoSize  = .T.
867:             .Caption   = "Feitio :"
868:             .FontName  = "Tahoma"
869:             .FontSize  = 8
870:             .BackStyle = 0
871:             .ForeColor = RGB(90, 90, 90)
872:         ENDWITH
873: 
874:         *-- TextBox: CFtios (Tipo 2)
875:         THIS.AddObject("txt_4c_CFtios", "TextBox")
876:         WITH THIS.txt_4c_CFtios
877:             .Top           = 240
878:             .Left          = 568
879:             .Width         = 31
880:             .Height        = 23
881:             .MaxLength     = 3
882:             .Format        = "K!"
883:             .SpecialEffect = 1
884:             .FontName      = "Tahoma"
885:             .FontSize      = 8
886:             .ForeColor     = RGB(0, 0, 0)
887:             .BorderColor   = RGB(100, 100, 100)
888:         ENDWITH
889:         BINDEVENT(THIS.txt_4c_CFtios, "DblClick", THIS, "AbrirBuscaCFtios")
890:         BINDEVENT(THIS.txt_4c_CFtios, "KeyPress", THIS, "TeclaLookupCFtios")
891: 
892:         *----------------------------------------------------------------------
893:         * Row 6: Moeda Custo Total / Moeda Preco Atual
894:         *----------------------------------------------------------------------
895: 
896:         *-- Label: "Moeda Custo Total :" (Tipo 2)
897:         THIS.AddObject("lbl_4c_MoeCusFs", "Label")
898:         WITH THIS.lbl_4c_MoeCusFs
899:             .Top       = 270
900:             .Left      = 64
901:             .Width     = 99
902:             .Height    = 15
903:             .AutoSize  = .T.
904:             .Caption   = "Moeda Custo Total :"
905:             .FontName  = "Tahoma"
906:             .FontSize  = 8
907:             .BackStyle = 0
908:             .ForeColor = RGB(90, 90, 90)
909:         ENDWITH
910: 
911:         *-- TextBox: MoeCusFs (Tipo 2)
912:         THIS.AddObject("txt_4c_MoeCusFs", "TextBox")
913:         WITH THIS.txt_4c_MoeCusFs
914:             .Top           = 266
915:             .Left          = 165
916:             .Width         = 31
917:             .Height        = 23
918:             .MaxLength     = 3
919:             .Format        = "K!"
920:             .SpecialEffect = 1
921:             .FontName      = "Tahoma"
922:             .FontSize      = 8
923:             .ForeColor     = RGB(0, 0, 0)
924:             .BorderColor   = RGB(100, 100, 100)
925:         ENDWITH
926:         BINDEVENT(THIS.txt_4c_MoeCusFs, "DblClick", THIS, "AbrirBuscaMoeCusFs")
927:         BINDEVENT(THIS.txt_4c_MoeCusFs, "KeyPress", THIS, "TeclaLookupMoeCusFs")
928: 
929:         *-- Label: "Moeda Pre" + CHR(231) + "o Atual :" (Tipo 2)
930:         THIS.AddObject("lbl_4c_MoeVs", "Label")
931:         WITH THIS.lbl_4c_MoeVs
932:             .Top       = 270
933:             .Left      = 319
934:             .Width     = 99
935:             .Height    = 15
936:             .AutoSize  = .T.
937:             .Caption   = "Moeda Pre" + CHR(231) + "o Atual :"
938:             .FontName  = "Tahoma"
939:             .FontSize  = 8
940:             .BackStyle = 0
941:             .ForeColor = RGB(90, 90, 90)
942:         ENDWITH
943: 
944:         *-- TextBox: MoeVs (Tipo 2)
945:         THIS.AddObject("txt_4c_MoeVs", "TextBox")
946:         WITH THIS.txt_4c_MoeVs
947:             .Top           = 266
948:             .Left          = 420
949:             .Width         = 31
950:             .Height        = 23
951:             .MaxLength     = 3
952:             .Format        = "K!"
953:             .SpecialEffect = 1
954:             .FontName      = "Tahoma"
955:             .FontSize      = 8
956:             .ForeColor     = RGB(0, 0, 0)
957:             .BorderColor   = RGB(100, 100, 100)
958:         ENDWITH
959:         BINDEVENT(THIS.txt_4c_MoeVs, "DblClick", THIS, "AbrirBuscaMoeVs")
960:         BINDEVENT(THIS.txt_4c_MoeVs, "KeyPress", THIS, "TeclaLookupMoeVs")
961: 
962:         *----------------------------------------------------------------------
963:         * CheckBox: Modo manual "Produtos" (chkAuditado)
964:         *----------------------------------------------------------------------
965:         THIS.AddObject("chk_4c_Auditado", "CheckBox")
966:         WITH THIS.chk_4c_Auditado
967:             .Top           = 307
968:             .Left          = 763
969:             .Width         = 75
970:             .Height        = 75
971:             .Style         = 1
972:             .Caption       = "Produtos"
973:             .Value         = 0
974:             .FontBold      = .T.
975:             .FontItalic    = .T.
976:             .FontName      = "Tahoma"
977:             .FontSize      = 8
978:             .ForeColor     = RGB(90, 90, 90)
979:             .BackColor     = RGB(255, 255, 255)
980:             .Themes        = .F.
981:             .Picture       = gc_4c_CaminhoIcones + "geral_produtos_60.jpg"
982:         ENDWITH
983:         BINDEVENT(THIS.chk_4c_Auditado, "Click", THIS, "ChkAuditadoClick")
984: 
985:         *----------------------------------------------------------------------
986:         * Grid de produtos
987:         *----------------------------------------------------------------------
988:         THIS.AddObject("grd_4c_Produtos", "Grid")
989:         WITH THIS.grd_4c_Produtos
990:             .Top          = 307
991:             .Left         = 31
992:             .Width        = 725
993:             .Height       = 247
994:             .FontName     = "Verdana"
995:             .FontSize     = 8
996:             .HeaderHeight = 20
997:             .RowHeight    = 16
998:             .ScrollBars   = 2
999:             .DeleteMark   = .F.
1000:             .RecordMark   = .F.
1001:             .GridLines    = 3
1002:             .ColumnCount  = 5
1003: 
1004:             *-- Column1: CheckBox de selecao (lMarca)
1005:             WITH .Column1
1006:                 .Width         = 20
1007:                 .Alignment     = 3
1008:                 .Movable       = .F.
1009:                 .Resizable     = .F.
1010:                 .Sparse        = .F.
1011:                 .FontName      = "Verdana"
1012:                 .FontSize      = 8
1013:                 .Header1.Caption   = ""
1014:                 .Header1.Picture   = gc_4c_CaminhoIcones + "checkbx.bmp"
1015:                 .Header1.Alignment = 2
1016:                 .Header1.FontName  = "Verdana"
1017:                 .Header1.FontSize  = 8
1018:             ENDWITH
1019: 
1020:             *-- Column2: Codigo do produto (CPros)
1021:             WITH .Column2
1022:                 .Width             = 108
1023:                 .Movable           = .F.

*-- Linhas 1103 a 1192:
1103:         *-- Column2 come?a ReadOnly (modo normal; auditor inverte)
1104:         THIS.grd_4c_Produtos.Column2.ReadOnly = .T.
1105: 
1106:         BINDEVENT(THIS.grd_4c_Produtos, "AfterRowColChange", THIS, "GrdAfterRowColChange")
1107:         BINDEVENT(THIS.grd_4c_Produtos.Column1.Header1, "Click", THIS, "GrdHeaderClick")
1108: 
1109:         *----------------------------------------------------------------------
1110:         * Shape e Image para foto do produto
1111:         *----------------------------------------------------------------------
1112:         THIS.AddObject("shp_4c_Foto", "Shape")
1113:         WITH THIS.shp_4c_Foto
1114:             .Top          = 414
1115:             .Left         = 763
1116:             .Width        = 205
1117:             .Height       = 140
1118:             .BackStyle    = 0
1119:             .BorderStyle  = 1
1120:             .FillStyle    = 1
1121:             .SpecialEffect = 1
1122:             .BorderColor  = RGB(90, 90, 90)
1123:         ENDWITH
1124: 
1125:         THIS.AddObject("img_4c_Foto", "Image")
1126:         WITH THIS.img_4c_Foto
1127:             .Top     = 415
1128:             .Left    = 764
1129:             .Width   = 203
1130:             .Height  = 138
1131:             .Stretch = 1
1132:             .Visible = .F.
1133:         ENDWITH
1134: 
1135:     ENDPROC
1136: 
1137:     *==========================================================================
1138:     * ConfigurarPaginaDados - Form OPERACIONAL nao usa Page2; metodo requerido
1139:     * pela hierarquia FormBase mas sem conteudo aplicavel aqui.
1140:     *==========================================================================
1141:     PROTECTED PROCEDURE ConfigurarPaginaDados()
1142:         RETURN
1143:     ENDPROC
1144: 
1145:     *==========================================================================
1146:     * AlternarPagina - Reset da area operacional (limpa grid, filtros e foco)
1147:     *   par_nPagina = 1 -> reset completo (equivalente a nova consulta)
1148:     *   par_nPagina = 2 -> apenas limpar grid e desabilitar Atualizar
1149:     * OPERACIONAL nao possui Page1/Page2; AlternarPagina age como reset de
1150:     * estado, retornando o form ao ponto inicial de trabalho.
1151:     *==========================================================================
1152:     PROCEDURE AlternarPagina(par_nPagina)
1153:         LOCAL loc_nModo
1154:         loc_nModo = IIF(VARTYPE(par_nPagina) = "N" AND par_nPagina > 0, par_nPagina, 1)
1155: 
1156:         *-- Zera o cursor do grid de produtos
1157:         IF USED("cursor_4c_Produtos")
1158:             SELECT cursor_4c_Produtos
1159:             IF RECCOUNT() > 0
1160:                 ZAP
1161:             ENDIF
1162:         ENDIF
1163: 
1164:         *-- Desabilita o botao Atualizar (fica ativo apenas apos Processar)
1165:         IF VARTYPE(THIS.cmg_4c_Acao) = "O"
1166:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .F.
1167:             THIS.cmg_4c_Acao.Buttons(2).Refresh
1168:         ENDIF
1169: 
1170:         *-- Reseta selecao global do header (checkbox da coluna 1)
1171:         THIS.this_lAllSelected = .T.
1172:         THIS.this_lInCol5      = .F.
1173:         THIS.this_nAntValAtu   = 0
1174: 
1175:         IF loc_nModo = 1
1176:             *-- Reset COMPLETO: limpa TODOS os campos de filtro/parametros
1177:             IF VARTYPE(THIS.txt_4c_CdGrupo)  = "O"
1178:                 THIS.txt_4c_CdGrupo.Value  = ""
1179:             ENDIF
1180:             IF VARTYPE(THIS.txt_4c_AteGrupo) = "O"
1181:                 THIS.txt_4c_AteGrupo.Value = ""
1182:             ENDIF
1183:             IF VARTYPE(THIS.txt_4c_Col)      = "O"
1184:                 THIS.txt_4c_Col.Value      = ""
1185:             ENDIF
1186:             IF VARTYPE(THIS.txt_4c_Conta)    = "O"
1187:                 THIS.txt_4c_Conta.Value    = ""
1188:             ENDIF
1189:             IF VARTYPE(THIS.txt_4c_DConta)   = "O"
1190:                 THIS.txt_4c_DConta.Value   = ""
1191:             ENDIF
1192:             IF VARTYPE(THIS.txt_4c_Variacao) = "O"

*-- Linhas 1264 a 1471:
1264:     ENDPROC
1265: 
1266:     *==========================================================================
1267:     * TornarControlesVisiveis - Recursivo, respeita a regra de recursao antes do LOOP
1268:     *==========================================================================
1269:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1270:         LOCAL loc_nI, loc_oObjeto
1271:         IF VARTYPE(par_oContainer) # "O"
1272:             RETURN
1273:         ENDIF
1274:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1275:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1276:             IF VARTYPE(loc_oObjeto) = "O"
1277:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1278:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1279:                 ENDIF
1280:                 *-- img_4c_Foto comeca oculta; controlada por GrdAfterRowColChange
1281:                 *-- cnt_4c_Sombra permanece Visible=.F.; visibilidade controlada externamente
1282:                 IF INLIST(UPPER(loc_oObjeto.Name), "IMG_4C_FOTO", "CNT_4C_SOMBRA")
1283:                     LOOP
1284:                 ENDIF
1285:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1286:                     loc_oObjeto.Visible = .T.
1287:                 ENDIF
1288:             ENDIF
1289:         ENDFOR
1290:     ENDPROC
1291: 
1292:     *==========================================================================
1293:     * AtualizarVisibilidade - Mostra/oculta controles pelo tipo de reajuste
1294:     *==========================================================================
1295:     PROCEDURE AtualizarVisibilidade(par_nTipo)
1296:         LOCAL loc_lTipo1, loc_lTipo2
1297: 
1298:         loc_lTipo1 = (par_nTipo = 1)
1299:         loc_lTipo2 = (par_nTipo = 2)
1300: 
1301:         *-- Tipo 1: Variacao
1302:         THIS.lbl_4c_Variacao.Visible = loc_lTipo1
1303:         THIS.txt_4c_Variacao.Visible = loc_lTipo1
1304:         THIS.lbl_4c_Pct.Visible      = loc_lTipo1
1305:         THIS.chk_4c_IncCusts.Visible = loc_lTipo1
1306: 
1307:         *-- Tipo 2: MarkUp
1308:         THIS.lbl_4c_Moeda.Visible    = loc_lTipo2
1309:         THIS.txt_4c_Moeda.Visible    = loc_lTipo2
1310:         THIS.lbl_4c_MarkUp.Visible   = loc_lTipo2
1311:         THIS.txt_4c_MarkUp1.Visible  = loc_lTipo2
1312:         THIS.lbl_4c_Para.Visible     = loc_lTipo2
1313:         THIS.txt_4c_MarkUp2.Visible  = loc_lTipo2
1314:         THIS.lbl_4c_Fator.Visible    = loc_lTipo2
1315:         THIS.txt_4c_Fator.Visible    = loc_lTipo2
1316:         THIS.txt_4c_MoeCusto.Visible = loc_lTipo2
1317:         THIS.lbl_4c_Moecs.Visible    = loc_lTipo2
1318:         THIS.txt_4c_Moecs.Visible    = loc_lTipo2
1319:         THIS.lbl_4c_MoeCusFs.Visible = loc_lTipo2
1320:         THIS.txt_4c_MoeCusFs.Visible = loc_lTipo2
1321:         THIS.lbl_4c_Moedas.Visible   = loc_lTipo2
1322:         THIS.txt_4c_Moedas.Visible   = loc_lTipo2
1323:         THIS.lbl_4c_CFtios.Visible   = loc_lTipo2
1324:         THIS.txt_4c_CFtios.Visible   = loc_lTipo2
1325:         THIS.lbl_4c_MoeVs.Visible    = loc_lTipo2
1326:         THIS.txt_4c_MoeVs.Visible    = loc_lTipo2
1327: 
1328:         THIS.Refresh
1329:     ENDPROC
1330: 
1331:     *==========================================================================
1332:     * OptTipoInteractiveChange - Atualiza visibilidade ao mudar tipo
1333:     *==========================================================================
1334:     PROCEDURE OptTipoInteractiveChange()
1335:         THIS.AtualizarVisibilidade(THIS.opt_4c_Tipo.Value)
1336:     ENDPROC
1337: 
1338:     *==========================================================================
1339:     * BtnProcessarClick - Coleta campos, chama ProcessarReajuste()
1340:     *==========================================================================
1341:     PROCEDURE BtnProcessarClick()
1342:         LOCAL loc_oBO
1343: 
1344:         loc_oBO = THIS.this_oBusinessObject
1345:         IF VARTYPE(loc_oBO) # "O"
1346:             RETURN
1347:         ENDIF
1348: 
1349:         *-- Transfere campos do form para o BO
1350:         loc_oBO.this_nTipo      = THIS.opt_4c_Tipo.Value
1351:         loc_oBO.this_cCdGrupo   = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value,  ""))
1352:         loc_oBO.this_cAteGrupo  = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
1353:         loc_oBO.this_cCol       = ALLTRIM(NVL(THIS.txt_4c_Col.Value,       ""))
1354:         loc_oBO.this_cConta     = ALLTRIM(NVL(THIS.txt_4c_Conta.Value,     ""))
1355:         loc_oBO.this_cDConta    = ALLTRIM(NVL(THIS.txt_4c_DConta.Value,    ""))
1356:         loc_oBO.this_nIgnorar   = THIS.chk_4c_Ignorar.Value
1357:         loc_oBO.this_nVariacao  = NVL(THIS.txt_4c_Variacao.Value, 0)
1358:         loc_oBO.this_nIncCusts  = THIS.chk_4c_IncCusts.Value
1359:         loc_oBO.this_cMoeda     = ALLTRIM(NVL(THIS.txt_4c_Moeda.Value,    ""))
1360:         loc_oBO.this_nMarkUp1   = NVL(THIS.txt_4c_MarkUp1.Value,  0)
1361:         loc_oBO.this_nMarkUp2   = NVL(THIS.txt_4c_MarkUp2.Value,  0)
1362:         loc_oBO.this_nFator     = NVL(THIS.txt_4c_Fator.Value,    0)
1363:         loc_oBO.this_cMoeCusto  = ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, ""))
1364:         loc_oBO.this_cMoecs     = ALLTRIM(NVL(THIS.txt_4c_Moecs.Value,    ""))
1365:         loc_oBO.this_cMoeCusFs  = ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, ""))
1366:         loc_oBO.this_cMoedas    = ALLTRIM(NVL(THIS.txt_4c_Moedas.Value,   ""))
1367:         loc_oBO.this_cCFtios    = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value,   ""))
1368:         loc_oBO.this_cMoeVs     = ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value,    ""))
1369:         loc_oBO.this_cPromo     = ALLTRIM(NVL(THIS.txt_4c_Promo.Value,    ""))
1370:         loc_oBO.this_nLimpar    = THIS.chk_4c_Limpar.Value
1371:         loc_oBO.this_nAuditado  = THIS.chk_4c_Auditado.Value
1372: 
1373:         IF loc_oBO.ProcessarReajuste()
1374:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
1375:             THIS.grd_4c_Produtos.Column1.SetFocus
1376:             THIS.grd_4c_Produtos.Refresh
1377:         ENDIF
1378:     ENDPROC
1379: 
1380:     *==========================================================================
1381:     * BtnAtualizarClick - Chama AtualizarPrecos(), desabilita Atualizar
1382:     *==========================================================================
1383:     PROCEDURE BtnAtualizarClick()
1384:         LOCAL loc_oBO
1385:         loc_oBO = THIS.this_oBusinessObject
1386:         IF VARTYPE(loc_oBO) # "O"
1387:             RETURN
1388:         ENDIF
1389:         IF loc_oBO.AtualizarPrecos()
1390:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .F.
1391:             THIS.cmg_4c_Acao.Buttons(2).Refresh
1392:         ENDIF
1393:     ENDPROC
1394: 
1395:     *==========================================================================
1396:     * BtnEncerrarClick - Fecha o form
1397:     *==========================================================================
1398:     PROCEDURE BtnEncerrarClick()
1399:         THIS.Release
1400:     ENDPROC
1401: 
1402:     *==========================================================================
1403:     * TxtVariacaoLostFocus - Move foco para Processar ao sair do campo
1404:     *==========================================================================
1405:     PROCEDURE TxtVariacaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1406:         THIS.cmg_4c_Acao.Buttons(1).SetFocus
1407:     ENDPROC
1408: 
1409:     *==========================================================================
1410:     * GrdHeaderClick - Alterna selecao de todos os produtos (lMarca)
1411:     *==========================================================================
1412:     PROCEDURE GrdHeaderClick()
1413:         IF !USED("cursor_4c_Produtos")
1414:             RETURN
1415:         ENDIF
1416:         IF THIS.this_lAllSelected
1417:             UPDATE cursor_4c_Produtos SET lMarca = 0
1418:             THIS.this_lAllSelected = .F.
1419:         ELSE
1420:             UPDATE cursor_4c_Produtos SET lMarca = 1
1421:             THIS.this_lAllSelected = .T.
1422:         ENDIF
1423:         THIS.grd_4c_Produtos.Refresh
1424:         THIS.Refresh
1425:     ENDPROC
1426: 
1427:     *==========================================================================
1428:     * GrdAfterRowColChange - Manual tracking + auditor lookup + foto produto
1429:     * par_nColIndex = coluna que acabou de ser ENTADA (nova coluna ativa)
1430:     *==========================================================================
1431:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1432:         LOCAL loc_lcArqFig, loc_nResult, loc_lcFoto, loc_cCPros
1433: 
1434:         IF !USED("cursor_4c_Produtos")
1435:             RETURN
1436:         ENDIF
1437:         SELECT cursor_4c_Produtos
1438: 
1439:         *-- Rastreia edicao manual de ValAtu (Column5): detecta saida da coluna
1440:         IF par_nColIndex != 5 AND THIS.this_lInCol5
1441:             IF !EOF("cursor_4c_Produtos") AND ;
1442:                NVL(cursor_4c_Produtos.ValAtu, 0) != THIS.this_nAntValAtu
1443:                 REPLACE Manual WITH 1 IN cursor_4c_Produtos
1444:                 *-- Em modo LibValAtu: adiciona linha vazia no fundo se ultimo item tem produto
1445:                 *-- Equivale ao Column5.Text1.Valid do legado (Insert From MemVar + DNARROW)
1446:                 IF THIS.this_oBusinessObject.this_lLibValAtu
1447:                     SET ORDER TO
1448:                     GO BOTTOM
1449:                     IF !EMPTY(ALLTRIM(NVL(cursor_4c_Produtos.CPros, "")))
1450:                         INSERT INTO cursor_4c_Produtos ;
1451:                             (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1452:                             VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, SPACE(3), 0, 0)
1453:                     ENDIF
1454:                     THIS.grd_4c_Produtos.Refresh
1455:                 ENDIF
1456:             ENDIF
1457:             THIS.this_lInCol5 = .F.
1458:         ENDIF
1459:         IF par_nColIndex = 5 AND !EOF("cursor_4c_Produtos")
1460:             THIS.this_nAntValAtu = NVL(cursor_4c_Produtos.ValAtu, 0)
1461:             THIS.this_lInCol5    = .T.
1462:         ENDIF
1463: 
1464:         *-- Modo auditado: ao sair de Column2 com codigo preenchido, carrega produto
1465:         IF par_nColIndex != 2 AND THIS.chk_4c_Auditado.Value = 1 ;
1466:             AND !EOF("cursor_4c_Produtos")
1467:             loc_cCPros = ALLTRIM(NVL(cursor_4c_Produtos.CPros, ""))
1468:             IF !EMPTY(loc_cCPros)
1469:                 THIS.CarregarProdutoAuditado(loc_cCPros)
1470:             ENDIF
1471:         ENDIF

*-- Linhas 1513 a 1556:
1513:     * CarregarProdutoAuditado - Modo auditado: busca produto e calcula preco
1514:     * Chamado por GrdAfterRowColChange ao sair de Column2 com um codigo
1515:     *==========================================================================
1516:     PROCEDURE CarregarProdutoAuditado(par_cCPros)
1517:         LOCAL loc_nResult, loc_nTipo, loc_nVariacao, loc_nMarkUp2
1518:         LOCAL loc_nValAtu, loc_nCotId, loc_nCotVd, loc_nPVen, loc_nVlVen
1519: 
1520:         IF EMPTY(ALLTRIM(par_cCPros))
1521:             RETURN
1522:         ENDIF
1523: 
1524:         *-- Busca produto em SigCdPro e adiciona a cursor_4c_TmpPro
1525:         IF USED("cursor_4c_ProdAud")
1526:             USE IN cursor_4c_ProdAud
1527:         ENDIF
1528:         loc_nResult = SQLEXEC(gnConnHandle, ;
1529:             "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCPros)), ;
1530:             "cursor_4c_ProdAud")
1531:         IF loc_nResult < 1 OR EOF("cursor_4c_ProdAud")
1532:             IF USED("cursor_4c_ProdAud")
1533:                 USE IN cursor_4c_ProdAud
1534:             ENDIF
1535:             THIS.AbrirBuscaProdutoGrd()
1536:             RETURN
1537:         ENDIF
1538: 
1539:         *-- Insere no cursor_4c_TmpPro se ainda nao existe
1540:         IF USED("cursor_4c_TmpPro")
1541:             IF !SEEK(ALLTRIM(par_cCPros), "cursor_4c_TmpPro", "CPros")
1542:                 SELECT cursor_4c_ProdAud
1543:                 GO TOP
1544:                 LOCAL loc_oErroIns
1545:                 TRY
1546:                     SELECT cursor_4c_TmpPro
1547:                     APPEND BLANK
1548:                     *-- Copia campos essenciais manualmente (SCATTER/GATHER pode falhar entre cursores)
1549:                     REPLACE CPros    WITH ALLTRIM(cursor_4c_ProdAud.CPros)
1550:                     REPLACE DPros    WITH ALLTRIM(NVL(cursor_4c_ProdAud.DPros,    ""))
1551:                     REPLACE PVens    WITH NVL(cursor_4c_ProdAud.PVens,    0)
1552:                     REPLACE PVIdeals WITH NVL(cursor_4c_ProdAud.PVIdeals, 0)
1553:                     REPLACE PCuss    WITH NVL(cursor_4c_ProdAud.PCuss,    0)
1554:                     REPLACE CustoFs  WITH NVL(cursor_4c_ProdAud.CustoFs,  0)
1555:                     REPLACE fCustos  WITH NVL(cursor_4c_ProdAud.fCustos,  0)
1556:                     REPLACE Margems  WITH NVL(cursor_4c_ProdAud.Margems,  0)

*-- Linhas 1634 a 1677:
1634:     *==========================================================================
1635:     * ChkAuditadoClick - Alterna modo de entrada manual de produtos
1636:     *==========================================================================
1637:     PROCEDURE ChkAuditadoClick()
1638:         IF THIS.chk_4c_Auditado.Value = 1
1639:             *-- Modo auditado: limpa grid, Column2 editavel, Column1 readonly
1640:             IF USED("cursor_4c_Produtos")
1641:                 LOCAL loc_lMarca_v, loc_cCPros_v, loc_cDPros_v, loc_nValAtu_v, loc_nValAnt_v
1642:                 loc_lMarca_v = 0
1643:                 loc_cCPros_v = SPACE(14)
1644:                 loc_cDPros_v = SPACE(40)
1645:                 loc_nValAtu_v = 0
1646:                 loc_nValAnt_v = 0
1647:                 INSERT INTO cursor_4c_Produtos (lMarca, CPros, DPros, ValAtu, ValAnt) ;
1648:                     VALUES (loc_lMarca_v, loc_cCPros_v, loc_cDPros_v, loc_nValAtu_v, loc_nValAnt_v)
1649:                 SELECT cursor_4c_Produtos
1650:                 SET ORDER TO
1651:                 GO TOP
1652:             ENDIF
1653:             THIS.txt_4c_CdGrupo.Enabled  = .F.
1654:             THIS.txt_4c_AteGrupo.Enabled = .F.
1655:             THIS.txt_4c_Col.Enabled      = .F.
1656:             THIS.txt_4c_Moeda.Enabled    = .F.
1657:             THIS.txt_4c_MarkUp1.Enabled  = .F.
1658:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .F.
1659:             THIS.grd_4c_Produtos.Column1.ReadOnly = .T.
1660:             THIS.grd_4c_Produtos.Column2.ReadOnly = .F.
1661:             THIS.grd_4c_Produtos.Column2.SetFocus
1662:             THIS.grd_4c_Produtos.Refresh
1663:         ELSE
1664:             *-- Modo normal: limpa grid, Column2 readonly, Column1 editavel
1665:             IF USED("cursor_4c_Produtos")
1666:                 DELETE FROM cursor_4c_Produtos
1667:             ENDIF
1668:             THIS.txt_4c_CdGrupo.Enabled  = .T.
1669:             THIS.txt_4c_AteGrupo.Enabled = .T.
1670:             THIS.txt_4c_Col.Enabled      = .T.
1671:             THIS.txt_4c_Moeda.Enabled    = .T.
1672:             THIS.txt_4c_MarkUp1.Enabled  = .T.
1673:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
1674:             THIS.grd_4c_Produtos.Column1.ReadOnly = .F.
1675:             THIS.grd_4c_Produtos.Column2.ReadOnly = .T.
1676:             SELECT cursor_4c_Produtos
1677:             SET ORDER TO CPros

*-- Linhas 1686 a 2550:
1686:     *==========================================================================
1687: 
1688:     *-- Helper generico para SigCdMoe
1689:     PROTECTED PROCEDURE BuscarMoedaHelper(par_oTxt)
1690:         LOCAL loc_cValor, loc_oForm
1691:         loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))
1692:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1693:             "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, "Moedas")
1694:         IF ISNULL(loc_oForm)
1695:             RETURN
1696:         ENDIF
1697:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1698:             par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1699:         ELSE
1700:             IF !loc_oForm.this_lAchouRegistro
1701:             loc_oForm.mAddColuna("CMoes",  "XXXXXX", "C" + CHR(243) + "digo")
1702:             loc_oForm.mAddColuna("DMoes",  "",       "Descri" + CHR(231) + CHR(227) + "o")
1703:             loc_oForm.Show()
1704:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1705:                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1706:             ENDIF
1707:             ENDIF
1708:         ENDIF
1709:         IF USED("cursor_4c_BuscaMoe")
1710:             USE IN cursor_4c_BuscaMoe
1711:         ENDIF
1712:         loc_oForm.Release()
1713:     ENDPROC
1714: 
1715:     *==========================================================================
1716:     * Lookups - SigCdGrp (CdGrupo)
1717:     *==========================================================================
1718:     PROCEDURE AbrirBuscaCdGrupo()
1719:         LOCAL loc_cValor, loc_oForm
1720:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value, ""))
1721:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1722:             "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cValor, ;
1723:             "Grupos de Produto")
1724:         IF ISNULL(loc_oForm)
1725:             RETURN
1726:         ENDIF
1727:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1728:             THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1729:             IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
1730:                 THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
1731:             ENDIF
1732:         ELSE
1733:             IF !loc_oForm.this_lAchouRegistro
1734:             loc_oForm.mAddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
1735:             loc_oForm.mAddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
1736:             loc_oForm.Show()
1737:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1738:                 THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1739:                 IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
1740:                     THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
1741:                 ENDIF
1742:             ENDIF
1743:             ENDIF
1744:         ENDIF
1745:         IF USED("cursor_4c_BuscaGrp")
1746:             USE IN cursor_4c_BuscaGrp
1747:         ENDIF
1748:         loc_oForm.Release()
1749:     ENDPROC
1750: 
1751:     PROCEDURE TeclaLookupCdGrupo(par_nKeyCode, par_nShiftAltCtrl)
1752:         IF INLIST(par_nKeyCode, 115, 116)
1753:             THIS.AbrirBuscaCdGrupo()
1754:         ELSE
1755:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1756:             THIS.ValidarCdGrupo()
1757:             ENDIF
1758:         ENDIF
1759:     ENDPROC
1760: 
1761:     PROCEDURE ValidarCdGrupo()
1762:         LOCAL loc_cVal, loc_nR
1763:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value, "")))
1764:         IF EMPTY(loc_cVal)
1765:             RETURN
1766:         ENDIF
1767:         loc_nR = SQLEXEC(gnConnHandle, ;
1768:             "SELECT CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cVal), ;
1769:             "cursor_4c_ValGrp")
1770:         IF loc_nR > 0 AND !EOF("cursor_4c_ValGrp")
1771:             THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_ValGrp.CGrus)
1772:             IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
1773:                 THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
1774:             ENDIF
1775:         ELSE
1776:             MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "")
1777:             THIS.txt_4c_CdGrupo.Value = ""
1778:             THIS.AbrirBuscaCdGrupo()
1779:         ENDIF
1780:         IF USED("cursor_4c_ValGrp")
1781:             USE IN cursor_4c_ValGrp
1782:         ENDIF
1783:     ENDPROC
1784: 
1785:     *==========================================================================
1786:     * Lookups - SigCdGrp (AteGrupo)
1787:     *==========================================================================
1788:     PROCEDURE AbrirBuscaAteGrupo()
1789:         LOCAL loc_cValor, loc_oForm
1790:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
1791:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1792:             "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cValor, ;
1793:             "Grupos de Produto")
1794:         IF ISNULL(loc_oForm)
1795:             RETURN
1796:         ENDIF
1797:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1798:             THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1799:         ELSE
1800:             IF !loc_oForm.this_lAchouRegistro
1801:             loc_oForm.mAddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
1802:             loc_oForm.mAddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
1803:             loc_oForm.Show()
1804:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1805:                 THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1806:             ENDIF
1807:             ENDIF
1808:         ENDIF
1809:         IF USED("cursor_4c_BuscaGrp")
1810:             USE IN cursor_4c_BuscaGrp
1811:         ENDIF
1812:         loc_oForm.Release()
1813:     ENDPROC
1814: 
1815:     PROCEDURE TeclaLookupAteGrupo(par_nKeyCode, par_nShiftAltCtrl)
1816:         IF INLIST(par_nKeyCode, 115, 116)
1817:             THIS.AbrirBuscaAteGrupo()
1818:         ELSE
1819:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1820:             THIS.ValidarAteGrupo()
1821:             ENDIF
1822:         ENDIF
1823:     ENDPROC
1824: 
1825:     PROCEDURE ValidarAteGrupo()
1826:         LOCAL loc_cVal, loc_nR
1827:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, "")))
1828:         IF EMPTY(loc_cVal)
1829:             RETURN
1830:         ENDIF
1831:         loc_nR = SQLEXEC(gnConnHandle, ;
1832:             "SELECT CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cVal), ;
1833:             "cursor_4c_ValGrp")
1834:         IF loc_nR > 0 AND !EOF("cursor_4c_ValGrp")
1835:             THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_ValGrp.CGrus)
1836:         ELSE
1837:             MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "")
1838:             THIS.txt_4c_AteGrupo.Value = ""
1839:             THIS.AbrirBuscaAteGrupo()
1840:         ENDIF
1841:         IF USED("cursor_4c_ValGrp")
1842:             USE IN cursor_4c_ValGrp
1843:         ENDIF
1844:     ENDPROC
1845: 
1846:     *==========================================================================
1847:     * Lookups - SigCdCol
1848:     *==========================================================================
1849:     PROCEDURE AbrirBuscaCol()
1850:         LOCAL loc_cValor, loc_oForm
1851:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Col.Value, ""))
1852:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1853:             "SigCdCol", "cursor_4c_BuscaCol", "Colecoes", loc_cValor, ;
1854:             "Cole" + CHR(231) + CHR(245) + "es")
1855:         IF ISNULL(loc_oForm)
1856:             RETURN
1857:         ENDIF
1858:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1859:             THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1860:         ELSE
1861:             IF !loc_oForm.this_lAchouRegistro
1862:             loc_oForm.mAddColuna("Colecoes", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1863:             loc_oForm.mAddColuna("Descs",    "",           "Descri" + CHR(231) + CHR(227) + "o")
1864:             loc_oForm.Show()
1865:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCol")
1866:                 THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1867:             ENDIF
1868:             ENDIF
1869:         ENDIF
1870:         IF USED("cursor_4c_BuscaCol")
1871:             USE IN cursor_4c_BuscaCol
1872:         ENDIF
1873:         loc_oForm.Release()
1874:     ENDPROC
1875: 
1876:     PROCEDURE TeclaLookupCol(par_nKeyCode, par_nShiftAltCtrl)
1877:         IF INLIST(par_nKeyCode, 115, 116)
1878:             THIS.AbrirBuscaCol()
1879:         ELSE
1880:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1881:             THIS.ValidarCol()
1882:             ENDIF
1883:         ENDIF
1884:     ENDPROC
1885: 
1886:     PROCEDURE ValidarCol()
1887:         LOCAL loc_cVal, loc_nR
1888:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Col.Value, "")))
1889:         IF EMPTY(loc_cVal)
1890:             RETURN
1891:         ENDIF
1892:         loc_nR = SQLEXEC(gnConnHandle, ;
1893:             "SELECT Colecoes FROM SigCdCol WHERE Colecoes = " + EscaparSQL(loc_cVal), ;
1894:             "cursor_4c_ValCol")
1895:         IF loc_nR > 0 AND !EOF("cursor_4c_ValCol")
1896:             THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_ValCol.Colecoes)
1897:         ELSE
1898:             MsgAviso("Cole" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "")
1899:             THIS.txt_4c_Col.Value = ""
1900:             THIS.AbrirBuscaCol()
1901:         ENDIF
1902:         IF USED("cursor_4c_ValCol")
1903:             USE IN cursor_4c_ValCol
1904:         ENDIF
1905:     ENDPROC
1906: 
1907:     *==========================================================================
1908:     * Lookups - SigCdMoe (Moeda - Tipo 2)
1909:     *==========================================================================
1910:     PROCEDURE AbrirBuscaMoeda()
1911:         THIS.BuscarMoedaHelper(THIS.txt_4c_Moeda)
1912:     ENDPROC
1913: 
1914:     PROCEDURE TeclaLookupMoeda(par_nKeyCode, par_nShiftAltCtrl)
1915:         IF INLIST(par_nKeyCode, 115, 116)
1916:             THIS.AbrirBuscaMoeda()
1917:         ELSE
1918:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1919:             THIS.ValidarMoeda()
1920:             ENDIF
1921:         ENDIF
1922:     ENDPROC
1923: 
1924:     PROCEDURE ValidarMoeda()
1925:         LOCAL loc_cVal, loc_nR
1926:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Moeda.Value, "")))
1927:         IF EMPTY(loc_cVal)
1928:             RETURN
1929:         ENDIF
1930:         loc_nR = SQLEXEC(gnConnHandle, ;
1931:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
1932:             "cursor_4c_ValMoe")
1933:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
1934:             THIS.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
1935:         ELSE
1936:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
1937:             THIS.txt_4c_Moeda.Value = ""
1938:             THIS.AbrirBuscaMoeda()
1939:         ENDIF
1940:         IF USED("cursor_4c_ValMoe")
1941:             USE IN cursor_4c_ValMoe
1942:         ENDIF
1943:     ENDPROC
1944: 
1945:     *==========================================================================
1946:     * Lookups - SigCdMoe (Moecs)
1947:     *==========================================================================
1948:     PROCEDURE AbrirBuscaMoecs()
1949:         THIS.BuscarMoedaHelper(THIS.txt_4c_Moecs)
1950:     ENDPROC
1951: 
1952:     PROCEDURE TeclaLookupMoecs(par_nKeyCode, par_nShiftAltCtrl)
1953:         IF INLIST(par_nKeyCode, 115, 116)
1954:             THIS.AbrirBuscaMoecs()
1955:         ELSE
1956:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1957:             THIS.ValidarMoecs()
1958:             ENDIF
1959:         ENDIF
1960:     ENDPROC
1961: 
1962:     PROCEDURE ValidarMoecs()
1963:         LOCAL loc_cVal, loc_nR
1964:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Moecs.Value, "")))
1965:         IF EMPTY(loc_cVal)
1966:             RETURN
1967:         ENDIF
1968:         loc_nR = SQLEXEC(gnConnHandle, ;
1969:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
1970:             "cursor_4c_ValMoe")
1971:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
1972:             THIS.txt_4c_Moecs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
1973:         ELSE
1974:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
1975:             THIS.txt_4c_Moecs.Value = ""
1976:             THIS.AbrirBuscaMoecs()
1977:         ENDIF
1978:         IF USED("cursor_4c_ValMoe")
1979:             USE IN cursor_4c_ValMoe
1980:         ENDIF
1981:     ENDPROC
1982: 
1983:     *==========================================================================
1984:     * Lookups - SigCdMoe (MoeCusFs)
1985:     *==========================================================================
1986:     PROCEDURE AbrirBuscaMoeCusFs()
1987:         THIS.BuscarMoedaHelper(THIS.txt_4c_MoeCusFs)
1988:     ENDPROC
1989: 
1990:     PROCEDURE TeclaLookupMoeCusFs(par_nKeyCode, par_nShiftAltCtrl)
1991:         IF INLIST(par_nKeyCode, 115, 116)
1992:             THIS.AbrirBuscaMoeCusFs()
1993:         ELSE
1994:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1995:             THIS.ValidarMoeCusFs()
1996:             ENDIF
1997:         ENDIF
1998:     ENDPROC
1999: 
2000:     PROCEDURE ValidarMoeCusFs()
2001:         LOCAL loc_cVal, loc_nR
2002:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, "")))
2003:         IF EMPTY(loc_cVal)
2004:             RETURN
2005:         ENDIF
2006:         loc_nR = SQLEXEC(gnConnHandle, ;
2007:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2008:             "cursor_4c_ValMoe")
2009:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2010:             THIS.txt_4c_MoeCusFs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2011:         ELSE
2012:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2013:             THIS.txt_4c_MoeCusFs.Value = ""
2014:             THIS.AbrirBuscaMoeCusFs()
2015:         ENDIF
2016:         IF USED("cursor_4c_ValMoe")
2017:             USE IN cursor_4c_ValMoe
2018:         ENDIF
2019:     ENDPROC
2020: 
2021:     *==========================================================================
2022:     * Lookups - SigCdMoe (Moedas = Moeda Preco Ideal)
2023:     *==========================================================================
2024:     PROCEDURE AbrirBuscaMoedas()
2025:         THIS.BuscarMoedaHelper(THIS.txt_4c_Moedas)
2026:     ENDPROC
2027: 
2028:     PROCEDURE TeclaLookupMoedas(par_nKeyCode, par_nShiftAltCtrl)
2029:         IF INLIST(par_nKeyCode, 115, 116)
2030:             THIS.AbrirBuscaMoedas()
2031:         ELSE
2032:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2033:             THIS.ValidarMoedas()
2034:             ENDIF
2035:         ENDIF
2036:     ENDPROC
2037: 
2038:     PROCEDURE ValidarMoedas()
2039:         LOCAL loc_cVal, loc_nR
2040:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Moedas.Value, "")))
2041:         IF EMPTY(loc_cVal)
2042:             RETURN
2043:         ENDIF
2044:         loc_nR = SQLEXEC(gnConnHandle, ;
2045:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2046:             "cursor_4c_ValMoe")
2047:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2048:             THIS.txt_4c_Moedas.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2049:         ELSE
2050:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2051:             THIS.txt_4c_Moedas.Value = ""
2052:             THIS.AbrirBuscaMoedas()
2053:         ENDIF
2054:         IF USED("cursor_4c_ValMoe")
2055:             USE IN cursor_4c_ValMoe
2056:         ENDIF
2057:     ENDPROC
2058: 
2059:     *==========================================================================
2060:     * Lookups - SigCdMoe (MoeCusto = Moeda do Custo)
2061:     *==========================================================================
2062:     PROCEDURE AbrirBuscaMoeCusto()
2063:         THIS.BuscarMoedaHelper(THIS.txt_4c_MoeCusto)
2064:     ENDPROC
2065: 
2066:     PROCEDURE TeclaLookupMoeCusto(par_nKeyCode, par_nShiftAltCtrl)
2067:         IF INLIST(par_nKeyCode, 115, 116)
2068:             THIS.AbrirBuscaMoeCusto()
2069:         ELSE
2070:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2071:             THIS.ValidarMoeCusto()
2072:             ENDIF
2073:         ENDIF
2074:     ENDPROC
2075: 
2076:     PROCEDURE ValidarMoeCusto()
2077:         LOCAL loc_cVal, loc_nR
2078:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, "")))
2079:         IF EMPTY(loc_cVal)
2080:             RETURN
2081:         ENDIF
2082:         loc_nR = SQLEXEC(gnConnHandle, ;
2083:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2084:             "cursor_4c_ValMoe")
2085:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2086:             THIS.txt_4c_MoeCusto.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2087:         ELSE
2088:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2089:             THIS.txt_4c_MoeCusto.Value = ""
2090:             THIS.AbrirBuscaMoeCusto()
2091:         ENDIF
2092:         IF USED("cursor_4c_ValMoe")
2093:             USE IN cursor_4c_ValMoe
2094:         ENDIF
2095:     ENDPROC
2096: 
2097:     *==========================================================================
2098:     * Lookups - SigCdMoe (MoeVs = Moeda Preco Atual)
2099:     *==========================================================================
2100:     PROCEDURE AbrirBuscaMoeVs()
2101:         THIS.BuscarMoedaHelper(THIS.txt_4c_MoeVs)
2102:     ENDPROC
2103: 
2104:     PROCEDURE TeclaLookupMoeVs(par_nKeyCode, par_nShiftAltCtrl)
2105:         IF INLIST(par_nKeyCode, 115, 116)
2106:             THIS.AbrirBuscaMoeVs()
2107:         ELSE
2108:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2109:             THIS.ValidarMoeVs()
2110:             ENDIF
2111:         ENDIF
2112:     ENDPROC
2113: 
2114:     PROCEDURE ValidarMoeVs()
2115:         LOCAL loc_cVal, loc_nR
2116:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value, "")))
2117:         IF EMPTY(loc_cVal)
2118:             RETURN
2119:         ENDIF
2120:         loc_nR = SQLEXEC(gnConnHandle, ;
2121:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2122:             "cursor_4c_ValMoe")
2123:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2124:             THIS.txt_4c_MoeVs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2125:         ELSE
2126:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2127:             THIS.txt_4c_MoeVs.Value = ""
2128:             THIS.AbrirBuscaMoeVs()
2129:         ENDIF
2130:         IF USED("cursor_4c_ValMoe")
2131:             USE IN cursor_4c_ValMoe
2132:         ENDIF
2133:     ENDPROC
2134: 
2135:     *==========================================================================
2136:     * Lookups - SigPrFti (CFtios = Feitio)
2137:     *==========================================================================
2138:     PROCEDURE AbrirBuscaCFtios()
2139:         LOCAL loc_cValor, loc_oForm
2140:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value, ""))
2141:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2142:             "SigPrFti", "cursor_4c_BuscaFtio", "Cods", loc_cValor, "Feitio")
2143:         IF ISNULL(loc_oForm)
2144:             RETURN
2145:         ENDIF
2146:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
2147:             THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
2148:         ELSE
2149:             IF !loc_oForm.this_lAchouRegistro
2150:             loc_oForm.mAddColuna("Cods",  "XXXXXX", "C" + CHR(243) + "digo")
2151:             loc_oForm.mAddColuna("Descs", "",       "Descri" + CHR(231) + CHR(227) + "o")
2152:             loc_oForm.Show()
2153:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaFtio")
2154:                 THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
2155:             ENDIF
2156:             ENDIF
2157:         ENDIF
2158:         IF USED("cursor_4c_BuscaFtio")
2159:             USE IN cursor_4c_BuscaFtio
2160:         ENDIF
2161:         loc_oForm.Release()
2162:     ENDPROC
2163: 
2164:     PROCEDURE TeclaLookupCFtios(par_nKeyCode, par_nShiftAltCtrl)
2165:         IF INLIST(par_nKeyCode, 115, 116)
2166:             THIS.AbrirBuscaCFtios()
2167:         ELSE
2168:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2169:             THIS.ValidarCFtios()
2170:             ENDIF
2171:         ENDIF
2172:     ENDPROC
2173: 
2174:     PROCEDURE ValidarCFtios()
2175:         LOCAL loc_cVal, loc_nR
2176:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_CFtios.Value, "")))
2177:         IF EMPTY(loc_cVal)
2178:             RETURN
2179:         ENDIF
2180:         loc_nR = SQLEXEC(gnConnHandle, ;
2181:             "SELECT Cods FROM SigPrFti WHERE Cods = " + EscaparSQL(loc_cVal), ;
2182:             "cursor_4c_ValFtio")
2183:         IF loc_nR > 0 AND !EOF("cursor_4c_ValFtio")
2184:             THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_ValFtio.Cods)
2185:         ELSE
2186:             MsgAviso("Feitio n" + CHR(227) + "o encontrado.", "")
2187:             THIS.txt_4c_CFtios.Value = ""
2188:             THIS.AbrirBuscaCFtios()
2189:         ENDIF
2190:         IF USED("cursor_4c_ValFtio")
2191:             USE IN cursor_4c_ValFtio
2192:         ENDIF
2193:     ENDPROC
2194: 
2195:     *==========================================================================
2196:     * Lookups - Fornecedor via fAcessoContas (Conta / DConta)
2197:     *==========================================================================
2198:     PROCEDURE AbrirBuscaConta()
2199:         fAcessoContas(gc_4c_UsuarioLogado, ;
2200:                       THIS.this_oBusinessObject.this_cGrPadFors, ;
2201:                       "C", THIS.txt_4c_Conta.Value, ;
2202:                       THIS.txt_4c_Conta, THIS.txt_4c_DConta)
2203:     ENDPROC
2204: 
2205:     PROCEDURE TeclaLookupConta(par_nKeyCode, par_nShiftAltCtrl)
2206:         IF INLIST(par_nKeyCode, 115, 116)
2207:             THIS.AbrirBuscaConta()
2208:         ELSE
2209:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2210:             THIS.ValidarConta()
2211:             ENDIF
2212:         ENDIF
2213:     ENDPROC
2214: 
2215:     PROCEDURE ValidarConta()
2216:         IF !EMPTY(ALLTRIM(NVL(THIS.txt_4c_Conta.Value, "")))
2217:             IF !fAcessoContas(gc_4c_UsuarioLogado, ;
2218:                               THIS.this_oBusinessObject.this_cGrPadFors, ;
2219:                               "C", THIS.txt_4c_Conta.Value, ;
2220:                               THIS.txt_4c_Conta, THIS.txt_4c_DConta)
2221:                 MsgAviso("Acesso Negado !!!", "")
2222:                 THIS.txt_4c_Conta.Value  = ""
2223:                 THIS.txt_4c_DConta.Value = ""
2224:             ENDIF
2225:         ELSE
2226:             THIS.txt_4c_DConta.Value = ""
2227:         ENDIF
2228:     ENDPROC
2229: 
2230:     PROCEDURE AbrirBuscaDConta()
2231:         fAcessoContas(gc_4c_UsuarioLogado, ;
2232:                       THIS.this_oBusinessObject.this_cGrPadFors, ;
2233:                       "D", THIS.txt_4c_DConta.Value, ;
2234:                       THIS.txt_4c_Conta, THIS.txt_4c_DConta)
2235:     ENDPROC
2236: 
2237:     PROCEDURE TeclaLookupDConta(par_nKeyCode, par_nShiftAltCtrl)
2238:         IF INLIST(par_nKeyCode, 115, 116)
2239:             THIS.AbrirBuscaDConta()
2240:         ELSE
2241:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2242:             THIS.ValidarDConta()
2243:             ENDIF
2244:         ENDIF
2245:     ENDPROC
2246: 
2247:     PROCEDURE ValidarDConta()
2248:         IF !EMPTY(ALLTRIM(NVL(THIS.txt_4c_DConta.Value, "")))
2249:             IF !fAcessoContas(gc_4c_UsuarioLogado, ;
2250:                               THIS.this_oBusinessObject.this_cGrPadFors, ;
2251:                               "D", THIS.txt_4c_DConta.Value, ;
2252:                               THIS.txt_4c_Conta, THIS.txt_4c_DConta)
2253:                 MsgAviso("Acesso Negado !!!", "")
2254:                 THIS.txt_4c_DConta.Value = ""
2255:                 THIS.txt_4c_Conta.Value  = ""
2256:             ENDIF
2257:         ELSE
2258:             THIS.txt_4c_Conta.Value = ""
2259:         ENDIF
2260:     ENDPROC
2261: 
2262:     *==========================================================================
2263:     * Lookups - SigPrPmc (Promo)
2264:     *==========================================================================
2265:     PROCEDURE AbrirBuscaPromo()
2266:         LOCAL loc_cValor, loc_oForm
2267:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Promo.Value, ""))
2268:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2269:             "SigPrPmc", "cursor_4c_BuscaPmc", "Promos", loc_cValor, ;
2270:             "Promo" + CHR(231) + CHR(227) + "o")
2271:         IF ISNULL(loc_oForm)
2272:             RETURN
2273:         ENDIF
2274:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
2275:             THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPmc.Promos)
2276:         ELSE
2277:             IF !loc_oForm.this_lAchouRegistro
2278:             loc_oForm.mAddColuna("Promos", "", "Promo" + CHR(231) + CHR(227) + "o")
2279:             loc_oForm.Show()
2280:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaPmc")
2281:                 THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPmc.Promos)
2282:             ENDIF
2283:             ENDIF
2284:         ENDIF
2285:         IF USED("cursor_4c_BuscaPmc")
2286:             USE IN cursor_4c_BuscaPmc
2287:         ENDIF
2288:         loc_oForm.Release()
2289:     ENDPROC
2290: 
2291:     PROCEDURE TeclaLookupPromo(par_nKeyCode, par_nShiftAltCtrl)
2292:         IF INLIST(par_nKeyCode, 115, 116)
2293:             THIS.AbrirBuscaPromo()
2294:         ELSE
2295:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2296:             THIS.ValidarPromo()
2297:             ENDIF
2298:         ENDIF
2299:     ENDPROC
2300: 
2301:     PROCEDURE ValidarPromo()
2302:         LOCAL loc_cVal, loc_nR
2303:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Promo.Value, "")))
2304:         IF EMPTY(loc_cVal)
2305:             RETURN
2306:         ENDIF
2307:         loc_nR = SQLEXEC(gnConnHandle, ;
2308:             "SELECT Promos FROM SigPrPmc WHERE Promos = " + EscaparSQL(loc_cVal), ;
2309:             "cursor_4c_ValPmc")
2310:         IF loc_nR > 0 AND !EOF("cursor_4c_ValPmc")
2311:             THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_ValPmc.Promos)
2312:         ELSE
2313:             MsgAviso("Promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "")
2314:             THIS.txt_4c_Promo.Value = ""
2315:             THIS.AbrirBuscaPromo()
2316:         ENDIF
2317:         IF USED("cursor_4c_ValPmc")
2318:             USE IN cursor_4c_ValPmc
2319:         ENDIF
2320:     ENDPROC
2321: 
2322:     *==========================================================================
2323:     * BtnIncluirClick - Inicia novo ciclo: limpa grid e parametros (equivale a
2324:     *   "nova busca" no contexto operacional de reajuste de precificacao)
2325:     *==========================================================================
2326:     PROCEDURE BtnIncluirClick()
2327:         LOCAL loc_oErro
2328:         TRY
2329:             THIS.AlternarPagina(1)
2330:             IF VARTYPE(THIS.txt_4c_CdGrupo) = "O"
2331:                 THIS.txt_4c_CdGrupo.SetFocus
2332:             ENDIF
2333:         CATCH TO loc_oErro
2334:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
2335:         ENDTRY
2336:     ENDPROC
2337: 
2338:     *==========================================================================
2339:     * BtnAlterarClick - Reprocessa com os parametros atuais sem limpar filtros
2340:     *   (equivale a "recalcular" preservando selecao atual do grid)
2341:     *==========================================================================
2342:     PROCEDURE BtnAlterarClick()
2343:         LOCAL loc_oBO, loc_oErro
2344:         TRY
2345:             loc_oBO = THIS.this_oBusinessObject
2346:             IF VARTYPE(loc_oBO) # "O"
2347:                 RETURN
2348:             ENDIF
2349:             *-- Transfere campos do form para o BO (mesmo fluxo de Processar)
2350:             loc_oBO.this_nTipo      = THIS.opt_4c_Tipo.Value
2351:             loc_oBO.this_cCdGrupo   = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value,  ""))
2352:             loc_oBO.this_cAteGrupo  = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
2353:             loc_oBO.this_cCol       = ALLTRIM(NVL(THIS.txt_4c_Col.Value,       ""))
2354:             loc_oBO.this_cConta     = ALLTRIM(NVL(THIS.txt_4c_Conta.Value,     ""))
2355:             loc_oBO.this_cDConta    = ALLTRIM(NVL(THIS.txt_4c_DConta.Value,    ""))
2356:             loc_oBO.this_nIgnorar   = THIS.chk_4c_Ignorar.Value
2357:             loc_oBO.this_nVariacao  = NVL(THIS.txt_4c_Variacao.Value, 0)
2358:             loc_oBO.this_nIncCusts  = THIS.chk_4c_IncCusts.Value
2359:             loc_oBO.this_cMoeda     = ALLTRIM(NVL(THIS.txt_4c_Moeda.Value,    ""))
2360:             loc_oBO.this_nMarkUp1   = NVL(THIS.txt_4c_MarkUp1.Value,  0)
2361:             loc_oBO.this_nMarkUp2   = NVL(THIS.txt_4c_MarkUp2.Value,  0)
2362:             loc_oBO.this_nFator     = NVL(THIS.txt_4c_Fator.Value,    0)
2363:             loc_oBO.this_cMoeCusto  = ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, ""))
2364:             loc_oBO.this_cMoecs     = ALLTRIM(NVL(THIS.txt_4c_Moecs.Value,    ""))
2365:             loc_oBO.this_cMoeCusFs  = ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, ""))
2366:             loc_oBO.this_cMoedas    = ALLTRIM(NVL(THIS.txt_4c_Moedas.Value,   ""))
2367:             loc_oBO.this_cCFtios    = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value,   ""))
2368:             loc_oBO.this_cMoeVs     = ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value,    ""))
2369:             loc_oBO.this_cPromo     = ALLTRIM(NVL(THIS.txt_4c_Promo.Value,    ""))
2370:             loc_oBO.this_nLimpar    = THIS.chk_4c_Limpar.Value
2371:             loc_oBO.this_nAuditado  = THIS.chk_4c_Auditado.Value
2372:             IF loc_oBO.ProcessarReajuste()
2373:                 THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
2374:                 THIS.grd_4c_Produtos.Column1.SetFocus
2375:                 THIS.grd_4c_Produtos.Refresh
2376:             ENDIF
2377:         CATCH TO loc_oErro
2378:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
2379:         ENDTRY
2380:     ENDPROC
2381: 
2382:     *==========================================================================
2383:     * BtnVisualizarClick - Exibe o estado atual do grid (precos antes x depois)
2384:     *   Atualiza o grid a partir do cursor sem reprocessar
2385:     *==========================================================================
2386:     PROCEDURE BtnVisualizarClick()
2387:         LOCAL loc_oErro
2388:         TRY
2389:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
2390:                 SELECT cursor_4c_Produtos
2391:                 GO TOP
2392:                 THIS.grd_4c_Produtos.Refresh
2393:                 THIS.Refresh
2394:             ELSE
2395:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " produtos processados " + ;
2396:                          "para visualizar. Execute o Processar primeiro.", "Aviso")
2397:             ENDIF
2398:         CATCH TO loc_oErro
2399:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
2400:         ENDTRY
2401:     ENDPROC
2402: 
2403:     *==========================================================================
2404:     * BtnExcluirClick - Limpa apenas o grid de produtos sem resetar os filtros
2405:     *   Permite reprocessar com os mesmos parametros mas lista limpa
2406:     *==========================================================================
2407:     PROCEDURE BtnExcluirClick()
2408:         LOCAL loc_lConfirma, loc_oErro
2409:         TRY
2410:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
2411:                 RETURN
2412:             ENDIF
2413:             loc_lConfirma = MsgConfirma("Limpar a lista de produtos processados?", ;
2414:                                         "Confirmar")
2415:             IF loc_lConfirma
2416:                 THIS.AlternarPagina(2)
2417:             ENDIF
2418:         CATCH TO loc_oErro
2419:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
2420:         ENDTRY
2421:     ENDPROC
2422: 
2423:     *==========================================================================
2424:     * AbrirBuscaProdutoGrd - Lookup de produto para modo auditado (Column2)
2425:     * Equivalente ao fwbuscaext do Column2.Text1.Valid no legado.
2426:     *==========================================================================
2427:     PROCEDURE AbrirBuscaProdutoGrd()
2428:         LOCAL loc_cValAtual, loc_oForm, loc_cSelecionado
2429: 
2430:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
2431:             RETURN
2432:         ENDIF
2433:         SELECT cursor_4c_Produtos
2434:         loc_cValAtual = ALLTRIM(NVL(cursor_4c_Produtos.CPros, ""))
2435: 
2436:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2437:             "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValAtual, ;
2438:             "Produtos")
2439:         IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2440:             RETURN
2441:         ENDIF
2442: 
2443:         IF !loc_oForm.this_lAchouRegistro
2444:             loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2445:             loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2446:             loc_oForm.Show()
2447:         ENDIF
2448: 
2449:         loc_cSelecionado = ""
2450:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaPro")
2451:             loc_cSelecionado = ALLTRIM(cursor_4c_BuscaPro.CPros)
2452:         ENDIF
2453:         IF USED("cursor_4c_BuscaPro")
2454:             USE IN cursor_4c_BuscaPro
2455:         ENDIF
2456: 
2457:         IF !EMPTY(loc_cSelecionado)
2458:             SELECT cursor_4c_Produtos
2459:             REPLACE CPros WITH loc_cSelecionado
2460:             THIS.grd_4c_Produtos.Refresh
2461:             THIS.CarregarProdutoAuditado(loc_cSelecionado)
2462:         ELSE
2463:             SELECT cursor_4c_Produtos
2464:             IF !EOF("cursor_4c_Produtos")
2465:                 REPLACE CPros WITH SPACE(14)
2466:             ENDIF
2467:             THIS.grd_4c_Produtos.Refresh
2468:         ENDIF
2469:         loc_oForm.Release()
2470:     ENDPROC
2471: 
2472:     *==========================================================================
2473:     * FormParaBO - Transfere todos os campos do form para propriedades do BO
2474:     * Usado por BtnProcessarClick e BtnAlterarClick para evitar duplicacao
2475:     *==========================================================================
2476:     PROCEDURE FormParaBO()
2477:         LOCAL loc_oBO
2478:         loc_oBO = THIS.this_oBusinessObject
2479:         IF VARTYPE(loc_oBO) # "O"
2480:             RETURN
2481:         ENDIF
2482:         loc_oBO.this_nTipo     = THIS.opt_4c_Tipo.Value
2483:         loc_oBO.this_cCdGrupo  = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value,  ""))
2484:         loc_oBO.this_cAteGrupo = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
2485:         loc_oBO.this_cCol      = ALLTRIM(NVL(THIS.txt_4c_Col.Value,       ""))
2486:         loc_oBO.this_cConta    = ALLTRIM(NVL(THIS.txt_4c_Conta.Value,     ""))
2487:         loc_oBO.this_cDConta   = ALLTRIM(NVL(THIS.txt_4c_DConta.Value,    ""))
2488:         loc_oBO.this_nIgnorar  = THIS.chk_4c_Ignorar.Value
2489:         loc_oBO.this_nVariacao = NVL(THIS.txt_4c_Variacao.Value, 0)
2490:         loc_oBO.this_nIncCusts = THIS.chk_4c_IncCusts.Value
2491:         loc_oBO.this_cMoeda    = ALLTRIM(NVL(THIS.txt_4c_Moeda.Value,    ""))
2492:         loc_oBO.this_nMarkUp1  = NVL(THIS.txt_4c_MarkUp1.Value,  0)
2493:         loc_oBO.this_nMarkUp2  = NVL(THIS.txt_4c_MarkUp2.Value,  0)
2494:         loc_oBO.this_nFator    = NVL(THIS.txt_4c_Fator.Value,    0)
2495:         loc_oBO.this_cMoeCusto = ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, ""))
2496:         loc_oBO.this_cMoecs    = ALLTRIM(NVL(THIS.txt_4c_Moecs.Value,    ""))
2497:         loc_oBO.this_cMoeCusFs = ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, ""))
2498:         loc_oBO.this_cMoedas   = ALLTRIM(NVL(THIS.txt_4c_Moedas.Value,   ""))
2499:         loc_oBO.this_cCFtios   = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value,   ""))
2500:         loc_oBO.this_cMoeVs    = ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value,    ""))
2501:         loc_oBO.this_cPromo    = ALLTRIM(NVL(THIS.txt_4c_Promo.Value,    ""))
2502:         loc_oBO.this_nLimpar   = THIS.chk_4c_Limpar.Value
2503:         loc_oBO.this_nAuditado = THIS.chk_4c_Auditado.Value
2504:     ENDPROC
2505: 
2506:     *==========================================================================
2507:     * BOParaForm - Carrega propriedades do BO de volta para os campos do form
2508:     * Util apos recarregar estado do BO ou em modo auditado
2509:     *==========================================================================
2510:     PROCEDURE BOParaForm()
2511:         LOCAL loc_oBO
2512:         loc_oBO = THIS.this_oBusinessObject
2513:         IF VARTYPE(loc_oBO) # "O"
2514:             RETURN
2515:         ENDIF
2516:         IF VARTYPE(THIS.opt_4c_Tipo)     = "O"
2517:             THIS.opt_4c_Tipo.Value     = loc_oBO.this_nTipo
2518:             THIS.AtualizarVisibilidade(loc_oBO.this_nTipo)
2519:         ENDIF
2520:         IF VARTYPE(THIS.txt_4c_CdGrupo)  = "O"
2521:             THIS.txt_4c_CdGrupo.Value  = ALLTRIM(loc_oBO.this_cCdGrupo)
2522:         ENDIF
2523:         IF VARTYPE(THIS.txt_4c_AteGrupo) = "O"
2524:             THIS.txt_4c_AteGrupo.Value = ALLTRIM(loc_oBO.this_cAteGrupo)
2525:         ENDIF
2526:         IF VARTYPE(THIS.txt_4c_Col)      = "O"
2527:             THIS.txt_4c_Col.Value      = ALLTRIM(loc_oBO.this_cCol)
2528:         ENDIF
2529:         IF VARTYPE(THIS.txt_4c_Conta)    = "O"
2530:             THIS.txt_4c_Conta.Value    = ALLTRIM(loc_oBO.this_cConta)
2531:         ENDIF
2532:         IF VARTYPE(THIS.txt_4c_DConta)   = "O"
2533:             THIS.txt_4c_DConta.Value   = ALLTRIM(loc_oBO.this_cDConta)
2534:         ENDIF
2535:         IF VARTYPE(THIS.chk_4c_Ignorar)  = "O"
2536:             THIS.chk_4c_Ignorar.Value  = loc_oBO.this_nIgnorar
2537:         ENDIF
2538:         IF VARTYPE(THIS.txt_4c_Variacao) = "O"
2539:             THIS.txt_4c_Variacao.Value = loc_oBO.this_nVariacao
2540:         ENDIF
2541:         IF VARTYPE(THIS.chk_4c_IncCusts) = "O"
2542:             THIS.chk_4c_IncCusts.Value = loc_oBO.this_nIncCusts
2543:         ENDIF
2544:         IF VARTYPE(THIS.txt_4c_Moeda)    = "O"
2545:             THIS.txt_4c_Moeda.Value    = ALLTRIM(loc_oBO.this_cMoeda)
2546:         ENDIF
2547:         IF VARTYPE(THIS.txt_4c_MarkUp1)  = "O"
2548:             THIS.txt_4c_MarkUp1.Value  = loc_oBO.this_nMarkUp1
2549:         ENDIF
2550:         IF VARTYPE(THIS.txt_4c_MarkUp2)  = "O"

*-- Linhas 2587 a 2638:
2587:     * LimparCampos - Limpa todos os campos de entrada e o grid de produtos
2588:     * Equivalente a resetar o form para o estado inicial (nova consulta)
2589:     *==========================================================================
2590:     PROCEDURE LimparCampos()
2591:         THIS.AlternarPagina(1)
2592:     ENDPROC
2593: 
2594:     *==========================================================================
2595:     * HabilitarCampos - Habilita ou desabilita todos os campos de entrada
2596:     * par_lHabilitar = .T. -> habilitar | .F. -> desabilitar
2597:     *==========================================================================
2598:     PROCEDURE HabilitarCampos(par_lHabilitar)
2599:         LOCAL loc_lHab
2600:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2601: 
2602:         IF VARTYPE(THIS.txt_4c_CdGrupo)  = "O"
2603:             THIS.txt_4c_CdGrupo.Enabled  = loc_lHab
2604:         ENDIF
2605:         IF VARTYPE(THIS.txt_4c_AteGrupo) = "O"
2606:             THIS.txt_4c_AteGrupo.Enabled = loc_lHab
2607:         ENDIF
2608:         IF VARTYPE(THIS.txt_4c_Col)      = "O"
2609:             THIS.txt_4c_Col.Enabled      = loc_lHab
2610:         ENDIF
2611:         IF VARTYPE(THIS.txt_4c_Conta)    = "O"
2612:             THIS.txt_4c_Conta.Enabled    = loc_lHab
2613:         ENDIF
2614:         IF VARTYPE(THIS.txt_4c_DConta)   = "O"
2615:             THIS.txt_4c_DConta.Enabled   = loc_lHab
2616:         ENDIF
2617:         IF VARTYPE(THIS.txt_4c_Variacao) = "O"
2618:             THIS.txt_4c_Variacao.Enabled = loc_lHab
2619:         ENDIF
2620:         IF VARTYPE(THIS.txt_4c_Moeda)    = "O"
2621:             THIS.txt_4c_Moeda.Enabled    = loc_lHab
2622:         ENDIF
2623:         IF VARTYPE(THIS.txt_4c_MarkUp1)  = "O"
2624:             THIS.txt_4c_MarkUp1.Enabled  = loc_lHab
2625:         ENDIF
2626:         IF VARTYPE(THIS.txt_4c_MarkUp2)  = "O"
2627:             THIS.txt_4c_MarkUp2.Enabled  = loc_lHab
2628:         ENDIF
2629:         IF VARTYPE(THIS.txt_4c_Fator)    = "O"
2630:             THIS.txt_4c_Fator.Enabled    = loc_lHab
2631:         ENDIF
2632:         IF VARTYPE(THIS.txt_4c_MoeCusto) = "O"
2633:             THIS.txt_4c_MoeCusto.Enabled = loc_lHab
2634:         ENDIF
2635:         IF VARTYPE(THIS.txt_4c_Promo)    = "O"
2636:             THIS.txt_4c_Promo.Enabled    = loc_lHab
2637:         ENDIF
2638:         IF VARTYPE(THIS.opt_4c_Tipo)     = "O"

*-- Linhas 2649 a 2728:
2649:     * executar ProcessarReajuste() via BtnProcessarClick.
2650:     * Exibe o estado atual do cursor sem reprocessar.
2651:     *==========================================================================
2652:     PROCEDURE CarregarLista()
2653:         IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
2654:             SELECT cursor_4c_Produtos
2655:             GO TOP
2656:             IF VARTYPE(THIS.grd_4c_Produtos) = "O"
2657:                 THIS.grd_4c_Produtos.Refresh
2658:             ENDIF
2659:         ENDIF
2660:     ENDPROC
2661: 
2662:     *==========================================================================
2663:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo corrente
2664:     * Para o form OPERACIONAL: habilita Processar, desabilita Atualizar
2665:     * apos reset; habilita Atualizar apos Processar com sucesso.
2666:     * par_cModo = "NORMAL"  -> estado inicial (Processar habilitado)
2667:     *           = "PRONTO"  -> apos Processar (Atualizar habilitado)
2668:     *           = "AUDITADO"-> modo entrada manual (Processar desabilitado)
2669:     *==========================================================================
2670:     PROCEDURE AjustarBotoesPorModo(par_cModo)
2671:         LOCAL loc_cModo
2672:         loc_cModo = UPPER(ALLTRIM(NVL(par_cModo, "NORMAL")))
2673: 
2674:         IF VARTYPE(THIS.cmg_4c_Acao) # "O"
2675:             RETURN
2676:         ENDIF
2677: 
2678:         DO CASE
2679:         CASE loc_cModo = "PRONTO"
2680:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
2681:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
2682: 
2683:         CASE loc_cModo = "AUDITADO"
2684:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .F.
2685:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
2686: 
2687:         OTHERWISE
2688:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
2689:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .F.
2690:         ENDCASE
2691: 
2692:         THIS.cmg_4c_Acao.Buttons(1).Refresh
2693:         THIS.cmg_4c_Acao.Buttons(2).Refresh
2694:     ENDPROC
2695: 
2696:     *==========================================================================
2697:     * BtnBuscarClick - Alias semantico para BtnProcessarClick
2698:     * Aciona o processamento de selecao e calculo de precos
2699:     *==========================================================================
2700:     PROCEDURE BtnBuscarClick()
2701:         THIS.BtnProcessarClick()
2702:     ENDPROC
2703: 
2704:     *==========================================================================
2705:     * BtnSalvarClick - Alias semantico para BtnAtualizarClick
2706:     * Confirma e grava os precos calculados no banco de dados
2707:     *==========================================================================
2708:     PROCEDURE BtnSalvarClick()
2709:         THIS.BtnAtualizarClick()
2710:     ENDPROC
2711: 
2712:     *==========================================================================
2713:     * BtnCancelarClick - Cancela o processamento atual sem gravar
2714:     * Zera o grid mas mantem os parametros de filtro para reprocessar
2715:     *==========================================================================
2716:     PROCEDURE BtnCancelarClick()
2717:         LOCAL loc_oErro
2718:         TRY
2719:             THIS.AlternarPagina(2)
2720:             IF VARTYPE(THIS.txt_4c_CdGrupo) = "O"
2721:                 THIS.txt_4c_CdGrupo.SetFocus
2722:             ENDIF
2723:         CATCH TO loc_oErro
2724:             MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
2725:         ENDTRY
2726:     ENDPROC
2727: 
2728: ENDDEFINE

