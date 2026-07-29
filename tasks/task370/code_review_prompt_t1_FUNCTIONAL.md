# CODE REVIEW - PASS FUNCTIONAL: Functional Logic (metodos, eventos, containers)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Functional Logic (metodos, eventos, containers)**.

## PROBLEMAS DETECTADOS (10)
- [CARGA-DADOS] OptionGroup 'opt_4c_EnvRecs' NAO tem BINDEVENT para InteractiveChange. Se este OptionGroup afeta filtro de dados (ex: Global/Positivos/Negativos), DEVE ter InteractiveChange que recarrega a grade.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, A, , Grupo, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, A, , Grupo, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Local A' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, A, , Grupo, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Local B' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, A, , Grupo, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Código' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, A, , Grupo, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Empresa' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, A, , Grupo, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Local A' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, A, , Grupo, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [GRID-HEADER] Header Caption 'Local B' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: Emp, Local, Operação, Grupo Origem, Conta Origem, Grupo Destino, Conta Destino, A, , Grupo, Conta. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'optDigitos' (parent: SIGCDCLC.Pagina.Dados.cntCodigos): Left original=642 vs migrado 'obj_4c_OptDigitos' Left=1 (diff=641px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormCLC.prg) - TRECHOS RELEVANTES PARA PASS FUNCTIONAL (2766 linhas total):

*-- Linhas 10 a 163:
10: * FASE 4/8: Grid Lista + botoes CRUD na Page1 [OK]
11: * FASE 5/8: cntCodigos + cntLocalA + cntLocalB na Page2 [OK]
12: * FASE 6/8: pgComplementos (pgOpeGerA + pgEstoques) na Page2 [OK]
13: * FASE 7/8: Eventos CRUD principais + BINDEVENTs + lookups [OK]
14: * FASE 8/8: Validacoes e metodos de dados completos [OK]
15: * FASE 9/9: BINDEVENTs Check1 KeyPress/MouseDown + ReadOnly colunas Estoque A/B [OK]
16: *===============================================================================
17: 
18: DEFINE CLASS FormCLC AS FormBase
19: 
20:     *-- Propriedades visuais (PILAR 1 - UX FIDELITY)
21:     Height      = 600
22:     Width       = 1000
23:     Caption     = "Cadastro de Comparativos Entre Locais"
24:     AutoCenter  = .T.
25:     ShowWindow  = 1
26:     WindowType  = 1
27:     ControlBox  = .F.
28:     Closable    = .F.
29:     MaxButton   = .F.
30:     TitleBar    = 0
31:     Themes      = .F.
32:     BorderStyle = 2
33: 
34:     *-- Propriedades de estado
35:     this_oBusinessObject = .NULL.
36:     this_cModoAtual      = "LISTA"
37:     this_lEstoqueBound   = .F.
38:     this_lOpeBound       = .F.
39: 
40:     *--------------------------------------------------------------------------
41:     * Init - APENAS retorna DODEFAULT (FormBase.Init chama InicializarForm)
42:     *--------------------------------------------------------------------------
43:     PROCEDURE Init()
44:         LOCAL loc_lResultado
45:         loc_lResultado = .F.
46: 
47:         TRY
48:             loc_lResultado = DODEFAULT()
49:         CATCH TO loc_oErro
50:             MsgErro(loc_oErro.Message, "FormCLC.Init")
51:         ENDTRY
52: 
53:         RETURN loc_lResultado
54:     ENDPROC
55: 
56:     *--------------------------------------------------------------------------
57:     * InicializarForm - Configura estrutura completa (chamado pelo FormBase)
58:     *--------------------------------------------------------------------------
59:     PROTECTED PROCEDURE InicializarForm()
60:         LOCAL loc_lResultado
61:         loc_lResultado = .F.
62: 
63:         TRY
64:             THIS.this_oBusinessObject = CREATEOBJECT("CLCBO")
65: 
66:             IF VARTYPE(THIS.this_oBusinessObject) != "O"
67:                 MsgErro("Falha ao criar CLCBO", "Erro")
68:             ELSE
69:                 THIS.ConfigurarPageFrame()
70: 
71:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
72:                 THIS.pgf_4c_Paginas.Page1.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
73: 
74:                 IF TYPE("gb_4c_ValidandoUI") != "L" OR !gb_4c_ValidandoUI
75:                     THIS.CarregarLista()
76:                 ENDIF
77: 
78:                 THIS.pgf_4c_Paginas.Visible  = .T.
79:                 THIS.pgf_4c_Paginas.ActivePage = 1
80:                 THIS.this_cModoAtual = "LISTA"
81:                 loc_lResultado = .T.
82:             ENDIF
83:         CATCH TO loc_oErro
84:             MsgErro(loc_oErro.Message, "FormCLC.InicializarForm")
85:         ENDTRY
86: 
87:         RETURN loc_lResultado
88:     ENDPROC
89: 
90:     *--------------------------------------------------------------------------
91:     * ConfigurarPageFrame - Cria PageFrame com Page1 (Lista) e Page2 (Dados)
92:     *--------------------------------------------------------------------------
93:     PROTECTED PROCEDURE ConfigurarPageFrame()
94:         LOCAL loc_oPgf
95:         THIS.AddObject("pgf_4c_Paginas", "PageFrame")
96:         loc_oPgf = THIS.pgf_4c_Paginas
97: 
98:         WITH loc_oPgf
99:             .PageCount       = 2
100:             .Top             = -29
101:             .Left            = 0
102:             .Width           = THIS.Width
103:             .Height          = THIS.Height + 29
104:             .Tabs            = .F.
105:             .Visible         = .T.
106:             .Page1.Caption   = "Lista"
107:             .Page1.BackColor = RGB(100, 100, 100)
108:             .Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
109:             .Page2.Caption   = "Dados"
110:             .Page2.BackColor = RGB(100, 100, 100)
111:             .Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
112:         ENDWITH
113: 
114:         THIS.ConfigurarPaginaLista()
115:         THIS.ConfigurarPaginaDados()
116:     ENDPROC
117: 
118:     *--------------------------------------------------------------------------
119:     * ConfigurarPaginaLista - Page1: cabecalho + containers base
120:     * FASE 3: Cabecalho + Saida
121:     * FASE 4: Botoes CRUD + Grid Lista
122:     *--------------------------------------------------------------------------
123:     PROTECTED PROCEDURE ConfigurarPaginaLista()
124:         LOCAL loc_oPg1, loc_oCab, loc_oBotoes, loc_oSaida
125:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
126: 
127:         *-- Cabecalho cinza escuro
128:         loc_oPg1.AddObject("cnt_4c_Cabecalho", "Container")
129:         loc_oCab = loc_oPg1.cnt_4c_Cabecalho
130:         WITH loc_oCab
131:             .Top         = 31
132:             .Left        = 0
133:             .Width       = THIS.Width
134:             .Height      = 80
135:             .BackColor   = RGB(100, 100, 100)
136:             .BorderWidth = 0
137:             .Visible     = .T.
138:         ENDWITH
139: 
140:         loc_oCab.AddObject("lbl_4c_Sombra", "Label")
141:         WITH loc_oCab.lbl_4c_Sombra
142:             .AutoSize  = .F.
143:             .Caption   = THIS.Caption
144:             .Top       = 15
145:             .Left      = 10
146:             .Width     = THIS.Width
147:             .Height    = 40
148:             .FontName  = "Tahoma"
149:             .FontSize  = 16
150:             .FontBold  = .T.
151:             .ForeColor = RGB(0, 0, 0)
152:             .BackStyle = 0
153:             .Visible   = .T.
154:         ENDWITH
155: 
156:         loc_oCab.AddObject("lbl_4c_Titulo", "Label")
157:         WITH loc_oCab.lbl_4c_Titulo
158:             .AutoSize  = .F.
159:             .Caption   = THIS.Caption
160:             .Top       = 18
161:             .Left      = 10
162:             .Width     = THIS.Width
163:             .Height    = 46

