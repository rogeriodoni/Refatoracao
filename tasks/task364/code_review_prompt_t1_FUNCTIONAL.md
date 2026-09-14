# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (14)
- [BINDEVENT-PARAMS] Handler 'Text29LostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE Text29LostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'Text30LostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE Text30LostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [BINDEVENT-PARAMS] Handler 'Text40LostFocus' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE Text40LostFocus(par_nKeyCode, par_nShiftAltCtrl)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDCFB.pagina.dados): Top original=121 vs migrado 'lbl_4c_Label15' Top=399 (diff=278px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label1' (parent: SIGCDCFB.pagina.dados): Left original=61 vs migrado 'lbl_4c_Label15' Left=109 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDCFB.pagina.dados): Top original=206 vs migrado 'lbl_4c_Label20' Top=383 (diff=177px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label2' (parent: SIGCDCFB.pagina.dados): Left original=64 vs migrado 'lbl_4c_Label20' Left=409 (diff=345px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text1' (parent: SIGCDCFB.pagina.dados): Top original=220 vs migrado 'txt_4c_Text11' Top=324 (diff=104px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDCFB.pagina.dados): Top original=221 vs migrado 'lbl_4c_Label32' Top=361 (diff=140px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Label3' (parent: SIGCDCFB.pagina.dados): Left original=109 vs migrado 'lbl_4c_Label32' Left=61 (diff=48px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDCFB.pagina.dados): Top original=220 vs migrado 'txt_4c_Text31' Top=537 (diff=317px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text3' (parent: SIGCDCFB.pagina.dados): Left original=179 vs migrado 'txt_4c_Text31' Left=263 (diff=84px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDCFB.pagina.dados): Top original=220 vs migrado 'txt_4c_Text40' Top=502 (diff=282px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Text4' (parent: SIGCDCFB.pagina.dados): Left original=233 vs migrado 'txt_4c_Text40' Left=336 (diff=103px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCfb.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2781 linhas total):

*-- Linhas 28 a 153:
28:     this_cModoAtual      = "LISTA"
29: 
30:     *--------------------------------------------------------------------------
31:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
32:     *--------------------------------------------------------------------------
33:     PROCEDURE Init()
34:         LOCAL loc_lResultado
35:         loc_lResultado = .F.
36: 
37:         TRY
38:             loc_lResultado = DODEFAULT()
39:         CATCH TO loc_oErro
40:             MsgErro(loc_oErro.Message, "FormCfb.Init")
41:         ENDTRY
42: 
43:         RETURN loc_lResultado
44:     ENDPROC
45: 
46:     *--------------------------------------------------------------------------
47:     * InicializarForm - Conecta BO e cria estrutura PageFrame
48:     * Chamado automaticamente pelo FormBase.Init()
49:     *--------------------------------------------------------------------------
50:     PROTECTED PROCEDURE InicializarForm()
51:         LOCAL loc_lResultado
52:         loc_lResultado = .F.
53: 
54:         TRY
55:             THIS.this_oBusinessObject = CREATEOBJECT("CfbBO")
56: 
57:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
58:                 MsgErro("Falha ao criar CfbBO", "Erro")
59:             ELSE
60:                 THIS.ConfigurarPageFrame()
61: 
62:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
63:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
64: 
65:                 THIS.pgf_4c_Paginas.Visible    = .T.
66:                 THIS.pgf_4c_Paginas.ActivePage = 1
67:                 THIS.this_cModoAtual           = "LISTA"
68: 
69:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
70:                     THIS.CarregarLista()
71:                 ENDIF
72: 
73:                 loc_lResultado = .T.
74:             ENDIF
75:         CATCH TO loc_oErro
76:             MsgErro(loc_oErro.Message, "FormCfb.InicializarForm")
77:         ENDTRY
78: 
79:         RETURN loc_lResultado
80:     ENDPROC
81: 
82:     *--------------------------------------------------------------------------
83:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
84:     *--------------------------------------------------------------------------
85:     PROTECTED PROCEDURE ConfigurarPageFrame()
86:         LOCAL loc_oPgf
87:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
88:         loc_oPgf = THIS.pgf_4c_Paginas
89: 
90:         WITH loc_oPgf
91:             .PageCount = 2
92:             .Top       = -29
93:             .Left      = 0
94:             .Width     = THIS.Width
95:             .Height    = THIS.Height + 29
96:             .Tabs      = .F.
97:             .Visible   = .T.
98:             .Page1.Caption   = "Lista"
99:             .Page1.BackColor = RGB(100, 100, 100)
100:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
101:             .Page2.Caption   = "Dados"
102:             .Page2.BackColor = RGB(100, 100, 100)
103:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
104:         ENDWITH
105: 
106:         THIS.ConfigurarPaginaLista()
107:         THIS.ConfigurarPaginaDados()
108:     ENDPROC
109: 
110:     *--------------------------------------------------------------------------
111:     * ConfigurarPaginaLista - Cria Page1 (Lista) com Grid e botoes CRUD
112:     *--------------------------------------------------------------------------
113:     PROTECTED PROCEDURE ConfigurarPaginaLista()
114:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida, loc_oGrid
115: 
116:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
117: 
118:         *-- Cabecalho cinza (Top=1 + 29 compensacao = 30)
119:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
120:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
121:         WITH loc_oCab
122:             .Top           = 30
123:             .Left          = 0
124:             .Width         = THIS.Width
125:             .Height        = 80
126:             .BackColor     = RGB(100, 100, 100)
127:             .BorderWidth   = 0
128:             .SpecialEffect = 0
129:             .Visible       = .T.
130:         ENDWITH
131: 
132:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
133:         WITH loc_oCab.lbl_4c_Sombra
134:             .AutoSize  = .F.
135:             .Caption   = THIS.Caption
136:             .Top       = 15
137:             .Left      = 10
138:             .Width     = THIS.Width
139:             .Height    = 40
140:             .FontName  = "Tahoma"
141:             .FontSize  = 16
142:             .FontBold  = .T.
143:             .ForeColor = RGB(0, 0, 0)
144:             .BackStyle = 0
145:             .Visible   = .T.
146:         ENDWITH
147: 
148:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
149:         WITH loc_oCab.lbl_4c_Titulo
150:             .AutoSize  = .F.
151:             .Caption   = THIS.Caption
152:             .Top       = 18
153:             .Left      = 10

*-- Linhas 287 a 371:
287:             .Visible         = .T.
288:         ENDWITH
289: 
290:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
291:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
292:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
293:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
294:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
295: 
296:         *-- Container Encerrar (canonico: Left=917, Top=29)
297:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
298:         loc_oSaida = loc_oPg1.cnt_4c_Saida
299:         WITH loc_oSaida
300:             .Top           = 29
301:             .Left          = 917
302:             .Width         = 90
303:             .Height        = 85
304:             .BackStyle     = 0
305:             .BorderWidth   = 0
306:             .Visible       = .T.
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
321:             .FontBold        = .T.
322:             .FontItalic      = .T.
323:             .FontSize        = 8
324:             .Themes          = .F.
325:             .SpecialEffect   = 0
326:             .MousePointer    = 15
327:             .WordWrap        = .T.
328:             .Visible         = .T.
329:         ENDWITH
330: 
331:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
332: 
333:         *-- Grid de lista (Top=117 = 88+29 compensacao)
334:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
335:         loc_oGrid = loc_oPg1.grd_4c_Lista
336:         loc_oGrid.Top         = 117
337:         loc_oGrid.Left        = 12
338:         loc_oGrid.Width       = 950
339:         loc_oGrid.Height      = 476
340:         loc_oGrid.ColumnCount = 3
341:         WITH loc_oGrid
342:             .FontName           = "Verdana"
343:             .FontSize           = 8
344:             .ForeColor          = RGB(90, 90, 90)
345:             .BackColor          = RGB(255, 255, 255)
346:             .DeleteMark         = .F.
347:             .RecordMark         = .F.
348:             .GridLines          = 3
349:             .GridLineColor      = RGB(238, 238, 238)
350:             .HighlightBackColor = RGB(255, 255, 255)
351:             .HighlightForeColor = RGB(15, 41, 104)
352:             .HighlightStyle     = 2
353:             .RowHeight          = 16
354:             .ScrollBars         = 2
355:             .Visible            = .T.
356:         ENDWITH
357: 
358:         WITH loc_oGrid.Column1
359:             .Width           = 100
360:             .Resizable       = .T.
361:             .Alignment       = 0
362:             .Header1.Caption = "Forma Pgto"
363:             .Header1.FontName = "Tahoma"
364:             .Header1.FontSize = 8
365:         ENDWITH
366: 
367:         WITH loc_oGrid.Column2
368:             .Width           = 680
369:             .Resizable       = .T.
370:             .Alignment       = 0
371:             .Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"

*-- Linhas 382 a 431:
382:             .Header1.FontSize = 8
383:         ENDWITH
384: 
385:         THIS.TornarControlesVisiveis(loc_oPg1)
386:     ENDPROC
387: 
388:     *--------------------------------------------------------------------------
389:     * ConfigurarPaginaDados - Fase 6/8: Todos os campos completos + BINDEVENTs
390:     *--------------------------------------------------------------------------
391:     PROTECTED PROCEDURE ConfigurarPaginaDados()
392:         LOCAL loc_oPg2, loc_oSalva
393: 
394:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
395: 
396:         *-- Container botoes Confirmar/Cancelar (Top=4+29=33, Left=842 canonico)
397:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
398:         loc_oSalva = loc_oPg2.cnt_4c_BotoesAcao
399:         WITH loc_oSalva
400:             .Top         = 33
401:             .Left        = 842
402:             .Width       = 160
403:             .Height      = 85
404:             .BackStyle   = 0
405:             .BorderWidth = 0
406:             .Visible     = .T.
407:         ENDWITH
408: 
409:         loc_oSalva.AddObject("cmd_4c_Confirmar", "CommandButton")
410:         WITH loc_oSalva.cmd_4c_Confirmar
411:             .Caption         = "Confirmar"
412:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
413:             .PicturePosition = 13
414:             .Top             = 5
415:             .Left            = 5
416:             .Width           = 75
417:             .Height          = 75
418:             .BackColor       = RGB(255, 255, 255)
419:             .ForeColor       = RGB(90, 90, 90)
420:             .FontName        = "Comic Sans MS"
421:             .FontBold        = .T.
422:             .FontItalic      = .T.
423:             .FontSize        = 8
424:             .Themes          = .F.
425:             .SpecialEffect   = 0
426:             .MousePointer    = 15
427:             .WordWrap        = .T.
428:             .Visible         = .T.
429:         ENDWITH
430: 
431:         loc_oSalva.AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 450 a 494:
450:             .Visible         = .T.
451:         ENDWITH
452: 
453:         BINDEVENT(loc_oSalva.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
454:         BINDEVENT(loc_oSalva.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
455: 
456:         *-- Shape2: separador no topo da area de dados (top=138+29=167)
457:         loc_oPg2.AddObject("shp_4c_Shape2", "Shape")
458:         WITH loc_oPg2.shp_4c_Shape2
459:             .Top       = 167
460:             .Left      = 54
461:             .Width     = 577
462:             .Height    = 2
463:             .BackColor = RGB(80, 80, 80)
464:             .FillStyle = 1
465:             .BackStyle = 1
466:             .Visible   = .T.
467:         ENDWITH
468: 
469:         *-- ==============================================================
470:         *-- SECAO: Condicao de Pagamento (top original=121-144 + 29=150-173)
471:         *-- ==============================================================
472:         loc_oPg2.AddObject("lbl_4c_Label1", "Label")
473:         WITH loc_oPg2.lbl_4c_Label1
474:             .AutoSize  = .F.
475:             .Caption   = " Condi" + CHR(231) + CHR(227) + "o de Pagamento "
476:             .Top       = 150
477:             .Left      = 61
478:             .Width     = 144
479:             .Height    = 15
480:             .FontName  = "Tahoma"
481:             .FontSize  = 8
482:             .FontBold  = .F.
483:             .ForeColor = RGB(255, 255, 255)
484:             .BackStyle = 0
485:             .Visible   = .T.
486:         ENDWITH
487: 
488:         *-- txt_4c_FPags: codigo da condicao de pagamento (sempre read-only - FK SigOpFp)
489:         loc_oPg2.AddObject("txt_4c_FPags", "TextBox")
490:         WITH loc_oPg2.txt_4c_FPags
491:             .Value    = ""
492:             .Top      = 173
493:             .Left     = 64
494:             .Width    = 94

*-- Linhas 877 a 898:
877:             .ForeColor = RGB(255, 255, 255)
878:             .BackStyle = 0
879:             .Visible   = .T.
880:         ENDWITH
881: 
882:         loc_oPg2.AddObject("txt_4c_Text11", "TextBox")
883:         WITH loc_oPg2.txt_4c_Text11
884:             .Value    = 0
885:             .Top      = 324
886:             .Left     = 64
887:             .Width    = 41
888:             .Height   = 18
889:             .FontName = "Tahoma"
890:             .FontSize = 8
891:             .Enabled  = .F.
892:             .Visible  = .T.
893:         ENDWITH
894: 
895:         loc_oPg2.AddObject("lbl_4c_Label13", "Label")
896:         WITH loc_oPg2.lbl_4c_Label13
897:             .AutoSize  = .F.
898:             .Caption   = "x"

*-- Linhas 1490 a 1511:
1490:             .FontSize  = 8
1491:             .ForeColor = RGB(255, 255, 255)
1492:             .BackStyle = 0
1493:             .Visible   = .T.
1494:         ENDWITH
1495:         loc_oPg2.AddObject("txt_4c_Text31", "TextBox")
1496:         WITH loc_oPg2.txt_4c_Text31
1497:             .Value    = 0
1498:             .Top      = 537
1499:             .Left     = 263
1500:             .Width    = 41
1501:             .Height   = 18
1502:             .FontName = "Tahoma"
1503:             .FontSize = 8
1504:             .Enabled  = .F.
1505:             .Visible  = .T.
1506:         ENDWITH
1507: 
1508:         *-- Tamanho Folha (Label38 + Text40) top=460+29=489 / 473+29=502
1509:         loc_oPg2.AddObject("lbl_4c_Label38", "Label")
1510:         WITH loc_oPg2.lbl_4c_Label38
1511:             .AutoSize  = .F.

*-- Linhas 1518 a 1863:
1518:             .FontSize  = 8
1519:             .ForeColor = RGB(255, 255, 255)
1520:             .BackStyle = 0
1521:             .Visible   = .T.
1522:         ENDWITH
1523:         loc_oPg2.AddObject("txt_4c_Text40", "TextBox")
1524:         WITH loc_oPg2.txt_4c_Text40
1525:             .Value    = ""
1526:             .Top      = 502
1527:             .Left     = 336
1528:             .Width    = 244
1529:             .Height   = 19
1530:             .FontName = "Tahoma"
1531:             .FontSize = 8
1532:             .Enabled  = .F.
1533:             .Visible  = .T.
1534:         ENDWITH
1535: 
1536:         *-- BINDEVENT: validacao de impressora, fonte e tamanho de folha ao sair do campo
1537:         BINDEVENT(loc_oPg2.txt_4c_Text29, "KeyPress", THIS, "Text29LostFocus")
1538:         BINDEVENT(loc_oPg2.txt_4c_Text30, "KeyPress", THIS, "Text30LostFocus")
1539:         BINDEVENT(loc_oPg2.txt_4c_Text40, "KeyPress", THIS, "Text40LostFocus")
1540: 
1541:         THIS.TornarControlesVisiveis(loc_oPg2)
1542:     ENDPROC
1543: 
1544:     *--------------------------------------------------------------------------
1545:     * CarregarLista - Carrega lista de condicoes de pagamento no Grid (Page1)
1546:     *--------------------------------------------------------------------------
1547:     PROCEDURE CarregarLista()
1548:         LOCAL loc_lResultado, loc_oGrid
1549:         loc_lResultado = .F.
1550: 
1551:         TRY
1552:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
1553:                 loc_lResultado = .T.
1554:             ELSE
1555:                 IF !THIS.this_oBusinessObject.Buscar("")
1556:                     loc_lResultado = .F.
1557:                 ELSE
1558:                     loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1559: 
1560:                     *-- RecordSource FORA do WITH para garantir criacao imediata das colunas
1561:                     loc_oGrid.ColumnCount = 3
1562:                     loc_oGrid.RecordSource = "cursor_4c_Dados"
1563:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
1564:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1565:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"
1566: 
1567:                     *-- Reconfigurar headers apos RecordSource (VFP9 reseta headers)
1568:                     loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
1569:                     loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1570:                     loc_oGrid.Column3.Header1.Caption = "Configurado"
1571: 
1572:                     THIS.FormatarGridLista(loc_oGrid)
1573:                     loc_lResultado = .T.
1574:                 ENDIF
1575:             ENDIF
1576:         CATCH TO loc_oErro
1577:             MsgErro(loc_oErro.Message, "FormCfb.CarregarLista")
1578:             loc_lResultado = .F.
1579:         ENDTRY
1580: 
1581:         RETURN loc_lResultado
1582:     ENDPROC
1583: 
1584:     *--------------------------------------------------------------------------
1585:     * AlternarPagina - Alterna entre Page1 (Lista=1) e Page2 (Dados=2)
1586:     *--------------------------------------------------------------------------
1587:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
1588:         LOCAL loc_lResultado
1589:         loc_lResultado = .F.
1590: 
1591:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
1592:             RETURN .F.
1593:         ENDIF
1594: 
1595:         TRY
1596:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
1597: 
1598:             IF par_nPagina = 1
1599:                 THIS.CarregarLista()
1600:             ENDIF
1601: 
1602:             loc_lResultado = .T.
1603:         CATCH TO loc_oErro
1604:             MsgErro(loc_oErro.Message, "FormCfb.AlternarPagina")
1605:         ENDTRY
1606: 
1607:         RETURN loc_lResultado
1608:     ENDPROC
1609: 
1610:     *--------------------------------------------------------------------------
1611:     * BtnEncerrarClick - Fecha o formulario
1612:     *--------------------------------------------------------------------------
1613:     PROCEDURE BtnEncerrarClick()
1614:         THIS.Release()
1615:     ENDPROC
1616: 
1617:     *--------------------------------------------------------------------------
1618:     * BtnSalvarClick - Salva configuracao de boleto (stub - Fase 7 completa)
1619:     * Legado: somente ALTERAR e permitido (pcEscolha = 'INSERIR' e bloqueado)
1620:     *--------------------------------------------------------------------------
1621:     PROCEDURE BtnSalvarClick()
1622:         LOCAL loc_lResultado
1623:         loc_lResultado = .F.
1624: 
1625:         TRY
1626:             IF THIS.this_cModoAtual = "INCLUIR"
1627:                 MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + ;
1628:                     "vel Inserir Dados Atrav" + CHR(233) + "s Deste Cadastro!!!" + ;
1629:                     CHR(13) + "Use a Op" + CHR(231) + CHR(227) + "o Alterar ou o " + ;
1630:                     "Cadastro de Condi" + CHR(231) + CHR(245) + "es de Pagamento.", ;
1631:                     "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
1632:                 loc_lResultado = .F.
1633:             ELSE
1634:                 IF THIS.this_oBusinessObject.Salvar()
1635:                     MsgInfo("Configura" + CHR(231) + CHR(227) + "o salva com sucesso!")
1636:                     THIS.this_cModoAtual = "LISTA"
1637:                     THIS.AlternarPagina(1)
1638:                     loc_lResultado = .T.
1639:                 ENDIF
1640:             ENDIF
1641:         CATCH TO loc_oErro
1642:             MsgErro(loc_oErro.Message, "FormCfb.BtnSalvarClick")
1643:         ENDTRY
1644: 
1645:         RETURN loc_lResultado
1646:     ENDPROC
1647: 
1648:     *--------------------------------------------------------------------------
1649:     * BtnCancelarClick - Cancela edicao e volta para lista
1650:     *--------------------------------------------------------------------------
1651:     PROCEDURE BtnCancelarClick()
1652:         THIS.this_cModoAtual = "LISTA"
1653:         THIS.AlternarPagina(1)
1654:         THIS.CarregarLista()
1655:     ENDPROC
1656: 
1657:     *--------------------------------------------------------------------------
1658:     * BtnIncluirClick - Bloqueia insercao (legado: so Alterar e permitido)
1659:     *--------------------------------------------------------------------------
1660:     PROCEDURE BtnIncluirClick()
1661:         MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + ;
1662:             "vel Inserir Dados Atrav" + CHR(233) + "s Deste Cadastro!!!" + ;
1663:             CHR(13) + "Use a Op" + CHR(231) + CHR(227) + "o Alterar ou o " + ;
1664:             "Cadastro de Condi" + CHR(231) + CHR(245) + "es de Pagamento.", ;
1665:             "Opera" + CHR(231) + CHR(227) + "o Inv" + CHR(225) + "lida")
1666:     ENDPROC
1667: 
1668:     *--------------------------------------------------------------------------
1669:     * BtnAlterarClick - Carrega configuracao selecionada para edicao
1670:     *--------------------------------------------------------------------------
1671:     PROCEDURE BtnAlterarClick()
1672:         LOCAL loc_cFPags, loc_cDescrs
1673:         loc_cFPags  = ""
1674:         loc_cDescrs = ""
1675: 
1676:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1677:             MsgAviso("Selecione uma condi" + CHR(231) + CHR(227) + "o de pagamento.", "")
1678:             RETURN
1679:         ENDIF
1680: 
1681:         SELECT cursor_4c_Dados
1682:         loc_cFPags  = ALLTRIM(cursor_4c_Dados.FPags)
1683:         loc_cDescrs = ALLTRIM(cursor_4c_Dados.Descrs)
1684: 
1685:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFPags)
1686:             THIS.this_oBusinessObject.this_cDescrs = loc_cDescrs
1687:             THIS.this_oBusinessObject.EditarRegistro()
1688:             THIS.this_cModoAtual = "ALTERAR"
1689:             THIS.BOParaForm()
1690:             THIS.HabilitarCampos(.T.)
1691:             THIS.AlternarPagina(2)
1692:         ELSE
1693:             MsgAviso("Nenhuma configura" + CHR(231) + CHR(227) + "o encontrada para " + ;
1694:                 "esta condi" + CHR(231) + CHR(227) + "o." + CHR(13) + ;
1695:                 "O registro ser" + CHR(225) + " criado ao salvar.", "")
1696:             THIS.this_oBusinessObject.NovoRegistro()
1697:             THIS.this_oBusinessObject.this_cFPags   = loc_cFPags
1698:             THIS.this_oBusinessObject.this_cDescrs  = loc_cDescrs
1699:             THIS.this_cModoAtual = "ALTERAR"
1700:             THIS.LimparCampos()
1701:             THIS.HabilitarCampos(.T.)
1702:             THIS.AlternarPagina(2)
1703:         ENDIF
1704:     ENDPROC
1705: 
1706:     *--------------------------------------------------------------------------
1707:     * BtnVisualizarClick - Carrega configuracao selecionada somente leitura
1708:     *--------------------------------------------------------------------------
1709:     PROCEDURE BtnVisualizarClick()
1710:         LOCAL loc_cFPags, loc_cDescrs
1711:         loc_cFPags  = ""
1712:         loc_cDescrs = ""
1713: 
1714:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1715:             MsgAviso("Selecione uma condi" + CHR(231) + CHR(227) + "o de pagamento.", "")
1716:             RETURN
1717:         ENDIF
1718: 
1719:         SELECT cursor_4c_Dados
1720:         loc_cFPags  = ALLTRIM(cursor_4c_Dados.FPags)
1721:         loc_cDescrs = ALLTRIM(cursor_4c_Dados.Descrs)
1722: 
1723:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFPags)
1724:             MsgAviso("Nenhuma configura" + CHR(231) + CHR(227) + "o encontrada para " + ;
1725:                 "esta condi" + CHR(231) + CHR(227) + "o de pagamento.", "")
1726:             RETURN
1727:         ENDIF
1728: 
1729:         THIS.this_oBusinessObject.this_cDescrs = loc_cDescrs
1730:         THIS.this_cModoAtual = "VISUALIZAR"
1731:         THIS.BOParaForm()
1732:         THIS.HabilitarCampos(.F.)
1733:         THIS.AlternarPagina(2)
1734:     ENDPROC
1735: 
1736:     *--------------------------------------------------------------------------
1737:     * BtnExcluirClick - Exclui configuracao da condicao de pagamento selecionada
1738:     *--------------------------------------------------------------------------
1739:     PROCEDURE BtnExcluirClick()
1740:         LOCAL loc_cFPags
1741: 
1742:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
1743:             MsgAviso("Selecione uma condi" + CHR(231) + CHR(227) + "o de pagamento.", "")
1744:             RETURN
1745:         ENDIF
1746: 
1747:         SELECT cursor_4c_Dados
1748:         IF EMPTY(ALLTRIM(NVL(cursor_4c_Dados.TemDados, "")))
1749:             MsgAviso("Esta condi" + CHR(231) + CHR(227) + "o n" + CHR(227) + ;
1750:                 "o possui configura" + CHR(231) + CHR(227) + "o de boleto.", "")
1751:             RETURN
1752:         ENDIF
1753: 
1754:         loc_cFPags = ALLTRIM(cursor_4c_Dados.FPags)
1755: 
1756:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o da configura" + CHR(231) + ;
1757:                 CHR(227) + "o de boleto para:" + CHR(13) + loc_cFPags + "?", ;
1758:                 "Confirmar Exclus" + CHR(227) + "o")
1759:             RETURN
1760:         ENDIF
1761: 
1762:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFPags)
1763:             IF THIS.this_oBusinessObject.Excluir()
1764:                 MsgInfo("Configura" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + "da com sucesso!")
1765:                 THIS.CarregarLista()
1766:             ENDIF
1767:         ENDIF
1768:     ENDPROC
1769: 
1770:     *--------------------------------------------------------------------------
1771:     * BtnBuscarClick - Filtra lista por texto digitado
1772:     *--------------------------------------------------------------------------
1773:     PROCEDURE BtnBuscarClick()
1774:         LOCAL loc_cFiltro, loc_oGrid
1775:         loc_cFiltro = ""
1776: 
1777:         loc_cFiltro = INPUTBOX("Informe a forma ou descri" + CHR(231) + CHR(227) + ;
1778:             "o para filtrar:", "Buscar", "")
1779: 
1780:         IF !THIS.this_oBusinessObject.Buscar(ALLTRIM(loc_cFiltro))
1781:             RETURN
1782:         ENDIF
1783: 
1784:         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
1785:         loc_oGrid.ColumnCount = 3
1786:         loc_oGrid.RecordSource = "cursor_4c_Dados"
1787:         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
1788:         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
1789:         loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"
1790:         loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
1791:         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
1792:         loc_oGrid.Column3.Header1.Caption = "Configurado"
1793:         THIS.FormatarGridLista(loc_oGrid)
1794:     ENDPROC
1795: 
1796:     *--------------------------------------------------------------------------
1797:     * FormParaBO - Transfere valores dos campos do Form para o BO
1798:     * Fase 5: Secoes Condicao de Pagamento + Cabecalho + Texto Responsabilidade
1799:     *--------------------------------------------------------------------------
1800:     PROTECTED PROCEDURE FormParaBO()
1801:         LOCAL loc_oPg2
1802:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1803: 
1804:         TRY
1805:             *-- Condicao de Pagamento (FPags read-only, mas propaga para garantir consistencia)
1806:             IF PEMSTATUS(loc_oPg2, "txt_4c_FPags", 5)
1807:                 THIS.this_oBusinessObject.this_cFPags = ALLTRIM(loc_oPg2.txt_4c_FPags.Value)
1808:             ENDIF
1809: 
1810:             *-- Secao Cabecalho: Local de Pagamento (linha x coluna)
1811:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
1812:                 THIS.this_oBusinessObject.this_nNlnLocals = loc_oPg2.txt_4c_Text1.Value
1813:             ENDIF
1814:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
1815:                 THIS.this_oBusinessObject.this_nNclLocals = loc_oPg2.txt_4c_Text2.Value
1816:             ENDIF
1817:             *-- Vencimento (linha x coluna)
1818:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text3", 5)
1819:                 THIS.this_oBusinessObject.this_nNlnDtVencs = loc_oPg2.txt_4c_Text3.Value
1820:             ENDIF
1821:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text4", 5)
1822:                 THIS.this_oBusinessObject.this_nNclDtVencs = loc_oPg2.txt_4c_Text4.Value
1823:             ENDIF
1824:             *-- Data Documento (linha x coluna)
1825:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
1826:                 THIS.this_oBusinessObject.this_nNlnDtDocs = loc_oPg2.txt_4c_Text5.Value
1827:             ENDIF
1828:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
1829:                 THIS.this_oBusinessObject.this_nNclDtDocs = loc_oPg2.txt_4c_Text6.Value
1830:             ENDIF
1831:             *-- Nro Documento (linha x coluna)
1832:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
1833:                 THIS.this_oBusinessObject.this_nNlnNrDocs = loc_oPg2.txt_4c_Text7.Value
1834:             ENDIF
1835:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
1836:                 THIS.this_oBusinessObject.this_nNclNrDocs = loc_oPg2.txt_4c_Text8.Value
1837:             ENDIF
1838:             *-- Valor Documento (linha x coluna)
1839:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
1840:                 THIS.this_oBusinessObject.this_nNlnVlDocs = loc_oPg2.txt_4c_Text9.Value
1841:             ENDIF
1842:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
1843:                 THIS.this_oBusinessObject.this_nNclVlDocs = loc_oPg2.txt_4c_Text10.Value
1844:             ENDIF
1845: 
1846:             *-- Secao Texto Responsabilidade do Cedente (linha x coluna + qtd linhas/colunas)
1847:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text11", 5)
1848:                 THIS.this_oBusinessObject.this_nNlnTxtCds = loc_oPg2.txt_4c_Text11.Value
1849:             ENDIF
1850:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text12", 5)
1851:                 THIS.this_oBusinessObject.this_nNclTxtCds = loc_oPg2.txt_4c_Text12.Value
1852:             ENDIF
1853:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text13", 5)
1854:                 THIS.this_oBusinessObject.this_nNTxtCols = loc_oPg2.txt_4c_Text13.Value
1855:             ENDIF
1856:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text14", 5)
1857:                 THIS.this_oBusinessObject.this_nNTxtLins = loc_oPg2.txt_4c_Text14.Value
1858:             ENDIF
1859: 
1860:             *-- Secao Sacado: Razao Social (linha x coluna)
1861:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text15", 5)
1862:                 THIS.this_oBusinessObject.this_nNlnRazClis = loc_oPg2.txt_4c_Text15.Value
1863:             ENDIF

