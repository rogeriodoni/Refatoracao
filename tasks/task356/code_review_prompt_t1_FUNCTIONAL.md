# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [BINDEVENT-PARAMS] Handler 'ValidarContas' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarContas(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarDataDetalhe' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarDataDetalhe(par_nKeyCode, par_nShiftAltCtrl)
- [METODO-INEXISTENTE] Metodo 'THIS.ExecutarReportForm()' chamado mas NAO definido como PROCEDURE no Form nem herdado de FormBase. A LLM pode ter inventado este metodo. VERIFICAR se existe no legado e IMPLEMENTAR ou REMOVER a chamada.
- [GRID-HEADER] Header Caption 'Valor Líq.' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Valor, Dias, Valor Liquido. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Conta' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Valor, Dias, Valor Liquido. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Descrição' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Valor, Dias, Valor Liquido. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Data Base' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Valor, Dias, Valor Liquido. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Fator' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Valor, Dias, Valor Liquido. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Total' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Valor, Dias, Valor Liquido. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Líquido' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Data, Valor, Dias, Valor Liquido. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCCJ.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (1780 linhas total):

*-- Linhas 29 a 156:
29:     this_cModoAtual      = "LISTA"
30: 
31:     *--------------------------------------------------------------------------
32:     * Init - Retorna DODEFAULT (FormBase.Init chama InicializarForm)
33:     *--------------------------------------------------------------------------
34:     PROCEDURE Init()
35:         LOCAL loc_lResultado
36:         loc_lResultado = .F.
37: 
38:         TRY
39:             loc_lResultado = DODEFAULT()
40:         CATCH TO loc_oErro
41:             MsgErro(loc_oErro.Message, "FormCCJ.Init")
42:         ENDTRY
43: 
44:         RETURN loc_lResultado
45:     ENDPROC
46: 
47:     *--------------------------------------------------------------------------
48:     * InicializarForm - Configura estrutura completa do formulario
49:     * Chamado automaticamente pelo FormBase.Init()
50:     *--------------------------------------------------------------------------
51:     PROTECTED PROCEDURE InicializarForm()
52:         LOCAL loc_lResultado
53:         loc_lResultado = .F.
54: 
55:         TRY
56:             THIS.this_oBusinessObject = CREATEOBJECT("CCJBO")
57: 
58:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
59:                 MsgErro("Falha ao criar CCJBO", "Erro")
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
70:                 THIS.pgf_4c_Paginas.Visible = .T.
71:                 THIS.pgf_4c_Paginas.ActivePage = 1
72:                 THIS.this_cModoAtual = "LISTA"
73:                 loc_lResultado = .T.
74:             ENDIF
75:         CATCH TO loc_oErro
76:             MsgErro(loc_oErro.Message, "FormCCJ.InicializarForm")
77:         ENDTRY
78: 
79:         RETURN loc_lResultado
80:     ENDPROC
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
108:         THIS.ConfigurarPaginaDados()
109:     ENDPROC
110: 
111:     *--------------------------------------------------------------------------
112:     * ConfigurarPaginaLista - Cria containers da Page1 (Lista)
113:     * Fase 3: cabecalho + shell cnt_4c_Botoes + cnt_4c_Saida/Encerrar
114:     * Fase 4: grid grd_4c_Lista e botoes CRUD dentro de cnt_4c_Botoes
115:     *--------------------------------------------------------------------------
116:     PROTECTED PROCEDURE ConfigurarPaginaLista()
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

*-- Linhas 291 a 417:
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
354:             .BackColor          = RGB(255, 255, 255)
355:             .GridLineColor      = RGB(238, 238, 238)
356:             .HighlightBackColor = RGB(255, 255, 255)
357:             .HighlightForeColor = RGB(15, 41, 104)
358:             .HighlightStyle     = 2
359:             .DeleteMark         = .F.
360:             .RecordMark         = .F.
361:             .RowHeight          = 16
362:             .ScrollBars         = 2
363:             .GridLines          = 3
364:             .ReadOnly           = .T.
365:             .Visible            = .T.
366:         ENDWITH
367: 
368:         THIS.TornarControlesVisiveis(loc_oPg1)
369:     ENDPROC
370: 
371:     *--------------------------------------------------------------------------
372:     * ConfigurarPaginaDados - Cria containers da Page2 (Dados)
373:     * Fase 3: cnt_4c_BotoesAcao com Confirmar/Cancelar
374:     * Fase 5: BtnRec/BtnVideo + campos Conta/DataBase/Fator/OptDias
375:     * Fase 6: GradeDetalhe, InserirV/ExcluirV, secao Totais
376:     *--------------------------------------------------------------------------
377:     PROTECTED PROCEDURE ConfigurarPaginaDados()
378:         LOCAL loc_oPg2, loc_oBotoesAcao, loc_oGrdDet
379:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
380: 
381:         *-- Container Confirmar/Cancelar (canonico: Top=33, Left=842, Width=160)
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

*-- Linhas 437 a 481:
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

*-- Linhas 488 a 532:
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
505:             .BackStyle = 0
506:             .Alignment = 1
507:             .Visible   = .T.
508:         ENDWITH
509: 
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
520:             .BackColor     = RGB(255, 255, 255)
521:             .Themes        = .F.
522:             .SpecialEffect = 0
523:             .Visible       = .T.
524:         ENDWITH
525: 
526:         *-- TextBox descricao da conta - readonly, auto-preenchido (Get_DContas: top=115+29=144, left=345)
527:         loc_oPg2.AddObject("txt_4c_DContas", "TextBox")
528:         WITH loc_oPg2.txt_4c_DContas
529:             .Value         = ""
530:             .Top           = 144
531:             .Left          = 345
532:             .Width         = 279

