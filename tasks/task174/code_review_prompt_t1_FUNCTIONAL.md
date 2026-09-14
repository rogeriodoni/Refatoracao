# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (4)
- [METODO-INEXISTENTE] Metodo 'THIS.ImprimirDocumento()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [METODO-INEXISTENTE] Metodo 'THIS.EnviarEmail()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-HEADER] Header Caption ' Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Conta, Nome, Email, Movimentação de Estoque, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption ' Nome' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Conta, Nome, Email, Movimentação de Estoque, . Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\operacionais\Formsigprema.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1238 linhas total):

*-- Linhas 24 a 216:
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
84: 
85:                 THIS.TornarControlesVisiveis(THIS)
86: 
87:                 THIS.CarregarDados()
88: 
89:                 *-- Modo automatico: email ja foi enviado, impede exibicao do form
90:                 IF THIS.this_lAutomatico
91:                     loc_lSucesso = .F.
92:                 ENDIF
93: 
94:                 loc_lSucesso = .T.
95:             ELSE
96:                 MsgErro("Erro ao criar sigpremaBO.", "Erro")
97:             ENDIF
98: 
99:         CATCH TO loc_oErro
100:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo) + ;
101:                     " PROC=" + loc_oErro.Procedure, "Erro ao inicializar form")
102:             loc_lSucesso = .F.
103:         ENDTRY
104: 
105:         RETURN loc_lSucesso
106:     ENDPROC
107: 
108:     *--------------------------------------------------------------------------
109:     * ConfigurarPageFrame - Orquestra layout do form OPERACIONAL (flat)
110:     *--------------------------------------------------------------------------
111:     PROTECTED PROCEDURE ConfigurarPageFrame()
112:         THIS.ConfigurarCabecalho()
113:         THIS.ConfigurarSaida()
114:         THIS.ConfigurarShape1()
115:         THIS.ConfigurarPaginaLista()
116:         THIS.ConfigurarPaginaDados()
117:     ENDPROC
118: 
119:     *--------------------------------------------------------------------------
120:     * AlternarPagina - Form OPERACIONAL nao alterna paginas
121:     * Metodo existe por compatibilidade com FormBase (chamado por CancelarClick etc)
122:     *--------------------------------------------------------------------------
123:     PROCEDURE AlternarPagina(par_nPagina)
124:         RETURN .T.
125:     ENDPROC
126: 
127:     *--------------------------------------------------------------------------
128:     * ConfigurarPaginaDados - Configura area de exibicao/edicao dos dados
129:     * Form OPERACIONAL: nao ha "Page Dados" separada; area de dados eh o grid.
130:     * Este metodo finaliza a area de dados:
131:     *   1. Aplica sort visual inicial (coluna Nome/Rclis destacada em teal)
132:     *   2. Normaliza BackColor dos demais headers em cinza claro
133:     *   3. Ajusta alinhamento do header do checkbox
134:     *   4. Garante que o grid comece com valores default consistentes
135:     *--------------------------------------------------------------------------
136:     PROTECTED PROCEDURE ConfigurarPaginaDados()
137:         LOCAL loc_oGrid
138: 
139:         IF !PEMSTATUS(THIS, "grd_4c_Dados", 5)
140:             RETURN .F.
141:         ENDIF
142:         loc_oGrid = THIS.grd_4c_Dados
143: 
144:         *-- Sort inicial: Nome (Column3) marcado com cor de destaque teal
145:         *-- Espelha comportamento do Header.Click original (RGB 64,128,128)
146:         loc_oGrid.Column1.Header1.BackColor = RGB(192, 192, 192)
147:         loc_oGrid.Column2.Header1.BackColor = RGB(192, 192, 192)
148:         loc_oGrid.Column3.Header1.BackColor = RGB(64, 128, 128)
149:         loc_oGrid.Column4.Header1.BackColor = RGB(192, 192, 192)
150:         loc_oGrid.Column5.Header1.BackColor = RGB(192, 192, 192)
151: 
152:         *-- Alinhamento do header do checkbox (centralizado)
153:         loc_oGrid.Column1.Header1.Alignment = 2
154: 
155:         *-- Modo somente-leitura no grid inteiro exceto checkbox
156:         loc_oGrid.Column2.ReadOnly = .T.
157:         loc_oGrid.Column3.ReadOnly = .T.
158:         loc_oGrid.Column5.ReadOnly = .T.
159: 
160:         RETURN .T.
161:     ENDPROC
162: 
163:     *--------------------------------------------------------------------------
164:     * ConfigurarPaginaLista - Cria grid principal e botoes auxiliares
165:     * Layout original:
166:     *   grade: Top=126, Left=3, Width=993, Height=469, ColumnCount=5
167:     *   Column5(ordem 1) = CheckBox, Width=17
168:     *   Column1(ordem 2) = Conta,    Width=80
169:     *   Column2(ordem 3) = Nome,     Width=290
170:     *   Column3(ordem 4) = Email,    Width=290
171:     *   Column4(ordem 5) = Mensagem, Width=290
172:     *   SelTudo: Top=84, Left=4,  W=40, H=40, Picture=geral_marcar_26.jpg
173:     *   apaga:   Top=84, Left=43, W=40, H=40, Picture=cadastro_excluir_26.jpg
174:     *   btnEmail:Top=3,  Left=850,W=75, H=75, Picture=geral_envelope_60.jpg
175:     *--------------------------------------------------------------------------
176:     PROTECTED PROCEDURE ConfigurarPaginaLista()
177:         LOCAL loc_oGrid, loc_oCol
178: 
179:         *-- Grid principal
180:         THIS.AddObject("grd_4c_Dados", "Grid")
181:         loc_oGrid = THIS.grd_4c_Dados
182:         WITH loc_oGrid
183:             .Top              = 126
184:             .Left             = 3
185:             .Width            = 993
186:             .Height           = 469
187:             .ColumnCount      = 5
188:             .FontName         = "Verdana"
189:             .FontSize         = 8
190:             .RecordMark       = .F.
191:             .DeleteMark       = .F.
192:             .RowHeight        = 18
193:             .GridLines        = 1
194:             .GridLineColor    = RGB(238, 238, 238)
195:             .HighlightBackColor = RGB(255, 255, 255)
196:             .HighlightForeColor = RGB(15, 41, 104)
197:             .HighlightStyle   = 2
198:             .ScrollBars       = 2
199:             .RecordSource     = "cursor_4c_Dados"
200:             .Visible          = .T.
201: 
202:             *-- Coluna 1: CheckBox (selecao)
203:             WITH .Column1
204:                 .Width         = 17
205:                 .ColumnOrder   = 1
206:                 .ReadOnly      = .F.
207:                 .Sparse        = .F.
208:                 .FontName      = "Verdana"
209:                 .FontSize      = 8
210:                 .AddObject("Check1", "CheckBox")
211:                 WITH .Check1
212:                     .Caption   = ""
213:                     .Value     = 0
214:                     .Visible   = .T.
215:                 ENDWITH
216:                 .CurrentControl  = "Check1"