*-- Linhas 1912 a 1998:
1912:                 THIS.this_oBusinessObject.this_cCNomeImps = ALLTRIM(loc_oPg2.txt_4c_Text29.Value)
1913:             ENDIF
1914:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
1915:                 THIS.this_oBusinessObject.this_cCFontePdrs = ALLTRIM(loc_oPg2.txt_4c_Text30.Value)
1916:             ENDIF
1917:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
1918:                 THIS.this_oBusinessObject.this_nNTamFontes = loc_oPg2.txt_4c_Text31.Value
1919:             ENDIF
1920:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
1921:                 THIS.this_oBusinessObject.this_cCTamFolha = ALLTRIM(loc_oPg2.txt_4c_Text40.Value)
1922:             ENDIF
1923:         CATCH TO loc_oErro
1924:             MsgErro(loc_oErro.Message, "FormCfb.FormParaBO")
1925:         ENDTRY
1926:     ENDPROC
1927: 
1928:     *--------------------------------------------------------------------------
1929:     * BOParaForm - Transfere valores do BO para os campos do Form
1930:     * Fase 5: Secoes Condicao de Pagamento + Cabecalho + Texto Responsabilidade
1931:     *--------------------------------------------------------------------------
1932:     PROTECTED PROCEDURE BOParaForm()
1933:         LOCAL loc_oPg2
1934:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
1935: 
1936:         TRY
1937:             *-- Condicao de Pagamento (codigo e descricao - sempre read-only)
1938:             IF PEMSTATUS(loc_oPg2, "txt_4c_FPags", 5)
1939:                 loc_oPg2.txt_4c_FPags.Value = ALLTRIM(THIS.this_oBusinessObject.this_cFPags)
1940:             ENDIF
1941:             IF PEMSTATUS(loc_oPg2, "txt_4c_DPags", 5)
1942:                 loc_oPg2.txt_4c_DPags.Value = ALLTRIM(THIS.this_oBusinessObject.this_cDescrs)
1943:             ENDIF
1944: 
1945:             *-- Secao Cabecalho: Local de Pagamento
1946:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
1947:                 loc_oPg2.txt_4c_Text1.Value = THIS.this_oBusinessObject.this_nNlnLocals
1948:             ENDIF
1949:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
1950:                 loc_oPg2.txt_4c_Text2.Value = THIS.this_oBusinessObject.this_nNclLocals
1951:             ENDIF
1952:             *-- Vencimento
1953:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text3", 5)
1954:                 loc_oPg2.txt_4c_Text3.Value = THIS.this_oBusinessObject.this_nNlnDtVencs
1955:             ENDIF
1956:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text4", 5)
1957:                 loc_oPg2.txt_4c_Text4.Value = THIS.this_oBusinessObject.this_nNclDtVencs
1958:             ENDIF
1959:             *-- Data Documento
1960:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
1961:                 loc_oPg2.txt_4c_Text5.Value = THIS.this_oBusinessObject.this_nNlnDtDocs
1962:             ENDIF
1963:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
1964:                 loc_oPg2.txt_4c_Text6.Value = THIS.this_oBusinessObject.this_nNclDtDocs
1965:             ENDIF
1966:             *-- Nro Documento
1967:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
1968:                 loc_oPg2.txt_4c_Text7.Value = THIS.this_oBusinessObject.this_nNlnNrDocs
1969:             ENDIF
1970:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
1971:                 loc_oPg2.txt_4c_Text8.Value = THIS.this_oBusinessObject.this_nNclNrDocs
1972:             ENDIF
1973:             *-- Valor Documento
1974:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
1975:                 loc_oPg2.txt_4c_Text9.Value = THIS.this_oBusinessObject.this_nNlnVlDocs
1976:             ENDIF
1977:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
1978:                 loc_oPg2.txt_4c_Text10.Value = THIS.this_oBusinessObject.this_nNclVlDocs
1979:             ENDIF
1980: 
1981:             *-- Secao Texto Responsabilidade do Cedente
1982:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text11", 5)
1983:                 loc_oPg2.txt_4c_Text11.Value = THIS.this_oBusinessObject.this_nNlnTxtCds
1984:             ENDIF
1985:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text12", 5)
1986:                 loc_oPg2.txt_4c_Text12.Value = THIS.this_oBusinessObject.this_nNclTxtCds
1987:             ENDIF
1988:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text13", 5)
1989:                 loc_oPg2.txt_4c_Text13.Value = THIS.this_oBusinessObject.this_nNTxtCols
1990:             ENDIF
1991:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text14", 5)
1992:                 loc_oPg2.txt_4c_Text14.Value = THIS.this_oBusinessObject.this_nNTxtLins
1993:             ENDIF
1994: 
1995:             *-- Secao Sacado: Razao Social (linha x coluna)
1996:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text15", 5)
1997:                 loc_oPg2.txt_4c_Text15.Value = THIS.this_oBusinessObject.this_nNlnRazClis
1998:             ENDIF

