# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (2)
- [METODO-INEXISTENTE] Metodo 'THIS.ImprimirDocumento()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.EnviarEmail()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1240 linhas total):

*-- Linhas 24 a 218:
24:     this_oBusinessObject = .NULL.
25: 
26:     *--------------------------------------------------------------------------
27:     PROCEDURE Init(par_cDopes, par_lAutomatico)
28:     *--------------------------------------------------------------------------
29:         THIS.this_cDopes      = IIF(TYPE("par_cDopes") = "C", par_cDopes, "")
30:         THIS.this_lAutomatico = IIF(TYPE("par_lAutomatico") = "L", par_lAutomatico, .F.)
31:         RETURN DODEFAULT()
32:     ENDPROC
33: 
34:     *--------------------------------------------------------------------------
35:     * InicializarForm - Cria estrutura do formulario (chamado por FormBase.Init)
36:     *--------------------------------------------------------------------------
37:     PROTECTED PROCEDURE InicializarForm()
38:         LOCAL loc_lSucesso, loc_oErro
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             *-- Instancia o BO
43:             THIS.this_oBusinessObject = CREATEOBJECT("sigpremaBO")
44:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
45:                 *-- Propriedades visuais do form
46:                 THIS.Width        = 1000
47:                 THIS.Height       = 600
48:                 THIS.AutoCenter   = .T.
49:                 THIS.BorderStyle  = 2
50:                 THIS.TitleBar     = 0
51:                 THIS.ControlBox   = .F.
52:                 THIS.Caption      = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
53:                 THIS.FontName     = "Tahoma"
54:                 THIS.FontSize     = 8
55:                 THIS.WindowType   = 1
56:                 THIS.ShowTips     = .T.
57: 
58:                 IF FILE(gc_4c_CaminhoIcones + "new_background.jpg")
59:                     THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
60:                 ENDIF
61: 
62:                 *-- Cursor placeholder com estrutura identica ao cursor_4c_Local do BO
63:                 IF USED("cursor_4c_Dados")
64:                     USE IN cursor_4c_Dados
65:                 ENDIF
66:                 SET NULL ON
67:                 CREATE CURSOR cursor_4c_Dados (;
68:                     Checks     N(1)    NULL,;
69:                     grupos     C(10)   NULL,;
70:                     Contas     C(10)   NULL,;
71:                     Rclis      C(30)   NULL,;
72:                     emails     C(50)   NULL,;
73:                     mensagems  M,;
74:                     EmpDopNums C(29)   NULL,;
75:                     prioridade C(15)   NULL;
76:                 )
77:                 SET NULL OFF
78:                 INDEX ON Contas  TAG Contas
79:                 INDEX ON Rclis   TAG Rclis
80:                 INDEX ON emails  TAG Emails
81: 
82:                 *-- Cria estrutura visual (form OPERACIONAL usa layout flat, sem PageFrame real)
83:                 THIS.ConfigurarPageFrame()
84:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
85:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
86: 
87:                 THIS.TornarControlesVisiveis(THIS)
88: 
89:                 THIS.CarregarDados()
90: 
91:                 *-- Modo automatico: email ja foi enviado, impede exibicao do form
92:                 IF THIS.this_lAutomatico
93:                     loc_lSucesso = .F.
94:                 ENDIF
95: 
96:                 loc_lSucesso = .T.
97:             ELSE
98:                 MsgErro("Erro ao criar sigpremaBO.", "Erro")
99:             ENDIF
100: 
101:         CATCH TO loc_oErro
102:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
103:                     " PROC=" + loc_oErro.Procedure, "Erro ao inicializar form")
104:             loc_lSucesso = .F.
105:         ENDTRY
106: 
107:         RETURN loc_lSucesso
108:     ENDPROC
109: 
110:     *--------------------------------------------------------------------------
111:     * ConfigurarPageFrame - Orquestra layout do form OPERACIONAL (flat)
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarPageFrame()
114:         THIS.ConfigurarCabecalho()
115:         THIS.ConfigurarSaida()
116:         THIS.ConfigurarShape1()
117:         THIS.ConfigurarPaginaLista()
118:         THIS.ConfigurarPaginaDados()
119:     ENDPROC
120: 
121:     *--------------------------------------------------------------------------
122:     * AlternarPagina - Form OPERACIONAL nao alterna paginas
123:     * Metodo existe por compatibilidade com FormBase (chamado por CancelarClick etc)
124:     *--------------------------------------------------------------------------
125:     PROCEDURE AlternarPagina(par_nPagina)
126:         RETURN .T.
127:     ENDPROC
128: 
129:     *--------------------------------------------------------------------------
130:     * ConfigurarPaginaDados - Configura area de exibicao/edicao dos dados
131:     * Form OPERACIONAL: nao ha "Page Dados" separada; area de dados eh o grid.
132:     * Este metodo finaliza a area de dados:
133:     *   1. Aplica sort visual inicial (coluna Nome/Rclis destacada em teal)
134:     *   2. Normaliza BackColor dos demais headers em cinza claro
135:     *   3. Ajusta alinhamento do header do checkbox
136:     *   4. Garante que o grid comece com valores default consistentes
137:     *--------------------------------------------------------------------------
138:     PROTECTED PROCEDURE ConfigurarPaginaDados()
139:         LOCAL loc_oGrid
140: 
141:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
142:             RETURN .F.
143:         ENDIF
144:         loc_oGrid = THIS.grd_4c_Dados
145: 
146:         *-- Sort inicial: Nome (Column3) marcado com cor de destaque teal
147:         *-- Espelha comportamento do Header.Click original (RGB 64,128,128)
148:         loc_oGrid.Column1.Header1.BackColor = RGB(192, 192, 192)
149:         loc_oGrid.Column2.Header1.BackColor = RGB(192, 192, 192)
150:         loc_oGrid.Column3.Header1.BackColor = RGB(64, 128, 128)
151:         loc_oGrid.Column4.Header1.BackColor = RGB(192, 192, 192)
152:         loc_oGrid.Column5.Header1.BackColor = RGB(192, 192, 192)
153: 
154:         *-- Alinhamento do header do checkbox (centralizado)
155:         loc_oGrid.Column1.Header1.Alignment = 2
156: 
157:         *-- Modo somente-leitura no grid inteiro exceto checkbox
158:         loc_oGrid.Column2.ReadOnly = .T.
159:         loc_oGrid.Column3.ReadOnly = .T.
160:         loc_oGrid.Column5.ReadOnly = .T.
161: 
162:         RETURN .T.
163:     ENDPROC
164: 
165:     *--------------------------------------------------------------------------
166:     * ConfigurarPaginaLista - Cria grid principal e botoes auxiliares
167:     * Layout original:
168:     *   grade: Top=126, Left=3, Width=993, Height=469, ColumnCount=5
169:     *   Column5(ordem 1) = CheckBox, Width=17
170:     *   Column1(ordem 2) = Conta,    Width=80
171:     *   Column2(ordem 3) = Nome,     Width=290
172:     *   Column3(ordem 4) = Email,    Width=290
173:     *   Column4(ordem 5) = Mensagem, Width=290
174:     *   SelTudo: Top=84, Left=4,  W=40, H=40, Picture=geral_marcar_26.jpg
175:     *   apaga:   Top=84, Left=43, W=40, H=40, Picture=cadastro_excluir_26.jpg
176:     *   btnEmail:Top=3,  Left=850,W=75, H=75, Picture=geral_envelope_60.jpg
177:     *--------------------------------------------------------------------------
178:     PROTECTED PROCEDURE ConfigurarPaginaLista()
179:         LOCAL loc_oGrid, loc_oCol
180: 
181:         *-- Grid principal
182:         THIS.AddObject("grd_4c_Dados", "Grid")
183:         loc_oGrid = THIS.grd_4c_Dados
184:         WITH loc_oGrid
185:             .Top              = 126
186:             .Left             = 3
187:             .Width            = 993
188:             .Height           = 469
189:             .ColumnCount      = 5
190:             .FontName         = "Verdana"
191:             .FontSize         = 8
192:             .RecordMark       = .F.
193:             .DeleteMark       = .F.
194:             .RowHeight        = 18
195:             .GridLines        = 1
196:             .GridLineColor    = RGB(238, 238, 238)
197:             .HighlightBackColor = RGB(255, 255, 255)
198:             .HighlightForeColor = RGB(15, 41, 104)
199:             .HighlightStyle   = 2
200:             .ScrollBars       = 2
201:             .RecordSource     = "cursor_4c_Dados"
202:             .Visible          = .T.
203: 
204:             *-- Coluna 1: CheckBox (selecao)
205:             WITH .Column1
206:                 .Width         = 17
207:                 .ColumnOrder   = 1
208:                 .ReadOnly      = .F.
209:                 .Sparse        = .F.
210:                 .FontName      = "Verdana"
211:                 .FontSize      = 8
212:                 .AddObject("Check1", "CheckBox")
213:                 WITH .Check1
214:                     .Caption   = ""
215:                     .Value     = 0
216:                     .Visible   = .T.
217:                 ENDWITH
218:                 .CurrentControl  = "Check1"

