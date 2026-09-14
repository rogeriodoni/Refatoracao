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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrApr.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2727 linhas total):

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
976:             .FontName      = "Comic Sans MS"
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

*-- Linhas 1264 a 1470:
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
1280:                 *-- img_4c_Foto comeca oculta; e' controlada por GrdAfterRowColChange
1281:                 IF UPPER(loc_oObjeto.Name) = "IMG_4C_FOTO"
1282:                     LOOP
1283:                 ENDIF
1284:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1285:                     loc_oObjeto.Visible = .T.
1286:                 ENDIF
1287:             ENDIF
1288:         ENDFOR
1289:     ENDPROC
1290: 
1291:     *==========================================================================
1292:     * AtualizarVisibilidade - Mostra/oculta controles pelo tipo de reajuste
1293:     *==========================================================================
1294:     PROCEDURE AtualizarVisibilidade(par_nTipo)
1295:         LOCAL loc_lTipo1, loc_lTipo2
1296: 
1297:         loc_lTipo1 = (par_nTipo = 1)
1298:         loc_lTipo2 = (par_nTipo = 2)
1299: 
1300:         *-- Tipo 1: Variacao
1301:         THIS.lbl_4c_Variacao.Visible = loc_lTipo1
1302:         THIS.txt_4c_Variacao.Visible = loc_lTipo1
1303:         THIS.lbl_4c_Pct.Visible      = loc_lTipo1
1304:         THIS.chk_4c_IncCusts.Visible = loc_lTipo1
1305: 
1306:         *-- Tipo 2: MarkUp
1307:         THIS.lbl_4c_Moeda.Visible    = loc_lTipo2
1308:         THIS.txt_4c_Moeda.Visible    = loc_lTipo2
1309:         THIS.lbl_4c_MarkUp.Visible   = loc_lTipo2
1310:         THIS.txt_4c_MarkUp1.Visible  = loc_lTipo2
1311:         THIS.lbl_4c_Para.Visible     = loc_lTipo2
1312:         THIS.txt_4c_MarkUp2.Visible  = loc_lTipo2
1313:         THIS.lbl_4c_Fator.Visible    = loc_lTipo2
1314:         THIS.txt_4c_Fator.Visible    = loc_lTipo2
1315:         THIS.txt_4c_MoeCusto.Visible = loc_lTipo2
1316:         THIS.lbl_4c_Moecs.Visible    = loc_lTipo2
1317:         THIS.txt_4c_Moecs.Visible    = loc_lTipo2
1318:         THIS.lbl_4c_MoeCusFs.Visible = loc_lTipo2
1319:         THIS.txt_4c_MoeCusFs.Visible = loc_lTipo2
1320:         THIS.lbl_4c_Moedas.Visible   = loc_lTipo2
1321:         THIS.txt_4c_Moedas.Visible   = loc_lTipo2
1322:         THIS.lbl_4c_CFtios.Visible   = loc_lTipo2
1323:         THIS.txt_4c_CFtios.Visible   = loc_lTipo2
1324:         THIS.lbl_4c_MoeVs.Visible    = loc_lTipo2
1325:         THIS.txt_4c_MoeVs.Visible    = loc_lTipo2
1326: 
1327:         THIS.Refresh
1328:     ENDPROC
1329: 
1330:     *==========================================================================
1331:     * OptTipoInteractiveChange - Atualiza visibilidade ao mudar tipo
1332:     *==========================================================================
1333:     PROCEDURE OptTipoInteractiveChange()
1334:         THIS.AtualizarVisibilidade(THIS.opt_4c_Tipo.Value)
1335:     ENDPROC
1336: 
1337:     *==========================================================================
1338:     * BtnProcessarClick - Coleta campos, chama ProcessarReajuste()
1339:     *==========================================================================
1340:     PROCEDURE BtnProcessarClick()
1341:         LOCAL loc_oBO
1342: 
1343:         loc_oBO = THIS.this_oBusinessObject
1344:         IF VARTYPE(loc_oBO) # "O"
1345:             RETURN
1346:         ENDIF
1347: 
1348:         *-- Transfere campos do form para o BO
1349:         loc_oBO.this_nTipo      = THIS.opt_4c_Tipo.Value
1350:         loc_oBO.this_cCdGrupo   = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value,  ""))
1351:         loc_oBO.this_cAteGrupo  = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
1352:         loc_oBO.this_cCol       = ALLTRIM(NVL(THIS.txt_4c_Col.Value,       ""))
1353:         loc_oBO.this_cConta     = ALLTRIM(NVL(THIS.txt_4c_Conta.Value,     ""))
1354:         loc_oBO.this_cDConta    = ALLTRIM(NVL(THIS.txt_4c_DConta.Value,    ""))
1355:         loc_oBO.this_nIgnorar   = THIS.chk_4c_Ignorar.Value
1356:         loc_oBO.this_nVariacao  = NVL(THIS.txt_4c_Variacao.Value, 0)
1357:         loc_oBO.this_nIncCusts  = THIS.chk_4c_IncCusts.Value
1358:         loc_oBO.this_cMoeda     = ALLTRIM(NVL(THIS.txt_4c_Moeda.Value,    ""))
1359:         loc_oBO.this_nMarkUp1   = NVL(THIS.txt_4c_MarkUp1.Value,  0)
1360:         loc_oBO.this_nMarkUp2   = NVL(THIS.txt_4c_MarkUp2.Value,  0)
1361:         loc_oBO.this_nFator     = NVL(THIS.txt_4c_Fator.Value,    0)
1362:         loc_oBO.this_cMoeCusto  = ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, ""))
1363:         loc_oBO.this_cMoecs     = ALLTRIM(NVL(THIS.txt_4c_Moecs.Value,    ""))
1364:         loc_oBO.this_cMoeCusFs  = ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, ""))
1365:         loc_oBO.this_cMoedas    = ALLTRIM(NVL(THIS.txt_4c_Moedas.Value,   ""))
1366:         loc_oBO.this_cCFtios    = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value,   ""))
1367:         loc_oBO.this_cMoeVs     = ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value,    ""))
1368:         loc_oBO.this_cPromo     = ALLTRIM(NVL(THIS.txt_4c_Promo.Value,    ""))
1369:         loc_oBO.this_nLimpar    = THIS.chk_4c_Limpar.Value
1370:         loc_oBO.this_nAuditado  = THIS.chk_4c_Auditado.Value
1371: 
1372:         IF loc_oBO.ProcessarReajuste()
1373:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
1374:             THIS.grd_4c_Produtos.Column1.SetFocus
1375:             THIS.grd_4c_Produtos.Refresh
1376:         ENDIF
1377:     ENDPROC
1378: 
1379:     *==========================================================================
1380:     * BtnAtualizarClick - Chama AtualizarPrecos(), desabilita Atualizar
1381:     *==========================================================================
1382:     PROCEDURE BtnAtualizarClick()
1383:         LOCAL loc_oBO
1384:         loc_oBO = THIS.this_oBusinessObject
1385:         IF VARTYPE(loc_oBO) # "O"
1386:             RETURN
1387:         ENDIF
1388:         IF loc_oBO.AtualizarPrecos()
1389:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .F.
1390:             THIS.cmg_4c_Acao.Buttons(2).Refresh
1391:         ENDIF
1392:     ENDPROC
1393: 
1394:     *==========================================================================
1395:     * BtnEncerrarClick - Fecha o form
1396:     *==========================================================================
1397:     PROCEDURE BtnEncerrarClick()
1398:         THIS.Release
1399:     ENDPROC
1400: 
1401:     *==========================================================================
1402:     * TxtVariacaoLostFocus - Move foco para Processar ao sair do campo
1403:     *==========================================================================
1404:     PROCEDURE TxtVariacaoLostFocus(par_nKeyCode, par_nShiftAltCtrl)
1405:         THIS.cmg_4c_Acao.Buttons(1).SetFocus
1406:     ENDPROC
1407: 
1408:     *==========================================================================
1409:     * GrdHeaderClick - Alterna selecao de todos os produtos (lMarca)
1410:     *==========================================================================
1411:     PROCEDURE GrdHeaderClick()
1412:         IF !USED("cursor_4c_Produtos")
1413:             RETURN
1414:         ENDIF
1415:         IF THIS.this_lAllSelected
1416:             UPDATE cursor_4c_Produtos SET lMarca = 0
1417:             THIS.this_lAllSelected = .F.
1418:         ELSE
1419:             UPDATE cursor_4c_Produtos SET lMarca = 1
1420:             THIS.this_lAllSelected = .T.
1421:         ENDIF
1422:         THIS.grd_4c_Produtos.Refresh
1423:         THIS.Refresh
1424:     ENDPROC
1425: 
1426:     *==========================================================================
1427:     * GrdAfterRowColChange - Manual tracking + auditor lookup + foto produto
1428:     * par_nColIndex = coluna que acabou de ser ENTADA (nova coluna ativa)
1429:     *==========================================================================
1430:     PROCEDURE GrdAfterRowColChange(par_nColIndex)
1431:         LOCAL loc_lcArqFig, loc_nResult, loc_lcFoto, loc_cCPros
1432: 
1433:         IF !USED("cursor_4c_Produtos")
1434:             RETURN
1435:         ENDIF
1436:         SELECT cursor_4c_Produtos
1437: 
1438:         *-- Rastreia edicao manual de ValAtu (Column5): detecta saida da coluna
1439:         IF par_nColIndex != 5 AND THIS.this_lInCol5
1440:             IF !EOF("cursor_4c_Produtos") AND ;
1441:                NVL(cursor_4c_Produtos.ValAtu, 0) != THIS.this_nAntValAtu
1442:                 REPLACE Manual WITH 1 IN cursor_4c_Produtos
1443:                 *-- Em modo LibValAtu: adiciona linha vazia no fundo se ultimo item tem produto
1444:                 *-- Equivale ao Column5.Text1.Valid do legado (Insert From MemVar + DNARROW)
1445:                 IF THIS.this_oBusinessObject.this_lLibValAtu
1446:                     SET ORDER TO
1447:                     GO BOTTOM
1448:                     IF !EMPTY(ALLTRIM(NVL(cursor_4c_Produtos.CPros, "")))
1449:                         INSERT INTO cursor_4c_Produtos ;
1450:                             (lMarca, CPros, DPros, ValAtu, ValAnt, fCustos, MoePcs, CustoFs, Manual) ;
1451:                             VALUES (0, SPACE(14), SPACE(40), 0, 0, 0, SPACE(3), 0, 0)
1452:                     ENDIF
1453:                     THIS.grd_4c_Produtos.Refresh
1454:                 ENDIF
1455:             ENDIF
1456:             THIS.this_lInCol5 = .F.
1457:         ENDIF
1458:         IF par_nColIndex = 5 AND !EOF("cursor_4c_Produtos")
1459:             THIS.this_nAntValAtu = NVL(cursor_4c_Produtos.ValAtu, 0)
1460:             THIS.this_lInCol5    = .T.
1461:         ENDIF
1462: 
1463:         *-- Modo auditado: ao sair de Column2 com codigo preenchido, carrega produto
1464:         IF par_nColIndex != 2 AND THIS.chk_4c_Auditado.Value = 1 ;
1465:             AND !EOF("cursor_4c_Produtos")
1466:             loc_cCPros = ALLTRIM(NVL(cursor_4c_Produtos.CPros, ""))
1467:             IF !EMPTY(loc_cCPros)
1468:                 THIS.CarregarProdutoAuditado(loc_cCPros)
1469:             ENDIF
1470:         ENDIF

