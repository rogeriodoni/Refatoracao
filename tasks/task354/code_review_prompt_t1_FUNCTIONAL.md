# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (6)
- [BINDEVENT-PARAMS] Handler 'ValidarAcomis' para evento 'KeyPress' nao declara parametros. VFP passa parametros obrigatorios e gera 'No PARAMETER statement is found'. Adicionar: PROCEDURE ValidarAcomis(par_nKeyCode, par_nShiftAltCtrl)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_Dados' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Cargo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Valor, Moeda, Categoria, Descrição, Validar. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Tipo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Valor, Moeda, Categoria, Descrição, Validar. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Cargo' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Grupo, Conta, Valor, Moeda, Categoria, Descrição, Validar. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'inserir' (parent: SIGCDCAR.Pagina.Dados): Left original=380 vs migrado 'cmd_4c_InserirCat' Left=823 (diff=443px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCargo.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (3300 linhas total):

*-- Linhas 29 a 152:
29:     this_cModoAtual      = "LISTA"
30: 
31:     *--------------------------------------------------------------------------
32:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
33:     *--------------------------------------------------------------------------
34:     PROCEDURE Init()
35:         LOCAL loc_lResultado
36:         loc_lResultado = .F.
37: 
38:         TRY
39:             loc_lResultado = DODEFAULT()
40:         CATCH TO loc_oErro
41:             MsgErro(loc_oErro.Message, "FormCargo.Init")
42:         ENDTRY
43: 
44:         RETURN loc_lResultado
45:     ENDPROC
46: 
47:     *--------------------------------------------------------------------------
48:     * InicializarForm - Configura estrutura completa
49:     *--------------------------------------------------------------------------
50:     PROTECTED PROCEDURE InicializarForm()
51:         LOCAL loc_lResultado
52:         loc_lResultado = .F.
53: 
54:         TRY
55:             THIS.this_oBusinessObject = CREATEOBJECT("CargoBO")
56: 
57:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
58:                 MsgErro("Falha ao criar CargoBO", "Erro")
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
69:                 THIS.pgf_4c_Paginas.Visible = .T.
70:                 THIS.pgf_4c_Paginas.ActivePage = 1
71:                 THIS.this_cModoAtual = "LISTA"
72:                 loc_lResultado = .T.
73:             ENDIF
74:         CATCH TO loc_oErro
75:             MsgErro(loc_oErro.Message, "FormCargo.InicializarForm")
76:         ENDTRY
77: 
78:         RETURN loc_lResultado
79:     ENDPROC
80: 
81:     *--------------------------------------------------------------------------
82:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
83:     *--------------------------------------------------------------------------
84:     PROTECTED PROCEDURE ConfigurarPageFrame()
85:         LOCAL loc_oPgf
86:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
87:         loc_oPgf = THIS.pgf_4c_Paginas
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
106:         THIS.ConfigurarPaginaDados()
107:     ENDPROC
108: 
109:     *--------------------------------------------------------------------------
110:     * ConfigurarPaginaLista - Page1: cabecalho, botoes CRUD, grid lista
111:     *--------------------------------------------------------------------------
112:     PROTECTED PROCEDURE ConfigurarPaginaLista()
113:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida
114:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
115: 
116:         *-- Cabecalho cinza
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

*-- Linhas 287 a 413:
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
320:             .FontName        = "Tahoma"
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
334:         *-- Grid lista: ccargs (Cargo) + dcargs (Descricao)
335:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
336:         loc_oPg1.grd_4c_Lista.RecordSource = ""
337:         loc_oPg1.grd_4c_Lista.ColumnCount  = 2
338: 
339:         WITH loc_oPg1.grd_4c_Lista
340:             .Top                     = 117
341:             .Left                    = 12
342:             .Width                   = 890
343:             .Height                  = 480
344:             .FontName                = "Verdana"
345:             .FontSize                = 8
346:             .ForeColor               = RGB(90, 90, 90)
347:             .BackColor               = RGB(255, 255, 255)
348:             .GridLineColor           = RGB(238, 238, 238)
349:             .HighlightBackColor      = RGB(255, 255, 255)
350:             .HighlightForeColor      = RGB(15, 41, 104)
351:             .HighlightStyle          = 2
352:             .DeleteMark              = .F.
353:             .RecordMark              = .F.
354:             .RowHeight               = 16
355:             .ScrollBars              = 2
356:             .GridLines               = 3
357:             .ReadOnly                = .T.
358:             .Visible                 = .T.
359:             .Column1.Width           = 100
360:             .Column2.Width           = 760
361:             .Column1.ReadOnly        = .T.
362:             .Column2.ReadOnly        = .T.
363:             .Column1.Header1.Caption = "Cargo"
364:             .Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
365:         ENDWITH
366: 
367:         THIS.TornarControlesVisiveis(loc_oPg1)
368:     ENDPROC
369: 
370:     *--------------------------------------------------------------------------
371:     * ConfigurarPaginaDados - Page2: todos os campos, grids e botoes
372:     *--------------------------------------------------------------------------
373:     PROTECTED PROCEDURE ConfigurarPaginaDados()
374:         LOCAL loc_oPg2, loc_oBotoesAcao, loc_oGridAcesso, loc_oGridCat
375:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
376: 
377:         *-- Botoes Confirmar/Cancelar
378:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
379:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
380:         WITH loc_oBotoesAcao
381:             .Top         = 33
382:             .Left        = 842
383:             .Width       = 160
384:             .Height      = 85
385:             .BackStyle   = 0
386:             .BorderWidth = 0
387:             .Visible     = .T.
388:         ENDWITH
389: 
390:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
391:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
392:             .Caption         = "Confirmar"
393:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
394:             .PicturePosition = 13
395:             .Top             = 5
396:             .Left            = 5
397:             .Width           = 75
398:             .Height          = 75
399:             .BackColor       = RGB(255, 255, 255)
400:             .ForeColor       = RGB(90, 90, 90)
401:             .FontName        = "Tahoma"
402:             .FontSize        = 8
403:             .FontBold        = .T.
404:             .FontItalic      = .T.
405:             .Themes          = .F.
406:             .SpecialEffect   = 0
407:             .MousePointer    = 15
408:             .WordWrap        = .T.
409:             .AutoSize        = .F.
410:             .Visible         = .T.
411:         ENDWITH
412: 
413:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 433 a 477:
433:             .Visible         = .T.
434:         ENDWITH
435: 
436:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
437:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
438: 
439:         *======================================================================
440:         * LINHA 1: Cargo + Senha
441:         *======================================================================
442:         loc_oPg2.AddObject("lbl_4c_LbCargo", "Label")
443:         WITH loc_oPg2.lbl_4c_LbCargo
444:             .Caption   = "Cargo :"
445:             .Top       = 51
446:             .Left      = 212
447:             .Width     = 38
448:             .Height    = 17
449:             .AutoSize  = .F.
450:             .FontName  = "Tahoma"
451:             .FontSize  = 8
452:             .ForeColor = RGB(90, 90, 90)
453:             .BackStyle = 0
454:             .Alignment = 1
455:             .Visible   = .T.
456:         ENDWITH
457: 
458:         loc_oPg2.AddObject("txt_4c_Ccargs", "TextBox")
459:         WITH loc_oPg2.txt_4c_Ccargs
460:             .Value         = ""
461:             .Top           = 47
462:             .Left          = 252
463:             .Width         = 80
464:             .Height        = 21
465:             .FontName      = "Tahoma"
466:             .FontSize      = 8
467:             .ForeColor     = RGB(90, 90, 90)
468:             .BackColor     = RGB(255, 255, 255)
469:             .BorderStyle   = 1
470:             .SpecialEffect = 0
471:             .MaxLength     = 10
472:             .Visible       = .T.
473:         ENDWITH
474: 
475:         *-- Botao busca template (cmdGarqicone: abre picker p/ copiar cargo base)
476:         loc_oPg2.AddObject("cmd_4c_BuscarBase", "CommandButton")
477:         WITH loc_oPg2.cmd_4c_BuscarBase

*-- Linhas 490 a 533:
490:             .Visible         = .T.
491:         ENDWITH
492: 
493:         BINDEVENT(loc_oPg2.cmd_4c_BuscarBase, "Click", THIS, "BtnBuscarBaseClick")
494: 
495:         loc_oPg2.AddObject("lbl_4c_LbSenha", "Label")
496:         WITH loc_oPg2.lbl_4c_LbSenha
497:             .Caption   = "Senha :"
498:             .Top       = 50
499:             .Left      = 578
500:             .Width     = 40
501:             .Height    = 17
502:             .AutoSize  = .F.
503:             .FontName  = "Tahoma"
504:             .FontSize  = 8
505:             .ForeColor = RGB(90, 90, 90)
506:             .BackStyle = 0
507:             .Alignment = 1
508:             .Visible   = .T.
509:         ENDWITH
510: 
511:         loc_oPg2.AddObject("txt_4c_Nivels", "TextBox")
512:         WITH loc_oPg2.txt_4c_Nivels
513:             .Value         = ""
514:             .Top           = 46
515:             .Left          = 619
516:             .Width         = 20
517:             .Height        = 21
518:             .FontName      = "Tahoma"
519:             .FontSize      = 8
520:             .ForeColor     = RGB(90, 90, 90)
521:             .BackColor     = RGB(255, 255, 255)
522:             .BorderStyle   = 1
523:             .SpecialEffect = 0
524:             .MaxLength     = 1
525:             .Visible       = .T.
526:         ENDWITH
527: 
528:         loc_oPg2.AddObject("lbl_4c_LbSenhaSN", "Label")
529:         WITH loc_oPg2.lbl_4c_LbSenhaSN
530:             .Caption   = "(S/N)"
531:             .Top       = 50
532:             .Left      = 642
533:             .Width     = 35

*-- Linhas 1296 a 1339:
1296:             .Visible       = .T.
1297:         ENDWITH
1298: 
1299:         BINDEVENT(loc_oPg2.txt_4c_Grcomis, "KeyPress", THIS, "BuscarGrupoFinan")
1300: 
1301:         loc_oPg2.AddObject("lbl_4c_LbLibExprd", "Label")
1302:         WITH loc_oPg2.lbl_4c_LbLibExprd
1303:             .Caption   = "Libera Excluir Movimenta" + CHR(231) + CHR(227) + "o de Produ" + CHR(231) + CHR(227) + "o :"
1304:             .Top       = 250
1305:             .Left      = 410
1306:             .Width     = 208
1307:             .Height    = 17
1308:             .AutoSize  = .F.
1309:             .FontName  = "Tahoma"
1310:             .FontSize  = 8
1311:             .ForeColor = RGB(90, 90, 90)
1312:             .BackStyle = 0
1313:             .Alignment = 1
1314:             .Visible   = .T.
1315:         ENDWITH
1316: 
1317:         loc_oPg2.AddObject("txt_4c_Libexprd", "TextBox")
1318:         WITH loc_oPg2.txt_4c_Libexprd
1319:             .Value         = ""
1320:             .Top           = 246
1321:             .Left          = 619
1322:             .Width         = 20
1323:             .Height        = 21
1324:             .FontName      = "Tahoma"
1325:             .FontSize      = 8
1326:             .ForeColor     = RGB(90, 90, 90)
1327:             .BackColor     = RGB(255, 255, 255)
1328:             .BorderStyle   = 1
1329:             .SpecialEffect = 0
1330:             .MaxLength     = 1
1331:             .Visible       = .T.
1332:         ENDWITH
1333: 
1334:         loc_oPg2.AddObject("lbl_4c_LbLibExprdSN", "Label")
1335:         WITH loc_oPg2.lbl_4c_LbLibExprdSN
1336:             .Caption   = "(S/N)"
1337:             .Top       = 250
1338:             .Left      = 642
1339:             .Width     = 35

*-- Linhas 1415 a 1496:
1415:             .Visible       = .T.
1416:         ENDWITH
1417: 
1418:         BINDEVENT(loc_oPg2.txt_4c_Acomis, "KeyPress", THIS, "ValidarAcomis")
1419: 
1420:         loc_oPg2.AddObject("lbl_4c_LbAcomisPct", "Label")
1421:         WITH loc_oPg2.lbl_4c_LbAcomisPct
1422:             .Caption   = "(%)"
1423:             .Top       = 275
1424:             .Left      = 737
1425:             .Width     = 25
1426:             .Height    = 17
1427:             .AutoSize  = .F.
1428:             .FontName  = "Tahoma"
1429:             .FontSize  = 8
1430:             .ForeColor = RGB(90, 90, 90)
1431:             .BackStyle = 0
1432:             .Visible   = .T.
1433:         ENDWITH
1434: 
1435:         *======================================================================
1436:         * OPTION GROUPS - Esquerda (2 botoes: Sim/Nao)
1437:         *======================================================================
1438: 
1439:         *-- Libera Produtos Bloqueados (libleilaos)
1440:         loc_oPg2.AddObject("lbl_4c_LbLibleilaos", "Label")
1441:         WITH loc_oPg2.lbl_4c_LbLibleilaos
1442:             .Caption   = "Libera Produtos Bloqueados :"
1443:             .Top       = 276
1444:             .Left      = 108
1445:             .Width     = 138
1446:             .Height    = 17
1447:             .AutoSize  = .F.
1448:             .FontName  = "Tahoma"
1449:             .FontSize  = 8
1450:             .ForeColor = RGB(90, 90, 90)
1451:             .BackStyle = 0
1452:             .Alignment = 1
1453:             .Visible   = .T.
1454:         ENDWITH
1455: 
1456:         loc_oPg2.AddObject("opt_4c_Libleilaos", "OptionGroup")
1457:         WITH loc_oPg2.opt_4c_Libleilaos
1458:             .ButtonCount = 2
1459:             .Top         = 272
1460:             .Left        = 247
1461:             .Width       = 89
1462:             .Height      = 22
1463:             .AutoSize    = .F.
1464:             .BackStyle   = 0
1465:             .BorderStyle = 0
1466:             .Value       = 2
1467:             .Visible     = .T.
1468:             WITH .Buttons(1)
1469:                 .Caption   = "\<Sim"
1470:                 .Left      = 2
1471:                 .Top       = 3
1472:                 .Width     = 40
1473:                 .Height    = 17
1474:                 .AutoSize  = .F.
1475:                 .BackStyle = 0
1476:                 .ForeColor = RGB(90, 90, 90)
1477:             ENDWITH
1478:             WITH .Buttons(2)
1479:                 .Caption   = "\<N" + CHR(227) + "o"
1480:                 .Left      = 46
1481:                 .Top       = 3
1482:                 .Width     = 40
1483:                 .Height    = 17
1484:                 .AutoSize  = .F.
1485:                 .BackStyle = 0
1486:                 .ForeColor = RGB(90, 90, 90)
1487:             ENDWITH
1488:         ENDWITH
1489: 
1490:         *-- Libera Duplicidade (libdupends)
1491:         loc_oPg2.AddObject("lbl_4c_LbLibdupends", "Label")
1492:         WITH loc_oPg2.lbl_4c_LbLibdupends
1493:             .Caption   = "Libera Duplicidade :"
1494:             .Top       = 296
1495:             .Left      = 155
1496:             .Width     = 91

*-- Linhas 1504 a 1547:
1504:             .Visible   = .T.
1505:         ENDWITH
1506: 
1507:         loc_oPg2.AddObject("opt_4c_Libdupends", "OptionGroup")
1508:         WITH loc_oPg2.opt_4c_Libdupends
1509:             .ButtonCount = 2
1510:             .Top         = 292
1511:             .Left        = 247
1512:             .Width       = 89
1513:             .Height      = 22
1514:             .AutoSize    = .F.
1515:             .BackStyle   = 0
1516:             .BorderStyle = 0
1517:             .Value       = 2
1518:             .Visible     = .T.
1519:             WITH .Buttons(1)
1520:                 .Caption   = "\<Sim"
1521:                 .Left      = 2
1522:                 .Top       = 3
1523:                 .Width     = 40
1524:                 .Height    = 17
1525:                 .AutoSize  = .F.
1526:                 .BackStyle = 0
1527:                 .ForeColor = RGB(90, 90, 90)
1528:             ENDWITH
1529:             WITH .Buttons(2)
1530:                 .Caption   = "\<N" + CHR(227) + "o"
1531:                 .Left      = 46
1532:                 .Top       = 3
1533:                 .Width     = 40
1534:                 .Height    = 17
1535:                 .AutoSize  = .F.
1536:                 .BackStyle = 0
1537:                 .ForeColor = RGB(90, 90, 90)
1538:             ENDWITH
1539:         ENDWITH
1540: 
1541:         *======================================================================
1542:         * LINHA 11: Comissao + Tipo Comissao (direita)
1543:         *======================================================================
1544:         loc_oPg2.AddObject("lbl_4c_LbComis", "Label")
1545:         WITH loc_oPg2.lbl_4c_LbComis
1546:             .Caption   = "Comiss" + CHR(227) + "o :"
1547:             .Top       = 299

*-- Linhas 1606 a 1649:
1606:         ENDWITH
1607: 
1608:         *-- Tipo Comissao (3 botoes: Venda, Caixa, O.S.)
1609:         loc_oPg2.AddObject("opt_4c_Tpcomis", "OptionGroup")
1610:         WITH loc_oPg2.opt_4c_Tpcomis
1611:             .ButtonCount = 3
1612:             .Top         = 292
1613:             .Left        = 749
1614:             .Width       = 141
1615:             .Height      = 21
1616:             .AutoSize    = .F.
1617:             .BackStyle   = 0
1618:             .BorderStyle = 0
1619:             .Value       = 1
1620:             .Visible     = .T.
1621:             WITH .Buttons(1)
1622:                 .Caption   = "Venda"
1623:                 .Left      = 2
1624:                 .Top       = 2
1625:                 .Width     = 44
1626:                 .Height    = 17
1627:                 .AutoSize  = .F.
1628:                 .BackStyle = 0
1629:                 .ForeColor = RGB(90, 90, 90)
1630:             ENDWITH
1631:             WITH .Buttons(2)
1632:                 .Caption   = "Caixa"
1633:                 .Left      = 48
1634:                 .Top       = 2
1635:                 .Width     = 44
1636:                 .Height    = 17
1637:                 .AutoSize  = .F.
1638:                 .BackStyle = 0
1639:                 .ForeColor = RGB(90, 90, 90)
1640:             ENDWITH
1641:             WITH .Buttons(3)
1642:                 .Caption   = "O.S."
1643:                 .Left      = 94
1644:                 .Top       = 2
1645:                 .Width     = 44
1646:                 .Height    = 17
1647:                 .AutoSize  = .F.
1648:                 .BackStyle = 0
1649:                 .ForeColor = RGB(90, 90, 90)

*-- Linhas 1667 a 1710:
1667:             .Visible   = .T.
1668:         ENDWITH
1669: 
1670:         loc_oPg2.AddObject("opt_4c_Custoprod", "OptionGroup")
1671:         WITH loc_oPg2.opt_4c_Custoprod
1672:             .ButtonCount = 2
1673:             .Top         = 313
1674:             .Left        = 247
1675:             .Width       = 89
1676:             .Height      = 22
1677:             .AutoSize    = .F.
1678:             .BackStyle   = 0
1679:             .BorderStyle = 0
1680:             .Value       = 2
1681:             .Visible     = .T.
1682:             WITH .Buttons(1)
1683:                 .Caption   = "\<Sim"
1684:                 .Left      = 2
1685:                 .Top       = 3
1686:                 .Width     = 40
1687:                 .Height    = 17
1688:                 .AutoSize  = .F.
1689:                 .BackStyle = 0
1690:                 .ForeColor = RGB(90, 90, 90)
1691:             ENDWITH
1692:             WITH .Buttons(2)
1693:                 .Caption   = "\<N" + CHR(227) + "o"
1694:                 .Left      = 46
1695:                 .Top       = 3
1696:                 .Width     = 40
1697:                 .Height    = 17
1698:                 .AutoSize  = .F.
1699:                 .BackStyle = 0
1700:                 .ForeColor = RGB(90, 90, 90)
1701:             ENDWITH
1702:         ENDWITH
1703: 
1704:         *-- Variacao Mov Dupla (varmovdup)
1705:         loc_oPg2.AddObject("lbl_4c_LbVarMovDup", "Label")
1706:         WITH loc_oPg2.lbl_4c_LbVarMovDup
1707:             .Caption   = "Varia" + CHR(231) + CHR(227) + "o Mov. Dupla :"
1708:             .Top       = 326
1709:             .Left      = 510
1710:             .Width     = 108

*-- Linhas 1768 a 1811:
1768:             .Visible   = .T.
1769:         ENDWITH
1770: 
1771:         loc_oPg2.AddObject("opt_4c_LibValmmax", "OptionGroup")
1772:         WITH loc_oPg2.opt_4c_LibValmmax
1773:             .ButtonCount = 2
1774:             .Top         = 334
1775:             .Left        = 247
1776:             .Width       = 89
1777:             .Height      = 22
1778:             .AutoSize    = .F.
1779:             .BackStyle   = 0
1780:             .BorderStyle = 0
1781:             .Value       = 2
1782:             .Visible     = .T.
1783:             WITH .Buttons(1)
1784:                 .Caption   = "\<Sim"
1785:                 .Left      = 2
1786:                 .Top       = 3
1787:                 .Width     = 40
1788:                 .Height    = 17
1789:                 .AutoSize  = .F.
1790:                 .BackStyle = 0
1791:                 .ForeColor = RGB(90, 90, 90)
1792:             ENDWITH
1793:             WITH .Buttons(2)
1794:                 .Caption   = "\<N" + CHR(227) + "o"
1795:                 .Left      = 46
1796:                 .Top       = 3
1797:                 .Width     = 40
1798:                 .Height    = 17
1799:                 .AutoSize  = .F.
1800:                 .BackStyle = 0
1801:                 .ForeColor = RGB(90, 90, 90)
1802:             ENDWITH
1803:         ENDWITH
1804: 
1805:         *-- Liberar Variacao Mov Dupla (libvmovdup)
1806:         loc_oPg2.AddObject("lbl_4c_LbLibVMovDup", "Label")
1807:         WITH loc_oPg2.lbl_4c_LbLibVMovDup
1808:             .Caption   = "Liberar Varia" + CHR(231) + CHR(227) + "o Mov. Dupla :"
1809:             .Top       = 350
1810:             .Left      = 474
1811:             .Width     = 144

*-- Linhas 1868 a 1911:
1868:             .Visible   = .T.
1869:         ENDWITH
1870: 
1871:         loc_oPg2.AddObject("opt_4c_Libduptits", "OptionGroup")
1872:         WITH loc_oPg2.opt_4c_Libduptits
1873:             .ButtonCount = 2
1874:             .Top         = 352
1875:             .Left        = 247
1876:             .Width       = 89
1877:             .Height      = 22
1878:             .AutoSize    = .F.
1879:             .BackStyle   = 0
1880:             .BorderStyle = 0
1881:             .Value       = 2
1882:             .Visible     = .T.
1883:             WITH .Buttons(1)
1884:                 .Caption   = "\<Sim"
1885:                 .Left      = 2
1886:                 .Top       = 3
1887:                 .Width     = 40
1888:                 .Height    = 17
1889:                 .AutoSize  = .F.
1890:                 .BackStyle = 0
1891:                 .ForeColor = RGB(90, 90, 90)
1892:             ENDWITH
1893:             WITH .Buttons(2)
1894:                 .Caption   = "\<N" + CHR(227) + "o"
1895:                 .Left      = 46
1896:                 .Top       = 3
1897:                 .Width     = 40
1898:                 .Height    = 17
1899:                 .AutoSize  = .F.
1900:                 .BackStyle = 0
1901:                 .ForeColor = RGB(90, 90, 90)
1902:             ENDWITH
1903:         ENDWITH
1904: 
1905:         *-- Libera Prazo de Entrega (libprzes)
1906:         loc_oPg2.AddObject("lbl_4c_LbLibprzes", "Label")
1907:         WITH loc_oPg2.lbl_4c_LbLibprzes
1908:             .Caption   = "Libera Prazo de Entrega :"
1909:             .Top       = 377
1910:             .Left      = 126
1911:             .Width     = 120

*-- Linhas 1919 a 1962:
1919:             .Visible   = .T.
1920:         ENDWITH
1921: 
1922:         loc_oPg2.AddObject("opt_4c_Libprzes", "OptionGroup")
1923:         WITH loc_oPg2.opt_4c_Libprzes
1924:             .ButtonCount = 2
1925:             .Top         = 373
1926:             .Left        = 247
1927:             .Width       = 89
1928:             .Height      = 22
1929:             .AutoSize    = .F.
1930:             .BackStyle   = 0
1931:             .BorderStyle = 0
1932:             .Value       = 2
1933:             .Visible     = .T.
1934:             WITH .Buttons(1)
1935:                 .Caption   = "\<Sim"
1936:                 .Left      = 2
1937:                 .Top       = 3
1938:                 .Width     = 40
1939:                 .Height    = 17
1940:                 .AutoSize  = .F.
1941:                 .BackStyle = 0
1942:                 .ForeColor = RGB(90, 90, 90)
1943:             ENDWITH
1944:             WITH .Buttons(2)
1945:                 .Caption   = "\<N" + CHR(227) + "o"
1946:                 .Left      = 46
1947:                 .Top       = 3
1948:                 .Width     = 40
1949:                 .Height    = 17
1950:                 .AutoSize  = .F.
1951:                 .BackStyle = 0
1952:                 .ForeColor = RGB(90, 90, 90)
1953:             ENDWITH
1954:         ENDWITH
1955: 
1956:         *-- Libera Consulta de Todos Subniveis (ConsSubn)
1957:         loc_oPg2.AddObject("lbl_4c_LbConsSubn", "Label")
1958:         WITH loc_oPg2.lbl_4c_LbConsSubn
1959:             .Caption   = "Libera Consulta de Todos Subniveis :"
1960:             .Top       = 375
1961:             .Left      = 439
1962:             .Width     = 179

*-- Linhas 2056 a 2149:
2056:             .Column4.Header1.Caption = "Moeda"
2057:         ENDWITH
2058: 
2059:         BINDEVENT(loc_oGridAcesso.Column1.Text1, "KeyPress", THIS, "ValidarGrupoGrade")
2060:         BINDEVENT(loc_oGridAcesso.Column2.Text1, "KeyPress", THIS, "ValidarContaGrade")
2061:         BINDEVENT(loc_oGridAcesso.Column4.Text1, "KeyPress", THIS, "ValidarMoedaGrade")
2062: 
2063:         *-- Botoes Inserir/Excluir linhas da grade de acesso
2064:         loc_oPg2.AddObject("cmd_4c_InserirAcesso", "CommandButton")
2065:         WITH loc_oPg2.cmd_4c_InserirAcesso
2066:             .Caption         = "Inserir"
2067:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2068:             .PicturePosition = 13
2069:             .Top             = 482
2070:             .Left            = 380
2071:             .Width           = 45
2072:             .Height          = 45
2073:             .BackColor       = RGB(255, 255, 255)
2074:             .ForeColor       = RGB(90, 90, 90)
2075:             .FontName        = "Tahoma"
2076:             .FontSize        = 7
2077:             .FontBold        = .T.
2078:             .Themes          = .F.
2079:             .SpecialEffect   = 0
2080:             .MousePointer    = 15
2081:             .WordWrap        = .T.
2082:             .AutoSize        = .F.
2083:             .Visible         = .T.
2084:         ENDWITH
2085: 
2086:         loc_oPg2.AddObject("cmd_4c_ExcluirAcesso", "CommandButton")
2087:         WITH loc_oPg2.cmd_4c_ExcluirAcesso
2088:             .Caption         = "Excluir"
2089:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2090:             .PicturePosition = 13
2091:             .Top             = 527
2092:             .Left            = 380
2093:             .Width           = 45
2094:             .Height          = 45
2095:             .BackColor       = RGB(255, 255, 255)
2096:             .ForeColor       = RGB(90, 90, 90)
2097:             .FontName        = "Tahoma"
2098:             .FontSize        = 7
2099:             .FontBold        = .T.
2100:             .Themes          = .F.
2101:             .SpecialEffect   = 0
2102:             .MousePointer    = 15
2103:             .WordWrap        = .T.
2104:             .AutoSize        = .F.
2105:             .Visible         = .T.
2106:         ENDWITH
2107: 
2108:         BINDEVENT(loc_oPg2.cmd_4c_InserirAcesso, "Click", THIS, "BtnInserirAcessoClick")
2109:         BINDEVENT(loc_oPg2.cmd_4c_ExcluirAcesso, "Click", THIS, "BtnExcluirAcessoClick")
2110: 
2111:         *======================================================================
2112:         * SUB-GRADE: Categorias (sigcarct + sigcdctg)
2113:         *======================================================================
2114:         loc_oPg2.AddObject("lbl_4c_LbGradeCat", "Label")
2115:         WITH loc_oPg2.lbl_4c_LbGradeCat
2116:             .Caption   = "Categorias"
2117:             .Top       = 403
2118:             .Left      = 509
2119:             .Width     = 63
2120:             .Height    = 15
2121:             .AutoSize  = .F.
2122:             .FontName  = "Tahoma"
2123:             .FontSize  = 8
2124:             .FontBold  = .T.
2125:             .ForeColor = RGB(90, 90, 90)
2126:             .BackStyle = 0
2127:             .Visible   = .T.
2128:         ENDWITH
2129: 
2130:         loc_oPg2.AddObject("grd_4c_Categorias", "Grid")
2131:         loc_oPg2.grd_4c_Categorias.RecordSource = ""
2132:         loc_oPg2.grd_4c_Categorias.ColumnCount  = 3
2133: 
2134:         loc_oGridCat = loc_oPg2.grd_4c_Categorias
2135:         WITH loc_oGridCat
2136:             .Top                     = 419
2137:             .Left                    = 509
2138:             .Width                   = 310
2139:             .Height                  = 205
2140:             .FontName                = "Verdana"
2141:             .FontSize                = 8
2142:             .ForeColor               = RGB(90, 90, 90)
2143:             .BackColor               = RGB(255, 255, 255)
2144:             .GridLineColor           = RGB(238, 238, 238)
2145:             .HighlightBackColor      = RGB(255, 255, 255)
2146:             .HighlightForeColor      = RGB(15, 41, 104)
2147:             .HighlightStyle          = 2
2148:             .DeleteMark              = .F.
2149:             .RecordMark              = .F.

*-- Linhas 2161 a 2782:
2161:             .Column2.ReadOnly        = .T.
2162:         ENDWITH
2163: 
2164:         BINDEVENT(loc_oGridCat.Column1.Text1, "KeyPress", THIS, "ValidarCategoriaGrade")
2165:         BINDEVENT(loc_oGridCat.Column3.Text1, "KeyPress", THIS, "ValidarTipoCategoria")
2166: 
2167:         *-- Botoes Inserir/Excluir linhas da grade de categorias
2168:         loc_oPg2.AddObject("cmd_4c_InserirCat", "CommandButton")
2169:         WITH loc_oPg2.cmd_4c_InserirCat
2170:             .Caption         = "Inserir"
2171:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
2172:             .PicturePosition = 13
2173:             .Top             = 482
2174:             .Left            = 823
2175:             .Width           = 45
2176:             .Height          = 45
2177:             .BackColor       = RGB(255, 255, 255)
2178:             .ForeColor       = RGB(90, 90, 90)
2179:             .FontName        = "Tahoma"
2180:             .FontSize        = 7
2181:             .FontBold        = .T.
2182:             .Themes          = .F.
2183:             .SpecialEffect   = 0
2184:             .MousePointer    = 15
2185:             .WordWrap        = .T.
2186:             .AutoSize        = .F.
2187:             .Visible         = .T.
2188:         ENDWITH
2189: 
2190:         loc_oPg2.AddObject("cmd_4c_ExcluirCat", "CommandButton")
2191:         WITH loc_oPg2.cmd_4c_ExcluirCat
2192:             .Caption         = "Excluir"
2193:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_26.jpg"
2194:             .PicturePosition = 13
2195:             .Top             = 528
2196:             .Left            = 823
2197:             .Width           = 45
2198:             .Height          = 45
2199:             .BackColor       = RGB(255, 255, 255)
2200:             .ForeColor       = RGB(90, 90, 90)
2201:             .FontName        = "Tahoma"
2202:             .FontSize        = 7
2203:             .FontBold        = .T.
2204:             .Themes          = .F.
2205:             .SpecialEffect   = 0
2206:             .MousePointer    = 15
2207:             .WordWrap        = .T.
2208:             .AutoSize        = .F.
2209:             .Visible         = .T.
2210:         ENDWITH
2211: 
2212:         BINDEVENT(loc_oPg2.cmd_4c_InserirCat, "Click", THIS, "BtnInserirCatClick")
2213:         BINDEVENT(loc_oPg2.cmd_4c_ExcluirCat, "Click", THIS, "BtnExcluirCatClick")
2214: 
2215:         THIS.TornarControlesVisiveis(loc_oPg2)
2216:     ENDPROC
2217: 
2218:     *--------------------------------------------------------------------------
2219:     * CarregarLista - Busca cargos e carrega grid da Page1
2220:     *--------------------------------------------------------------------------
2221:     PROCEDURE CarregarLista()
2222:         LOCAL loc_lResultado, loc_oGrid
2223:         loc_lResultado = .F.
2224: 
2225:         TRY
2226:             IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2227:                 CREATE CURSOR cursor_4c_Dados (ccargs C(10), dcargs C(20))
2228:                 loc_lResultado = .T.
2229:             ELSE
2230:                 IF THIS.this_oBusinessObject.Buscar("")
2231:                     IF PEMSTATUS(THIS.pgf_4c_Paginas.Page1, "grd_4c_Lista", 5)
2232:                         loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2233: 
2234:                         loc_oGrid.ColumnCount  = 2
2235:                         loc_oGrid.RecordSource = "cursor_4c_Dados"
2236:                         loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.ccargs"
2237:                         loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.dcargs"
2238: 
2239:                         loc_oGrid.Column1.Width = 100
2240:                         loc_oGrid.Column2.Width = 760
2241: 
2242:                         loc_oGrid.Column1.ReadOnly = .T.
2243:                         loc_oGrid.Column2.ReadOnly = .T.
2244: 
2245:                         loc_oGrid.Column1.Header1.Caption = "Cargo"
2246:                         loc_oGrid.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2247: 
2248:                         THIS.FormatarGridLista(loc_oGrid)
2249:                     ENDIF
2250:                     loc_lResultado = .T.
2251:                 ENDIF
2252:             ENDIF
2253:         CATCH TO loc_oErro
2254:             MsgErro(loc_oErro.Message, "FormCargo.CarregarLista")
2255:         ENDTRY
2256: 
2257:         RETURN loc_lResultado
2258:     ENDPROC
2259: 
2260:     *--------------------------------------------------------------------------
2261:     * CarregarGrades - Conecta cursores das sub-tabelas aos grids de Page2
2262:     *--------------------------------------------------------------------------
2263:     PROCEDURE CarregarGrades()
2264:         LOCAL loc_oPg2, loc_oGridAcesso, loc_oGridCat
2265:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2266: 
2267:         TRY
2268:             *-- Grid acesso financeiro
2269:             IF PEMSTATUS(loc_oPg2, "grd_4c_AcessoFinan", 5)
2270:                 loc_oGridAcesso = loc_oPg2.grd_4c_AcessoFinan
2271:                 IF USED("cursor_4c_AcessoFinan")
2272:                     loc_oGridAcesso.ColumnCount = 4
2273:                     loc_oGridAcesso.RecordSource = "cursor_4c_AcessoFinan"
2274:                     loc_oGridAcesso.Column1.ControlSource = "cursor_4c_AcessoFinan.grupos"
2275:                     loc_oGridAcesso.Column2.ControlSource = "cursor_4c_AcessoFinan.contas"
2276:                     loc_oGridAcesso.Column3.ControlSource = "cursor_4c_AcessoFinan.valors"
2277:                     loc_oGridAcesso.Column4.ControlSource = "cursor_4c_AcessoFinan.moedas"
2278:                     loc_oGridAcesso.Column1.Header1.Caption = "Grupo"
2279:                     loc_oGridAcesso.Column2.Header1.Caption = "Conta"
2280:                     loc_oGridAcesso.Column3.Header1.Caption = "Valor"
2281:                     loc_oGridAcesso.Column4.Header1.Caption = "Moeda"
2282:                     loc_oGridAcesso.Refresh
2283:                 ENDIF
2284:             ENDIF
2285: 
2286:             *-- Grid categorias
2287:             IF PEMSTATUS(loc_oPg2, "grd_4c_Categorias", 5)
2288:                 loc_oGridCat = loc_oPg2.grd_4c_Categorias
2289:                 IF USED("cursor_4c_Categorias")
2290:                     loc_oGridCat.ColumnCount = 3
2291:                     loc_oGridCat.RecordSource = "cursor_4c_Categorias"
2292:                     loc_oGridCat.Column1.ControlSource = "cursor_4c_Categorias.categoria"
2293:                     loc_oGridCat.Column2.ControlSource = "cursor_4c_Categorias.descs"
2294:                     loc_oGridCat.Column3.ControlSource = "cursor_4c_Categorias.tipo"
2295:                     loc_oGridCat.Column1.Header1.Caption = "Categoria"
2296:                     loc_oGridCat.Column2.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
2297:                     loc_oGridCat.Column3.Header1.Caption = "Tipo"
2298:                     loc_oGridCat.Refresh
2299:                 ENDIF
2300:             ENDIF
2301:         CATCH TO loc_oErro
2302:             MsgErro(loc_oErro.Message, "FormCargo.CarregarGrades")
2303:         ENDTRY
2304:     ENDPROC
2305: 
2306:     *--------------------------------------------------------------------------
2307:     * AlternarPagina - Alterna entre Lista (1) e Dados (2)
2308:     *--------------------------------------------------------------------------
2309:     PROCEDURE AlternarPagina(par_nPagina)
2310:         LOCAL loc_lResultado
2311:         loc_lResultado = .F.
2312: 
2313:         TRY
2314:             IF VARTYPE(par_nPagina) = "N" AND par_nPagina >= 1 AND par_nPagina <= 2
2315:                 THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2316:                 IF par_nPagina = 1
2317:                     THIS.CarregarLista()
2318:                 ENDIF
2319:                 loc_lResultado = .T.
2320:             ENDIF
2321:         CATCH TO loc_oErro
2322:             MsgErro(loc_oErro.Message, "FormCargo.AlternarPagina")
2323:         ENDTRY
2324: 
2325:         RETURN loc_lResultado
2326:     ENDPROC
2327: 
2328:     *--------------------------------------------------------------------------
2329:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
2330:     *--------------------------------------------------------------------------
2331:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2332:         LOCAL loc_nI, loc_oObjeto, loc_nP
2333: 
2334:         FOR loc_nI = 1 TO par_oContainer.ControlCount
2335:             loc_oObjeto = par_oContainer.Controls(loc_nI)
2336: 
2337:             IF VARTYPE(loc_oObjeto) = "O"
2338:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2339:                     loc_oObjeto.Visible = .T.
2340:                 ENDIF
2341: 
2342:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2343:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2344:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2345:                     ENDFOR
2346:                 ENDIF
2347: 
2348:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2349:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2350:                 ENDIF
2351:             ENDIF
2352:         ENDFOR
2353:     ENDPROC
2354: 
2355:     *--------------------------------------------------------------------------
2356:     * FormatarGridLista - Formata visual do grid da lista
2357:     *--------------------------------------------------------------------------
2358:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2359:         WITH par_oGrid
2360:             .FontName = "Tahoma"
2361:             .FontSize = 8
2362:         ENDWITH
2363:     ENDPROC
2364: 
2365:     *--------------------------------------------------------------------------
2366:     * BtnIncluirClick - Prepara form para inclusao de novo cargo
2367:     *--------------------------------------------------------------------------
2368:     PROCEDURE BtnIncluirClick()
2369:         LOCAL loc_lResultado
2370:         loc_lResultado = .F.
2371: 
2372:         TRY
2373:             THIS.this_oBusinessObject.NovoRegistro()
2374:             THIS.LimparCampos()
2375:             THIS.this_cModoAtual = "INCLUIR"
2376:             THIS.HabilitarCampos(.T.)
2377:             THIS.AjustarBotoesPorModo()
2378:             THIS.this_oBusinessObject.InicializarCursoresGrid()
2379:             THIS.CarregarGrades()
2380:             THIS.AlternarPagina(2)
2381:             loc_lResultado = .T.
2382:         CATCH TO loc_oErro
2383:             MsgErro(loc_oErro.Message, "FormCargo.BtnIncluirClick")
2384:         ENDTRY
2385: 
2386:         RETURN loc_lResultado
2387:     ENDPROC
2388: 
2389:     *--------------------------------------------------------------------------
2390:     * BtnVisualizarClick - Abre registro selecionado em modo somente leitura
2391:     *--------------------------------------------------------------------------
2392:     PROCEDURE BtnVisualizarClick()
2393:         LOCAL loc_cCcargs, loc_lResultado
2394:         loc_lResultado = .F.
2395: 
2396:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2397:             MsgAviso("Nenhum registro selecionado.", "Visualizar")
2398:             RETURN .F.
2399:         ENDIF
2400: 
2401:         SELECT cursor_4c_Dados
2402:         loc_cCcargs = ALLTRIM(cursor_4c_Dados.ccargs)
2403: 
2404:         TRY
2405:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCcargs)
2406:                 THIS.BOParaForm()
2407:                 THIS.this_cModoAtual = "VISUALIZAR"
2408:                 THIS.HabilitarCampos(.F.)
2409:                 THIS.AjustarBotoesPorModo()
2410:                 THIS.CarregarGrades()
2411:                 THIS.AlternarPagina(2)
2412:                 loc_lResultado = .T.
2413:             ENDIF
2414:         CATCH TO loc_oErro
2415:             MsgErro(loc_oErro.Message, "FormCargo.BtnVisualizarClick")
2416:         ENDTRY
2417: 
2418:         RETURN loc_lResultado
2419:     ENDPROC
2420: 
2421:     *--------------------------------------------------------------------------
2422:     * BtnAlterarClick - Abre registro selecionado para edicao
2423:     *--------------------------------------------------------------------------
2424:     PROCEDURE BtnAlterarClick()
2425:         LOCAL loc_cCcargs, loc_lResultado
2426:         loc_lResultado = .F.
2427: 
2428:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2429:             MsgAviso("Nenhum registro selecionado.", "Alterar")
2430:             RETURN .F.
2431:         ENDIF
2432: 
2433:         SELECT cursor_4c_Dados
2434:         loc_cCcargs = ALLTRIM(cursor_4c_Dados.ccargs)
2435: 
2436:         TRY
2437:             IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCcargs)
2438:                 THIS.this_oBusinessObject.EditarRegistro()
2439:                 THIS.BOParaForm()
2440:                 THIS.this_cModoAtual = "ALTERAR"
2441:                 THIS.HabilitarCampos(.T.)
2442:                 THIS.AjustarBotoesPorModo()
2443:                 THIS.CarregarGrades()
2444:                 THIS.AlternarPagina(2)
2445:                 loc_lResultado = .T.
2446:             ENDIF
2447:         CATCH TO loc_oErro
2448:             MsgErro(loc_oErro.Message, "FormCargo.BtnAlterarClick")
2449:         ENDTRY
2450: 
2451:         RETURN loc_lResultado
2452:     ENDPROC
2453: 
2454:     *--------------------------------------------------------------------------
2455:     * BtnExcluirClick - Exclui cargo selecionado apos confirmacao
2456:     *--------------------------------------------------------------------------
2457:     PROCEDURE BtnExcluirClick()
2458:         LOCAL loc_cCcargs, loc_lResultado
2459:         loc_lResultado = .F.
2460: 
2461:         IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados") OR RECCOUNT("cursor_4c_Dados") = 0
2462:             MsgAviso("Nenhum registro selecionado.", "Excluir")
2463:             RETURN .F.
2464:         ENDIF
2465: 
2466:         SELECT cursor_4c_Dados
2467:         loc_cCcargs = ALLTRIM(cursor_4c_Dados.ccargs)
2468: 
2469:         IF !THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCcargs)
2470:             RETURN .F.
2471:         ENDIF
2472: 
2473:         IF !MsgConfirma("Confirma a exclus" + CHR(227) + "o do cargo " + loc_cCcargs + "?", "Excluir")
2474:             RETURN .F.
2475:         ENDIF
2476: 
2477:         TRY
2478:             IF THIS.this_oBusinessObject.Excluir()
2479:                 MsgInfo("Cargo exclu" + CHR(237) + "do com sucesso!")
2480:                 THIS.CarregarLista()
2481:                 loc_lResultado = .T.
2482:             ENDIF
2483:         CATCH TO loc_oErro
2484:             MsgErro(loc_oErro.Message, "FormCargo.BtnExcluirClick")
2485:         ENDTRY
2486: 
2487:         RETURN loc_lResultado
2488:     ENDPROC
2489: 
2490:     *--------------------------------------------------------------------------
2491:     * BtnBuscarClick - Vai para Page2 no modo BUSCAR
2492:     *--------------------------------------------------------------------------
2493:     PROCEDURE BtnBuscarClick()
2494:         LOCAL loc_lResultado
2495:         loc_lResultado = .F.
2496: 
2497:         TRY
2498:             THIS.this_oBusinessObject.NovoRegistro()
2499:             THIS.LimparCampos()
2500:             THIS.this_cModoAtual = "BUSCAR"
2501:             THIS.HabilitarCampos(.T.)
2502:             THIS.AjustarBotoesPorModo()
2503:             THIS.AlternarPagina(2)
2504:             loc_lResultado = .T.
2505:         CATCH TO loc_oErro
2506:             MsgErro(loc_oErro.Message, "FormCargo.BtnBuscarClick")
2507:         ENDTRY
2508: 
2509:         RETURN loc_lResultado
2510:     ENDPROC
2511: 
2512:     *--------------------------------------------------------------------------
2513:     * BtnEncerrarClick - Fecha o formulario
2514:     *--------------------------------------------------------------------------
2515:     PROCEDURE BtnEncerrarClick()
2516:         THIS.Release()
2517:     ENDPROC
2518: 
2519:     *--------------------------------------------------------------------------
2520:     * BtnConfirmarClick - Salva cargo (ou localiza em modo BUSCAR)
2521:     *--------------------------------------------------------------------------
2522:     PROCEDURE BtnConfirmarClick()
2523:         LOCAL loc_oPg2, loc_cCodBusca, loc_lResultado
2524:         loc_lResultado = .F.
2525: 
2526:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2527: 
2528:         *-- Validacoes antes do TRY (RETURN valido aqui)
2529:         IF PEMSTATUS(loc_oPg2, "txt_4c_Ccargs", 5) AND ;
2530:            EMPTY(ALLTRIM(loc_oPg2.txt_4c_Ccargs.Value)) AND ;
2531:            THIS.this_cModoAtual = "INCLUIR"
2532:             MsgAviso("O c" + CHR(243) + "digo do cargo " + CHR(233) + " obrigat" + CHR(243) + "rio.", "")
2533:             loc_oPg2.txt_4c_Ccargs.SetFocus
2534:             RETURN .F.
2535:         ENDIF
2536: 
2537:         IF PEMSTATUS(loc_oPg2, "txt_4c_Dcargs", 5) AND ;
2538:            EMPTY(ALLTRIM(loc_oPg2.txt_4c_Dcargs.Value)) AND ;
2539:            !INLIST(THIS.this_cModoAtual, "BUSCAR", "VISUALIZAR")
2540:             MsgAviso("A descri" + CHR(231) + CHR(227) + "o " + CHR(233) + " obrigat" + CHR(243) + "ria.", "")
2541:             loc_oPg2.txt_4c_Dcargs.SetFocus
2542:             RETURN .F.
2543:         ENDIF
2544: 
2545:         TRY
2546:             IF THIS.this_cModoAtual = "BUSCAR"
2547:                 IF PEMSTATUS(loc_oPg2, "txt_4c_Ccargs", 5)
2548:                     loc_cCodBusca = ALLTRIM(loc_oPg2.txt_4c_Ccargs.Value)
2549:                 ELSE
2550:                     loc_cCodBusca = ""
2551:                 ENDIF
2552:                 THIS.this_cModoAtual = "LISTA"
2553:                 THIS.AlternarPagina(1)
2554:                 IF USED("cursor_4c_Dados") AND !EMPTY(loc_cCodBusca)
2555:                     SELECT cursor_4c_Dados
2556:                     LOCATE FOR ALLTRIM(cursor_4c_Dados.ccargs) = loc_cCodBusca
2557:                     IF !FOUND()
2558:                         LOCATE FOR UPPER(ALLTRIM(cursor_4c_Dados.dcargs)) = UPPER(loc_cCodBusca)
2559:                     ENDIF
2560:                 ENDIF
2561:                 loc_lResultado = .T.
2562:             ELSE
2563:                 IF THIS.FormParaBO()
2564:                     IF THIS.this_oBusinessObject.Salvar()
2565:                         MsgInfo("Cargo salvo com sucesso!")
2566:                         THIS.this_cModoAtual = "LISTA"
2567:                         THIS.AlternarPagina(1)
2568:                         loc_lResultado = .T.
2569:                     ENDIF
2570:                 ENDIF
2571:             ENDIF
2572:         CATCH TO loc_oErro
2573:             MsgErro(loc_oErro.Message, "FormCargo.BtnConfirmarClick")
2574:         ENDTRY
2575: 
2576:         RETURN loc_lResultado
2577:     ENDPROC
2578: 
2579:     *--------------------------------------------------------------------------
2580:     * BtnSalvarClick - Alias canonico para BtnConfirmarClick
2581:     *--------------------------------------------------------------------------
2582:     PROCEDURE BtnSalvarClick()
2583:         RETURN THIS.BtnConfirmarClick()
2584:     ENDPROC
2585: 
2586:     *--------------------------------------------------------------------------
2587:     * BtnCancelarClick - Cancela e volta para lista
2588:     *--------------------------------------------------------------------------
2589:     PROCEDURE BtnCancelarClick()
2590:         TRY
2591:             THIS.this_cModoAtual = "LISTA"
2592:             THIS.AlternarPagina(1)
2593:         CATCH TO loc_oErro
2594:             MsgErro(loc_oErro.Message, "FormCargo.BtnCancelarClick")
2595:         ENDTRY
2596:     ENDPROC
2597: 
2598:     *--------------------------------------------------------------------------
2599:     * BtnBuscarBaseClick - Abre picker para copiar cargo existente como modelo
2600:     *--------------------------------------------------------------------------
2601:     PROCEDURE BtnBuscarBaseClick()
2602:         IF THIS.this_cModoAtual != "INCLUIR"
2603:             RETURN
2604:         ENDIF
2605: 
2606:         LOCAL loc_oPg2, loc_cValor, loc_oBusca, loc_cCargoSelecionado
2607:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2608:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Ccargs.Value)
2609: 
2610:         TRY
2611:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2612:                 "SIGCDCRG", "cursor_4c_BuscaCargoBase", "ccargs", loc_cValor, ;
2613:                 "Selecionar Cargo Base")
2614: 
2615:             IF VARTYPE(loc_oBusca) = "O"
2616:                 IF !loc_oBusca.this_lAchouRegistro
2617:                     loc_oBusca.mAddColuna("ccargs", "", "Cargo")
2618:                     loc_oBusca.mAddColuna("dcargs", "", "Descri" + CHR(231) + CHR(227) + "o")
2619:                     loc_oBusca.Show()
2620:                 ENDIF
2621: 
2622:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCargoBase")
2623:                     SELECT cursor_4c_BuscaCargoBase
2624:                     loc_cCargoSelecionado = ALLTRIM(cursor_4c_BuscaCargoBase.ccargs)
2625: 
2626:                     IF !EMPTY(loc_cCargoSelecionado)
2627:                         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCargoSelecionado)
2628:                             THIS.BOParaForm()
2629:                             *-- Limpa o codigo para o usuario digitar o novo
2630:                             loc_oPg2.txt_4c_Ccargs.Value = ""
2631:                             THIS.CarregarGrades()
2632:                         ENDIF
2633:                     ENDIF
2634:                 ENDIF
2635: 
2636:                 loc_oBusca.Release()
2637:             ENDIF
2638:         CATCH TO loc_oErro
2639:             MsgErro(loc_oErro.Message, "FormCargo.BtnBuscarBaseClick")
2640:         ENDTRY
2641: 
2642:         IF USED("cursor_4c_BuscaCargoBase")
2643:             USE IN cursor_4c_BuscaCargoBase
2644:         ENDIF
2645:     ENDPROC
2646: 
2647:     *--------------------------------------------------------------------------
2648:     * BtnInserirAcessoClick - Adiciona linha na grade de acesso financeiro
2649:     *--------------------------------------------------------------------------
2650:     PROCEDURE BtnInserirAcessoClick()
2651:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2652:             RETURN
2653:         ENDIF
2654:         IF !USED("cursor_4c_AcessoFinan")
2655:             RETURN
2656:         ENDIF
2657: 
2658:         TRY
2659:             SELECT cursor_4c_AcessoFinan
2660:             APPEND BLANK
2661:             THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Refresh
2662:             THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Column1.SetFocus
2663:         CATCH TO loc_oErro
2664:             MsgErro(loc_oErro.Message, "FormCargo.BtnInserirAcessoClick")
2665:         ENDTRY
2666:     ENDPROC
2667: 
2668:     *--------------------------------------------------------------------------
2669:     * BtnExcluirAcessoClick - Remove linha da grade de acesso financeiro
2670:     *--------------------------------------------------------------------------
2671:     PROCEDURE BtnExcluirAcessoClick()
2672:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2673:             RETURN
2674:         ENDIF
2675:         IF !USED("cursor_4c_AcessoFinan")
2676:             RETURN
2677:         ENDIF
2678: 
2679:         SELECT cursor_4c_AcessoFinan
2680:         IF BOF() OR EOF()
2681:             RETURN
2682:         ENDIF
2683: 
2684:         TRY
2685:             DELETE
2686:             PACK
2687:             THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan.Refresh
2688:         CATCH TO loc_oErro
2689:             MsgErro(loc_oErro.Message, "FormCargo.BtnExcluirAcessoClick")
2690:         ENDTRY
2691:     ENDPROC
2692: 
2693:     *--------------------------------------------------------------------------
2694:     * BtnInserirCatClick - Adiciona linha na grade de categorias
2695:     *--------------------------------------------------------------------------
2696:     PROCEDURE BtnInserirCatClick()
2697:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2698:             RETURN
2699:         ENDIF
2700:         IF !USED("cursor_4c_Categorias")
2701:             RETURN
2702:         ENDIF
2703: 
2704:         TRY
2705:             SELECT cursor_4c_Categorias
2706:             APPEND BLANK
2707:             THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Refresh
2708:             THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Column1.SetFocus
2709:         CATCH TO loc_oErro
2710:             MsgErro(loc_oErro.Message, "FormCargo.BtnInserirCatClick")
2711:         ENDTRY
2712:     ENDPROC
2713: 
2714:     *--------------------------------------------------------------------------
2715:     * BtnExcluirCatClick - Remove linha da grade de categorias
2716:     *--------------------------------------------------------------------------
2717:     PROCEDURE BtnExcluirCatClick()
2718:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2719:             RETURN
2720:         ENDIF
2721:         IF !USED("cursor_4c_Categorias")
2722:             RETURN
2723:         ENDIF
2724: 
2725:         SELECT cursor_4c_Categorias
2726:         IF BOF() OR EOF()
2727:             RETURN
2728:         ENDIF
2729: 
2730:         TRY
2731:             DELETE
2732:             PACK
2733:             THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias.Refresh
2734:         CATCH TO loc_oErro
2735:             MsgErro(loc_oErro.Message, "FormCargo.BtnExcluirCatClick")
2736:         ENDTRY
2737:     ENDPROC
2738: 
2739:     *--------------------------------------------------------------------------
2740:     * FormParaBO - Transfere valores do form para o BO
2741:     *--------------------------------------------------------------------------
2742:     PROTECTED PROCEDURE FormParaBO()
2743:         LOCAL loc_oPg2, loc_lResultado
2744:         loc_lResultado = .F.
2745: 
2746:         TRY
2747:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2748: 
2749:             THIS.this_oBusinessObject.this_cCcargs      = ALLTRIM(loc_oPg2.txt_4c_Ccargs.Value)
2750:             THIS.this_oBusinessObject.this_cDcargs      = ALLTRIM(loc_oPg2.txt_4c_Dcargs.Value)
2751:             THIS.this_oBusinessObject.this_nLimdescs    = loc_oPg2.txt_4c_Limdescs.Value
2752:             THIS.this_oBusinessObject.this_nDescpors    = loc_oPg2.txt_4c_Descpors.Value
2753:             THIS.this_oBusinessObject.this_nLimacres    = loc_oPg2.txt_4c_Limacres.Value
2754:             THIS.this_oBusinessObject.this_nAcrepors    = loc_oPg2.txt_4c_Acrepors.Value
2755:             THIS.this_oBusinessObject.this_nVllibpgs    = loc_oPg2.txt_4c_Vllibpgs.Value
2756:             THIS.this_oBusinessObject.this_nVllibcots   = loc_oPg2.txt_4c_Vllibcots.Value
2757:             THIS.this_oBusinessObject.this_nVllibopes   = loc_oPg2.txt_4c_Vllibopes.Value
2758:             THIS.this_oBusinessObject.this_nVarcots     = loc_oPg2.txt_4c_Varcots.Value
2759:             THIS.this_oBusinessObject.this_cGrcomis     = ALLTRIM(loc_oPg2.txt_4c_Grcomis.Value)
2760:             THIS.this_oBusinessObject.this_nAcomis      = loc_oPg2.txt_4c_Acomis.Value
2761:             THIS.this_oBusinessObject.this_nComis       = loc_oPg2.txt_4c_Comis.Value
2762:             THIS.this_oBusinessObject.this_nVarmovdup   = loc_oPg2.txt_4c_Varmovdup.Value
2763:             THIS.this_oBusinessObject.this_cNivels      = ALLTRIM(loc_oPg2.txt_4c_Nivels.Value)
2764:             THIS.this_oBusinessObject.this_cAltcots     = ALLTRIM(loc_oPg2.txt_4c_Altcots.Value)
2765:             THIS.this_oBusinessObject.this_cLimites     = ALLTRIM(loc_oPg2.txt_4c_Limites.Value)
2766:             THIS.this_oBusinessObject.this_cCancitens   = ALLTRIM(loc_oPg2.txt_4c_Cancitens.Value)
2767:             THIS.this_oBusinessObject.this_cLibfpags    = ALLTRIM(loc_oPg2.txt_4c_Libfpags.Value)
2768:             THIS.this_oBusinessObject.this_cLibsdins    = ALLTRIM(loc_oPg2.txt_4c_Libsdins.Value)
2769:             THIS.this_oBusinessObject.this_cLibfpgs     = ALLTRIM(loc_oPg2.txt_4c_Libfpgs.Value)
2770:             THIS.this_oBusinessObject.this_cLibopes     = ALLTRIM(loc_oPg2.txt_4c_Libopes.Value)
2771:             THIS.this_oBusinessObject.this_cLibexprd    = ALLTRIM(loc_oPg2.txt_4c_Libexprd.Value)
2772:             THIS.this_oBusinessObject.this_cFcomis      = ALLTRIM(loc_oPg2.txt_4c_Fcomis.Value)
2773:             THIS.this_oBusinessObject.this_cLibvmovdup  = ALLTRIM(loc_oPg2.txt_4c_Libvmovdup.Value)
2774:             THIS.this_oBusinessObject.this_cConsSubn    = ALLTRIM(loc_oPg2.txt_4c_ConsSubn.Value)
2775:             THIS.this_oBusinessObject.this_nLibleilaos  = loc_oPg2.opt_4c_Libleilaos.Value
2776:             THIS.this_oBusinessObject.this_nLibdupends  = loc_oPg2.opt_4c_Libdupends.Value
2777:             THIS.this_oBusinessObject.this_nCustoprod   = loc_oPg2.opt_4c_Custoprod.Value
2778:             THIS.this_oBusinessObject.this_nLibValmmax  = loc_oPg2.opt_4c_LibValmmax.Value
2779:             THIS.this_oBusinessObject.this_nLibduptits  = loc_oPg2.opt_4c_Libduptits.Value
2780:             THIS.this_oBusinessObject.this_nLibprzes    = loc_oPg2.opt_4c_Libprzes.Value
2781:             THIS.this_oBusinessObject.this_nTpcomis     = loc_oPg2.opt_4c_Tpcomis.Value
2782: 

