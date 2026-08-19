# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (16)
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BUSCA-CURSOR] CREATEOBJECT('FormBuscaAuxiliar') sem parametros mas NAO define this_cCursorDestino. No Modo 2 (sem params), DEVE definir this_cCursorDestino com o cursor local pre-existente ANTES de chamar Show().
- [BINDEVENT-PARAMS] Handler 'ValidarTipos' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarTipos(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarGGrus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarGGrus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'ValidarSGrus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarSGrus(par_nKeyCode, par_nShiftAltCtrl)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Compos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Compos' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Operação, Emp., Descrição, Composição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Operação, Emp., Descrição, Composição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Razão Social' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Operação, Emp., Descrição, Composição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Operação, Emp., Descrição, Composição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Operação, Emp., Descrição, Composição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Operação, Emp., Descrição, Composição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Operação, Emp., Descrição, Composição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Razão Social' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Operação, Emp., Descrição, Composição. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormMda.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2590 linhas total):

*-- Linhas 6 a 147:
6: DEFINE CLASS FormMda AS FormBase
7: 
8:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
9:     *-- Caption setado via CHR() em InicializarForm (CLAUDE.md: sem acentos literais em .PRG)
10:     Height      = 600
11:     Width       = 1000
12:     Caption     = ""
13:     AutoCenter  = .T.
14:     ShowWindow  = 1
15:     WindowType  = 1
16:     ControlBox  = .F.
17:     TitleBar    = 0
18:     Themes      = .F.
19:     BorderStyle = 2
20: 
21:     *-- Propriedades de estado
22:     this_oBusinessObject = .NULL.
23:     this_cModoAtual      = "LISTA"
24: 
25:     *===========================================================================
26:     * Init - REGRA CRITICA: Apenas RETURN DODEFAULT()
27:     * FormBase.Init() ja chama InicializarForm() - NAO duplicar a chamada!
28:     *===========================================================================
29:     PROCEDURE Init()
30:         RETURN DODEFAULT()
31:     ENDPROC
32: 
33:     *===========================================================================
34:     * InicializarForm - Configura estrutura completa
35:     * Chamado automaticamente pelo FormBase.Init() via DODEFAULT()
36:     *===========================================================================
37:     PROTECTED PROCEDURE InicializarForm()
38:         LOCAL loc_lSucesso
39:         loc_lSucesso = .F.
40: 
41:         TRY
42:             THIS.Caption = "Cadastro de Motivos de Desconto / Acr" + CHR(233) + "scimo"
43:             THIS.this_oBusinessObject = CREATEOBJECT("MdaBO")
44: 
45:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
46:                 MostrarErro("Erro ao criar MdaBO" + CHR(13) + ;
47:                     "VARTYPE retornou: " + VARTYPE(THIS.this_oBusinessObject), ;
48:                     "FormMda.InicializarForm")
49:             ELSE
50:                 THIS.ConfigurarPageFrame()
51:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
52:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
53:                 THIS.pgf_4c_Paginas.Visible  = .T.
54:                 THIS.pgf_4c_Paginas.ActivePage = 1
55:                 THIS.this_cModoAtual = "LISTA"
56: 
57:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
58:                     THIS.CarregarLista()
59:                 ENDIF
60: 
61:                 loc_lSucesso = .T.
62:             ENDIF
63: 
64:         CATCH TO loException
65:             MostrarErro("Erro ao inicializar FormMda:" + CHR(13) + ;
66:                 loException.Message + CHR(13) + ;
67:                 "Linha: " + TRANSFORM(loException.LineNo), ;
68:                 "FormMda.InicializarForm")
69:         ENDTRY
70: 
71:         RETURN loc_lSucesso
72:     ENDPROC
73: 
74:     *===========================================================================
75:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
76:     * Top=-29 para esconder abas; controles dentro das Pages compensam +29 no Top
77:     *===========================================================================
78:     PROTECTED PROCEDURE ConfigurarPageFrame()
79:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
80: 
81:         WITH THIS.pgf_4c_Paginas
82:             .PageCount = 2
83:             .Top       = -29
84:             .Left      = 0
85:             .Width     = THIS.Width
86:             .Height    = THIS.Height + 29
87:             .Tabs      = .F.
88:             .Visible   = .T.
89: 
90:             .Page1.Caption   = "Lista"
91:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
92:             .Page1.BackColor = RGB(255, 255, 255)
93: 
94:             .Page2.Caption   = "Dados"
95:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
96:             .Page2.BackColor = RGB(255, 255, 255)
97:         ENDWITH
98: 
99:         THIS.ConfigurarPaginaLista()
100:         THIS.ConfigurarPaginaDados()
101:     ENDPROC
102: 
103:     *===========================================================================
104:     * ConfigurarPaginaLista - Page1: Cabecalho + container botoes CRUD + Encerrar
105:     * Grid e botoes CRUD adicionados na Fase 4
106:     *===========================================================================
107:     PROTECTED PROCEDURE ConfigurarPaginaLista()
108:         LOCAL loc_oPagina
109:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
110: 
111:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112: 
113:         *----------------------------------------------------------------------
114:         * Container Cabecalho (cntSombra no legado)
115:         * Original: Top=1. Com compensacao PageFrame +29: Top=31
116:         *----------------------------------------------------------------------
117:         loc_oPagina.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH loc_oPagina.cnt_4c_Cabecalho
119:             .Top         = 31
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackColor   = RGB(100, 100, 100)
124:             .BorderWidth = 0
125:             .Visible     = .T.
126:         ENDWITH
127: 
128:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
129:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Sombra
130:             .Caption   = THIS.Caption
131:             .Top       = 15
132:             .Left      = 10
133:             .Width     = THIS.Width - 10
134:             .Height    = 40
135:             .AutoSize  = .F.
136:             .FontName  = "Tahoma"
137:             .FontSize  = 16
138:             .FontBold  = .T.
139:             .ForeColor = RGB(0, 0, 0)
140:             .BackStyle = 0
141:             .Visible   = .T.
142:         ENDWITH
143: 
144:         loc_oPagina.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
145:         WITH loc_oPagina.cnt_4c_Cabecalho.lbl_4c_Titulo
146:             .Caption   = THIS.Caption
147:             .Top       = 18