*-- Linhas 1512 a 1555:
1512:     * CarregarProdutoAuditado - Modo auditado: busca produto e calcula preco
1513:     * Chamado por GrdAfterRowColChange ao sair de Column2 com um codigo
1514:     *==========================================================================
1515:     PROCEDURE CarregarProdutoAuditado(par_cCPros)
1516:         LOCAL loc_nResult, loc_nTipo, loc_nVariacao, loc_nMarkUp2
1517:         LOCAL loc_nValAtu, loc_nCotId, loc_nCotVd, loc_nPVen, loc_nVlVen
1518: 
1519:         IF EMPTY(ALLTRIM(par_cCPros))
1520:             RETURN
1521:         ENDIF
1522: 
1523:         *-- Busca produto em SigCdPro e adiciona a cursor_4c_TmpPro
1524:         IF USED("cursor_4c_ProdAud")
1525:             USE IN cursor_4c_ProdAud
1526:         ENDIF
1527:         loc_nResult = SQLEXEC(gnConnHandle, ;
1528:             "SELECT * FROM SigCdPro WHERE CPros = " + EscaparSQL(ALLTRIM(par_cCPros)), ;
1529:             "cursor_4c_ProdAud")
1530:         IF loc_nResult < 1 OR EOF("cursor_4c_ProdAud")
1531:             IF USED("cursor_4c_ProdAud")
1532:                 USE IN cursor_4c_ProdAud
1533:             ENDIF
1534:             THIS.AbrirBuscaProdutoGrd()
1535:             RETURN
1536:         ENDIF
1537: 
1538:         *-- Insere no cursor_4c_TmpPro se ainda nao existe
1539:         IF USED("cursor_4c_TmpPro")
1540:             IF !SEEK(ALLTRIM(par_cCPros), "cursor_4c_TmpPro", "CPros")
1541:                 SELECT cursor_4c_ProdAud
1542:                 GO TOP
1543:                 LOCAL loc_oErroIns
1544:                 TRY
1545:                     SELECT cursor_4c_TmpPro
1546:                     APPEND BLANK
1547:                     *-- Copia campos essenciais manualmente (SCATTER/GATHER pode falhar entre cursores)
1548:                     REPLACE CPros    WITH ALLTRIM(cursor_4c_ProdAud.CPros)
1549:                     REPLACE DPros    WITH ALLTRIM(NVL(cursor_4c_ProdAud.DPros,    ""))
1550:                     REPLACE PVens    WITH NVL(cursor_4c_ProdAud.PVens,    0)
1551:                     REPLACE PVIdeals WITH NVL(cursor_4c_ProdAud.PVIdeals, 0)
1552:                     REPLACE PCuss    WITH NVL(cursor_4c_ProdAud.PCuss,    0)
1553:                     REPLACE CustoFs  WITH NVL(cursor_4c_ProdAud.CustoFs,  0)
1554:                     REPLACE fCustos  WITH NVL(cursor_4c_ProdAud.fCustos,  0)
1555:                     REPLACE Margems  WITH NVL(cursor_4c_ProdAud.Margems,  0)

*-- Linhas 1633 a 1676:
1633:     *==========================================================================
1634:     * ChkAuditadoClick - Alterna modo de entrada manual de produtos
1635:     *==========================================================================
1636:     PROCEDURE ChkAuditadoClick()
1637:         IF THIS.chk_4c_Auditado.Value = 1
1638:             *-- Modo auditado: limpa grid, Column2 editavel, Column1 readonly
1639:             IF USED("cursor_4c_Produtos")
1640:                 LOCAL loc_lMarca_v, loc_cCPros_v, loc_cDPros_v, loc_nValAtu_v, loc_nValAnt_v
1641:                 loc_lMarca_v = 0
1642:                 loc_cCPros_v = SPACE(14)
1643:                 loc_cDPros_v = SPACE(40)
1644:                 loc_nValAtu_v = 0
1645:                 loc_nValAnt_v = 0
1646:                 INSERT INTO cursor_4c_Produtos (lMarca, CPros, DPros, ValAtu, ValAnt) ;
1647:                     VALUES (loc_lMarca_v, loc_cCPros_v, loc_cDPros_v, loc_nValAtu_v, loc_nValAnt_v)
1648:                 SELECT cursor_4c_Produtos
1649:                 SET ORDER TO
1650:                 GO TOP
1651:             ENDIF
1652:             THIS.txt_4c_CdGrupo.Enabled  = .F.
1653:             THIS.txt_4c_AteGrupo.Enabled = .F.
1654:             THIS.txt_4c_Col.Enabled      = .F.
1655:             THIS.txt_4c_Moeda.Enabled    = .F.
1656:             THIS.txt_4c_MarkUp1.Enabled  = .F.
1657:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .F.
1658:             THIS.grd_4c_Produtos.Column1.ReadOnly = .T.
1659:             THIS.grd_4c_Produtos.Column2.ReadOnly = .F.
1660:             THIS.grd_4c_Produtos.Column2.SetFocus
1661:             THIS.grd_4c_Produtos.Refresh
1662:         ELSE
1663:             *-- Modo normal: limpa grid, Column2 readonly, Column1 editavel
1664:             IF USED("cursor_4c_Produtos")
1665:                 DELETE FROM cursor_4c_Produtos
1666:             ENDIF
1667:             THIS.txt_4c_CdGrupo.Enabled  = .T.
1668:             THIS.txt_4c_AteGrupo.Enabled = .T.
1669:             THIS.txt_4c_Col.Enabled      = .T.
1670:             THIS.txt_4c_Moeda.Enabled    = .T.
1671:             THIS.txt_4c_MarkUp1.Enabled  = .T.
1672:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
1673:             THIS.grd_4c_Produtos.Column1.ReadOnly = .F.
1674:             THIS.grd_4c_Produtos.Column2.ReadOnly = .T.
1675:             SELECT cursor_4c_Produtos
1676:             SET ORDER TO CPros