*-- Linhas 2791 a 2937:
2791:     *--------------------------------------------------------------------------
2792:     * BOParaForm - Transfere valores do BO para o form
2793:     *--------------------------------------------------------------------------
2794:     PROTECTED PROCEDURE BOParaForm()
2795:         LOCAL loc_oPg2, loc_lResultado, loc_nTpcomis
2796:         loc_lResultado = .F.
2797: 
2798:         TRY
2799:             loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2800: 
2801:             loc_oPg2.txt_4c_Ccargs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cCcargs)
2802:             loc_oPg2.txt_4c_Dcargs.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cDcargs)
2803:             loc_oPg2.txt_4c_Limdescs.Value  = THIS.this_oBusinessObject.this_nLimdescs
2804:             loc_oPg2.txt_4c_Descpors.Value  = THIS.this_oBusinessObject.this_nDescpors
2805:             loc_oPg2.txt_4c_Limacres.Value  = THIS.this_oBusinessObject.this_nLimacres
2806:             loc_oPg2.txt_4c_Acrepors.Value  = THIS.this_oBusinessObject.this_nAcrepors
2807:             loc_oPg2.txt_4c_Vllibpgs.Value  = THIS.this_oBusinessObject.this_nVllibpgs
2808:             loc_oPg2.txt_4c_Vllibcots.Value = THIS.this_oBusinessObject.this_nVllibcots
2809:             loc_oPg2.txt_4c_Vllibopes.Value = THIS.this_oBusinessObject.this_nVllibopes
2810:             loc_oPg2.txt_4c_Varcots.Value   = THIS.this_oBusinessObject.this_nVarcots
2811:             loc_oPg2.txt_4c_Grcomis.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cGrcomis)
2812:             loc_oPg2.txt_4c_Acomis.Value    = THIS.this_oBusinessObject.this_nAcomis
2813:             loc_oPg2.txt_4c_Comis.Value     = THIS.this_oBusinessObject.this_nComis
2814:             loc_oPg2.txt_4c_Varmovdup.Value = THIS.this_oBusinessObject.this_nVarmovdup
2815:             loc_oPg2.txt_4c_Nivels.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cNivels)
2816:             loc_oPg2.txt_4c_Altcots.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cAltcots)
2817:             loc_oPg2.txt_4c_Limites.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cLimites)
2818:             loc_oPg2.txt_4c_Cancitens.Value = ALLTRIM(THIS.this_oBusinessObject.this_cCancitens)
2819:             loc_oPg2.txt_4c_Libfpags.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cLibfpags)
2820:             loc_oPg2.txt_4c_Libsdins.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cLibsdins)
2821:             loc_oPg2.txt_4c_Libfpgs.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cLibfpgs)
2822:             loc_oPg2.txt_4c_Libopes.Value   = ALLTRIM(THIS.this_oBusinessObject.this_cLibopes)
2823:             loc_oPg2.txt_4c_Libexprd.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cLibexprd)
2824:             loc_oPg2.txt_4c_Fcomis.Value    = ALLTRIM(THIS.this_oBusinessObject.this_cFcomis)
2825:             loc_oPg2.txt_4c_Libvmovdup.Value = ALLTRIM(THIS.this_oBusinessObject.this_cLibvmovdup)
2826:             loc_oPg2.txt_4c_ConsSubn.Value  = ALLTRIM(THIS.this_oBusinessObject.this_cConsSubn)
2827: 
2828:             *-- OptionGroups binarios (0 no BO = Nao = 2 no form)
2829:             loc_oPg2.opt_4c_Libleilaos.Value = IIF(THIS.this_oBusinessObject.this_nLibleilaos = 1, 1, 2)
2830:             loc_oPg2.opt_4c_Libdupends.Value = IIF(THIS.this_oBusinessObject.this_nLibdupends = 1, 1, 2)
2831:             loc_oPg2.opt_4c_Custoprod.Value  = IIF(THIS.this_oBusinessObject.this_nCustoprod  = 1, 1, 2)
2832:             loc_oPg2.opt_4c_LibValmmax.Value = IIF(THIS.this_oBusinessObject.this_nLibValmmax = 1, 1, 2)
2833:             loc_oPg2.opt_4c_Libduptits.Value = IIF(THIS.this_oBusinessObject.this_nLibduptits = 1, 1, 2)
2834:             loc_oPg2.opt_4c_Libprzes.Value   = IIF(THIS.this_oBusinessObject.this_nLibprzes   = 1, 1, 2)
2835: 
2836:             *-- Tipo comissao (1-3, default 1)
2837:             loc_nTpcomis = THIS.this_oBusinessObject.this_nTpcomis
2838:             loc_oPg2.opt_4c_Tpcomis.Value = IIF(loc_nTpcomis >= 1 AND loc_nTpcomis <= 3, loc_nTpcomis, 1)
2839: 
2840:             loc_lResultado = .T.
2841:         CATCH TO loc_oErro
2842:             MsgErro(loc_oErro.Message, "FormCargo.BOParaForm")
2843:         ENDTRY
2844: 
2845:         RETURN loc_lResultado
2846:     ENDPROC
2847: 
2848:     *--------------------------------------------------------------------------
2849:     * LimparCampos - Limpa valores dos campos da Page2
2850:     *--------------------------------------------------------------------------
2851:     PROTECTED PROCEDURE LimparCampos()
2852:         LOCAL loc_oPg2
2853:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2854: 
2855:         TRY
2856:             loc_oPg2.txt_4c_Ccargs.Value    = ""
2857:             loc_oPg2.txt_4c_Dcargs.Value    = ""
2858:             loc_oPg2.txt_4c_Limdescs.Value  = 0
2859:             loc_oPg2.txt_4c_Descpors.Value  = 0
2860:             loc_oPg2.txt_4c_Limacres.Value  = 0
2861:             loc_oPg2.txt_4c_Acrepors.Value  = 0
2862:             loc_oPg2.txt_4c_Vllibpgs.Value  = 0
2863:             loc_oPg2.txt_4c_Vllibcots.Value = 0
2864:             loc_oPg2.txt_4c_Vllibopes.Value = 0
2865:             loc_oPg2.txt_4c_Varcots.Value   = 0
2866:             loc_oPg2.txt_4c_Grcomis.Value   = ""
2867:             loc_oPg2.txt_4c_Acomis.Value    = 0
2868:             loc_oPg2.txt_4c_Comis.Value     = 0
2869:             loc_oPg2.txt_4c_Varmovdup.Value = 0
2870:             loc_oPg2.txt_4c_Nivels.Value    = ""
2871:             loc_oPg2.txt_4c_Altcots.Value   = ""
2872:             loc_oPg2.txt_4c_Limites.Value   = ""
2873:             loc_oPg2.txt_4c_Cancitens.Value = ""
2874:             loc_oPg2.txt_4c_Libfpags.Value  = ""
2875:             loc_oPg2.txt_4c_Libsdins.Value  = ""
2876:             loc_oPg2.txt_4c_Libfpgs.Value   = ""
2877:             loc_oPg2.txt_4c_Libopes.Value   = ""
2878:             loc_oPg2.txt_4c_Libexprd.Value  = ""
2879:             loc_oPg2.txt_4c_Fcomis.Value    = ""
2880:             loc_oPg2.txt_4c_Libvmovdup.Value = ""
2881:             loc_oPg2.txt_4c_ConsSubn.Value  = ""
2882:             loc_oPg2.opt_4c_Libleilaos.Value = 2
2883:             loc_oPg2.opt_4c_Libdupends.Value = 2
2884:             loc_oPg2.opt_4c_Custoprod.Value  = 2
2885:             loc_oPg2.opt_4c_LibValmmax.Value = 2
2886:             loc_oPg2.opt_4c_Libduptits.Value = 2
2887:             loc_oPg2.opt_4c_Libprzes.Value   = 2
2888:             loc_oPg2.opt_4c_Tpcomis.Value    = 1
2889:         CATCH TO loc_oErro
2890:             MsgErro(loc_oErro.Message, "FormCargo.LimparCampos")
2891:         ENDTRY
2892:     ENDPROC
2893: 
2894:     *--------------------------------------------------------------------------
2895:     * HabilitarCampos - Habilita ou desabilita campos da Page2
2896:     *--------------------------------------------------------------------------
2897:     PROTECTED PROCEDURE HabilitarCampos(par_lHabilitar)
2898:         LOCAL loc_oPg2, loc_lCodHabilitar
2899:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
2900: 
2901:         TRY
2902:             *-- Codigo do cargo: apenas em INCLUIR e BUSCAR
2903:             loc_lCodHabilitar = INLIST(THIS.this_cModoAtual, "INCLUIR", "BUSCAR")
2904:             loc_oPg2.txt_4c_Ccargs.Enabled     = loc_lCodHabilitar
2905:             loc_oPg2.cmd_4c_BuscarBase.Enabled = (THIS.this_cModoAtual = "INCLUIR")
2906: 
2907:             *-- Demais campos
2908:             loc_oPg2.txt_4c_Dcargs.Enabled     = par_lHabilitar
2909:             loc_oPg2.txt_4c_Limdescs.Enabled   = par_lHabilitar
2910:             loc_oPg2.txt_4c_Descpors.Enabled   = par_lHabilitar
2911:             loc_oPg2.txt_4c_Limacres.Enabled   = par_lHabilitar
2912:             loc_oPg2.txt_4c_Acrepors.Enabled   = par_lHabilitar
2913:             loc_oPg2.txt_4c_Vllibpgs.Enabled   = par_lHabilitar
2914:             loc_oPg2.txt_4c_Vllibcots.Enabled  = par_lHabilitar
2915:             loc_oPg2.txt_4c_Vllibopes.Enabled  = par_lHabilitar
2916:             loc_oPg2.txt_4c_Varcots.Enabled    = par_lHabilitar
2917:             loc_oPg2.txt_4c_Grcomis.Enabled    = par_lHabilitar
2918:             loc_oPg2.txt_4c_Acomis.Enabled     = par_lHabilitar
2919:             loc_oPg2.txt_4c_Comis.Enabled      = par_lHabilitar
2920:             loc_oPg2.txt_4c_Varmovdup.Enabled  = par_lHabilitar
2921:             loc_oPg2.txt_4c_Nivels.Enabled     = par_lHabilitar
2922:             loc_oPg2.txt_4c_Altcots.Enabled    = par_lHabilitar
2923:             loc_oPg2.txt_4c_Limites.Enabled    = par_lHabilitar
2924:             loc_oPg2.txt_4c_Cancitens.Enabled  = par_lHabilitar
2925:             loc_oPg2.txt_4c_Libfpags.Enabled   = par_lHabilitar
2926:             loc_oPg2.txt_4c_Libsdins.Enabled   = par_lHabilitar
2927:             loc_oPg2.txt_4c_Libfpgs.Enabled    = par_lHabilitar
2928:             loc_oPg2.txt_4c_Libopes.Enabled    = par_lHabilitar
2929:             loc_oPg2.txt_4c_Libexprd.Enabled   = par_lHabilitar
2930:             loc_oPg2.txt_4c_Fcomis.Enabled     = par_lHabilitar
2931:             loc_oPg2.txt_4c_Libvmovdup.Enabled = par_lHabilitar
2932:             loc_oPg2.txt_4c_ConsSubn.Enabled   = par_lHabilitar
2933:             loc_oPg2.opt_4c_Libleilaos.Enabled = par_lHabilitar
2934:             loc_oPg2.opt_4c_Libdupends.Enabled = par_lHabilitar
2935:             loc_oPg2.opt_4c_Custoprod.Enabled  = par_lHabilitar
2936:             loc_oPg2.opt_4c_LibValmmax.Enabled = par_lHabilitar
2937:             loc_oPg2.opt_4c_Libduptits.Enabled = par_lHabilitar