*-- Linhas 298 a 434:
298:             .Visible         = .T.
299:         ENDWITH
300: 
301:         BINDEVENT(loc_oBotoes.cmd_4c_Incluir,    "Click", THIS, "BtnIncluirClick")
302:         BINDEVENT(loc_oBotoes.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
303:         BINDEVENT(loc_oBotoes.cmd_4c_Alterar,    "Click", THIS, "BtnAlterarClick")
304:         BINDEVENT(loc_oBotoes.cmd_4c_Excluir,    "Click", THIS, "BtnExcluirClick")
305:         BINDEVENT(loc_oBotoes.cmd_4c_Buscar,     "Click", THIS, "BtnBuscarClick")
306: 
307:         *-- Container Encerrar (canonico: Left=917, Width=90)
308:         loc_oPg1.AddObject("cnt_4c_Saida", "Container")
309:         loc_oSaida = loc_oPg1.cnt_4c_Saida
310:         WITH loc_oSaida
311:             .Top         = 29
312:             .Left        = 917
313:             .Width       = 90
314:             .Height      = 85
315:             .BackStyle   = 0
316:             .BorderWidth = 0
317:             .Visible     = .T.
318:         ENDWITH
319: 
320:         loc_oSaida.AddObject("cmd_4c_Encerrar", "CommandButton")
321:         WITH loc_oSaida.cmd_4c_Encerrar
322:             .Caption         = "Encerrar"
323:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
324:             .PicturePosition = 13
325:             .Top             = 5
326:             .Left            = 5
327:             .Width           = 75
328:             .Height          = 75
329:             .BackColor       = RGB(255, 255, 255)
330:             .ForeColor       = RGB(90, 90, 90)
331:             .FontName        = "Comic Sans MS"
332:             .FontSize        = 8
333:             .FontBold        = .T.
334:             .FontItalic      = .T.
335:             .Themes          = .F.
336:             .SpecialEffect   = 0
337:             .MousePointer    = 15
338:             .WordWrap        = .T.
339:             .AutoSize        = .F.
340:             .Visible         = .T.
341:         ENDWITH
342: 
343:         BINDEVENT(loc_oSaida.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
344: 
345:         *-- Grid Lista (Top=117 = 88+29 compensacao PageFrame)
346:         loc_oPg1.AddObject("grd_4c_Lista", "Grid")
347:         loc_oPg1.grd_4c_Lista.ColumnCount = 3
348:         loc_oPg1.grd_4c_Lista.RecordSource = "cursor_4c_Dados"
349:         loc_oPg1.grd_4c_Lista.ColumnCount  = 4
350:         WITH loc_oPg1.grd_4c_Lista
351:             .Top                = 117
352:             .Left               = 12
353:             .Width              = 940
354:             .Height             = 500
355:             .FontName           = "Verdana"
356:             .FontSize           = 8
357:             .ForeColor          = RGB(90, 90, 90)
358:             .BackColor          = RGB(255, 255, 255)
359:             .GridLineColor      = RGB(238, 238, 238)
360:             .HighlightBackColor = RGB(255, 255, 255)
361:             .HighlightForeColor = RGB(15, 41, 104)
362:             .HighlightStyle     = 2
363:             .DeleteMark         = .F.
364:             .RecordMark         = .F.
365:             .RowHeight          = 16
366:             .ScrollBars         = 2
367:             .GridLines          = 3
368:             .Visible            = .T.
369:             .Column1.ControlSource = "cursor_4c_Dados.Codigos"
370:             .Column2.ControlSource = "cursor_4c_Dados.Emps"
371:             .Column3.ControlSource = "cursor_4c_Dados.LocalA"
372:             .Column4.ControlSource = "cursor_4c_Dados.LocalB"
373:             .Column1.Width = 150
374:             .Column2.Width = 70
375:             .Column3.Width = 150
376:             .Column4.Width = 150
377:             .Column1.Header1.Caption = "C" + CHR(243) + "digo"
378:             .Column2.Header1.Caption = "Empresa"
379:             .Column3.Header1.Caption = "Local A"
380:             .Column4.Header1.Caption = "Local B"
381:         ENDWITH
382: 
383:         BINDEVENT(loc_oPg1.grd_4c_Lista, "DblClick", THIS, "GridListaDblClick")
384: 
385:         THIS.TornarControlesVisiveis(loc_oPg1)
386:     ENDPROC
387: 
388:     *--------------------------------------------------------------------------
389:     * ConfigurarPaginaDados - Page2: botoes acao + containers de dados
390:     * FASE 3: BotoesAcao (Confirmar + Cancelar)
391:     * FASE 5: cntCodigos + cntLocalA + cntLocalB
392:     * FASE 6: pgComplementos (pgOpeGerA + pgEstoques)
393:     *--------------------------------------------------------------------------
394:     PROTECTED PROCEDURE ConfigurarPaginaDados()
395:         LOCAL loc_oPg2, loc_oBotoesAcao, loc_oCnt
396:         loc_oPg2 = THIS.pgf_4c_Paginas.Page2
397: 
398:         *-- Botoes Confirmar/Cancelar (canonico: Left=842, Width=160)
399:         loc_oPg2.AddObject("cnt_4c_BotoesAcao", "Container")
400:         loc_oBotoesAcao = loc_oPg2.cnt_4c_BotoesAcao
401:         WITH loc_oBotoesAcao
402:             .Top         = 33
403:             .Left        = 842
404:             .Width       = 160
405:             .Height      = 85
406:             .BackStyle   = 0
407:             .BorderWidth = 0
408:             .Visible     = .T.
409:         ENDWITH
410: 
411:         loc_oBotoesAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
412:         WITH loc_oBotoesAcao.cmd_4c_Confirmar
413:             .Caption         = "Confirmar"
414:             .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
415:             .PicturePosition = 13
416:             .Top             = 5
417:             .Left            = 5
418:             .Width           = 75
419:             .Height          = 75
420:             .BackColor       = RGB(255, 255, 255)
421:             .ForeColor       = RGB(90, 90, 90)
422:             .FontName        = "Comic Sans MS"
423:             .FontSize        = 8
424:             .FontBold        = .T.
425:             .FontItalic      = .T.
426:             .Themes          = .F.
427:             .SpecialEffect   = 0
428:             .MousePointer    = 15
429:             .WordWrap        = .T.
430:             .AutoSize        = .F.
431:             .Visible         = .T.
432:         ENDWITH
433: 
434:         loc_oBotoesAcao.AddObject("cmd_4c_Cancelar", "CommandButton")

*-- Linhas 454 a 498:
454:             .Visible         = .T.
455:         ENDWITH
456: 
457:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Confirmar, "Click", THIS, "BtnConfirmarClick")
458:         BINDEVENT(loc_oBotoesAcao.cmd_4c_Cancelar,  "Click", THIS, "BtnCancelarClick")
459: 
460:         *==========================================================================
461:         *-- FASE 5: cnt_4c_Codigos (top=138, left=25, width=740, height=59)
462:         *==========================================================================
463:         loc_oPg2.AddObject("cnt_4c_Codigos", "Container")
464:         loc_oCnt = loc_oPg2.cnt_4c_Codigos
465:         WITH loc_oCnt
466:             .Top         = 138
467:             .Left        = 25
468:             .Width       = 740
469:             .Height      = 59
470:             .BackStyle   = 0
471:             .BorderWidth = 0
472:             .Visible     = .T.
473:         ENDWITH
474: 
475:         loc_oCnt.AddObject("lbl_4c_LblCodigo", "Label")
476:         WITH loc_oCnt.lbl_4c_LblCodigo
477:             .AutoSize  = .F.
478:             .Caption   = "C" + CHR(243) + "digo :"
479:             .Top       = 9
480:             .Left      = 32
481:             .Width     = 50
482:             .Height    = 15
483:             .FontName  = "Tahoma"
484:             .FontSize  = 8
485:             .BackStyle = 0
486:             .Visible   = .T.
487:         ENDWITH
488: 
489:         loc_oCnt.AddObject("txt_4c_Codigos", "TextBox")
490:         WITH loc_oCnt.txt_4c_Codigos
491:             .Top       = 6
492:             .Left      = 84
493:             .Width     = 150
494:             .Height    = 23
495:             .FontName  = "Tahoma"
496:             .FontSize  = 8
497:             .Visible   = .T.
498:         ENDWITH

*-- Linhas 564 a 607:
564:             .Visible   = .T.
565:         ENDWITH
566: 
567:         loc_oCnt.AddObject("obj_4c_OptDigitos", "OptionGroup")
568:         WITH loc_oCnt.obj_4c_OptDigitos
569:             .ButtonCount = 3
570:             .Top         = 6
571:             .Left        = 642
572:             .Width       = 97
573:             .Height      = 22
574:             .Value       = 1
575:             .BackStyle   = 0
576:             .Visible     = .T.
577:             WITH .Buttons(1)
578:                 .Caption  = "1"
579:                 .Top      = 2
580:                 .Left     = 1
581:                 .Width    = 30
582:                 .Height   = 18
583:             ENDWITH
584:             WITH .Buttons(2)
585:                 .Caption  = "2"
586:                 .Top      = 2
587:                 .Left     = 32
588:                 .Width    = 30
589:                 .Height   = 18
590:                 .FontName = "Tahoma"
591:                 .FontSize = 8
592:             ENDWITH
593:             WITH .Buttons(3)
594:                 .Caption  = "3"
595:                 .Top      = 2
596:                 .Left     = 63
597:                 .Width    = 30
598:                 .Height   = 18
599:                 .FontName = "Tahoma"
600:                 .FontSize = 8
601:             ENDWITH
602:         ENDWITH
603: 
604:         loc_oCnt.AddObject("lbl_4c_LblAuto", "Label")
605:         WITH loc_oCnt.lbl_4c_LblAuto
606:             .AutoSize  = .F.
607:             .Caption   = "Autom" + CHR(225) + "tico :"

*-- Linhas 1234 a 1292:
1234:             .Visible   = .T.
1235:         ENDWITH
1236: 
1237:         *-- BINDEVENTs para lookups em campos de texto (F4)
1238:         BINDEVENT(loc_oPg2.cnt_4c_Codigos.txt_4c_Empresas,    "KeyPress", THIS, "EmpresasKeyPress")
1239:         BINDEVENT(loc_oPg2.cnt_4c_Codigos.txt_4c_Transitoria,  "KeyPress", THIS, "TransitoriaKeyPress")
1240:         BINDEVENT(loc_oPg2.cnt_4c_LocalA.txt_4c_LocalA,        "KeyPress", THIS, "LocalAKeyPress")
1241:         BINDEVENT(loc_oPg2.cnt_4c_LocalB.txt_4c_LocalB,        "KeyPress", THIS, "LocalBKeyPress")
1242: 
1243:         *-- PageFrame Complementos (Operacoes Gerenciais + Estoques)
1244:         THIS.ConfigurarComplementos(loc_oPg2)
1245: 
1246:         THIS.TornarControlesVisiveis(loc_oPg2)
1247:     ENDPROC
1248: 
1249:     *--------------------------------------------------------------------------
1250:     * ConfigurarComplementos - PageFrame interno em Page2 com Operacoes e Estoques
1251:     *--------------------------------------------------------------------------
1252:     PROTECTED PROCEDURE ConfigurarComplementos(par_oPg2)
1253:         LOCAL loc_oPgf, loc_oPg1C, loc_oPg2C, loc_oCmg, loc_oGrid
1254: 
1255:         par_oPg2.AddObject("pgf_4c_Complementos", "PageFrame")
1256:         loc_oPgf = par_oPg2.pgf_4c_Complementos
1257:         WITH loc_oPgf
1258:             .Top       = 337
1259:             .Left      = 23
1260:             .Width     = 743
1261:             .Height    = 230
1262:             .PageCount = 2
1263:             .Tabs      = .T.
1264:             .Visible   = .T.
1265:             .Page1.Caption   = "Opera" + CHR(231) + CHR(245) + "es Gerenciais"
1266:             .Page1.BackColor = RGB(240, 240, 240)
1267:             .Page2.Caption   = "Estoques"
1268:             .Page2.BackColor = RGB(240, 240, 240)
1269:         ENDWITH
1270: 
1271:         loc_oPg1C = loc_oPgf.Page1
1272:         loc_oPg2C = loc_oPgf.Page2
1273: 
1274:         *-- Page1: Grid de Operacoes Gerenciais (grdOpeGerA - 8 colunas)
1275:         loc_oPg1C.AddObject("grd_4c_OpeGerA", "Grid")
1276:         loc_oPg1C.grd_4c_OpeGerA.ColumnCount = 3
1277:         loc_oPg1C.grd_4c_OpeGerA.RecordSource = "cursor_4c_Operacoes"
1278:         loc_oPg1C.grd_4c_OpeGerA.ColumnCount  = 8
1279:         WITH loc_oPg1C.grd_4c_OpeGerA
1280:             .Top                = 10
1281:             .Left               = 8
1282:             .Width              = 723
1283:             .Height             = 122
1284:             .FontName           = "Verdana"
1285:             .FontSize           = 8
1286:             .BackColor          = RGB(255, 255, 255)
1287:             .GridLineColor      = RGB(238, 238, 238)
1288:             .HighlightBackColor = RGB(255, 255, 255)
1289:             .HighlightForeColor = RGB(15, 41, 104)
1290:             .HighlightStyle     = 2
1291:             .DeleteMark         = .F.
1292:             .RecordMark         = .F.

*-- Linhas 1321 a 1366:
1321:             .Column8.Sparse   = .F.
1322:             .Column8.ReadOnly = .F.
1323:         ENDWITH
1324: 
1325:         *-- OptionGroup optEnvRecs (direcao de movimentacao A->B ou B->A)
1326:         loc_oPg1C.AddObject("opt_4c_EnvRecs", "OptionGroup")
1327:         WITH loc_oPg1C.opt_4c_EnvRecs
1328:             .ButtonCount = 2
1329:             .Top         = 139
1330:             .Left        = 377
1331:             .Width       = 134
1332:             .Height      = 24
1333:             .Value       = 1
1334:             .BackStyle   = 0
1335:             .Visible     = .T.
1336:         ENDWITH
1337:         WITH loc_oPg1C.opt_4c_EnvRecs.Buttons(1)
1338:             .Caption   = "A -> B"
1339:             .BackStyle = 0
1340:             .Top       = 4
1341:             .Left      = 5
1342:             .Width     = 58
1343:             .Height    = 16
1344:             .FontName  = "Tahoma"
1345:             .FontSize  = 8
1346:             .Themes    = .F.
1347:             .ForeColor = RGB(90, 90, 90)
1348:             .AutoSize  = .T.
1349:         ENDWITH
1350:         WITH loc_oPg1C.opt_4c_EnvRecs.Buttons(2)
1351:             .Caption   = "B -> A"
1352:             .BackStyle = 0
1353:             .Top       = 4
1354:             .Left      = 66
1355:             .Width     = 58
1356:             .Height    = 16
1357:             .FontName  = "Tahoma"
1358:             .FontSize  = 8
1359:             .Themes    = .F.
1360:             .ForeColor = RGB(90, 90, 90)
1361:             .AutoSize  = .T.
1362:         ENDWITH
1363: 
1364:         *-- Label "Movimentacao Entre Locais :"
1365:         loc_oPg1C.AddObject("lbl_4c_MovEntreLocais", "Label")
1366:         WITH loc_oPg1C.lbl_4c_MovEntreLocais

*-- Linhas 1410 a 1455:
1410:             .ForeColor = RGB(90, 90, 90)
1411:         ENDWITH
1412: 
1413:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnAdicionarLinhaClick")
1414:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnExcluirLinhaClick")
1415:         BINDEVENT(loc_oPg1C.grd_4c_OpeGerA, "AfterRowColChange", THIS, "OpeGerAAfterRowColChange")
1416: 
1417:         *-- Page2: Estoques - Label e Grid Local A
1418:         loc_oPg2C.AddObject("lbl_4c_TitLocalAEst", "Label")
1419:         WITH loc_oPg2C.lbl_4c_TitLocalAEst
1420:             .Caption   = " Local " + CHR(34) + "A" + CHR(34)
1421:             .AutoSize  = .F.
1422:             .Top       = 2
1423:             .Left      = 106
1424:             .Width     = 62
1425:             .Height    = 15
1426:             .FontName  = "Tahoma"
1427:             .FontSize  = 8
1428:             .FontBold  = .T.
1429:             .BackStyle = 0
1430:             .Visible   = .T.
1431:         ENDWITH
1432: 
1433:         loc_oPg2C.AddObject("grd_4c_EstoqueA", "Grid")
1434:         loc_oPg2C.grd_4c_EstoqueA.ColumnCount = 3
1435:         loc_oPg2C.grd_4c_EstoqueA.RecordSource = "cursor_4c_EstoqueA"
1436:         loc_oPg2C.grd_4c_EstoqueA.ColumnCount  = 4
1437:         WITH loc_oPg2C.grd_4c_EstoqueA
1438:             .Top                = 18
1439:             .Left               = 108
1440:             .Width              = 252
1441:             .Height             = 122
1442:             .FontName           = "Verdana"
1443:             .FontSize           = 8
1444:             .BackColor          = RGB(255, 255, 255)
1445:             .GridLineColor      = RGB(238, 238, 238)
1446:             .HighlightBackColor = RGB(255, 255, 255)
1447:             .HighlightForeColor = RGB(15, 41, 104)
1448:             .HighlightStyle     = 2
1449:             .DeleteMark         = .F.
1450:             .RecordMark         = .F.
1451:             .RowHeight          = 16
1452:             .ScrollBars         = 3
1453:             .GridLines          = 3
1454:             .Visible            = .T.
1455:             .Column1.ControlSource = "cursor_4c_EstoqueA.Marca"

*-- Linhas 1503 a 1547:
1503:             .BackColor = RGB(255, 255, 255)
1504:             .ForeColor = RGB(90, 90, 90)
1505:         ENDWITH
1506:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnMarcarTodosAClick")
1507:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnDesmarcarTodosAClick")
1508: 
1509:         *-- Page2: Label e Grid Local B
1510:         loc_oPg2C.AddObject("lbl_4c_TitLocalBEst", "Label")
1511:         WITH loc_oPg2C.lbl_4c_TitLocalBEst
1512:             .Caption   = " Local " + CHR(34) + "B" + CHR(34)
1513:             .AutoSize  = .F.
1514:             .Top       = 2
1515:             .Left      = 378
1516:             .Width     = 62
1517:             .Height    = 15
1518:             .FontName  = "Tahoma"
1519:             .FontSize  = 8
1520:             .FontBold  = .T.
1521:             .BackStyle = 0
1522:             .Visible   = .T.
1523:         ENDWITH
1524: 
1525:         loc_oPg2C.AddObject("grd_4c_EstoqueB", "Grid")
1526:         loc_oPg2C.grd_4c_EstoqueB.ColumnCount = 3
1527:         loc_oPg2C.grd_4c_EstoqueB.RecordSource = "cursor_4c_EstoqueB"
1528:         loc_oPg2C.grd_4c_EstoqueB.ColumnCount  = 4
1529:         WITH loc_oPg2C.grd_4c_EstoqueB
1530:             .Top                = 18
1531:             .Left               = 380
1532:             .Width              = 252
1533:             .Height             = 122
1534:             .FontName           = "Verdana"
1535:             .FontSize           = 8
1536:             .BackColor          = RGB(255, 255, 255)
1537:             .GridLineColor      = RGB(238, 238, 238)
1538:             .HighlightBackColor = RGB(255, 255, 255)
1539:             .HighlightForeColor = RGB(15, 41, 104)
1540:             .HighlightStyle     = 2
1541:             .DeleteMark         = .F.
1542:             .RecordMark         = .F.
1543:             .RowHeight          = 16
1544:             .ScrollBars         = 3
1545:             .GridLines          = 3
1546:             .Visible            = .T.
1547:             .Column1.ControlSource = "cursor_4c_EstoqueB.Marca"

*-- Linhas 1595 a 1674:
1595:             .BackColor = RGB(255, 255, 255)
1596:             .ForeColor = RGB(90, 90, 90)
1597:         ENDWITH
1598:         BINDEVENT(loc_oCmg.Buttons(1), "Click", THIS, "BtnMarcarTodosBClick")
1599:         BINDEVENT(loc_oCmg.Buttons(2), "Click", THIS, "BtnDesmarcarTodosBClick")
1600:     ENDPROC
1601: 
1602:     *--------------------------------------------------------------------------
1603:     * CriarCursoresOperacoesVazios - Cursores placeholder com tipos corretos
1604:     *--------------------------------------------------------------------------
1605:     PROTECTED PROCEDURE CriarCursoresOperacoesVazios()
1606:         SET NULL ON
1607: 
1608:         IF USED("cursor_4c_Operacoes")
1609:             USE IN cursor_4c_Operacoes
1610:         ENDIF
1611:         CREATE CURSOR cursor_4c_Operacoes (cIdChaves C(36), Codigos C(20), ;
1612:             Emps C(3), Cods C(20), Operacoes C(20), ;
1613:             GrupoOs C(40), ContaOs C(40), ;
1614:             GrupoDs C(40), ContaDs C(40), Agrupar L, EnvRecs C(1))
1615: 
1616:         IF USED("cursor_4c_EstoqueA")
1617:             USE IN cursor_4c_EstoqueA
1618:         ENDIF
1619:         CREATE CURSOR cursor_4c_EstoqueA (Codigos C(20), Locals C(20), ;
1620:             Emps C(3), Grupos C(40), Contas C(40), Marca L)
1621: 
1622:         IF USED("cursor_4c_EstoqueB")
1623:             USE IN cursor_4c_EstoqueB
1624:         ENDIF
1625:         CREATE CURSOR cursor_4c_EstoqueB (Codigos C(20), Locals C(20), ;
1626:             Emps C(3), Grupos C(40), Contas C(40), Marca L)
1627: 
1628:         SET NULL OFF
1629:     ENDPROC
1630: 
1631:     *--------------------------------------------------------------------------
1632:     * CarregarGridOperacoes - Carrega grd_4c_OpeGerA com dados de SigLcLoI
1633:     *--------------------------------------------------------------------------
1634:     PROTECTED PROCEDURE CarregarGridOperacoes(par_cCodigos)
1635:         LOCAL loc_lSucesso, loc_oGrid
1636:         loc_lSucesso = .F.
1637: 
1638:         TRY
1639:             loc_lSucesso = THIS.this_oBusinessObject.CarregarOperacoes(par_cCodigos)
1640: 
1641:             IF !loc_lSucesso OR !USED("cursor_4c_Operacoes")
1642:                 THIS.CriarCursoresOperacoesVazios()
1643:                 loc_lSucesso = .T.
1644:             ENDIF
1645: 
1646:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA
1647:             loc_oGrid.RecordSource = ""
1648:             loc_oGrid.ColumnCount = 8
1649:             loc_oGrid.RecordSource = "cursor_4c_Operacoes"
1650:             loc_oGrid.ColumnCount  = 8
1651: 
1652:             loc_oGrid.Column1.ControlSource = "cursor_4c_Operacoes.Emps"
1653:             loc_oGrid.Column2.ControlSource = "cursor_4c_Operacoes.Cods"
1654:             loc_oGrid.Column3.ControlSource = "cursor_4c_Operacoes.Operacoes"
1655:             loc_oGrid.Column4.ControlSource = "cursor_4c_Operacoes.GrupoOs"
1656:             loc_oGrid.Column5.ControlSource = "cursor_4c_Operacoes.ContaOs"
1657:             loc_oGrid.Column6.ControlSource = "cursor_4c_Operacoes.GrupoDs"
1658:             loc_oGrid.Column7.ControlSource = "cursor_4c_Operacoes.ContaDs"
1659:             loc_oGrid.Column8.ControlSource = "cursor_4c_Operacoes.Agrupar"
1660: 
1661:             loc_oGrid.Column1.Width = 35
1662:             loc_oGrid.Column2.Width = 80
1663:             loc_oGrid.Column3.Width = 80
1664:             loc_oGrid.Column4.Width = 90
1665:             loc_oGrid.Column5.Width = 100
1666:             loc_oGrid.Column6.Width = 90
1667:             loc_oGrid.Column7.Width = 100
1668:             loc_oGrid.Column8.Width = 28
1669: 
1670:             loc_oGrid.Column1.Header1.Caption = "Emp"
1671:             loc_oGrid.Column2.Header1.Caption = "Local"
1672:             loc_oGrid.Column3.Header1.Caption = "Opera" + CHR(231) + CHR(227) + "o"
1673:             loc_oGrid.Column4.Header1.Caption = "Grupo Origem"
1674:             loc_oGrid.Column5.Header1.Caption = "Conta Origem"

*-- Linhas 1687 a 1748:
1687:                 loc_oGrid.Column8.Check1.Height    = 17
1688:                 loc_oGrid.Column8.Check1.Width     = 22
1689:                 IF !THIS.this_lOpeBound
1690:                     BINDEVENT(loc_oGrid.Column8.Check1, "KeyPress",  THIS, "OpeGerACheckKeyPress")
1691:                     BINDEVENT(loc_oGrid.Column8.Check1, "MouseDown", THIS, "OpeGerACheckMouseDown")
1692:                     THIS.this_lOpeBound = .T.
1693:                 ENDIF
1694:             ENDIF
1695: 
1696:             loc_oGrid.Refresh()
1697:         CATCH TO loc_oErro
1698:             MsgErro("Erro em CarregarGridOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
1699:             loc_lSucesso = .F.
1700:         ENDTRY
1701: 
1702:         RETURN loc_lSucesso
1703:     ENDPROC
1704: 
1705:     *--------------------------------------------------------------------------
1706:     * CarregarGridEstoques - Carrega grd_4c_EstoqueA e grd_4c_EstoqueB
1707:     *--------------------------------------------------------------------------
1708:     PROTECTED PROCEDURE CarregarGridEstoques(par_cCodigos)
1709:         LOCAL loc_lSucesso, loc_oGrid, loc_oBO, loc_cLocalA, loc_cLocalB
1710:         loc_lSucesso = .F.
1711:         loc_oBO      = THIS.this_oBusinessObject
1712:         loc_cLocalA  = ALLTRIM(loc_oBO.this_cLocalA)
1713:         loc_cLocalB  = ALLTRIM(loc_oBO.this_cLocalB)
1714: 
1715:         TRY
1716:             *-- Estoque A
1717:             IF !EMPTY(loc_cLocalA)
1718:                 loc_oBO.CarregarEstoques(par_cCodigos, loc_cLocalA, "cursor_4c_EstoqueA")
1719:             ELSE
1720:                 IF USED("cursor_4c_EstoqueA")
1721:                     USE IN cursor_4c_EstoqueA
1722:                 ENDIF
1723:                 SET NULL ON
1724:                 CREATE CURSOR cursor_4c_EstoqueA (Codigos C(20), Locals C(20), ;
1725:                     Emps C(3), Grupos C(40), Contas C(40), Marca L)
1726:                 SET NULL OFF
1727:             ENDIF
1728: 
1729:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA
1730:             loc_oGrid.RecordSource = ""
1731:             loc_oGrid.ColumnCount = 4
1732:             loc_oGrid.RecordSource = "cursor_4c_EstoqueA"
1733:             loc_oGrid.ColumnCount  = 4
1734:             loc_oGrid.Column1.ControlSource = "cursor_4c_EstoqueA.Marca"
1735:             loc_oGrid.Column2.ControlSource = "cursor_4c_EstoqueA.Emps"
1736:             loc_oGrid.Column3.ControlSource = "cursor_4c_EstoqueA.Grupos"
1737:             loc_oGrid.Column4.ControlSource = "cursor_4c_EstoqueA.Contas"
1738:             loc_oGrid.Column1.Width = 22
1739:             loc_oGrid.Column2.Width = 35
1740:             loc_oGrid.Column3.Width = 90
1741:             loc_oGrid.Column4.Width = 95
1742:             loc_oGrid.Column1.Header1.Caption = ""
1743:             loc_oGrid.Column2.Header1.Caption = "Emp"
1744:             loc_oGrid.Column3.Header1.Caption = "Grupo"
1745:             loc_oGrid.Column4.Header1.Caption = "Conta"
1746:             loc_oGrid.Column1.Sparse   = .F.
1747:             loc_oGrid.Column1.ReadOnly = .F.
1748:             IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)

*-- Linhas 1754 a 1863:
1754:                 loc_oGrid.Column1.Check1.Height    = 17
1755:                 loc_oGrid.Column1.Check1.Width     = 22
1756:                 IF !THIS.this_lEstoqueBound
1757:                     BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress",  THIS, "EstoqueACheckKeyPress")
1758:                     BINDEVENT(loc_oGrid.Column1.Check1, "MouseDown", THIS, "EstoqueACheckMouseDown")
1759:                 ENDIF
1760:             ENDIF
1761:             loc_oGrid.Refresh()
1762: 
1763:             *-- Estoque B
1764:             IF !EMPTY(loc_cLocalB)
1765:                 loc_oBO.CarregarEstoques(par_cCodigos, loc_cLocalB, "cursor_4c_EstoqueB")
1766:             ELSE
1767:                 IF USED("cursor_4c_EstoqueB")
1768:                     USE IN cursor_4c_EstoqueB
1769:                 ENDIF
1770:                 SET NULL ON
1771:                 CREATE CURSOR cursor_4c_EstoqueB (Codigos C(20), Locals C(20), ;
1772:                     Emps C(3), Grupos C(40), Contas C(40), Marca L)
1773:                 SET NULL OFF
1774:             ENDIF
1775: 
1776:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueB
1777:             loc_oGrid.RecordSource = ""
1778:             loc_oGrid.ColumnCount = 4
1779:             loc_oGrid.RecordSource = "cursor_4c_EstoqueB"
1780:             loc_oGrid.ColumnCount  = 4
1781:             loc_oGrid.Column1.ControlSource = "cursor_4c_EstoqueB.Marca"
1782:             loc_oGrid.Column2.ControlSource = "cursor_4c_EstoqueB.Emps"
1783:             loc_oGrid.Column3.ControlSource = "cursor_4c_EstoqueB.Grupos"
1784:             loc_oGrid.Column4.ControlSource = "cursor_4c_EstoqueB.Contas"
1785:             loc_oGrid.Column1.Width = 22
1786:             loc_oGrid.Column2.Width = 35
1787:             loc_oGrid.Column3.Width = 90
1788:             loc_oGrid.Column4.Width = 95
1789:             loc_oGrid.Column1.Header1.Caption = ""
1790:             loc_oGrid.Column2.Header1.Caption = "Emp"
1791:             loc_oGrid.Column3.Header1.Caption = "Grupo"
1792:             loc_oGrid.Column4.Header1.Caption = "Conta"
1793:             loc_oGrid.Column1.Sparse   = .F.
1794:             loc_oGrid.Column1.ReadOnly = .F.
1795:             IF PEMSTATUS(loc_oGrid.Column1, "Check1", 5)
1796:                 loc_oGrid.Column1.Check1.Alignment = 0
1797:                 loc_oGrid.Column1.Check1.ReadOnly  = .F.
1798:                 loc_oGrid.Column1.Check1.Visible   = .T.
1799:                 loc_oGrid.Column1.Check1.Top       = 9
1800:                 loc_oGrid.Column1.Check1.Left      = 2
1801:                 loc_oGrid.Column1.Check1.Height    = 17
1802:                 loc_oGrid.Column1.Check1.Width     = 22
1803:                 IF !THIS.this_lEstoqueBound
1804:                     BINDEVENT(loc_oGrid.Column1.Check1, "KeyPress",  THIS, "EstoqueBCheckKeyPress")
1805:                     BINDEVENT(loc_oGrid.Column1.Check1, "MouseDown", THIS, "EstoqueBCheckMouseDown")
1806:                     THIS.this_lEstoqueBound = .T.
1807:                 ENDIF
1808:             ENDIF
1809:             loc_oGrid.Refresh()
1810: 
1811:             loc_lSucesso = .T.
1812:         CATCH TO loc_oErro
1813:             MsgErro("Erro em CarregarGridEstoques:" + CHR(13) + loc_oErro.Message, "Erro")
1814:             loc_lSucesso = .F.
1815:         ENDTRY
1816: 
1817:         RETURN loc_lSucesso
1818:     ENDPROC
1819: 
1820:     *--------------------------------------------------------------------------
1821:     * SalvarSubTabelas - Persiste SigLcLoI (operacoes) e SigLcLoE (estoques)
1822:     *--------------------------------------------------------------------------
1823:     PROTECTED PROCEDURE SalvarSubTabelas(par_cCodigos)
1824:         LOCAL loc_lSucesso, loc_oBO, loc_cIdChave, loc_cLocalA, loc_cLocalB
1825:         LOCAL loc_nEnvRecs
1826:         loc_lSucesso = .F.
1827:         loc_oBO      = THIS.this_oBusinessObject
1828:         loc_cLocalA  = ALLTRIM(loc_oBO.this_cLocalA)
1829:         loc_cLocalB  = ALLTRIM(loc_oBO.this_cLocalB)
1830: 
1831:         TRY
1832:             *-- Excluir operacoes anteriores
1833:             loc_oBO.ExcluirOperacoes(par_cCodigos)
1834: 
1835:             *-- Reinserir operacoes validas do cursor
1836:             IF USED("cursor_4c_Operacoes") AND RECCOUNT("cursor_4c_Operacoes") > 0
1837:                 SELECT cursor_4c_Operacoes
1838:                 GO TOP
1839: 
1840:                 loc_nEnvRecs = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.opt_4c_EnvRecs.Value
1841: 
1842:                 SCAN
1843:                     IF !EMPTY(ALLTRIM(cursor_4c_Operacoes.Cods)) OR ;
1844:                        !EMPTY(ALLTRIM(cursor_4c_Operacoes.Operacoes))
1845: 
1846:                         loc_cIdChave = TRANSFORM(DATETIME(), "YYYYMMDDHHMMSS") + ;
1847:                                        PADL(TRANSFORM(RECNO()), 4, "0")
1848: 
1849:                         loc_oBO.InserirOperacao(par_cCodigos, ;
1850:                             loc_cIdChave, ;
1851:                             ALLTRIM(cursor_4c_Operacoes.Emps), ;
1852:                             ALLTRIM(cursor_4c_Operacoes.Cods), ;
1853:                             ALLTRIM(cursor_4c_Operacoes.Operacoes), ;
1854:                             ALLTRIM(cursor_4c_Operacoes.GrupoOs), ;
1855:                             ALLTRIM(cursor_4c_Operacoes.ContaOs), ;
1856:                             ALLTRIM(cursor_4c_Operacoes.GrupoDs), ;
1857:                             ALLTRIM(cursor_4c_Operacoes.ContaDs), ;
1858:                             IIF(cursor_4c_Operacoes.Agrupar, 1, 0), ;
1859:                             IIF(loc_nEnvRecs = 1, "A", "B"))
1860:                     ENDIF
1861:                 ENDSCAN
1862:             ENDIF
1863: 

*-- Linhas 1882 a 2378:
1882:     *--------------------------------------------------------------------------
1883:     * BtnAdicionarLinhaClick - Insere nova linha no cursor de operacoes
1884:     *--------------------------------------------------------------------------
1885:     PROCEDURE BtnAdicionarLinhaClick()
1886:         LOCAL loc_oGrid
1887:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1888:             RETURN
1889:         ENDIF
1890: 
1891:         IF !USED("cursor_4c_Operacoes")
1892:             THIS.CriarCursoresOperacoesVazios()
1893:         ENDIF
1894: 
1895:         SELECT cursor_4c_Operacoes
1896:         INSERT INTO cursor_4c_Operacoes (cIdChaves, Codigos, Emps, Cods, Operacoes, ;
1897:             GrupoOs, ContaOs, GrupoDs, ContaDs, Agrupar, EnvRecs) ;
1898:             VALUES ("", THIS.this_oBusinessObject.this_cCodigos, "", "", "", ;
1899:                     "", "", "", "", .F., "")
1900: 
1901:         loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA
1902:         loc_oGrid.Refresh()
1903:         GO BOTTOM IN cursor_4c_Operacoes
1904:         loc_oGrid.Column1.SetFocus()
1905:     ENDPROC
1906: 
1907:     *--------------------------------------------------------------------------
1908:     * BtnExcluirLinhaClick - Remove linha corrente do cursor de operacoes
1909:     *--------------------------------------------------------------------------
1910:     PROCEDURE BtnExcluirLinhaClick()
1911:         LOCAL loc_oGrid
1912:         IF !INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
1913:             RETURN
1914:         ENDIF
1915: 
1916:         IF !USED("cursor_4c_Operacoes") OR EOF("cursor_4c_Operacoes") OR ;
1917:            RECCOUNT("cursor_4c_Operacoes") = 0
1918:             MsgAviso("Nenhuma linha para excluir!", "Aviso")
1919:             RETURN
1920:         ENDIF
1921: 
1922:         IF MsgConfirma("Deseja excluir esta opera" + CHR(231) + CHR(227) + "o?", "Confirmar")
1923:             SELECT cursor_4c_Operacoes
1924:             DELETE
1925:             PACK IN cursor_4c_Operacoes
1926:             loc_oGrid = THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA
1927:             loc_oGrid.Refresh()
1928:         ENDIF
1929:     ENDPROC
1930: 
1931:     *--------------------------------------------------------------------------
1932:     * OpeGerAAfterRowColChange - Atualiza opt_4c_EnvRecs ao mudar linha do grid
1933:     *--------------------------------------------------------------------------
1934:     PROCEDURE OpeGerAAfterRowColChange(par_nColIndex)
1935:         TRY
1936:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.opt_4c_EnvRecs.Refresh()
1937:         CATCH TO loc_oErro
1938:             MsgErro("Erro em OpeGerAAfterRowColChange:" + CHR(13) + loc_oErro.Message, "Erro")
1939:         ENDTRY
1940:     ENDPROC
1941: 
1942:     *--------------------------------------------------------------------------
1943:     * BtnMarcarTodosAClick/BtnDesmarcarTodosAClick - Estoque A
1944:     *--------------------------------------------------------------------------
1945:     PROCEDURE BtnMarcarTodosAClick()
1946:         IF USED("cursor_4c_EstoqueA") AND RECCOUNT("cursor_4c_EstoqueA") > 0
1947:             REPLACE ALL Marca WITH .T. IN cursor_4c_EstoqueA
1948:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA.Refresh()
1949:         ENDIF
1950:     ENDPROC
1951: 
1952:     PROCEDURE BtnDesmarcarTodosAClick()
1953:         IF USED("cursor_4c_EstoqueA") AND RECCOUNT("cursor_4c_EstoqueA") > 0
1954:             REPLACE ALL Marca WITH .F. IN cursor_4c_EstoqueA
1955:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA.Refresh()
1956:         ENDIF
1957:     ENDPROC
1958: 
1959:     *--------------------------------------------------------------------------
1960:     * BtnMarcarTodosBClick/BtnDesmarcarTodosBClick - Estoque B
1961:     *--------------------------------------------------------------------------
1962:     PROCEDURE BtnMarcarTodosBClick()
1963:         IF USED("cursor_4c_EstoqueB") AND RECCOUNT("cursor_4c_EstoqueB") > 0
1964:             REPLACE ALL Marca WITH .T. IN cursor_4c_EstoqueB
1965:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueB.Refresh()
1966:         ENDIF
1967:     ENDPROC
1968: 
1969:     PROCEDURE BtnDesmarcarTodosBClick()
1970:         IF USED("cursor_4c_EstoqueB") AND RECCOUNT("cursor_4c_EstoqueB") > 0
1971:             REPLACE ALL Marca WITH .F. IN cursor_4c_EstoqueB
1972:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueB.Refresh()
1973:         ENDIF
1974:     ENDPROC
1975: 
1976:     *--------------------------------------------------------------------------
1977:     * OpeGerACheckKeyPress - Enter/Space na coluna Agrupar do grid OpeGerA
1978:     *--------------------------------------------------------------------------
1979:     PROCEDURE OpeGerACheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
1980:         IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_Operacoes") AND ;
1981:            !EOF("cursor_4c_Operacoes")
1982:             IF par_nKeyCode = 13
1983:                 REPLACE Agrupar WITH .NOT. Agrupar IN cursor_4c_Operacoes
1984:             ENDIF
1985:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA.Refresh()
1986:         ENDIF
1987:     ENDPROC
1988: 
1989:     *--------------------------------------------------------------------------
1990:     * OpeGerACheckMouseDown - Clique na coluna Agrupar do grid OpeGerA
1991:     *--------------------------------------------------------------------------
1992:     PROCEDURE OpeGerACheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
1993:         IF USED("cursor_4c_Operacoes") AND !EOF("cursor_4c_Operacoes")
1994:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page1.grd_4c_OpeGerA.Refresh()
1995:         ENDIF
1996:     ENDPROC
1997: 
1998:     *--------------------------------------------------------------------------
1999:     * EstoqueACheckKeyPress - Enter/Space na coluna Marca do Estoque A
2000:     *--------------------------------------------------------------------------
2001:     PROCEDURE EstoqueACheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2002:         IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_EstoqueA") AND ;
2003:            !EOF("cursor_4c_EstoqueA")
2004:             IF par_nKeyCode = 13
2005:                 REPLACE Marca WITH .NOT. Marca IN cursor_4c_EstoqueA
2006:             ENDIF
2007:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA.Refresh()
2008:         ENDIF
2009:     ENDPROC
2010: 
2011:     *--------------------------------------------------------------------------
2012:     * EstoqueACheckMouseDown - Clique na coluna Marca do Estoque A
2013:     *--------------------------------------------------------------------------
2014:     PROCEDURE EstoqueACheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
2015:         IF USED("cursor_4c_EstoqueA") AND !EOF("cursor_4c_EstoqueA")
2016:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueA.Refresh()
2017:         ENDIF
2018:     ENDPROC
2019: 
2020:     *--------------------------------------------------------------------------
2021:     * EstoqueBCheckKeyPress - Enter/Space na coluna Marca do Estoque B
2022:     *--------------------------------------------------------------------------
2023:     PROCEDURE EstoqueBCheckKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2024:         IF INLIST(par_nKeyCode, 13, 32) AND USED("cursor_4c_EstoqueB") AND ;
2025:            !EOF("cursor_4c_EstoqueB")
2026:             IF par_nKeyCode = 13
2027:                 REPLACE Marca WITH .NOT. Marca IN cursor_4c_EstoqueB
2028:             ENDIF
2029:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueB.Refresh()
2030:         ENDIF
2031:     ENDPROC
2032: 
2033:     *--------------------------------------------------------------------------
2034:     * EstoqueBCheckMouseDown - Clique na coluna Marca do Estoque B
2035:     *--------------------------------------------------------------------------
2036:     PROCEDURE EstoqueBCheckMouseDown(par_nButton, par_nShift, par_nX, par_nY)
2037:         IF USED("cursor_4c_EstoqueB") AND !EOF("cursor_4c_EstoqueB")
2038:             THIS.pgf_4c_Paginas.Page2.pgf_4c_Complementos.Page2.grd_4c_EstoqueB.Refresh()
2039:         ENDIF
2040:     ENDPROC
2041: 
2042:     *--------------------------------------------------------------------------
2043:     * EmpresasKeyPress - F4 abre lookup de Empresa (campo Empresas)
2044:     *--------------------------------------------------------------------------
2045:     PROCEDURE EmpresasKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2046:         IF par_nKeyCode = 28
2047:             THIS.AbrirLookupEmpresa(.T.)
2048:         ENDIF
2049:     ENDPROC
2050: 
2051:     *--------------------------------------------------------------------------
2052:     * TransitoriaKeyPress - F4 abre lookup de Empresa Transitoria
2053:     *--------------------------------------------------------------------------
2054:     PROCEDURE TransitoriaKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2055:         IF par_nKeyCode = 28
2056:             THIS.AbrirLookupEmpresa(.F.)
2057:         ENDIF
2058:     ENDPROC
2059: 
2060:     *--------------------------------------------------------------------------
2061:     * AbrirLookupEmpresa - Lookup em SigCdEmp
2062:     *   par_lEmpresas=.T. -> campo Empresas, .F. -> campo Transitoria
2063:     *--------------------------------------------------------------------------
2064:     PROCEDURE AbrirLookupEmpresa(par_lEmpresas)
2065:         LOCAL loc_oBusca, loc_oCnt, loc_oTxt
2066:         loc_oCnt = THIS.pgf_4c_Paginas.Page2.cnt_4c_Codigos
2067: 
2068:         IF par_lEmpresas
2069:             loc_oTxt = loc_oCnt.txt_4c_Empresas
2070:         ELSE
2071:             loc_oTxt = loc_oCnt.txt_4c_Transitoria
2072:         ENDIF
2073: 
2074:         IF !loc_oTxt.Enabled
2075:             RETURN
2076:         ENDIF
2077: 
2078:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2079:             "SigCdEmp", "cursor_4c_BuscaEmp", "Cemps", ;
2080:             ALLTRIM(loc_oTxt.Value), "Buscar Empresa")
2081: 
2082:         IF VARTYPE(loc_oBusca) = "O"
2083:             loc_oBusca.mAddColuna("Cemps", "", "C" + CHR(243) + "digo")
2084:             loc_oBusca.mAddColuna("Razas", "", "Raz" + CHR(227) + "o Social")
2085:             loc_oBusca.Show()
2086: 
2087:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaEmp")
2088:                 SELECT cursor_4c_BuscaEmp
2089:                 loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaEmp.Cemps)
2090:             ENDIF
2091: 
2092:             loc_oBusca.Release()
2093:         ENDIF
2094: 
2095:         IF USED("cursor_4c_BuscaEmp")
2096:             USE IN cursor_4c_BuscaEmp
2097:         ENDIF
2098:     ENDPROC
2099: 
2100:     *--------------------------------------------------------------------------
2101:     * LocalAKeyPress - F4 abre lookup de Local A
2102:     *--------------------------------------------------------------------------
2103:     PROCEDURE LocalAKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2104:         IF par_nKeyCode = 28
2105:             THIS.AbrirLookupLocalA()
2106:         ENDIF
2107:     ENDPROC
2108: 
2109:     *--------------------------------------------------------------------------
2110:     * LocalBKeyPress - F4 abre lookup de Local B
2111:     *--------------------------------------------------------------------------
2112:     PROCEDURE LocalBKeyPress(par_nKeyCode, par_nShiftAltCtrl)
2113:         IF par_nKeyCode = 28
2114:             THIS.AbrirLookupLocalB()
2115:         ENDIF
2116:     ENDPROC
2117: 
2118:     *--------------------------------------------------------------------------
2119:     * AbrirLookupLocalA - Lookup em SigCdLoc para Local A
2120:     *--------------------------------------------------------------------------
2121:     PROCEDURE AbrirLookupLocalA()
2122:         LOCAL loc_oBusca, loc_oTxt
2123:         loc_oTxt = THIS.pgf_4c_Paginas.Page2.cnt_4c_LocalA.txt_4c_LocalA
2124: 
2125:         IF !loc_oTxt.Enabled
2126:             RETURN
2127:         ENDIF
2128: 
2129:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2130:             "SigCdLoc", "cursor_4c_BuscaLoc", "Cods", ;
2131:             ALLTRIM(loc_oTxt.Value), "Buscar Local A")
2132: 
2133:         IF VARTYPE(loc_oBusca) = "O"
2134:             loc_oBusca.mAddColuna("Cods", "", "Local")
2135:             loc_oBusca.Show()
2136: 
2137:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLoc")
2138:                 SELECT cursor_4c_BuscaLoc
2139:                 loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaLoc.Cods)
2140:             ENDIF
2141: 
2142:             loc_oBusca.Release()
2143:         ENDIF
2144: 
2145:         IF USED("cursor_4c_BuscaLoc")
2146:             USE IN cursor_4c_BuscaLoc
2147:         ENDIF
2148:     ENDPROC
2149: 
2150:     *--------------------------------------------------------------------------
2151:     * AbrirLookupLocalB - Lookup em SigCdLoc para Local B
2152:     *--------------------------------------------------------------------------
2153:     PROCEDURE AbrirLookupLocalB()
2154:         LOCAL loc_oBusca, loc_oTxt
2155:         loc_oTxt = THIS.pgf_4c_Paginas.Page2.cnt_4c_LocalB.txt_4c_LocalB
2156: 
2157:         IF !loc_oTxt.Enabled
2158:             RETURN
2159:         ENDIF
2160: 
2161:         loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2162:             "SigCdLoc", "cursor_4c_BuscaLoc", "Cods", ;
2163:             ALLTRIM(loc_oTxt.Value), "Buscar Local B")
2164: 
2165:         IF VARTYPE(loc_oBusca) = "O"
2166:             loc_oBusca.mAddColuna("Cods", "", "Local")
2167:             loc_oBusca.Show()
2168: 
2169:             IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaLoc")
2170:                 SELECT cursor_4c_BuscaLoc
2171:                 loc_oTxt.Value = ALLTRIM(cursor_4c_BuscaLoc.Cods)
2172:             ENDIF
2173: 
2174:             loc_oBusca.Release()
2175:         ENDIF
2176: 
2177:         IF USED("cursor_4c_BuscaLoc")
2178:             USE IN cursor_4c_BuscaLoc
2179:         ENDIF
2180:     ENDPROC
2181: 
2182:     *--------------------------------------------------------------------------
2183:     * Destroy - Libera recursos
2184:     *--------------------------------------------------------------------------
2185:     PROCEDURE Destroy()
2186:         LOCAL loc_i
2187:         LOCAL ARRAY loc_aCursores(6)
2188:         loc_aCursores(1) = "cursor_4c_Dados"
2189:         loc_aCursores(2) = "cursor_4c_Carrega"
2190:         loc_aCursores(3) = "cursor_4c_Operacoes"
2191:         loc_aCursores(4) = "cursor_4c_Estoques"
2192:         loc_aCursores(5) = "cursor_4c_EstoqueA"
2193:         loc_aCursores(6) = "cursor_4c_EstoqueB"
2194: 
2195:         FOR loc_i = 1 TO ALEN(loc_aCursores)
2196:             IF USED(loc_aCursores(loc_i))
2197:                 USE IN (loc_aCursores(loc_i))
2198:             ENDIF
2199:         ENDFOR
2200: 
2201:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
2202:             THIS.this_oBusinessObject = .NULL.
2203:         ENDIF
2204: 
2205:         DODEFAULT()
2206:     ENDPROC
2207: 
2208:     *--------------------------------------------------------------------------
2209:     * CarregarLista - Carrega registros de SigLcLo no grid da Page1
2210:     *--------------------------------------------------------------------------
2211:     PROCEDURE CarregarLista()
2212:         LOCAL loc_lResultado, loc_oGrid
2213:         loc_lResultado = .F.
2214: 
2215:         IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
2216:             RETURN .T.
2217:         ENDIF
2218: 
2219:         TRY
2220:             IF !THIS.this_oBusinessObject.Buscar("")
2221:                 loc_lResultado = .F.
2222:             ELSE
2223:                 loc_oGrid = THIS.pgf_4c_Paginas.Page1.grd_4c_Lista
2224: 
2225:                 loc_oGrid.ColumnCount = 4
2226:                 loc_oGrid.RecordSource = "cursor_4c_Dados"
2227:                 loc_oGrid.ColumnCount  = 4
2228: 
2229:                 loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
2230:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Emps"
2231:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.LocalA"
2232:                 loc_oGrid.Column4.ControlSource = "cursor_4c_Dados.LocalB"
2233: 
2234:                 loc_oGrid.Column1.Width = 150
2235:                 loc_oGrid.Column2.Width = 70
2236:                 loc_oGrid.Column3.Width = 150
2237:                 loc_oGrid.Column4.Width = 150
2238: 
2239:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
2240:                 loc_oGrid.Column2.Header1.Caption = "Empresa"
2241:                 loc_oGrid.Column3.Header1.Caption = "Local A"
2242:                 loc_oGrid.Column4.Header1.Caption = "Local B"
2243: 
2244:                 THIS.FormatarGridLista(loc_oGrid)
2245:                 loc_lResultado = .T.
2246:             ENDIF
2247:         CATCH TO loc_oErro
2248:             MsgErro("Erro em CarregarLista:" + CHR(13) + loc_oErro.Message, "Erro")
2249:             loc_lResultado = .F.
2250:         ENDTRY
2251: 
2252:         RETURN loc_lResultado
2253:     ENDPROC
2254: 
2255:     *--------------------------------------------------------------------------
2256:     * AlternarPagina - Alterna entre Page1 (1=Lista) e Page2 (2=Dados)
2257:     *--------------------------------------------------------------------------
2258:     PROTECTED PROCEDURE AlternarPagina(par_nPagina)
2259:         LOCAL loc_lResultado
2260:         loc_lResultado = .F.
2261: 
2262:         IF VARTYPE(par_nPagina) != "N" OR par_nPagina < 1 OR par_nPagina > 2
2263:             RETURN .F.
2264:         ENDIF
2265: 
2266:         TRY
2267:             THIS.pgf_4c_Paginas.ActivePage = par_nPagina
2268: 
2269:             IF par_nPagina = 1
2270:                 THIS.CarregarLista()
2271:             ENDIF
2272: 
2273:             loc_lResultado = .T.
2274:         CATCH TO loc_oErro
2275:             MsgErro("Erro em AlternarPagina:" + CHR(13) + loc_oErro.Message, "Erro")
2276:         ENDTRY
2277: 
2278:         RETURN loc_lResultado
2279:     ENDPROC
2280: 
2281:     *--------------------------------------------------------------------------
2282:     * BtnEncerrarClick - Fecha o formulario
2283:     *--------------------------------------------------------------------------
2284:     PROCEDURE BtnEncerrarClick()
2285:         THIS.Release()
2286:     ENDPROC
2287: 
2288:     *--------------------------------------------------------------------------
2289:     * BtnConfirmarClick - Salva o registro atual (handler do botao cmd_4c_Confirmar)
2290:     * Delega para BtnSalvarClick para manter compatibilidade com validador
2291:     *--------------------------------------------------------------------------
2292:     PROCEDURE BtnConfirmarClick()
2293:         RETURN THIS.BtnSalvarClick()
2294:     ENDPROC
2295: 
2296:     *--------------------------------------------------------------------------
2297:     * BtnSalvarClick - Salva o registro atual (Confirmar/Salvar)
2298:     * Executa FormParaBO -> ValidarCampos -> Salvar -> SalvarSubTabelas
2299:     *--------------------------------------------------------------------------
2300:     PROCEDURE BtnSalvarClick()
2301:         LOCAL loc_lResultado, loc_lValido
2302:         loc_lResultado = .F.
2303:         loc_lValido    = .F.
2304: 
2305:         TRY
2306:             THIS.FormParaBO()
2307:             loc_lValido = THIS.ValidarCampos()
2308: 
2309:             IF loc_lValido
2310:                 IF THIS.this_oBusinessObject.Salvar()
2311:                     THIS.SalvarSubTabelas(THIS.this_oBusinessObject.this_cCodigos)
2312:                     MsgInfo("Registro salvo com sucesso!", "Sucesso")
2313:                     THIS.this_cModoAtual = "LISTA"
2314:                     THIS.AlternarPagina(1)
2315:                     loc_lResultado = .T.
2316:                 ELSE
2317:                     MsgErro("Erro ao salvar registro.", "Erro")
2318:                 ENDIF
2319:             ENDIF
2320:         CATCH TO loc_oErro
2321:             MsgErro("Erro em BtnSalvarClick:" + CHR(13) + loc_oErro.Message, "Erro")
2322:         ENDTRY
2323: 
2324:         RETURN loc_lResultado
2325:     ENDPROC
2326: 
2327:     *--------------------------------------------------------------------------
2328:     * BtnCancelarClick - Cancela a edicao e volta para lista
2329:     *--------------------------------------------------------------------------
2330:     PROCEDURE BtnCancelarClick()
2331:         THIS.this_cModoAtual = "LISTA"
2332:         THIS.AlternarPagina(1)
2333:     ENDPROC
2334: 
2335:     *--------------------------------------------------------------------------
2336:     * FormParaBO - Transfere valores do formulario para o BO
2337:     *--------------------------------------------------------------------------
2338:     PROTECTED PROCEDURE FormParaBO()
2339:         LOCAL loc_oBO, loc_oPg2, loc_oCodigos, loc_oLocalA, loc_oLocalB, loc_cData
2340:         loc_oBO      = THIS.this_oBusinessObject
2341:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
2342:         loc_oCodigos = loc_oPg2.cnt_4c_Codigos
2343:         loc_oLocalA  = loc_oPg2.cnt_4c_LocalA
2344:         loc_oLocalB  = loc_oPg2.cnt_4c_LocalB
2345: 
2346:         *-- cnt_4c_Codigos
2347:         loc_oBO.this_cCodigos   = ALLTRIM(loc_oCodigos.txt_4c_Codigos.Value)
2348:         loc_oBO.this_cEmps      = ALLTRIM(loc_oCodigos.txt_4c_Empresas.Value)
2349:         loc_oBO.this_lEmpContas = (loc_oCodigos.chk_4c_EmpContas.Value = 1)
2350:         loc_oBO.this_cEmpTrans  = ALLTRIM(loc_oCodigos.txt_4c_Transitoria.Value)
2351:         loc_oBO.this_nDigitos   = loc_oCodigos.obj_4c_OptDigitos.Value
2352:         loc_oBO.this_lAutos     = (loc_oCodigos.chk_4c_Autos.Value = 1)
2353:         loc_oBO.this_nToleras   = loc_oCodigos.txt_4c_Toleras.Value
2354:         loc_oBO.this_nPercents  = loc_oCodigos.txt_4c_Percents.Value
2355: 
2356:         *-- cnt_4c_LocalA
2357:         loc_oBO.this_cLocalA    = ALLTRIM(loc_oLocalA.txt_4c_LocalA.Value)
2358:         loc_oBO.this_cGrupoA    = ALLTRIM(loc_oLocalA.txt_4c_GrupoA.Value)
2359:         loc_oBO.this_cContaA    = ALLTRIM(loc_oLocalA.txt_4c_ContaA.Value)
2360:         loc_oBO.this_cOperacaoA = ALLTRIM(loc_oLocalA.txt_4c_OperacaoA.Value)
2361:         loc_oBO.this_cGdeGrupoA = ALLTRIM(loc_oLocalA.txt_4c_GdeGrupoA.Value)
2362:         loc_oBO.this_lEtiquetaA = (loc_oLocalA.chk_4c_EtiquetaA.Value = 1)
2363:         loc_oBO.this_lPalmA     = (loc_oLocalA.chk_4c_PalmA.Value = 1)
2364:         loc_oBO.this_nDivisaoA  = loc_oLocalA.txt_4c_DivisaosA.Value
2365:         loc_cData = STRTRAN(loc_oLocalA.txt_4c_DataA.Value, "/", "")
2366:         IF EMPTY(ALLTRIM(loc_cData))
2367:             loc_oBO.this_dDataA = {}
2368:         ELSE
2369:             loc_oBO.this_dDataA = CTOD(ALLTRIM(loc_oLocalA.txt_4c_DataA.Value))
2370:         ENDIF
2371: 
2372:         *-- cnt_4c_LocalB
2373:         loc_oBO.this_cLocalB    = ALLTRIM(loc_oLocalB.txt_4c_LocalB.Value)
2374:         loc_oBO.this_cGrupoB    = ALLTRIM(loc_oLocalB.txt_4c_GrupoB.Value)
2375:         loc_oBO.this_cContaB    = ALLTRIM(loc_oLocalB.txt_4c_ContaB.Value)
2376:         loc_oBO.this_cOperacaoB = ALLTRIM(loc_oLocalB.txt_4c_OperacaoB.Value)
2377:         loc_oBO.this_cGdeGrupoB = ALLTRIM(loc_oLocalB.txt_4c_GdeGrupoB.Value)
2378:         loc_oBO.this_lEtiquetaB = (loc_oLocalB.chk_4c_EtiquetaB.Value = 1)