*-- Linhas 287 a 374:
287:             .Visible         = .T.
288:         ENDWITH
289: 
290:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
291:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
292:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
293:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
294:         BINDEVENT(loc_oPagina.cnt_4c_Botoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
295: 
296:         *----------------------------------------------------------------------
297:         * Container Saida - PADRAO CANONICO (CLAUDE.md Regra #10)
298:         * Left=917, Top=29 (0+29 compensacao), Width=90, Height=85
299:         *----------------------------------------------------------------------
300:         loc_oPagina.AddObject("cnt_4c_Saida", "Container")
301:         WITH loc_oPagina.cnt_4c_Saida
302:             .Top         = 29
303:             .Left        = 917
304:             .Width       = 90
305:             .Height      = 85
306:             .BackStyle   = 0
307:             .BorderWidth = 0
308:             .Visible     = .T.
309:         ENDWITH
310: 
311:         loc_oPagina.cnt_4c_Saida.AddObject("cmd_4c_Encerrar", "CommandButton")
312:         WITH loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar
313:             .Caption         = "Encerrar"
314:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
315:             .PicturePosition = 13
316:             .Top             = 5
317:             .Left            = 5
318:             .Width           = 75
319:             .Height          = 75
320:             .FontName        = "Tahoma"
321:             .FontBold        = .T.
322:             .FontItalic      = .T.
323:             .FontSize        = 8
324:             .ForeColor       = RGB(90, 90, 90)
325:             .BackColor       = RGB(255, 255, 255)
326:             .Themes          = .F.
327:             .SpecialEffect   = 0
328:             .MousePointer    = 15
329:             .WordWrap        = .T.
330:             .AutoSize        = .F.
331:             .Visible         = .T.
332:         ENDWITH
333: 
334:         BINDEVENT(loc_oPagina.cnt_4c_Saida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
335: 
336:         *----------------------------------------------------------------------
337:         * Grid de Lista - colunas: Codigos(80), Descrs(290), Tipos(40)
338:         * Top = 117 (88 padrao framework + 29 compensacao PageFrame)
339:         * ColumnCount e RecordSource FORA de WITH (Problema 36/48)
340:         *----------------------------------------------------------------------
341:         loc_oPagina.AddObject("grd_4c_Lista", "Grid")
342:         loc_oPagina.grd_4c_Lista.ColumnCount = 3
343:         loc_oPagina.grd_4c_Lista.RecordSource = ""
344: 
345:         WITH loc_oPagina.grd_4c_Lista
346:             .Top                = 117
347:             .Left               = 26
348:             .Width              = 890
349:             .Height             = 498
350:             .FontName           = "Verdana"
351:             .FontSize           = 8
352:             .ForeColor          = RGB(90, 90, 90)
353:             .BackColor          = RGB(255, 255, 255)
354:             .GridLineColor      = RGB(238, 238, 238)
355:             .HighlightBackColor = RGB(255, 255, 255)
356:             .HighlightForeColor = RGB(15, 41, 104)
357:             .HighlightStyle     = 2
358:             .DeleteMark         = .F.
359:             .RecordMark         = .F.
360:             .RowHeight          = 16
361:             .ScrollBars         = 2
362:             .GridLines          = 3
363:             .ReadOnly           = .T.
364:             .Visible            = .T.
365:         ENDWITH
366: 
367:         WITH loc_oPagina.grd_4c_Lista.Column1
368:             .Width     = 80
369:             .Alignment = 0
370:             .Header1.Caption = "C" + CHR(243) + "digo"
371:         ENDWITH
372: 
373:         WITH loc_oPagina.grd_4c_Lista.Column2
374:             .Width     = 290

*-- Linhas 382 a 434:
382:             .Header1.Caption = "Tipo"
383:         ENDWITH
384: 
385:         BINDEVENT(loc_oPagina.grd_4c_Lista, "DblClick", THIS, "BtnVisualizarClick")
386: 
387:         THIS.TornarControlesVisiveis(loc_oPagina)
388:     ENDPROC
389: 
390:     *===========================================================================
391:     * ConfigurarPaginaDados - Page2: container botoes acao (Confirmar/Cancelar)
392:     * Campos e grids de dados adicionados nas Fases 4-6
393:     *===========================================================================
394:     PROTECTED PROCEDURE ConfigurarPaginaDados()
395:         LOCAL loc_oPagina
396:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
397: 
398:         loc_oPagina.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
399: 
400:         *----------------------------------------------------------------------
401:         * Container BotoesAcao - Confirmar / Cancelar
402:         * Grupo_Salva no legado: Top=4. Com compensacao +29: Top=33
403:         *----------------------------------------------------------------------
404:         loc_oPagina.AddObject("cnt_4c_BotoesAcao", "Container")
405:         WITH loc_oPagina.cnt_4c_BotoesAcao
406:             .Top         = 33
407:             .Left        = 842
408:             .Width       = 160
409:             .Height      = 85
410:             .BackStyle = 1
411:             .BackColor   = RGB(255, 255, 255)
412:             .BorderWidth = 0
413:             .Visible     = .T.
414:         ENDWITH
415: 
416:         loc_oPagina.cnt_4c_BotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
417:         WITH loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar
418:             .Caption         = "Confirmar"
419:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
420:             .PicturePosition = 13
421:             .Top             = 5
422:             .Left            = 5
423:             .Width           = 75
424:             .Height          = 75
425:             .FontName        = "Tahoma"
426:             .FontBold        = .T.
427:             .FontItalic      = .T.
428:             .FontSize        = 8
429:             .ForeColor       = RGB(90, 90, 90)
430:             .BackColor       = RGB(255, 255, 255)
431:             .Themes          = .F.
432:             .SpecialEffect   = 0
433:             .MousePointer    = 15
434:             .WordWrap        = .T.

*-- Linhas 459 a 503:
459:             .Visible         = .T.
460:         ENDWITH
461: 
462:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
463:         BINDEVENT(loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
464: 
465:         *----------------------------------------------------------------------
466:         * FASE 5: Campos escalares da Page2
467:         * Tops = valor_original_SCX + 29 (compensacao PageFrame.Top=-29)
468:         *----------------------------------------------------------------------
469: 
470:         *-- Linha 1: Codigo (Top=121->150) + Tipos (Top=121->150)
471:         loc_oPagina.AddObject("lbl_4c_Label1", "Label")
472:         WITH loc_oPagina.lbl_4c_Label1
473:             .Caption   = "C" + CHR(243) + "digo :"
474:             .Top       = 153
475:             .Left      = 125
476:             .Width     = 42
477:             .Height    = 17
478:             .AutoSize  = .F.
479:             .FontName  = "Tahoma"
480:             .FontSize  = 8
481:             .FontBold  = .F.
482:             .ForeColor = RGB(90, 90, 90)
483:             .BackStyle = 0
484:             .Visible   = .T.
485:         ENDWITH
486: 
487:         loc_oPagina.AddObject("txt_4c_Codigos", "TextBox")
488:         WITH loc_oPagina.txt_4c_Codigos
489:             .Value     = ""
490:             .Top       = 150
491:             .Left      = 171
492:             .Width     = 80
493:             .Height    = 23
494:             .MaxLength = 10
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .Visible   = .T.
498:         ENDWITH
499: 
500:         loc_oPagina.AddObject("lbl_4c_Label3", "Label")
501:         WITH loc_oPagina.lbl_4c_Label3
502:             .Caption   = "Tipos :"
503:             .Top       = 153

*-- Linhas 525 a 568:
525:             .FontSize  = 8
526:             .Visible   = .T.
527:         ENDWITH
528:         BINDEVENT(loc_oPagina.txt_4c_Tipos, "KeyPress", THIS, "ValidarTipos")
529: 
530:         loc_oPagina.AddObject("lbl_4c_Label4", "Label")
531:         WITH loc_oPagina.lbl_4c_Label4
532:             .Caption   = "< D >esconto  < A >cr" + CHR(233) + "scimo"
533:             .Top       = 147
534:             .Left      = 323
535:             .Width     = 85
536:             .Height    = 30
537:             .AutoSize  = .F.
538:             .WordWrap  = .T.
539:             .FontName  = "Tahoma"
540:             .FontSize  = 8
541:             .FontBold  = .F.
542:             .ForeColor = RGB(90, 90, 90)
543:             .BackStyle = 0
544:             .Visible   = .T.
545:         ENDWITH
546: 
547:         *-- Linha 2: Descricao (Top=145->174)
548:         loc_oPagina.AddObject("lbl_4c_Label2", "Label")
549:         WITH loc_oPagina.lbl_4c_Label2
550:             .Caption   = "Descri" + CHR(231) + CHR(227) + "o :"
551:             .Top       = 177
552:             .Left      = 112
553:             .Width     = 60
554:             .Height    = 17
555:             .AutoSize  = .F.
556:             .FontName  = "Tahoma"
557:             .FontSize  = 8
558:             .FontBold  = .F.
559:             .ForeColor = RGB(90, 90, 90)
560:             .BackStyle = 0
561:             .Visible   = .T.
562:         ENDWITH
563: 
564:         loc_oPagina.AddObject("txt_4c_Descrs", "TextBox")
565:         WITH loc_oPagina.txt_4c_Descrs
566:             .Value     = ""
567:             .Top       = 174
568:             .Left      = 171

*-- Linhas 574 a 766:
574:             .Visible   = .T.
575:         ENDWITH
576: 
577:         *-- Linha 3: Bloquear Desconto BIN - Optiongroup12 (Top=169->198)
578:         loc_oPagina.AddObject("lbl_4c_Label58", "Label")
579:         WITH loc_oPagina.lbl_4c_Label58
580:             .Caption   = "Bloquear Desconto BIN :"
581:             .Top       = 200
582:             .Left      = 48
583:             .Width     = 120
584:             .Height    = 17
585:             .AutoSize  = .F.
586:             .FontName  = "Tahoma"
587:             .FontSize  = 8
588:             .FontBold  = .F.
589:             .ForeColor = RGB(90, 90, 90)
590:             .BackStyle = 0
591:             .Visible   = .T.
592:         ENDWITH
593: 
594:         loc_oPagina.AddObject("opt_4c_Optiongroup12", "OptionGroup")
595:         WITH loc_oPagina.opt_4c_Optiongroup12
596:             .ButtonCount = 2
597:             .Top         = 198
598:             .Left        = 171
599:             .Width       = 97
600:             .Height      = 20
601:             .BackStyle   = 0
602:             .BorderStyle = 0
603:             .Value       = 2
604:             .Visible     = .T.
605:         ENDWITH
606:         WITH loc_oPagina.opt_4c_Optiongroup12.Buttons(1)
607:             .Caption   = "Sim"
608:             .Left      = 5
609:             .Top       = 1
610:             .Width     = 40
611:             .Height    = 17
612:             .AutoSize  = .F.
613:             .FontName  = "Tahoma"
614:             .FontSize  = 8
615:             .ForeColor = RGB(90, 90, 90)
616:             .BackStyle = 0
617:         ENDWITH
618:         WITH loc_oPagina.opt_4c_Optiongroup12.Buttons(2)
619:             .Caption   = "N" + CHR(227) + "o"
620:             .Left      = 47
621:             .Top       = 1
622:             .Width     = 40
623:             .Height    = 17
624:             .AutoSize  = .F.
625:             .FontName  = "Tahoma"
626:             .FontSize  = 8
627:             .ForeColor = RGB(90, 90, 90)
628:             .BackStyle = 0
629:         ENDWITH
630: 
631:         *-- Linha 4: Nao Gerar Bonus - Optiongroup1 (Top=191->220)
632:         loc_oPagina.AddObject("lbl_4c_Label5", "Label")
633:         WITH loc_oPagina.lbl_4c_Label5
634:             .Caption   = "N" + CHR(227) + "o Gerar Bonus:"
635:             .Top       = 222
636:             .Left      = 80
637:             .Width     = 90
638:             .Height    = 17
639:             .AutoSize  = .F.
640:             .FontName  = "Tahoma"
641:             .FontSize  = 8
642:             .FontBold  = .F.
643:             .ForeColor = RGB(90, 90, 90)
644:             .BackStyle = 0
645:             .Visible   = .T.
646:         ENDWITH
647: 
648:         loc_oPagina.AddObject("opt_4c_Optiongroup1", "OptionGroup")
649:         WITH loc_oPagina.opt_4c_Optiongroup1
650:             .ButtonCount = 2
651:             .Top         = 220
652:             .Left        = 171
653:             .Width       = 97
654:             .Height      = 20
655:             .BackStyle   = 0
656:             .BorderStyle = 0
657:             .Value       = 2
658:             .Visible     = .T.
659:         ENDWITH
660:         WITH loc_oPagina.opt_4c_Optiongroup1.Buttons(1)
661:             .Caption   = "Sim"
662:             .Left      = 5
663:             .Top       = 1
664:             .Width     = 40
665:             .Height    = 17
666:             .AutoSize  = .F.
667:             .FontName  = "Tahoma"
668:             .FontSize  = 8
669:             .ForeColor = RGB(90, 90, 90)
670:             .BackStyle = 0
671:         ENDWITH
672:         WITH loc_oPagina.opt_4c_Optiongroup1.Buttons(2)
673:             .Caption   = "N" + CHR(227) + "o"
674:             .Left      = 47
675:             .Top       = 1
676:             .Width     = 40
677:             .Height    = 17
678:             .AutoSize  = .F.
679:             .FontName  = "Tahoma"
680:             .FontSize  = 8
681:             .ForeColor = RGB(90, 90, 90)
682:             .BackStyle = 0
683:         ENDWITH
684: 
685:         *-- Linha 5: Bloquear Tab.Desconto - Optiongroup2 (Top=213->242)
686:         loc_oPagina.AddObject("lbl_4c_Label6", "Label")
687:         WITH loc_oPagina.lbl_4c_Label6
688:             .Caption   = "Bloquear Tab.Desconto :"
689:             .Top       = 244
690:             .Left      = 46
691:             .Width     = 125
692:             .Height    = 17
693:             .AutoSize  = .F.
694:             .FontName  = "Tahoma"
695:             .FontSize  = 8
696:             .FontBold  = .F.
697:             .ForeColor = RGB(90, 90, 90)
698:             .BackStyle = 0
699:             .Visible   = .T.
700:         ENDWITH
701: 
702:         loc_oPagina.AddObject("opt_4c_Optiongroup2", "OptionGroup")
703:         WITH loc_oPagina.opt_4c_Optiongroup2
704:             .ButtonCount = 2
705:             .Top         = 242
706:             .Left        = 171
707:             .Width       = 97
708:             .Height      = 20
709:             .BackStyle   = 0
710:             .BorderStyle = 0
711:             .Value       = 2
712:             .Visible     = .T.
713:         ENDWITH
714:         WITH loc_oPagina.opt_4c_Optiongroup2.Buttons(1)
715:             .Caption   = "Sim"
716:             .Left      = 5
717:             .Top       = 1
718:             .Width     = 40
719:             .Height    = 17
720:             .AutoSize  = .F.
721:             .FontName  = "Tahoma"
722:             .FontSize  = 8
723:             .ForeColor = RGB(90, 90, 90)
724:             .BackStyle = 0
725:         ENDWITH
726:         WITH loc_oPagina.opt_4c_Optiongroup2.Buttons(2)
727:             .Caption   = "N" + CHR(227) + "o"
728:             .Left      = 47
729:             .Top       = 1
730:             .Width     = 40
731:             .Height    = 17
732:             .AutoSize  = .F.
733:             .FontName  = "Tahoma"
734:             .FontSize  = 8
735:             .ForeColor = RGB(90, 90, 90)
736:             .BackStyle = 0
737:         ENDWITH
738: 
739:         *-- Linha 6: Periodo (PerInis Top=235->264, PerFins Top=235->264)
740:         loc_oPagina.AddObject("lbl_4c_Label9", "Label")
741:         WITH loc_oPagina.lbl_4c_Label9
742:             .Caption   = "Per" + CHR(237) + "odo :"
743:             .Top       = 267
744:             .Left      = 122
745:             .Width     = 50
746:             .Height    = 17
747:             .AutoSize  = .F.
748:             .FontName  = "Tahoma"
749:             .FontSize  = 8
750:             .FontBold  = .F.
751:             .ForeColor = RGB(90, 90, 90)
752:             .BackStyle = 0
753:             .Visible   = .T.
754:         ENDWITH
755: 
756:         loc_oPagina.AddObject("txt_4c_PerInis", "TextBox")
757:         WITH loc_oPagina.txt_4c_PerInis
758:             .Value    = {}
759:             .Top      = 264
760:             .Left     = 171
761:             .Width    = 80
762:             .Height   = 23
763:             .FontName = "Tahoma"
764:             .FontSize = 8
765:             .Visible  = .T.
766:         ENDWITH

*-- Linhas 853 a 916:
853:             .Visible   = .T.
854:         ENDWITH
855: 
856:         BINDEVENT(loc_oPagina.txt_4c_GGrus, "KeyPress", THIS, "ValidarGGrus")
857:         BINDEVENT(loc_oPagina.txt_4c_SGrus, "KeyPress", THIS, "ValidarSGrus")
858: 
859:         *-- Linha 8: Tipo de Desconto - OptTpDescs (Top=282->311)
860:         loc_oPagina.AddObject("lbl_4c_Label14", "Label")
861:         WITH loc_oPagina.lbl_4c_Label14
862:             .Caption   = "Tipo de Desconto :"
863:             .Top       = 315
864:             .Left      = 75
865:             .Width     = 95
866:             .Height    = 17
867:             .AutoSize  = .F.
868:             .FontName  = "Tahoma"
869:             .FontSize  = 8
870:             .FontBold  = .F.
871:             .ForeColor = RGB(90, 90, 90)
872:             .BackStyle = 0
873:             .Visible   = .T.
874:         ENDWITH
875: 
876:         loc_oPagina.AddObject("opt_4c_OptTpDescs", "OptionGroup")
877:         WITH loc_oPagina.opt_4c_OptTpDescs
878:             .ButtonCount = 2
879:             .Top         = 311
880:             .Left        = 171
881:             .Width       = 152
882:             .Height      = 25
883:             .BackStyle   = 0
884:             .BorderStyle = 0
885:             .Value       = 1
886:             .Visible     = .T.
887:         ENDWITH
888:         WITH loc_oPagina.opt_4c_OptTpDescs.Buttons(1)
889:             .Caption   = "Geral"
890:             .Left      = 5
891:             .Top       = 5
892:             .Width     = 43
893:             .Height    = 15
894:             .AutoSize  = .T.
895:             .FontName  = "Tahoma"
896:             .FontSize  = 8
897:             .ForeColor = RGB(90, 90, 90)
898:             .BackStyle = 0
899:         ENDWITH
900:         WITH loc_oPagina.opt_4c_OptTpDescs.Buttons(2)
901:             .Caption   = "por Produto"
902:             .Left      = 67
903:             .Top       = 5
904:             .Width     = 75
905:             .Height    = 15
906:             .AutoSize  = .T.
907:             .FontName  = "Tahoma"
908:             .FontSize  = 8
909:             .ForeColor = RGB(90, 90, 90)
910:             .BackStyle = 0
911:         ENDWITH
912: 
913:         *-- Linha 9: Limite de Desconto (Top=307->336)
914:         loc_oPagina.AddObject("lbl_4c_Label15", "Label")
915:         WITH loc_oPagina.lbl_4c_Label15
916:             .Caption   = "Limite de Desconto :"

*-- Linhas 941 a 1025:
941:             .Visible   = .T.
942:         ENDWITH
943: 
944:         *-- Linha 10: Checar Dt. Aniversario - Optiongroup3 (Top=332->361)
945:         loc_oPagina.AddObject("lbl_4c_Label16", "Label")
946:         WITH loc_oPagina.lbl_4c_Label16
947:             .Caption   = "Checar Dt. Anivers" + CHR(225) + "rio :"
948:             .Top       = 363
949:             .Left      = 49
950:             .Width     = 125
951:             .Height    = 17
952:             .AutoSize  = .F.
953:             .FontName  = "Tahoma"
954:             .FontSize  = 8
955:             .FontBold  = .F.
956:             .ForeColor = RGB(90, 90, 90)
957:             .BackStyle = 0
958:             .Visible   = .T.
959:         ENDWITH
960: 
961:         loc_oPagina.AddObject("opt_4c_Optiongroup3", "OptionGroup")
962:         WITH loc_oPagina.opt_4c_Optiongroup3
963:             .ButtonCount = 2
964:             .Top         = 361
965:             .Left        = 171
966:             .Width       = 97
967:             .Height      = 20
968:             .BackStyle   = 0
969:             .BorderStyle = 0
970:             .Value       = 2
971:             .Visible     = .T.
972:         ENDWITH
973:         WITH loc_oPagina.opt_4c_Optiongroup3.Buttons(1)
974:             .Caption   = "Sim"
975:             .Left      = 5
976:             .Top       = 1
977:             .Width     = 40
978:             .Height    = 17
979:             .AutoSize  = .F.
980:             .FontName  = "Tahoma"
981:             .FontSize  = 8
982:             .ForeColor = RGB(90, 90, 90)
983:             .BackStyle = 0
984:         ENDWITH
985:         WITH loc_oPagina.opt_4c_Optiongroup3.Buttons(2)
986:             .Caption   = "N" + CHR(227) + "o"
987:             .Left      = 47
988:             .Top       = 1
989:             .Width     = 40
990:             .Height    = 17
991:             .AutoSize  = .F.
992:             .FontName  = "Tahoma"
993:             .FontSize  = 8
994:             .ForeColor = RGB(90, 90, 90)
995:             .BackStyle = 0
996:         ENDWITH
997: 
998:         *----------------------------------------------------------------------
999:         * Label "Operacoes" (Say8 legado: Top=124+29=153, Left=508)
1000:         *----------------------------------------------------------------------
1001:         loc_oPagina.AddObject("lbl_4c_Label8", "Label")
1002:         WITH loc_oPagina.lbl_4c_Label8
1003:             .Caption   = "Opera" + CHR(231) + CHR(245) + "es"
1004:             .Top       = 153
1005:             .Left      = 508
1006:             .Width     = 100
1007:             .Height    = 13
1008:             .AutoSize  = .F.
1009:             .FontName  = "Tahoma"
1010:             .FontSize  = 8
1011:             .FontBold  = .F.
1012:             .ForeColor = RGB(90, 90, 90)
1013:             .BackStyle = 0
1014:             .Visible   = .T.
1015:         ENDWITH
1016: 
1017:         *----------------------------------------------------------------------
1018:         * Label "Empresas" (Say7 legado: Top=359+29=388, Left=61)
1019:         *----------------------------------------------------------------------
1020:         loc_oPagina.AddObject("lbl_4c_Label7", "Label")
1021:         WITH loc_oPagina.lbl_4c_Label7
1022:             .Caption   = "Empresas"
1023:             .Top       = 388
1024:             .Left      = 61
1025:             .Width     = 60

*-- Linhas 1107 a 1153:
1107:         ENDWITH
1108:         loc_oPagina.grd_4c_Opers.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
1109: 
1110:         BINDEVENT(loc_oPagina.grd_4c_Opers.Column1.Check1, "MouseDown", THIS, "OperCheckboxMouseDown")
1111:         BINDEVENT(loc_oPagina.grd_4c_Opers.Column1.Check1, "MouseUp",   THIS, "OperCheckboxMouseUp")
1112:         BINDEVENT(loc_oPagina.grd_4c_Opers.Column1.Check1, "Click",     THIS, "OperCheckboxClick")
1113:         BINDEVENT(loc_oPagina.grd_4c_Opers.Column1.Check1, "KeyPress",  THIS, "OperCheckboxKeyPress")
1114: 
1115:         *----------------------------------------------------------------------
1116:         * Container botoes MarcaTodos/DesmarcaTodos Operacoes
1117:         * (Commandgroup1 legado: Top=157+29=186, Left=708, W=50, H=90)
1118:         *----------------------------------------------------------------------
1119:         loc_oPagina.AddObject("cnt_4c_CmdOpers", "Container")
1120:         WITH loc_oPagina.cnt_4c_CmdOpers
1121:             .Top         = 186
1122:             .Left        = 708
1123:             .Width       = 50
1124:             .Height      = 90
1125:             .BackStyle = 1
1126:             .BackColor = RGB(255, 255, 255)
1127:             .BorderWidth = 0
1128:             .Visible     = .T.
1129:         ENDWITH
1130: 
1131:         loc_oPagina.cnt_4c_CmdOpers.AddObject("cmd_4c_MarcaOpers", "CommandButton")
1132:         WITH loc_oPagina.cnt_4c_CmdOpers.cmd_4c_MarcaOpers
1133:             .Caption         = ""
1134:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1135:             .PicturePosition = 13
1136:             .ToolTipText     = "Marcar todos"
1137:             .Top             = 5
1138:             .Left            = 5
1139:             .Width           = 40
1140:             .Height          = 40
1141:             .Themes          = .T.
1142:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1143:             .MousePointer    = 15
1144:             .Visible         = .T.
1145:         ENDWITH
1146: 
1147:         loc_oPagina.cnt_4c_CmdOpers.AddObject("cmd_4c_DesmarcaOpers", "CommandButton")
1148:         WITH loc_oPagina.cnt_4c_CmdOpers.cmd_4c_DesmarcaOpers
1149:             .Caption         = ""
1150:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1151:             .PicturePosition = 13
1152:             .ToolTipText     = "Desmarcar todos"
1153:             .Top             = 45

*-- Linhas 1160 a 1204:
1160:             .Visible         = .T.
1161:         ENDWITH
1162: 
1163:         BINDEVENT(loc_oPagina.cnt_4c_CmdOpers.cmd_4c_MarcaOpers,    "Click", THIS, "MarcaTodosOpersClick")
1164:         BINDEVENT(loc_oPagina.cnt_4c_CmdOpers.cmd_4c_DesmarcaOpers, "Click", THIS, "DesmarcaTodosOpersClick")
1165: 
1166:         *----------------------------------------------------------------------
1167:         * Grid Empresas (grdEmps legado: Top=376+29=405, Left=59, W=276, H=207)
1168:         * Col1: CheckBox/Imps (W=20), Col2: Text/Emps (W=30), Col3: Text/Razas (W=200)
1169:         *----------------------------------------------------------------------
1170:         loc_oPagina.AddObject("grd_4c_Emps", "Grid")
1171:         WITH loc_oPagina.grd_4c_Emps
1172:             .Top         = 405
1173:             .Left        = 59
1174:             .Width       = 276
1175:             .Height      = 207
1176:             .ColumnCount = 3
1177:             .FontName    = "Tahoma"
1178:             .FontSize    = 8
1179:             .GridLines   = 2
1180:             .RecordMark  = .F.
1181:             .DeleteMark  = .F.
1182:             .ScrollBars  = 2
1183:             .ReadOnly    = .F.
1184:             .Movable     = .F.
1185:             .Resizable   = .F.
1186:             .Visible     = .T.
1187:         ENDWITH
1188: 
1189:         *-- Column1: CheckBox para Imps
1190:         WITH loc_oPagina.grd_4c_Emps.Column1
1191:             .Width     = 20
1192:             .Movable   = .F.
1193:             .Resizable = .F.
1194:             .ReadOnly  = .F.
1195:             .Sparse    = .F.
1196:         ENDWITH
1197:         loc_oPagina.grd_4c_Emps.Column1.Header1.Caption   = ""
1198:         loc_oPagina.grd_4c_Emps.Column1.Header1.Alignment = 2
1199:         loc_oPagina.grd_4c_Emps.Column1.AddObject("check12", "CheckBox")
1200:         WITH loc_oPagina.grd_4c_Emps.Column1.check12
1201:             .Caption   = ""
1202:             .Alignment = 0
1203:             .ReadOnly  = .F.
1204:             .Visible   = .T.

*-- Linhas 1229 a 1275:
1229:         ENDWITH
1230:         loc_oPagina.grd_4c_Emps.Column3.Header1.Caption = "Raz" + CHR(227) + "o Social"
1231: 
1232:         BINDEVENT(loc_oPagina.grd_4c_Emps.Column1.Check1, "MouseDown", THIS, "EmpCheckboxMouseDown")
1233:         BINDEVENT(loc_oPagina.grd_4c_Emps.Column1.Check1, "MouseUp",   THIS, "EmpCheckboxMouseUp")
1234:         BINDEVENT(loc_oPagina.grd_4c_Emps.Column1.Check1, "Click",     THIS, "EmpCheckboxClick")
1235:         BINDEVENT(loc_oPagina.grd_4c_Emps.Column1.Check1, "KeyPress",  THIS, "EmpCheckboxKeyPress")
1236: 
1237:         *----------------------------------------------------------------------
1238:         * Container botoes MarcaTodos/DesmarcaTodos Empresas
1239:         * (cmdEmps legado: Top=391+29=420, Left=336, W=50, H=90)
1240:         *----------------------------------------------------------------------
1241:         loc_oPagina.AddObject("cnt_4c_CmdEmps", "Container")
1242:         WITH loc_oPagina.cnt_4c_CmdEmps
1243:             .Top         = 420
1244:             .Left        = 336
1245:             .Width       = 50
1246:             .Height      = 90
1247:             .BackStyle = 1
1248:             .BackColor = RGB(255, 255, 255)
1249:             .BorderWidth = 0
1250:             .Visible     = .T.
1251:         ENDWITH
1252: 
1253:         loc_oPagina.cnt_4c_CmdEmps.AddObject("cmd_4c_MarcaEmps", "CommandButton")
1254:         WITH loc_oPagina.cnt_4c_CmdEmps.cmd_4c_MarcaEmps
1255:             .Caption         = ""
1256:             .Picture         = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1257:             .PicturePosition = 13
1258:             .ToolTipText     = "Marcar todos"
1259:             .Top             = 5
1260:             .Left            = 5
1261:             .Width           = 40
1262:             .Height          = 40
1263:             .Themes          = .T.
1264:             .DisabledPicture = gc_4c_CaminhoIcones + "geral_marcar_26.jpg"
1265:             .MousePointer    = 15
1266:             .Visible         = .T.
1267:         ENDWITH
1268: 
1269:         loc_oPagina.cnt_4c_CmdEmps.AddObject("cmd_4c_DesmarcaEmps", "CommandButton")
1270:         WITH loc_oPagina.cnt_4c_CmdEmps.cmd_4c_DesmarcaEmps
1271:             .Caption         = ""
1272:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1273:             .PicturePosition = 13
1274:             .ToolTipText     = "Desmarcar todos"
1275:             .Top             = 45

*-- Linhas 1282 a 1409:
1282:             .Visible         = .T.
1283:         ENDWITH
1284: 
1285:         BINDEVENT(loc_oPagina.cnt_4c_CmdEmps.cmd_4c_MarcaEmps,    "Click", THIS, "MarcaTodosEmpsClick")
1286:         BINDEVENT(loc_oPagina.cnt_4c_CmdEmps.cmd_4c_DesmarcaEmps, "Click", THIS, "DesmarcaTodosEmpsClick")
1287: 
1288:         *----------------------------------------------------------------------
1289:         * Grid Composicoes (GrdCompo legado: Top=376+29=405, Left=431, W=276, H=207)
1290:         * Col1: Text/Compos editavel (W=244) com lookup
1291:         *----------------------------------------------------------------------
1292:         loc_oPagina.AddObject("grd_4c_Compo", "Grid")
1293:         WITH loc_oPagina.grd_4c_Compo
1294:             .Top         = 405
1295:             .Left        = 431
1296:             .Width       = 276
1297:             .Height      = 207
1298:             .ColumnCount = 1
1299:             .FontName    = "Tahoma"
1300:             .FontSize    = 8
1301:             .GridLines   = 2
1302:             .RecordMark  = .F.
1303:             .DeleteMark  = .F.
1304:             .ScrollBars  = 2
1305:             .ReadOnly    = .F.
1306:             .Movable     = .F.
1307:             .Resizable   = .F.
1308:             .Visible     = .T.
1309:         ENDWITH
1310: 
1311:         WITH loc_oPagina.grd_4c_Compo.Column1
1312:             .Width     = 244
1313:             .Movable   = .F.
1314:             .Resizable = .F.
1315:             .ReadOnly  = .F.
1316:         ENDWITH
1317:         loc_oPagina.grd_4c_Compo.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
1318: 
1319:         BINDEVENT(loc_oPagina.grd_4c_Compo.Column1.Text1, "Valid", THIS, "CompoTextValid")
1320: 
1321:         *----------------------------------------------------------------------
1322:         * Botao Inserir Composicao (cmdInserir legado: Top=397+29=426, Left=712, 40x40)
1323:         *----------------------------------------------------------------------
1324:         loc_oPagina.AddObject("cmd_4c_InserirCompo", "CommandButton")
1325:         WITH loc_oPagina.cmd_4c_InserirCompo
1326:             .Caption         = ""
1327:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1328:             .PicturePosition = 13
1329:             .ToolTipText     = "Inserir composi" + CHR(231) + CHR(227) + "o"
1330:             .Top             = 426
1331:             .Left            = 712
1332:             .Width           = 40
1333:             .Height          = 40
1334:             .Themes          = .T.
1335:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
1336:             .MousePointer    = 15
1337:             .Visible         = .T.
1338:         ENDWITH
1339: 
1340:         *----------------------------------------------------------------------
1341:         * Botao Excluir Composicao (cmdExcluir legado: Top=437+29=466, Left=712, 40x40)
1342:         *----------------------------------------------------------------------
1343:         loc_oPagina.AddObject("cmd_4c_ExcluirCompo", "CommandButton")
1344:         WITH loc_oPagina.cmd_4c_ExcluirCompo
1345:             .Caption         = ""
1346:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1347:             .PicturePosition = 13
1348:             .ToolTipText     = "Excluir composi" + CHR(231) + CHR(227) + "o"
1349:             .Top             = 466
1350:             .Left            = 712
1351:             .Width           = 40
1352:             .Height          = 40
1353:             .Themes          = .T.
1354:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
1355:             .MousePointer    = 15
1356:             .Visible         = .T.
1357:         ENDWITH
1358: 
1359:         BINDEVENT(loc_oPagina.cmd_4c_InserirCompo, "Click", THIS, "CompoInserirClick")
1360:         BINDEVENT(loc_oPagina.cmd_4c_ExcluirCompo, "Click", THIS, "CompoExcluirClick")
1361: 
1362:         THIS.TornarControlesVisiveis(loc_oPagina)
1363:     ENDPROC
1364: 
1365:     *===========================================================================
1366:     * CarregarLista - Carrega grid de lista da Page1
1367:     * Fase 4 adiciona o grid e implementa a carga completa de dados
1368:     *===========================================================================
1369:     PROCEDURE CarregarLista()
1370:         LOCAL loc_lResultado, loc_oGrid
1371:         loc_lResultado = .F.
1372: 
1373:         TRY
1374:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1375:                 loc_lResultado = .T.
1376:             ELSE
1377:                 IF VARTYPE(THIS.this_oBusinessObject) = "O"
1378:                     IF THIS.this_oBusinessObject.Buscar("")
1379:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1380: 
1381:                         *-- RecordSource FORA de WITH (Problema 36/48)
1382:                         loc_oGrid.ColumnCount = 3
1383:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
1384: 
1385:                         *-- ControlSource SEMPRE apos RecordSource (Problema 48)
1386:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1387:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
1388:                         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tipos"
1389: 
1390:                         loc_oGrid.Column1.Width     = 80
1391:                         loc_oGrid.Column2.Width     = 290
1392:                         loc_oGrid.Column3.Width     = 40
1393:                         loc_oGrid.Column1.Alignment = 0
1394:                         loc_oGrid.Column2.Alignment = 0
1395:                         loc_oGrid.Column3.Alignment = 2
1396: 
1397:                         *-- Headers OBRIGATORIO apos RecordSource (Problema 6/32)
1398:                         loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1399:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1400:                         loc_oGrid.Column3.Header1.Caption = "Tipo"
1401: 
1402:                         THIS.FormatarGridLista(loc_oGrid)
1403:                         loc_oGrid.Refresh()
1404:                         loc_lResultado = .T.
1405:                     ENDIF
1406:                 ENDIF
1407:             ENDIF
1408:         CATCH TO loException
1409:             MostrarErro("Erro ao carregar lista:" + CHR(13) + loException.Message, ;

*-- Linhas 1415 a 2590:
1415: 
1416:     *===========================================================================
1417:     * BtnEncerrarClick - Fecha o formulario
1418:     * PUBLIC: BINDEVENT requer metodo publico (CLAUDE.md Regra BINDEVENT)
1419:     *===========================================================================
1420:     PROCEDURE BtnEncerrarClick()
1421:         THIS.Release()
1422:     ENDPROC
1423: 
1424:     *===========================================================================
1425:     * BtnSalvarClick - Salva registro (implementado na Fase 7)
1426:     * PUBLIC: BINDEVENT requer metodo publico
1427:     *===========================================================================
1428:     PROCEDURE BtnSalvarClick()
1429:         LOCAL loc_lResultado
1430:         loc_lResultado = .F.
1431: 
1432:         *-- Transferir campos do form para o BO (Problema 16 - validacao ANTES do TRY)
1433:         THIS.FormParaBO()
1434: 
1435:         IF EMPTY(THIS.this_oBusinessObject.this_cCodigos)
1436:             MsgAviso("C" + CHR(243) + "digo do motivo " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
1437:                 "Valida" + CHR(231) + CHR(227) + "o")
1438:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Codigos", 5)
1439:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Codigos.SetFocus
1440:             ENDIF
1441:             RETURN loc_lResultado
1442:         ENDIF
1443: 
1444:         IF EMPTY(THIS.this_oBusinessObject.this_cDescrs)
1445:             MsgAviso("Descri" + CHR(231) + CHR(227) + "o do motivo " + CHR(233) + " obrigat" + CHR(243) + "ria.", ;
1446:                 "Valida" + CHR(231) + CHR(227) + "o")
1447:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Descrs", 5)
1448:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Descrs.SetFocus
1449:             ENDIF
1450:             RETURN loc_lResultado
1451:         ENDIF
1452: 
1453:         IF EMPTY(THIS.this_oBusinessObject.this_cTipos) OR ;
1454:            !INLIST(THIS.this_oBusinessObject.this_cTipos, "D", "A")
1455:             MsgAviso("Tipo deve ser 'D' (Desconto) ou 'A' (Acr" + CHR(233) + "scimo).", ;
1456:                 "Valida" + CHR(231) + CHR(227) + "o")
1457:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "txt_4c_Tipos", 5)
1458:                 THIS.pgf_4c_Paginas.Page2.txt_4c_Tipos.SetFocus
1459:             ENDIF
1460:             RETURN loc_lResultado
1461:         ENDIF
1462: 
1463:         TRY
1464:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
1465:                 IF THIS.this_oBusinessObject.Salvar()
1466:                     *-- Salvar relacionados quando cursores existirem (habilitado em Fase 6+)
1467:                     IF USED("cursor_4c_Emps") OR USED("cursor_4c_Opers") OR USED("cursor_4c_Compos")
1468:                         THIS.this_oBusinessObject.SalvarRelacionados( ;
1469:                             THIS.this_oBusinessObject.this_cCodigos, ;
1470:                             "cursor_4c_Emps", ;
1471:                             "cursor_4c_Opers", ;
1472:                             "cursor_4c_Compos")
1473:                     ENDIF
1474:                     MsgInfo("Registro salvo com sucesso!")
1475:                     THIS.pgf_4c_Paginas.ActivePage = 1
1476:                     THIS.this_cModoAtual = "LISTA"
1477:                     THIS.CarregarLista()
1478:                     loc_lResultado = .T.
1479:                 ENDIF
1480:             ENDIF
1481:         CATCH TO loException
1482:             MostrarErro("Erro ao salvar:" + CHR(13) + loException.Message, ;
1483:                 "FormMda.BtnSalvarClick")
1484:         ENDTRY
1485: 
1486:         RETURN loc_lResultado
1487:     ENDPROC
1488: 
1489:     *===========================================================================
1490:     * BtnCancelarClick - Cancela edicao e retorna para lista
1491:     * PUBLIC: BINDEVENT requer metodo publico
1492:     *===========================================================================
1493:     PROCEDURE BtnCancelarClick()
1494:         THIS.pgf_4c_Paginas.ActivePage = 1
1495:         THIS.this_cModoAtual = "LISTA"
1496:         THIS.CarregarLista()
1497:     ENDPROC
1498: 
1499:     *===========================================================================
1500:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
1501:     *===========================================================================
1502:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1503:         LOCAL loc_lResultado
1504:         loc_lResultado = .F.
1505: 
1506:         TRY
1507:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
1508:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1509:                 IF par_nPagina = 1
1510:                     THIS.CarregarLista()
1511:                 ELSE
1512:                     THIS.AjustarBotoesPorModo()
1513:                 ENDIF
1514:                 loc_lResultado = .T.
1515:             ENDIF
1516:         CATCH TO loException
1517:             MostrarErro("Erro ao alternar p" + CHR(225) + "gina:" + CHR(13) + ;
1518:                 loException.Message, "FormMda.AlternarPagina")
1519:         ENDTRY
1520: 
1521:         RETURN loc_lResultado
1522:     ENDPROC
1523: 
1524:     *===========================================================================
1525:     * BtnIncluirClick - Prepara novo registro para inclusao
1526:     * PUBLIC: BINDEVENT requer metodo publico
1527:     *===========================================================================
1528:     PROCEDURE BtnIncluirClick()
1529:         THIS.this_oBusinessObject.NovoRegistro()
1530:         THIS.LimparCampos()
1531:         THIS.this_cModoAtual = "INCLUIR"
1532:         THIS.HabilitarCampos(.T.)
1533:         THIS.AlternarPagina(2)
1534:         THIS.CarregarRelacionados("")
1535:     ENDPROC
1536: 
1537:     *===========================================================================
1538:     * BtnVisualizarClick - Visualiza registro selecionado (somente leitura)
1539:     * PUBLIC: BINDEVENT requer metodo publico (tambem vinculado ao DblClick do grid)
1540:     *===========================================================================
1541:     PROCEDURE BtnVisualizarClick()
1542:         LOCAL loc_cCodigo
1543:         loc_cCodigo = ""
1544: 
1545:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1546:             SELECT cursor_4c_Dados
1547:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1548:         ENDIF
1549: 
1550:         IF EMPTY(loc_cCodigo)
1551:             MsgAviso("Selecione um registro na lista.", "Visualizar")
1552:             RETURN
1553:         ENDIF
1554: 
1555:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1556:             THIS.this_cModoAtual = "VISUALIZAR"
1557:             THIS.BOParaForm()
1558:             THIS.HabilitarCampos(.F.)
1559:             THIS.AlternarPagina(2)
1560:             THIS.CarregarRelacionados(loc_cCodigo)
1561:         ENDIF
1562:     ENDPROC
1563: 
1564:     *===========================================================================
1565:     * BtnAlterarClick - Carrega registro selecionado para alteracao
1566:     * PUBLIC: BINDEVENT requer metodo publico
1567:     *===========================================================================
1568:     PROCEDURE BtnAlterarClick()
1569:         LOCAL loc_cCodigo
1570:         loc_cCodigo = ""
1571: 
1572:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1573:             SELECT cursor_4c_Dados
1574:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.codigos)
1575:         ENDIF
1576: 
1577:         IF EMPTY(loc_cCodigo)
1578:             MsgAviso("Selecione um registro na lista.", "Alterar")
1579:             RETURN
1580:         ENDIF
1581: 
1582:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1583:             THIS.this_oBusinessObject.EditarRegistro()
1584:             THIS.this_cModoAtual = "ALTERAR"
1585:             THIS.BOParaForm()
1586:             THIS.HabilitarCampos(.T.)
1587:             THIS.AlternarPagina(2)
1588:             THIS.CarregarRelacionados(loc_cCodigo)
1589:         ENDIF
1590:     ENDPROC
1591: 
1592:     *===========================================================================
1593:     * BtnExcluirClick - Exclui registro selecionado apos confirmacao
1594:     * PUBLIC: BINDEVENT requer metodo publico
1595:     *===========================================================================
1596:     PROCEDURE BtnExcluirClick()
1597:         LOCAL loc_cCodigo, loc_cDescricao
1598:         loc_cCodigo    = ""
1599:         loc_cDescricao = ""
1600: 
1601:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
1602:             SELECT cursor_4c_Dados
1603:             loc_cCodigo    = ALLTRIM(cursor_4c_Dados.codigos)
1604:             loc_cDescricao = ALLTRIM(cursor_4c_Dados.descrs)
1605:         ENDIF
1606: 
1607:         IF EMPTY(loc_cCodigo)
1608:             MsgAviso("Selecione um registro na lista.", "Excluir")
1609:             RETURN
1610:         ENDIF
1611: 
1612:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do motivo:" + CHR(13) + ;
1613:                 loc_cCodigo + " - " + loc_cDescricao + "?", ;
1614:                 "Confirmar Exclus" + CHR(227) + "o")
1615:             RETURN
1616:         ENDIF
1617: 
1618:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
1619:             IF THIS.this_oBusinessObject.Excluir()
1620:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!")
1621:                 THIS.CarregarLista()
1622:             ENDIF
1623:         ENDIF
1624:     ENDPROC
1625: 
1626:     *===========================================================================
1627:     * BtnBuscarClick - Abre busca para filtrar registros na lista
1628:     * PUBLIC: BINDEVENT requer metodo publico
1629:     *===========================================================================
1630:     PROCEDURE BtnBuscarClick()
1631:         LOCAL loc_oBusca, loc_cCodigo, loc_oGrid
1632:         loc_cCodigo = ""
1633: 
1634:         TRY
1635:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
1636:                 "SigCdFs", "cursor_4c_BuscaMda", "codigos", "", ;
1637:                 "Buscar Motivo de Desconto / Acr" + CHR(233) + "scimo")
1638: 
1639:             IF VARTYPE(loc_oBusca) = "O"
1640:                 loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
1641:                 loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
1642:                 loc_oBusca.mAddColuna("tipos",   "", "Tipo")
1643:                 loc_oBusca.Show()
1644: 
1645:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMda")
1646:                     SELECT cursor_4c_BuscaMda
1647:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaMda.codigos)
1648:                 ENDIF
1649: 
1650:                 loc_oBusca.Release()
1651:             ENDIF
1652:         CATCH TO loException
1653:             MostrarErro("Erro na busca:" + CHR(13) + loException.Message, ;
1654:                 "FormMda.BtnBuscarClick")
1655:         ENDTRY
1656: 
1657:         IF USED("cursor_4c_BuscaMda")
1658:             USE IN cursor_4c_BuscaMda
1659:         ENDIF
1660: 
1661:         IF !EMPTY(loc_cCodigo)
1662:             IF THIS.this_oBusinessObject.Buscar("codigos = " + EscaparSQL(loc_cCodigo))
1663:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1664:                 loc_oGrid.ColumnCount = 3
1665:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
1666:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.codigos"
1667:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.descrs"
1668:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.tipos"
1669:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1670:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1671:                 loc_oGrid.Column3.Header1.Caption = "Tipo"
1672:                 loc_oGrid.Refresh()
1673:             ENDIF
1674:         ELSE
1675:             THIS.CarregarLista()
1676:         ENDIF
1677:     ENDPROC
1678: 
1679:     *===========================================================================
1680:     * FormParaBO - Transfere valores dos campos de Page2 para o BO
1681:     * Controles verificados com PEMSTATUS para compatibilidade multi-fase
1682:     *===========================================================================
1683:     PROTECTED PROCEDURE FormParaBO()
1684:         LOCAL loc_oPagina
1685:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1686: 
1687:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1688:             THIS.this_oBusinessObject.this_cCodigos = ALLTRIM(loc_oPagina.txt_4c_Codigos.Value)
1689:         ENDIF
1690:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
1691:             THIS.this_oBusinessObject.this_cDescrs = ALLTRIM(loc_oPagina.txt_4c_Descrs.Value)
1692:         ENDIF
1693:         IF PEMSTATUS(loc_oPagina, "txt_4c_Tipos", 5)
1694:             THIS.this_oBusinessObject.this_cTipos = ALLTRIM(loc_oPagina.txt_4c_Tipos.Value)
1695:         ENDIF
1696:         IF PEMSTATUS(loc_oPagina, "txt_4c_LimDescs", 5)
1697:             THIS.this_oBusinessObject.this_nLimdescs = loc_oPagina.txt_4c_LimDescs.Value
1698:         ENDIF
1699:         IF PEMSTATUS(loc_oPagina, "txt_4c_PerInis", 5)
1700:             THIS.this_oBusinessObject.this_dPerinis = loc_oPagina.txt_4c_PerInis.Value
1701:         ENDIF
1702:         IF PEMSTATUS(loc_oPagina, "txt_4c_PerFins", 5)
1703:             THIS.this_oBusinessObject.this_dPerfins = loc_oPagina.txt_4c_PerFins.Value
1704:         ENDIF
1705:         IF PEMSTATUS(loc_oPagina, "txt_4c_GGrus", 5)
1706:             THIS.this_oBusinessObject.this_cGgrus = ALLTRIM(loc_oPagina.txt_4c_GGrus.Value)
1707:         ENDIF
1708:         IF PEMSTATUS(loc_oPagina, "txt_4c_SGrus", 5)
1709:             THIS.this_oBusinessObject.this_cSgrus = ALLTRIM(loc_oPagina.txt_4c_SGrus.Value)
1710:         ENDIF
1711:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup12", 5)
1712:             THIS.this_oBusinessObject.this_nChkbins = IIF(loc_oPagina.opt_4c_Optiongroup12.Value = 1, 1, 0)
1713:         ENDIF
1714:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup1", 5)
1715:             THIS.this_oBusinessObject.this_nBlqbonus = IIF(loc_oPagina.opt_4c_Optiongroup1.Value = 1, 1, 0)
1716:         ENDIF
1717:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup2", 5)
1718:             THIS.this_oBusinessObject.this_nBlqtabds = IIF(loc_oPagina.opt_4c_Optiongroup2.Value = 1, 1, 0)
1719:         ENDIF
1720:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup3", 5)
1721:             THIS.this_oBusinessObject.this_nChkdtanivs = IIF(loc_oPagina.opt_4c_Optiongroup3.Value = 1, 1, 0)
1722:         ENDIF
1723:         IF PEMSTATUS(loc_oPagina, "opt_4c_OptTpDescs", 5)
1724:             THIS.this_oBusinessObject.this_nTpdescs = loc_oPagina.opt_4c_OptTpDescs.Value - 1
1725:         ENDIF
1726:     ENDPROC
1727: 
1728:     *===========================================================================
1729:     * BOParaForm - Transfere valores do BO para os campos de Page2
1730:     * Controles verificados com PEMSTATUS para compatibilidade multi-fase
1731:     *===========================================================================
1732:     PROTECTED PROCEDURE BOParaForm()
1733:         LOCAL loc_oPagina
1734:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1735: 
1736:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1737:             loc_oPagina.txt_4c_Codigos.Value = THIS.this_oBusinessObject.this_cCodigos
1738:         ENDIF
1739:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
1740:             loc_oPagina.txt_4c_Descrs.Value = THIS.this_oBusinessObject.this_cDescrs
1741:         ENDIF
1742:         IF PEMSTATUS(loc_oPagina, "txt_4c_Tipos", 5)
1743:             loc_oPagina.txt_4c_Tipos.Value = THIS.this_oBusinessObject.this_cTipos
1744:         ENDIF
1745:         IF PEMSTATUS(loc_oPagina, "txt_4c_LimDescs", 5)
1746:             loc_oPagina.txt_4c_LimDescs.Value = THIS.this_oBusinessObject.this_nLimdescs
1747:         ENDIF
1748:         IF PEMSTATUS(loc_oPagina, "txt_4c_PerInis", 5)
1749:             loc_oPagina.txt_4c_PerInis.Value = THIS.this_oBusinessObject.this_dPerinis
1750:         ENDIF
1751:         IF PEMSTATUS(loc_oPagina, "txt_4c_PerFins", 5)
1752:             loc_oPagina.txt_4c_PerFins.Value = THIS.this_oBusinessObject.this_dPerfins
1753:         ENDIF
1754:         IF PEMSTATUS(loc_oPagina, "txt_4c_GGrus", 5)
1755:             loc_oPagina.txt_4c_GGrus.Value = THIS.this_oBusinessObject.this_cGgrus
1756:         ENDIF
1757:         IF PEMSTATUS(loc_oPagina, "txt_4c_SGrus", 5)
1758:             loc_oPagina.txt_4c_SGrus.Value = THIS.this_oBusinessObject.this_cSgrus
1759:         ENDIF
1760:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup12", 5)
1761:             loc_oPagina.opt_4c_Optiongroup12.Value = IIF(THIS.this_oBusinessObject.this_nChkbins = 1, 1, 2)
1762:         ENDIF
1763:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup1", 5)
1764:             loc_oPagina.opt_4c_Optiongroup1.Value = IIF(THIS.this_oBusinessObject.this_nBlqbonus = 1, 1, 2)
1765:         ENDIF
1766:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup2", 5)
1767:             loc_oPagina.opt_4c_Optiongroup2.Value = IIF(THIS.this_oBusinessObject.this_nBlqtabds = 1, 1, 2)
1768:         ENDIF
1769:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup3", 5)
1770:             loc_oPagina.opt_4c_Optiongroup3.Value = IIF(THIS.this_oBusinessObject.this_nChkdtanivs = 1, 1, 2)
1771:         ENDIF
1772:         IF PEMSTATUS(loc_oPagina, "opt_4c_OptTpDescs", 5)
1773:             loc_oPagina.opt_4c_OptTpDescs.Value = THIS.this_oBusinessObject.this_nTpdescs + 1
1774:         ENDIF
1775:     ENDPROC
1776: 
1777:     *===========================================================================
1778:     * HabilitarCampos - Habilita/desabilita campos editaveis de Page2
1779:     *===========================================================================
1780:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
1781:         LOCAL loc_oPagina, loc_lEditar
1782:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1783:         loc_lEditar = (par_lHabilitar = .T.)
1784: 
1785:         *-- Codigo: editavel apenas no INCLUIR
1786:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1787:             loc_oPagina.txt_4c_Codigos.ReadOnly = !(loc_lEditar AND THIS.this_cModoAtual = "INCLUIR")
1788:         ENDIF
1789:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
1790:             loc_oPagina.txt_4c_Descrs.ReadOnly = !loc_lEditar
1791:         ENDIF
1792:         IF PEMSTATUS(loc_oPagina, "txt_4c_Tipos", 5)
1793:             loc_oPagina.txt_4c_Tipos.ReadOnly = !loc_lEditar
1794:         ENDIF
1795:         IF PEMSTATUS(loc_oPagina, "txt_4c_LimDescs", 5)
1796:             loc_oPagina.txt_4c_LimDescs.ReadOnly = !loc_lEditar
1797:         ENDIF
1798:         IF PEMSTATUS(loc_oPagina, "txt_4c_PerInis", 5)
1799:             loc_oPagina.txt_4c_PerInis.ReadOnly = !loc_lEditar
1800:         ENDIF
1801:         IF PEMSTATUS(loc_oPagina, "txt_4c_PerFins", 5)
1802:             loc_oPagina.txt_4c_PerFins.ReadOnly = !loc_lEditar
1803:         ENDIF
1804:         IF PEMSTATUS(loc_oPagina, "txt_4c_GGrus", 5)
1805:             loc_oPagina.txt_4c_GGrus.ReadOnly = !loc_lEditar
1806:         ENDIF
1807:         IF PEMSTATUS(loc_oPagina, "txt_4c_SGrus", 5)
1808:             loc_oPagina.txt_4c_SGrus.ReadOnly = !loc_lEditar
1809:         ENDIF
1810:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup12", 5)
1811:             loc_oPagina.opt_4c_Optiongroup12.Enabled = loc_lEditar
1812:         ENDIF
1813:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup1", 5)
1814:             loc_oPagina.opt_4c_Optiongroup1.Enabled = loc_lEditar
1815:         ENDIF
1816:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup2", 5)
1817:             loc_oPagina.opt_4c_Optiongroup2.Enabled = loc_lEditar
1818:         ENDIF
1819:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup3", 5)
1820:             loc_oPagina.opt_4c_Optiongroup3.Enabled = loc_lEditar
1821:         ENDIF
1822:         IF PEMSTATUS(loc_oPagina, "opt_4c_OptTpDescs", 5)
1823:             loc_oPagina.opt_4c_OptTpDescs.Enabled = loc_lEditar
1824:         ENDIF
1825: 
1826:         *-- Botao Confirmar: habilitado apenas em INCLUIR/ALTERAR
1827:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1828:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1829:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
1830:             ENDIF
1831:         ENDIF
1832: 
1833:         *-- Grids e botoes de relacionados: editaveis apenas em INCLUIR/ALTERAR
1834:         IF PEMSTATUS(loc_oPagina, "cnt_4c_CmdOpers", 5)
1835:             loc_oPagina.cnt_4c_CmdOpers.Enabled = loc_lEditar
1836:         ENDIF
1837:         IF PEMSTATUS(loc_oPagina, "cnt_4c_CmdEmps", 5)
1838:             loc_oPagina.cnt_4c_CmdEmps.Enabled = loc_lEditar
1839:         ENDIF
1840:         IF PEMSTATUS(loc_oPagina, "cmd_4c_InserirCompo", 5)
1841:             loc_oPagina.cmd_4c_InserirCompo.Enabled = loc_lEditar
1842:         ENDIF
1843:         IF PEMSTATUS(loc_oPagina, "cmd_4c_ExcluirCompo", 5)
1844:             loc_oPagina.cmd_4c_ExcluirCompo.Enabled = loc_lEditar
1845:         ENDIF
1846:         IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
1847:             loc_oPagina.grd_4c_Compo.ReadOnly = !loc_lEditar
1848:         ENDIF
1849:     ENDPROC
1850: 
1851:     *===========================================================================
1852:     * LimparCampos - Limpa os campos de Page2 para novo registro
1853:     *===========================================================================
1854:     PROTECTED PROCEDURE LimparCampos()
1855:         LOCAL loc_oPagina
1856:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1857: 
1858:         IF PEMSTATUS(loc_oPagina, "txt_4c_Codigos", 5)
1859:             loc_oPagina.txt_4c_Codigos.Value = ""
1860:         ENDIF
1861:         IF PEMSTATUS(loc_oPagina, "txt_4c_Descrs", 5)
1862:             loc_oPagina.txt_4c_Descrs.Value = ""
1863:         ENDIF
1864:         IF PEMSTATUS(loc_oPagina, "txt_4c_Tipos", 5)
1865:             loc_oPagina.txt_4c_Tipos.Value = "D"
1866:         ENDIF
1867:         IF PEMSTATUS(loc_oPagina, "txt_4c_LimDescs", 5)
1868:             loc_oPagina.txt_4c_LimDescs.Value = 0
1869:         ENDIF
1870:         IF PEMSTATUS(loc_oPagina, "txt_4c_PerInis", 5)
1871:             loc_oPagina.txt_4c_PerInis.Value = {}
1872:         ENDIF
1873:         IF PEMSTATUS(loc_oPagina, "txt_4c_PerFins", 5)
1874:             loc_oPagina.txt_4c_PerFins.Value = {}
1875:         ENDIF
1876:         IF PEMSTATUS(loc_oPagina, "txt_4c_GGrus", 5)
1877:             loc_oPagina.txt_4c_GGrus.Value = ""
1878:         ENDIF
1879:         IF PEMSTATUS(loc_oPagina, "txt_4c_SGrus", 5)
1880:             loc_oPagina.txt_4c_SGrus.Value = ""
1881:         ENDIF
1882:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup12", 5)
1883:             loc_oPagina.opt_4c_Optiongroup12.Value = 2
1884:         ENDIF
1885:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup1", 5)
1886:             loc_oPagina.opt_4c_Optiongroup1.Value = 2
1887:         ENDIF
1888:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup2", 5)
1889:             loc_oPagina.opt_4c_Optiongroup2.Value = 2
1890:         ENDIF
1891:         IF PEMSTATUS(loc_oPagina, "opt_4c_Optiongroup3", 5)
1892:             loc_oPagina.opt_4c_Optiongroup3.Value = 2
1893:         ENDIF
1894:         IF PEMSTATUS(loc_oPagina, "opt_4c_OptTpDescs", 5)
1895:             loc_oPagina.opt_4c_OptTpDescs.Value = 1
1896:         ENDIF
1897: 
1898:         *-- Limpar cursores dos grids relacionados (recarregados em CarregarRelacionados)
1899:         IF USED("cursor_4c_Emps")
1900:             REPLACE ALL Imps WITH .F. IN cursor_4c_Emps
1901:             IF PEMSTATUS(loc_oPagina, "grd_4c_Emps", 5)
1902:                 loc_oPagina.grd_4c_Emps.Refresh()
1903:             ENDIF
1904:         ENDIF
1905:         IF USED("cursor_4c_Opers")
1906:             REPLACE ALL Imps WITH .F. IN cursor_4c_Opers
1907:             IF PEMSTATUS(loc_oPagina, "grd_4c_Opers", 5)
1908:                 loc_oPagina.grd_4c_Opers.Refresh()
1909:             ENDIF
1910:         ENDIF
1911:         IF USED("cursor_4c_Compos")
1912:             ZAP IN cursor_4c_Compos
1913:             IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
1914:                 loc_oPagina.grd_4c_Compo.Refresh()
1915:             ENDIF
1916:         ENDIF
1917:     ENDPROC
1918: 
1919:     *===========================================================================
1920:     * AjustarBotoesPorModo - Ajusta estado dos botoes de Page2 conforme modo atual
1921:     *===========================================================================
1922:     PROTECTED PROCEDURE AjustarBotoesPorModo()
1923:         LOCAL loc_oPagina, loc_lEditar
1924:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1925:         loc_lEditar = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1926: 
1927:         IF PEMSTATUS(loc_oPagina, "cnt_4c_BotoesAcao", 5)
1928:             IF PEMSTATUS(loc_oPagina.cnt_4c_BotoesAcao, "cmd_4c_Confirmar", 5)
1929:                 loc_oPagina.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditar
1930:             ENDIF
1931:         ENDIF
1932:     ENDPROC
1933: 
1934:     *===========================================================================
1935:     * ValidarTipos - Valida campo Tipo (D=Desconto, A=Acrescimo)
1936:     * PUBLIC: BINDEVENT requer metodo publico
1937:     *===========================================================================
1938:     PROCEDURE ValidarTipos(par_nKeyCode, par_nShiftAltCtrl)
1939:         LOCAL loc_oPagina, loc_cTipo
1940:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1941: 
1942:         IF !PEMSTATUS(loc_oPagina, "txt_4c_Tipos", 5)
1943:             RETURN
1944:         ENDIF
1945: 
1946:         loc_cTipo = UPPER(ALLTRIM(loc_oPagina.txt_4c_Tipos.Value))
1947: 
1948:         IF EMPTY(loc_cTipo)
1949:             RETURN
1950:         ENDIF
1951: 
1952:         IF !INLIST(loc_cTipo, "D", "A")
1953:             MsgAviso("Tipo deve ser 'D' (Desconto) ou 'A' (Acr" + CHR(233) + "scimo).", ;
1954:                 "Tipo Inv" + CHR(225) + "lido")
1955:             loc_oPagina.txt_4c_Tipos.Value = ""
1956:             loc_oPagina.txt_4c_Tipos.SetFocus
1957:             RETURN
1958:         ENDIF
1959: 
1960:         loc_oPagina.txt_4c_Tipos.Value = loc_cTipo
1961:     ENDPROC
1962: 
1963:     *===========================================================================
1964:     * ValidarGGrus - Valida codigo Grande Grupo (SigCdGpr)
1965:     * Se nao encontrado exato, abre picker FormBuscaAuxiliar (Pattern A canonico)
1966:     * PUBLIC: BINDEVENT requer metodo publico
1967:     *===========================================================================
1968:     PROCEDURE ValidarGGrus(par_nKeyCode, par_nShiftAltCtrl)
1969:         LOCAL loc_oPagina, loc_cCod, loc_nRows, loc_oBusca
1970:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
1971: 
1972:         IF !PEMSTATUS(loc_oPagina, "txt_4c_GGrus", 5)
1973:             RETURN
1974:         ENDIF
1975: 
1976:         loc_cCod = ALLTRIM(loc_oPagina.txt_4c_GGrus.Value)
1977: 
1978:         IF EMPTY(loc_cCod)
1979:             RETURN
1980:         ENDIF
1981: 
1982:         TRY
1983:             loc_nRows = SQLEXEC(gnConnHandle, ;
1984:                 "SELECT codigos, descs FROM SigCdGpr WHERE codigos = " + EscaparSQL(loc_cCod), ;
1985:                 "cursor_4c_BuscaGGrus")
1986: 
1987:             IF loc_nRows > 0 AND USED("cursor_4c_BuscaGGrus") AND !EOF("cursor_4c_BuscaGGrus")
1988:                 loc_oPagina.txt_4c_GGrus.Value = ALLTRIM(cursor_4c_BuscaGGrus.codigos)
1989:                 IF USED("cursor_4c_BuscaGGrus")
1990:                     USE IN cursor_4c_BuscaGGrus
1991:                 ENDIF
1992:             ELSE
1993:                 IF USED("cursor_4c_BuscaGGrus")
1994:                     USE IN cursor_4c_BuscaGGrus
1995:                 ENDIF
1996: 
1997:                 *-- Nao encontrado exato: busca parcial para picker
1998:                 loc_nRows = SQLEXEC(gnConnHandle, ;
1999:                     "SELECT codigos, descs FROM SigCdGpr WHERE codigos LIKE " + ;
2000:                     EscaparSQL(loc_cCod + "%") + " ORDER BY codigos", ;
2001:                     "cursor_4c_BuscaGGrus")
2002: 
2003:                 IF loc_nRows <= 0 OR !USED("cursor_4c_BuscaGGrus") OR EOF("cursor_4c_BuscaGGrus")
2004:                     IF USED("cursor_4c_BuscaGGrus")
2005:                         USE IN cursor_4c_BuscaGGrus
2006:                     ENDIF
2007:                     SQLEXEC(gnConnHandle, ;
2008:                         "SELECT codigos, descs FROM SigCdGpr ORDER BY codigos", ;
2009:                         "cursor_4c_BuscaGGrus")
2010:                 ENDIF
2011: 
2012:                 IF USED("cursor_4c_BuscaGGrus") AND !EOF("cursor_4c_BuscaGGrus")
2013:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2014:                     IF VARTYPE(loc_oBusca) = "O"
2015:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaGGrus", "codigos", "descs", ;
2016:                             "Buscar Grande Grupo")
2017:                         loc_oBusca.Mostrar()
2018:                         IF loc_oBusca.this_lSelecionou
2019:                             loc_oPagina.txt_4c_GGrus.Value = loc_oBusca.cCodigoSelecionado
2020:                         ELSE
2021:                             loc_oPagina.txt_4c_GGrus.Value = ""
2022:                         ENDIF
2023:                         loc_oBusca.Release()
2024:                     ENDIF
2025:                 ELSE
2026:                     loc_oPagina.txt_4c_GGrus.Value = ""
2027:                 ENDIF
2028: 
2029:                 IF USED("cursor_4c_BuscaGGrus")
2030:                     USE IN cursor_4c_BuscaGGrus
2031:                 ENDIF
2032:             ENDIF
2033:         CATCH TO loException
2034:             MostrarErro("Erro ao validar Grande Grupo:" + CHR(13) + loException.Message, ;
2035:                 "FormMda.ValidarGGrus")
2036:             IF USED("cursor_4c_BuscaGGrus")
2037:                 USE IN cursor_4c_BuscaGGrus
2038:             ENDIF
2039:         ENDTRY
2040:     ENDPROC
2041: 
2042:     *===========================================================================
2043:     * ValidarSGrus - Valida codigo SubGrupo (SigCdPsg)
2044:     * Se nao encontrado exato, abre picker FormBuscaAuxiliar (Pattern A canonico)
2045:     * PUBLIC: BINDEVENT requer metodo publico
2046:     *===========================================================================
2047:     PROCEDURE ValidarSGrus(par_nKeyCode, par_nShiftAltCtrl)
2048:         LOCAL loc_oPagina, loc_cCod, loc_nRows, loc_oBusca
2049:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2050: 
2051:         IF !PEMSTATUS(loc_oPagina, "txt_4c_SGrus", 5)
2052:             RETURN
2053:         ENDIF
2054: 
2055:         loc_cCod = ALLTRIM(loc_oPagina.txt_4c_SGrus.Value)
2056: 
2057:         IF EMPTY(loc_cCod)
2058:             RETURN
2059:         ENDIF
2060: 
2061:         TRY
2062:             loc_nRows = SQLEXEC(gnConnHandle, ;
2063:                 "SELECT Codigos, Descricaos FROM SigCdPsg WHERE Codigos = " + EscaparSQL(loc_cCod), ;
2064:                 "cursor_4c_BuscaSGrus")
2065: 
2066:             IF loc_nRows > 0 AND USED("cursor_4c_BuscaSGrus") AND !EOF("cursor_4c_BuscaSGrus")
2067:                 loc_oPagina.txt_4c_SGrus.Value = ALLTRIM(cursor_4c_BuscaSGrus.Codigos)
2068:                 IF USED("cursor_4c_BuscaSGrus")
2069:                     USE IN cursor_4c_BuscaSGrus
2070:                 ENDIF
2071:             ELSE
2072:                 IF USED("cursor_4c_BuscaSGrus")
2073:                     USE IN cursor_4c_BuscaSGrus
2074:                 ENDIF
2075: 
2076:                 *-- Nao encontrado exato: busca parcial para picker
2077:                 loc_nRows = SQLEXEC(gnConnHandle, ;
2078:                     "SELECT Codigos, Descricaos FROM SigCdPsg WHERE Codigos LIKE " + ;
2079:                     EscaparSQL(loc_cCod + "%") + " ORDER BY Codigos", ;
2080:                     "cursor_4c_BuscaSGrus")
2081: 
2082:                 IF loc_nRows <= 0 OR !USED("cursor_4c_BuscaSGrus") OR EOF("cursor_4c_BuscaSGrus")
2083:                     IF USED("cursor_4c_BuscaSGrus")
2084:                         USE IN cursor_4c_BuscaSGrus
2085:                     ENDIF
2086:                     SQLEXEC(gnConnHandle, ;
2087:                         "SELECT Codigos, Descricaos FROM SigCdPsg ORDER BY Codigos", ;
2088:                         "cursor_4c_BuscaSGrus")
2089:                 ENDIF
2090: 
2091:                 IF USED("cursor_4c_BuscaSGrus") AND !EOF("cursor_4c_BuscaSGrus")
2092:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2093:                     IF VARTYPE(loc_oBusca) = "O"
2094:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaSGrus", "Codigos", "Descricaos", ;
2095:                             "Buscar SubGrupo")
2096:                         loc_oBusca.Mostrar()
2097:                         IF loc_oBusca.this_lSelecionou
2098:                             loc_oPagina.txt_4c_SGrus.Value = loc_oBusca.cCodigoSelecionado
2099:                         ELSE
2100:                             loc_oPagina.txt_4c_SGrus.Value = ""
2101:                         ENDIF
2102:                         loc_oBusca.Release()
2103:                     ENDIF
2104:                 ELSE
2105:                     loc_oPagina.txt_4c_SGrus.Value = ""
2106:                 ENDIF
2107: 
2108:                 IF USED("cursor_4c_BuscaSGrus")
2109:                     USE IN cursor_4c_BuscaSGrus
2110:                 ENDIF
2111:             ENDIF
2112:         CATCH TO loException
2113:             MostrarErro("Erro ao validar SubGrupo:" + CHR(13) + loException.Message, ;
2114:                 "FormMda.ValidarSGrus")
2115:             IF USED("cursor_4c_BuscaSGrus")
2116:                 USE IN cursor_4c_BuscaSGrus
2117:             ENDIF
2118:         ENDTRY
2119:     ENDPROC
2120: 
2121:     *===========================================================================
2122:     * CarregarRelacionados - Carrega grids de Emps, Opers e Compos via BO
2123:     * Chamado apos BtnIncluir/Alterar/VisualizarClick com codigo do motivo
2124:     *===========================================================================
2125:     PROCEDURE CarregarRelacionados(par_cCodigos)
2126:         LOCAL loc_lResultado, loc_oPagina, loc_oGrd
2127:         loc_lResultado = .F.
2128:         loc_oPagina    = THIS.pgf_4c_Paginas.Page2
2129: 
2130:         TRY
2131:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
2132:                 loc_lResultado = loc_lResultado
2133:             ENDIF
2134: 
2135:             THIS.this_oBusinessObject.CarregarEmpresas(par_cCodigos)
2136:             THIS.this_oBusinessObject.CarregarOperacoes(par_cCodigos)
2137:             THIS.this_oBusinessObject.CarregarComposicoes(par_cCodigos)
2138:             THIS.this_oBusinessObject.BuscarComposicoesProdutos()
2139: 
2140:             *-- Grid Operacoes
2141:             IF PEMSTATUS(loc_oPagina, "grd_4c_Opers", 5) AND USED("cursor_4c_Opers")
2142:                 loc_oGrd = loc_oPagina.grd_4c_Opers
2143:                 *-- RecordSource e ControlSource FORA de WITH (Problema 36/48)
2144:                 loc_oGrd.ColumnCount = 2
2145:                 loc_oGrd.RecordSource          = "cursor_4c_Opers"
2146:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Opers.Imps"
2147:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Opers.Dopes"
2148:                 *-- Headers OBRIGATORIO apos RecordSource (Problema 32)
2149:                 loc_oGrd.Column1.Header1.Caption = ""
2150:                 loc_oGrd.Column2.Header1.Caption = "Opera" + CHR(231) + CHR(245) + "o"
2151:                 loc_oGrd.Refresh()
2152:             ENDIF
2153: 
2154:             *-- Grid Empresas
2155:             IF PEMSTATUS(loc_oPagina, "grd_4c_Emps", 5) AND USED("cursor_4c_Emps")
2156:                 loc_oGrd = loc_oPagina.grd_4c_Emps
2157:                 loc_oGrd.ColumnCount = 3
2158:                 loc_oGrd.RecordSource          = "cursor_4c_Emps"
2159:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Emps.Imps"
2160:                 loc_oGrd.Column2.ControlSource = "cursor_4c_Emps.Emps"
2161:                 loc_oGrd.Column3.ControlSource = "cursor_4c_Emps.Razas"
2162:                 loc_oGrd.Column1.Header1.Caption = ""
2163:                 loc_oGrd.Column2.Header1.Caption = "Emp."
2164:                 loc_oGrd.Column3.Header1.Caption = "Raz" + CHR(227) + "o Social"
2165:                 loc_oGrd.Refresh()
2166:             ENDIF
2167: 
2168:             *-- Grid Composicoes
2169:             IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5) AND USED("cursor_4c_Compos")
2170:                 loc_oGrd = loc_oPagina.grd_4c_Compo
2171:                 loc_oGrd.ColumnCount = 1
2172:                 loc_oGrd.RecordSource          = "cursor_4c_Compos"
2173:                 loc_oGrd.Column1.ControlSource = "cursor_4c_Compos.Compos"
2174:                 loc_oGrd.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
2175:                 loc_oGrd.Refresh()
2176:             ENDIF
2177: 
2178:             loc_lResultado = .T.
2179: 
2180:         CATCH TO loException
2181:             MostrarErro("Erro ao carregar relacionados:" + CHR(13) + loException.Message, ;
2182:                 "FormMda.CarregarRelacionados")
2183:         ENDTRY
2184: 
2185:         RETURN loc_lResultado
2186:     ENDPROC
2187: 
2188:     *===========================================================================
2189:     * OperCheckboxMouseDown - Toggle Imps em cursor_4c_Opers via mouse
2190:     * PUBLIC: BINDEVENT requer metodo publico
2191:     *===========================================================================
2192:     PROCEDURE OperCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2193:         IF THIS.this_cModoAtual = "VISUALIZAR"
2194:             NODEFAULT
2195:             RETURN
2196:         ENDIF
2197:         IF USED("cursor_4c_Opers") AND !EOF("cursor_4c_Opers")
2198:             SELECT cursor_4c_Opers
2199:             REPLACE Imps WITH !cursor_4c_Opers.Imps IN cursor_4c_Opers
2200:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
2201:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
2202:             ENDIF
2203:         ENDIF
2204:         NODEFAULT
2205:     ENDPROC
2206: 
2207:     *===========================================================================
2208:     * OperCheckboxMouseUp - Suprime comportamento padrao
2209:     * PUBLIC: BINDEVENT requer metodo publico
2210:     *===========================================================================
2211:     PROCEDURE OperCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2212:         NODEFAULT
2213:     ENDPROC
2214: 
2215:     *===========================================================================
2216:     * OperCheckboxClick - Suprime toggle automatico VFP9 (MouseDown ja atualizou)
2217:     * PUBLIC: BINDEVENT requer metodo publico
2218:     *===========================================================================
2219:     PROCEDURE OperCheckboxClick()
2220:         NODEFAULT
2221:     ENDPROC
2222: 
2223:     *===========================================================================
2224:     * OperCheckboxKeyPress - Toggle Imps em cursor_4c_Opers via teclado
2225:     * PUBLIC: BINDEVENT requer metodo publico
2226:     *===========================================================================
2227:     PROCEDURE OperCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2228:         IF THIS.this_cModoAtual = "VISUALIZAR"
2229:             NODEFAULT
2230:             RETURN
2231:         ENDIF
2232:         IF INLIST(par_nKeyCode, 13, 32)
2233:             IF USED("cursor_4c_Opers") AND !EOF("cursor_4c_Opers")
2234:                 SELECT cursor_4c_Opers
2235:                 REPLACE Imps WITH !cursor_4c_Opers.Imps IN cursor_4c_Opers
2236:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
2237:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
2238:                 ENDIF
2239:             ENDIF
2240:             NODEFAULT
2241:         ENDIF
2242:     ENDPROC
2243: 
2244:     *===========================================================================
2245:     * EmpCheckboxMouseDown - Toggle Imps em cursor_4c_Emps via mouse
2246:     * PUBLIC: BINDEVENT requer metodo publico
2247:     *===========================================================================
2248:     PROCEDURE EmpCheckboxMouseDown(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2249:         IF THIS.this_cModoAtual = "VISUALIZAR"
2250:             NODEFAULT
2251:             RETURN
2252:         ENDIF
2253:         IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps")
2254:             SELECT cursor_4c_Emps
2255:             REPLACE Imps WITH !cursor_4c_Emps.Imps IN cursor_4c_Emps
2256:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
2257:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
2258:             ENDIF
2259:         ENDIF
2260:         NODEFAULT
2261:     ENDPROC
2262: 
2263:     *===========================================================================
2264:     * EmpCheckboxMouseUp - Suprime comportamento padrao
2265:     * PUBLIC: BINDEVENT requer metodo publico
2266:     *===========================================================================
2267:     PROCEDURE EmpCheckboxMouseUp(par_nButton, par_nShift, par_nXCoord, par_nYCoord)
2268:         NODEFAULT
2269:     ENDPROC
2270: 
2271:     *===========================================================================
2272:     * EmpCheckboxClick - Suprime toggle automatico VFP9 (MouseDown ja atualizou)
2273:     * PUBLIC: BINDEVENT requer metodo publico
2274:     *===========================================================================
2275:     PROCEDURE EmpCheckboxClick()
2276:         NODEFAULT
2277:     ENDPROC
2278: 
2279:     *===========================================================================
2280:     * EmpCheckboxKeyPress - Toggle Imps em cursor_4c_Emps via teclado
2281:     * PUBLIC: BINDEVENT requer metodo publico
2282:     *===========================================================================
2283:     PROCEDURE EmpCheckboxKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2284:         IF THIS.this_cModoAtual = "VISUALIZAR"
2285:             NODEFAULT
2286:             RETURN
2287:         ENDIF
2288:         IF INLIST(par_nKeyCode, 13, 32)
2289:             IF USED("cursor_4c_Emps") AND !EOF("cursor_4c_Emps")
2290:                 SELECT cursor_4c_Emps
2291:                 REPLACE Imps WITH !cursor_4c_Emps.Imps IN cursor_4c_Emps
2292:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
2293:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
2294:                 ENDIF
2295:             ENDIF
2296:             NODEFAULT
2297:         ENDIF
2298:     ENDPROC
2299: 
2300:     *===========================================================================
2301:     * MarcaTodosOpersClick - Marca todas operacoes (Imps = .T.)
2302:     * PUBLIC: BINDEVENT requer metodo publico
2303:     *===========================================================================
2304:     PROCEDURE MarcaTodosOpersClick()
2305:         IF USED("cursor_4c_Opers")
2306:             REPLACE ALL Imps WITH .T. IN cursor_4c_Opers
2307:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
2308:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
2309:             ENDIF
2310:         ENDIF
2311:     ENDPROC
2312: 
2313:     *===========================================================================
2314:     * DesmarcaTodosOpersClick - Desmarca todas operacoes (Imps = .F.)
2315:     * PUBLIC: BINDEVENT requer metodo publico
2316:     *===========================================================================
2317:     PROCEDURE DesmarcaTodosOpersClick()
2318:         IF USED("cursor_4c_Opers")
2319:             REPLACE ALL Imps WITH .F. IN cursor_4c_Opers
2320:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Opers", 5)
2321:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Opers.Refresh()
2322:             ENDIF
2323:         ENDIF
2324:     ENDPROC
2325: 
2326:     *===========================================================================
2327:     * MarcaTodosEmpsClick - Marca todas empresas (Imps = .T.)
2328:     * PUBLIC: BINDEVENT requer metodo publico
2329:     *===========================================================================
2330:     PROCEDURE MarcaTodosEmpsClick()
2331:         IF USED("cursor_4c_Emps")
2332:             REPLACE ALL Imps WITH .T. IN cursor_4c_Emps
2333:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
2334:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
2335:             ENDIF
2336:         ENDIF
2337:     ENDPROC
2338: 
2339:     *===========================================================================
2340:     * DesmarcaTodosEmpsClick - Desmarca todas empresas (Imps = .F.)
2341:     * PUBLIC: BINDEVENT requer metodo publico
2342:     *===========================================================================
2343:     PROCEDURE DesmarcaTodosEmpsClick()
2344:         IF USED("cursor_4c_Emps")
2345:             REPLACE ALL Imps WITH .F. IN cursor_4c_Emps
2346:             IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Emps", 5)
2347:                 THIS.pgf_4c_Paginas.Page2.grd_4c_Emps.Refresh()
2348:             ENDIF
2349:         ENDIF
2350:     ENDPROC
2351: 
2352:     *===========================================================================
2353:     * CompoInserirClick - Insere linha vazia em cursor_4c_Compos
2354:     * PUBLIC: BINDEVENT requer metodo publico
2355:     *===========================================================================
2356:     PROCEDURE CompoInserirClick()
2357:         LOCAL loc_oPagina
2358:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2359: 
2360:         IF !USED("cursor_4c_Compos")
2361:             RETURN
2362:         ENDIF
2363: 
2364:         SELECT cursor_4c_Compos
2365:         APPEND BLANK
2366:         REPLACE Compos WITH "" IN cursor_4c_Compos
2367:         GO BOTTOM IN cursor_4c_Compos
2368: 
2369:         IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
2370:             loc_oPagina.grd_4c_Compo.Refresh()
2371:         ENDIF
2372:     ENDPROC
2373: 
2374:     *===========================================================================
2375:     * CompoExcluirClick - Exclui linha atual de cursor_4c_Compos
2376:     * PUBLIC: BINDEVENT requer metodo publico
2377:     *===========================================================================
2378:     PROCEDURE CompoExcluirClick()
2379:         LOCAL loc_oPagina, loc_nRec
2380:         loc_oPagina = THIS.pgf_4c_Paginas.Page2
2381: 
2382:         IF !USED("cursor_4c_Compos") OR EOF("cursor_4c_Compos") OR ;
2383:            RECCOUNT("cursor_4c_Compos") = 0
2384:             RETURN
2385:         ENDIF
2386: 
2387:         TRY
2388:             SELECT cursor_4c_Compos
2389:             loc_nRec = RECNO("cursor_4c_Compos")
2390: 
2391:             *-- Rebuild writable cursor excluindo o registro atual
2392:             IF USED("cursor_4c_CompoTemp")
2393:                 USE IN cursor_4c_CompoTemp
2394:             ENDIF
2395:             SELECT Compos FROM cursor_4c_Compos ;
2396:                 WHERE RECNO() != loc_nRec ;
2397:                 INTO CURSOR cursor_4c_CompoTemp READWRITE
2398:             USE IN cursor_4c_Compos
2399: 
2400:             IF USED("cursor_4c_CompoTemp") AND RECCOUNT("cursor_4c_CompoTemp") > 0
2401:                 SELECT Compos FROM cursor_4c_CompoTemp ;
2402:                     INTO CURSOR cursor_4c_Compos READWRITE
2403:                 USE IN cursor_4c_CompoTemp
2404:                 GO BOTTOM IN cursor_4c_Compos
2405:             ELSE
2406:                 IF USED("cursor_4c_CompoTemp")
2407:                     USE IN cursor_4c_CompoTemp
2408:                 ENDIF
2409:                 CREATE CURSOR cursor_4c_Compos (Compos C(30))
2410:             ENDIF
2411: 
2412:             IF PEMSTATUS(loc_oPagina, "grd_4c_Compo", 5)
2413:                 loc_oPagina.grd_4c_Compo.ColumnCount = 1
2414:                 loc_oPagina.grd_4c_Compo.RecordSource          = "cursor_4c_Compos"
2415:                 loc_oPagina.grd_4c_Compo.Column1.ControlSource = "cursor_4c_Compos.Compos"
2416:                 loc_oPagina.grd_4c_Compo.Column1.Header1.Caption = "Composi" + CHR(231) + CHR(227) + "o"
2417:                 loc_oPagina.grd_4c_Compo.Refresh()
2418:             ENDIF
2419: 
2420:         CATCH TO loException
2421:             MostrarErro("Erro ao excluir composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
2422:                 loException.Message, "FormMda.CompoExcluirClick")
2423:         ENDTRY
2424:     ENDPROC
2425: 
2426:     *===========================================================================
2427:     * CompoTextValid - Valida/busca composicao digitada em grd_4c_Compo
2428:     * PUBLIC: BINDEVENT requer metodo publico
2429:     *===========================================================================
2430:     PROCEDURE CompoTextValid()
2431:         LOCAL loc_cCompo, loc_oBusca, loc_lOk
2432:         loc_lOk = .T.
2433: 
2434:         IF THIS.this_cModoAtual = "VISUALIZAR"
2435:             RETURN loc_lOk
2436:         ENDIF
2437: 
2438:         IF !USED("cursor_4c_Compos") OR EOF("cursor_4c_Compos")
2439:             RETURN loc_lOk
2440:         ENDIF
2441: 
2442:         loc_cCompo = ALLTRIM(cursor_4c_Compos.Compos)
2443: 
2444:         IF EMPTY(loc_cCompo)
2445:             RETURN loc_lOk
2446:         ENDIF
2447: 
2448:         IF !USED("cursor_4c_CsCompos") OR RECCOUNT("cursor_4c_CsCompos") = 0
2449:             RETURN loc_lOk
2450:         ENDIF
2451: 
2452:         TRY
2453:             *-- Busca exata
2454:             SELECT cursor_4c_CsCompos
2455:             LOCATE FOR UPPER(ALLTRIM(cursor_4c_CsCompos.Compos)) = UPPER(loc_cCompo)
2456: 
2457:             IF !EOF("cursor_4c_CsCompos")
2458:                 *-- Encontrado: normaliza para forma canonica
2459:                 SELECT cursor_4c_Compos
2460:                 REPLACE Compos WITH ALLTRIM(cursor_4c_CsCompos.Compos) IN cursor_4c_Compos
2461:                 IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Compo", 5)
2462:                     THIS.pgf_4c_Paginas.Page2.grd_4c_Compo.Refresh()
2463:                 ENDIF
2464:             ELSE
2465:                 *-- Nao encontrado: abre picker com filtro parcial
2466:                 SELECT cursor_4c_Compos
2467: 
2468:                 IF USED("cursor_4c_BuscaCompo")
2469:                     USE IN cursor_4c_BuscaCompo
2470:                 ENDIF
2471: 
2472:                 SELECT Compos FROM cursor_4c_CsCompos ;
2473:                     WHERE UPPER(ALLTRIM(cursor_4c_CsCompos.Compos)) LIKE "%" + UPPER(loc_cCompo) + "%" ;
2474:                     ORDER BY cursor_4c_CsCompos.Compos ;
2475:                     INTO CURSOR cursor_4c_BuscaCompo
2476: 
2477:                 IF !USED("cursor_4c_BuscaCompo") OR EOF("cursor_4c_BuscaCompo")
2478:                     IF USED("cursor_4c_BuscaCompo")
2479:                         USE IN cursor_4c_BuscaCompo
2480:                     ENDIF
2481:                     SELECT Compos FROM cursor_4c_CsCompos ;
2482:                         ORDER BY cursor_4c_CsCompos.Compos ;
2483:                         INTO CURSOR cursor_4c_BuscaCompo
2484:                 ENDIF
2485: 
2486:                 IF USED("cursor_4c_BuscaCompo") AND !EOF("cursor_4c_BuscaCompo")
2487:                     loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar")
2488:                     IF VARTYPE(loc_oBusca) = "O"
2489:                         loc_oBusca.DefinirCursor("cursor_4c_BuscaCompo", "Compos", "Compos", ;
2490:                             "Buscar Composi" + CHR(231) + CHR(227) + "o")
2491:                         loc_oBusca.Mostrar()
2492:                         SELECT cursor_4c_Compos
2493:                         IF loc_oBusca.this_lSelecionou
2494:                             REPLACE Compos WITH ALLTRIM(loc_oBusca.cCodigoSelecionado) IN cursor_4c_Compos
2495:                         ELSE
2496:                             REPLACE Compos WITH "" IN cursor_4c_Compos
2497:                         ENDIF
2498:                         loc_oBusca.Release()
2499:                         IF PEMSTATUS(THIS.pgf_4c_Paginas.Page2, "grd_4c_Compo", 5)
2500:                             THIS.pgf_4c_Paginas.Page2.grd_4c_Compo.Refresh()
2501:                         ENDIF
2502:                     ENDIF
2503:                 ELSE
2504:                     SELECT cursor_4c_Compos
2505:                     REPLACE Compos WITH "" IN cursor_4c_Compos
2506:                 ENDIF
2507: 
2508:                 IF USED("cursor_4c_BuscaCompo")
2509:                     USE IN cursor_4c_BuscaCompo
2510:                 ENDIF
2511:             ENDIF
2512: 
2513:         CATCH TO loException
2514:             MostrarErro("Erro ao validar composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
2515:                 loException.Message, "FormMda.CompoTextValid")
2516:         ENDTRY
2517: 
2518:         RETURN loc_lOk
2519:     ENDPROC
2520: 
2521:     *===========================================================================
2522:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2523:     * Percorre Pages de PageFrames E Controls de Containers
2524:     *===========================================================================
2525:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2526:         LOCAL loc_nI, loc_oObjeto, loc_nP
2527:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2528:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2529:             IF VARTYPE(loc_oObjeto) = "O"
2530:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2531:                     loc_oObjeto.Visible = .T.
2532:                 ENDIF
2533:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2534:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2535:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2536:                     ENDFOR
2537:                 ENDIF
2538:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2539:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2540:                 ENDIF
2541:             ENDIF
2542:         ENDFOR
2543:     ENDPROC
2544: 
2545:     *===========================================================================
2546:     * FormatarGridLista - Aplica formatacao visual padrao ao grid de lista
2547:     *===========================================================================
2548:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2549:         WITH par_oGrid
2550:             .FontName = "Tahoma"
2551:             .FontSize = 8
2552:         ENDWITH
2553:     ENDPROC
2554: 
2555:     *===========================================================================
2556:     * Destroy - Libera recursos ao fechar o formulario
2557:     *===========================================================================
2558:     PROCEDURE Destroy()
2559:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2560:             THIS.this_oBusinessObject = .NULL.
2561:         ENDIF
2562: 
2563:         IF USED("cursor_4c_Dados")
2564:             USE IN cursor_4c_Dados
2565:         ENDIF
2566: 
2567:         IF USED("cursor_4c_BuscaMda")
2568:             USE IN cursor_4c_BuscaMda
2569:         ENDIF
2570: 
2571:         IF USED("cursor_4c_Emps")
2572:             USE IN cursor_4c_Emps
2573:         ENDIF
2574:         IF USED("cursor_4c_Opers")
2575:             USE IN cursor_4c_Opers
2576:         ENDIF
2577:         IF USED("cursor_4c_Compos")
2578:             USE IN cursor_4c_Compos
2579:         ENDIF
2580:         IF USED("cursor_4c_CsCompos")
2581:             USE IN cursor_4c_CsCompos
2582:         ENDIF
2583:         IF USED("cursor_4c_BuscaCompo")
2584:             USE IN cursor_4c_BuscaCompo
2585:         ENDIF
2586: 
2587:         DODEFAULT()
2588:     ENDPROC
2589: 
2590: ENDDEFINE


### BO (C:\4c\projeto\app\classes\MdaBO.prg):
*==============================================================================
* MdaBO.prg - Business Object para Motivos de Desconto / Acrescimo
* Tabela principal: SigCdFs
* Tabelas relacionadas: SigCdFsi (empresas), SigCdFso (operacoes), SigCdFsc (composicoes)
*==============================================================================

DEFINE CLASS MdaBO AS BusinessBase

    *-- Propriedades da tabela SigCdFs
    this_cCodigos    = ""    && codigos char(10) PK
    this_cDescrs     = ""    && descrs char(40)
    this_cTipos      = ""    && tipos char(1) - "D"=Desconto, "A"=Acrescimo
    this_nBlqbonus   = 0     && blqbonus numeric(1,0) - nao gerar bonus (1=Sim, 0=Nao)
    this_nBlqtabds   = 0     && blqtabds numeric(1,0) - bloquear tab.desconto
    this_nChkbins    = 0     && chkbins numeric(1,0) - bloquear desconto BIN
    this_nChkdtanivs = 0     && chkdtanivs numeric(1,0) - checar data aniversario
    this_cGgrus      = ""    && ggrus char(3) - grande grupo
    this_nLimdescs   = 0     && limdescs numeric(5,2) - limite de desconto
    this_dPerfins    = {}    && perfins datetime NULL - periodo fim
    this_dPerinis    = {}    && perinis datetime NULL - periodo inicio
    this_cSgrus      = ""    && sgrus char(6) - sub-grupo
    this_nTpdescs    = 0     && tpdescs numeric(1,0) - tipo desconto (0=Geral, 1=por Produto)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdFs"
        THIS.this_cCampoChave = "codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDFUNC

    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(par_cFiltro)
                loc_cSQL = "SELECT codigos, descrs, tipos" + ;
                           " FROM SigCdFs" + ;
                           " ORDER BY codigos"
            ELSE
                loc_cSQL = "SELECT codigos, descrs, tipos" + ;
                           " FROM SigCdFs" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY codigos"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResult >= 0
                IF RECCOUNT("cursor_4c_Dados") = 0
                    SELECT 0 FROM cursor_4c_Dados WHERE .F. INTO CURSOR cursor_4c_Dados READWRITE
                ENDIF
                GO TOP IN cursor_4c_Dados
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar motivos de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.Buscar: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT codigos, descrs, tipos, blqbonus, blqtabds," + ;
                       " chkbins, chkdtanivs, ggrus, limdescs, perfins," + ;
                       " perinis, sgrus, tpdescs" + ;
                       " FROM SigCdFs" + ;
                       " WHERE codigos = " + EscaparSQL(par_cCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ELSE
                IF loc_nResult < 0
                    MsgErro("Erro ao carregar motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarPorCodigo: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos    = ALLTRIM(TratarNulo(codigos,    "C"))
            THIS.this_cDescrs     = ALLTRIM(TratarNulo(descrs,     "C"))
            THIS.this_cTipos      = ALLTRIM(TratarNulo(tipos,      "C"))
            THIS.this_nBlqbonus   = TratarNulo(blqbonus,   "N")
            THIS.this_nBlqtabds   = TratarNulo(blqtabds,   "N")
            THIS.this_nChkbins    = TratarNulo(chkbins,    "N")
            THIS.this_nChkdtanivs = TratarNulo(chkdtanivs, "N")
            THIS.this_cGgrus      = ALLTRIM(TratarNulo(ggrus,  "C"))
            THIS.this_nLimdescs   = TratarNulo(limdescs,   "N")
            THIS.this_dPerfins    = TratarNulo(perfins,    "D")
            THIS.this_dPerinis    = TratarNulo(perinis,    "D")
            THIS.this_cSgrus      = ALLTRIM(TratarNulo(sgrus,  "C"))
            THIS.this_nTpdescs    = TratarNulo(tpdescs,    "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdFs" + ;
                       " (codigos, descrs, tipos, blqbonus, blqtabds," + ;
                       "  chkbins, chkdtanivs, ggrus, limdescs, perfins," + ;
                       "  perinis, sgrus, tpdescs)" + ;
                       " VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cDescrs) + ", " + ;
                       EscaparSQL(THIS.this_cTipos) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqbonus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nBlqtabds) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkbins) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nChkdtanivs) + ", " + ;
                       EscaparSQL(THIS.this_cGgrus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nLimdescs) + ", " + ;
                       IIF(EMPTY(THIS.this_dPerfins), "NULL", FormatarDataSQL(THIS.this_dPerfins)) + ", " + ;
                       IIF(EMPTY(THIS.this_dPerinis), "NULL", FormatarDataSQL(THIS.this_dPerinis)) + ", " + ;
                       EscaparSQL(THIS.this_cSgrus) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nTpdescs) + ;
                       ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Insert")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir motivo de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.Inserir: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Insert")
            USE IN cursor_4c_Insert
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigCdFs SET" + ;
                       "  descrs      = " + EscaparSQL(THIS.this_cDescrs) + "," + ;
                       "  tipos       = " + EscaparSQL(THIS.this_cTipos) + "," + ;
                       "  blqbonus    = " + FormatarNumeroSQL(THIS.this_nBlqbonus) + "," + ;
                       "  blqtabds    = " + FormatarNumeroSQL(THIS.this_nBlqtabds) + "," + ;
                       "  chkbins     = " + FormatarNumeroSQL(THIS.this_nChkbins) + "," + ;
                       "  chkdtanivs  = " + FormatarNumeroSQL(THIS.this_nChkdtanivs) + "," + ;
                       "  ggrus       = " + EscaparSQL(THIS.this_cGgrus) + "," + ;
                       "  limdescs    = " + FormatarNumeroSQL(THIS.this_nLimdescs) + "," + ;
                       "  perfins     = " + IIF(EMPTY(THIS.this_dPerfins), "NULL", FormatarDataSQL(THIS.this_dPerfins)) + "," + ;
                       "  perinis     = " + IIF(EMPTY(THIS.this_dPerinis), "NULL", FormatarDataSQL(THIS.this_dPerinis)) + "," + ;
                       "  sgrus       = " + EscaparSQL(THIS.this_cSgrus) + "," + ;
                       "  tpdescs     = " + FormatarNumeroSQL(THIS.this_nTpdescs) + ;
                       " WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Update")
            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar motivo de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.Atualizar: " + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Update")
            USE IN cursor_4c_Update
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Verificar se motivo esta em uso em SigCdCmt/SigCdClc
            loc_cSQL = "SELECT b.Grupos, b.Codigos" + ;
                       " FROM SigCdCmt a, SigCdClc b" + ;
                       " WHERE a.Codigos = " + EscaparSQL(THIS.this_cCodigos) + ;
                       " AND a.fkChaves = b.cIdChaves"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_VerifUso")
            IF loc_nResult < 0
                MsgErro("Erro ao verificar uso do motivo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ELSE
                GO TOP IN cursor_4c_VerifUso
                IF !EOF("cursor_4c_VerifUso")
                    MsgErro("O Motivo Est" + CHR(225) + " Em Uso No Cadastro de Classifica" + CHR(231) + CHR(227) + "o!!!" + CHR(13) + ;
                            "Grupo : " + ALLTRIM(cursor_4c_VerifUso.Grupos) + ;
                            " - C" + CHR(243) + "digo : " + ALLTRIM(cursor_4c_VerifUso.Codigos), ;
                            "Exclus" + CHR(227) + "o N" + CHR(227) + "o Permitida!!!")
                ELSE
                    *-- Excluir registros relacionados primeiro
                    loc_lSucesso = THIS.ExcluirRelacionados()
                    IF loc_lSucesso
                        loc_cSQL = "DELETE FROM SigCdFs WHERE codigos = " + EscaparSQL(THIS.this_cCodigos)
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Delete")
                        IF loc_nResult >= 0
                            THIS.RegistrarAuditoria("DELETE")
                        ELSE
                            MsgErro("Erro ao excluir motivo de desconto:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                        IF USED("cursor_4c_Delete")
                            USE IN cursor_4c_Delete
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.ExecutarExclusao: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        IF USED("cursor_4c_VerifUso")
            USE IN cursor_4c_VerifUso
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SalvarRelacionados - Salva empresas, operacoes e composicoes do motivo
    * Par: par_cCodigos - codigo do motivo
    * Par: par_cCursorEmps - cursor com empresas selecionadas (csSigCdEmp)
    * Par: par_cCursorOpes - cursor com operacoes selecionadas (csSigCdOpe)
    * Par: par_cCursorCompo - cursor com composicoes (csSigPrCp)
    *--------------------------------------------------------------------------
    PROCEDURE SalvarRelacionados(par_cCodigos, par_cCursorEmps, par_cCursorOpes, par_cCursorCompo)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso, loc_cIdChaves
        loc_lSucesso = .F.

        TRY
            *-- Deletar relacionamentos anteriores
            loc_lSucesso = THIS.ExcluirRelacionados()

            IF loc_lSucesso
                *-- Inserir empresas selecionadas em SigCdFsi
                IF USED(par_cCursorEmps)
                    SELECT (par_cCursorEmps)
                    GO TOP
                    SCAN
                        IF Imps
                            loc_cIdChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdFsi (cIdChaves, Codigos, Emps)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cIdChaves) + ", " + ;
                                       EscaparSQL(par_cCodigos) + ", " + ;
                                       EscaparSQL(ALLTRIM(Emps)) + ;
                                       ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsEmp")
                            IF loc_nResult < 0
                                MsgErro("Erro ao salvar empresa:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                            IF USED("cursor_4c_InsEmp")
                                USE IN cursor_4c_InsEmp
                            ENDIF
                        ENDIF
                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- Inserir operacoes selecionadas em SigCdFso
                IF loc_lSucesso AND USED(par_cCursorOpes)
                    SELECT (par_cCursorOpes)
                    GO TOP
                    SCAN
                        IF Imps
                            loc_cIdChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdFso (cIdChaves, Codigos, Dopes)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cIdChaves) + ", " + ;
                                       EscaparSQL(par_cCodigos) + ", " + ;
                                       EscaparSQL(ALLTRIM(Dopes)) + ;
                                       ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsOpe")
                            IF loc_nResult < 0
                                MsgErro("Erro ao salvar opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                            IF USED("cursor_4c_InsOpe")
                                USE IN cursor_4c_InsOpe
                            ENDIF
                        ENDIF
                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF

                *-- Inserir composicoes em SigCdFsc
                IF loc_lSucesso AND USED(par_cCursorCompo)
                    SELECT (par_cCursorCompo)
                    GO TOP
                    SCAN
                        IF !EMPTY(ALLTRIM(Compos))
                            loc_cIdChaves = fUniqueIds()
                            loc_cSQL = "INSERT INTO SigCdFsc (cIdChaves, Codigos, Compos)" + ;
                                       " VALUES (" + ;
                                       EscaparSQL(loc_cIdChaves) + ", " + ;
                                       EscaparSQL(par_cCodigos) + ", " + ;
                                       EscaparSQL(ALLTRIM(Compos)) + ;
                                       ")"
                            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_InsCompo")
                            IF loc_nResult < 0
                                MsgErro("Erro ao salvar composi" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                                loc_lSucesso = .F.
                            ENDIF
                            IF USED("cursor_4c_InsCompo")
                                USE IN cursor_4c_InsCompo
                            ENDIF
                        ENDIF
                        IF !loc_lSucesso
                            EXIT
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.SalvarRelacionados: " + loc_oErro.Message, "Erro")
            loc_lSucesso = .F.
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExcluirRelacionados - Deleta SigCdFsi/SigCdFso/SigCdFsc pelo codigo
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExcluirRelacionados()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigCdFsi WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelFsi")
            IF USED("cursor_4c_DelFsi")
                USE IN cursor_4c_DelFsi
            ENDIF

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdFso WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelFso")
                IF USED("cursor_4c_DelFso")
                    USE IN cursor_4c_DelFso
                ENDIF
            ENDIF

            IF loc_nResult >= 0
                loc_cSQL = "DELETE FROM SigCdFsc WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DelFsc")
                IF USED("cursor_4c_DelFsc")
                    USE IN cursor_4c_DelFsc
                ENDIF
            ENDIF

            IF loc_nResult >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir relacionamentos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.ExcluirRelacionados: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarEmpresas - Carrega empresas ativas com marca dos vinculados ao motivo
    * Popula cursor_4c_Emps com: Imps L, Emps C(3), Razas C(...)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarEmpresas(par_cCodigos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT CAST(0 AS BIT) AS Imps, Cemps AS Emps, Razas" + ;
                       " FROM SigCdEmp" + ;
                       " WHERE NOT Ativas = 2" + ;
                       " ORDER BY Cemps"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Emps")
            IF loc_nResult >= 0
                *-- Marcar empresas vinculadas
                IF !EMPTY(par_cCodigos)
                    loc_cSQL = "SELECT Emps FROM SigCdFsi WHERE Codigos = " + EscaparSQL(par_cCodigos)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_EmpsVinc") >= 0
                        SELECT cursor_4c_EmpsVinc
                        SCAN
                            UPDATE cursor_4c_Emps SET Imps = .T. WHERE Emps = ALLTRIM(cursor_4c_EmpsVinc.Emps)
                        ENDSCAN
                    ENDIF
                    IF USED("cursor_4c_EmpsVinc")
                        USE IN cursor_4c_EmpsVinc
                    ENDIF
                ENDIF
                GO TOP IN cursor_4c_Emps
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar empresas:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarEmpresas: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarOperacoes - Carrega operacoes ativas com marca dos vinculados ao motivo
    * Popula cursor_4c_Opers com: Imps L, Dopes C(20)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT CAST(0 AS BIT) AS Imps, a.Dopes" + ;
                       " FROM SigCdOpe a INNER JOIN SigOpCdc b ON b.Dopes = a.Dopes" + ;
                       " WHERE b.OpeInatvs <> 1" + ;
                       " ORDER BY a.Dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Opers")
            IF loc_nResult >= 0
                *-- Marcar operacoes vinculadas
                IF !EMPTY(par_cCodigos)
                    loc_cSQL = "SELECT Dopes FROM SigCdFso WHERE Codigos = " + EscaparSQL(par_cCodigos)
                    IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_OpesVinc") >= 0
                        SELECT cursor_4c_OpesVinc
                        SCAN
                            UPDATE cursor_4c_Opers SET Imps = .T. WHERE Dopes = ALLTRIM(cursor_4c_OpesVinc.Dopes)
                        ENDSCAN
                    ENDIF
                    IF USED("cursor_4c_OpesVinc")
                        USE IN cursor_4c_OpesVinc
                    ENDIF
                ENDIF
                GO TOP IN cursor_4c_Opers
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarOperacoes: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarComposicoes - Carrega composicoes vinculadas ao motivo para edicao
    * Popula cursor_4c_Compos (readwrite) com: Compos C(30)
    * Par: par_cCodigos - codigo do motivo (vazio = cursor vazio)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarComposicoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Compos")
                USE IN cursor_4c_Compos
            ENDIF

            IF EMPTY(par_cCodigos)
                *-- Cursor vazio para inclusao
                CREATE CURSOR cursor_4c_Compos (Compos C(30))
                loc_lSucesso = .T.
            ELSE
                loc_cSQL = "SELECT Compos FROM SigCdFsc WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                           " ORDER BY Compos"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Compos")
                IF loc_nResult >= 0
                    GO TOP IN cursor_4c_Compos
                    loc_lSucesso = .T.
                ELSE
                    MsgErro("Erro ao carregar composi" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.CarregarComposicoes: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarComposicoesProdutos - Cursor de composicoes de SigCdPro para lookup
    * Popula cursor_4c_CsCompos com: Compos C(30)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarComposicoesProdutos()
        LOCAL loc_cSQL, loc_nResult, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT DISTINCT Compos FROM SigCdPro ORDER BY Compos"
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CsCompos")
            IF loc_nResult >= 0
                GO TOP IN cursor_4c_CsCompos
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar composi" + CHR(231) + CHR(245) + "es de produtos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em MdaBO.BuscarComposicoesProdutos: " + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF
        IF USED("cursor_4c_Emps")
            USE IN cursor_4c_Emps
        ENDIF
        IF USED("cursor_4c_Opers")
            USE IN cursor_4c_Opers
        ENDIF
        IF USED("cursor_4c_Compos")
            USE IN cursor_4c_Compos
        ENDIF
        IF USED("cursor_4c_CsCompos")
            USE IN cursor_4c_CsCompos
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