*-- Linhas 2951 a 3300:
2951:                 loc_oPg2.cmd_4c_InserirAcesso.Enabled = par_lHabilitar
2952:             ENDIF
2953:             IF PEMSTATUS(loc_oPg2, "cmd_4c_ExcluirAcesso", 5)
2954:                 loc_oPg2.cmd_4c_ExcluirAcesso.Enabled = par_lHabilitar
2955:             ENDIF
2956:             IF PEMSTATUS(loc_oPg2, "cmd_4c_InserirCat", 5)
2957:                 loc_oPg2.cmd_4c_InserirCat.Enabled = par_lHabilitar
2958:             ENDIF
2959:             IF PEMSTATUS(loc_oPg2, "cmd_4c_ExcluirCat", 5)
2960:                 loc_oPg2.cmd_4c_ExcluirCat.Enabled = par_lHabilitar
2961:             ENDIF
2962:         CATCH TO loc_oErro
2963:             MsgErro(loc_oErro.Message, "FormCargo.HabilitarCampos")
2964:         ENDTRY
2965:     ENDPROC
2966: 
2967:     *--------------------------------------------------------------------------
2968:     * AjustarBotoesPorModo - Habilita/desabilita botoes conforme modo
2969:     *--------------------------------------------------------------------------
2970:     PROCEDURE AjustarBotoesPorModo()
2971:         LOCAL loc_oBotoesAcao
2972:         loc_oBotoesAcao = THIS.pgf_4c_Paginas.Page2.cnt_4c_BotoesAcao
2973: 
2974:         TRY
2975:             loc_oBotoesAcao.cmd_4c_Confirmar.Enabled = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR", "BUSCAR")
2976:             loc_oBotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2977:         CATCH TO loc_oErro
2978:             MsgErro(loc_oErro.Message, "FormCargo.AjustarBotoesPorModo")
2979:         ENDTRY
2980:     ENDPROC
2981: 
2982:     *--------------------------------------------------------------------------
2983:     * BuscarGrupoFinan - Lookup Grupo Financeiro (SigCdGcr) via F4/Enter/Tab
2984:     *--------------------------------------------------------------------------
2985:     PROCEDURE BuscarGrupoFinan(par_nKeyCode, par_nShiftAltCtrl)
2986:         IF !INLIST(par_nKeyCode, 13, 9, 115)
2987:             RETURN
2988:         ENDIF
2989: 
2990:         LOCAL loc_oPg2, loc_cValor, loc_oBusca
2991:         loc_oPg2   = THIS.pgf_4c_Paginas.Page2
2992:         loc_cValor = ALLTRIM(loc_oPg2.txt_4c_Grcomis.Value)
2993: 
2994:         IF EMPTY(loc_cValor)
2995:             RETURN
2996:         ENDIF
2997: 
2998:         TRY
2999:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3000:                 "SigCdGcr", "cursor_4c_BuscaGcr", "Codigos", loc_cValor, ;
3001:                 "Grupo Financeiro")
3002: 
3003:             IF VARTYPE(loc_oBusca) = "O"
3004:                 IF !loc_oBusca.this_lAchouRegistro
3005:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
3006:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3007:                     loc_oBusca.Show()
3008:                 ENDIF
3009: 
3010:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr")
3011:                     SELECT cursor_4c_BuscaGcr
3012:                     loc_oPg2.txt_4c_Grcomis.Value = ALLTRIM(cursor_4c_BuscaGcr.Codigos)
3013:                 ENDIF
3014: 
3015:                 loc_oBusca.Release()
3016:             ENDIF
3017:         CATCH TO loc_oErro
3018:             MsgErro(loc_oErro.Message, "FormCargo.BuscarGrupoFinan")
3019:         ENDTRY
3020: 
3021:         IF USED("cursor_4c_BuscaGcr")
3022:             USE IN cursor_4c_BuscaGcr
3023:         ENDIF
3024:     ENDPROC
3025: 
3026:     *--------------------------------------------------------------------------
3027:     * ValidarGrupoGrade - Lookup SigCdGcr para coluna Grupos da grade acesso
3028:     *--------------------------------------------------------------------------
3029:     PROCEDURE ValidarGrupoGrade(par_nKeyCode, par_nShiftAltCtrl)
3030:         IF !INLIST(par_nKeyCode, 13, 9, 115)
3031:             RETURN
3032:         ENDIF
3033: 
3034:         LOCAL loc_oGrid, loc_cValor, loc_oBusca
3035:         loc_oGrid  = THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan
3036:         loc_cValor = ALLTRIM(loc_oGrid.Column1.Text1.Value)
3037: 
3038:         IF EMPTY(loc_cValor)
3039:             RETURN
3040:         ENDIF
3041: 
3042:         TRY
3043:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3044:                 "SigCdGcr", "cursor_4c_BuscaGcr2", "Codigos", loc_cValor, ;
3045:                 "Grupo Financeiro")
3046: 
3047:             IF VARTYPE(loc_oBusca) = "O"
3048:                 IF !loc_oBusca.this_lAchouRegistro
3049:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
3050:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3051:                     loc_oBusca.Show()
3052:                 ENDIF
3053: 
3054:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaGcr2")
3055:                     SELECT cursor_4c_BuscaGcr2
3056:                     REPLACE grupos WITH ALLTRIM(cursor_4c_BuscaGcr2.Codigos) IN cursor_4c_AcessoFinan
3057:                     loc_oGrid.Column1.Text1.Value = ALLTRIM(cursor_4c_BuscaGcr2.Codigos)
3058:                     loc_oGrid.Refresh
3059:                 ENDIF
3060: 
3061:                 loc_oBusca.Release()
3062:             ENDIF
3063:         CATCH TO loc_oErro
3064:             MsgErro(loc_oErro.Message, "FormCargo.ValidarGrupoGrade")
3065:         ENDTRY
3066: 
3067:         IF USED("cursor_4c_BuscaGcr2")
3068:             USE IN cursor_4c_BuscaGcr2
3069:         ENDIF
3070:     ENDPROC
3071: 
3072:     *--------------------------------------------------------------------------
3073:     * ValidarContaGrade - Lookup conta financeira para coluna Contas da grade
3074:     * Nota: contas referencia tabela de contas financeiras (verificar FK)
3075:     *--------------------------------------------------------------------------
3076:     PROCEDURE ValidarContaGrade(par_nKeyCode, par_nShiftAltCtrl)
3077:         IF !INLIST(par_nKeyCode, 13, 9, 115)
3078:             RETURN
3079:         ENDIF
3080: 
3081:         LOCAL loc_oGrid, loc_cValor, loc_cGrupo, loc_oBusca
3082:         loc_oGrid  = THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan
3083:         loc_cValor = ALLTRIM(loc_oGrid.Column2.Text1.Value)
3084:         loc_cGrupo = ALLTRIM(loc_oGrid.Column1.Text1.Value)
3085: 
3086:         IF EMPTY(loc_cValor)
3087:             RETURN
3088:         ENDIF
3089: 
3090:         TRY
3091:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3092:                 "SigCdGcr", "cursor_4c_BuscaConta", "Codigos", loc_cValor, ;
3093:                 "Conta Financeira")
3094: 
3095:             IF VARTYPE(loc_oBusca) = "O"
3096:                 IF !loc_oBusca.this_lAchouRegistro
3097:                     loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
3098:                     loc_oBusca.mAddColuna("Descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
3099:                     loc_oBusca.Show()
3100:                 ENDIF
3101: 
3102:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaConta")
3103:                     SELECT cursor_4c_BuscaConta
3104:                     REPLACE contas WITH ALLTRIM(cursor_4c_BuscaConta.Codigos) IN cursor_4c_AcessoFinan
3105:                     loc_oGrid.Column2.Text1.Value = ALLTRIM(cursor_4c_BuscaConta.Codigos)
3106:                     loc_oGrid.Refresh
3107:                 ENDIF
3108: 
3109:                 loc_oBusca.Release()
3110:             ENDIF
3111:         CATCH TO loc_oErro
3112:             MsgErro(loc_oErro.Message, "FormCargo.ValidarContaGrade")
3113:         ENDTRY
3114: 
3115:         IF USED("cursor_4c_BuscaConta")
3116:             USE IN cursor_4c_BuscaConta
3117:         ENDIF
3118:     ENDPROC
3119: 
3120:     *--------------------------------------------------------------------------
3121:     * ValidarMoedaGrade - Lookup SigCdMoe para coluna Moedas da grade acesso
3122:     *--------------------------------------------------------------------------
3123:     PROCEDURE ValidarMoedaGrade(par_nKeyCode, par_nShiftAltCtrl)
3124:         IF !INLIST(par_nKeyCode, 13, 9, 115)
3125:             RETURN
3126:         ENDIF
3127: 
3128:         LOCAL loc_oGrid, loc_cValor, loc_oBusca
3129:         loc_oGrid  = THIS.pgf_4c_Paginas.Page2.grd_4c_AcessoFinan
3130:         loc_cValor = ALLTRIM(loc_oGrid.Column4.Text1.Value)
3131: 
3132:         IF EMPTY(loc_cValor)
3133:             RETURN
3134:         ENDIF
3135: 
3136:         TRY
3137:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3138:                 "SigCdMoe", "cursor_4c_BuscaMoe", "CMoes", loc_cValor, ;
3139:                 "Moeda")
3140: 
3141:             IF VARTYPE(loc_oBusca) = "O"
3142:                 IF !loc_oBusca.this_lAchouRegistro
3143:                     loc_oBusca.mAddColuna("CMoes", "", "Moeda")
3144:                     loc_oBusca.mAddColuna("DMoes", "", "Descri" + CHR(231) + CHR(227) + "o")
3145:                     loc_oBusca.Show()
3146:                 ENDIF
3147: 
3148:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaMoe")
3149:                     SELECT cursor_4c_BuscaMoe
3150:                     REPLACE moedas WITH ALLTRIM(cursor_4c_BuscaMoe.CMoes) IN cursor_4c_AcessoFinan
3151:                     loc_oGrid.Column4.Text1.Value = ALLTRIM(cursor_4c_BuscaMoe.CMoes)
3152:                     loc_oGrid.Refresh
3153:                 ENDIF
3154: 
3155:                 loc_oBusca.Release()
3156:             ENDIF
3157:         CATCH TO loc_oErro
3158:             MsgErro(loc_oErro.Message, "FormCargo.ValidarMoedaGrade")
3159:         ENDTRY
3160: 
3161:         IF USED("cursor_4c_BuscaMoe")
3162:             USE IN cursor_4c_BuscaMoe
3163:         ENDIF
3164:     ENDPROC
3165: 
3166:     *--------------------------------------------------------------------------
3167:     * ValidarCategoriaGrade - Lookup SigCdCtg para coluna Categoria da grade
3168:     *--------------------------------------------------------------------------
3169:     PROCEDURE ValidarCategoriaGrade(par_nKeyCode, par_nShiftAltCtrl)
3170:         IF !INLIST(par_nKeyCode, 13, 9, 115)
3171:             RETURN
3172:         ENDIF
3173: 
3174:         LOCAL loc_oGridCat, loc_cValor, loc_oBusca
3175:         loc_oGridCat = THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias
3176:         loc_cValor   = ALLTRIM(loc_oGridCat.Column1.Text1.Value)
3177: 
3178:         IF EMPTY(loc_cValor)
3179:             RETURN
3180:         ENDIF
3181: 
3182:         TRY
3183:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3184:                 "SigCdCtg", "cursor_4c_BuscaCtg", "Cods", loc_cValor, ;
3185:                 "Categoria")
3186: 
3187:             IF VARTYPE(loc_oBusca) = "O"
3188:                 IF !loc_oBusca.this_lAchouRegistro
3189:                     loc_oBusca.mAddColuna("Cods",  "", "C" + CHR(243) + "digo")
3190:                     loc_oBusca.mAddColuna("Descs", "", "Descri" + CHR(231) + CHR(227) + "o")
3191:                     loc_oBusca.Show()
3192:                 ENDIF
3193: 
3194:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaCtg")
3195:                     SELECT cursor_4c_BuscaCtg
3196:                     REPLACE categoria WITH ALLTRIM(cursor_4c_BuscaCtg.Cods), ;
3197:                             descs     WITH ALLTRIM(cursor_4c_BuscaCtg.Descs) ;
3198:                         IN cursor_4c_Categorias
3199:                     loc_oGridCat.Column1.Text1.Value = ALLTRIM(cursor_4c_BuscaCtg.Cods)
3200:                     loc_oGridCat.Column2.Text1.Value = ALLTRIM(cursor_4c_BuscaCtg.Descs)
3201:                     loc_oGridCat.Refresh
3202:                 ENDIF
3203: 
3204:                 loc_oBusca.Release()
3205:             ENDIF
3206:         CATCH TO loc_oErro
3207:             MsgErro(loc_oErro.Message, "FormCargo.ValidarCategoriaGrade")
3208:         ENDTRY
3209: 
3210:         IF USED("cursor_4c_BuscaCtg")
3211:             USE IN cursor_4c_BuscaCtg
3212:         ENDIF
3213:     ENDPROC
3214: 
3215:     *--------------------------------------------------------------------------
3216:     * ValidarAcomis - Valida que o percentual de comissao nao eh negativo
3217:     *--------------------------------------------------------------------------
3218:     PROCEDURE ValidarAcomis(par_nKeyCode, par_nShiftAltCtrl)
3219:         LOCAL loc_oPg2
3220:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
3221: 
3222:         TRY
3223:             IF loc_oPg2.txt_4c_Acomis.Value < 0
3224:                 MsgAviso("O percentual de comiss" + CHR(227) + "o n" + CHR(227) + "o pode ser negativo.", "Aten" + CHR(231) + CHR(227) + "o")
3225:                 loc_oPg2.txt_4c_Acomis.Value = 0
3226:                 loc_oPg2.txt_4c_Acomis.SetFocus()
3227:             ENDIF
3228:         CATCH TO loc_oErro
3229:             MsgErro(loc_oErro.Message, "FormCargo.ValidarAcomis")
3230:         ENDTRY
3231:     ENDPROC
3232: 
3233:     *--------------------------------------------------------------------------
3234:     * ValidarTipoCategoria - Lookup Tipo na grade de categorias via F4/F5
3235:     *--------------------------------------------------------------------------
3236:     PROCEDURE ValidarTipoCategoria(par_nKeyCode, par_nShiftAltCtrl)
3237:         IF !INLIST(par_nKeyCode, 13, 9, 115, 116)
3238:             RETURN
3239:         ENDIF
3240: 
3241:         IF !INLIST(par_nKeyCode, 115, 116)
3242:             RETURN
3243:         ENDIF
3244: 
3245:         LOCAL loc_oGridCat, loc_cValor, loc_oBusca
3246:         loc_oGridCat = THIS.pgf_4c_Paginas.Page2.grd_4c_Categorias
3247:         loc_cValor   = ALLTRIM(loc_oGridCat.Column3.Text1.Value)
3248: 
3249:         TRY
3250:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
3251:                 "sigcarct", "cursor_4c_BuscaTipo", "tipo", loc_cValor, ;
3252:                 "Tipo de Categoria")
3253: 
3254:             IF VARTYPE(loc_oBusca) = "O"
3255:                 IF !loc_oBusca.this_lAchouRegistro
3256:                     loc_oBusca.mAddColuna("tipo", "", "Tipo")
3257:                     loc_oBusca.Show()
3258:                 ENDIF
3259: 
3260:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaTipo")
3261:                     SELECT cursor_4c_BuscaTipo
3262:                     REPLACE tipo WITH ALLTRIM(cursor_4c_BuscaTipo.tipo) ;
3263:                         IN cursor_4c_Categorias
3264:                     loc_oGridCat.Column3.Text1.Value = ALLTRIM(cursor_4c_BuscaTipo.tipo)
3265:                     loc_oGridCat.Refresh
3266:                 ENDIF
3267: 
3268:                 loc_oBusca.Release()
3269:             ENDIF
3270:         CATCH TO loc_oErro
3271:             MsgErro(loc_oErro.Message, "FormCargo.ValidarTipoCategoria")
3272:         ENDTRY
3273: 
3274:         IF USED("cursor_4c_BuscaTipo")
3275:             USE IN cursor_4c_BuscaTipo
3276:         ENDIF
3277:     ENDPROC
3278: 
3279:     *--------------------------------------------------------------------------
3280:     * Destroy - Libera recursos e cursores
3281:     *--------------------------------------------------------------------------
3282:     PROCEDURE Destroy()
3283:         TRY
3284:             IF VARTYPE(THIS.this_oBusinessObject) = "O"
3285:                 THIS.this_oBusinessObject = .NULL.
3286:             ENDIF
3287:             IF USED("cursor_4c_AcessoFinan")
3288:                 USE IN cursor_4c_AcessoFinan
3289:             ENDIF
3290:             IF USED("cursor_4c_Categorias")
3291:                 USE IN cursor_4c_Categorias
3292:             ENDIF
3293:         CATCH TO loc_oErro
3294:             MsgErro(loc_oErro.Message, "FormCargo.Destroy")
3295:         ENDTRY
3296: 
3297:         DODEFAULT()
3298:     ENDPROC
3299: 
3300: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CargoBO.prg):
*====================================================================
* CargoBO.prg
*
* Business Object para Cargos
* Tabela principal: SIGCDCRG (ccargs PK)
* Sub-tabelas: SIGCRRCC (acesso financeiro), sigcarct (categorias)
* Herda de: BusinessBase
*====================================================================