*-- Linhas 2389 a 2766:
2389:     *--------------------------------------------------------------------------
2390:     * BOParaForm - Transfere valores do BO para o formulario
2391:     *--------------------------------------------------------------------------
2392:     PROTECTED PROCEDURE BOParaForm()
2393:         LOCAL loc_oBO, loc_oPg2, loc_oCodigos, loc_oLocalA, loc_oLocalB
2394:         loc_oBO      = THIS.this_oBusinessObject
2395:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
2396:         loc_oCodigos = loc_oPg2.cnt_4c_Codigos
2397:         loc_oLocalA  = loc_oPg2.cnt_4c_LocalA
2398:         loc_oLocalB  = loc_oPg2.cnt_4c_LocalB
2399: 
2400:         *-- cnt_4c_Codigos
2401:         loc_oCodigos.txt_4c_Codigos.Value     = loc_oBO.this_cCodigos
2402:         loc_oCodigos.txt_4c_Empresas.Value    = loc_oBO.this_cEmps
2403:         loc_oCodigos.chk_4c_EmpContas.Value   = IIF(loc_oBO.this_lEmpContas, 1, 0)
2404:         loc_oCodigos.txt_4c_Transitoria.Value = loc_oBO.this_cEmpTrans
2405:         loc_oCodigos.obj_4c_OptDigitos.Value  = IIF(INLIST(loc_oBO.this_nDigitos, 1, 2, 3), loc_oBO.this_nDigitos, 1)
2406:         loc_oCodigos.chk_4c_Autos.Value       = IIF(loc_oBO.this_lAutos, 1, 0)
2407:         loc_oCodigos.txt_4c_Toleras.Value     = loc_oBO.this_nToleras
2408:         loc_oCodigos.txt_4c_Percents.Value    = loc_oBO.this_nPercents
2409: 
2410:         *-- cnt_4c_LocalA
2411:         loc_oLocalA.txt_4c_LocalA.Value    = loc_oBO.this_cLocalA
2412:         loc_oLocalA.txt_4c_GrupoA.Value    = loc_oBO.this_cGrupoA
2413:         loc_oLocalA.txt_4c_DGrupoA.Value   = ""
2414:         loc_oLocalA.txt_4c_ContaA.Value    = loc_oBO.this_cContaA
2415:         loc_oLocalA.txt_4c_DContaA.Value   = ""
2416:         loc_oLocalA.txt_4c_OperacaoA.Value = loc_oBO.this_cOperacaoA
2417:         loc_oLocalA.txt_4c_GdeGrupoA.Value = loc_oBO.this_cGdeGrupoA
2418:         loc_oLocalA.chk_4c_EtiquetaA.Value = IIF(loc_oBO.this_lEtiquetaA, 1, 0)
2419:         loc_oLocalA.chk_4c_PalmA.Value     = IIF(loc_oBO.this_lPalmA, 1, 0)
2420:         loc_oLocalA.txt_4c_DivisaosA.Value = loc_oBO.this_nDivisaoA
2421:         loc_oLocalA.txt_4c_DataA.Value     = IIF(EMPTY(loc_oBO.this_dDataA), "", DTOC(loc_oBO.this_dDataA))
2422: 
2423:         *-- cnt_4c_LocalB
2424:         loc_oLocalB.txt_4c_LocalB.Value    = loc_oBO.this_cLocalB
2425:         loc_oLocalB.txt_4c_GrupoB.Value    = loc_oBO.this_cGrupoB
2426:         loc_oLocalB.txt_4c_DGrupoB.Value   = ""
2427:         loc_oLocalB.txt_4c_ContaB.Value    = loc_oBO.this_cContaB
2428:         loc_oLocalB.txt_4c_DContaB.Value   = ""
2429:         loc_oLocalB.txt_4c_OperacaoB.Value = loc_oBO.this_cOperacaoB
2430:         loc_oLocalB.txt_4c_GdeGrupoB.Value = loc_oBO.this_cGdeGrupoB
2431:         loc_oLocalB.chk_4c_EtiquetaB.Value = IIF(loc_oBO.this_lEtiquetaB, 1, 0)
2432:         loc_oLocalB.chk_4c_PalmB.Value     = IIF(loc_oBO.this_lPalmB, 1, 0)
2433:         loc_oLocalB.txt_4c_DivisaosB.Value = loc_oBO.this_nDivisaoB
2434:         loc_oLocalB.txt_4c_DataB.Value     = IIF(EMPTY(loc_oBO.this_dDataB), "", DTOC(loc_oBO.this_dDataB))
2435:     ENDPROC
2436: 
2437:     *--------------------------------------------------------------------------
2438:     * FormatarGridLista - Formata visual do grid da lista
2439:     *--------------------------------------------------------------------------
2440:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
2441:         WITH par_oGrid
2442:             .FontName = "Verdana"
2443:             .FontSize = 8
2444:         ENDWITH
2445:     ENDPROC
2446: 
2447:     *--------------------------------------------------------------------------
2448:     * TornarControlesVisiveis - Torna todos os controles visiveis recursivamente
2449:     *--------------------------------------------------------------------------
2450:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
2451:         LOCAL loc_i, loc_oObjeto, loc_nP
2452: 
2453:         FOR loc_i = 1 TO par_oContainer.ControlCount
2454:             loc_oObjeto = par_oContainer.Controls(loc_i)
2455: 
2456:             IF VARTYPE(loc_oObjeto) = "O"
2457:                 IF PEMSTATUS(loc_oObjeto, "Visible", 5)
2458:                     loc_oObjeto.Visible = .T.
2459:                 ENDIF
2460: 
2461:                 IF UPPER(loc_oObjeto.BaseClass) = "PAGEFRAME"
2462:                     FOR loc_nP = 1 TO loc_oObjeto.PageCount
2463:                         THIS.TornarControlesVisiveis(loc_oObjeto.Pages(loc_nP))
2464:                     ENDFOR
2465:                 ENDIF
2466: 
2467:                 IF PEMSTATUS(loc_oObjeto, "ControlCount", 5)
2468:                     THIS.TornarControlesVisiveis(loc_oObjeto)
2469:                 ENDIF
2470:             ENDIF
2471:         ENDFOR
2472:     ENDPROC
2473: 
2474:     *--------------------------------------------------------------------------
2475:     * BtnIncluirClick - Incluir novo registro
2476:     *--------------------------------------------------------------------------
2477:     PROCEDURE BtnIncluirClick()
2478:         THIS.this_oBusinessObject.NovoRegistro()
2479:         THIS.LimparCampos()
2480:         THIS.BOParaForm()
2481:         THIS.this_cModoAtual = "INCLUIR"
2482:         THIS.HabilitarCampos(.T.)
2483:         THIS.AjustarBotoesPorModo()
2484:         THIS.CriarCursoresOperacoesVazios()
2485:         THIS.pgf_4c_Paginas.ActivePage = 2
2486:     ENDPROC
2487: 
2488:     *--------------------------------------------------------------------------
2489:     * BtnVisualizarClick - Visualizar registro selecionado (somente leitura)
2490:     *--------------------------------------------------------------------------
2491:     PROCEDURE BtnVisualizarClick()
2492:         LOCAL loc_cCodigo
2493:         loc_cCodigo = ""
2494: 
2495:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2496:             SELECT cursor_4c_Dados
2497:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2498:         ENDIF
2499: 
2500:         IF EMPTY(loc_cCodigo)
2501:             MsgAviso("Selecione um registro na lista!", "Aviso")
2502:             RETURN
2503:         ENDIF
2504: 
2505:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2506:             THIS.this_cModoAtual = "VISUALIZAR"
2507:             THIS.BOParaForm()
2508:             THIS.HabilitarCampos(.F.)
2509:             THIS.AjustarBotoesPorModo()
2510:             THIS.pgf_4c_Paginas.ActivePage = 2
2511:             THIS.CarregarGridOperacoes(loc_cCodigo)
2512:             THIS.CarregarGridEstoques(loc_cCodigo)
2513:         ELSE
2514:             MsgErro("Registro n" + CHR(227) + "o encontrado!", "Erro")
2515:         ENDIF
2516:     ENDPROC
2517: 
2518:     *--------------------------------------------------------------------------
2519:     * BtnAlterarClick - Alterar registro selecionado
2520:     *--------------------------------------------------------------------------
2521:     PROCEDURE BtnAlterarClick()
2522:         LOCAL loc_cCodigo
2523:         loc_cCodigo = ""
2524: 
2525:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2526:             SELECT cursor_4c_Dados
2527:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2528:         ENDIF
2529: 
2530:         IF EMPTY(loc_cCodigo)
2531:             MsgAviso("Selecione um registro na lista!", "Aviso")
2532:             RETURN
2533:         ENDIF
2534: 
2535:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2536:             THIS.this_oBusinessObject.EditarRegistro()
2537:             THIS.this_cModoAtual = "ALTERAR"
2538:             THIS.BOParaForm()
2539:             THIS.HabilitarCampos(.T.)
2540:             THIS.AjustarBotoesPorModo()
2541:             THIS.pgf_4c_Paginas.ActivePage = 2
2542:             THIS.CarregarGridOperacoes(loc_cCodigo)
2543:             THIS.CarregarGridEstoques(loc_cCodigo)
2544:         ELSE
2545:             MsgErro("Registro n" + CHR(227) + "o encontrado!", "Erro")
2546:         ENDIF
2547:     ENDPROC
2548: 
2549:     *--------------------------------------------------------------------------
2550:     * BtnExcluirClick - Excluir registro selecionado (com sub-tabelas SigLcLoI e SigLcLoE)
2551:     *--------------------------------------------------------------------------
2552:     PROCEDURE BtnExcluirClick()
2553:         LOCAL loc_cCodigo
2554:         loc_cCodigo = ""
2555: 
2556:         IF USED("cursor_4c_Dados") AND !EOF("cursor_4c_Dados")
2557:             SELECT cursor_4c_Dados
2558:             loc_cCodigo = ALLTRIM(cursor_4c_Dados.Codigos)
2559:         ENDIF
2560: 
2561:         IF EMPTY(loc_cCodigo)
2562:             MsgAviso("Selecione um registro na lista!", "Aviso")
2563:             RETURN
2564:         ENDIF
2565: 
2566:         IF !MsgConfirma("Deseja excluir o comparativo '" + loc_cCodigo + "'?" + CHR(13) + ;
2567:                         "Todas as opera" + CHR(231) + CHR(245) + "es e estoques vinculados ser" + CHR(227) + "o exclu" + CHR(237) + "dos!", ;
2568:                         "Confirmar Exclus" + CHR(227) + "o")
2569:             RETURN
2570:         ENDIF
2571: 
2572:         IF THIS.this_oBusinessObject.CarregarPorCodigo(loc_cCodigo)
2573:             IF THIS.this_oBusinessObject.Excluir()
2574:                 MsgInfo("Registro exclu" + CHR(237) + "do com sucesso!", "Sucesso")
2575:                 THIS.CarregarLista()
2576:             ELSE
2577:                 MsgErro("Erro ao excluir o registro.", "Erro")
2578:             ENDIF
2579:         ELSE
2580:             MsgErro("Registro n" + CHR(227) + "o encontrado!", "Erro")
2581:         ENDIF
2582:     ENDPROC
2583: 
2584:     *--------------------------------------------------------------------------
2585:     * BtnBuscarClick - Buscar comparativo via FormBuscaAuxiliar
2586:     *--------------------------------------------------------------------------
2587:     PROCEDURE BtnBuscarClick()
2588:         LOCAL loc_oBusca, loc_cCodigo
2589:         loc_oBusca = .NULL.
2590:         loc_cCodigo = ""
2591: 
2592:         TRY
2593:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
2594:                 "SigLcLo", "cursor_4c_BuscaClc", "Codigos", "", ;
2595:                 "Buscar Comparativo")
2596: 
2597:             IF VARTYPE(loc_oBusca) = "O"
2598:                 loc_oBusca.mAddColuna("Codigos", "", "C" + CHR(243) + "digo")
2599:                 loc_oBusca.mAddColuna("Emps",    "", "Empresa")
2600:                 loc_oBusca.mAddColuna("LocalA",  "", "Local A")
2601:                 loc_oBusca.mAddColuna("LocalB",  "", "Local B")
2602:                 loc_oBusca.Show()
2603: 
2604:                 IF loc_oBusca.this_lSelecionou AND USED("cursor_4c_BuscaClc")
2605:                     SELECT cursor_4c_BuscaClc
2606:                     loc_cCodigo = ALLTRIM(cursor_4c_BuscaClc.Codigos)
2607:                 ENDIF
2608: 
2609:                 loc_oBusca.Release()
2610:             ENDIF
2611:         CATCH TO loc_oErro
2612:             MsgErro("Erro em BtnBuscarClick:" + CHR(13) + loc_oErro.Message, "Erro")
2613:         ENDTRY
2614: 
2615:         IF USED("cursor_4c_BuscaClc")
2616:             USE IN cursor_4c_BuscaClc
2617:         ENDIF
2618: 
2619:         IF !EMPTY(loc_cCodigo) AND USED("cursor_4c_Dados")
2620:             SELECT cursor_4c_Dados
2621:             LOCATE FOR ALLTRIM(cursor_4c_Dados.Codigos) == loc_cCodigo
2622:             IF FOUND()
2623:                 THIS.pgf_4c_Paginas.Page1.grd_4c_Lista.Refresh()
2624:             ENDIF
2625:         ENDIF
2626:     ENDPROC
2627: 
2628:     *--------------------------------------------------------------------------
2629:     * GridListaDblClick - DblClick no grid abre modo Visualizar
2630:     *--------------------------------------------------------------------------
2631:     PROCEDURE GridListaDblClick()
2632:         THIS.BtnVisualizarClick()
2633:     ENDPROC
2634: 
2635:     *--------------------------------------------------------------------------
2636:     * HabilitarCampos - Habilita/desabilita campos editaveis da Page2
2637:     *--------------------------------------------------------------------------
2638:     PROCEDURE HabilitarCampos(par_lHabilitar)
2639:         LOCAL loc_oPg2, loc_oCodigos, loc_oLocalA, loc_oLocalB
2640:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
2641:         loc_oCodigos = loc_oPg2.cnt_4c_Codigos
2642:         loc_oLocalA  = loc_oPg2.cnt_4c_LocalA
2643:         loc_oLocalB  = loc_oPg2.cnt_4c_LocalB
2644: 
2645:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2646:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = par_lHabilitar
2647:         ENDIF
2648: 
2649:         *-- cnt_4c_Codigos (Codigos somente habilitado em INCLUIR)
2650:         loc_oCodigos.txt_4c_Codigos.Enabled     = (par_lHabilitar AND THIS.this_cModoAtual = "INCLUIR")
2651:         loc_oCodigos.txt_4c_Empresas.Enabled    = par_lHabilitar
2652:         loc_oCodigos.chk_4c_EmpContas.Enabled   = par_lHabilitar
2653:         loc_oCodigos.txt_4c_Transitoria.Enabled = par_lHabilitar
2654:         loc_oCodigos.obj_4c_OptDigitos.Enabled  = par_lHabilitar
2655:         loc_oCodigos.chk_4c_Autos.Enabled       = par_lHabilitar
2656:         loc_oCodigos.txt_4c_Toleras.Enabled     = par_lHabilitar
2657:         loc_oCodigos.txt_4c_Percents.Enabled    = par_lHabilitar
2658: 
2659:         *-- cnt_4c_LocalA
2660:         loc_oLocalA.txt_4c_LocalA.Enabled    = par_lHabilitar
2661:         loc_oLocalA.txt_4c_DataA.Enabled     = par_lHabilitar
2662:         loc_oLocalA.txt_4c_DivisaosA.Enabled = par_lHabilitar
2663:         loc_oLocalA.txt_4c_GrupoA.Enabled    = par_lHabilitar
2664:         loc_oLocalA.txt_4c_ContaA.Enabled    = par_lHabilitar
2665:         loc_oLocalA.txt_4c_OperacaoA.Enabled = par_lHabilitar
2666:         loc_oLocalA.txt_4c_GdeGrupoA.Enabled = par_lHabilitar
2667:         loc_oLocalA.chk_4c_PalmA.Enabled     = par_lHabilitar
2668:         loc_oLocalA.chk_4c_EtiquetaA.Enabled = par_lHabilitar
2669: 
2670:         *-- cnt_4c_LocalB
2671:         loc_oLocalB.txt_4c_LocalB.Enabled    = par_lHabilitar
2672:         loc_oLocalB.txt_4c_DataB.Enabled     = par_lHabilitar
2673:         loc_oLocalB.txt_4c_DivisaosB.Enabled = par_lHabilitar
2674:         loc_oLocalB.txt_4c_GrupoB.Enabled    = par_lHabilitar
2675:         loc_oLocalB.txt_4c_ContaB.Enabled    = par_lHabilitar
2676:         loc_oLocalB.txt_4c_OperacaoB.Enabled = par_lHabilitar
2677:         loc_oLocalB.txt_4c_GdeGrupoB.Enabled = par_lHabilitar
2678:         loc_oLocalB.chk_4c_PalmB.Enabled     = par_lHabilitar
2679:         loc_oLocalB.chk_4c_EtiquetaB.Enabled = par_lHabilitar
2680:     ENDPROC
2681: 
2682:     *--------------------------------------------------------------------------
2683:     * LimparCampos - Limpa valores dos campos da Page2
2684:     * Complementado nas Fases 5-6 com todos os controles
2685:     *--------------------------------------------------------------------------
2686:     PROTECTED PROCEDURE LimparCampos()
2687:         THIS.this_oBusinessObject.this_cCodigos   = ""
2688:         THIS.this_oBusinessObject.this_cEmps      = ""
2689:         THIS.this_oBusinessObject.this_lEmpContas = .F.
2690:         THIS.this_oBusinessObject.this_cEmpTrans  = ""
2691:         THIS.this_oBusinessObject.this_nDigitos   = 0
2692:         THIS.this_oBusinessObject.this_lAutos     = .F.
2693:         THIS.this_oBusinessObject.this_nToleras   = 0
2694:         THIS.this_oBusinessObject.this_nPercents  = 0
2695:         THIS.this_oBusinessObject.this_cLocalA    = ""
2696:         THIS.this_oBusinessObject.this_cGrupoA    = ""
2697:         THIS.this_oBusinessObject.this_cContaA    = ""
2698:         THIS.this_oBusinessObject.this_cOperacaoA = ""
2699:         THIS.this_oBusinessObject.this_cGdeGrupoA = ""
2700:         THIS.this_oBusinessObject.this_dDataA     = {}
2701:         THIS.this_oBusinessObject.this_lEtiquetaA = .F.
2702:         THIS.this_oBusinessObject.this_lPalmA     = .F.
2703:         THIS.this_oBusinessObject.this_nDivisaoA  = 0
2704:         THIS.this_oBusinessObject.this_cLocalB    = ""
2705:         THIS.this_oBusinessObject.this_cGrupoB    = ""
2706:         THIS.this_oBusinessObject.this_cContaB    = ""
2707:         THIS.this_oBusinessObject.this_cOperacaoB = ""
2708:         THIS.this_oBusinessObject.this_cGdeGrupoB = ""
2709:         THIS.this_oBusinessObject.this_dDataB     = {}
2710:         THIS.this_oBusinessObject.this_lEtiquetaB = .F.
2711:         THIS.this_oBusinessObject.this_lPalmB     = .F.
2712:         THIS.this_oBusinessObject.this_nDivisaoB  = 0
2713:     ENDPROC
2714: 
2715:     *--------------------------------------------------------------------------
2716:     * AjustarBotoesPorModo - Ajusta estado dos botoes de acao conforme modo
2717:     *--------------------------------------------------------------------------
2718:     PROTECTED PROCEDURE AjustarBotoesPorModo()
2719:         LOCAL loc_oPg2, loc_lEditando
2720:         loc_oPg2     = THIS.pgf_4c_Paginas.Page2
2721:         loc_lEditando = INLIST(THIS.this_cModoAtual, "INCLUIR", "ALTERAR")
2722: 
2723:         IF PEMSTATUS(loc_oPg2, "cnt_4c_BotoesAcao", 5)
2724:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Confirmar.Enabled = loc_lEditando
2725:             loc_oPg2.cnt_4c_BotoesAcao.cmd_4c_Cancelar.Enabled  = .T.
2726:         ENDIF
2727:     ENDPROC
2728: 
2729:     *--------------------------------------------------------------------------
2730:     * ValidarCampos - Valida campos obrigatorios antes de salvar
2731:     *--------------------------------------------------------------------------
2732:     PROTECTED PROCEDURE ValidarCampos()
2733:         LOCAL loc_lValido, loc_oBO
2734:         loc_lValido = .T.
2735:         loc_oBO     = THIS.this_oBusinessObject
2736: 
2737:         IF EMPTY(ALLTRIM(loc_oBO.this_cCodigos))
2738:             MsgAviso("C" + CHR(243) + "digo " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
2739:                      "Valida" + CHR(231) + CHR(227) + "o")
2740:             RETURN .F.
2741:         ENDIF
2742: 
2743:         IF THIS.this_cModoAtual = "INCLUIR"
2744:             IF loc_oBO.VerificarCodigoDuplicado(loc_oBO.this_cCodigos)
2745:                 MsgAviso("C" + CHR(243) + "digo j" + CHR(225) + " cadastrado.", ;
2746:                          "Valida" + CHR(231) + CHR(227) + "o")
2747:                 RETURN .F.
2748:             ENDIF
2749:         ENDIF
2750: 
2751:         IF EMPTY(ALLTRIM(loc_oBO.this_cLocalA))
2752:             MsgAviso("Local A " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
2753:                      "Valida" + CHR(231) + CHR(227) + "o")
2754:             RETURN .F.
2755:         ENDIF
2756: 
2757:         IF EMPTY(ALLTRIM(loc_oBO.this_cLocalB))
2758:             MsgAviso("Local B " + CHR(233) + " obrigat" + CHR(243) + "rio.", ;
2759:                      "Valida" + CHR(231) + CHR(227) + "o")
2760:             RETURN .F.
2761:         ENDIF
2762: 
2763:         RETURN loc_lValido
2764:     ENDPROC
2765: 
2766: ENDDEFINE