*-- Linhas 1685 a 2549:
1685:     *==========================================================================
1686: 
1687:     *-- Helper generico para SigCdMoe
1688:     PROTECTED PROCEDURE BuscarMoedaHelper(par_oTxt)
1689:         LOCAL loc_cValor, loc_oForm
1690:         loc_cValor = ALLTRIM(NVL(par_oTxt.Value, ""))
1691:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1692:             "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, "Moedas")
1693:         IF ISNULL(loc_oForm)
1694:             RETURN
1695:         ENDIF
1696:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1697:             par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1698:         ELSE
1699:             IF !loc_oForm.this_lAchouRegistro
1700:             loc_oForm.mAddColuna("CMoes",  "XXXXXX", "C" + CHR(243) + "digo")
1701:             loc_oForm.mAddColuna("DMoes",  "",       "Descri" + CHR(231) + CHR(227) + "o")
1702:             loc_oForm.Show()
1703:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
1704:                 par_oTxt.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
1705:             ENDIF
1706:             ENDIF
1707:         ENDIF
1708:         IF USED("cursor_4c_BuscaMoe")
1709:             USE IN cursor_4c_BuscaMoe
1710:         ENDIF
1711:         loc_oForm.Release()
1712:     ENDPROC
1713: 
1714:     *==========================================================================
1715:     * Lookups - SigCdGrp (CdGrupo)
1716:     *==========================================================================
1717:     PROCEDURE AbrirBuscaCdGrupo()
1718:         LOCAL loc_cValor, loc_oForm
1719:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value, ""))
1720:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1721:             "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cValor, ;
1722:             "Grupos de Produto")
1723:         IF ISNULL(loc_oForm)
1724:             RETURN
1725:         ENDIF
1726:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1727:             THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1728:             IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
1729:                 THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
1730:             ENDIF
1731:         ELSE
1732:             IF !loc_oForm.this_lAchouRegistro
1733:             loc_oForm.mAddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
1734:             loc_oForm.mAddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
1735:             loc_oForm.Show()
1736:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1737:                 THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1738:                 IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
1739:                     THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
1740:                 ENDIF
1741:             ENDIF
1742:             ENDIF
1743:         ENDIF
1744:         IF USED("cursor_4c_BuscaGrp")
1745:             USE IN cursor_4c_BuscaGrp
1746:         ENDIF
1747:         loc_oForm.Release()
1748:     ENDPROC
1749: 
1750:     PROCEDURE TeclaLookupCdGrupo(par_nKeyCode, par_nShiftAltCtrl)
1751:         IF INLIST(par_nKeyCode, 115, 116)
1752:             THIS.AbrirBuscaCdGrupo()
1753:         ELSE
1754:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1755:             THIS.ValidarCdGrupo()
1756:             ENDIF
1757:         ENDIF
1758:     ENDPROC
1759: 
1760:     PROCEDURE ValidarCdGrupo()
1761:         LOCAL loc_cVal, loc_nR
1762:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value, "")))
1763:         IF EMPTY(loc_cVal)
1764:             RETURN
1765:         ENDIF
1766:         loc_nR = SQLEXEC(gnConnHandle, ;
1767:             "SELECT CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cVal), ;
1768:             "cursor_4c_ValGrp")
1769:         IF loc_nR > 0 AND !EOF("cursor_4c_ValGrp")
1770:             THIS.txt_4c_CdGrupo.Value = ALLTRIM(cursor_4c_ValGrp.CGrus)
1771:             IF EMPTY(ALLTRIM(THIS.txt_4c_AteGrupo.Value))
1772:                 THIS.txt_4c_AteGrupo.Value = THIS.txt_4c_CdGrupo.Value
1773:             ENDIF
1774:         ELSE
1775:             MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "")
1776:             THIS.txt_4c_CdGrupo.Value = ""
1777:             THIS.AbrirBuscaCdGrupo()
1778:         ENDIF
1779:         IF USED("cursor_4c_ValGrp")
1780:             USE IN cursor_4c_ValGrp
1781:         ENDIF
1782:     ENDPROC
1783: 
1784:     *==========================================================================
1785:     * Lookups - SigCdGrp (AteGrupo)
1786:     *==========================================================================
1787:     PROCEDURE AbrirBuscaAteGrupo()
1788:         LOCAL loc_cValor, loc_oForm
1789:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
1790:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1791:             "SigCdGrp", "cursor_4c_BuscaGrp", "CGrus", loc_cValor, ;
1792:             "Grupos de Produto")
1793:         IF ISNULL(loc_oForm)
1794:             RETURN
1795:         ENDIF
1796:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1797:             THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1798:         ELSE
1799:             IF !loc_oForm.this_lAchouRegistro
1800:             loc_oForm.mAddColuna("CGrus", "XXXXXX", "C" + CHR(243) + "digo")
1801:             loc_oForm.mAddColuna("DGrus", "",       "Descri" + CHR(231) + CHR(227) + "o")
1802:             loc_oForm.Show()
1803:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaGrp")
1804:                 THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_BuscaGrp.CGrus)
1805:             ENDIF
1806:             ENDIF
1807:         ENDIF
1808:         IF USED("cursor_4c_BuscaGrp")
1809:             USE IN cursor_4c_BuscaGrp
1810:         ENDIF
1811:         loc_oForm.Release()
1812:     ENDPROC
1813: 
1814:     PROCEDURE TeclaLookupAteGrupo(par_nKeyCode, par_nShiftAltCtrl)
1815:         IF INLIST(par_nKeyCode, 115, 116)
1816:             THIS.AbrirBuscaAteGrupo()
1817:         ELSE
1818:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1819:             THIS.ValidarAteGrupo()
1820:             ENDIF
1821:         ENDIF
1822:     ENDPROC
1823: 
1824:     PROCEDURE ValidarAteGrupo()
1825:         LOCAL loc_cVal, loc_nR
1826:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, "")))
1827:         IF EMPTY(loc_cVal)
1828:             RETURN
1829:         ENDIF
1830:         loc_nR = SQLEXEC(gnConnHandle, ;
1831:             "SELECT CGrus FROM SigCdGrp WHERE CGrus = " + EscaparSQL(loc_cVal), ;
1832:             "cursor_4c_ValGrp")
1833:         IF loc_nR > 0 AND !EOF("cursor_4c_ValGrp")
1834:             THIS.txt_4c_AteGrupo.Value = ALLTRIM(cursor_4c_ValGrp.CGrus)
1835:         ELSE
1836:             MsgAviso("Grupo n" + CHR(227) + "o encontrado.", "")
1837:             THIS.txt_4c_AteGrupo.Value = ""
1838:             THIS.AbrirBuscaAteGrupo()
1839:         ENDIF
1840:         IF USED("cursor_4c_ValGrp")
1841:             USE IN cursor_4c_ValGrp
1842:         ENDIF
1843:     ENDPROC
1844: 
1845:     *==========================================================================
1846:     * Lookups - SigCdCol
1847:     *==========================================================================
1848:     PROCEDURE AbrirBuscaCol()
1849:         LOCAL loc_cValor, loc_oForm
1850:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Col.Value, ""))
1851:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1852:             "SigCdCol", "cursor_4c_BuscaCol", "Colecoes", loc_cValor, ;
1853:             "Cole" + CHR(231) + CHR(245) + "es")
1854:         IF ISNULL(loc_oForm)
1855:             RETURN
1856:         ENDIF
1857:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
1858:             THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1859:         ELSE
1860:             IF !loc_oForm.this_lAchouRegistro
1861:             loc_oForm.mAddColuna("Colecoes", "XXXXXXXXXX", "C" + CHR(243) + "digo")
1862:             loc_oForm.mAddColuna("Descs",    "",           "Descri" + CHR(231) + CHR(227) + "o")
1863:             loc_oForm.Show()
1864:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaCol")
1865:                 THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_BuscaCol.Colecoes)
1866:             ENDIF
1867:             ENDIF
1868:         ENDIF
1869:         IF USED("cursor_4c_BuscaCol")
1870:             USE IN cursor_4c_BuscaCol
1871:         ENDIF
1872:         loc_oForm.Release()
1873:     ENDPROC
1874: 
1875:     PROCEDURE TeclaLookupCol(par_nKeyCode, par_nShiftAltCtrl)
1876:         IF INLIST(par_nKeyCode, 115, 116)
1877:             THIS.AbrirBuscaCol()
1878:         ELSE
1879:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1880:             THIS.ValidarCol()
1881:             ENDIF
1882:         ENDIF
1883:     ENDPROC
1884: 
1885:     PROCEDURE ValidarCol()
1886:         LOCAL loc_cVal, loc_nR
1887:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Col.Value, "")))
1888:         IF EMPTY(loc_cVal)
1889:             RETURN
1890:         ENDIF
1891:         loc_nR = SQLEXEC(gnConnHandle, ;
1892:             "SELECT Colecoes FROM SigCdCol WHERE Colecoes = " + EscaparSQL(loc_cVal), ;
1893:             "cursor_4c_ValCol")
1894:         IF loc_nR > 0 AND !EOF("cursor_4c_ValCol")
1895:             THIS.txt_4c_Col.Value = ALLTRIM(cursor_4c_ValCol.Colecoes)
1896:         ELSE
1897:             MsgAviso("Cole" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "")
1898:             THIS.txt_4c_Col.Value = ""
1899:             THIS.AbrirBuscaCol()
1900:         ENDIF
1901:         IF USED("cursor_4c_ValCol")
1902:             USE IN cursor_4c_ValCol
1903:         ENDIF
1904:     ENDPROC
1905: 
1906:     *==========================================================================
1907:     * Lookups - SigCdMoe (Moeda - Tipo 2)
1908:     *==========================================================================
1909:     PROCEDURE AbrirBuscaMoeda()
1910:         THIS.BuscarMoedaHelper(THIS.txt_4c_Moeda)
1911:     ENDPROC
1912: 
1913:     PROCEDURE TeclaLookupMoeda(par_nKeyCode, par_nShiftAltCtrl)
1914:         IF INLIST(par_nKeyCode, 115, 116)
1915:             THIS.AbrirBuscaMoeda()
1916:         ELSE
1917:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1918:             THIS.ValidarMoeda()
1919:             ENDIF
1920:         ENDIF
1921:     ENDPROC
1922: 
1923:     PROCEDURE ValidarMoeda()
1924:         LOCAL loc_cVal, loc_nR
1925:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Moeda.Value, "")))
1926:         IF EMPTY(loc_cVal)
1927:             RETURN
1928:         ENDIF
1929:         loc_nR = SQLEXEC(gnConnHandle, ;
1930:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
1931:             "cursor_4c_ValMoe")
1932:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
1933:             THIS.txt_4c_Moeda.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
1934:         ELSE
1935:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
1936:             THIS.txt_4c_Moeda.Value = ""
1937:             THIS.AbrirBuscaMoeda()
1938:         ENDIF
1939:         IF USED("cursor_4c_ValMoe")
1940:             USE IN cursor_4c_ValMoe
1941:         ENDIF
1942:     ENDPROC
1943: 
1944:     *==========================================================================
1945:     * Lookups - SigCdMoe (Moecs)
1946:     *==========================================================================
1947:     PROCEDURE AbrirBuscaMoecs()
1948:         THIS.BuscarMoedaHelper(THIS.txt_4c_Moecs)
1949:     ENDPROC
1950: 
1951:     PROCEDURE TeclaLookupMoecs(par_nKeyCode, par_nShiftAltCtrl)
1952:         IF INLIST(par_nKeyCode, 115, 116)
1953:             THIS.AbrirBuscaMoecs()
1954:         ELSE
1955:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1956:             THIS.ValidarMoecs()
1957:             ENDIF
1958:         ENDIF
1959:     ENDPROC
1960: 
1961:     PROCEDURE ValidarMoecs()
1962:         LOCAL loc_cVal, loc_nR
1963:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Moecs.Value, "")))
1964:         IF EMPTY(loc_cVal)
1965:             RETURN
1966:         ENDIF
1967:         loc_nR = SQLEXEC(gnConnHandle, ;
1968:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
1969:             "cursor_4c_ValMoe")
1970:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
1971:             THIS.txt_4c_Moecs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
1972:         ELSE
1973:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
1974:             THIS.txt_4c_Moecs.Value = ""
1975:             THIS.AbrirBuscaMoecs()
1976:         ENDIF
1977:         IF USED("cursor_4c_ValMoe")
1978:             USE IN cursor_4c_ValMoe
1979:         ENDIF
1980:     ENDPROC
1981: 
1982:     *==========================================================================
1983:     * Lookups - SigCdMoe (MoeCusFs)
1984:     *==========================================================================
1985:     PROCEDURE AbrirBuscaMoeCusFs()
1986:         THIS.BuscarMoedaHelper(THIS.txt_4c_MoeCusFs)
1987:     ENDPROC
1988: 
1989:     PROCEDURE TeclaLookupMoeCusFs(par_nKeyCode, par_nShiftAltCtrl)
1990:         IF INLIST(par_nKeyCode, 115, 116)
1991:             THIS.AbrirBuscaMoeCusFs()
1992:         ELSE
1993:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
1994:             THIS.ValidarMoeCusFs()
1995:             ENDIF
1996:         ENDIF
1997:     ENDPROC
1998: 
1999:     PROCEDURE ValidarMoeCusFs()
2000:         LOCAL loc_cVal, loc_nR
2001:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, "")))
2002:         IF EMPTY(loc_cVal)
2003:             RETURN
2004:         ENDIF
2005:         loc_nR = SQLEXEC(gnConnHandle, ;
2006:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2007:             "cursor_4c_ValMoe")
2008:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2009:             THIS.txt_4c_MoeCusFs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2010:         ELSE
2011:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2012:             THIS.txt_4c_MoeCusFs.Value = ""
2013:             THIS.AbrirBuscaMoeCusFs()
2014:         ENDIF
2015:         IF USED("cursor_4c_ValMoe")
2016:             USE IN cursor_4c_ValMoe
2017:         ENDIF
2018:     ENDPROC
2019: 
2020:     *==========================================================================
2021:     * Lookups - SigCdMoe (Moedas = Moeda Preco Ideal)
2022:     *==========================================================================
2023:     PROCEDURE AbrirBuscaMoedas()
2024:         THIS.BuscarMoedaHelper(THIS.txt_4c_Moedas)
2025:     ENDPROC
2026: 
2027:     PROCEDURE TeclaLookupMoedas(par_nKeyCode, par_nShiftAltCtrl)
2028:         IF INLIST(par_nKeyCode, 115, 116)
2029:             THIS.AbrirBuscaMoedas()
2030:         ELSE
2031:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2032:             THIS.ValidarMoedas()
2033:             ENDIF
2034:         ENDIF
2035:     ENDPROC
2036: 
2037:     PROCEDURE ValidarMoedas()
2038:         LOCAL loc_cVal, loc_nR
2039:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Moedas.Value, "")))
2040:         IF EMPTY(loc_cVal)
2041:             RETURN
2042:         ENDIF
2043:         loc_nR = SQLEXEC(gnConnHandle, ;
2044:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2045:             "cursor_4c_ValMoe")
2046:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2047:             THIS.txt_4c_Moedas.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2048:         ELSE
2049:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2050:             THIS.txt_4c_Moedas.Value = ""
2051:             THIS.AbrirBuscaMoedas()
2052:         ENDIF
2053:         IF USED("cursor_4c_ValMoe")
2054:             USE IN cursor_4c_ValMoe
2055:         ENDIF
2056:     ENDPROC
2057: 
2058:     *==========================================================================
2059:     * Lookups - SigCdMoe (MoeCusto = Moeda do Custo)
2060:     *==========================================================================
2061:     PROCEDURE AbrirBuscaMoeCusto()
2062:         THIS.BuscarMoedaHelper(THIS.txt_4c_MoeCusto)
2063:     ENDPROC
2064: 
2065:     PROCEDURE TeclaLookupMoeCusto(par_nKeyCode, par_nShiftAltCtrl)
2066:         IF INLIST(par_nKeyCode, 115, 116)
2067:             THIS.AbrirBuscaMoeCusto()
2068:         ELSE
2069:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2070:             THIS.ValidarMoeCusto()
2071:             ENDIF
2072:         ENDIF
2073:     ENDPROC
2074: 
2075:     PROCEDURE ValidarMoeCusto()
2076:         LOCAL loc_cVal, loc_nR
2077:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, "")))
2078:         IF EMPTY(loc_cVal)
2079:             RETURN
2080:         ENDIF
2081:         loc_nR = SQLEXEC(gnConnHandle, ;
2082:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2083:             "cursor_4c_ValMoe")
2084:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2085:             THIS.txt_4c_MoeCusto.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2086:         ELSE
2087:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2088:             THIS.txt_4c_MoeCusto.Value = ""
2089:             THIS.AbrirBuscaMoeCusto()
2090:         ENDIF
2091:         IF USED("cursor_4c_ValMoe")
2092:             USE IN cursor_4c_ValMoe
2093:         ENDIF
2094:     ENDPROC
2095: 
2096:     *==========================================================================
2097:     * Lookups - SigCdMoe (MoeVs = Moeda Preco Atual)
2098:     *==========================================================================
2099:     PROCEDURE AbrirBuscaMoeVs()
2100:         THIS.BuscarMoedaHelper(THIS.txt_4c_MoeVs)
2101:     ENDPROC
2102: 
2103:     PROCEDURE TeclaLookupMoeVs(par_nKeyCode, par_nShiftAltCtrl)
2104:         IF INLIST(par_nKeyCode, 115, 116)
2105:             THIS.AbrirBuscaMoeVs()
2106:         ELSE
2107:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2108:             THIS.ValidarMoeVs()
2109:             ENDIF
2110:         ENDIF
2111:     ENDPROC
2112: 
2113:     PROCEDURE ValidarMoeVs()
2114:         LOCAL loc_cVal, loc_nR
2115:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value, "")))
2116:         IF EMPTY(loc_cVal)
2117:             RETURN
2118:         ENDIF
2119:         loc_nR = SQLEXEC(gnConnHandle, ;
2120:             "SELECT CMoes FROM SigCdMoe WHERE CMoes = " + EscaparSQL(loc_cVal), ;
2121:             "cursor_4c_ValMoe")
2122:         IF loc_nR > 0 AND !EOF("cursor_4c_ValMoe")
2123:             THIS.txt_4c_MoeVs.Value = ALLTRIM(cursor_4c_ValMoe.CMoes)
2124:         ELSE
2125:             MsgAviso("Moeda n" + CHR(227) + "o encontrada.", "")
2126:             THIS.txt_4c_MoeVs.Value = ""
2127:             THIS.AbrirBuscaMoeVs()
2128:         ENDIF
2129:         IF USED("cursor_4c_ValMoe")
2130:             USE IN cursor_4c_ValMoe
2131:         ENDIF
2132:     ENDPROC
2133: 
2134:     *==========================================================================
2135:     * Lookups - SigPrFti (CFtios = Feitio)
2136:     *==========================================================================
2137:     PROCEDURE AbrirBuscaCFtios()
2138:         LOCAL loc_cValor, loc_oForm
2139:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value, ""))
2140:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2141:             "SigPrFti", "cursor_4c_BuscaFtio", "Cods", loc_cValor, "Feitio")
2142:         IF ISNULL(loc_oForm)
2143:             RETURN
2144:         ENDIF
2145:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
2146:             THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
2147:         ELSE
2148:             IF !loc_oForm.this_lAchouRegistro
2149:             loc_oForm.mAddColuna("Cods",  "XXXXXX", "C" + CHR(243) + "digo")
2150:             loc_oForm.mAddColuna("Descs", "",       "Descri" + CHR(231) + CHR(227) + "o")
2151:             loc_oForm.Show()
2152:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaFtio")
2153:                 THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_BuscaFtio.Cods)
2154:             ENDIF
2155:             ENDIF
2156:         ENDIF
2157:         IF USED("cursor_4c_BuscaFtio")
2158:             USE IN cursor_4c_BuscaFtio
2159:         ENDIF
2160:         loc_oForm.Release()
2161:     ENDPROC
2162: 
2163:     PROCEDURE TeclaLookupCFtios(par_nKeyCode, par_nShiftAltCtrl)
2164:         IF INLIST(par_nKeyCode, 115, 116)
2165:             THIS.AbrirBuscaCFtios()
2166:         ELSE
2167:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2168:             THIS.ValidarCFtios()
2169:             ENDIF
2170:         ENDIF
2171:     ENDPROC
2172: 
2173:     PROCEDURE ValidarCFtios()
2174:         LOCAL loc_cVal, loc_nR
2175:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_CFtios.Value, "")))
2176:         IF EMPTY(loc_cVal)
2177:             RETURN
2178:         ENDIF
2179:         loc_nR = SQLEXEC(gnConnHandle, ;
2180:             "SELECT Cods FROM SigPrFti WHERE Cods = " + EscaparSQL(loc_cVal), ;
2181:             "cursor_4c_ValFtio")
2182:         IF loc_nR > 0 AND !EOF("cursor_4c_ValFtio")
2183:             THIS.txt_4c_CFtios.Value = ALLTRIM(cursor_4c_ValFtio.Cods)
2184:         ELSE
2185:             MsgAviso("Feitio n" + CHR(227) + "o encontrado.", "")
2186:             THIS.txt_4c_CFtios.Value = ""
2187:             THIS.AbrirBuscaCFtios()
2188:         ENDIF
2189:         IF USED("cursor_4c_ValFtio")
2190:             USE IN cursor_4c_ValFtio
2191:         ENDIF
2192:     ENDPROC
2193: 
2194:     *==========================================================================
2195:     * Lookups - Fornecedor via fAcessoContas (Conta / DConta)
2196:     *==========================================================================
2197:     PROCEDURE AbrirBuscaConta()
2198:         fAcessoContas(gc_4c_UsuarioLogado, ;
2199:                       THIS.this_oBusinessObject.this_cGrPadFors, ;
2200:                       "C", THIS.txt_4c_Conta.Value, ;
2201:                       THIS.txt_4c_Conta, THIS.txt_4c_DConta)
2202:     ENDPROC
2203: 
2204:     PROCEDURE TeclaLookupConta(par_nKeyCode, par_nShiftAltCtrl)
2205:         IF INLIST(par_nKeyCode, 115, 116)
2206:             THIS.AbrirBuscaConta()
2207:         ELSE
2208:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2209:             THIS.ValidarConta()
2210:             ENDIF
2211:         ENDIF
2212:     ENDPROC
2213: 
2214:     PROCEDURE ValidarConta()
2215:         IF !EMPTY(ALLTRIM(NVL(THIS.txt_4c_Conta.Value, "")))
2216:             IF !fAcessoContas(gc_4c_UsuarioLogado, ;
2217:                               THIS.this_oBusinessObject.this_cGrPadFors, ;
2218:                               "C", THIS.txt_4c_Conta.Value, ;
2219:                               THIS.txt_4c_Conta, THIS.txt_4c_DConta)
2220:                 MsgAviso("Acesso Negado !!!", "")
2221:                 THIS.txt_4c_Conta.Value  = ""
2222:                 THIS.txt_4c_DConta.Value = ""
2223:             ENDIF
2224:         ELSE
2225:             THIS.txt_4c_DConta.Value = ""
2226:         ENDIF
2227:     ENDPROC
2228: 
2229:     PROCEDURE AbrirBuscaDConta()
2230:         fAcessoContas(gc_4c_UsuarioLogado, ;
2231:                       THIS.this_oBusinessObject.this_cGrPadFors, ;
2232:                       "D", THIS.txt_4c_DConta.Value, ;
2233:                       THIS.txt_4c_Conta, THIS.txt_4c_DConta)
2234:     ENDPROC
2235: 
2236:     PROCEDURE TeclaLookupDConta(par_nKeyCode, par_nShiftAltCtrl)
2237:         IF INLIST(par_nKeyCode, 115, 116)
2238:             THIS.AbrirBuscaDConta()
2239:         ELSE
2240:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2241:             THIS.ValidarDConta()
2242:             ENDIF
2243:         ENDIF
2244:     ENDPROC
2245: 
2246:     PROCEDURE ValidarDConta()
2247:         IF !EMPTY(ALLTRIM(NVL(THIS.txt_4c_DConta.Value, "")))
2248:             IF !fAcessoContas(gc_4c_UsuarioLogado, ;
2249:                               THIS.this_oBusinessObject.this_cGrPadFors, ;
2250:                               "D", THIS.txt_4c_DConta.Value, ;
2251:                               THIS.txt_4c_Conta, THIS.txt_4c_DConta)
2252:                 MsgAviso("Acesso Negado !!!", "")
2253:                 THIS.txt_4c_DConta.Value = ""
2254:                 THIS.txt_4c_Conta.Value  = ""
2255:             ENDIF
2256:         ELSE
2257:             THIS.txt_4c_Conta.Value = ""
2258:         ENDIF
2259:     ENDPROC
2260: 
2261:     *==========================================================================
2262:     * Lookups - SigPrPmc (Promo)
2263:     *==========================================================================
2264:     PROCEDURE AbrirBuscaPromo()
2265:         LOCAL loc_cValor, loc_oForm
2266:         loc_cValor = ALLTRIM(NVL(THIS.txt_4c_Promo.Value, ""))
2267:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2268:             "SigPrPmc", "cursor_4c_BuscaPmc", "Promos", loc_cValor, ;
2269:             "Promo" + CHR(231) + CHR(227) + "o")
2270:         IF ISNULL(loc_oForm)
2271:             RETURN
2272:         ENDIF
2273:         IF loc_oForm.this_lSelecionou AND loc_oForm.this_lAchouRegistro
2274:             THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPmc.Promos)
2275:         ELSE
2276:             IF !loc_oForm.this_lAchouRegistro
2277:             loc_oForm.mAddColuna("Promos", "", "Promo" + CHR(231) + CHR(227) + "o")
2278:             loc_oForm.Show()
2279:             IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaPmc")
2280:                 THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_BuscaPmc.Promos)
2281:             ENDIF
2282:             ENDIF
2283:         ENDIF
2284:         IF USED("cursor_4c_BuscaPmc")
2285:             USE IN cursor_4c_BuscaPmc
2286:         ENDIF
2287:         loc_oForm.Release()
2288:     ENDPROC
2289: 
2290:     PROCEDURE TeclaLookupPromo(par_nKeyCode, par_nShiftAltCtrl)
2291:         IF INLIST(par_nKeyCode, 115, 116)
2292:             THIS.AbrirBuscaPromo()
2293:         ELSE
2294:             IF par_nKeyCode = 13 OR par_nKeyCode = 9
2295:             THIS.ValidarPromo()
2296:             ENDIF
2297:         ENDIF
2298:     ENDPROC
2299: 
2300:     PROCEDURE ValidarPromo()
2301:         LOCAL loc_cVal, loc_nR
2302:         loc_cVal = UPPER(ALLTRIM(NVL(THIS.txt_4c_Promo.Value, "")))
2303:         IF EMPTY(loc_cVal)
2304:             RETURN
2305:         ENDIF
2306:         loc_nR = SQLEXEC(gnConnHandle, ;
2307:             "SELECT Promos FROM SigPrPmc WHERE Promos = " + EscaparSQL(loc_cVal), ;
2308:             "cursor_4c_ValPmc")
2309:         IF loc_nR > 0 AND !EOF("cursor_4c_ValPmc")
2310:             THIS.txt_4c_Promo.Value = ALLTRIM(cursor_4c_ValPmc.Promos)
2311:         ELSE
2312:             MsgAviso("Promo" + CHR(231) + CHR(227) + "o n" + CHR(227) + "o encontrada.", "")
2313:             THIS.txt_4c_Promo.Value = ""
2314:             THIS.AbrirBuscaPromo()
2315:         ENDIF
2316:         IF USED("cursor_4c_ValPmc")
2317:             USE IN cursor_4c_ValPmc
2318:         ENDIF
2319:     ENDPROC
2320: 
2321:     *==========================================================================
2322:     * BtnIncluirClick - Inicia novo ciclo: limpa grid e parametros (equivale a
2323:     *   "nova busca" no contexto operacional de reajuste de precificacao)
2324:     *==========================================================================
2325:     PROCEDURE BtnIncluirClick()
2326:         LOCAL loc_oErro
2327:         TRY
2328:             THIS.AlternarPagina(1)
2329:             IF VARTYPE(THIS.txt_4c_CdGrupo) = "O"
2330:                 THIS.txt_4c_CdGrupo.SetFocus
2331:             ENDIF
2332:         CATCH TO loc_oErro
2333:             MsgErro(loc_oErro.Message, "Erro BtnIncluirClick")
2334:         ENDTRY
2335:     ENDPROC
2336: 
2337:     *==========================================================================
2338:     * BtnAlterarClick - Reprocessa com os parametros atuais sem limpar filtros
2339:     *   (equivale a "recalcular" preservando selecao atual do grid)
2340:     *==========================================================================
2341:     PROCEDURE BtnAlterarClick()
2342:         LOCAL loc_oBO, loc_oErro
2343:         TRY
2344:             loc_oBO = THIS.this_oBusinessObject
2345:             IF VARTYPE(loc_oBO) # "O"
2346:                 RETURN
2347:             ENDIF
2348:             *-- Transfere campos do form para o BO (mesmo fluxo de Processar)
2349:             loc_oBO.this_nTipo      = THIS.opt_4c_Tipo.Value
2350:             loc_oBO.this_cCdGrupo   = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value,  ""))
2351:             loc_oBO.this_cAteGrupo  = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
2352:             loc_oBO.this_cCol       = ALLTRIM(NVL(THIS.txt_4c_Col.Value,       ""))
2353:             loc_oBO.this_cConta     = ALLTRIM(NVL(THIS.txt_4c_Conta.Value,     ""))
2354:             loc_oBO.this_cDConta    = ALLTRIM(NVL(THIS.txt_4c_DConta.Value,    ""))
2355:             loc_oBO.this_nIgnorar   = THIS.chk_4c_Ignorar.Value
2356:             loc_oBO.this_nVariacao  = NVL(THIS.txt_4c_Variacao.Value, 0)
2357:             loc_oBO.this_nIncCusts  = THIS.chk_4c_IncCusts.Value
2358:             loc_oBO.this_cMoeda     = ALLTRIM(NVL(THIS.txt_4c_Moeda.Value,    ""))
2359:             loc_oBO.this_nMarkUp1   = NVL(THIS.txt_4c_MarkUp1.Value,  0)
2360:             loc_oBO.this_nMarkUp2   = NVL(THIS.txt_4c_MarkUp2.Value,  0)
2361:             loc_oBO.this_nFator     = NVL(THIS.txt_4c_Fator.Value,    0)
2362:             loc_oBO.this_cMoeCusto  = ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, ""))
2363:             loc_oBO.this_cMoecs     = ALLTRIM(NVL(THIS.txt_4c_Moecs.Value,    ""))
2364:             loc_oBO.this_cMoeCusFs  = ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, ""))
2365:             loc_oBO.this_cMoedas    = ALLTRIM(NVL(THIS.txt_4c_Moedas.Value,   ""))
2366:             loc_oBO.this_cCFtios    = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value,   ""))
2367:             loc_oBO.this_cMoeVs     = ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value,    ""))
2368:             loc_oBO.this_cPromo     = ALLTRIM(NVL(THIS.txt_4c_Promo.Value,    ""))
2369:             loc_oBO.this_nLimpar    = THIS.chk_4c_Limpar.Value
2370:             loc_oBO.this_nAuditado  = THIS.chk_4c_Auditado.Value
2371:             IF loc_oBO.ProcessarReajuste()
2372:                 THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
2373:                 THIS.grd_4c_Produtos.Column1.SetFocus
2374:                 THIS.grd_4c_Produtos.Refresh
2375:             ENDIF
2376:         CATCH TO loc_oErro
2377:             MsgErro(loc_oErro.Message, "Erro BtnAlterarClick")
2378:         ENDTRY
2379:     ENDPROC
2380: 
2381:     *==========================================================================
2382:     * BtnVisualizarClick - Exibe o estado atual do grid (precos antes x depois)
2383:     *   Atualiza o grid a partir do cursor sem reprocessar
2384:     *==========================================================================
2385:     PROCEDURE BtnVisualizarClick()
2386:         LOCAL loc_oErro
2387:         TRY
2388:             IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
2389:                 SELECT cursor_4c_Produtos
2390:                 GO TOP
2391:                 THIS.grd_4c_Produtos.Refresh
2392:                 THIS.Refresh
2393:             ELSE
2394:                 MsgAviso("N" + CHR(227) + "o h" + CHR(225) + " produtos processados " + ;
2395:                          "para visualizar. Execute o Processar primeiro.", "Aviso")
2396:             ENDIF
2397:         CATCH TO loc_oErro
2398:             MsgErro(loc_oErro.Message, "Erro BtnVisualizarClick")
2399:         ENDTRY
2400:     ENDPROC
2401: 
2402:     *==========================================================================
2403:     * BtnExcluirClick - Limpa apenas o grid de produtos sem resetar os filtros
2404:     *   Permite reprocessar com os mesmos parametros mas lista limpa
2405:     *==========================================================================
2406:     PROCEDURE BtnExcluirClick()
2407:         LOCAL loc_lConfirma, loc_oErro
2408:         TRY
2409:             IF !USED("cursor_4c_Produtos") OR RECCOUNT("cursor_4c_Produtos") = 0
2410:                 RETURN
2411:             ENDIF
2412:             loc_lConfirma = MsgConfirma("Limpar a lista de produtos processados?", ;
2413:                                         "Confirmar")
2414:             IF loc_lConfirma
2415:                 THIS.AlternarPagina(2)
2416:             ENDIF
2417:         CATCH TO loc_oErro
2418:             MsgErro(loc_oErro.Message, "Erro BtnExcluirClick")
2419:         ENDTRY
2420:     ENDPROC
2421: 
2422:     *==========================================================================
2423:     * AbrirBuscaProdutoGrd - Lookup de produto para modo auditado (Column2)
2424:     * Equivalente ao fwbuscaext do Column2.Text1.Valid no legado.
2425:     *==========================================================================
2426:     PROCEDURE AbrirBuscaProdutoGrd()
2427:         LOCAL loc_cValAtual, loc_oForm, loc_cSelecionado
2428: 
2429:         IF !USED("cursor_4c_Produtos") OR EOF("cursor_4c_Produtos")
2430:             RETURN
2431:         ENDIF
2432:         SELECT cursor_4c_Produtos
2433:         loc_cValAtual = ALLTRIM(NVL(cursor_4c_Produtos.CPros, ""))
2434: 
2435:         loc_oForm = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2436:             "SigCdPro", "cursor_4c_BuscaPro", "CPros", loc_cValAtual, ;
2437:             "Produtos")
2438:         IF ISNULL(loc_oForm) OR VARTYPE(loc_oForm) # "O"
2439:             RETURN
2440:         ENDIF
2441: 
2442:         IF !loc_oForm.this_lAchouRegistro
2443:             loc_oForm.mAddColuna("CPros", "", "C" + CHR(243) + "digo")
2444:             loc_oForm.mAddColuna("DPros", "", "Descri" + CHR(231) + CHR(227) + "o")
2445:             loc_oForm.Show()
2446:         ENDIF
2447: 
2448:         loc_cSelecionado = ""
2449:         IF loc_oForm.this_lSelecionou AND USED("cursor_4c_BuscaPro")
2450:             loc_cSelecionado = ALLTRIM(cursor_4c_BuscaPro.CPros)
2451:         ENDIF
2452:         IF USED("cursor_4c_BuscaPro")
2453:             USE IN cursor_4c_BuscaPro
2454:         ENDIF
2455: 
2456:         IF !EMPTY(loc_cSelecionado)
2457:             SELECT cursor_4c_Produtos
2458:             REPLACE CPros WITH loc_cSelecionado
2459:             THIS.grd_4c_Produtos.Refresh
2460:             THIS.CarregarProdutoAuditado(loc_cSelecionado)
2461:         ELSE
2462:             SELECT cursor_4c_Produtos
2463:             IF !EOF("cursor_4c_Produtos")
2464:                 REPLACE CPros WITH SPACE(14)
2465:             ENDIF
2466:             THIS.grd_4c_Produtos.Refresh
2467:         ENDIF
2468:         loc_oForm.Release()
2469:     ENDPROC
2470: 
2471:     *==========================================================================
2472:     * FormParaBO - Transfere todos os campos do form para propriedades do BO
2473:     * Usado por BtnProcessarClick e BtnAlterarClick para evitar duplicacao
2474:     *==========================================================================
2475:     PROCEDURE FormParaBO()
2476:         LOCAL loc_oBO
2477:         loc_oBO = THIS.this_oBusinessObject
2478:         IF VARTYPE(loc_oBO) # "O"
2479:             RETURN
2480:         ENDIF
2481:         loc_oBO.this_nTipo     = THIS.opt_4c_Tipo.Value
2482:         loc_oBO.this_cCdGrupo  = ALLTRIM(NVL(THIS.txt_4c_CdGrupo.Value,  ""))
2483:         loc_oBO.this_cAteGrupo = ALLTRIM(NVL(THIS.txt_4c_AteGrupo.Value, ""))
2484:         loc_oBO.this_cCol      = ALLTRIM(NVL(THIS.txt_4c_Col.Value,       ""))
2485:         loc_oBO.this_cConta    = ALLTRIM(NVL(THIS.txt_4c_Conta.Value,     ""))
2486:         loc_oBO.this_cDConta   = ALLTRIM(NVL(THIS.txt_4c_DConta.Value,    ""))
2487:         loc_oBO.this_nIgnorar  = THIS.chk_4c_Ignorar.Value
2488:         loc_oBO.this_nVariacao = NVL(THIS.txt_4c_Variacao.Value, 0)
2489:         loc_oBO.this_nIncCusts = THIS.chk_4c_IncCusts.Value
2490:         loc_oBO.this_cMoeda    = ALLTRIM(NVL(THIS.txt_4c_Moeda.Value,    ""))
2491:         loc_oBO.this_nMarkUp1  = NVL(THIS.txt_4c_MarkUp1.Value,  0)
2492:         loc_oBO.this_nMarkUp2  = NVL(THIS.txt_4c_MarkUp2.Value,  0)
2493:         loc_oBO.this_nFator    = NVL(THIS.txt_4c_Fator.Value,    0)
2494:         loc_oBO.this_cMoeCusto = ALLTRIM(NVL(THIS.txt_4c_MoeCusto.Value, ""))
2495:         loc_oBO.this_cMoecs    = ALLTRIM(NVL(THIS.txt_4c_Moecs.Value,    ""))
2496:         loc_oBO.this_cMoeCusFs = ALLTRIM(NVL(THIS.txt_4c_MoeCusFs.Value, ""))
2497:         loc_oBO.this_cMoedas   = ALLTRIM(NVL(THIS.txt_4c_Moedas.Value,   ""))
2498:         loc_oBO.this_cCFtios   = ALLTRIM(NVL(THIS.txt_4c_CFtios.Value,   ""))
2499:         loc_oBO.this_cMoeVs    = ALLTRIM(NVL(THIS.txt_4c_MoeVs.Value,    ""))
2500:         loc_oBO.this_cPromo    = ALLTRIM(NVL(THIS.txt_4c_Promo.Value,    ""))
2501:         loc_oBO.this_nLimpar   = THIS.chk_4c_Limpar.Value
2502:         loc_oBO.this_nAuditado = THIS.chk_4c_Auditado.Value
2503:     ENDPROC
2504: 
2505:     *==========================================================================
2506:     * BOParaForm - Carrega propriedades do BO de volta para os campos do form
2507:     * Util apos recarregar estado do BO ou em modo auditado
2508:     *==========================================================================
2509:     PROCEDURE BOParaForm()
2510:         LOCAL loc_oBO
2511:         loc_oBO = THIS.this_oBusinessObject
2512:         IF VARTYPE(loc_oBO) # "O"
2513:             RETURN
2514:         ENDIF
2515:         IF VARTYPE(THIS.opt_4c_Tipo)     = "O"
2516:             THIS.opt_4c_Tipo.Value     = loc_oBO.this_nTipo
2517:             THIS.AtualizarVisibilidade(loc_oBO.this_nTipo)
2518:         ENDIF
2519:         IF VARTYPE(THIS.txt_4c_CdGrupo)  = "O"
2520:             THIS.txt_4c_CdGrupo.Value  = ALLTRIM(loc_oBO.this_cCdGrupo)
2521:         ENDIF
2522:         IF VARTYPE(THIS.txt_4c_AteGrupo) = "O"
2523:             THIS.txt_4c_AteGrupo.Value = ALLTRIM(loc_oBO.this_cAteGrupo)
2524:         ENDIF
2525:         IF VARTYPE(THIS.txt_4c_Col)      = "O"
2526:             THIS.txt_4c_Col.Value      = ALLTRIM(loc_oBO.this_cCol)
2527:         ENDIF
2528:         IF VARTYPE(THIS.txt_4c_Conta)    = "O"
2529:             THIS.txt_4c_Conta.Value    = ALLTRIM(loc_oBO.this_cConta)
2530:         ENDIF
2531:         IF VARTYPE(THIS.txt_4c_DConta)   = "O"
2532:             THIS.txt_4c_DConta.Value   = ALLTRIM(loc_oBO.this_cDConta)
2533:         ENDIF
2534:         IF VARTYPE(THIS.chk_4c_Ignorar)  = "O"
2535:             THIS.chk_4c_Ignorar.Value  = loc_oBO.this_nIgnorar
2536:         ENDIF
2537:         IF VARTYPE(THIS.txt_4c_Variacao) = "O"
2538:             THIS.txt_4c_Variacao.Value = loc_oBO.this_nVariacao
2539:         ENDIF
2540:         IF VARTYPE(THIS.chk_4c_IncCusts) = "O"
2541:             THIS.chk_4c_IncCusts.Value = loc_oBO.this_nIncCusts
2542:         ENDIF
2543:         IF VARTYPE(THIS.txt_4c_Moeda)    = "O"
2544:             THIS.txt_4c_Moeda.Value    = ALLTRIM(loc_oBO.this_cMoeda)
2545:         ENDIF
2546:         IF VARTYPE(THIS.txt_4c_MarkUp1)  = "O"
2547:             THIS.txt_4c_MarkUp1.Value  = loc_oBO.this_nMarkUp1
2548:         ENDIF
2549:         IF VARTYPE(THIS.txt_4c_MarkUp2)  = "O"