DEFINE CLASS CargoBO AS BusinessBase

	*-- Propriedades da entidade (SIGCDCRG)
	this_cCcargs      = ""   && ccargs char(10)      - PK (codigo do cargo)
	this_cDcargs      = ""   && dcargs char(20)       - descricao
	this_nAcrepors    = 0    && acrepors numeric(9,2) - acrescimo %
	this_cAltcots     = ""   && altcots char(1)       - altera cotacao (S/N)
	this_nComis       = 0    && comis numeric(5,2)    - comissao %
	this_dDatatrans   = {}   && datatrans datetime    - data transacao (NULL)
	this_nDescpors    = 0    && descpors numeric(9,2) - desconto %
	this_nLimacres    = 0    && limacres numeric(11,2) - limite acrescimo (R$)
	this_nLimdescs    = 0    && limdescs numeric(11,2) - limite desconto (R$)
	this_cNivels      = ""   && nivels char(1)        - senha (S/N)
	this_nVarcots     = 0    && varcots numeric(5,2)  - variacao cotacao %
	this_cLimites     = ""   && limites char(1)       - libera limite (S/N)
	this_nAcomis      = 0    && acomis numeric(5,2)   - fator de comissao %
	this_cFcomis      = ""   && fcomis char(1)        - tipo comissao S/N
	this_cCancitens   = ""   && cancitens char(1)     - cancela item cupom fiscal (S/N)
	this_nVllibpgs    = 0    && vllibpgs numeric(11,2) - valor liberar pagamentos (R$)
	this_cLibfpags    = ""   && libfpags char(1)      - excluir cond. pagto ecf (S/N)
	this_cLibsdins    = ""   && libsdins char(1)      - libera saldo insuficiente (S/N)
	this_nVllibcots   = 0    && vllibcots numeric(11,2) - valor liberar cotacoes (R$)
	this_nVllibopes   = 0    && vllibopes numeric(11,2) - valor liberar movimentacoes (R$)
	this_cLibfpgs     = ""   && libfpgs char(1)       - libera condicao pagto (S/N)
	this_cLibopes     = ""   && libopes char(1)       - liberar movim. estoque (S/N)
	this_cGrcomis     = ""   && grcomis char(10)      - grupo financeiro
	this_nTpcomis     = 0    && tpcomis numeric(1,0)  - tipo comissao (OptionGroup)
	this_nLibleilaos  = 0    && libleilaos numeric(1,0) - libera leilao (OptionGroup)
	this_nLibdupends  = 0    && libdupends numeric(1,0) - libera duplicidade (OptionGroup)
	this_nLibduptits  = 0    && libduptits numeric(1,0) - liberar titulos iguais (OptionGroup)
	this_nLibprzes    = 0    && libprzes numeric(1,0) - liberar prazo entrega (OptionGroup)
	this_nLibsldtqe   = 0    && libsldtqe numeric(1,0) - libera saldo cotacao (OptionGroup)
	this_cLibaltcli   = ""   && libaltcli char(1)     - libera alterar cliente (S/N)
	this_cLibexprd    = ""   && libexprd char(1)      - libera excluir mov. producao (S/N)
	this_nCustoprod   = 0    && custoprod numeric(1,0) - custo producao (OptionGroup)
	this_cLibvmovdup  = ""   && libvmovdup char(1)    - liberar variacao mov dupla (S/N)
	this_nVarmovdup   = 0    && varmovdup numeric(5,2) - variacao mov dupla %
	this_cLibopers    = ""   && libopers char(1)      - liberar operacoes (S/N)
	this_cLibvarpeso  = ""   && libvarpeso char(1)    - liberar variacao peso (S/N)
	this_nLibmultvends = 0   && libmultvends numeric(1,0) - libera multi-vendas (OptionGroup)
	this_nAltvlpro    = 0    && altvlpro numeric(1,0) - altera valor producao (OptionGroup)

	*-- Colunas adicionais presentes no banco (nao no schema dump inicial)
	this_cConsSubn    = ""   && ConsSubn char(1)      - libera consulta todos subniveis (S/N)
	this_nLibValmmax  = 0    && libValMMax numeric(1,0) - libera valor max malote (OptionGroup)

	*====================================================================
	* Init - Inicializa Business Object
	*====================================================================
	PROCEDURE Init()
		DODEFAULT()
		THIS.this_cTabela     = "SIGCDCRG"
		THIS.this_cCampoChave = "ccargs"
		RETURN .T.
	ENDPROC

	*====================================================================
	* ObterChavePrimaria - Retorna chave primaria para auditoria
	*====================================================================
	PROTECTED PROCEDURE ObterChavePrimaria()
		RETURN ALLTRIM(THIS.this_cCcargs)
	ENDPROC

	*====================================================================
	* Buscar - Carrega lista de cargos no cursor_4c_Dados
	*====================================================================
	PROCEDURE Buscar(par_cFiltro)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF EMPTY(par_cFiltro)
				loc_cSQL = "SELECT ccargs, dcargs FROM SIGCDCRG ORDER BY ccargs"
			ELSE
				loc_cSQL = "SELECT ccargs, dcargs FROM SIGCDCRG" + ;
				           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(par_cFiltro)) + ;
				           " ORDER BY ccargs"
			ENDIF

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao buscar cargos:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao buscar cargos:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarPorCodigo - Carrega um registro pelo codigo (PK)
	*====================================================================
	PROCEDURE CarregarPorCodigo(par_cCcargs)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "SELECT acrepors, altcots, ccargs, comis, datatrans," + ;
			           " dcargs, descpors, limacres, limdescs, nivels, varcots," + ;
			           " limites, acomis, fcomis, cancitens, vllibpgs, libfpags," + ;
			           " libsdins, vllibcots, vllibopes, libfpgs, libopes, grcomis," + ;
			           " tpcomis, libleilaos, libdupends, libduptits, libprzes," + ;
			           " libsldtqe, libaltcli, libexprd, custoprod, libvmovdup," + ;
			           " varmovdup, libopers, libvarpeso, libmultvends, altvlpro" + ;
			           " FROM SIGCDCRG" + ;
			           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(par_cCcargs))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")
			IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
				loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
				THIS.this_lNovoRegistro = .F.
				IF loc_lSucesso
					THIS.CarregarSubTabelaAcessoFinan(par_cCcargs)
					THIS.CarregarSubTabelaCategorias(par_cCcargs)
				ENDIF
			ENDIF

			IF USED("cursor_4c_Carrega")
				USE IN cursor_4c_Carrega
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar cargo:" + CHR(13) + loc_oErro.Message, "Erro")
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
			THIS.this_cCcargs       = TratarNulo(ccargs, "C")
			THIS.this_cDcargs       = TratarNulo(dcargs, "C")
			THIS.this_nAcrepors     = TratarNulo(acrepors, "N")
			THIS.this_cAltcots      = TratarNulo(altcots, "C")
			THIS.this_nComis        = TratarNulo(comis, "N")
			THIS.this_nDescpors     = TratarNulo(descpors, "N")
			THIS.this_nLimacres     = TratarNulo(limacres, "N")
			THIS.this_nLimdescs     = TratarNulo(limdescs, "N")
			THIS.this_cNivels       = TratarNulo(nivels, "C")
			THIS.this_nVarcots      = TratarNulo(varcots, "N")
			THIS.this_cLimites      = TratarNulo(limites, "C")
			THIS.this_nAcomis       = TratarNulo(acomis, "N")
			THIS.this_cFcomis       = TratarNulo(fcomis, "C")
			THIS.this_cCancitens    = TratarNulo(cancitens, "C")
			THIS.this_nVllibpgs     = TratarNulo(vllibpgs, "N")
			THIS.this_cLibfpags     = TratarNulo(libfpags, "C")
			THIS.this_cLibsdins     = TratarNulo(libsdins, "C")
			THIS.this_nVllibcots    = TratarNulo(vllibcots, "N")
			THIS.this_nVllibopes    = TratarNulo(vllibopes, "N")
			THIS.this_cLibfpgs      = TratarNulo(libfpgs, "C")
			THIS.this_cLibopes      = TratarNulo(libopes, "C")
			THIS.this_cGrcomis      = TratarNulo(grcomis, "C")
			THIS.this_nTpcomis      = TratarNulo(tpcomis, "N")
			THIS.this_nLibleilaos   = TratarNulo(libleilaos, "N")
			THIS.this_nLibdupends   = TratarNulo(libdupends, "N")
			THIS.this_nLibduptits   = TratarNulo(libduptits, "N")
			THIS.this_nLibprzes     = TratarNulo(libprzes, "N")
			THIS.this_nLibsldtqe    = TratarNulo(libsldtqe, "N")
			THIS.this_cLibaltcli    = TratarNulo(libaltcli, "C")
			THIS.this_cLibexprd     = TratarNulo(libexprd, "C")
			THIS.this_nCustoprod    = TratarNulo(custoprod, "N")
			THIS.this_cLibvmovdup   = TratarNulo(libvmovdup, "C")
			THIS.this_nVarmovdup    = TratarNulo(varmovdup, "N")
			THIS.this_cLibopers     = TratarNulo(libopers, "C")
			THIS.this_cLibvarpeso   = TratarNulo(libvarpeso, "C")
			THIS.this_nLibmultvends = TratarNulo(libmultvends, "N")
			THIS.this_nAltvlpro     = TratarNulo(altvlpro, "N")
			loc_lSucesso = .T.
		ENDIF

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarSubTabelaAcessoFinan - Carrega acesso financeiro (SIGCRRCC)
	*====================================================================
	PROCEDURE CarregarSubTabelaAcessoFinan(par_cCcargs)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_AcessoFinan")
				USE IN cursor_4c_AcessoFinan
			ENDIF

			loc_cSQL = "SELECT grupos, contas, valors, moedas FROM SIGCRRCC" + ;
			           " WHERE RTRIM(cargos) = " + EscaparSQL(ALLTRIM(par_cCcargs)) + ;
			           " ORDER BY grupos, contas"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcessoFinan")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao carregar acesso financeiro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar acesso financeiro:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* CarregarSubTabelaCategorias - Carrega categorias (sigcarct + sigcdctg)
	*====================================================================
	PROCEDURE CarregarSubTabelaCategorias(par_cCcargs)
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			IF USED("cursor_4c_Categorias")
				USE IN cursor_4c_Categorias
			ENDIF

			loc_cSQL = "SELECT a.categoria, ISNULL(b.descs, '') AS descs, a.tipo, a.cargo" + ;
			           " FROM sigcarct a" + ;
			           " LEFT JOIN sigcdctg b ON RTRIM(b.cods) = RTRIM(a.categoria)" + ;
			           " WHERE RTRIM(a.cargo) = " + EscaparSQL(ALLTRIM(par_cCcargs)) + ;
			           " ORDER BY a.categoria"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Categorias")
			IF loc_nResultado >= 0
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao carregar categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao carregar categorias:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* InicializarCursoresGrid - Cria cursores vazios para grids em INCLUIR
	*====================================================================
	PROCEDURE InicializarCursoresGrid()
		IF USED("cursor_4c_AcessoFinan")
			USE IN cursor_4c_AcessoFinan
		ENDIF
		SET NULL ON
		CREATE CURSOR cursor_4c_AcessoFinan (grupos C(10), contas C(10), valors N(13,2), moedas C(3))
		SET NULL OFF

		IF USED("cursor_4c_Categorias")
			USE IN cursor_4c_Categorias
		ENDIF
		SET NULL ON
		CREATE CURSOR cursor_4c_Categorias (categoria C(6), descs C(30), tipo C(10), cargo C(10))
		SET NULL OFF
	ENDPROC

	*====================================================================
	* SalvarSubTabelaAcessoFinan - Salva acesso financeiro (SIGCRRCC)
	*====================================================================
	PROTECTED PROCEDURE SalvarSubTabelaAcessoFinan()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cCidchaves
		loc_lSucesso = .F.

		TRY
			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
			loc_cSQL = "DELETE FROM SIGCRRCC WHERE RTRIM(cargos) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				MsgErro("Erro ao excluir acesso financeiro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.
				IF USED("cursor_4c_AcessoFinan") AND RECCOUNT("cursor_4c_AcessoFinan") > 0
					GO TOP IN cursor_4c_AcessoFinan
					SELECT cursor_4c_AcessoFinan
					SCAN
						IF !EMPTY(ALLTRIM(cursor_4c_AcessoFinan.grupos)) .OR. ;
						   !EMPTY(ALLTRIM(cursor_4c_AcessoFinan.contas))
							loc_cCidchaves = LEFT(fUniqueIds(), 20)
							loc_cSQL = "INSERT INTO SIGCRRCC (cargos, cidchaves, grupos, contas, valors, moedas)" + ;
							           " VALUES (" + ;
							           EscaparSQL(THIS.this_cCcargs) + "," + ;
							           EscaparSQL(loc_cCidchaves) + "," + ;
							           EscaparSQL(cursor_4c_AcessoFinan.grupos) + "," + ;
							           EscaparSQL(cursor_4c_AcessoFinan.contas) + "," + ;
							           FormatarNumeroSQL(cursor_4c_AcessoFinan.valors) + "," + ;
							           EscaparSQL(cursor_4c_AcessoFinan.moedas) + ;
							           ")"
							IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
								loc_lSucesso = .F.
								MsgErro("Erro ao inserir acesso financeiro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
								EXIT
							ENDIF
						ENDIF
					ENDSCAN
				ENDIF
			ENDIF

			IF loc_lSucesso
				SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
			ELSE
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro ao salvar acesso financeiro:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* SalvarSubTabelaCategorias - Salva categorias (sigcarct)
	*====================================================================
	PROTECTED PROCEDURE SalvarSubTabelaCategorias()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso, loc_cPkChave
		loc_lSucesso = .F.

		TRY
			SQLEXEC(gnConnHandle, "BEGIN TRANSACTION")
			loc_cSQL = "DELETE FROM sigcarct WHERE RTRIM(cargo) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				MsgErro("Erro ao excluir categorias:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				loc_lSucesso = .T.
				IF USED("cursor_4c_Categorias") AND RECCOUNT("cursor_4c_Categorias") > 0
					GO TOP IN cursor_4c_Categorias
					SELECT cursor_4c_Categorias
					SCAN
						IF !EMPTY(ALLTRIM(cursor_4c_Categorias.categoria))
							loc_cPkChave = LEFT(fUniqueIds(), 20)
							loc_cSQL = "INSERT INTO sigcarct (categoria, pkchave, tipo, cargo)" + ;
							           " VALUES (" + ;
							           EscaparSQL(LEFT(ALLTRIM(cursor_4c_Categorias.categoria), 6)) + "," + ;
							           EscaparSQL(loc_cPkChave) + "," + ;
							           EscaparSQL(LEFT(ALLTRIM(cursor_4c_Categorias.tipo), 10)) + "," + ;
							           EscaparSQL(THIS.this_cCcargs) + ;
							           ")"
							IF SQLEXEC(gnConnHandle, loc_cSQL) < 0
								loc_lSucesso = .F.
								MsgErro("Erro ao inserir categoria:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
								EXIT
							ENDIF
						ENDIF
					ENDSCAN
				ENDIF
			ENDIF

			IF loc_lSucesso
				SQLEXEC(gnConnHandle, "COMMIT TRANSACTION")
			ELSE
				SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			ENDIF
		CATCH TO loc_oErro
			SQLEXEC(gnConnHandle, "ROLLBACK TRANSACTION")
			MsgErro("Erro ao salvar categorias:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Inserir - INSERT na tabela SIGCDCRG + sub-tabelas
	*====================================================================
	PROTECTED PROCEDURE Inserir()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "INSERT INTO SIGCDCRG" + ;
			           " (ccargs, dcargs, acrepors, altcots, comis," + ;
			           " descpors, limacres, limdescs, nivels, varcots," + ;
			           " limites, acomis, fcomis, cancitens, vllibpgs," + ;
			           " libfpags, libsdins, vllibcots, vllibopes, libfpgs," + ;
			           " libopes, grcomis, tpcomis, libleilaos, libdupends," + ;
			           " libduptits, libprzes, libsldtqe, libaltcli, libexprd," + ;
			           " custoprod, libvmovdup, varmovdup, libopers, libvarpeso," + ;
			           " libmultvends, altvlpro, ConsSubn, libValMMax)" + ;
			           " VALUES (" + ;
			           EscaparSQL(THIS.this_cCcargs) + "," + ;
			           EscaparSQL(THIS.this_cDcargs) + "," + ;
			           FormatarNumeroSQL(THIS.this_nAcrepors) + "," + ;
			           EscaparSQL(THIS.this_cAltcots) + "," + ;
			           FormatarNumeroSQL(THIS.this_nComis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nDescpors) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLimacres) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLimdescs) + "," + ;
			           EscaparSQL(THIS.this_cNivels) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVarcots) + "," + ;
			           EscaparSQL(THIS.this_cLimites) + "," + ;
			           FormatarNumeroSQL(THIS.this_nAcomis) + "," + ;
			           EscaparSQL(THIS.this_cFcomis) + "," + ;
			           EscaparSQL(THIS.this_cCancitens) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVllibpgs) + "," + ;
			           EscaparSQL(THIS.this_cLibfpags) + "," + ;
			           EscaparSQL(THIS.this_cLibsdins) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVllibcots) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVllibopes) + "," + ;
			           EscaparSQL(THIS.this_cLibfpgs) + "," + ;
			           EscaparSQL(THIS.this_cLibopes) + "," + ;
			           EscaparSQL(THIS.this_cGrcomis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nTpcomis) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibleilaos) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibdupends) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibduptits) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibprzes) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibsldtqe) + "," + ;
			           EscaparSQL(THIS.this_cLibaltcli) + "," + ;
			           EscaparSQL(THIS.this_cLibexprd) + "," + ;
			           FormatarNumeroSQL(THIS.this_nCustoprod) + "," + ;
			           EscaparSQL(THIS.this_cLibvmovdup) + "," + ;
			           FormatarNumeroSQL(THIS.this_nVarmovdup) + "," + ;
			           EscaparSQL(THIS.this_cLibopers) + "," + ;
			           EscaparSQL(THIS.this_cLibvarpeso) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibmultvends) + "," + ;
			           FormatarNumeroSQL(THIS.this_nAltvlpro) + "," + ;
			           EscaparSQL(THIS.this_cConsSubn) + "," + ;
			           FormatarNumeroSQL(THIS.this_nLibValmmax) + ;
			           ")"

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("INSERT")
				THIS.SalvarSubTabelaAcessoFinan()
				THIS.SalvarSubTabelaCategorias()
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao inserir cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao inserir cargo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* Atualizar - UPDATE na tabela SIGCDCRG + sub-tabelas
	*====================================================================
	PROTECTED PROCEDURE Atualizar()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			loc_cSQL = "UPDATE SIGCDCRG SET" + ;
			           " dcargs = " + EscaparSQL(THIS.this_cDcargs) + "," + ;
			           " acrepors = " + FormatarNumeroSQL(THIS.this_nAcrepors) + "," + ;
			           " altcots = " + EscaparSQL(THIS.this_cAltcots) + "," + ;
			           " comis = " + FormatarNumeroSQL(THIS.this_nComis) + "," + ;
			           " descpors = " + FormatarNumeroSQL(THIS.this_nDescpors) + "," + ;
			           " limacres = " + FormatarNumeroSQL(THIS.this_nLimacres) + "," + ;
			           " limdescs = " + FormatarNumeroSQL(THIS.this_nLimdescs) + "," + ;
			           " nivels = " + EscaparSQL(THIS.this_cNivels) + "," + ;
			           " varcots = " + FormatarNumeroSQL(THIS.this_nVarcots) + "," + ;
			           " limites = " + EscaparSQL(THIS.this_cLimites) + "," + ;
			           " acomis = " + FormatarNumeroSQL(THIS.this_nAcomis) + "," + ;
			           " fcomis = " + EscaparSQL(THIS.this_cFcomis) + "," + ;
			           " cancitens = " + EscaparSQL(THIS.this_cCancitens) + "," + ;
			           " vllibpgs = " + FormatarNumeroSQL(THIS.this_nVllibpgs) + "," + ;
			           " libfpags = " + EscaparSQL(THIS.this_cLibfpags) + "," + ;
			           " libsdins = " + EscaparSQL(THIS.this_cLibsdins) + "," + ;
			           " vllibcots = " + FormatarNumeroSQL(THIS.this_nVllibcots) + "," + ;
			           " vllibopes = " + FormatarNumeroSQL(THIS.this_nVllibopes) + "," + ;
			           " libfpgs = " + EscaparSQL(THIS.this_cLibfpgs) + "," + ;
			           " libopes = " + EscaparSQL(THIS.this_cLibopes) + "," + ;
			           " grcomis = " + EscaparSQL(THIS.this_cGrcomis) + "," + ;
			           " tpcomis = " + FormatarNumeroSQL(THIS.this_nTpcomis) + "," + ;
			           " libleilaos = " + FormatarNumeroSQL(THIS.this_nLibleilaos) + "," + ;
			           " libdupends = " + FormatarNumeroSQL(THIS.this_nLibdupends) + "," + ;
			           " libduptits = " + FormatarNumeroSQL(THIS.this_nLibduptits) + "," + ;
			           " libprzes = " + FormatarNumeroSQL(THIS.this_nLibprzes) + "," + ;
			           " libsldtqe = " + FormatarNumeroSQL(THIS.this_nLibsldtqe) + "," + ;
			           " libaltcli = " + EscaparSQL(THIS.this_cLibaltcli) + "," + ;
			           " libexprd = " + EscaparSQL(THIS.this_cLibexprd) + "," + ;
			           " custoprod = " + FormatarNumeroSQL(THIS.this_nCustoprod) + "," + ;
			           " libvmovdup = " + EscaparSQL(THIS.this_cLibvmovdup) + "," + ;
			           " varmovdup = " + FormatarNumeroSQL(THIS.this_nVarmovdup) + "," + ;
			           " libopers = " + EscaparSQL(THIS.this_cLibopers) + "," + ;
			           " libvarpeso = " + EscaparSQL(THIS.this_cLibvarpeso) + "," + ;
			           " libmultvends = " + FormatarNumeroSQL(THIS.this_nLibmultvends) + "," + ;
			           " altvlpro = " + FormatarNumeroSQL(THIS.this_nAltvlpro) + "," + ;
			           " ConsSubn = " + EscaparSQL(THIS.this_cConsSubn) + "," + ;
			           " libValMMax = " + FormatarNumeroSQL(THIS.this_nLibValmmax) + ;
			           " WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))

			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado >= 0
				THIS.RegistrarAuditoria("UPDATE")
				THIS.SalvarSubTabelaAcessoFinan()
				THIS.SalvarSubTabelaCategorias()
				loc_lSucesso = .T.
			ELSE
				MsgErro("Erro ao atualizar cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao atualizar cargo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

	*====================================================================
	* ExecutarExclusao - DELETE SIGCRRCC + sigcarct + SIGCDCRG
	*====================================================================
	PROTECTED PROCEDURE ExecutarExclusao()
		LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
		loc_lSucesso = .F.

		TRY
			*-- 1. Excluir acesso financeiro (SIGCRRCC)
			loc_cSQL = "DELETE FROM SIGCRRCC WHERE RTRIM(cargos) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
			loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
			IF loc_nResultado < 0
				MsgErro("Erro ao excluir acesso financeiro do cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
			ELSE
				*-- 2. Excluir categorias (sigcarct)
				loc_cSQL = "DELETE FROM sigcarct WHERE RTRIM(cargo) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
				loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
				IF loc_nResultado < 0
					MsgErro("Erro ao excluir categorias do cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
				ELSE
					*-- 3. Excluir registro principal (SIGCDCRG)
					loc_cSQL = "DELETE FROM SIGCDCRG WHERE RTRIM(ccargs) = " + EscaparSQL(ALLTRIM(THIS.this_cCcargs))
					loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
					IF loc_nResultado >= 0
						THIS.RegistrarAuditoria("DELETE")
						loc_lSucesso = .T.
					ELSE
						MsgErro("Erro ao excluir cargo:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
					ENDIF
				ENDIF
			ENDIF
		CATCH TO loc_oErro
			MsgErro("Erro ao excluir cargo:" + CHR(13) + loc_oErro.Message, "Erro")
		ENDTRY

		RETURN loc_lSucesso
	ENDPROC

ENDDEFINE