*-- Linhas 2047 a 2130:
2047:                 loc_oPg2.txt_4c_Text29.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCNomeImps)
2048:             ENDIF
2049:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
2050:                 loc_oPg2.txt_4c_Text30.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCFontePdrs)
2051:             ENDIF
2052:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
2053:                 loc_oPg2.txt_4c_Text31.Value = THIS.this_oBusinessObject.this_nNTamFontes
2054:             ENDIF
2055:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
2056:                 loc_oPg2.txt_4c_Text40.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCTamFolha)
2057:             ENDIF
2058:         CATCH TO loc_oErro
2059:             MsgErro(loc_oErro.Message, "FormCfb.BOParaForm")
2060:         ENDTRY
2061:     ENDPROC
2062: 
2063:     *--------------------------------------------------------------------------
2064:     * HabilitarCampos - Habilita ou desabilita campos editaveis da Page2
2065:     * Fase 5: Cabecalho (Text1-Text10) + Texto Responsabilidade (Text11-Text14)
2066:     * Fase 6 completara com Sacado e Impressora/Fonte
2067:     *--------------------------------------------------------------------------
2068:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2069:         LOCAL loc_oPg2
2070:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2071: 
2072:         TRY
2073:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2074:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
2075:             ENDIF
2076:             *-- txt_4c_FPags e txt_4c_DPags sao SEMPRE read-only (FK de SigOpFp)
2077: 
2078:             *-- Secao Cabecalho - Local de Pagamento
2079:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
2080:                 loc_oPg2.txt_4c_Text1.Enabled = par_lHabilitar
2081:             ENDIF
2082:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
2083:                 loc_oPg2.txt_4c_Text2.Enabled = par_lHabilitar
2084:             ENDIF
2085:             *-- Vencimento
2086:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text3", 5)
2087:                 loc_oPg2.txt_4c_Text3.Enabled = par_lHabilitar
2088:             ENDIF
2089:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text4", 5)
2090:                 loc_oPg2.txt_4c_Text4.Enabled = par_lHabilitar
2091:             ENDIF
2092:             *-- Data Documento
2093:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
2094:                 loc_oPg2.txt_4c_Text5.Enabled = par_lHabilitar
2095:             ENDIF
2096:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
2097:                 loc_oPg2.txt_4c_Text6.Enabled = par_lHabilitar
2098:             ENDIF
2099:             *-- Nro Documento
2100:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
2101:                 loc_oPg2.txt_4c_Text7.Enabled = par_lHabilitar
2102:             ENDIF
2103:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
2104:                 loc_oPg2.txt_4c_Text8.Enabled = par_lHabilitar
2105:             ENDIF
2106:             *-- Valor Documento
2107:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
2108:                 loc_oPg2.txt_4c_Text9.Enabled = par_lHabilitar
2109:             ENDIF
2110:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
2111:                 loc_oPg2.txt_4c_Text10.Enabled = par_lHabilitar
2112:             ENDIF
2113:             *-- Secao Texto Responsabilidade
2114:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text11", 5)
2115:                 loc_oPg2.txt_4c_Text11.Enabled = par_lHabilitar
2116:             ENDIF
2117:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text12", 5)
2118:                 loc_oPg2.txt_4c_Text12.Enabled = par_lHabilitar
2119:             ENDIF
2120:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text13", 5)
2121:                 loc_oPg2.txt_4c_Text13.Enabled = par_lHabilitar
2122:             ENDIF
2123:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text14", 5)
2124:                 loc_oPg2.txt_4c_Text14.Enabled = par_lHabilitar
2125:             ENDIF
2126:             *-- Secao Sacado
2127:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text15", 5)
2128:                 loc_oPg2.txt_4c_Text15.Enabled = par_lHabilitar
2129:             ENDIF
2130:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text16", 5)