*-- Linhas 332 a 526:
332:         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.EmpDopNums"
333: 
334:         *-- Handlers de Click nos headers para ordenacao (ordem original do legado)
335:         BINDEVENT(loc_oGrid.Column2.Header1, "Click", THIS, "GrdHeader2Click")
336:         BINDEVENT(loc_oGrid.Column3.Header1, "Click", THIS, "GrdHeader3Click")
337:         BINDEVENT(loc_oGrid.Column4.Header1, "Click", THIS, "GrdHeader4Click")
338: 
339:         *-- Handler de InteractiveChange no CheckBox para atualizar cursor
340:         BINDEVENT(loc_oGrid.Column1.Check1, "InteractiveChange", THIS, "ChkSelChange")
341: 
342:         *-- Botao SelTudo (Marcar Todos)
343:         THIS.AddObject("cmd_4c_SelTudo", "CommandButton")
344:         WITH THIS.cmd_4c_SelTudo
345:             .Top          = 84
346:             .Left         = 4
347:             .Height       = 40
348:             .Width        = 40
349:             .FontName     = "Verdana"
350:             .FontSize     = 8
351:             .WordWrap     = .T.
352:             .Caption      = ""
353:             .ToolTipText  = "Marcar Todos"
354:             .ForeColor    = RGB(36, 84, 155)
355:             .BackColor    = RGB(255, 255, 255)
356:             .Themes       = .T.
357:             .Picture      = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
358:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
359:             .TabStop      = .F.
360:             .Visible      = .T.
361:         ENDWITH
362:         BINDEVENT(THIS.cmd_4c_SelTudo, "Click", THIS, "CmdSelTudoClick")
363: 
364:         *-- Botao apaga (Desmarcar Todos)
365:         THIS.AddObject("cmd_4c_Apaga", "CommandButton")
366:         WITH THIS.cmd_4c_Apaga
367:             .Top          = 84
368:             .Left         = 43
369:             .Height       = 40
370:             .Width        = 40
371:             .FontName     = "Verdana"
372:             .FontSize     = 8
373:             .WordWrap     = .T.
374:             .Caption      = ""
375:             .ToolTipText  = "Desmarcar Todos"
376:             .ForeColor    = RGB(36, 84, 155)
377:             .BackColor    = RGB(255, 255, 255)
378:             .Themes       = .T.
379:             .Picture      = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
380:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
381:             .TabStop      = .F.
382:             .Visible      = .T.
383:         ENDWITH
384:         BINDEVENT(THIS.cmd_4c_Apaga, "Click", THIS, "CmdApagaClick")
385: 
386:         *-- Botao Enviar Email
387:         THIS.AddObject("cmd_4c_BtnEmail", "CommandButton")
388:         WITH THIS.cmd_4c_BtnEmail
389:             .Top          = 3
390:             .Left         = 850
391:             .Height       = 75
392:             .Width        = 75
393:             .FontBold     = .T.
394:             .FontItalic   = .T.
395:             .FontName     = "Comic Sans MS"
396:             .FontSize     = 8
397:             .Caption      = "Enviar Email"
398:             .ToolTipText  = "Enviar Email"
399:             .ForeColor    = RGB(90, 90, 90)
400:             .BackColor    = RGB(255, 255, 255)
401:             .Themes       = .T.
402:             .Picture      = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
403:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_envelope_60.jpg"
404:             .Visible      = .T.
405:         ENDWITH
406:         BINDEVENT(THIS.cmd_4c_BtnEmail, "Click", THIS, "CmdBtnEmailClick")
407:     ENDPROC
408: 
409:     *--------------------------------------------------------------------------
410:     * GrdHeader2Click - Ordena grid pela coluna Conta
411:     *--------------------------------------------------------------------------
412:     PROCEDURE GrdHeader2Click()
413:         SELECT cursor_4c_Dados
414:         SET ORDER TO TAG Contas
415:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(64, 128, 128)
416:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
417:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
418:         THIS.grd_4c_Dados.Refresh()
419:     ENDPROC
420: 
421:     *--------------------------------------------------------------------------
422:     * GrdHeader3Click - Ordena grid pela coluna Nome
423:     *--------------------------------------------------------------------------
424:     PROCEDURE GrdHeader3Click()
425:         SELECT cursor_4c_Dados
426:         SET ORDER TO TAG Rclis
427:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
428:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(64, 128, 128)
429:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(192, 192, 192)
430:         THIS.grd_4c_Dados.Refresh()
431:     ENDPROC
432: 
433:     *--------------------------------------------------------------------------
434:     * GrdHeader4Click - Ordena grid pela coluna Email
435:     *--------------------------------------------------------------------------
436:     PROCEDURE GrdHeader4Click()
437:         SELECT cursor_4c_Dados
438:         SET ORDER TO TAG Emails
439:         THIS.grd_4c_Dados.Column2.Header1.BackColor = RGB(192, 192, 192)
440:         THIS.grd_4c_Dados.Column3.Header1.BackColor = RGB(192, 192, 192)
441:         THIS.grd_4c_Dados.Column4.Header1.BackColor = RGB(64, 128, 128)
442:         THIS.grd_4c_Dados.Refresh()
443:     ENDPROC
444: 
445:     *--------------------------------------------------------------------------
446:     * ChkSelChange - Atualiza campo Checks no cursor quando CheckBox muda
447:     *--------------------------------------------------------------------------
448:     PROCEDURE ChkSelChange()
449:         LOCAL loc_oChk
450:         loc_oChk = THIS.grd_4c_Dados.Column1.Check1
451:         IF USED("cursor_4c_Dados")
452:             SELECT cursor_4c_Dados
453:             REPLACE Checks WITH loc_oChk.Value IN cursor_4c_Dados
454:         ENDIF
455:     ENDPROC
456: 
457:     *--------------------------------------------------------------------------
458:     * CmdSelTudoClick - Marca todos os registros
459:     *--------------------------------------------------------------------------
460:     PROCEDURE CmdSelTudoClick()
461:         IF USED("cursor_4c_Dados")
462:             SELECT cursor_4c_Dados
463:             GO TOP
464:             REPLACE ALL Checks WITH 1
465:             GO TOP
466:         ENDIF
467:         THIS.grd_4c_Dados.Refresh()
468:     ENDPROC
469: 
470:     *--------------------------------------------------------------------------
471:     * CmdApagaClick - Desmarca todos os registros
472:     *--------------------------------------------------------------------------
473:     PROCEDURE CmdApagaClick()
474:         IF USED("cursor_4c_Dados")
475:             SELECT cursor_4c_Dados
476:             GO TOP
477:             REPLACE ALL Checks WITH 0
478:             GO TOP
479:         ENDIF
480:         THIS.grd_4c_Dados.Refresh()
481:     ENDPROC
482: 
483:     *--------------------------------------------------------------------------
484:     * ConfigurarCabecalho - Cria container de cabecalho superior
485:     *--------------------------------------------------------------------------
486:     PROTECTED PROCEDURE ConfigurarCabecalho()
487:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
488:         WITH THIS.cnt_4c_Cabecalho
489:             .Top         = 0
490:             .Left        = 0
491:             .Width       = THIS.Width
492:             .Height      = 80
493:             .BorderWidth = 0
494:             .BackStyle   = 1
495:             .BackColor   = RGB(100, 100, 100)
496:             .Visible     = .T.
497: 
498:             .AddObject("lbl_4c_Sombra", "Label")
499:             WITH .lbl_4c_Sombra
500:                 .Top      = 18
501:                 .Left     = 10
502:                 .Width    = THIS.Width
503:                 .Height   = 40
504:                 .AutoSize = .F.
505:                 .FontName = "Tahoma"
506:                 .FontSize = 18
507:                 .FontBold = .T.
508:                 .BackStyle = 0
509:                 .ForeColor = RGB(0, 0, 0)
510:                 .WordWrap  = .T.
511:                 .Alignment = 0
512:                 .Caption   = "Processamento e Gera" + CHR(231) + CHR(227) + "o de Email"
513:                 .Visible   = .T.
514:             ENDWITH
515: 
516:             .AddObject("lbl_4c_Titulo", "Label")
517:             WITH .lbl_4c_Titulo
518:                 .Top         = 17
519:                 .Left        = 10
520:                 .Width       = THIS.Width
521:                 .Height      = 46
522:                 .AutoSize    = .F.
523:                 .FontName    = "Tahoma"
524:                 .FontSize    = 18
525:                 .FontBold    = .T.
526:                 .BackStyle   = 0