*-- Linhas 2586 a 2637:
2586:     * LimparCampos - Limpa todos os campos de entrada e o grid de produtos
2587:     * Equivalente a resetar o form para o estado inicial (nova consulta)
2588:     *==========================================================================
2589:     PROCEDURE LimparCampos()
2590:         THIS.AlternarPagina(1)
2591:     ENDPROC
2592: 
2593:     *==========================================================================
2594:     * HabilitarCampos - Habilita ou desabilita todos os campos de entrada
2595:     * par_lHabilitar = .T. -> habilitar | .F. -> desabilitar
2596:     *==========================================================================
2597:     PROCEDURE HabilitarCampos(par_lHabilitar)
2598:         LOCAL loc_lHab
2599:         loc_lHab = IIF(VARTYPE(par_lHabilitar) = "L", par_lHabilitar, .T.)
2600: 
2601:         IF VARTYPE(THIS.txt_4c_CdGrupo)  = "O"
2602:             THIS.txt_4c_CdGrupo.Enabled  = loc_lHab
2603:         ENDIF
2604:         IF VARTYPE(THIS.txt_4c_AteGrupo) = "O"
2605:             THIS.txt_4c_AteGrupo.Enabled = loc_lHab
2606:         ENDIF
2607:         IF VARTYPE(THIS.txt_4c_Col)      = "O"
2608:             THIS.txt_4c_Col.Enabled      = loc_lHab
2609:         ENDIF
2610:         IF VARTYPE(THIS.txt_4c_Conta)    = "O"
2611:             THIS.txt_4c_Conta.Enabled    = loc_lHab
2612:         ENDIF
2613:         IF VARTYPE(THIS.txt_4c_DConta)   = "O"
2614:             THIS.txt_4c_DConta.Enabled   = loc_lHab
2615:         ENDIF
2616:         IF VARTYPE(THIS.txt_4c_Variacao) = "O"
2617:             THIS.txt_4c_Variacao.Enabled = loc_lHab
2618:         ENDIF
2619:         IF VARTYPE(THIS.txt_4c_Moeda)    = "O"
2620:             THIS.txt_4c_Moeda.Enabled    = loc_lHab
2621:         ENDIF
2622:         IF VARTYPE(THIS.txt_4c_MarkUp1)  = "O"
2623:             THIS.txt_4c_MarkUp1.Enabled  = loc_lHab
2624:         ENDIF
2625:         IF VARTYPE(THIS.txt_4c_MarkUp2)  = "O"
2626:             THIS.txt_4c_MarkUp2.Enabled  = loc_lHab
2627:         ENDIF
2628:         IF VARTYPE(THIS.txt_4c_Fator)    = "O"
2629:             THIS.txt_4c_Fator.Enabled    = loc_lHab
2630:         ENDIF
2631:         IF VARTYPE(THIS.txt_4c_MoeCusto) = "O"
2632:             THIS.txt_4c_MoeCusto.Enabled = loc_lHab
2633:         ENDIF
2634:         IF VARTYPE(THIS.txt_4c_Promo)    = "O"
2635:             THIS.txt_4c_Promo.Enabled    = loc_lHab
2636:         ENDIF
2637:         IF VARTYPE(THIS.opt_4c_Tipo)     = "O"