*-- Linhas 2171 a 2250:
2171:                 loc_oPg2.txt_4c_Text29.Enabled = par_lHabilitar
2172:             ENDIF
2173:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
2174:                 loc_oPg2.txt_4c_Text30.Enabled = par_lHabilitar
2175:             ENDIF
2176:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
2177:                 loc_oPg2.txt_4c_Text31.Enabled = par_lHabilitar
2178:             ENDIF
2179:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
2180:                 loc_oPg2.txt_4c_Text40.Enabled = par_lHabilitar
2181:             ENDIF
2182:         CATCH TO loc_oErro
2183:             MsgErro(loc_oErro.Message, "FormCfb.HabilitarCampos")
2184:         ENDTRY
2185:     ENDPROC
2186: 
2187:     *--------------------------------------------------------------------------
2188:     * LimparCampos - Limpa valores dos campos da Page2
2189:     * Fase 5: Secoes Condicao + Cabecalho + Texto Responsabilidade
2190:     *--------------------------------------------------------------------------
2191:     PROTECTED PROCEDURE LimparCampos()
2192:         LOCAL loc_oPg2
2193:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2194: 
2195:         TRY
2196:             IF PEMSTATUS(loc_oPg2, "txt_4c_FPags", 5)
2197:                 loc_oPg2.txt_4c_FPags.Value = ""
2198:             ENDIF
2199:             IF PEMSTATUS(loc_oPg2, "txt_4c_DPags", 5)
2200:                 loc_oPg2.txt_4c_DPags.Value = ""
2201:             ENDIF
2202:             *-- Secao Cabecalho
2203:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text1", 5)
2204:                 loc_oPg2.txt_4c_Text1.Value = 0
2205:             ENDIF
2206:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text2", 5)
2207:                 loc_oPg2.txt_4c_Text2.Value = 0
2208:             ENDIF
2209:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text3", 5)
2210:                 loc_oPg2.txt_4c_Text3.Value = 0
2211:             ENDIF
2212:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text4", 5)
2213:                 loc_oPg2.txt_4c_Text4.Value = 0
2214:             ENDIF
2215:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text5", 5)
2216:                 loc_oPg2.txt_4c_Text5.Value = 0
2217:             ENDIF
2218:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text6", 5)
2219:                 loc_oPg2.txt_4c_Text6.Value = 0
2220:             ENDIF
2221:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text7", 5)
2222:                 loc_oPg2.txt_4c_Text7.Value = 0
2223:             ENDIF
2224:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text8", 5)
2225:                 loc_oPg2.txt_4c_Text8.Value = 0
2226:             ENDIF
2227:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text9", 5)
2228:                 loc_oPg2.txt_4c_Text9.Value = 0
2229:             ENDIF
2230:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text10", 5)
2231:                 loc_oPg2.txt_4c_Text10.Value = 0
2232:             ENDIF
2233:             *-- Secao Texto Responsabilidade
2234:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text11", 5)
2235:                 loc_oPg2.txt_4c_Text11.Value = 0
2236:             ENDIF
2237:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text12", 5)
2238:                 loc_oPg2.txt_4c_Text12.Value = 0
2239:             ENDIF
2240:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text13", 5)
2241:                 loc_oPg2.txt_4c_Text13.Value = 0
2242:             ENDIF
2243:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text14", 5)
2244:                 loc_oPg2.txt_4c_Text14.Value = 0
2245:             ENDIF
2246:             *-- Secao Sacado (campos numericos linha/coluna)
2247:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text15", 5)
2248:                 loc_oPg2.txt_4c_Text15.Value = 0
2249:             ENDIF
2250:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text16", 5)