*-- Linhas 334 a 528:
334:         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.EmpDopNums"
335: 
336:         *-- Handlers de Click nos headers para ordenacao (ordem original do legado)
337:         BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GrdHeader2Click")
338:         BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "GrdHeader3Click")
339:         BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "GrdHeader4Click")
340: 
341:         *-- Handler de InteractiveChange no CheckBox para atualizar cursor
342:         BINDEVENT(loc_oGrid.Column1.Check1, "InteractiveChange", THIS, "ChkSelChange")
343: 
344:         *-- Botao SelTudo (Marcar Todos)
345:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
346:         WITH THIS.cmd_4c_SelTudo
347:             .Top          = 84
348:             .Left         = 4
349:             .Height       = 40
350:             .Width        = 40
351:             .FontName     = "Verdana"
352:             .FontSize     = 8
353:             .WordWrap     = .T.
354:             .Caption      = ""
355:             .ToolTipText  = "Marcar Todos"
356:             .ForeColor    = RGB(36, 84, 155)
357:             .BackColor    = RGB(255, 255, 255)
358:             .Themes       = .T.
359:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
360:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
361:             .TabStop      = .F.
362:             .Visible      = .T.
363:         ENDWITH
364:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
365: 
366:         *-- Botao apaga (Desmarcar Todos)
367:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
368:         WITH THIS.cmd_4c_Apaga
369:             .Top          = 84
370:             .Left         = 43
371:             .Height       = 40
372:             .Width        = 40
373:             .FontName     = "Verdana"
374:             .FontSize     = 8
375:             .WordWrap     = .T.
376:             .Caption      = ""
377:             .ToolTipText  = "Desmarcar Todos"
378:             .ForeColor    = RGB(36, 84, 155)
379:             .BackColor    = RGB(255, 255, 255)
380:             .Themes       = .T.
381:             .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
382:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
383:             .TabStop      = .F.
384:             .Visible      = .T.
385:         ENDWITH
386:         BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
387: 
388:         *-- Botao Enviar Email
389:         THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
390:         WITH THIS.cmd_4c_BtnEmail
391:             .Top          = 3
392:             .Left         = 850
393:             .Height       = 75
394:             .Width        = 75
395:             .FontBold     = .T.
396:             .FontItalic   = .T.
397:             .FontName     = "Tahoma"
398:             .FontSize     = 8
399:             .Caption      = "Enviar Email"
400:             .ToolTipText  = "Enviar Email"
401:             .ForeColor    = RGB(90, 90, 90)
402:             .BackColor    = RGB(255, 255, 255)
403:             .Themes       = .T.
404:             .Picture      = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
405:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
406:             .Visible      = .T.
407:         ENDWITH
408:         BINDEVENT(THIS.cmd_4c_BtnEmail, "Click", THIS, "CmdBtnEmailClick")
409:     ENDPROC
410: 
411:     *--------------------------------------------------------------------------
412:     * GrdHeader2Click - Ordena grid pela coluna Conta
413:     *--------------------------------------------------------------------------
414:     PROCEDURE GrdHeader2Click()
415:         SELECT cursor_4c_Dados
416:         SET ORDER TO TAG Contas
417:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
418:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
419:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
420:         THIS.grd_4c_Dados.Refresh()
421:     ENDPROC
422: 
423:     *--------------------------------------------------------------------------
424:     * GrdHeader3Click - Ordena grid pela coluna Nome
425:     *--------------------------------------------------------------------------
426:     PROCEDURE GrdHeader3Click()
427:         SELECT cursor_4c_Dados
428:         SET ORDER TO TAG Rclis
429:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
430:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
431:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
432:         THIS.grd_4c_Dados.Refresh()
433:     ENDPROC
434: 
435:     *--------------------------------------------------------------------------
436:     * GrdHeader4Click - Ordena grid pela coluna Email
437:     *--------------------------------------------------------------------------
438:     PROCEDURE GrdHeader4Click()
439:         SELECT cursor_4c_Dados
440:         SET ORDER TO TAG Emails
441:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
442:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
443:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
444:         THIS.grd_4c_Dados.Refresh()
445:     ENDPROC
446: 
447:     *--------------------------------------------------------------------------
448:     * ChkSelChange - Atualiza campo Checks no cursor quando CheckBox muda
449:     *--------------------------------------------------------------------------
450:     PROCEDURE ChkSelChange()
451:         LOCAL loc_oChk
452:         loc_oChk = THIS.grd_4c_Dados.Column1.Check1
453:         IF USED("cursor_4c_Dados")
454:             SELECT cursor_4c_Dados
455:             REPLACE Checks WITH loc_oChk.Value IN cursor_4c_Dados
456:         ENDIF
457:     ENDPROC
458: 
459:     *--------------------------------------------------------------------------
460:     * CmdSelTudoClick - Marca todos os registros
461:     *--------------------------------------------------------------------------
462:     PROCEDURE CmdSelTudoClick()
463:         IF USED("cursor_4c_Dados")
464:             SELECT cursor_4c_Dados
465:             GO TOP
466:             REPLACE ALL Checks WITH 1
467:             GO TOP
468:         ENDIF
469:         THIS.grd_4c_Dados.Refresh()
470:     ENDPROC
471: 
472:     *--------------------------------------------------------------------------
473:     * CmdApagaClick - Desmarca todos os registros
474:     *--------------------------------------------------------------------------
475:     PROCEDURE CmdApagaClick()
476:         IF USED("cursor_4c_Dados")
477:             SELECT cursor_4c_Dados
478:             GO TOP
479:             REPLACE ALL Checks WITH 0
480:             GO TOP
481:         ENDIF
482:         THIS.grd_4c_Dados.Refresh()
483:     ENDPROC
484: 
485:     *--------------------------------------------------------------------------
486:     * ConfigurarCabecalho - Cria container de cabecalho superior
487:     *--------------------------------------------------------------------------
488:     PROTECTED PROCEDURE ConfigurarCabecalho()
489:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
490:         WITH THIS.cnt_4c_Cabecalho
491:             .Top         = 0
492:             .Left        = 0
493:             .Width       = THIS.Width
494:             .Height      = 80
495:             .BorderWidth = 0
496:             .BackStyle   = 1
497:             .BackColor   = RGB(100, 100, 100)
498:             .Visible     = .T.
499: 
500:             .AddObject("lbl_4c_Sombra", "Label")
501:             WITH .lbl_4c_Sombra
502:                 .Top      = 18
503:                 .Left     = 10
504:                 .Width    = THIS.Width
505:                 .Height   = 40
506:                 .AutoSize = .F.
507:                 .FontName = "Tahoma"
508:                 .FontSize = 18
509:                 .FontBold = .T.
510:                 .BackStyle = 0
511:                 .ForeColor = RGB(0, 0, 0)
512:                 .WordWrap  = .T.
513:                 .Alignment = 0
514:                 .Caption   = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
515:                 .Visible   = .T.
516:             ENDWITH
517: 
518:             .AddObject("lbl_4c_Titulo", "Label")
519:             WITH .lbl_4c_Titulo
520:                 .Top         = 17
521:                 .Left        = 10
522:                 .Width       = THIS.Width
523:                 .Height      = 46
524:                 .AutoSize    = .F.
525:                 .FontName    = "Tahoma"
526:                 .FontSize    = 18
527:                 .FontBold    = .T.
528:                 .BackStyle   = 0