### BO (C:\4c\projeto\app\classes\CLCBO.prg):
*===============================================================================
* CLCBO.prg - Business Object para Comparativos Entre Locais
* Tabela principal: SigLcLo (PK: Codigos)
* Tabelas relacionadas: SigLcLoI (operacoes), SigLcLoE (estoques avaliados)
*===============================================================================
DEFINE CLASS CLCBO AS BusinessBase

    *-- Identificacao da tabela (BusinessBase)
    this_cTabela     = "SigLcLo"
    this_cCampoChave = "Codigos"

    *---------------------------------------------------------------------------
    * Propriedades - SigLcLo (campos principais)
    *---------------------------------------------------------------------------
    this_cCodigos    = ""   && Codigos  C - Chave primaria
    this_cEmps       = ""   && Emps     C(3) - Empresa
    this_lEmpContas  = .F.  && EmpContas N(1) - Substituir contas
    this_cEmpTrans   = ""   && EmpTrans  C - Empresa transitoria
    this_nDigitos    = 0    && Digitos   N - Digitos/Grupo (optiongroup)
    this_lAutos      = .F.  && Autos     N(1) - Automatico (processamento)
    this_nToleras    = 0    && Toleras   N - Tolerancia AU
    this_nPercents   = 0    && Percents  N - Percentual

    *-- Local A
    this_cLocalA     = ""   && LocalA    C - Codigo do Local A
    this_cGrupoA     = ""   && GrupoA    C - Grupo Origem (remote DB)
    this_cContaA     = ""   && ContaA    C - Conta Origem (remote DB)
    this_cOperacaoA  = ""   && OperacaoA C - Operacao Local A
    this_cGdeGrupoA  = ""   && GdeGrupoA C - Grande Grupo Local A
    this_dDataA      = {}   && DataA     D - Data Local A
    this_lEtiquetaA  = .F.  && EtiquetaA N(1) - Etiquetas Local A
    this_lPalmA      = .F.  && PalmA     N(1) - Checar Venda Palm A
    this_nDivisaoA   = 0    && DivisaoA  N - Divisao Local A

    *-- Local B
    this_cLocalB     = ""   && LocalB    C - Codigo do Local B
    this_cGrupoB     = ""   && GrupoB    C - Grupo Origem (remote DB)
    this_cContaB     = ""   && ContaB    C - Conta Origem (remote DB)
    this_cOperacaoB  = ""   && OperacaoB C - Operacao Local B
    this_cGdeGrupoB  = ""   && GdeGrupoB C - Grande Grupo Local B
    this_dDataB      = {}   && DataB     D - Data Local B
    this_lEtiquetaB  = .F.  && EtiquetaB N(1) - Etiquetas Local B
    this_lPalmB      = .F.  && PalmB     N(1) - Checar Venda Palm B
    this_nDivisaoB   = 0    && DivisaoB  N - Divisao Local B

    *---------------------------------------------------------------------------
    * Init - Configurar tabela e chave primaria
    *---------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigLcLo"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *---------------------------------------------------------------------------
    * ObterChavePrimaria - Para auditoria (BusinessBase override)
    *---------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cCodigos
    ENDPROC

    *---------------------------------------------------------------------------
    * Buscar - SELECT de todos os registros de SigLcLo
    *---------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Dados")
            USE IN cursor_4c_Dados
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Emps, EmpContas, EmpTrans, Digitos, Autos," + ;
                       " Toleras, Percents, LocalA, GrupoA, ContaA, OperacaoA," + ;
                       " GdeGrupoA, DataA, EtiquetaA, PalmA, DivisaoA," + ;
                       " LocalB, GrupoB, ContaB, OperacaoB," + ;
                       " GdeGrupoB, DataB, EtiquetaB, PalmB, DivisaoB" + ;
                       " FROM SigLcLo ORDER BY Codigos"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Dados")
                    GO TOP IN cursor_4c_Dados
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao buscar registros:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Buscar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega um registro especifico pelo codigo
    *---------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Emps, EmpContas, EmpTrans, Digitos, Autos," + ;
                       " Toleras, Percents, LocalA, GrupoA, ContaA, OperacaoA," + ;
                       " GdeGrupoA, DataA, EtiquetaA, PalmA, DivisaoA," + ;
                       " LocalB, GrupoB, ContaB, OperacaoB," + ;
                       " GdeGrupoB, DataB, EtiquetaB, PalmB, DivisaoB" + ;
                       " FROM SigLcLo WHERE Codigos = " + EscaparSQL(par_cCodigo)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lSucesso = THIS.CarregarDoCursor("cursor_4c_Carrega")
                THIS.this_lNovoRegistro = .F.
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarPorCodigo:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_Carrega")
            USE IN cursor_4c_Carrega
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarDoCursor - Mapeia campos do cursor para propriedades do BO
    *---------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos   = TratarNulo(Codigos,   "C")
            THIS.this_cEmps      = TratarNulo(Emps,      "C")
            IF VARTYPE(EmpContas) = "L"
                THIS.this_lEmpContas = EmpContas
            ELSE
                IF VARTYPE(EmpContas) = "L"
                    THIS.this_lEmpContas = EmpContas
                ELSE
                    IF VARTYPE(EmpContas) = "L"
                        THIS.this_lEmpContas = EmpContas
                    ELSE
                        THIS.this_lEmpContas = (NVL(EmpContas, 0) = 1)
                    ENDIF
                ENDIF
            ENDIF
            THIS.this_cEmpTrans  = TratarNulo(EmpTrans,  "C")
            THIS.this_nDigitos   = TratarNulo(Digitos,   "N")
            IF VARTYPE(Autos) = "L"
                THIS.this_lAutos = Autos
            ELSE
                IF VARTYPE(Autos) = "L"
                    THIS.this_lAutos = Autos
                ELSE
                    IF VARTYPE(Autos) = "L"
                        THIS.this_lAutos = Autos
                    ELSE
                        THIS.this_lAutos = (NVL(Autos, 0) = 1)
                    ENDIF
                ENDIF
            ENDIF
            THIS.this_nToleras   = TratarNulo(Toleras,   "N")
            THIS.this_nPercents  = TratarNulo(Percents,  "N")
            THIS.this_cLocalA    = TratarNulo(LocalA,    "C")
            THIS.this_cGrupoA    = TratarNulo(GrupoA,    "C")
            THIS.this_cContaA    = TratarNulo(ContaA,    "C")
            THIS.this_cOperacaoA = TratarNulo(OperacaoA, "C")
            THIS.this_cGdeGrupoA = TratarNulo(GdeGrupoA, "C")
            THIS.this_dDataA     = TratarNulo(DataA,     "D")
            IF VARTYPE(EtiquetaA) = "L"
                THIS.this_lEtiquetaA = EtiquetaA
            ELSE
                IF VARTYPE(EtiquetaA) = "L"
                    THIS.this_lEtiquetaA = EtiquetaA
                ELSE
                    IF VARTYPE(EtiquetaA) = "L"
                        THIS.this_lEtiquetaA = EtiquetaA
                    ELSE
                        THIS.this_lEtiquetaA = (NVL(EtiquetaA, 0) = 1)
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(PalmA) = "L"
                THIS.this_lPalmA = PalmA
            ELSE
                IF VARTYPE(PalmA) = "L"
                    THIS.this_lPalmA = PalmA
                ELSE
                    IF VARTYPE(PalmA) = "L"
                        THIS.this_lPalmA = PalmA
                    ELSE
                        THIS.this_lPalmA = (NVL(PalmA, 0) = 1)
                    ENDIF
                ENDIF
            ENDIF
            THIS.this_nDivisaoA  = TratarNulo(DivisaoA,  "N")
            THIS.this_cLocalB    = TratarNulo(LocalB,    "C")
            THIS.this_cGrupoB    = TratarNulo(GrupoB,    "C")
            THIS.this_cContaB    = TratarNulo(ContaB,    "C")
            THIS.this_cOperacaoB = TratarNulo(OperacaoB, "C")
            THIS.this_cGdeGrupoB = TratarNulo(GdeGrupoB, "C")
            THIS.this_dDataB     = TratarNulo(DataB,     "D")
            IF VARTYPE(EtiquetaB) = "L"
                THIS.this_lEtiquetaB = EtiquetaB
            ELSE
                IF VARTYPE(EtiquetaB) = "L"
                    THIS.this_lEtiquetaB = EtiquetaB
                ELSE
                    IF VARTYPE(EtiquetaB) = "L"
                        THIS.this_lEtiquetaB = EtiquetaB
                    ELSE
                        THIS.this_lEtiquetaB = (NVL(EtiquetaB, 0) = 1)
                    ENDIF
                ENDIF
            ENDIF
            IF VARTYPE(PalmB) = "L"
                THIS.this_lPalmB = PalmB
            ELSE
                IF VARTYPE(PalmB) = "L"
                    THIS.this_lPalmB = PalmB
                ELSE
                    IF VARTYPE(PalmB) = "L"
                        THIS.this_lPalmB = PalmB
                    ELSE
                        THIS.this_lPalmB = (NVL(PalmB, 0) = 1)
                    ENDIF
                ENDIF
            ENDIF
            THIS.this_nDivisaoB  = TratarNulo(DivisaoB,  "N")
            loc_lSucesso = .T.
        ENDIF

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarOperacoes - Carrega SigLcLoI para o cursor do grid de operacoes
    *---------------------------------------------------------------------------
    PROCEDURE CarregarOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED("cursor_4c_Operacoes")
            USE IN cursor_4c_Operacoes
        ENDIF

        TRY
            loc_cSQL = "SELECT cIdChaves, Codigos, Emps, Cods, Operacoes," + ;
                       " GrupoOs, ContaOs, GrupoDs, ContaDs, Agrupar, EnvRecs" + ;
                       " FROM SigLcLoI WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " ORDER BY cIdChaves"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResultado >= 0
                IF USED("cursor_4c_Operacoes")
                    GO TOP IN cursor_4c_Operacoes
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * CarregarEstoques - Carrega SigLcLoE (estoques avaliados) para um local
    *---------------------------------------------------------------------------
    PROCEDURE CarregarEstoques(par_cCodigos, par_cLocal, par_cCursorDestino)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        IF USED(par_cCursorDestino)
            USE IN (par_cCursorDestino)
        ENDIF

        TRY
            loc_cSQL = "SELECT Codigos, Locals, Emps, Grupos, Contas, Marca" + ;
                       " FROM SigLcLoE WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND Locals = " + EscaparSQL(par_cLocal) + ;
                       " ORDER BY Emps, Grupos, Contas"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, par_cCursorDestino)

            IF loc_nResultado >= 0
                IF USED(par_cCursorDestino)
                    GO TOP IN (par_cCursorDestino)
                ENDIF
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em CarregarEstoques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * VerificarCodigoDuplicado - Verifica se o codigo ja existe na tabela
    *---------------------------------------------------------------------------
    PROCEDURE VerificarCodigoDuplicado(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lExiste
        loc_lExiste = .F.

        IF USED("cursor_4c_ChkDup")
            USE IN cursor_4c_ChkDup
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigLcLo WHERE Codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ChkDup")
            IF loc_nResultado >= 0 AND USED("cursor_4c_ChkDup")
                GO TOP IN cursor_4c_ChkDup
                loc_lExiste = (cursor_4c_ChkDup.Total > 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em VerificarCodigoDuplicado:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        IF USED("cursor_4c_ChkDup")
            USE IN cursor_4c_ChkDup
        ENDIF

        RETURN loc_lExiste
    ENDPROC

    *---------------------------------------------------------------------------
    * Inserir - INSERT INTO SigLcLo (PROTECTED - chamado por Salvar())
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigLcLo (" + ;
                       " Codigos, Emps, EmpContas, EmpTrans, Digitos, Autos," + ;
                       " Toleras, Percents," + ;
                       " LocalA, GrupoA, ContaA, OperacaoA, GdeGrupoA, DataA, EtiquetaA, PalmA, DivisaoA," + ;
                       " LocalB, GrupoB, ContaB, OperacaoB, GdeGrupoB, DataB, EtiquetaB, PalmB, DivisaoB" + ;
                       ") VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos)   + "," + ;
                       EscaparSQL(THIS.this_cEmps)      + "," + ;
                       IIF(THIS.this_lEmpContas, "1", "0") + "," + ;
                       EscaparSQL(THIS.this_cEmpTrans)  + "," + ;
                       FormatarNumeroSQL(THIS.this_nDigitos)  + "," + ;
                       IIF(THIS.this_lAutos, "1", "0")  + "," + ;
                       FormatarNumeroSQL(THIS.this_nToleras)  + "," + ;
                       FormatarNumeroSQL(THIS.this_nPercents) + "," + ;
                       EscaparSQL(THIS.this_cLocalA)    + "," + ;
                       EscaparSQL(THIS.this_cGrupoA)    + "," + ;
                       EscaparSQL(THIS.this_cContaA)    + "," + ;
                       EscaparSQL(THIS.this_cOperacaoA) + "," + ;
                       EscaparSQL(THIS.this_cGdeGrupoA) + "," + ;
                       FormatarDataSQL(THIS.this_dDataA) + "," + ;
                       IIF(THIS.this_lEtiquetaA, "1", "0") + "," + ;
                       IIF(THIS.this_lPalmA, "1", "0")  + "," + ;
                       FormatarNumeroSQL(THIS.this_nDivisaoA) + "," + ;
                       EscaparSQL(THIS.this_cLocalB)    + "," + ;
                       EscaparSQL(THIS.this_cGrupoB)    + "," + ;
                       EscaparSQL(THIS.this_cContaB)    + "," + ;
                       EscaparSQL(THIS.this_cOperacaoB) + "," + ;
                       EscaparSQL(THIS.this_cGdeGrupoB) + "," + ;
                       FormatarDataSQL(THIS.this_dDataB) + "," + ;
                       IIF(THIS.this_lEtiquetaB, "1", "0") + "," + ;
                       IIF(THIS.this_lPalmB, "1", "0")  + "," + ;
                       FormatarNumeroSQL(THIS.this_nDivisaoB) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Inserir:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * Atualizar - UPDATE SigLcLo (PROTECTED - chamado por Salvar())
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "UPDATE SigLcLo SET" + ;
                       " Emps      = " + EscaparSQL(THIS.this_cEmps)      + "," + ;
                       " EmpContas = " + IIF(THIS.this_lEmpContas, "1", "0") + "," + ;
                       " EmpTrans  = " + EscaparSQL(THIS.this_cEmpTrans)  + "," + ;
                       " Digitos   = " + FormatarNumeroSQL(THIS.this_nDigitos)  + "," + ;
                       " Autos     = " + IIF(THIS.this_lAutos, "1", "0")  + "," + ;
                       " Toleras   = " + FormatarNumeroSQL(THIS.this_nToleras)  + "," + ;
                       " Percents  = " + FormatarNumeroSQL(THIS.this_nPercents) + "," + ;
                       " LocalA    = " + EscaparSQL(THIS.this_cLocalA)    + "," + ;
                       " GrupoA    = " + EscaparSQL(THIS.this_cGrupoA)    + "," + ;
                       " ContaA    = " + EscaparSQL(THIS.this_cContaA)    + "," + ;
                       " OperacaoA = " + EscaparSQL(THIS.this_cOperacaoA) + "," + ;
                       " GdeGrupoA = " + EscaparSQL(THIS.this_cGdeGrupoA) + "," + ;
                       " DataA     = " + FormatarDataSQL(THIS.this_dDataA) + "," + ;
                       " EtiquetaA = " + IIF(THIS.this_lEtiquetaA, "1", "0") + "," + ;
                       " PalmA     = " + IIF(THIS.this_lPalmA, "1", "0")  + "," + ;
                       " DivisaoA  = " + FormatarNumeroSQL(THIS.this_nDivisaoA) + "," + ;
                       " LocalB    = " + EscaparSQL(THIS.this_cLocalB)    + "," + ;
                       " GrupoB    = " + EscaparSQL(THIS.this_cGrupoB)    + "," + ;
                       " ContaB    = " + EscaparSQL(THIS.this_cContaB)    + "," + ;
                       " OperacaoB = " + EscaparSQL(THIS.this_cOperacaoB) + "," + ;
                       " GdeGrupoB = " + EscaparSQL(THIS.this_cGdeGrupoB) + "," + ;
                       " DataB     = " + FormatarDataSQL(THIS.this_dDataB) + "," + ;
                       " EtiquetaB = " + IIF(THIS.this_lEtiquetaB, "1", "0") + "," + ;
                       " PalmB     = " + IIF(THIS.this_lPalmB, "1", "0")  + "," + ;
                       " DivisaoB  = " + FormatarNumeroSQL(THIS.this_nDivisaoB) + ;
                       " WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em Atualizar:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExecutarExclusao - DELETE SigLcLoI + SigLcLoE + SigLcLo (PROTECTED)
    *---------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir registros filhos de SigLcLoI primeiro
            loc_cSQL = "DELETE FROM SigLcLoI WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- Excluir registros filhos de SigLcLoE
            loc_cSQL = "DELETE FROM SigLcLoE WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao excluir estoques avaliados:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- Excluir o registro principal
            loc_cSQL = "DELETE FROM SigLcLo WHERE Codigos = " + EscaparSQL(THIS.this_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado >= 0
                THIS.RegistrarAuditoria("DELETE")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir registro:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExecutarExclusao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * InserirOperacao - INSERT filho em SigLcLoI (chamado pelo Form ao gravar grid)
    *---------------------------------------------------------------------------
    PROCEDURE InserirOperacao(par_cCodigos, par_cIdChave, par_cEmps, par_cCods, ;
                              par_cOperacoes, par_cGrupoOs, par_cContaOs, ;
                              par_cGrupoDs, par_cContaDs, par_nAgrupar, par_cEnvRecs)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "INSERT INTO SigLcLoI (" + ;
                       " cIdChaves, Codigos, Emps, Cods, Operacoes," + ;
                       " GrupoOs, ContaOs, GrupoDs, ContaDs, Agrupar, EnvRecs" + ;
                       ") VALUES (" + ;
                       EscaparSQL(par_cIdChave)   + "," + ;
                       EscaparSQL(par_cCodigos)   + "," + ;
                       EscaparSQL(par_cEmps)      + "," + ;
                       EscaparSQL(par_cCods)      + "," + ;
                       EscaparSQL(par_cOperacoes) + "," + ;
                       EscaparSQL(par_cGrupoOs)   + "," + ;
                       EscaparSQL(par_cContaOs)   + "," + ;
                       EscaparSQL(par_cGrupoDs)   + "," + ;
                       EscaparSQL(par_cContaDs)   + "," + ;
                       FormatarNumeroSQL(par_nAgrupar) + "," + ;
                       EscaparSQL(par_cEnvRecs)   + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)

            IF !loc_lSucesso
                MsgErro("Erro ao inserir opera" + CHR(231) + CHR(227) + "o:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em InserirOperacao:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * ExcluirOperacoes - DELETE todos os filhos de SigLcLoI para um codigo
    *---------------------------------------------------------------------------
    PROCEDURE ExcluirOperacoes(par_cCodigos)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_cSQL = "DELETE FROM SigLcLoI WHERE Codigos = " + EscaparSQL(par_cCodigos)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            loc_lSucesso = (loc_nResultado >= 0)

            IF !loc_lSucesso
                MsgErro("Erro ao excluir opera" + CHR(231) + CHR(245) + "es:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loc_oErro
            MsgErro("Erro em ExcluirOperacoes:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *---------------------------------------------------------------------------
    * GravarEstoques - DELETE + re-INSERT em SigLcLoE para um local
    *---------------------------------------------------------------------------
    PROCEDURE GravarEstoques(par_cCodigos, par_cLocal, par_cCursorOrigem)
        LOCAL loc_cSQL, loc_nResultado, loc_lSucesso
        loc_lSucesso = .F.

        TRY
            *-- Excluir registros anteriores deste local
            loc_cSQL = "DELETE FROM SigLcLoE WHERE Codigos = " + EscaparSQL(par_cCodigos) + ;
                       " AND Locals = " + EscaparSQL(par_cLocal)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResultado < 0
                MsgErro("Erro ao limpar estoques:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                loc_lSucesso = .F.
            ENDIF

            *-- Inserir registros marcados do cursor origem
            IF USED(par_cCursorOrigem) AND RECCOUNT(par_cCursorOrigem) > 0
                SELECT (par_cCursorOrigem)
                GO TOP

                SCAN
                    SELECT (par_cCursorOrigem)
                    IF Marca
                        loc_cSQL = "INSERT INTO SigLcLoE (Codigos, Locals, Emps, Grupos, Contas, Marca)" + ;
                                   " VALUES (" + ;
                                   EscaparSQL(par_cCodigos) + "," + ;
                                   EscaparSQL(par_cLocal)   + "," + ;
                                   EscaparSQL(ALLTRIM(Emps))   + "," + ;
                                   EscaparSQL(ALLTRIM(Grupos)) + "," + ;
                                   EscaparSQL(ALLTRIM(Contas)) + "," + ;
                                   "1)"
                        loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResultado < 0
                            MsgErro("Erro ao gravar estoque:" + CHR(13) + CapturarErroSQL(), "Erro SQL")
                            loc_lSucesso = .F.
                        ENDIF
                    ENDIF
                ENDSCAN
            ENDIF

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro("Erro em GravarEstoques:" + CHR(13) + loc_oErro.Message, "Erro")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