*-- Linhas 2291 a 2781:
2291:                 loc_oPg2.txt_4c_Text29.Value = ""
2292:             ENDIF
2293:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
2294:                 loc_oPg2.txt_4c_Text30.Value = ""
2295:             ENDIF
2296:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
2297:                 loc_oPg2.txt_4c_Text31.Value = 0
2298:             ENDIF
2299:             IF PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
2300:                 loc_oPg2.txt_4c_Text40.Value = ""
2301:             ENDIF
2302:         CATCH TO loc_oErro
2303:             MsgErro(loc_oErro.Message, "FormCfb.LimparCampos")
2304:         ENDTRY
2305:     ENDPROC
2306: 
2307:     *--------------------------------------------------------------------------
2308:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2309:     *--------------------------------------------------------------------------
2310:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2311:         LOCAL loc_nI, loc_oObjeto
2312: 
2313:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2314:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2315: 
2316:             IF VARTYPE(loc_oObjeto) = "O"
2317:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2318:                     loc_oObjeto.Visible = .T.
2319:                 ENDIF
2320: 
2321:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2322:                     LOCAL loc_nP
2323:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2324:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2325:                     ENDFOR
2326:                 ENDIF
2327: 
2328:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2329:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2330:                 ENDIF
2331:             ENDIF
2332:         ENDFOR
2333:     ENDPROC
2334: 
2335:     *--------------------------------------------------------------------------
2336:     * FormatarGridLista - Formata visual do grid da lista
2337:     *--------------------------------------------------------------------------
2338:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2339:         WITH par_oGrid
2340:             .FontName = "Verdana"
2341:             .FontSize = 8
2342:         ENDWITH
2343:     ENDPROC
2344: 
2345:     *--------------------------------------------------------------------------
2346:     * Text29LostFocus - Valida impressora ao sair do campo
2347:     * Equivalente ao Valid do SCX legado (SIGCDCFB.pagina.dados.Text29)
2348:     *--------------------------------------------------------------------------
2349:     PROCEDURE Text29LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2350:         LOCAL loc_oPg2, loc_cNome, loc_nQtd, loc_aPrinters, loc_nI, loc_lEncontrado
2351:         LOCAL loc_cImpressora
2352:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2353: 
2354:         TRY
2355:             IF !PEMSTATUS(loc_oPg2, "txt_4c_Text29", 5)
2356:                 RETURN
2357:             ENDIF
2358: 
2359:             loc_cNome = ALLTRIM(loc_oPg2.txt_4c_Text29.Value)
2360: 
2361:             IF EMPTY(loc_cNome)
2362:                 RETURN
2363:             ENDIF
2364: 
2365:             *-- Verificar se impressora informada existe na lista do sistema
2366:             loc_nQtd      = APRINTERS(loc_aPrinters)
2367:             loc_lEncontrado = .F.
2368: 
2369:             IF loc_nQtd > 0
2370:                 FOR loc_nI = 1 TO loc_nQtd
2371:                     IF UPPER(ALLTRIM(loc_aPrinters[loc_nI, 1])) == UPPER(loc_cNome)
2372:                         loc_lEncontrado = .T.
2373:                         EXIT
2374:                     ENDIF
2375:                 ENDFOR
2376:             ENDIF
2377: 
2378:             IF !loc_lEncontrado
2379:                 *-- Impressora invalida: abrir seletor de impressoras
2380:                 loc_cImpressora = GetPrinter()
2381:                 IF !EMPTY(loc_cImpressora)
2382:                     loc_oPg2.txt_4c_Text29.Value = loc_cImpressora
2383:                     THIS.this_oBusinessObject.this_cCNomeImps = loc_cImpressora
2384:                 ENDIF
2385:             ENDIF
2386:         CATCH TO loc_oErro
2387:             MsgErro(loc_oErro.Message, "FormCfb.Text29LostFocus")
2388:         ENDTRY
2389:     ENDPROC
2390: 
2391:     *--------------------------------------------------------------------------
2392:     * Text30LostFocus - Valida fonte ao sair do campo; atualiza tamanho (Text31)
2393:     * Equivalente ao Valid do SCX legado (SIGCDCFB.pagina.dados.Text30)
2394:     *--------------------------------------------------------------------------
2395:     PROCEDURE Text30LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2396:         LOCAL loc_oPg2, loc_cFonte, loc_nI, loc_nQtd, loc_aFontes, loc_lEncontrado
2397:         LOCAL loc_cResultado, loc_nPos1, loc_nPos2, loc_nTam
2398:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2399: 
2400:         TRY
2401:             IF !PEMSTATUS(loc_oPg2, "txt_4c_Text30", 5)
2402:                 RETURN
2403:             ENDIF
2404: 
2405:             loc_cFonte = ALLTRIM(loc_oPg2.txt_4c_Text30.Value)
2406: 
2407:             IF EMPTY(loc_cFonte)
2408:                 RETURN
2409:             ENDIF
2410: 
2411:             *-- Verificar se fonte informada existe na lista do sistema
2412:             loc_nQtd      = AFONT(loc_aFontes)
2413:             loc_lEncontrado = .F.
2414: 
2415:             IF loc_nQtd > 0
2416:                 FOR loc_nI = 1 TO loc_nQtd
2417:                     IF UPPER(ALLTRIM(loc_aFontes[loc_nI])) == UPPER(loc_cFonte)
2418:                         loc_lEncontrado = .T.
2419:                         EXIT
2420:                     ENDIF
2421:                 ENDFOR
2422:             ENDIF
2423: 
2424:             IF !loc_lEncontrado
2425:                 *-- Fonte invalida: abrir seletor de fontes
2426:                 loc_cResultado = GetFont()
2427:                 IF !EMPTY(loc_cResultado)
2428:                     *-- GetFont() retorna "FontName,Size,Style"
2429:                     loc_nPos1 = AT(",", loc_cResultado, 1)
2430:                     loc_nPos2 = AT(",", loc_cResultado, 2)
2431:                     IF loc_nPos1 > 0
2432:                         loc_cFonte = LEFT(loc_cResultado, loc_nPos1 - 1)
2433:                         loc_oPg2.txt_4c_Text30.Value = loc_cFonte
2434:                         THIS.this_oBusinessObject.this_cCFontePdrs = loc_cFonte
2435:                         *-- Atualizar tamanho da fonte em Text31
2436:                         IF loc_nPos2 > loc_nPos1 AND PEMSTATUS(loc_oPg2, "txt_4c_Text31", 5)
2437:                             loc_nTam = VAL(SUBSTR(loc_cResultado, loc_nPos1 + 1, ;
2438:                                 loc_nPos2 - loc_nPos1 - 1))
2439:                             loc_oPg2.txt_4c_Text31.Value = loc_nTam
2440:                             THIS.this_oBusinessObject.this_nNTamFontes = loc_nTam
2441:                         ENDIF
2442:                     ENDIF
2443:                 ENDIF
2444:             ENDIF
2445:         CATCH TO loc_oErro
2446:             MsgErro(loc_oErro.Message, "FormCfb.Text30LostFocus")
2447:         ENDTRY
2448:     ENDPROC
2449: 
2450:     *--------------------------------------------------------------------------
2451:     * Text40LostFocus - Abre seletor de tamanho de papel se campo vazio
2452:     * Equivalente ao Valid do SCX legado (SIGCDCFB.pagina.dados.Text40)
2453:     *--------------------------------------------------------------------------
2454:     PROCEDURE Text40LostFocus(par_nKeyCode, par_nShiftAltCtrl)
2455:         LOCAL loc_oPg2, loc_cTam, loc_cDescricao
2456:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2457: 
2458:         TRY
2459:             IF !PEMSTATUS(loc_oPg2, "txt_4c_Text40", 5)
2460:                 RETURN
2461:             ENDIF
2462: 
2463:             loc_cTam = ALLTRIM(loc_oPg2.txt_4c_Text40.Value)
2464: 
2465:             IF EMPTY(loc_cTam)
2466:                 *-- Campo vazio: abrir seletor de tamanho de papel
2467:                 loc_cTam = GetPaperSize()
2468:                 IF !EMPTY(loc_cTam)
2469:                     *-- GetPaperSize() retorna codigo (10 chars) + descricao
2470:                     loc_cDescricao = SUBSTR(loc_cTam, 11)
2471:                     loc_oPg2.txt_4c_Text40.Value = loc_cDescricao
2472:                     THIS.this_oBusinessObject.this_cCTamFolha = loc_cDescricao
2473:                 ENDIF
2474:             ELSE
2475:                 THIS.this_oBusinessObject.this_cCTamFolha = loc_cTam
2476:             ENDIF
2477:         CATCH TO loc_oErro
2478:             MsgErro(loc_oErro.Message, "FormCfb.Text40LostFocus")
2479:         ENDTRY
2480:     ENDPROC
2481: 
2482:     *--------------------------------------------------------------------------
2483:     * CarregarLista - Carrega grid de condicoes de pagamento com indicador
2484:     * de configuracao (LEFT JOIN SigOpFp + SIGCNFBL via Buscar)
2485:     *--------------------------------------------------------------------------
2486:     PROCEDURE CarregarLista()
2487:         LOCAL loc_lResultado, loc_oGrid
2488:         loc_lResultado = .F.
2489: 
2490:         TRY
2491:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2492:                 loc_lResultado = .T.
2493:             ENDIF
2494: 
2495:             loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2496: 
2497:             IF !THIS.this_oBusinessObject.Buscar("")
2498:                 loc_lResultado = .F.
2499:             ELSE
2500:                 loc_oGrid.ColumnCount = 3
2501:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
2502:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
2503:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
2504:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"
2505: 
2506:                 loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
2507:                 loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2508:                 loc_oGrid.Column3.Header1.Caption = "Configurado"
2509: 
2510:                 THIS.FormatarGridLista(loc_oGrid)
2511:                 loc_lResultado = .T.
2512:             ENDIF
2513:         CATCH TO loc_oErro
2514:             MsgErro(loc_oErro.Message, "FormCfb.CarregarLista")
2515:             loc_lResultado = .F.
2516:         ENDTRY
2517: 
2518:         RETURN loc_lResultado
2519:     ENDPROC
2520: 
2521:     *--------------------------------------------------------------------------
2522:     * AlternarPagina - Alterna entre Page1 (Lista) e Page2 (Dados)
2523:     *--------------------------------------------------------------------------
2524:     PROCEDURE AlternarPagina(par_nPagina)
2525:         LOCAL loc_lResultado
2526:         loc_lResultado = .F.
2527: 
2528:         TRY
2529:             IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
2530:                 loc_lResultado = .F.
2531:             ENDIF
2532: 
2533:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2534: 
2535:             IF par_nPagina = 1
2536:                 THIS.this_cModoAtual = "LISTA"
2537:                 THIS.CarregarLista()
2538:             ENDIF
2539: 
2540:             loc_lResultado = .T.
2541:         CATCH TO loc_oErro
2542:             MsgErro(loc_oErro.Message, "FormCfb.AlternarPagina")
2543:         ENDTRY
2544: 
2545:         RETURN loc_lResultado
2546:     ENDPROC
2547: 
2548:     *--------------------------------------------------------------------------
2549:     * BtnIncluirClick - INSERT proibido neste cadastro (regra de negocio legada)
2550:     * Original: "Nao e Possivel Inserir Dados Atraves Deste Cadastro!!!"
2551:     *--------------------------------------------------------------------------
2552:     PROCEDURE BtnIncluirClick()
2553:         MsgAviso("N" + CHR(227) + "o " + CHR(233) + " Poss" + CHR(237) + "vel Inserir Dados Atrav" + ;
2554:             CHR(233) + "s Deste Cadastro!!!" + CHR(13) + ;
2555:             "Use a Op" + CHR(231) + CHR(227) + "o Alterar ou o Cadastro de Condi" + ;
2556:             CHR(231) + CHR(245) + "es de Pagamento.", ;
2557:             "Opera" + CHR(231) + CHR(227) + "o Bloqueada")
2558:     ENDPROC
2559: 
2560:     *--------------------------------------------------------------------------
2561:     * BtnAlterarClick - Carrega configuracao do boleto para edicao
2562:     * Se nao existir registro em SIGCNFBL, prepara para INSERT
2563:     *--------------------------------------------------------------------------
2564:     PROCEDURE BtnAlterarClick()
2565:         LOCAL loc_cFPags, loc_cDescrs, loc_lTemDados
2566: 
2567:         TRY
2568:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
2569:                 MsgAviso("Selecione uma condi" + CHR(231) + CHR(227) + "o de pagamento.", "")
2570:                 RETURN
2571:             ENDIF
2572: 
2573:             SELECT cursor_4c_Dados
2574:             loc_cFPags   = ALLTRIM(cursor_4c_Dados.FPags)
2575:             loc_cDescrs  = ALLTRIM(cursor_4c_Dados.Descrs)
2576:             loc_lTemDados = !EMPTY(ALLTRIM(NVL(cursor_4c_Dados.TemDados, "")))
2577: 
2578:             IF loc_lTemDados
2579:                 *-- Registro existe -> Atualizar
2580:                 IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFPags)
2581:                     MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
2582:                     RETURN
2583:                 ENDIF
2584:                 THIS.this_oBusinessObject.EditarRegistro()
2585:             ELSE
2586:                 *-- Registro nao existe -> Inserir (neste caso o legado permitia via Alterar)
2587:                 THIS.this_oBusinessObject.NovoRegistro()
2588:                 THIS.this_oBusinessObject.this_cFPags   = loc_cFPags
2589:                 THIS.this_oBusinessObject.this_cDescrs  = loc_cDescrs
2590:             ENDIF
2591: 
2592:             THIS.this_oBusinessObject.this_cDescrs = loc_cDescrs
2593:             THIS.this_cModoAtual = "ALTERAR"
2594:             THIS.BOParaForm()
2595:             THIS.HabilitarCampos(.T.)
2596:             THIS.AjustarBotoesPorModo()
2597:             THIS.pgf_4c_Paginas.ActivePage = 2
2598:         CATCH TO loc_oErro
2599:             MsgErro(loc_oErro.Message, "FormCfb.BtnAlterarClick")
2600:         ENDTRY
2601:     ENDPROC
2602: 
2603:     *--------------------------------------------------------------------------
2604:     * BtnVisualizarClick - Carrega configuracao em modo somente leitura
2605:     *--------------------------------------------------------------------------
2606:     PROCEDURE BtnVisualizarClick()
2607:         LOCAL loc_cFPags, loc_cDescrs, loc_lTemDados
2608: 
2609:         TRY
2610:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
2611:                 MsgAviso("Selecione uma condi" + CHR(231) + CHR(227) + "o de pagamento.", "")
2612:                 RETURN
2613:             ENDIF
2614: 
2615:             SELECT cursor_4c_Dados
2616:             loc_cFPags   = ALLTRIM(cursor_4c_Dados.FPags)
2617:             loc_cDescrs  = ALLTRIM(cursor_4c_Dados.Descrs)
2618:             loc_lTemDados = !EMPTY(ALLTRIM(NVL(cursor_4c_Dados.TemDados, "")))
2619: 
2620:             IF !loc_lTemDados
2621:                 MsgAviso("Esta condi" + CHR(231) + CHR(227) + "o de pagamento ainda n" + ;
2622:                     CHR(227) + "o foi configurada.", "")
2623:                 RETURN
2624:             ENDIF
2625: 
2626:             IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cFPags)
2627:                 MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto.", "Erro")
2628:                 RETURN
2629:             ENDIF
2630: 
2631:             THIS.this_oBusinessObject.this_cDescrs = loc_cDescrs
2632:             THIS.this_cModoAtual = "VISUALIZAR"
2633:             THIS.BOParaForm()
2634:             THIS.HabilitarCampos(.F.)
2635:             THIS.AjustarBotoesPorModo()
2636:             THIS.pgf_4c_Paginas.ActivePage = 2
2637:         CATCH TO loc_oErro
2638:             MsgErro(loc_oErro.Message, "FormCfb.BtnVisualizarClick")
2639:         ENDTRY
2640:     ENDPROC
2641: 
2642:     *--------------------------------------------------------------------------
2643:     * BtnExcluirClick - Remove configuracao de boleto da condicao selecionada
2644:     *--------------------------------------------------------------------------
2645:     PROCEDURE BtnExcluirClick()
2646:         LOCAL loc_cFPags, loc_lTemDados, loc_lConfirma
2647: 
2648:         TRY
2649:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
2650:                 MsgAviso("Selecione uma condi" + CHR(231) + CHR(227) + "o de pagamento.", "")
2651:                 RETURN
2652:             ENDIF
2653: 
2654:             SELECT cursor_4c_Dados
2655:             loc_cFPags   = ALLTRIM(cursor_4c_Dados.FPags)
2656:             loc_lTemDados = !EMPTY(ALLTRIM(NVL(cursor_4c_Dados.TemDados, "")))
2657: 
2658:             IF !loc_lTemDados
2659:                 MsgAviso("Esta condi" + CHR(231) + CHR(227) + "o de pagamento n" + CHR(227) + ;
2660:                     "o possui configura" + CHR(231) + CHR(227) + "o de boleto.", "")
2661:                 RETURN
2662:             ENDIF
2663: 
2664:             loc_lConfirma = MsgConfirma("Confirma a exclus" + CHR(227) + "o da configura" + ;
2665:                 CHR(231) + CHR(227) + "o de boleto para a condi" + CHR(231) + CHR(227) + ;
2666:                 "o [" + loc_cFPags + "]?", "Confirmar Exclus" + CHR(227) + "o")
2667: 
2668:             IF !loc_lConfirma
2669:                 RETURN
2670:             ENDIF
2671: 
2672:             THIS.this_oBusinessObject.this_cFPags = loc_cFPags
2673:             IF THIS.this_oBusinessObject.Excluir()
2674:                 MsgInfo("Configura" + CHR(231) + CHR(227) + "o exclu" + CHR(237) + ;
2675:                     "da com sucesso!")
2676:                 THIS.CarregarLista()
2677:             ENDIF
2678:         CATCH TO loc_oErro
2679:             MsgErro(loc_oErro.Message, "FormCfb.BtnExcluirClick")
2680:         ENDTRY
2681:     ENDPROC
2682: 
2683:     *--------------------------------------------------------------------------
2684:     * BtnBuscarClick - Filtra a lista de condicoes de pagamento
2685:     *--------------------------------------------------------------------------
2686:     PROCEDURE BtnBuscarClick()
2687:         LOCAL loc_cFiltro, loc_oGrid
2688: 
2689:         TRY
2690:             loc_oGrid  = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2691:             loc_cFiltro = ""
2692: 
2693:             IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2694:                 SELECT cursor_4c_Dados
2695:                 loc_cFiltro = ALLTRIM(cursor_4c_Dados.FPags)
2696:             ENDIF
2697: 
2698:             IF !THIS.this_oBusinessObject.Buscar(loc_cFiltro)
2699:                 RETURN
2700:             ENDIF
2701: 
2702:             loc_oGrid.ColumnCount = 3
2703:             loc_oGrid.RecordSource = "cursor_4c_Dados"
2704:             loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.FPags"
2705:             loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Descrs"
2706:             loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.TemDados"
2707: 
2708:             loc_oGrid.Column1.Header1.Caption = "Forma Pgto"
2709:             loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2710:             loc_oGrid.Column3.Header1.Caption = "Configurado"
2711: 
2712:             THIS.FormatarGridLista(loc_oGrid)
2713:         CATCH TO loc_oErro
2714:             MsgErro(loc_oErro.Message, "FormCfb.BtnBuscarClick")
2715:         ENDTRY
2716:     ENDPROC
2717: 
2718:     *--------------------------------------------------------------------------
2719:     * BtnEncerrarClick - Fecha o formulario
2720:     *--------------------------------------------------------------------------
2721:     PROCEDURE BtnEncerrarClick()
2722:         THIS.Release()
2723:     ENDPROC
2724: 
2725:     *--------------------------------------------------------------------------
2726:     * BtnSalvarClick - Salva configuracao de boleto (INSERT ou UPDATE)
2727:     * Equivalente ao botao Confirmar na Page2
2728:     *--------------------------------------------------------------------------
2729:     PROCEDURE BtnSalvarClick()
2730:         LOCAL loc_lResultado
2731: 
2732:         THIS.FormParaBO()
2733: 
2734:         TRY
2735:             loc_lResultado = THIS.this_oBusinessObject.Salvar()
2736:             IF loc_lResultado
2737:                 MsgInfo("Configura" + CHR(231) + CHR(227) + "o salva com sucesso!")
2738:                 THIS.AlternarPagina(1)
2739:             ENDIF
2740:         CATCH TO loc_oErro
2741:             MsgErro(loc_oErro.Message, "FormCfb.BtnSalvarClick")
2742:         ENDTRY
2743:     ENDPROC
2744: 
2745:     *--------------------------------------------------------------------------
2746:     * BtnCancelarClick - Cancela edicao e volta para a lista
2747:     *--------------------------------------------------------------------------
2748:     PROCEDURE BtnCancelarClick()
2749:         THIS.AlternarPagina(1)
2750:     ENDPROC
2751: 
2752:     *--------------------------------------------------------------------------
2753:     * AjustarBotoesPorModo - Ajusta estado dos botoes conforme modo atual
2754:     *--------------------------------------------------------------------------
2755:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2756:         LOCAL loc_oPg2, loc_lAlterar
2757: 
2758:         TRY
2759:             loc_oPg2    = THIS.pgf_4c_Paginas.Page2
2760:             loc_lAlterar = (THIS.this_cModoAtual = "ALTERAR")
2761: 
2762:             IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2763:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lAlterar
2764:                 loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2765:             ENDIF
2766:         CATCH TO loc_oErro
2767:             MsgErro(loc_oErro.Message, "FormCfb.AjustarBotoesPorModo")
2768:         ENDTRY
2769:     ENDPROC
2770: 
2771:     *--------------------------------------------------------------------------
2772:     * Destroy - Libera recursos
2773:     *--------------------------------------------------------------------------
2774:     PROCEDURE Destroy()
2775:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2776:             THIS.this_oBusinessObject = .NULL.
2777:         ENDIF
2778:         DODEFAULT()
2779:     ENDPROC
2780: 
2781: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CfbBO.prg):
*==============================================================================
* CfbBO.prg - Business Object: Configura??o de Boletos Banc?rios
* Tabela: SIGCNFBL
* PK: cidchaves (t?cnica) | Chave de neg?cio: fpags (FK SigOpFp)
*==============================================================================
DEFINE CLASS CfbBO AS BusinessBase

    *--------------------------------------------------------------------------
    * Propriedades - Chaves
    *--------------------------------------------------------------------------
    this_cCidChaves = ""    && cidchaves char(20) - PK t?cnica
    this_cFPags     = ""    && fpags     char(12) - chave de neg?cio (FK SigOpFp)

    *--------------------------------------------------------------------------
    * Propriedades - Audi/Controle
    *--------------------------------------------------------------------------
    this_cCEmps     = ""    && cemps      char(3)
    this_dDDatas    = {}    && ddatas     datetime
    this_cCHoras    = ""    && choras     char(8)
    this_cCUsuarios = ""    && cusuarios  char(20)

    *--------------------------------------------------------------------------
    * Propriedades - Texto livre (sem binding UI, preservado na grava??o)
    *--------------------------------------------------------------------------
    this_cCLocals   = ""    && clocals    char(100) - local de pagamento (texto)
    this_cCTxtCds   = ""    && ctxtcds    text      - texto de resp. do cedente

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Cabe?alho (Local de Pagamento)
    *--------------------------------------------------------------------------
    this_nNlnLocals = 0     && nlnlocals  numeric(5,2) - linha
    this_nNclLocals = 0     && ncllocals  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Vencimento
    *--------------------------------------------------------------------------
    this_nNlnDtVencs = 0    && nlndtvencs numeric(5,2) - linha
    this_nNclDtVencs = 0    && ncldtvencs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Data Documento
    *--------------------------------------------------------------------------
    this_nNlnDtDocs = 0     && nlndtdocs  numeric(5,2) - linha
    this_nNclDtDocs = 0     && ncldtdocs  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o N? do Documento
    *--------------------------------------------------------------------------
    this_nNlnNrDocs = 0     && nlnnrdocs  numeric(5,2) - linha
    this_nNclNrDocs = 0     && nclnrdocs  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Valor do Documento
    *--------------------------------------------------------------------------
    this_nNlnVlDocs = 0     && nlnvldocs  numeric(5,2) - linha
    this_nNclVlDocs = 0     && nclvldocs  numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Texto de Responsabilidade
    *--------------------------------------------------------------------------
    this_nNlnTxtCds = 0     && nlntxtcds  numeric(5,2) - linha
    this_nNclTxtCds = 0     && ncltxtcds  numeric(5,2) - coluna
    this_nNTxtLins  = 0     && ntxtlins   numeric(3,0) - n? de linhas
    this_nNTxtCols  = 0     && ntxtcols   numeric(3,0) - n? de colunas

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Raz?o Social
    *--------------------------------------------------------------------------
    this_nNlnRazClis = 0    && nlnrazclis numeric(5,2) - linha
    this_nNclRazClis = 0    && nclrazclis numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: C.G.C./C.P.F.
    *--------------------------------------------------------------------------
    this_nNlnCgcClis = 0    && nlncgcclis numeric(5,2) - linha
    this_nNclCgcClis = 0    && nclcgcclis numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Endere?o
    *--------------------------------------------------------------------------
    this_nNlnEndCobs = 0    && nlnendcobs numeric(5,2) - linha
    this_nNclEndCobs = 0    && nclendcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Bairro
    *--------------------------------------------------------------------------
    this_nNlnBaiCobs = 0    && nlnbaicobs numeric(5,2) - linha
    this_nNclBaiCobs = 0    && nclbaicobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: Cidade
    *--------------------------------------------------------------------------
    this_nNlnCidCobs = 0    && nlncidcobs numeric(5,2) - linha
    this_nNclCidCobs = 0    && nclcidcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: U.F.
    *--------------------------------------------------------------------------
    this_nNlnEstCobs = 0    && nlnestcobs numeric(5,2) - linha
    this_nNclEstCobs = 0    && nclestcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Posi??o Sacado: C.E.P.
    *--------------------------------------------------------------------------
    this_nNlnCepCobs = 0    && nlncepcobs numeric(5,2) - linha
    this_nNclCepCobs = 0    && nclcepcobs numeric(5,2) - coluna

    *--------------------------------------------------------------------------
    * Propriedades - Impressora / Fonte
    *--------------------------------------------------------------------------
    this_cCNomeImps  = ""   && cnomeimps  char(128) - nome da impressora
    this_cCFontePdrs = ""   && cfontepdrs char(128) - fonte padr?o
    this_nNTamFontes = 0    && ntamfontes numeric(3,0) - tamanho da fonte
    this_cCTamFolha  = ""   && ctamfolha  char(50)  - tamanho da folha

    *--------------------------------------------------------------------------
    * Propriedades auxiliares (display only, n?o persistidas em SIGCNFBL)
    *--------------------------------------------------------------------------
    this_cDescrs = ""       && Descrs de SigOpFp (descri??o da condi??o de pgto)

    *==========================================================================
    PROCEDURE Init()
    *==========================================================================
        DODEFAULT()
        THIS.this_cTabela     = "SIGCNFBL"
        THIS.this_cCampoChave = "cidchaves"
        RETURN .T.
    ENDPROC

    *==========================================================================
    PROCEDURE ObterChavePrimaria()
    *==========================================================================
        RETURN THIS.this_cCidChaves
    ENDPROC

    *==========================================================================
    * Buscar - Lista condi??es de pagamento com indicador de configura??o
    *==========================================================================
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(par_cFiltro))
                loc_cSQL = "SELECT DISTINCT a.FPags, a.Descrs," + ;
                    " b.FPags AS TemDados" + ;
                    " FROM SigOpFp a" + ;
                    " LEFT JOIN SIGCNFBL b ON a.FPags = b.FPags" + ;
                    " ORDER BY a.FPags"
            ELSE
                loc_cSQL = "SELECT DISTINCT a.FPags, a.Descrs," + ;
                    " b.FPags AS TemDados" + ;
                    " FROM SigOpFp a" + ;
                    " LEFT JOIN SIGCNFBL b ON a.FPags = b.FPags" + ;
                    " WHERE a.FPags = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
                    " ORDER BY a.FPags"
            ENDIF

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
            IF loc_nResultado >= 0
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar condi" + CHR(231) + CHR(245) + "es de pagamento:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao buscar condi" + CHR(231) + CHR(245) + "es de pagamento:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarPorCodigo - Carrega configura??o de boleto pelo fpags
    *==========================================================================
    PROCEDURE CarregarPorCodigo(par_cFPags)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "SELECT cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                " ctxtcds, clocals," + ;
                " nlnlocals, ncllocals, nlndtvencs, ncldtvencs," + ;
                " nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs," + ;
                " nlnvldocs, nclvldocs, nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                " nlnrazclis, nclrazclis, nlncgcclis, nclcgcclis," + ;
                " nlnendcobs, nclendcobs, nlnbaicobs, nclbaicobs," + ;
                " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                " nlncepcobs, nclcepcobs," + ;
                " cnomeimps, cfontepdrs, ntamfontes, ctamfolha" + ;
                " FROM SIGCNFBL" + ;
                " WHERE fpags = " + EscaparSQL(ALLTRIM(par_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao carregar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *==========================================================================
    PROTECTED PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCidChaves    = TratarNulo(cidchaves,    "C")
            THIS.this_cFPags        = TratarNulo(fpags,        "C")
            THIS.this_cCEmps        = TratarNulo(cemps,        "C")
            THIS.this_dDDatas       = TratarNulo(ddatas,       "D")
            THIS.this_cCHoras       = TratarNulo(choras,       "C")
            THIS.this_cCUsuarios    = TratarNulo(cusuarios,    "C")
            THIS.this_cCTxtCds      = TratarNulo(ctxtcds,      "C")
            THIS.this_cCLocals      = TratarNulo(clocals,      "C")
            THIS.this_nNlnLocals    = TratarNulo(nlnlocals,    "N")
            THIS.this_nNclLocals    = TratarNulo(ncllocals,    "N")
            THIS.this_nNlnDtVencs   = TratarNulo(nlndtvencs,   "N")
            THIS.this_nNclDtVencs   = TratarNulo(ncldtvencs,   "N")
            THIS.this_nNlnDtDocs    = TratarNulo(nlndtdocs,    "N")
            THIS.this_nNclDtDocs    = TratarNulo(ncldtdocs,    "N")
            THIS.this_nNlnNrDocs    = TratarNulo(nlnnrdocs,    "N")
            THIS.this_nNclNrDocs    = TratarNulo(nclnrdocs,    "N")
            THIS.this_nNlnVlDocs    = TratarNulo(nlnvldocs,    "N")
            THIS.this_nNclVlDocs    = TratarNulo(nclvldocs,    "N")
            THIS.this_nNlnTxtCds    = TratarNulo(nlntxtcds,    "N")
            THIS.this_nNclTxtCds    = TratarNulo(ncltxtcds,    "N")
            THIS.this_nNTxtLins     = TratarNulo(ntxtlins,     "N")
            THIS.this_nNTxtCols     = TratarNulo(ntxtcols,     "N")
            THIS.this_nNlnRazClis   = TratarNulo(nlnrazclis,   "N")
            THIS.this_nNclRazClis   = TratarNulo(nclrazclis,   "N")
            THIS.this_nNlnCgcClis   = TratarNulo(nlncgcclis,   "N")
            THIS.this_nNclCgcClis   = TratarNulo(nclcgcclis,   "N")
            THIS.this_nNlnEndCobs   = TratarNulo(nlnendcobs,   "N")
            THIS.this_nNclEndCobs   = TratarNulo(nclendcobs,   "N")
            THIS.this_nNlnBaiCobs   = TratarNulo(nlnbaicobs,   "N")
            THIS.this_nNclBaiCobs   = TratarNulo(nclbaicobs,   "N")
            THIS.this_nNlnCidCobs   = TratarNulo(nlncidcobs,   "N")
            THIS.this_nNclCidCobs   = TratarNulo(nclcidcobs,   "N")
            THIS.this_nNlnEstCobs   = TratarNulo(nlnestcobs,   "N")
            THIS.this_nNclEstCobs   = TratarNulo(nclestcobs,   "N")
            THIS.this_nNlnCepCobs   = TratarNulo(nlncepcobs,   "N")
            THIS.this_nNclCepCobs   = TratarNulo(nclcepcobs,   "N")
            THIS.this_cCNomeImps    = TratarNulo(cnomeimps,    "C")
            THIS.this_cCFontePdrs   = TratarNulo(cfontepdrs,   "C")
            THIS.this_nNTamFontes   = TratarNulo(ntamfontes,   "N")
            THIS.this_cCTamFolha    = TratarNulo(ctamfolha,    "C")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Inserir - Insere nova configura??o de boleto bancario
    *==========================================================================
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_cVals, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SIGCNFBL" + ;
                " (cidchaves, fpags, cemps, ddatas, choras, cusuarios," + ;
                " ctxtcds, clocals," + ;
                " nlnlocals, ncllocals, nlndtvencs, ncldtvencs," + ;
                " nlndtdocs, ncldtdocs, nlnnrdocs, nclnrdocs," + ;
                " nlnvldocs, nclvldocs, nlntxtcds, ncltxtcds, ntxtlins, ntxtcols," + ;
                " nlnrazclis, nclrazclis, nlncgcclis, nclcgcclis," + ;
                " nlnendcobs, nclendcobs, nlnbaicobs, nclbaicobs," + ;
                " nlncidcobs, nclcidcobs, nlnestcobs, nclestcobs," + ;
                " nlncepcobs, nclcepcobs," + ;
                " cnomeimps, cfontepdrs, ntamfontes, ctamfolha)"

            loc_cVals = " VALUES (LEFT(NEWID(), 20)," + ;
                " " + EscaparSQL(ALLTRIM(THIS.this_cFPags)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)) + "," + ;
                " GETDATE()," + ;
                " " + EscaparSQL(LEFT(TIME(), 8)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)) + "," + ;
                " " + EscaparSQL(ALLTRIM(THIS.this_cCTxtCds)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCLocals), 100)) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnLocals) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclLocals) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnDtVencs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclDtVencs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnDtDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclDtDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnNrDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclNrDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnVlDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclVlDocs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnTxtCds) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclTxtCds) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNTxtLins) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNTxtCols) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnRazClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclRazClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnCgcClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclCgcClis) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnEndCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclEndCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclBaiCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnCidCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclCidCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnEstCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclEstCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNlnCepCobs) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNclCepCobs) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCNomeImps), 128)) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCFontePdrs), 128)) + "," + ;
                " " + FormatarNumeroSQL(THIS.this_nNTamFontes) + "," + ;
                " " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCTamFolha), 50)) + ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL + loc_cVals, "cursor_4c_Ins")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao inserir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Ins")
                USE IN cursor_4c_Ins
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * Atualizar - Atualiza configura??o de boleto bancario existente
    *==========================================================================
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SIGCNFBL SET" + ;
                " cemps = " + EscaparSQL(LEFT(ALLTRIM(go_4c_Sistema.cCodEmpresa), 3)) + "," + ;
                " ddatas = GETDATE()," + ;
                " choras = " + EscaparSQL(LEFT(TIME(), 8)) + "," + ;
                " cusuarios = " + EscaparSQL(LEFT(ALLTRIM(gc_4c_UsuarioLogado), 20)) + "," + ;
                " ctxtcds = " + EscaparSQL(ALLTRIM(THIS.this_cCTxtCds)) + "," + ;
                " clocals = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCLocals), 100)) + "," + ;
                " nlnlocals = " + FormatarNumeroSQL(THIS.this_nNlnLocals) + "," + ;
                " ncllocals = " + FormatarNumeroSQL(THIS.this_nNclLocals) + "," + ;
                " nlndtvencs = " + FormatarNumeroSQL(THIS.this_nNlnDtVencs) + "," + ;
                " ncldtvencs = " + FormatarNumeroSQL(THIS.this_nNclDtVencs) + "," + ;
                " nlndtdocs = " + FormatarNumeroSQL(THIS.this_nNlnDtDocs) + "," + ;
                " ncldtdocs = " + FormatarNumeroSQL(THIS.this_nNclDtDocs) + "," + ;
                " nlnnrdocs = " + FormatarNumeroSQL(THIS.this_nNlnNrDocs) + "," + ;
                " nclnrdocs = " + FormatarNumeroSQL(THIS.this_nNclNrDocs) + "," + ;
                " nlnvldocs = " + FormatarNumeroSQL(THIS.this_nNlnVlDocs) + "," + ;
                " nclvldocs = " + FormatarNumeroSQL(THIS.this_nNclVlDocs) + "," + ;
                " nlntxtcds = " + FormatarNumeroSQL(THIS.this_nNlnTxtCds) + "," + ;
                " ncltxtcds = " + FormatarNumeroSQL(THIS.this_nNclTxtCds) + "," + ;
                " ntxtlins = " + FormatarNumeroSQL(THIS.this_nNTxtLins) + "," + ;
                " ntxtcols = " + FormatarNumeroSQL(THIS.this_nNTxtCols) + "," + ;
                " nlnrazclis = " + FormatarNumeroSQL(THIS.this_nNlnRazClis) + "," + ;
                " nclrazclis = " + FormatarNumeroSQL(THIS.this_nNclRazClis) + "," + ;
                " nlncgcclis = " + FormatarNumeroSQL(THIS.this_nNlnCgcClis) + "," + ;
                " nclcgcclis = " + FormatarNumeroSQL(THIS.this_nNclCgcClis) + "," + ;
                " nlnendcobs = " + FormatarNumeroSQL(THIS.this_nNlnEndCobs) + "," + ;
                " nclendcobs = " + FormatarNumeroSQL(THIS.this_nNclEndCobs) + "," + ;
                " nlnbaicobs = " + FormatarNumeroSQL(THIS.this_nNlnBaiCobs) + "," + ;
                " nclbaicobs = " + FormatarNumeroSQL(THIS.this_nNclBaiCobs) + "," + ;
                " nlncidcobs = " + FormatarNumeroSQL(THIS.this_nNlnCidCobs) + "," + ;
                " nclcidcobs = " + FormatarNumeroSQL(THIS.this_nNclCidCobs) + "," + ;
                " nlnestcobs = " + FormatarNumeroSQL(THIS.this_nNlnEstCobs) + "," + ;
                " nclestcobs = " + FormatarNumeroSQL(THIS.this_nNclEstCobs) + "," + ;
                " nlncepcobs = " + FormatarNumeroSQL(THIS.this_nNlnCepCobs) + "," + ;
                " nclcepcobs = " + FormatarNumeroSQL(THIS.this_nNclCepCobs) + "," + ;
                " cnomeimps = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCNomeImps), 128)) + "," + ;
                " cfontepdrs = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCFontePdrs), 128)) + "," + ;
                " ntamfontes = " + FormatarNumeroSQL(THIS.this_nNTamFontes) + "," + ;
                " ctamfolha = " + EscaparSQL(LEFT(ALLTRIM(THIS.this_cCTamFolha), 50)) + ;
                " WHERE fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Upd")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao atualizar configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Upd")
                USE IN cursor_4c_Upd
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *==========================================================================
    * ExecutarExclusao - Exclui configura??o de boleto bancario
    *==========================================================================
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SIGCNFBL WHERE fpags = " + EscaparSQL(ALLTRIM(THIS.this_cFPags))

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Del")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                    CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro ao excluir configura" + CHR(231) + CHR(227) + "o de boleto:" + ;
                CHR(13) + loc_oErro.Message, "Erro")
            IF USED("cursor_4c_Del")
                USE IN cursor_4c_Del
            ENDIF
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