*-- Linhas 539 a 740:
539:     *--------------------------------------------------------------------------
540:     * ConfigurarShape1 - Cria elemento decorativo ao redor do botao Email
541:     *--------------------------------------------------------------------------
542:     PROTECTED PROCEDURE ConfigurarShape1()
543:         THIS.AddObject("shp_4c_Shape1", "Shape")
544:         WITH THIS.shp_4c_Shape1
545:             .Top          = 7
546:             .Left         = 804
547:             .Height       = 110
548:             .Width        = 90
549:             .BackStyle    = 0
550:             .BorderStyle  = 0
551:             .BorderWidth  = 1
552:             .SpecialEffect = 1
553:             .BorderColor  = RGB(136, 189, 188)
554:             .Visible      = .T.
555:         ENDWITH
556:     ENDPROC
557: 
558:     *--------------------------------------------------------------------------
559:     * ConfigurarSaida - Cria CommandGroup com botao Encerrar (canonico original)
560:     *--------------------------------------------------------------------------
561:     PROTECTED PROCEDURE ConfigurarSaida()
562:         THIS.AddObject("cmg_4c_Saida", "CommandGroup")
563:         WITH THIS.cmg_4c_Saida
564:             .Top           = -2
565:             .Left          = 920
566:             .Width         = 85
567:             .Height        = 85
568:             .ButtonCount   = 1
569:             .BackStyle     = 0
570:             .BorderStyle   = 0
571:             .SpecialEffect = 1
572:             .BorderColor   = RGB(136, 189, 188)
573:             .Themes        = .F.
574:             .Visible       = .T.
575: 
576:             WITH .Buttons(1)
577:                 .Top         = 5
578:                 .Left        = 5
579:                 .Height      = 75
580:                 .Width       = 75
581:                 .FontBold    = .T.
582:                 .FontItalic  = .T.
583:                 .Caption     = "Encerrar"
584:                 .ToolTipText = "[Esc] Encerrar"
585:                 .ForeColor   = RGB(90, 90, 90)
586:                 .BackColor   = RGB(255, 255, 255)
587:                 .Themes      = .F.
588:                 .Cancel      = .T.
589:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
590:             ENDWITH
591:         ENDWITH
592: 
593:         BINDEVENT(THIS.cmg_4c_Saida, "Click", THIS, "CmdEncerrarClick")
594:     ENDPROC
595: 
596:     *--------------------------------------------------------------------------
597:     * CmdEncerrarClick - Fecha o formulario
598:     *--------------------------------------------------------------------------
599:     PROCEDURE CmdEncerrarClick()
600:         THIS.Release()
601:     ENDPROC
602: 
603:     *--------------------------------------------------------------------------
604:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
605:     *--------------------------------------------------------------------------
606:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
607:         LOCAL loc_nI, loc_oControl, loc_nP
608:         FOR loc_nI = 1 TO par_oContainer.ControlCount
609:             loc_oControl = par_oContainer.Controls(loc_nI)
610:             IF VARTYPE(loc_oControl) = "O"
611:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
612:                     loc_oControl.Visible = .T.
613:                 ENDIF
614:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
615:                     FOR loc_nP = 1 TO loc_oControl.PageCount
616:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
617:                     ENDFOR
618:                 ENDIF
619:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
620:                    loc_oControl.ControlCount > 0
621:                     THIS.TornarControlesVisiveis(loc_oControl)
622:                 ENDIF
623:             ENDIF
624:         ENDFOR
625:     ENDPROC
626: 
627:     *--------------------------------------------------------------------------
628:     * CarregarDados - Carrega movimentos do dia (ou EmpDopNums especifico) via BO
629:     * Popula cursor_4c_Dados para o grid e trata modo automatico
630:     *--------------------------------------------------------------------------
631:     PROCEDURE CarregarDados()
632:         LOCAL loc_lResultado, loc_oErro
633:         loc_lResultado = .F.
634: 
635:         TRY
636:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
637:                 loc_lResultado = .T.
638:             ENDIF
639: 
640:             loc_lResultado = THIS.this_oBusinessObject.CarregarListaEmail(THIS.this_cDopes)
641: 
642:             IF loc_lResultado AND USED("cursor_4c_Local")
643:                 *-- Migra dados para cursor do grid (ZAP+APPEND preserva estrutura de colunas)
644:                 SELECT cursor_4c_Dados
645:                 ZAP
646:                 APPEND FROM DBF("cursor_4c_Local")
647:                 IF USED("cursor_4c_Local")
648:                     USE IN cursor_4c_Local
649:                 ENDIF
650: 
651:                 *-- Ordena por Nome (comportamento padrao do original)
652:                 SELECT cursor_4c_Dados
653:                 SET ORDER TO TAG Rclis
654: 
655:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
656:                     THIS.grd_4c_Dados.Refresh()
657:                 ENDIF
658:             ENDIF
659: 
660:             *-- Modo automatico: envia email imediatamente sem interacao
661:             IF THIS.this_lAutomatico
662:                 THIS.CmdBtnEmailClick()
663:             ENDIF
664: 
665:         CATCH TO loc_oErro
666:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
667:                     "Erro ao carregar dados para email")
668:             loc_lResultado = .F.
669:         ENDTRY
670: 
671:         RETURN loc_lResultado
672:     ENDPROC
673: 
674:     *--------------------------------------------------------------------------
675:     * CmdBtnEmailClick - Envia email para registros marcados (Checks=1)
676:     * Logica original: btnEmail.Click
677:     *--------------------------------------------------------------------------
678:     PROCEDURE CmdBtnEmailClick()
679:         LOCAL loc_lSucesso, loc_lOk, loc_oErro
680:         LOCAL loc_cReceptor, loc_cReceptorCopia, loc_cAssunto
681:         LOCAL loc_cTxtMensagem, loc_cArqAnexo
682:         LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cEdn
683:         LOCAL loc_cFrom, loc_cServer, loc_cSenha, loc_nPorta
684:         LOCAL loc_cSQL
685: 
686:         loc_lOk              = .T.
687:         loc_cReceptor        = ""
688:         loc_cReceptorCopia   = ""
689:         loc_cAssunto         = ""
690:         loc_cTxtMensagem     = ""
691:         loc_cArqAnexo        = ""
692: 
693:         *-- Seleciona apenas registros marcados
694:         IF USED("cursor_4c_Local2")
695:             USE IN cursor_4c_Local2
696:         ENDIF
697:         SELECT * FROM cursor_4c_Dados WHERE Checks = 1 INTO CURSOR cursor_4c_Local2 READWRITE
698: 
699:         IF !USED("cursor_4c_Local2") OR RECCOUNT("cursor_4c_Local2") < 1
700:             MsgAviso("Nenhum registro marcado para envio de email.", "Aviso")
701:             RETURN
702:         ENDIF
703: 
704:         SELECT cursor_4c_Local2
705:         GO TOP
706:         SCAN
707:             IF EMPTY(cursor_4c_Local2.emails)
708:                 LOOP
709:             ENDIF
710: 
711:             SELECT cursor_4c_Local2
712:             loc_cEmps   = SUBSTR(cursor_4c_Local2.EmpDopNums, 1, 3)
713:             loc_cDopes  = ALLTRIM(SUBSTR(cursor_4c_Local2.EmpDopNums, 4, 20))
714:             loc_nNumes  = VAL(SUBSTR(cursor_4c_Local2.EmpDopNums, 24, 6))
715:             loc_cEdn    = ALLTRIM(cursor_4c_Local2.EmpDopNums)
716: 
717:             IF RECNO("cursor_4c_Local2") = 1
718:                 loc_cReceptor      = ALLTRIM(cursor_4c_Local2.emails)
719:                 loc_cTxtMensagem   = ""
720:                 loc_cAssunto       = ""
721:             ELSE
722:                 IF !EMPTY(ALLTRIM(cursor_4c_Local2.emails))
723:                     loc_cReceptorCopia = loc_cReceptorCopia + ;
724:                         IIF(EMPTY(loc_cReceptorCopia), "", ",") + ;
725:                         ALLTRIM(cursor_4c_Local2.emails)
726:                 ENDIF
727:             ENDIF
728: 
729:             *-- Remove PDF anterior se existir
730:             IF FILE(ADDBS(SYS(2023)) + "FORTYUSPDF.PDF")
731:                 DELETE FILE ADDBS(SYS(2023)) + "FORTYUSPDF.PDF"
732:             ENDIF
733: 
734:             *-- Gera impressao/PDF do documento
735:             loc_lOk = THIS.ImprimirDocumento(loc_cEdn)
736: 
737:             IF loc_lOk
738:                 loc_cArqAnexo = THIS.this_cArqEmail
739:             ENDIF
740: 