*-- Linhas 537 a 738:
537:     *--------------------------------------------------------------------------
538:     * ConfigurarShape1 - Cria elemento decorativo ao redor do botao Email
539:     *--------------------------------------------------------------------------
540:     PROTECTED PROCEDURE ConfigurarShape1()
541:         THIS.AddObject("shp_4c_Shape1", "Shape")
542:         WITH THIS.shp_4c_Shape1
543:             .Top          = 7
544:             .Left         = 804
545:             .Height       = 110
546:             .Width        = 90
547:             .BackStyle    = 0
548:             .BorderStyle  = 0
549:             .BorderWidth  = 1
550:             .SpecialEffect = 1
551:             .BorderColor  = RGB(136, 189, 188)
552:             .Visible      = .T.
553:         ENDWITH
554:     ENDPROC
555: 
556:     *--------------------------------------------------------------------------
557:     * ConfigurarSaida - Cria CommandGroup com botao Encerrar (canonico original)
558:     *--------------------------------------------------------------------------
559:     PROTECTED PROCEDURE ConfigurarSaida()
560:         THIS.AddObject("cmg_4c_Saida", "CommandGroup")
561:         WITH THIS.cmg_4c_Saida
562:             .Top           = -2
563:             .Left          = 920
564:             .Width         = 85
565:             .Height        = 85
566:             .ButtonCount   = 1
567:             .BackStyle     = 0
568:             .BorderStyle   = 0
569:             .SpecialEffect = 1
570:             .BorderColor   = RGB(136, 189, 188)
571:             .Themes        = .F.
572:             .Visible       = .T.
573: 
574:             WITH .Buttons(1)
575:                 .Top         = 5
576:                 .Left        = 5
577:                 .Height      = 75
578:                 .Width       = 75
579:                 .FontBold    = .T.
580:                 .FontItalic  = .T.
581:                 .Caption     = "Encerrar"
582:                 .ToolTipText = "[Esc] Encerrar"
583:                 .ForeColor   = RGB(90, 90, 90)
584:                 .BackColor   = RGB(255, 255, 255)
585:                 .Themes      = .F.
586:                 .Cancel      = .T.
587:                 .Picture     = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
588:             ENDWITH
589:         ENDWITH
590: 
591:         BINDEVENT(THIS.cmg_4c_Saida, "Click", THIS, "CmdEncerrarClick")
592:     ENDPROC
593: 
594:     *--------------------------------------------------------------------------
595:     * CmdEncerrarClick - Fecha o formulario
596:     *--------------------------------------------------------------------------
597:     PROCEDURE CmdEncerrarClick()
598:         THIS.Release()
599:     ENDPROC
600: 
601:     *--------------------------------------------------------------------------
602:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
603:     *--------------------------------------------------------------------------
604:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
605:         LOCAL loc_nI, loc_oControl, loc_nP
606:         FOR loc_nI = 1 TO par_oContainer.ControlCount
607:             loc_oControl = par_oContainer.Controls(loc_nI)
608:             IF VARTYPE(loc_oControl) = "O"
609:                 IF PEMSTATUS(loc_oControl, "Visible", 5)
610:                     loc_oControl.Visible = .T.
611:                 ENDIF
612:                 IF UPPER(loc_oControl.BaseClass) = "PAGEFRAME"
613:                     FOR loc_nP = 1 TO loc_oControl.PageCount
614:                         THIS.TornarControlesVisiveis(loc_oControl.Pages(loc_nP))
615:                     ENDFOR
616:                 ENDIF
617:                 IF PEMSTATUS(loc_oControl, "ControlCount", 5) AND ;
618:                    loc_oControl.ControlCount > 0
619:                     THIS.TornarControlesVisiveis(loc_oControl)
620:                 ENDIF
621:             ENDIF
622:         ENDFOR
623:     ENDPROC
624: 
625:     *--------------------------------------------------------------------------
626:     * CarregarDados - Carrega movimentos do dia (ou EmpDopNums especifico) via BO
627:     * Popula cursor_4c_Dados para o grid e trata modo automatico
628:     *--------------------------------------------------------------------------
629:     PROCEDURE CarregarDados()
630:         LOCAL loc_lResultado, loc_oErro
631:         loc_lResultado = .F.
632: 
633:         TRY
634:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
635:                 loc_lResultado = .T.
636:             ENDIF
637: 
638:             loc_lResultado = THIS.this_oBusinessObject.CarregarListaEmail(THIS.this_cDopes)
639: 
640:             IF loc_lResultado AND USED("cursor_4c_Local")
641:                 *-- Migra dados para cursor do grid (ZAP+APPEND preserva estrutura de colunas)
642:                 SELECT cursor_4c_Dados
643:                 ZAP
644:                 APPEND FROM DBF("cursor_4c_Local")
645:                 IF USED("cursor_4c_Local")
646:                     USE IN cursor_4c_Local
647:                 ENDIF
648: 
649:                 *-- Ordena por Nome (comportamento padrao do original)
650:                 SELECT cursor_4c_Dados
651:                 SET ORDER TO TAG Rclis
652: 
653:                 IF VARTYPE(THIS.grd_4c_Dados) = "O"
654:                     THIS.grd_4c_Dados.Refresh()
655:                 ENDIF
656:             ENDIF
657: 
658:             *-- Modo automatico: envia email imediatamente sem interacao
659:             IF THIS.this_lAutomatico
660:                 THIS.CmdBtnEmailClick()
661:             ENDIF
662: 
663:         CATCH TO loc_oErro
664:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), ;
665:                     "Erro ao carregar dados para email")
666:             loc_lResultado = .F.
667:         ENDTRY
668: 
669:         RETURN loc_lResultado
670:     ENDPROC
671: 
672:     *--------------------------------------------------------------------------
673:     * CmdBtnEmailClick - Envia email para registros marcados (Checks=1)
674:     * Logica original: btnEmail.Click
675:     *--------------------------------------------------------------------------
676:     PROCEDURE CmdBtnEmailClick()
677:         LOCAL loc_lSucesso, loc_lOk, loc_oErro
678:         LOCAL loc_cReceptor, loc_cReceptorCopia, loc_cAssunto
679:         LOCAL loc_cTxtMensagem, loc_cArqAnexo
680:         LOCAL loc_cEmps, loc_cDopes, loc_nNumes, loc_cEdn
681:         LOCAL loc_cFrom, loc_cServer, loc_cSenha, loc_nPorta
682:         LOCAL loc_cSQL
683: 
684:         loc_lOk              = .T.
685:         loc_cReceptor        = ""
686:         loc_cReceptorCopia   = ""
687:         loc_cAssunto         = ""
688:         loc_cTxtMensagem     = ""
689:         loc_cArqAnexo        = ""
690: 
691:         *-- Seleciona apenas registros marcados
692:         IF USED("cursor_4c_Local2")
693:             USE IN cursor_4c_Local2
694:         ENDIF
695:         SELECT * FROM cursor_4c_Dados WHERE Checks = 1 INTO CURSOR cursor_4c_Local2 READWRITE
696: 
697:         IF !USED("cursor_4c_Local2") OR RECCOUNT("cursor_4c_Local2") < 1
698:             MsgAviso("Nenhum registro marcado para envio de email.", "Aviso")
699:             RETURN
700:         ENDIF
701: 
702:         SELECT cursor_4c_Local2
703:         GO TOP
704:         SCAN
705:             IF EMPTY(cursor_4c_Local2.emails)
706:                 LOOP
707:             ENDIF
708: 
709:             SELECT cursor_4c_Local2
710:             loc_cEmps   = SUBSTR(cursor_4c_Local2.EmpDopNums, 1, 3)
711:             loc_cDopes  = ALLTRIM(SUBSTR(cursor_4c_Local2.EmpDopNums, 4, 20))
712:             loc_nNumes  = VAL(SUBSTR(cursor_4c_Local2.EmpDopNums, 24, 6))
713:             loc_cEdn    = ALLTRIM(cursor_4c_Local2.EmpDopNums)
714: 
715:             IF RECNO("cursor_4c_Local2") = 1
716:                 loc_cReceptor      = ALLTRIM(cursor_4c_Local2.emails)
717:                 loc_cTxtMensagem   = ""
718:                 loc_cAssunto       = ""
719:             ELSE
720:                 IF !EMPTY(ALLTRIM(cursor_4c_Local2.emails))
721:                     loc_cReceptorCopia = loc_cReceptorCopia + ;
722:                         IIF(EMPTY(loc_cReceptorCopia), "", ",") + ;
723:                         ALLTRIM(cursor_4c_Local2.emails)
724:                 ENDIF
725:             ENDIF
726: 
727:             *-- Remove PDF anterior se existir
728:             IF FILE(ADDBS(SYS(2023)) + "FORTYUSPDF.PDF")
729:                 DELETE FILE ADDBS(SYS(2023)) + "FORTYUSPDF.PDF"
730:             ENDIF
731: 
732:             *-- Gera impressao/PDF do documento
733:             loc_lOk = THIS.ImprimirDocumento(loc_cEdn)
734: 
735:             IF loc_lOk
736:                 loc_cArqAnexo = THIS.this_cArqEmail
737:             ENDIF
738: 