*-- Linhas 541 a 586:
541:             .Visible       = .T.
542:         ENDWITH
543: 
544:         BINDEVENT(loc_oPg2.txt_4c_Contas, "KeyPress", THIS, "ValidarContas")
545:         BINDEVENT(loc_oPg2.txt_4c_Contas, "KeyPress",  THIS, "ContasKeyPress")
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
559:             .BackStyle = 0
560:             .Alignment = 1
561:             .Visible   = .T.
562:         ENDWITH
563: 
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
574:             .BackColor     = RGB(255, 255, 255)
575:             .InputMask     = "99/99/9999"
576:             .Themes        = .F.
577:             .SpecialEffect = 0
578:             .Visible       = .T.
579:         ENDWITH
580: 
581:         *-- Label + TextBox Fator (Say1+Get_Fator: original top=173/169 -> +29=202/198)
582:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
583:         WITH loc_oPg2.lbl_4c_Label1
584:             .Caption   = "Fator :"
585:             .Top       = 202
586:             .Left      = 223

*-- Linhas 611 a 703:
611:             .Visible       = .T.
612:         ENDWITH
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
689:             .BorderStyle   = 0
690:             .Visible       = .T.
691:         ENDWITH
692: 
693:         *-- Grade Detalhe (original top=196 -> compensado=225, left=260)
694:         *-- Colunas: Data/Valor (editaveis), Dias/Liquido (calculados, readonly)
695:         loc_oPg2.AddObject("grd_4c_Detalhe", "Grid")
696:         loc_oGrdDet = loc_oPg2.grd_4c_Detalhe
697:         WITH loc_oGrdDet
698:             .RecordSource       = ""
699:             .ColumnCount        = 4
700:             .Top                = 225
701:             .Left               = 260
702:             .Width              = 365
703:             .Height             = 382

*-- Linhas 743 a 836:
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
825:             .BackStyle = 0
826:             .Alignment = 1
827:             .Visible   = .T.
828:         ENDWITH
829: 
830:         loc_oPg2.AddObject("txt_4c_Qtde", "TextBox")
831:         WITH loc_oPg2.txt_4c_Qtde
832:             .Value         = 0
833:             .Top           = 275
834:             .Left          = 752
835:             .Width         = 68
836:             .Height        = 23