*-- Linhas 1007 a 1240:
1007:         loc_lEnvioOk = .T.
1008: 
1009:         TRY
1010:             loc_oEmail = CREATEOBJECT("CDO.Message")
1011:             IF VARTYPE(loc_oEmail) != "O"
1012:                 MsgAviso("Problemas ao instanciar CDO.Message para envio de email.", "Aviso")
1013:                 loc_lEnvioOk = .F.
1014:             ENDIF
1015: 
1016:             IF loc_lEnvioOk
1017:                 WITH loc_oEmail.Configuration.Fields
1018:                     .Item("http://schemas.microsoft.com/cdo/configuration/sendusing")              = 2
1019:                     .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")             = LOWER(ALLTRIM(par_cSmtpServer))
1020:                     .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout")  = 10
1021:                     .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport")         = IIF(par_nSmtpPort = 0, 25, par_nSmtpPort)
1022:                     .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")       = 1
1023:                     .Item("http://schemas.microsoft.com/cdo/configuration/sendusername")           = LOWER(ALLTRIM(par_cSendUser))
1024:                     .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword")           = par_cSendPass
1025:                     .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl")             = IIF(par_nSmtpPort = 465, 1, 0)
1026:                     .Update()
1027:                 ENDWITH
1028: 
1029:                 WITH loc_oEmail
1030:                     .To        = LOWER(ALLTRIM(par_cTo))
1031:                     .Cc        = LOWER(NVL(par_cCC, ""))
1032:                     .From      = LOWER(ALLTRIM(par_cFrom))
1033:                     .Subject   = ALLTRIM(par_cAssunto)
1034:                     .TextBody  = ALLTRIM(par_cCorpo)
1035: 
1036:                     IF !ISNULL(par_cAnexo) AND !EMPTY(ALLTRIM(par_cAnexo))
1037:                         IF FILE(ALLTRIM(par_cAnexo))
1038:                             .AddAttachment(ALLTRIM(par_cAnexo))
1039:                         ELSE
1040:                             loc_lEnvioOk = .F.
1041:                             MsgAviso("Arquivo anexo n" + CHR(227) + "o encontrado:" + CHR(13) + ;
1042:                                      ALLTRIM(par_cAnexo), "Aviso")
1043:                         ENDIF
1044:                     ENDIF
1045: 
1046:                     IF loc_lEnvioOk
1047:                         LOCAL loc_oErroEnvio
1048:                         TRY
1049:                             .Send()
1050:                             loc_lOk = .T.
1051:                         CATCH TO loc_oErroEnvio
1052:                             WAIT WINDOW "Dados do e-mail inv" + CHR(225) + "lidos." TIMEOUT 5
1053:                             loc_lOk = .F.
1054:                         ENDTRY
1055:                     ENDIF
1056:                 ENDWITH
1057:             ENDIF
1058: 
1059:         CATCH TO loc_oErro
1060:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro EnviarEmail")
1061:             loc_lOk = .F.
1062:         ENDTRY
1063: 
1064:         loc_oEmail = .NULL.
1065:         RETURN loc_lOk
1066:     ENDFUNC
1067: 
1068:     *--------------------------------------------------------------------------
1069:     * GravarLog - Registra envio no log do sistema (sigoplog)
1070:     * Adaptado de: fGravarLog('T', SIGPREMA, '', EmpDopNums)
1071:     *--------------------------------------------------------------------------
1072:     PROCEDURE GravarLog(par_cEmpDopNums)
1073:         LOCAL loc_lSucesso, loc_cSQL, loc_oErro
1074:         loc_lSucesso = .F.
1075: 
1076:         TRY
1077:             loc_cSQL = "INSERT INTO SigOpLog (Progs, Transacaos, Datas, Horas) " + ;
1078:                        "VALUES (" + EscaparSQL("SIGPREMA") + ", " + ;
1079:                        EscaparSQL(ALLTRIM(par_cEmpDopNums)) + ", " + ;
1080:                        FormatarDataSQL(DATE()) + ", " + ;
1081:                        EscaparSQL(TIME()) + ")"
1082:             IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
1083:                 loc_lSucesso = .T.
1084:             ENDIF
1085:         CATCH TO loc_oErro
1086:             *-- Falha no log nao impede o fluxo principal
1087:         ENDTRY
1088:     ENDPROC
1089: 
1090:     *--------------------------------------------------------------------------
1091:     * BtnIncluirClick - Form OPERACIONAL nao tem fluxo de inclusao CRUD
1092:     * FormBase declara este metodo; retorna .F. para indicar nao-suporte
1093:     *--------------------------------------------------------------------------
1094:     PROCEDURE BtnIncluirClick()
1095:         RETURN .F.
1096:     ENDPROC
1097: 
1098:     *--------------------------------------------------------------------------
1099:     * BtnAlterarClick - Form OPERACIONAL nao tem fluxo de alteracao CRUD
1100:     *--------------------------------------------------------------------------
1101:     PROCEDURE BtnAlterarClick()
1102:         RETURN .F.
1103:     ENDPROC
1104: 
1105:     *--------------------------------------------------------------------------
1106:     * BtnVisualizarClick - Form OPERACIONAL nao tem fluxo de visualizacao CRUD
1107:     *--------------------------------------------------------------------------
1108:     PROCEDURE BtnVisualizarClick()
1109:         RETURN .F.
1110:     ENDPROC
1111: 
1112:     *--------------------------------------------------------------------------
1113:     * BtnExcluirClick - Form OPERACIONAL nao tem fluxo de exclusao CRUD
1114:     *--------------------------------------------------------------------------
1115:     PROCEDURE BtnExcluirClick()
1116:         RETURN .F.
1117:     ENDPROC
1118: 
1119:     *--------------------------------------------------------------------------
1120:     * Destroy - Libera recursos ao fechar o form
1121:     *--------------------------------------------------------------------------
1122:     PROCEDURE Destroy()
1123:         IF USED("cursor_4c_Dados")
1124:             USE IN cursor_4c_Dados
1125:         ENDIF
1126:         IF USED("cursor_4c_Local")
1127:             USE IN cursor_4c_Local
1128:         ENDIF
1129:         IF USED("cursor_4c_Local2")
1130:             USE IN cursor_4c_Local2
1131:         ENDIF
1132:         IF USED("cursor_4c_MvCab")
1133:             USE IN cursor_4c_MvCab
1134:         ENDIF
1135:         IF USED("cursor_4c_Ope")
1136:             USE IN cursor_4c_Ope
1137:         ENDIF
1138:         IF USED("cursor_4c_OpCdc")
1139:             USE IN cursor_4c_OpCdc
1140:         ENDIF
1141:         IF USED("cursor_4c_OpCdi")
1142:             USE IN cursor_4c_OpCdi
1143:         ENDIF
1144:         IF USED("cursor_4c_OpCdd")
1145:             USE IN cursor_4c_OpCdd
1146:         ENDIF
1147:         IF USED("cursor_4c_MvCabEst")
1148:             USE IN cursor_4c_MvCabEst
1149:         ENDIF
1150:         IF USED("cursor_4c_OpeEst")
1151:             USE IN cursor_4c_OpeEst
1152:         ENDIF
1153:         IF USED("cursor_4c_OpCdcEst")
1154:             USE IN cursor_4c_OpCdcEst
1155:         ENDIF
1156:         IF USED("cursor_4c_EmpMail")
1157:             USE IN cursor_4c_EmpMail
1158:         ENDIF
1159:         THIS.this_oPdf             = .NULL.
1160:         THIS.this_oBusinessObject  = .NULL.
1161:         DODEFAULT()
1162:     ENDPROC
1163: 
1164:     *--------------------------------------------------------------------------
1165:     * BtnBuscarClick - Form OPERACIONAL: sem busca CRUD
1166:     *--------------------------------------------------------------------------
1167:     PROCEDURE BtnBuscarClick()
1168:         RETURN .F.
1169:     ENDPROC
1170: 
1171:     *--------------------------------------------------------------------------
1172:     * BtnEncerrarClick - Encerra o formulario (compatibilidade FormBase)
1173:     *--------------------------------------------------------------------------
1174:     PROCEDURE BtnEncerrarClick()
1175:         THIS.Release()
1176:     ENDPROC
1177: 
1178:     *--------------------------------------------------------------------------
1179:     * BtnSalvarClick - Form OPERACIONAL: sem salvamento CRUD
1180:     *--------------------------------------------------------------------------
1181:     PROCEDURE BtnSalvarClick()
1182:         RETURN .F.
1183:     ENDPROC
1184: 
1185:     *--------------------------------------------------------------------------
1186:     * BtnCancelarClick - Form OPERACIONAL: sem cancelamento CRUD
1187:     *--------------------------------------------------------------------------
1188:     PROCEDURE BtnCancelarClick()
1189:         RETURN .F.
1190:     ENDPROC
1191: 
1192:     *--------------------------------------------------------------------------
1193:     * FormParaBO - Form OPERACIONAL: sem mapeamento campo->propriedade BO
1194:     *--------------------------------------------------------------------------
1195:     PROCEDURE FormParaBO()
1196:         RETURN .F.
1197:     ENDPROC
1198: 
1199:     *--------------------------------------------------------------------------
1200:     * BOParaForm - Form OPERACIONAL: sem mapeamento propriedade BO->campo
1201:     *--------------------------------------------------------------------------
1202:     PROCEDURE BOParaForm()
1203:         RETURN .F.
1204:     ENDPROC
1205: 
1206:     *--------------------------------------------------------------------------
1207:     * HabilitarCampos - Form OPERACIONAL: sem controle de habilitacao por modo CRUD
1208:     *--------------------------------------------------------------------------
1209:     PROCEDURE HabilitarCampos(par_lHabilitar)
1210:         RETURN
1211:     ENDPROC
1212: 
1213:     *--------------------------------------------------------------------------
1214:     * LimparCampos - Zera cursor de dados e atualiza grid
1215:     *--------------------------------------------------------------------------
1216:     PROCEDURE LimparCampos()
1217:         IF USED("cursor_4c_Dados")
1218:             SELECT cursor_4c_Dados
1219:             ZAP
1220:         ENDIF
1221:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1222:             THIS.grd_4c_Dados.Refresh()
1223:         ENDIF
1224:     ENDPROC
1225: 
1226:     *--------------------------------------------------------------------------
1227:     * CarregarLista - Delega para CarregarDados (padrao operacional)
1228:     *--------------------------------------------------------------------------
1229:     PROCEDURE CarregarLista()
1230:         RETURN THIS.CarregarDados()
1231:     ENDPROC
1232: 
1233:     *--------------------------------------------------------------------------
1234:     * AjustarBotoesPorModo - Form OPERACIONAL: sem modos CRUD para ajustar
1235:     *--------------------------------------------------------------------------
1236:     PROCEDURE AjustarBotoesPorModo()
1237:         RETURN
1238:     ENDPROC
1239: 
1240: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigpremaBO.prg):
*==============================================================================
* sigpremaBO.prg - Business Object: Processamento e Geracao de Email
* Herda de: BusinessBase
* Form: Formsigprema.prg (OPERACIONAL)
*==============================================================================