*-- Linhas 1005 a 1238:
1005:         loc_lEnvioOk = .T.
1006: 
1007:         TRY
1008:             loc_oEmail = CREATEOBJECT("CDO.Message")
1009:             IF VARTYPE(loc_oEmail) != "O"
1010:                 MsgAviso("Problemas ao instanciar CDO.Message para envio de email.", "Aviso")
1011:                 loc_lEnvioOk = .F.
1012:             ENDIF
1013: 
1014:             IF loc_lEnvioOk
1015:                 WITH loc_oEmail.Configuration.Fields
1016:                     .Item("http://schemas.microsoft.com/cdo/configuration/sendusing")              = 2
1017:                     .Item("http://schemas.microsoft.com/cdo/configuration/smtpserver")             = LOWER(ALLTRIM(par_cSmtpServer))
1018:                     .Item("http://schemas.microsoft.com/cdo/configuration/smtpconnectiontimeout")  = 10
1019:                     .Item("http://schemas.microsoft.com/cdo/configuration/smtpserverport")         = IIF(par_nSmtpPort = 0, 25, par_nSmtpPort)
1020:                     .Item("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate")       = 1
1021:                     .Item("http://schemas.microsoft.com/cdo/configuration/sendusername")           = LOWER(ALLTRIM(par_cSendUser))
1022:                     .Item("http://schemas.microsoft.com/cdo/configuration/sendpassword")           = par_cSendPass
1023:                     .Item("http://schemas.microsoft.com/cdo/configuration/smtpusessl")             = IIF(par_nSmtpPort = 465, 1, 0)
1024:                     .Update()
1025:                 ENDWITH
1026: 
1027:                 WITH loc_oEmail
1028:                     .To        = LOWER(ALLTRIM(par_cTo))
1029:                     .Cc        = LOWER(NVL(par_cCC, ""))
1030:                     .From      = LOWER(ALLTRIM(par_cFrom))
1031:                     .Subject   = ALLTRIM(par_cAssunto)
1032:                     .TextBody  = ALLTRIM(par_cCorpo)
1033: 
1034:                     IF !ISNULL(par_cAnexo) AND !EMPTY(ALLTRIM(par_cAnexo))
1035:                         IF FILE(ALLTRIM(par_cAnexo))
1036:                             .AddAttachment(ALLTRIM(par_cAnexo))
1037:                         ELSE
1038:                             loc_lEnvioOk = .F.
1039:                             MsgAviso("Arquivo anexo n" + CHR(227) + "o encontrado:" + CHR(13) + ;
1040:                                      ALLTRIM(par_cAnexo), "Aviso")
1041:                         ENDIF
1042:                     ENDIF
1043: 
1044:                     IF loc_lEnvioOk
1045:                         LOCAL loc_oErroEnvio
1046:                         TRY
1047:                             .Send()
1048:                             loc_lOk = .T.
1049:                         CATCH TO loc_oErroEnvio
1050:                             WAIT WINDOW "Dados do e-mail inv" + CHR(225) + "lidos." TIMEOUT 5
1051:                             loc_lOk = .F.
1052:                         ENDTRY
1053:                     ENDIF
1054:                 ENDWITH
1055:             ENDIF
1056: 
1057:         CATCH TO loc_oErro
1058:             MsgErro(loc_oErro.Message + " LN=" + TRANSFORM(loc_oErro.LineNo), "Erro EnviarEmail")
1059:             loc_lOk = .F.
1060:         ENDTRY
1061: 
1062:         loc_oEmail = .NULL.
1063:         RETURN loc_lOk
1064:     ENDFUNC
1065: 
1066:     *--------------------------------------------------------------------------
1067:     * GravarLog - Registra envio no log do sistema (sigoplog)
1068:     * Adaptado de: fGravarLog('T', SIGPREMA, '', EmpDopNums)
1069:     *--------------------------------------------------------------------------
1070:     PROCEDURE GravarLog(par_cEmpDopNums)
1071:         LOCAL loc_lSucesso, loc_cSQL, loc_oErro
1072:         loc_lSucesso = .F.
1073: 
1074:         TRY
1075:             loc_cSQL = "INSERT INTO SigOpLog (Progs, Transacaos, Datas, Horas) " + ;
1076:                        "VALUES (" + EscaparSQL("SIGPREMA") + ", " + ;
1077:                        EscaparSQL(ALLTRIM(par_cEmpDopNums)) + ", " + ;
1078:                        FormatarDataSQL(DATE()) + ", " + ;
1079:                        EscaparSQL(TIME()) + ")"
1080:             IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
1081:                 loc_lSucesso = .T.
1082:             ENDIF
1083:         CATCH TO loc_oErro
1084:             *-- Falha no log nao impede o fluxo principal
1085:         ENDTRY
1086:     ENDPROC
1087: 
1088:     *--------------------------------------------------------------------------
1089:     * BtnIncluirClick - Form OPERACIONAL nao tem fluxo de inclusao CRUD
1090:     * FormBase declara este metodo; retorna .F. para indicar nao-suporte
1091:     *--------------------------------------------------------------------------
1092:     PROCEDURE BtnIncluirClick()
1093:         RETURN .F.
1094:     ENDPROC
1095: 
1096:     *--------------------------------------------------------------------------
1097:     * BtnAlterarClick - Form OPERACIONAL nao tem fluxo de alteracao CRUD
1098:     *--------------------------------------------------------------------------
1099:     PROCEDURE BtnAlterarClick()
1100:         RETURN .F.
1101:     ENDPROC
1102: 
1103:     *--------------------------------------------------------------------------
1104:     * BtnVisualizarClick - Form OPERACIONAL nao tem fluxo de visualizacao CRUD
1105:     *--------------------------------------------------------------------------
1106:     PROCEDURE BtnVisualizarClick()
1107:         RETURN .F.
1108:     ENDPROC
1109: 
1110:     *--------------------------------------------------------------------------
1111:     * BtnExcluirClick - Form OPERACIONAL nao tem fluxo de exclusao CRUD
1112:     *--------------------------------------------------------------------------
1113:     PROCEDURE BtnExcluirClick()
1114:         RETURN .F.
1115:     ENDPROC
1116: 
1117:     *--------------------------------------------------------------------------
1118:     * Destroy - Libera recursos ao fechar o form
1119:     *--------------------------------------------------------------------------
1120:     PROCEDURE Destroy()
1121:         IF USED("cursor_4c_Dados")
1122:             USE IN cursor_4c_Dados
1123:         ENDIF
1124:         IF USED("cursor_4c_Local")
1125:             USE IN cursor_4c_Local
1126:         ENDIF
1127:         IF USED("cursor_4c_Local2")
1128:             USE IN cursor_4c_Local2
1129:         ENDIF
1130:         IF USED("cursor_4c_MvCab")
1131:             USE IN cursor_4c_MvCab
1132:         ENDIF
1133:         IF USED("cursor_4c_Ope")
1134:             USE IN cursor_4c_Ope
1135:         ENDIF
1136:         IF USED("cursor_4c_OpCdc")
1137:             USE IN cursor_4c_OpCdc
1138:         ENDIF
1139:         IF USED("cursor_4c_OpCdi")
1140:             USE IN cursor_4c_OpCdi
1141:         ENDIF
1142:         IF USED("cursor_4c_OpCdd")
1143:             USE IN cursor_4c_OpCdd
1144:         ENDIF
1145:         IF USED("cursor_4c_MvCabEst")
1146:             USE IN cursor_4c_MvCabEst
1147:         ENDIF
1148:         IF USED("cursor_4c_OpeEst")
1149:             USE IN cursor_4c_OpeEst
1150:         ENDIF
1151:         IF USED("cursor_4c_OpCdcEst")
1152:             USE IN cursor_4c_OpCdcEst
1153:         ENDIF
1154:         IF USED("cursor_4c_EmpMail")
1155:             USE IN cursor_4c_EmpMail
1156:         ENDIF
1157:         THIS.this_oPdf             = .NULL.
1158:         THIS.this_oBusinessObject  = .NULL.
1159:         DODEFAULT()
1160:     ENDPROC
1161: 
1162:     *--------------------------------------------------------------------------
1163:     * BtnBuscarClick - Form OPERACIONAL: sem busca CRUD
1164:     *--------------------------------------------------------------------------
1165:     PROCEDURE BtnBuscarClick()
1166:         RETURN .F.
1167:     ENDPROC
1168: 
1169:     *--------------------------------------------------------------------------
1170:     * BtnEncerrarClick - Encerra o formulario (compatibilidade FormBase)
1171:     *--------------------------------------------------------------------------
1172:     PROCEDURE BtnEncerrarClick()
1173:         THIS.Release()
1174:     ENDPROC
1175: 
1176:     *--------------------------------------------------------------------------
1177:     * BtnSalvarClick - Form OPERACIONAL: sem salvamento CRUD
1178:     *--------------------------------------------------------------------------
1179:     PROCEDURE BtnSalvarClick()
1180:         RETURN .F.
1181:     ENDPROC
1182: 
1183:     *--------------------------------------------------------------------------
1184:     * BtnCancelarClick - Form OPERACIONAL: sem cancelamento CRUD
1185:     *--------------------------------------------------------------------------
1186:     PROCEDURE BtnCancelarClick()
1187:         RETURN .F.
1188:     ENDPROC
1189: 
1190:     *--------------------------------------------------------------------------
1191:     * FormParaBO - Form OPERACIONAL: sem mapeamento campo->propriedade BO
1192:     *--------------------------------------------------------------------------
1193:     PROCEDURE FormParaBO()
1194:         RETURN .F.
1195:     ENDPROC
1196: 
1197:     *--------------------------------------------------------------------------
1198:     * BOParaForm - Form OPERACIONAL: sem mapeamento propriedade BO->campo
1199:     *--------------------------------------------------------------------------
1200:     PROCEDURE BOParaForm()
1201:         RETURN .F.
1202:     ENDPROC
1203: 
1204:     *--------------------------------------------------------------------------
1205:     * HabilitarCampos - Form OPERACIONAL: sem controle de habilitacao por modo CRUD
1206:     *--------------------------------------------------------------------------
1207:     PROCEDURE HabilitarCampos(par_lHabilitar)
1208:         RETURN
1209:     ENDPROC
1210: 
1211:     *--------------------------------------------------------------------------
1212:     * LimparCampos - Zera cursor de dados e atualiza grid
1213:     *--------------------------------------------------------------------------
1214:     PROCEDURE LimparCampos()
1215:         IF USED("cursor_4c_Dados")
1216:             SELECT cursor_4c_Dados
1217:             ZAP
1218:         ENDIF
1219:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
1220:             THIS.grd_4c_Dados.Refresh()
1221:         ENDIF
1222:     ENDPROC
1223: 
1224:     *--------------------------------------------------------------------------
1225:     * CarregarLista - Delega para CarregarDados (padrao operacional)
1226:     *--------------------------------------------------------------------------
1227:     PROCEDURE CarregarLista()
1228:         RETURN THIS.CarregarDados()
1229:     ENDPROC
1230: 
1231:     *--------------------------------------------------------------------------
1232:     * AjustarBotoesPorModo - Form OPERACIONAL: sem modos CRUD para ajustar
1233:     *--------------------------------------------------------------------------
1234:     PROCEDURE AjustarBotoesPorModo()
1235:         RETURN
1236:     ENDPROC
1237: 
1238: ENDDEFINE


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