*-- Linhas 940 a 1780:
940:             .Visible       = .T.
941:         ENDWITH
942: 
943:         THIS.TornarControlesVisiveis(loc_oPg2)
944:     ENDPROC
945: 
946:     *--------------------------------------------------------------------------
947:     * CarregarLista - Popula cursor_4c_Dados e atualiza grd_4c_Lista
948:     *--------------------------------------------------------------------------
949:     PROCEDURE CarregarLista()
950:         LOCAL loc_lResultado
951:         loc_lResultado = .F.
952: 
953:         TRY
954:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
955:                 loc_lResultado = .T.
956:             ELSE
957:                 IF THIS.this_oBusinessObject.Buscar("")
958:                     THIS.AtualizarGrid()
959:                     loc_lResultado = .T.
960:                 ENDIF
961:             ENDIF
962:         CATCH TO loc_oErro
963:             MsgErro(loc_oErro.Message, "FormCCJ.CarregarLista")
964:             loc_lResultado = .F.
965:         ENDTRY
966: 
967:         RETURN loc_lResultado
968:     ENDPROC
969: 
970:     *--------------------------------------------------------------------------
971:     * AlternarPagina - Navega entre Page1 (Lista=1) e Page2 (Dados=2)
972:     *--------------------------------------------------------------------------
973:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
974:         LOCAL loc_lResultado
975:         loc_lResultado = .F.
976: 
977:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
978:             RETURN .F.
979:         ENDIF
980: 
981:         TRY
982:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
983: 
984:             IF par_nPagina = 1
985:                 THIS.this_cModoAtual = "LISTA"
986:                 THIS.CarregarLista()
987:             ENDIF
988: 
989:             loc_lResultado = .T.
990:         CATCH TO loc_oErro
991:             MsgErro(loc_oErro.Message, "FormCCJ.AlternarPagina")
992:         ENDTRY
993: 
994:         RETURN loc_lResultado
995:     ENDPROC
996: 
997:     *--------------------------------------------------------------------------
998:     * BtnEncerrarClick - Encerra o formulario
999:     *--------------------------------------------------------------------------
1000:     PROCEDURE BtnEncerrarClick()
1001:         THIS.Release()
1002:     ENDPROC
1003: 
1004:     *--------------------------------------------------------------------------
1005:     * BtnConfirmarClick - Valida, salva e retorna a lista
1006:     *--------------------------------------------------------------------------
1007:     PROCEDURE BtnConfirmarClick()
1008:         LOCAL loc_oPg2, loc_lSucesso
1009:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1010:         loc_lSucesso = .F.
1011: 
1012:         IF EMPTY(ALLTRIM(NVL(loc_oPg2.txt_4c_Contas.Value, "")))
1013:             MsgAviso("Conta n" + CHR(227) + "o informada.", "Confirmar")
1014:             RETURN
1015:         ENDIF
1016: 
1017:         IF EMPTY(loc_oPg2.txt_4c_DataBase.Value)
1018:             MsgAviso("Data Base n" + CHR(227) + "o informada.", "Confirmar")
1019:             RETURN
1020:         ENDIF
1021: 
1022:         TRY
1023:             IF THIS.this_cModoAtual = "INCLUIR"
1024:                 THIS.this_oBusinessObject.this_cCodigo = THIS.this_oBusinessObject.GerarCodigo()
1025:             ENDIF
1026: 
1027:             THIS.FormParaBO()
1028:             THIS.this_oBusinessObject.Recalcular()
1029: 
1030:             IF THIS.this_oBusinessObject.Salvar()
1031:                 MsgInfo("Registro salvo com sucesso!", "Confirmar")
1032:                 THIS.AlternarPagina(1)
1033:             ENDIF
1034:         CATCH TO loc_oErro
1035:             MsgErro(loc_oErro.Message, "BtnConfirmarClick")
1036:         ENDTRY
1037:     ENDPROC
1038: 
1039:     *--------------------------------------------------------------------------
1040:     * BtnCancelarClick - Cancela edicao e retorna a lista
1041:     *--------------------------------------------------------------------------
1042:     PROCEDURE BtnCancelarClick()
1043:         THIS.AlternarPagina(1)
1044:     ENDPROC
1045: 
1046:     *--------------------------------------------------------------------------
1047:     * AtualizarGrid - Wire RecordSource/ControlSource/Headers do grd_4c_Lista
1048:     *--------------------------------------------------------------------------
1049:     PROTECTED PROCEDURE AtualizarGrid()
1050:         LOCAL loc_oGrid
1051:         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1052: 
1053:         loc_oGrid.ColumnCount = 6
1054:         loc_oGrid.RecordSource = "cursor_4c_Dados"
1055: 
1056:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.contas"
1057:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.desconta"
1058:         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.data_base"
1059:         loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.fator"
1060:         loc_oGrid.Column5.ControlSource = "cursor_4c_Dados.total"
1061:         loc_oGrid.Column6.ControlSource = "cursor_4c_Dados.totliq"
1062: 
1063:         loc_oGrid.Column1.Width = 80
1064:         loc_oGrid.Column2.Width = 300
1065:         loc_oGrid.Column3.Width = 100
1066:         loc_oGrid.Column4.Width = 60
1067:         loc_oGrid.Column5.Width = 100
1068:         loc_oGrid.Column6.Width = 100
1069: 
1070:         loc_oGrid.Column1.Header1.Caption = "Conta"
1071:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1072:         loc_oGrid.Column3.Header1.Caption = "Data Base"
1073:         loc_oGrid.Column4.Header1.Caption = "Fator"
1074:         loc_oGrid.Column5.Header1.Caption = "Total"
1075:         loc_oGrid.Column6.Header1.Caption = "L" + CHR(237) + "quido"
1076: 
1077:         THIS.FormatarGridLista(loc_oGrid)
1078:     ENDPROC
1079: 
1080:     *--------------------------------------------------------------------------
1081:     * FormatarGridLista - Formata visual do grid da lista
1082:     *--------------------------------------------------------------------------
1083:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
1084:         WITH par_oGrid
1085:             .FontName = "Tahoma"
1086:             .FontSize = 8
1087:         ENDWITH
1088:     ENDPROC
1089: 
1090:     *--------------------------------------------------------------------------
1091:     * AjustarBotoesPorModo - Habilita/desabilita Confirmar conforme modo corrente
1092:     * VISUALIZAR: Confirmar disabled  |  INCLUIR/ALTERAR: Confirmar enabled
1093:     *--------------------------------------------------------------------------
1094:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1095:         LOCAL loc_oPg2, loc_lEdicao
1096:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
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
1110:     * BtnIncluirClick - Abre Page2 para inclusao de novo registro
1111:     *--------------------------------------------------------------------------
1112:     PROCEDURE BtnIncluirClick()
1113:         THIS.this_oBusinessObject.NovoRegistro()
1114:         THIS.this_oBusinessObject.BuscarDetalhe("")
1115:         THIS.this_cModoAtual = "INCLUIR"
1116:         THIS.LimparCampos()
1117:         THIS.AtualizarGradeDetalhe()
1118:         THIS.HabilitarCampos(.T.)
1119:         THIS.AjustarBotoesPorModo()
1120:         THIS.AlternarPagina(2)
1121:     ENDPROC
1122: 
1123:     *--------------------------------------------------------------------------
1124:     * BtnVisualizarClick - Carrega registro selecionado em modo consulta
1125:     *--------------------------------------------------------------------------
1126:     PROCEDURE BtnVisualizarClick()
1127:         LOCAL loc_cCodigo
1128:         loc_cCodigo = ""
1129: 
1130:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1131:             SELECT cursor_4c_Dados
1132:             loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.codigo, ""))
1133:         ENDIF
1134: 
1135:         IF EMPTY(loc_cCodigo)
1136:             MsgAviso("Selecione um registro na lista.", "Visualizar")
1137:             RETURN
1138:         ENDIF
1139: 
1140:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1141:             THIS.this_oBusinessObject.BuscarDetalhe(loc_cCodigo)
1142:             THIS.AtualizarGradeDetalhe()
1143:             THIS.this_cModoAtual = "VISUALIZAR"
1144:             THIS.BOParaForm()
1145:             THIS.HabilitarCampos(.F.)
1146:             THIS.AjustarBotoesPorModo()
1147:             THIS.AlternarPagina(2)
1148:         ENDIF
1149:     ENDPROC
1150: 
1151:     *--------------------------------------------------------------------------
1152:     * BtnAlterarClick - Carrega registro selecionado para edicao
1153:     *--------------------------------------------------------------------------
1154:     PROCEDURE BtnAlterarClick()
1155:         LOCAL loc_cCodigo
1156:         loc_cCodigo = ""
1157: 
1158:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1159:             SELECT cursor_4c_Dados
1160:             loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.codigo, ""))
1161:         ENDIF
1162: 
1163:         IF EMPTY(loc_cCodigo)
1164:             MsgAviso("Selecione um registro na lista.", "Alterar")
1165:             RETURN
1166:         ENDIF
1167: 
1168:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1169:             THIS.this_oBusinessObject.BuscarDetalhe(loc_cCodigo)
1170:             THIS.AtualizarGradeDetalhe()
1171:             THIS.this_oBusinessObject.EditarRegistro()
1172:             THIS.this_cModoAtual = "ALTERAR"
1173:             THIS.BOParaForm()
1174:             THIS.HabilitarCampos(.T.)
1175:             THIS.AjustarBotoesPorModo()
1176:             THIS.AlternarPagina(2)
1177:         ENDIF
1178:     ENDPROC
1179: 
1180:     *--------------------------------------------------------------------------
1181:     * BtnExcluirClick - Confirma e exclui registro selecionado
1182:     *--------------------------------------------------------------------------
1183:     PROCEDURE BtnExcluirClick()
1184:         LOCAL loc_cCodigo, loc_lConfirma
1185:         loc_cCodigo  = ""
1186:         loc_lConfirma = .F.
1187: 
1188:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1189:             SELECT cursor_4c_Dados
1190:             loc_cCodigo = ALLTRIM(NVL(cursor_4c_Dados.codigo, ""))
1191:         ENDIF
1192: 
1193:         IF EMPTY(loc_cCodigo)
1194:             MsgAviso("Selecione um registro na lista.", "Excluir")
1195:             RETURN
1196:         ENDIF
1197: 
1198:         loc_lConfirma = MsgConfirma("Deseja excluir o c" + CHR(225) + ;
1199:             "lculo de juros selecionado?", "Excluir")
1200:         IF !loc_lConfirma
1201:             RETURN
1202:         ENDIF
1203: 
1204:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1205:             IF THIS.this_oBusinessObject.Excluir()
1206:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Excluir")
1207:                 THIS.CarregarLista()
1208:             ENDIF
1209:         ENDIF
1210:     ENDPROC
1211: 
1212:     *--------------------------------------------------------------------------
1213:     * BtnBuscarClick - Busca registros filtrando por conta ou descricao
1214:     *--------------------------------------------------------------------------
1215:     PROCEDURE BtnBuscarClick()
1216:         LOCAL loc_cFiltro
1217:         loc_cFiltro = INPUTBOX("Informe conta ou descri" + CHR(231) + CHR(227) + ;
1218:             "o (vazio = todos):", "Buscar")
1219: 
1220:         IF VARTYPE(loc_cFiltro) = "C"
1221:             IF THIS.this_oBusinessObject.Buscar(loc_cFiltro)
1222:                 THIS.AtualizarGrid()
1223:             ENDIF
1224:         ENDIF
1225:     ENDPROC
1226: 
1227:     *--------------------------------------------------------------------------
1228:     * ContasKeyPress - Abre picker de conta ao pressionar F4
1229:     *--------------------------------------------------------------------------
1230:     PROCEDURE ContasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1231:         IF par_nKeyCode = 28  && F4
1232:             THIS.AbrirBuscaContas(ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.txt_4c_Contas.Value, "")))
1233:         ENDIF
1234:     ENDPROC
1235: 
1236:     *--------------------------------------------------------------------------
1237:     * ContasDblClick - Abre picker de conta ao dar duplo clique
1238:     *--------------------------------------------------------------------------
1239:     PROCEDURE ContasDblClick()
1240:         THIS.AbrirBuscaContas(ALLTRIM(NVL(THIS.pgf_4c_Paginas.Page2.txt_4c_Contas.Value, "")))
1241:     ENDPROC
1242: 
1243:     *--------------------------------------------------------------------------
1244:     * TornarControlesVisiveis - Torna todos controles visiveis recursivamente
1245:     *--------------------------------------------------------------------------
1246:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1247:         LOCAL loc_nI, loc_oObjeto, loc_nP
1248: 
1249:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1250:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1251: 
1252:             IF VARTYPE(loc_oObjeto) = "O"
1253:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
1254:                     loc_oObjeto.Visible = .T.
1255:                 ENDIF
1256: 
1257:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
1258:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
1259:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
1260:                     ENDFOR
1261:                 ENDIF
1262: 
1263:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5) AND loc_oObjeto.ControlCount > 0
1264:                     THIS.TornarControlesVisiveis(loc_oObjeto)
1265:                 ENDIF
1266:             ENDIF
1267:         ENDFOR
1268:     ENDPROC
1269: 
1270:     *--------------------------------------------------------------------------
1271:     * HabilitarCampos - Habilita/desabilita campos conforme modo corrente
1272:     * Fase 5: controles Conta/DataBase/Fator/OptDias/BtnRec/BtnVideo
1273:     * Fase 6: extende para GradeDetalhe e botoes InserirV/ExcluirV
1274:     *--------------------------------------------------------------------------
1275:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1276:         LOCAL loc_oPg2, loc_lEdicao
1277:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1278:         loc_lEdicao = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1279: 
1280:         IF !PEMSTATUS(loc_oPg2, "txt_4c_Contas", 5)
1281:             RETURN
1282:         ENDIF
1283: 
1284:         *-- Conta: editavel em INCLUIR
1285:         loc_oPg2.txt_4c_Contas.ReadOnly  = !(THIS.this_cModoAtual = "INCLUIR")
1286:         loc_oPg2.txt_4c_DContas.ReadOnly = .T.
1287: 
1288:         *-- DataBase, Fator, OptDias: editaveis em INCLUIR e ALTERAR
1289:         loc_oPg2.txt_4c_DataBase.ReadOnly = !loc_lEdicao
1290:         loc_oPg2.txt_4c_Fator.ReadOnly    = !loc_lEdicao
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
1309:     * Fase 5: Conta/DataBase/Fator/OptDias
1310:     * Fase 6: extende para campos de Totais
1311:     *--------------------------------------------------------------------------
1312:     PROTECTED PROCEDURE LimparCampos()
1313:         LOCAL loc_oPg2
1314:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1315: 
1316:         IF !PEMSTATUS(loc_oPg2, "txt_4c_Contas", 5)
1317:             RETURN
1318:         ENDIF
1319: 
1320:         loc_oPg2.txt_4c_Contas.Value    = ""
1321:         loc_oPg2.txt_4c_DContas.Value   = ""
1322:         loc_oPg2.txt_4c_DataBase.Value  = {}
1323:         loc_oPg2.txt_4c_Fator.Value     = 0
1324:         loc_oPg2.opt_4c_OptDias.Value   = 1
1325: 
1326:         IF PEMSTATUS(loc_oPg2, "txt_4c_Qtde", 5)
1327:             loc_oPg2.txt_4c_Qtde.Value   = 0
1328:             loc_oPg2.txt_4c_Media.Value  = 0
1329:             loc_oPg2.txt_4c_Total.Value  = 0
1330:             loc_oPg2.txt_4c_TotLiq.Value = 0
1331:         ENDIF
1332:     ENDPROC
1333: 
1334:     *--------------------------------------------------------------------------
1335:     * BOParaForm - Transfere propriedades do BO para os campos da Page2
1336:     * Fase 5: Conta/DContas/DataBase/Fator/OptDias
1337:     * Fase 6: extende para campos de Totais
1338:     *--------------------------------------------------------------------------
1339:     PROTECTED PROCEDURE BOParaForm()
1340:         LOCAL loc_oPg2, loc_oBO
1341:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1342:         loc_oBO  = THIS.this_oBusinessObject
1343: 
1344:         IF !PEMSTATUS(loc_oPg2, "txt_4c_Contas", 5)
1345:             RETURN
1346:         ENDIF
1347: 
1348:         TRY
1349:             loc_oPg2.txt_4c_Contas.Value   = loc_oBO.this_cContas
1350:             loc_oPg2.txt_4c_DataBase.Value  = loc_oBO.this_dDataBase
1351:             loc_oPg2.txt_4c_Fator.Value     = loc_oBO.this_nFator
1352:             loc_oPg2.opt_4c_OptDias.Value   = loc_oBO.this_nTiposDias
1353: 
1354:             *-- Carrega descricao da conta
1355:             IF loc_oBO.BuscarContaPorCodigo(loc_oBO.this_cContas)
1356:                 loc_oPg2.txt_4c_DContas.Value = loc_oBO.this_cDContas
1357:             ELSE
1358:                 loc_oPg2.txt_4c_DContas.Value = ""
1359:             ENDIF
1360: 
1361:             *-- Computa totais e atualiza campos de exibicao
1362:             THIS.AtualizarTotais()
1363: 
1364:             *-- Refresh da grade de detalhe
1365:             IF PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5)
1366:                 loc_oPg2.grd_4c_Detalhe.Refresh()
1367:             ENDIF
1368:         CATCH TO loc_oErro
1369:             MsgErro(loc_oErro.Message, "BOParaForm")
1370:         ENDTRY
1371:     ENDPROC
1372: 
1373:     *--------------------------------------------------------------------------
1374:     * FormParaBO - Transfere valores dos campos da Page2 para o BO
1375:     * Fase 5: Conta/DataBase/Fator/OptDias
1376:     * Fase 6: extende para campos de Totais (calculados pelo BO.Recalcular)
1377:     *--------------------------------------------------------------------------
1378:     PROTECTED PROCEDURE FormParaBO()
1379:         LOCAL loc_oPg2, loc_oBO
1380:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1381:         loc_oBO  = THIS.this_oBusinessObject
1382: 
1383:         IF !PEMSTATUS(loc_oPg2, "txt_4c_Contas", 5)
1384:             RETURN
1385:         ENDIF
1386: 
1387:         TRY
1388:             loc_oBO.this_cContas    = ALLTRIM(NVL(loc_oPg2.txt_4c_Contas.Value, ""))
1389:             loc_oBO.this_dDataBase  = NVL(loc_oPg2.txt_4c_DataBase.Value, {})
1390:             loc_oBO.this_nFator     = NVL(loc_oPg2.txt_4c_Fator.Value, 0)
1391:             loc_oBO.this_nTiposDias = NVL(loc_oPg2.opt_4c_OptDias.Value, 1)
1392:         CATCH TO loc_oErro
1393:             MsgErro(loc_oErro.Message, "FormParaBO")
1394:         ENDTRY
1395:     ENDPROC
1396: 
1397:     *--------------------------------------------------------------------------
1398:     * BtnRecalcularClick - Confirma e aciona recalculo de juros (BtnRec)
1399:     *--------------------------------------------------------------------------
1400:     PROCEDURE BtnRecalcularClick()
1401:         LOCAL loc_oPg2
1402:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1403: 
1404:         IF EMPTY(loc_oPg2.txt_4c_DataBase.Value)
1405:             MsgAviso("Data Base n" + CHR(227) + "o informada.", "Recalcular")
1406:             RETURN
1407:         ENDIF
1408: 
1409:         IF !MsgConfirma("Deseja Recalcular os Valores?", "Aten" + CHR(231) + CHR(227) + "o")
1410:             RETURN
1411:         ENDIF
1412: 
1413:         TRY
1414:             THIS.FormParaBO()
1415:             THIS.this_oBusinessObject.Recalcular()
1416:             THIS.AtualizarTotais()
1417:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Detalhe", 5)
1418:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Detalhe.Refresh()
1419:             ENDIF
1420:         CATCH TO loc_oErro
1421:             MsgErro(loc_oErro.Message, "BtnRecalcularClick")
1422:         ENDTRY
1423:     ENDPROC
1424: 
1425:     *--------------------------------------------------------------------------
1426:     * BtnRelatorioClick - Gera relatorio de calculo de juros (BtnVideo)
1427:     *--------------------------------------------------------------------------
1428:     PROCEDURE BtnRelatorioClick()
1429:         LOCAL loc_cCursorDet
1430:         loc_cCursorDet = THIS.this_oBusinessObject.this_cCursorDetalhe
1431: 
1432:         IF !USED(loc_cCursorDet) OR RECCOUNT(loc_cCursorDet) = 0
1433:             MsgAviso("Nenhum detalhe dispon" + CHR(237) + "vel para relat" + CHR(243) + "rio.", "Relat" + CHR(243) + "rio")
1434:             RETURN
1435:         ENDIF
1436: 
1437:         TRY
1438:             THIS.ExecutarReportForm(gc_4c_CaminhoReports + "SIGCDCCJ.frx", "PREVIEW", loc_cCursorDet)
1439:         CATCH TO loc_oErro
1440:             MsgErro(loc_oErro.Message, "BtnRelatorioClick")
1441:         ENDTRY
1442:     ENDPROC
1443: 
1444:     *--------------------------------------------------------------------------
1445:     * ValidarContas - Valida conta informada e auto-preenche descricao (LostFocus)
1446:     * Substitui fAcessoContas do legado por SQL direto + FormBuscaAuxiliar
1447:     *--------------------------------------------------------------------------
1448:     PROCEDURE ValidarContas(par_nKeyCode, par_nShiftAltCtrl)
1449:         LOCAL loc_oPg2, loc_cContas
1450:         loc_oPg2    = THIS.pgf_4c_Paginas.Page2
1451:         loc_cContas = ALLTRIM(NVL(loc_oPg2.txt_4c_Contas.Value, ""))
1452: 
1453:         IF EMPTY(loc_cContas)
1454:             loc_oPg2.txt_4c_DContas.Value = ""
1455:             RETURN
1456:         ENDIF
1457: 
1458:         TRY
1459:             IF THIS.this_oBusinessObject.BuscarContaPorCodigo(loc_cContas)
1460:                 loc_oPg2.txt_4c_DContas.Value = THIS.this_oBusinessObject.this_cDContas
1461:             ELSE
1462:                 THIS.AbrirBuscaContas(loc_cContas)
1463:             ENDIF
1464:         CATCH TO loc_oErro
1465:             MsgErro(loc_oErro.Message, "ValidarContas")
1466:         ENDTRY
1467:     ENDPROC
1468: 
1469:     *--------------------------------------------------------------------------
1470:     * AbrirBuscaContas - Abre FormBuscaAuxiliar para selecionar conta em SigCdCli
1471:     *--------------------------------------------------------------------------
1472:     PROCEDURE AbrirBuscaContas(par_cValorInicial)
1473:         LOCAL loc_oBusca, loc_oPg2
1474:         loc_oBusca = .NULL.
1475:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1476: 
1477:         TRY
1478:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1479:                 "SigCdCli", "cursor_4c_BuscaConta", "iclis", ;
1480:                 par_cValorInicial, "Selecionar Conta")
1481: 
1482:             IF VARTYPE(loc_oBusca) = "O"
1483:                 IF loc_oBusca.this_lAchouRegistro AND loc_oBusca.this_lSelecionou
1484:                     IF USED("cursor_4c_BuscaConta")
1485:                         SELECT cursor_4c_BuscaConta
1486:                         loc_oPg2.txt_4c_Contas.Value  = ALLTRIM(NVL(iclis, ""))
1487:                         loc_oPg2.txt_4c_DContas.Value = ALLTRIM(NVL(rclis, ""))
1488:                     ENDIF
1489:                 ELSE
1490:                     IF !loc_oBusca.this_lAchouRegistro
1491:                     loc_oBusca.mAddColuna("iclis", "", "Conta")
1492:                     loc_oBusca.mAddColuna("rclis", "", "Nome")
1493:                     loc_oBusca.Show()
1494:                     IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
1495:                         SELECT cursor_4c_BuscaConta
1496:                         loc_oPg2.txt_4c_Contas.Value  = ALLTRIM(NVL(iclis, ""))
1497:                         loc_oPg2.txt_4c_DContas.Value = ALLTRIM(NVL(rclis, ""))
1498:                     ELSE
1499:                         loc_oPg2.txt_4c_Contas.Value  = ""
1500:                         loc_oPg2.txt_4c_DContas.Value = ""
1501:                     ENDIF
1502:                     ENDIF
1503:                 ENDIF
1504:                 loc_oBusca.Release()
1505:             ENDIF
1506: 
1507:             IF USED("cursor_4c_BuscaConta")
1508:                 USE IN cursor_4c_BuscaConta
1509:             ENDIF
1510:         CATCH TO loc_oErro
1511:             MsgErro(loc_oErro.Message, "AbrirBuscaContas")
1512:             IF USED("cursor_4c_BuscaConta")
1513:                 USE IN cursor_4c_BuscaConta
1514:             ENDIF
1515:         ENDTRY
1516:     ENDPROC
1517: 
1518:     *--------------------------------------------------------------------------
1519:     * OptDiasChanged - Dispara recalculo ao mudar tipo de dias (Corridos/Uteis)
1520:     *--------------------------------------------------------------------------
1521:     PROCEDURE OptDiasChanged()
1522:         LOCAL loc_oPg2
1523:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1524: 
1525:         IF EMPTY(loc_oPg2.txt_4c_DataBase.Value)
1526:             RETURN
1527:         ENDIF
1528: 
1529:         TRY
1530:             THIS.FormParaBO()
1531:             THIS.this_oBusinessObject.Recalcular()
1532:             THIS.AtualizarTotais()
1533:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Detalhe", 5)
1534:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Detalhe.Refresh()
1535:             ENDIF
1536:         CATCH TO loc_oErro
1537:             MsgErro(loc_oErro.Message, "OptDiasChanged")
1538:         ENDTRY
1539:     ENDPROC
1540: 
1541:     *--------------------------------------------------------------------------
1542:     * AtualizarGradeDetalhe - Wira RecordSource/ControlSources do grd_4c_Detalhe
1543:     * Chamado apos BuscarDetalhe() para associar grid ao cursor de detalhe
1544:     *--------------------------------------------------------------------------
1545:     PROTECTED PROCEDURE AtualizarGradeDetalhe()
1546:         LOCAL loc_oPg2, loc_oGrd, loc_cAlias
1547:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1548:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorDetalhe
1549: 
1550:         IF !PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5)
1551:             RETURN
1552:         ENDIF
1553: 
1554:         TRY
1555:             loc_oGrd = loc_oPg2.grd_4c_Detalhe
1556: 
1557:             IF USED(loc_cAlias)
1558:                 loc_oGrd.RecordSource          = loc_cAlias
1559:                 loc_oGrd.Column1.ControlSource = loc_cAlias + ".datas"
1560:                 loc_oGrd.Column2.ControlSource = loc_cAlias + ".valor"
1561:                 loc_oGrd.Column3.ControlSource = loc_cAlias + ".dias"
1562:                 loc_oGrd.Column4.ControlSource = loc_cAlias + ".liquido"
1563:             ELSE
1564:                 loc_oGrd.RecordSource          = ""
1565:                 loc_oGrd.Column1.ControlSource = ""
1566:                 loc_oGrd.Column2.ControlSource = ""
1567:                 loc_oGrd.Column3.ControlSource = ""
1568:                 loc_oGrd.Column4.ControlSource = ""
1569:             ENDIF
1570: 
1571:             loc_oGrd.Refresh()
1572:         CATCH TO loc_oErro
1573:             MsgErro(loc_oErro.Message, "AtualizarGradeDetalhe")
1574:         ENDTRY
1575:     ENDPROC
1576: 
1577:     *--------------------------------------------------------------------------
1578:     * AtualizarTotais - Escaneia cursor de detalhe e atualiza campos de totais
1579:     * Chamado apos Recalcular(), ExcluirVClick() e BOParaForm()
1580:     *--------------------------------------------------------------------------
1581:     PROTECTED PROCEDURE AtualizarTotais()
1582:         LOCAL loc_oPg2, loc_cAlias
1583:         LOCAL loc_nQtde, loc_nTotalDias, loc_nTotal, loc_nTotLiq, loc_nDias
1584:         loc_oPg2       = THIS.pgf_4c_Paginas.Page2
1585:         loc_cAlias     = THIS.this_oBusinessObject.this_cCursorDetalhe
1586:         loc_nQtde      = 0
1587:         loc_nTotalDias = 0
1588:         loc_nTotal     = 0
1589:         loc_nTotLiq    = 0
1590:         loc_nDias      = 0
1591: 
1592:         IF !PEMSTATUS(loc_oPg2, "txt_4c_Qtde", 5)
1593:             RETURN
1594:         ENDIF
1595: 
1596:         TRY
1597:             IF USED(loc_cAlias)
1598:                 SELECT (loc_cAlias)
1599:                 SCAN
1600:                     IF !EMPTY(datas)
1601:                         loc_nQtde      = loc_nQtde + 1
1602:                         loc_nDias      = NVL(dias, 0)
1603:                         loc_nTotalDias = loc_nTotalDias + loc_nDias
1604:                         loc_nTotal     = loc_nTotal + NVL(valor, 0)
1605:                         loc_nTotLiq    = loc_nTotLiq + NVL(liquido, 0)
1606:                     ENDIF
1607:                 ENDSCAN
1608:             ENDIF
1609: 
1610:             loc_oPg2.txt_4c_Qtde.Value   = loc_nQtde
1611:             loc_oPg2.txt_4c_Media.Value  = IIF(loc_nQtde > 0, loc_nTotalDias / loc_nQtde, 0)
1612:             loc_oPg2.txt_4c_Total.Value  = loc_nTotal
1613:             loc_oPg2.txt_4c_TotLiq.Value = loc_nTotLiq
1614:         CATCH TO loc_oErro
1615:             MsgErro(loc_oErro.Message, "AtualizarTotais")
1616:         ENDTRY
1617:     ENDPROC
1618: 
1619:     *--------------------------------------------------------------------------
1620:     * RecalcularItem - Recalcula juros ao sair do campo Valor no grid (LostFocus)
1621:     *--------------------------------------------------------------------------
1622:     PROCEDURE RecalcularItem()
1623:         LOCAL loc_oPg2
1624:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1625: 
1626:         IF EMPTY(THIS.this_oBusinessObject.this_dDataBase)
1627:             RETURN
1628:         ENDIF
1629: 
1630:         TRY
1631:             THIS.this_oBusinessObject.Recalcular()
1632: 
1633:             IF PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5)
1634:                 loc_oPg2.grd_4c_Detalhe.Refresh()
1635:             ENDIF
1636: 
1637:             THIS.AtualizarTotais()
1638:         CATCH TO loc_oErro
1639:             MsgErro(loc_oErro.Message, "RecalcularItem")
1640:         ENDTRY
1641:     ENDPROC
1642: 
1643:     *--------------------------------------------------------------------------
1644:     * ValidarDataDetalhe - Valida data ao sair do campo Data no grid (LostFocus)
1645:     * Limpa data invalida (ano < 1900) para nao quebrar Recalcular
1646:     *--------------------------------------------------------------------------
1647:     PROCEDURE ValidarDataDetalhe(par_nKeyCode, par_nShiftAltCtrl)
1648:         LOCAL loc_oPg2, loc_cAlias
1649:         loc_oPg2  = THIS.pgf_4c_Paginas.Page2
1650:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorDetalhe
1651: 
1652:         TRY
1653:             IF !PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5) OR !USED(loc_cAlias)
1654:                 RETURN
1655:             ENDIF
1656: 
1657:             SELECT (loc_cAlias)
1658: 
1659:             IF !EOF() AND !BOF() AND !EMPTY(datas) AND YEAR(TTOD(datas)) < 1900
1660:                 REPLACE datas WITH {}
1661:                 loc_oPg2.grd_4c_Detalhe.Refresh()
1662:             ENDIF
1663:         CATCH TO loc_oErro
1664:             MsgErro(loc_oErro.Message, "ValidarDataDetalhe")
1665:         ENDTRY
1666:     ENDPROC
1667: 
1668:     *--------------------------------------------------------------------------
1669:     * InserirVClick - Adiciona nova linha em branco ao cursor de detalhe
1670:     *--------------------------------------------------------------------------
1671:     PROCEDURE InserirVClick()
1672:         LOCAL loc_cAlias, loc_oPg2
1673:         loc_cAlias = THIS.this_oBusinessObject.this_cCursorDetalhe
1674:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
1675: 
1676:         IF !USED(loc_cAlias)
1677:             RETURN
1678:         ENDIF
1679: 
1680:         TRY
1681:             SELECT (loc_cAlias)
1682:             APPEND BLANK
1683:             REPLACE cidchaves WITH "", ;
1684:                     codigo    WITH THIS.this_oBusinessObject.this_cCodigo, ;
1685:                     datas     WITH {}, ;
1686:                     dias      WITH 0, ;
1687:                     liquido   WITH 0, ;
1688:                     valor     WITH 0
1689: 
1690:             IF PEMSTATUS(loc_oPg2, "grd_4c_Detalhe", 5)
1691:                 loc_oPg2.grd_4c_Detalhe.Refresh()
1692:             ENDIF
1693:         CATCH TO loc_oErro
1694:             MsgErro(loc_oErro.Message, "InserirVClick")
1695:         ENDTRY
1696:     ENDPROC
1697: 
1698:     *--------------------------------------------------------------------------
1699:     * ExcluirVClick - Remove linha corrente do cursor de detalhe
1700:     * Reconstroi o cursor sem o registro excluido (PACK nao funciona em cursors)
1701:     *--------------------------------------------------------------------------
1702:     PROCEDURE ExcluirVClick()
1703:         LOCAL loc_cAlias, loc_oPg2, loc_lConfirma, loc_cTemp
1704:         loc_cAlias    = THIS.this_oBusinessObject.this_cCursorDetalhe
1705:         loc_oPg2      = THIS.pgf_4c_Paginas.Page2
1706:         loc_lConfirma = .F.
1707:         loc_cTemp     = "cursor_4c_DetTemp"
1708: 
1709:         IF !USED(loc_cAlias)
1710:             RETURN
1711:         ENDIF
1712: 
1713:         SELECT (loc_cAlias)
1714:         IF RECCOUNT() = 0 OR EOF()
1715:             MsgAviso("Nenhuma linha selecionada.", "Excluir")
1716:             RETURN
1717:         ENDIF
1718: 
1719:         loc_lConfirma = MsgConfirma("Deseja excluir a linha selecionada?", "Excluir")
1720:         IF !loc_lConfirma
1721:             RETURN
1722:         ENDIF
1723: 
1724:         TRY
1725:             *-- Marca e reconstroi cursor sem o registro (DELETE + SELECT WHERE !DELETED())
1726:             SELECT (loc_cAlias)
1727:             DELETE
1728: 
1729:             IF USED(loc_cTemp)
1730:                 USE IN (loc_cTemp)
1731:             ENDIF
1732: 
1733:             SELECT cidchaves, codigo, datas, dias, liquido, valor ;
1734:                 FROM (loc_cAlias) WHERE !DELETED() ;
1735:                 INTO CURSOR (loc_cTemp) READWRITE
1736: 
1737:             USE IN (loc_cAlias)
1738: 
1739:             SELECT cidchaves, codigo, datas, dias, liquido, valor ;
1740:                 FROM (loc_cTemp) ;
1741:                 INTO CURSOR (loc_cAlias) READWRITE
1742: 
1743:             IF USED(loc_cTemp)
1744:                 USE IN (loc_cTemp)
1745:             ENDIF
1746: 
1747:             THIS.AtualizarGradeDetalhe()
1748:             THIS.AtualizarTotais()
1749:         CATCH TO loc_oErro
1750:             MsgErro(loc_oErro.Message, "ExcluirVClick")
1751:             IF USED(loc_cTemp)
1752:                 USE IN (loc_cTemp)
1753:             ENDIF
1754:         ENDTRY
1755:     ENDPROC
1756: 
1757:     *--------------------------------------------------------------------------
1758:     * Destroy - Libera cursor e BO; chama FormBase.Destroy como ultima linha
1759:     *--------------------------------------------------------------------------
1760:     PROCEDURE Destroy()
1761:         TRY
1762:             IF USED("cursor_4c_Dados")
1763:                 USE IN cursor_4c_Dados
1764:             ENDIF
1765: 
1766:             IF USED("cursor_4c_Detalhe")
1767:                 USE IN cursor_4c_Detalhe
1768:             ENDIF
1769: 
1770:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1771:                 THIS.this_oBusinessObject = .NULL.
1772:             ENDIF
1773:         CATCH TO loc_oErro
1774:             MsgErro(loc_oErro.Message, "FormCCJ.Destroy")
1775:         ENDTRY
1776: 
1777:         DODEFAULT()
1778:     ENDPROC
1779: 
1780: ENDDEFINE


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