*-- Linhas 2648 a 2727:
2648:     * executar ProcessarReajuste() via BtnProcessarClick.
2649:     * Exibe o estado atual do cursor sem reprocessar.
2650:     *==========================================================================
2651:     PROCEDURE CarregarLista()
2652:         IF USED("cursor_4c_Produtos") AND RECCOUNT("cursor_4c_Produtos") > 0
2653:             SELECT cursor_4c_Produtos
2654:             GO TOP
2655:             IF VARTYPE(THIS.grd_4c_Produtos) = "O"
2656:                 THIS.grd_4c_Produtos.Refresh
2657:             ENDIF
2658:         ENDIF
2659:     ENDPROC
2660: 
2661:     *==========================================================================
2662:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo corrente
2663:     * Para o form OPERACIONAL: habilita Processar, desabilita Atualizar
2664:     * apos reset; habilita Atualizar apos Processar com sucesso.
2665:     * par_cModo = "NORMAL"  -> estado inicial (Processar habilitado)
2666:     *           = "PRONTO"  -> apos Processar (Atualizar habilitado)
2667:     *           = "AUDITADO"-> modo entrada manual (Processar desabilitado)
2668:     *==========================================================================
2669:     PROCEDURE AjustarBotoesPorModo(par_cModo)
2670:         LOCAL loc_cModo
2671:         loc_cModo = UPPER(ALLTRIM(NVL(par_cModo, "NORMAL")))
2672: 
2673:         IF VARTYPE(THIS.cmg_4c_Acao) # "O"
2674:             RETURN
2675:         ENDIF
2676: 
2677:         DO CASE
2678:         CASE loc_cModo = "PRONTO"
2679:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
2680:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
2681: 
2682:         CASE loc_cModo = "AUDITADO"
2683:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .F.
2684:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .T.
2685: 
2686:         OTHERWISE
2687:             THIS.cmg_4c_Acao.Buttons(1).Enabled = .T.
2688:             THIS.cmg_4c_Acao.Buttons(2).Enabled = .F.
2689:         ENDCASE
2690: 
2691:         THIS.cmg_4c_Acao.Buttons(1).Refresh
2692:         THIS.cmg_4c_Acao.Buttons(2).Refresh
2693:     ENDPROC
2694: 
2695:     *==========================================================================
2696:     * BtnBuscarClick - Alias semantico para BtnProcessarClick
2697:     * Aciona o processamento de selecao e calculo de precos
2698:     *==========================================================================
2699:     PROCEDURE BtnBuscarClick()
2700:         THIS.BtnProcessarClick()
2701:     ENDPROC
2702: 
2703:     *==========================================================================
2704:     * BtnSalvarClick - Alias semantico para BtnAtualizarClick
2705:     * Confirma e grava os precos calculados no banco de dados
2706:     *==========================================================================
2707:     PROCEDURE BtnSalvarClick()
2708:         THIS.BtnAtualizarClick()
2709:     ENDPROC
2710: 
2711:     *==========================================================================
2712:     * BtnCancelarClick - Cancela o processamento atual sem gravar
2713:     * Zera o grid mas mantem os parametros de filtro para reprocessar
2714:     *==========================================================================
2715:     PROCEDURE BtnCancelarClick()
2716:         LOCAL loc_oErro
2717:         TRY
2718:             THIS.AlternarPagina(2)
2719:             IF VARTYPE(THIS.txt_4c_CdGrupo) = "O"
2720:                 THIS.txt_4c_CdGrupo.SetFocus
2721:             ENDIF
2722:         CATCH TO loc_oErro
2723:             MsgErro(loc_oErro.Message, "Erro BtnCancelarClick")
2724:         ENDTRY
2725:     ENDPROC
2726: 
2727: ENDDEFINE