DEFINE CLASS sigpremaBO AS BusinessBase

    *-- Parametros de entrada do processo
    this_cEmpDopNums = ""    && Identificador completo do movimento (Emps+Dopes+Numes C29)
    this_cEmps       = ""    && Codigo da empresa (3 chars)
    this_cDopes      = ""    && Tipo de operacao (chars 4-23)
    this_nNumes      = 0     && Numero do movimento (chars 24-29)
    this_lAutomatico = .F.   && Modo automatico: processa e encerra sem interacao

    *-- Estado do processo de email
    this_cArqEmail   = ""    && Caminho do arquivo PDF gerado para anexo
    this_cEscolha    = ""    && Escolha de operacao retornada pelo ImpDocto

    *-- Configuracoes de email extraidas de SigCdEmp
    this_cPadEmails  = ""    && Email remetente (PadEmails)
    this_cPadServs   = ""    && Servidor SMTP (PadServs)
    this_cPadSenhas  = ""    && Senha SMTP (PadSenhas)
    this_nPadPortas  = 0     && Porta SMTP (PadPortas)

    *-- Estado da disponibilidade do PDFCreator
    this_lEmailAtivo = .F.   && .T. se PDFCreator esta registrado no sistema

    *-- Propriedades da linha do cursor (para CarregarDoCursor)
    this_cContas     = ""    && Codigo da conta/cliente (Iclis)
    this_cRclis      = ""    && Nome do cliente/conta (Rclis)
    this_cEmails     = ""    && Endereco de email
    this_cGrupos     = ""    && Grupo do cliente
    this_cMensagems  = ""    && Corpo da mensagem
    this_cPrioridade = ""    && Prioridade (NORMAL/etc)
    this_nChecks     = 0     && Flag de selecao para envio (0=nao, 1=sim)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
    *--------------------------------------------------------------------------
        THIS.this_cTabela     = "SigMvCab"
        THIS.this_cCampoChave = "EmpDopNums"
        DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nChecks     = TratarNulo(Checks, "N")
            THIS.this_cGrupos     = TratarNulo(grupos, "C")
            THIS.this_cContas     = TratarNulo(Contas, "C")
            THIS.this_cRclis      = TratarNulo(Rclis, "C")
            THIS.this_cEmails     = TratarNulo(emails, "C")
            THIS.this_cMensagems  = TratarNulo(mensagems, "C")
            THIS.this_cEmpDopNums = TratarNulo(EmpDopNums, "C")
            THIS.this_cPrioridade = TratarNulo(prioridade, "C")
            THIS.this_cEmps       = SUBSTR(THIS.this_cEmpDopNums, 1, 3)
            THIS.this_cDopes      = SUBSTR(THIS.this_cEmpDopNums, 4, 20)
            THIS.this_nNumes      = VAL(SUBSTR(THIS.this_cEmpDopNums, 24, 6))
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarListaEmail - Carrega cursor_4c_Local com movimentos para envio
    * par_cDopes: EmpDopNums do movimento especifico (vazio = todos do dia)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarListaEmail(par_cDopes)
        LOCAL loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Local")
                USE IN cursor_4c_Local
            ENDIF

            SET NULL ON
            CREATE CURSOR cursor_4c_Local (;
                Checks     N(1)    NULL,;
                grupos     C(10)   NULL,;
                Contas     C(10)   NULL,;
                Rclis      C(30)   NULL,;
                emails     C(50)   NULL,;
                mensagems  M,;
                EmpDopNums C(29)   NULL,;
                prioridade C(15)   NULL;
            )
            SET NULL OFF
            INDEX ON Contas     TAG Contas
            INDEX ON Rclis      TAG Rclis
            INDEX ON emails     TAG Emails

            *-- Carrega movimentos: especifico ou todos do dia sem log
            IF EMPTY(par_cDopes)
                loc_cQuery = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, " + ;
                             "b.Rclis, b.Rclis AS Rclis2, b.emails, b.grupos, b.iclis " + ;
                             "FROM SigMvCab a " + ;
                             "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                             "WHERE CONVERT(date, a.datatrans) = CONVERT(date, GETDATE()) " + ;
                             "AND a.EmpDopNums NOT IN (" + ;
                             "  SELECT transacaos FROM SigOpLog WHERE progs = 'SIGPREMA'" + ;
                             ") " + ;
                             "ORDER BY a.EmpDopNums"
            ELSE
                loc_cQuery = "SELECT 1 AS Checks, a.EmpDopNums, a.Jobs, " + ;
                             "b.Rclis, b.Rclis AS Rclis2, b.emails, b.grupos, b.iclis " + ;
                             "FROM SigMvCab a " + ;
                             "INNER JOIN SigCdCli b ON a.Contads = b.Iclis " + ;
                             "WHERE a.EmpDopNums = " + EscaparSQL(par_cDopes)
            ENDIF

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_MvTemp") < 1
                MsgErro("Falha ao carregar movimentos para email.", "Erro")
                loc_lSucesso = .F.
            ENDIF

            SELECT cursor_4c_MvTemp
            SCAN
                INSERT INTO cursor_4c_Local ;
                    (Checks, grupos, Contas, Rclis, emails, prioridade, EmpDopNums) ;
                    VALUES (cursor_4c_MvTemp.Checks, cursor_4c_MvTemp.grupos, ;
                            cursor_4c_MvTemp.iclis, cursor_4c_MvTemp.Rclis, ;
                            cursor_4c_MvTemp.emails, "NORMAL", cursor_4c_MvTemp.EmpDopNums)
            ENDSCAN
            IF USED("cursor_4c_MvTemp")
                USE IN cursor_4c_MvTemp
            ENDIF

            *-- Carrega clientes do grupo PAM (SigCdPam)
            loc_cQuery = "SELECT 0 AS Checks, c.grupos, c.iclis AS Contas, " + ;
                         "c.rclis, c.emails, '' AS prioridade " + ;
                         "FROM SigCdPam p " + ;
                         "INNER JOIN SigCdCli c ON c.grupos = p.grpadats"

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_PamTemp") >= 1
                SELECT cursor_4c_PamTemp
                SCAN
                    LOCAL loc_cJobQuery, loc_cContasPam, loc_cRclisPam, loc_cEmailsPam
                    loc_cContasPam = cursor_4c_PamTemp.Contas
                    loc_cRclisPam  = cursor_4c_PamTemp.Rclis
                    loc_cEmailsPam = cursor_4c_PamTemp.emails

                    *-- Verifica se cliente tem job associado ao movimento
                    loc_cJobQuery = "SELECT Jobs FROM SigClJob WHERE Iclis = " + ;
                                   EscaparSQL(loc_cContasPam)
                    IF SQLEXEC(gnConnHandle, loc_cJobQuery, "cursor_4c_JobTemp") >= 1
                        SELECT cursor_4c_JobTemp
                        GO TOP
                        IF !EOF()
                            *-- Insere apenas se nao existe ja no cursor
                            SELECT cursor_4c_Local
                            LOCATE FOR ALLTRIM(cursor_4c_Local.Contas) = ALLTRIM(loc_cContasPam) ;
                                    AND ALLTRIM(cursor_4c_Local.Rclis)  = ALLTRIM(loc_cRclisPam)
                            IF EOF()
                                INSERT INTO cursor_4c_Local ;
                                    (Checks, grupos, Contas, Rclis, emails, EmpDopNums, prioridade) ;
                                    VALUES (0, "", loc_cContasPam, loc_cRclisPam, ;
                                            loc_cEmailsPam, par_cDopes, "NORMAL")
                            ENDIF
                        ENDIF
                        IF USED("cursor_4c_JobTemp")
                            USE IN cursor_4c_JobTemp
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_PamTemp
                ENDSCAN
                IF USED("cursor_4c_PamTemp")
                    USE IN cursor_4c_PamTemp
                ENDIF
            ENDIF

            SELECT cursor_4c_Local
            GO TOP
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao carregar lista de email")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarConfigEmail - Carrega configuracoes SMTP de sigcdemp para this_*
    *--------------------------------------------------------------------------
    PROCEDURE BuscarConfigEmail()
        LOCAL loc_lSucesso, loc_cQuery
        loc_lSucesso = .F.

        TRY
            loc_cQuery = "SELECT pademails, padservs, padsenhas, padportas " + ;
                         "FROM sigcdemp WHERE cemps = " + EscaparSQL(go_4c_Sistema.cCodEmpresa)

            IF SQLEXEC(gnConnHandle, loc_cQuery, "cursor_4c_EmpEmail") >= 1
                SELECT cursor_4c_EmpEmail
                GO TOP
                IF !EOF()
                    THIS.this_cPadEmails = ALLTRIM(NVL(pademails, ""))
                    THIS.this_cPadServs  = ALLTRIM(NVL(padservs, ""))
                    THIS.this_cPadSenhas = ALLTRIM(NVL(padsenhas, ""))
                    THIS.this_nPadPortas = NVL(padportas, 0)
                    loc_lSucesso = .T.
                ENDIF
                IF USED("cursor_4c_EmpEmail")
                    USE IN cursor_4c_EmpEmail
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao buscar configura" + CHR(231) + CHR(227) + "o de email")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Registra envio de email no log de operacoes (SigOpLog)
    * Chamado apos cada email enviado com sucesso
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cEmpDopNums))
                MsgAviso("Identifica" + CHR(231) + CHR(227) + "o do movimento n" + ;
                         CHR(227) + "o informada.", "Aviso")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "INSERT INTO SigOpLog " + ;
                       "(usuaredes, datars, horas, progs, opers, usuasis, " + ;
                       " parametros, transacaos, cversaos, cidchaves, copias) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(LEFT(TIME(), 8)) + ", " + ;
                       "'SIGPREMA', 'T', " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "'', " + ;
                       EscaparSQL(ALLTRIM(THIS.this_cEmpDopNums)) + ", " + ;
                       "'', '', 0)"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao registrar log de envio de email.", "Erro")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
                    "Erro ao registrar email")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Nao aplicavel para este form operacional
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do movimento atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cEmpDopNums
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao na tabela LogAuditoria
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Usuario, Operacao, Tabela, ChaveRegistro, DataHora) " + ;
                       "VALUES (" + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       "'SigMvCab', " + ;
                       EscaparSQL(THIS.ObterChavePrimaria()) + ", " + ;
                       "GETDATE())"

            SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = .T.

        CATCH TO loc_oErro
            *-- Auditoria nao bloqueia operacao principal
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

