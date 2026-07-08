# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (9)
- [LAYOUT-POSITION] Controle 'lbl_periodo_a' (parent: SIGREFEC): Top original=133 vs migrado 'lbl_4c_Lbl_periodo_a' Top=48 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_empresa' (parent: SIGREFEC): Top original=108 vs migrado 'lbl_4c_Lbl_empresa' Top=23 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkDetOpe' (parent: SIGREFEC): Top original=236 vs migrado 'chk_4c_ChkDetOpe' Top=151 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkOpePag' (parent: SIGREFEC): Top original=289 vs migrado 'chk_4c_ChkOpePag' Top=204 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkResFpg' (parent: SIGREFEC): Top original=271 vs migrado 'chk_4c_ChkResFpg' Top=186 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'lbl_periodo' (parent: SIGREFEC): Top original=133 vs migrado 'lbl_4c_Lbl_periodo' Top=48 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkVends' (parent: SIGREFEC): Top original=236 vs migrado 'chk_4c_ChkVends' Top=151 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkAnaPag' (parent: SIGREFEC): Top original=307 vs migrado 'chk_4c_ChkAnaPag' Top=222 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'chkVendRes' (parent: SIGREFEC): Top original=253 vs migrado 'chk_4c_ChkVendRes' Top=168 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigrefec.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1244 linhas total):

*-- Linhas 44 a 52:
44:         loc_lContinuar = .T.
45: 
46:         TRY
47:             THIS.Caption = "Fechamento de Caixa"
48: 
49:             IF TYPE("gc_4c_CaminhoIcones") = "U"
50:                 gc_4c_CaminhoIcones = ""
51:             ENDIF
52:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 70 a 79:
70:                 THIS.LimparCampos()
71:                 THIS.AlternarPagina(1)
72: 
73:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
74:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
75: 
76:                 THIS.Visible  = .T.
77:                 loc_lSucesso  = .T.
78:             ENDIF
79: 

*-- Linhas 93 a 131:
93:     PROTECTED PROCEDURE ConfigurarCabecalho()
94:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
95:         WITH THIS.cnt_4c_Cabecalho
96:             .Top         = 0
97:             .Left        = 0
98:             .Width       = THIS.Width
99:             .Height      = 80
100:             .BackStyle   = 1
101:             .BackColor   = RGB(100, 100, 100)
102:             .BorderWidth = 0
103:             .Visible     = .T.
104: 
105:             .AddObject("lbl_4c_Sombra", "Label")
106:             WITH .lbl_4c_Sombra
107:                 .Top       = 22
108:                 .Left      = 22
109:                 .Width     = THIS.Width
110:                 .Height    = 30
111:                 .Caption   = "Fechamento de Caixa"
112:                 .FontName  = "Tahoma"
113:                 .FontSize  = 14
114:                 .FontBold  = .T.
115:                 .ForeColor = RGB(0, 0, 0)
116:                 .BackStyle = 0
117:                 .Visible   = .T.
118:             ENDWITH
119: 
120:             .AddObject("lbl_4c_Titulo", "Label")
121:             WITH .lbl_4c_Titulo
122:                 .Top       = 20
123:                 .Left      = 20
124:                 .Width     = THIS.Width
125:                 .Height    = 30
126:                 .Caption   = "Fechamento de Caixa"
127:                 .FontName  = "Tahoma"
128:                 .FontSize  = 14
129:                 .FontBold  = .T.
130:                 .ForeColor = RGB(255, 255, 255)
131:                 .BackStyle = 0

*-- Linhas 140 a 164:
140:     PROTECTED PROCEDURE ConfigurarBotoes()
141:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
142:         WITH THIS.cmg_4c_Botoes
143:             .Top           = 0
144:             .Left          = 529
145:             .Width         = 273
146:             .Height        = 80
147:             .ButtonCount   = 4
148:             .BackStyle     = 0
149:             .BorderStyle   = 0
150:             .SpecialEffect = 1
151:             .Themes        = .F.
152:             .Visible       = .T.
153: 
154:             WITH .Buttons(1)
155:                 .Top             = 5
156:                 .Left            = 5
157:                 .Width           = 65
158:                 .Height          = 70
159:                 .Caption         = "Visualizar"
160:                 .FontBold        = .T.
161:                 .FontItalic      = .T.
162:                 .BackColor       = RGB(255, 255, 255)
163:                 .ForeColor       = RGB(90, 90, 90)
164:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 171 a 183:
171:             ENDWITH
172: 
173:             WITH .Buttons(2)
174:                 .Top             = 5
175:                 .Left            = 71
176:                 .Width           = 65
177:                 .Height          = 70
178:                 .Caption         = "Imprimir"
179:                 .FontName        = "Tahoma"
180:                 .FontBold        = .T.
181:                 .FontItalic      = .T.
182:                 .FontSize        = 8
183:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 192 a 204:
192:             ENDWITH
193: 
194:             WITH .Buttons(3)
195:                 .Top             = 5
196:                 .Left            = 137
197:                 .Width           = 65
198:                 .Height          = 70
199:                 .Caption         = "Excel"
200:                 .FontName        = "Tahoma"
201:                 .FontBold        = .T.
202:                 .FontItalic      = .T.
203:                 .FontSize        = 8
204:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 213 a 225:
213:             ENDWITH
214: 
215:             WITH .Buttons(4)
216:                 .Top             = 5
217:                 .Left            = 203
218:                 .Width           = 65
219:                 .Height          = 70
220:                 .Caption         = "Encerrar"
221:                 .Cancel          = .T.
222:                 .FontName        = "Tahoma"
223:                 .FontBold        = .T.
224:                 .FontItalic      = .T.
225:                 .FontSize        = 8

*-- Linhas 245 a 259:
245:         loc_oPgf = THIS.pgf_4c_Paginas
246: 
247:         loc_oPgf.PageCount = 1
248:         loc_oPgf.Top       = 85
249:         loc_oPgf.Left      = -1
250:         loc_oPgf.Width     = THIS.Width + 2
251:         loc_oPgf.Height    = THIS.Height - 85
252:         loc_oPgf.Tabs      = .F.
253: 
254:         loc_oPgf.Page1.Caption   = "Filtros"
255:         loc_oPgf.Page1.FontName  = "Tahoma"
256:         loc_oPgf.Page1.FontSize  = 8
257:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
258:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
259:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 270 a 278:
270:         LOCAL loc_oPagina
271:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
272: 
273:         loc_oPagina.Caption   = "Filtros"
274:         loc_oPagina.FontName  = "Tahoma"
275:         loc_oPagina.FontSize  = 8
276:         loc_oPagina.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
277:         loc_oPagina.BackColor = RGB(255, 255, 255)
278:         loc_oPagina.ForeColor = RGB(90, 90, 90)

*-- Linhas 320 a 601:
320:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
321: 
322:         * --- Empresa ---
323:         loc_oPg1.AddObject("lbl_4c_Lbl_empresa", "Label")
324:         WITH loc_oPg1.lbl_4c_Lbl_empresa
325:             .Top       = 23
326:             .Left      = 200
327:             .Width     = 52
328:             .Height    = 18
329:             .Caption   = "Empresa :"
330:             .FontName  = "Tahoma"
331:             .FontSize  = 8
332:             .ForeColor = RGB(90, 90, 90)
333:             .BackStyle = 0
334:             .Visible   = .T.
335:         ENDWITH
336: 
337:         loc_oPg1.AddObject("txt_4c_Emps", "TextBox")
338:         WITH loc_oPg1.txt_4c_Emps
339:             .Top         = 20
340:             .Left        = 254
341:             .Width       = 31
342:             .Height      = 23
343:             .Value       = ""
344:             .FontName    = "Tahoma"
345:             .FontSize    = 8
346:             .ToolTipText = "C" + CHR(243) + "digo da Empresa (F4=Buscar)"
347:             .Visible     = .T.
348:         ENDWITH
349: 
350:         loc_oPg1.AddObject("txt_4c_DEmps", "TextBox")
351:         WITH loc_oPg1.txt_4c_DEmps
352:             .Top       = 20
353:             .Left      = 288
354:             .Width     = 289
355:             .Height    = 23
356:             .Value     = ""
357:             .ReadOnly  = .T.
358:             .FontName  = "Tahoma"
359:             .FontSize  = 8
360:             .BackColor = RGB(240, 240, 240)
361:             .Visible   = .T.
362:         ENDWITH
363: 
364:         * --- Periodo ---
365:         loc_oPg1.AddObject("lbl_4c_Lbl_periodo", "Label")
366:         WITH loc_oPg1.lbl_4c_Lbl_periodo
367:             .Top       = 48
368:             .Left      = 205
369:             .Width     = 52
370:             .Height    = 18
371:             .Caption   = "Per" + CHR(237) + "odo :"
372:             .FontName  = "Tahoma"
373:             .FontSize  = 8
374:             .ForeColor = RGB(90, 90, 90)
375:             .BackStyle = 0
376:             .Visible   = .T.
377:         ENDWITH
378: 
379:         loc_oPg1.AddObject("txt_4c_DtIni", "TextBox")
380:         WITH loc_oPg1.txt_4c_DtIni
381:             .Top         = 45
382:             .Left        = 254
383:             .Width       = 82
384:             .Height      = 23
385:             .Value       = {}
386:             .Format      = "@D"
387:             .FontName    = "Tahoma"
388:             .FontSize    = 8
389:             .ToolTipText = "Data Inicial do Per" + CHR(237) + "odo"
390:             .Visible     = .T.
391:         ENDWITH
392: 
393:         loc_oPg1.AddObject("lbl_4c_Lbl_periodo_a", "Label")
394:         WITH loc_oPg1.lbl_4c_Lbl_periodo_a
395:             .Top       = 48
396:             .Left      = 340
397:             .Width     = 10
398:             .Height    = 18
399:             .Caption   = "a"
400:             .FontName  = "Tahoma"
401:             .FontSize  = 8
402:             .ForeColor = RGB(90, 90, 90)
403:             .BackStyle = 0
404:             .Visible   = .T.
405:         ENDWITH
406: 
407:         loc_oPg1.AddObject("txt_4c_DtFim", "TextBox")
408:         WITH loc_oPg1.txt_4c_DtFim
409:             .Top         = 45
410:             .Left        = 352
411:             .Width       = 82
412:             .Height      = 23
413:             .Value       = {}
414:             .Format      = "@D"
415:             .FontName    = "Tahoma"
416:             .FontSize    = 8
417:             .ToolTipText = "Data Final do Per" + CHR(237) + "odo"
418:             .Visible     = .T.
419:         ENDWITH
420: 
421:         * --- Usuario ---
422:         loc_oPg1.AddObject("lbl_4c_Label9", "Label")
423:         WITH loc_oPg1.lbl_4c_Label9
424:             .Top       = 73
425:             .Left      = 205
426:             .Width     = 52
427:             .Height    = 18
428:             .Caption   = "Usu" + CHR(225) + "rio :"
429:             .FontName  = "Tahoma"
430:             .FontSize  = 8
431:             .ForeColor = RGB(90, 90, 90)
432:             .BackStyle = 0
433:             .Visible   = .T.
434:         ENDWITH
435: 
436:         loc_oPg1.AddObject("txt_4c_Usuars", "TextBox")
437:         WITH loc_oPg1.txt_4c_Usuars
438:             .Top         = 70
439:             .Left        = 254
440:             .Width       = 82
441:             .Height      = 23
442:             .Value       = ""
443:             .FontName    = "Tahoma"
444:             .FontSize    = 8
445:             .ToolTipText = "Usu" + CHR(225) + "rio (F4=Buscar)"
446:             .Visible     = .T.
447:         ENDWITH
448: 
449:         * --- Condicao de Pagamento ---
450:         loc_oPg1.AddObject("lbl_4c_Label2", "Label")
451:         WITH loc_oPg1.lbl_4c_Label2
452:             .Top       = 98
453:             .Left      = 180
454:             .Width     = 75
455:             .Height    = 18
456:             .Caption   = "Cond. Pagto.:"
457:             .FontName  = "Tahoma"
458:             .FontSize  = 8
459:             .ForeColor = RGB(90, 90, 90)
460:             .BackStyle = 0
461:             .Visible   = .T.
462:         ENDWITH
463: 
464:         loc_oPg1.AddObject("txt_4c_FPags", "TextBox")
465:         WITH loc_oPg1.txt_4c_FPags
466:             .Top         = 95
467:             .Left        = 254
468:             .Width       = 94
469:             .Height      = 23
470:             .Value       = ""
471:             .FontName    = "Tahoma"
472:             .FontSize    = 8
473:             .ToolTipText = "Forma de Pagamento (F4=Buscar)"
474:             .Visible     = .T.
475:         ENDWITH
476: 
477:         * --- Tipos de Impressao ---
478:         loc_oPg1.AddObject("lbl_4c_Label1", "Label")
479:         WITH loc_oPg1.lbl_4c_Label1
480:             .Top       = 129
481:             .Left      = 176
482:             .Width     = 130
483:             .Height    = 18
484:             .Caption   = "Tipos de Impress" + CHR(227) + "o"
485:             .FontName  = "Tahoma"
486:             .FontSize  = 8
487:             .FontBold  = .T.
488:             .ForeColor = RGB(90, 90, 90)
489:             .BackStyle = 0
490:             .Visible   = .T.
491:         ENDWITH
492: 
493:         * --- Linha separadora ---
494:         loc_oPg1.AddObject("lin_4c_Line1", "Line")
495:         WITH loc_oPg1.lin_4c_Line1
496:             .Top     = 144
497:             .Left    = 176
498:             .Width   = 435
499:             .Height  = 1
500:             .Visible = .T.
501:         ENDWITH
502: 
503:         * --- CheckBox: Detalhado Por Operacao ---
504:         loc_oPg1.AddObject("chk_4c_ChkDetOpe", "CheckBox")
505:         WITH loc_oPg1.chk_4c_ChkDetOpe
506:             .Top      = 151
507:             .Left     = 176
508:             .Width    = 136
509:             .Height   = 15
510:             .Caption  = "Detalhado Por Opera" + CHR(231) + CHR(227) + "o"
511:             .Value    = 0
512:             .FontName = "Tahoma"
513:             .FontSize = 8
514:             .Visible  = .T.
515:         ENDWITH
516: 
517:         * --- CheckBox: Imprime Vendedor (habilitado apenas com chkDetOpe) ---
518:         loc_oPg1.AddObject("chk_4c_ChkVends", "CheckBox")
519:         WITH loc_oPg1.chk_4c_ChkVends
520:             .Top      = 151
521:             .Left     = 400
522:             .Width    = 105
523:             .Height   = 15
524:             .Caption  = "Imprime Vendedor"
525:             .Value    = 0
526:             .FontName = "Tahoma"
527:             .FontSize = 8
528:             .Enabled  = .F.
529:             .Visible  = .T.
530:         ENDWITH
531: 
532:         * --- TextBox: Vendedor (habilitado apenas com chkDetOpe + chkVends) ---
533:         loc_oPg1.AddObject("txt_4c_Vends", "TextBox")
534:         WITH loc_oPg1.txt_4c_Vends
535:             .Top         = 148
536:             .Left        = 532
537:             .Width       = 80
538:             .Height      = 23
539:             .Value       = ""
540:             .FontName    = "Tahoma"
541:             .FontSize    = 8
542:             .Enabled     = .F.
543:             .ToolTipText = "Vendedor (F4=Buscar)"
544:             .Visible     = .T.
545:         ENDWITH
546: 
547:         * --- CheckBox: Resumo Por Vendedor ---
548:         loc_oPg1.AddObject("chk_4c_ChkVendRes", "CheckBox")
549:         WITH loc_oPg1.chk_4c_ChkVendRes
550:             .Top      = 168
551:             .Left     = 176
552:             .Width    = 124
553:             .Height   = 15
554:             .Caption  = "Resumo Por Vendedor"
555:             .Value    = 0
556:             .FontName = "Tahoma"
557:             .FontSize = 8
558:             .Visible  = .T.
559:         ENDWITH
560: 
561:         * --- CheckBox: Resumo Por Formas de Pagamento (default ativo) ---
562:         loc_oPg1.AddObject("chk_4c_ChkResFpg", "CheckBox")
563:         WITH loc_oPg1.chk_4c_ChkResFpg
564:             .Top      = 186
565:             .Left     = 176
566:             .Width    = 185
567:             .Height   = 15
568:             .Caption  = "Resumo Por Formas de Pagamento"
569:             .Value    = 1
570:             .FontName = "Tahoma"
571:             .FontSize = 8
572:             .Visible  = .T.
573:         ENDWITH
574: 
575:         * --- CheckBox: Operacoes X Pagamentos (default ativo) ---
576:         loc_oPg1.AddObject("chk_4c_ChkOpePag", "CheckBox")
577:         WITH loc_oPg1.chk_4c_ChkOpePag
578:             .Top      = 204
579:             .Left     = 176
580:             .Width    = 141
581:             .Height   = 15
582:             .Caption  = "Opera" + CHR(231) + CHR(245) + "es X Pagamentos"
583:             .Value    = 1
584:             .FontName = "Tahoma"
585:             .FontSize = 8
586:             .Visible  = .T.
587:         ENDWITH
588: 
589:         * --- CheckBox: Analitico Por Pagamentos ---
590:         loc_oPg1.AddObject("chk_4c_ChkAnaPag", "CheckBox")
591:         WITH loc_oPg1.chk_4c_ChkAnaPag
592:             .Top      = 222
593:             .Left     = 176
594:             .Width    = 142
595:             .Height   = 15
596:             .Caption  = "Anal" + CHR(237) + "tico Por Pagamentos"
597:             .Value    = 0
598:             .FontName = "Tahoma"
599:             .FontSize = 8
600:             .Visible  = .T.
601:         ENDWITH

*-- Linhas 1178 a 1191:
1178:         loc_oPg1 = THIS.pgf_4c_Paginas.Page1
1179: 
1180:         WITH THIS.this_oRelatorio
1181:             loc_oPg1.txt_4c_Emps.Value        = .this_cEmps
1182:             loc_oPg1.txt_4c_DtIni.Value       = .this_dDtIni
1183:             loc_oPg1.txt_4c_DtFim.Value       = .this_dDtFim
1184:             loc_oPg1.txt_4c_Usuars.Value      = .this_cUsuars
1185:             loc_oPg1.txt_4c_FPags.Value       = .this_cFPags
1186:             loc_oPg1.txt_4c_Vends.Value       = .this_cVends
1187:             loc_oPg1.chk_4c_ChkDetOpe.Value  = IIF(.this_lDetOpe,  1, 0)
1188:             loc_oPg1.chk_4c_ChkVends.Value   = IIF(.this_lVends,   1, 0)
1189:             loc_oPg1.chk_4c_ChkVendRes.Value = IIF(.this_lVendRes, 1, 0)
1190:             loc_oPg1.chk_4c_ChkResFpg.Value  = IIF(.this_lResFpg,  1, 0)
1191:             loc_oPg1.chk_4c_ChkOpePag.Value  = IIF(.this_lOpePag,  1, 0)


### BO (C:\4c\projeto\app\classes\sigrefecBO.prg):
*==============================================================================
* SIGREFECBO.PRG
* Business Object para Relatorio de Fechamento de Caixa
* Herda de RelatorioBase
*
* Formulario original: SIGREFEC (sigrefec.SCX)
* Caption: "Fechamento de Caixa"
*==============================================================================

DEFINE CLASS sigrefecBO AS RelatorioBase

    *-- Filtro: Empresa
    this_cEmps       = ""    && Codigo da empresa (3)
    this_cDEmps      = ""    && Razao social da empresa (40)

    *-- Filtro: Periodo
    this_dDtIni      = {}    && Data inicial
    this_dDtFim      = {}    && Data final

    *-- Filtro: Usuario / Vendedor / Forma de Pagamento
    this_cUsuars     = ""    && Codigo do usuario (10)
    this_cVends      = ""    && Codigo do vendedor (10)
    this_cFPags      = ""    && Condicao de pagamento / forma (10)

    *-- Opcoes de impressao (checkboxes)
    this_lDetOpe     = .F.   && Detalhado Por Operacao
    this_lVends      = .F.   && Imprime Vendedor
    this_lOpePag     = .T.   && Operacoes X Pagamentos
    this_lResFpg     = .T.   && Resumo Por Formas de Pagamento
    this_lAnaPag     = .F.   && Analitico Por Pagamentos
    this_lVendRes    = .F.   && Resumo Por Vendedor

    *--------------------------------------------------------------------------
    * Init - Inicializa BO com valores padrao
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF !DODEFAULT()
                loc_lSucesso = .F.
            ENDIF

            THIS.this_cEmps  = go_4c_Sistema.cCodEmpresa
            THIS.this_dDtIni = DATE()
            THIS.this_dDtFim = DATE()

            loc_lSucesso = .T.
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "sigrefecBO.Init")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Wrapper com TRY/CATCH para PrepararDadosInterno
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            loc_lSucesso = THIS.PrepararDadosInterno()
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrefecBO.PrepararDados")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDadosInterno - Logica completa de preparacao (retorno direto OK)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PrepararDadosInterno()
        LOCAL loc_cSQL, loc_nResult, loc_cEdn, loc_cFPags
        LOCAL loc_cVista1EmpDopNums, loc_lnPri
        PRIVATE pDtI, pDtF

        pDtI    = THIS.this_dDtIni
        pDtF    = THIS.this_dDtFim + 1  && limite superior exclusivo (inicio do proximo dia)
        loc_cFPags = ALLTRIM(THIS.this_cFPags)

        *-- Query principal: todas as operacoes de fechamento de caixa do periodo
        loc_cSQL = "SELECT o.RelFechas, o.CalcFecs, e.EmpDopNums, e.Datas, " + ;
                   "e.ContaDs, c.RClis, e.Notas, e.Usuars, e.Valos, e.Vends, " + ;
                   "o.COpers, (o.NDopes * 1000000) + e.Numes AS Codigos, e.ChkSubn " + ;
                   "FROM SigCdOpe o, SigMvCab e, SigCdCli c " + ;
                   "WHERE (o.RelFechas = 1 OR o.RelFechas = 4 " + ;
                   "OR (o.RelFechas = 3 AND e.chkPagos = 1)) " + ;
                   "AND o.CalcFecs = 2 AND o.Dopes = e.Dopes " + ;
                   "AND e.Datas >= ?pDtI AND e.Datas < ?pDtF " + ;
                   "AND e.ContaDs = c.IClis AND e.lcancelas = 0"

        loc_cSQL = loc_cSQL + ;
                   " AND NOT e.EmpDopNums IN (" + ;
                   "SELECT a1.EmpDopNums FROM SigMvPec a1 " + ;
                   "WHERE a1.Codigos IN (" + ;
                   "SELECT (o1.NDopes * 1000000) + e1.Numes AS Codigos " + ;
                   "FROM SigCdOpe o1, SigMvCab e1 " + ;
                   "WHERE o1.RelFechas = 3 AND o1.CalcFecs = 2 " + ;
                   "AND o1.Dopes = e1.Dopes " + ;
                   "AND e1.Datas >= ?pDtI AND e1.Datas < ?pDtF))" + ;
                   " ORDER BY e.EmpDopNums"

        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crDados")
        IF loc_nResult < 1
            THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crDados)"
            MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
            RETURN .F.
        ENDIF

        *-- Remove vendas NF parceladas canceladas
        DELETE FROM crDados WHERE RelFechas = 1 AND ChkSubn = .T.

        *-- Substitui vendedor vazio pelo codigo do cliente
        UPDATE crDados SET Vends = ContaDs WHERE EMPTY(Vends)

        *-- Filtra por usuario se especificado
        IF !EMPTY(ALLTRIM(THIS.this_cUsuars))
            DELETE FROM crDados WHERE Usuars != PADR(ALLTRIM(THIS.this_cUsuars), 10)
        ENDIF

        *-- Cria cursor de pagamentos consolidados
        CREATE CURSOR crPagamentos ;
            (EmpDopNums C(29), Parcs N(3), FPags C(12), Bancos C(3), ;
             Agencias C(4), Contas C(10), Numeros C(6), Valos N(12,2), ;
             MoeFpgs C(3), Vencs D(8), Outros C(20), DetFecCxs N(1))

        *-- Para cada operacao, busca formas de pagamento
        SELECT crDados
        SCAN
            loc_cEdn = crDados.EmpDopNums

            *-- Tenta buscar pagamentos diretos em SigMvPar
            loc_cSQL = "SELECT a.EmpDopNums, a.Parcs, a.FPags, b.Formas, b.Infos, " + ;
                       "a.Bancos, a.Agencias, a.Contas, a.Numeros, " + ;
                       "CASE WHEN b.trocos=1 THEN -a.valos ELSE a.valos END AS valos, " + ;
                       "a.MoeFpgs, a.Vencs, a.Outros, b.DetFecCxs " + ;
                       "FROM SigMvPar a, SigOpFp b " + ;
                       "WHERE a.EmpDopNums = " + EscaparSQL(loc_cEdn) + ;
                       " AND a.FPags = b.FPags ORDER BY a.Parcs"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crPags1")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crPags1)"
                MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                RETURN .F.
            ENDIF

            SELECT crPags1
            GO TOP IN crPags1
            IF !EOF("crPags1")
                *-- Filtra por forma de pagamento especificada (se houver)
                SELECT * FROM crPags1 ;
                    WHERE IIF(EMPTY(loc_cFPags), .T., FPags = PADR(loc_cFPags, 12)) ;
                    INTO CURSOR crPags READWRITE
            ELSE
                *-- Operacao vinculada: busca via SigMvPec
                loc_cSQL = "SELECT b.EmpDopNums, b.Parcs, b.FPags, c.Formas, c.Infos, " + ;
                           "b.Bancos, b.Agencias, b.Contas, b.Numeros, " + ;
                           "CASE WHEN c.trocos=1 THEN -b.valos ELSE b.valos END AS valos, " + ;
                           "b.MoeFpgs, b.Vencs, b.Outros, c.DetFecCxs " + ;
                           "FROM SigMvPec a, SigMvPar b, SigOpFp c " + ;
                           "WHERE a.Codigos = " + LTRIM(STR(crDados.Codigos, 10)) + ;
                           " AND a.EmpDopNums = b.EmpDopNums AND b.FPags = c.FPags"

                IF !EMPTY(loc_cFPags)
                    loc_cSQL = loc_cSQL + " AND b.FPags = " + EscaparSQL(PADR(loc_cFPags, 12))
                ENDIF

                loc_cSQL = loc_cSQL + " ORDER BY b.Parcs"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crPags")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crPags)"
                    MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                    RETURN .F.
                ENDIF
            ENDIF

            SELECT crPags
            GO TOP IN crPags
            IF EOF("crPags") AND !EMPTY(loc_cFPags)
                DELETE IN crDados
            ELSE
                SCAN
                    SCATTER MEMVAR MEMO
                    m.EmpDopNums = loc_cEdn
                    m.FPags = IIF(m.Infos = "B" AND !EMPTY(m.Formas), m.Formas, m.FPags)
                    INSERT INTO crPagamentos FROM MEMVAR
                ENDSCAN
            ENDIF
        ENDSCAN

        *-- Monta crDetalhe: JOIN entre crDados e crPagamentos
        SELECT LEFT(a.EmpDopNums, 3) AS Emps, ;
               SUBSTR(a.EmpDopNums, 4, 20) AS Dopes, ;
               RIGHT(a.EmpDopNums, 6) AS Numes, ;
               a.Datas, a.ContaDs AS IClis, a.RClis, a.Notas, ;
               a.Valos * IIF(a.COpers = 2, -1, 1) AS Valos, ;
               a.Vends, SPACE(30) AS NVends, a.Codigos, a.Usuars, ;
               b.Parcs, b.FPags, b.Bancos, b.Agencias, b.Contas, ;
               b.Numeros, b.Valos * IIF(a.COpers = 2, -1, 1) AS ValPagos, ;
               b.MoeFpgs, b.Vencs, b.DetFecCxs, b.Outros, ;
               a.RelFechas, a.CalcFecs, ;
               SPACE(32) AS RPags, SPACE(32) AS RChqs ;
            FROM crDados a RIGHT JOIN crPagamentos b ;
            ON a.EmpDopNums = b.EmpDopNums ;
            ORDER BY a.Datas, a.EmpDopNums, b.Parcs ;
            INTO CURSOR crDetalhe READWRITE

        *-- Preenche NVends e campos de vista (RPags/RChqs) em crDetalhe
        SELECT crDetalhe
        SCAN
            IF crDetalhe.RelFechas = 3 AND crDetalhe.CalcFecs = 2
                *-- Reconstroi EmpDopNums a partir dos campos fixos (sem ALLTRIM - fixed-width)
                loc_cEdn = crDetalhe.Emps + crDetalhe.Dopes + crDetalhe.Numes

                loc_cSQL = "SELECT p.EmpDopNums " + ;
                           "FROM SigMvPec p " + ;
                           "WHERE p.Codigos = " + LTRIM(STR(crDetalhe.Codigos, 10)) + ;
                           " ORDER BY p.EmpDopNums"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crVista1")
                IF loc_nResult < 1
                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crVista1)"
                    MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                    RETURN .F.
                ENDIF

                SELECT crVista1
                GO TOP IN crVista1
                IF !EOF("crVista1")
                    loc_cVista1EmpDopNums = crVista1.EmpDopNums

                    loc_cSQL = "SELECT r.Parcs, r.FPags, r.Valos, r.Vencs, " + ;
                               "r.Contas, r.Numeros " + ;
                               "FROM SigMvPar r " + ;
                               "WHERE r.EmpDopNums = " + EscaparSQL(loc_cVista1EmpDopNums) + ;
                               " AND r.Parcs = " + LTRIM(STR(crDetalhe.Parcs, 2)) + ;
                               " ORDER BY r.Parcs"

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crVista")
                    IF loc_nResult < 1
                        THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crVista)"
                        MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                        RETURN .F.
                    ENDIF

                    loc_lnPri = 1
                    SELECT crVista
                    SCAN
                        IF !ISNULL(crVista.FPags)
                            IF loc_lnPri > 1
                                loc_cSQL = "SELECT NComps FROM SigCdUsu " + ;
                                           "WHERE Usuarios = " + EscaparSQL(crDetalhe.Vends)

                                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crNVends")
                                IF loc_nResult < 1
                                    THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crNVends)"
                                    MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                                    RETURN .F.
                                ENDIF

                                SELECT crNVends
                                GO TOP IN crNVends
                                IF !EOF("crNVends")
                                    REPLACE NVends WITH crNVends.NComps IN crDetalhe
                                ENDIF

                                SKIP IN crDetalhe
                            ENDIF

                            REPLACE RPags WITH LTRIM(STR(loc_lnPri, 2)) + " " + crVista.FPags + ;
                                    " " + SPACE(6) + ;
                                    TRANSFORM(crVista.Valos, "999,999.99") IN crDetalhe

                            IF !EMPTY(crVista.Numeros)
                                REPLACE RChqs WITH crVista.Contas + " / " + crVista.Numeros + ;
                                        "  " + DTOC(crVista.Vencs) IN crDetalhe
                            ENDIF

                            loc_lnPri = loc_lnPri + 1
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDIF

            *-- Preenche nome do vendedor para todas as linhas
            loc_cSQL = "SELECT NComps FROM SigCdUsu WHERE Usuarios = " + ;
                       EscaparSQL(crDetalhe.Vends)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "crNVends")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na Conex" + CHR(227) + CHR(227) + "o (crNVends)"
                MsgErro(THIS.this_cMensagemErro, "sigrefecBO.PrepararDadosInterno")
                RETURN .F.
            ENDIF

            SELECT crNVends
            GO TOP IN crNVends
            IF !EOF("crNVends")
                REPLACE NVends WITH crNVends.NComps IN crDetalhe
            ENDIF
        ENDSCAN

        *-- Monta impressao linha a linha em crImpressao
        CREATE CURSOR crImpressao (Detalhe C(40))

        SET POINT TO ","
        SET SEPARATOR TO "."

        THIS.Cabecalho()

        IF THIS.this_lDetOpe
            THIS.Detalhado()
        ENDIF

        IF THIS.this_lVendRes
            THIS.ResVends()
        ENDIF

        IF THIS.this_lResFpg
            THIS.ResumoPagto()
        ENDIF

        IF THIS.this_lOpePag
            THIS.PagtoXFpags()
        ENDIF

        IF THIS.this_lAnaPag
            THIS.AnaFPags()
        ENDIF

        SET POINT TO "."
        SET SEPARATOR TO ","

        SELECT crImpressao
        GO TOP IN crImpressao

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Cabecalho - Insere cabecalho do relatorio em crImpressao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Cabecalho()
        LOCAL loc_cDEmps, loc_dDtIni, loc_dDtFim, loc_cUsuars

        loc_cDEmps  = ALLTRIM(THIS.this_cDEmps)
        loc_dDtIni  = THIS.this_dDtIni
        loc_dDtFim  = THIS.this_dDtFim
        loc_cUsuars = ALLTRIM(THIS.this_cUsuars)

        INSERT INTO crImpressao (Detalhe) VALUES ("========================================")
        INSERT INTO crImpressao (Detalhe) VALUES (PADC(loc_cDEmps, 40))
        INSERT INTO crImpressao (Detalhe) VALUES ("   Caixas de: " + DTOC(loc_dDtIni) + ;
            " " + CHR(224) + " " + DTOC(loc_dDtFim))
        INSERT INTO crImpressao (Detalhe) VALUES ("   Usuario  : " + ;
            IIF(EMPTY(loc_cUsuars), "GERAL", loc_cUsuars))
        INSERT INTO crImpressao (Detalhe) VALUES ("   Fechamento em " + DTOC(DATE()) + ;
            " " + CHR(224) + "s " + SUBSTR(TTOC(DATETIME()), 12, 5) + "h")
        INSERT INTO crImpressao (Detalhe) VALUES ("========================================")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * Detalhado - Secao detalhada por operacao
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Detalhado()
        LOCAL loc_cVen, loc_cVal, loc_lnTot, loc_cCli, loc_cVdd

        loc_cVen   = ALLTRIM(THIS.this_cVends)
        loc_lnTot  = 0

        IF EMPTY(loc_cVen)
            IF THIS.this_lVends
                SELECT Vends, Dopes, SUM(IIF(RelFechas=4, 0.00, ValPagos)) AS Valos ;
                    FROM crDetalhe ;
                    GROUP BY Vends, Dopes ;
                    ORDER BY Dopes, Vends ;
                    INTO CURSOR TmpOperacoes
            ELSE
                SELECT SPACE(10) AS Vends, Dopes, ;
                       SUM(IIF(RelFechas=4, 0.00, ValPagos)) AS Valos ;
                    FROM crDetalhe ;
                    GROUP BY Dopes ;
                    ORDER BY Dopes ;
                    INTO CURSOR TmpOperacoes
            ENDIF
        ELSE
            SELECT Vends, Dopes, SUM(IIF(RelFechas=4, 0.00, ValPagos)) AS Valos ;
                FROM crDetalhe ;
                WHERE Vends = loc_cVen ;
                GROUP BY Vends, Dopes ;
                ORDER BY Dopes, Vends ;
                INTO CURSOR TmpOperacoes
        ENDIF

        INSERT INTO crImpressao (Detalhe) VALUES ("======== DETALHADO POR OPERACAO ========")

        SELECT TmpOperacoes
        SCAN
            loc_lnTot = loc_lnTot + TmpOperacoes.Valos

            loc_cVal = TRANSFORM(TmpOperacoes.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpOperacoes.Dopes + ":   " + loc_cVal)

            IF EMPTY(loc_cVen)
                IF THIS.this_lVends
                    SELECT DISTINCT Vends, Dopes, Numes ;
                        FROM crDetalhe ;
                        WHERE Dopes = TmpOperacoes.Dopes AND Vends = TmpOperacoes.Vends ;
                        ORDER BY Dopes, Vends, Numes ;
                        INTO CURSOR TmpOpeIndivs
                ELSE
                    SELECT DISTINCT Dopes, Numes ;
                        FROM crDetalhe ;
                        WHERE Dopes = TmpOperacoes.Dopes ;
                        ORDER BY Dopes, Numes ;
                        INTO CURSOR TmpOpeIndivs
                ENDIF
            ELSE
                SELECT DISTINCT Dopes, Numes ;
                    FROM crDetalhe ;
                    WHERE Dopes = TmpOperacoes.Dopes AND Vends = loc_cVen ;
                    ORDER BY Dopes, Numes ;
                    INTO CURSOR TmpOpeIndivs
            ENDIF

            SELECT TmpOpeIndivs
            SCAN
                SELECT IClis, RClis, Notas, Vends, NVends, Parcs, FPags, ValPagos, ;
                       Vencs, Bancos, Agencias, Contas, Numeros, RelFechas ;
                    FROM crDetalhe ;
                    WHERE Dopes = TmpOpeIndivs.Dopes AND Numes = TmpOpeIndivs.Numes ;
                    ORDER BY Parcs ;
                    INTO CURSOR TmpOpePags

                SELECT TmpOpePags
                SCAN
                    loc_cVal = TRANSFORM(TmpOpePags.ValPagos, "999,999,999.99")

                    IF TmpOpePags.Parcs = 1
                        INSERT INTO crImpressao (Detalhe) VALUES ("> " + ;
                            PADL(ALLTRIM(TmpOpeIndivs.Numes), 6, "0") + ;
                            " (" + PADL(TmpOpePags.Parcs, 2, "0") + ") " + ;
                            TmpOpePags.FPags + loc_cVal)
                    ELSE
                        INSERT INTO crImpressao (Detalhe) VALUES ("        " + ;
                            " (" + PADL(TmpOpePags.Parcs, 2, "0") + ") " + ;
                            TmpOpePags.FPags + loc_cVal)
                    ENDIF

                    IF !EMPTY(TmpOpePags.Numeros)
                        INSERT INTO crImpressao (Detalhe) VALUES ("         " + ;
                            TmpOpePags.Contas + " / " + TmpOpePags.Numeros + ;
                            "  " + DTOC(TmpOpePags.Vencs))
                    ENDIF
                ENDSCAN

                SELECT TmpOpePags
                GO TOP IN TmpOpePags
                IF !EOF("TmpOpePags")
                    loc_cCli = PADR(ALLTRIM(TmpOpePags.IClis) + " - " + ;
                                    ALLTRIM(TmpOpePags.RClis), 31)
                    INSERT INTO crImpressao (Detalhe) VALUES ("  " + loc_cCli + " " + TmpOpePags.Notas)
                ENDIF

                IF THIS.this_lVends
                    SELECT TmpOpePags
                    GO TOP IN TmpOpePags
                    IF !EOF("TmpOpePags")
                        IF EMPTY(TmpOpePags.Vends)
                            loc_cVdd = ALLTRIM(TmpOpePags.IClis) + " - " + ALLTRIM(TmpOpePags.RClis)
                        ELSE
                            loc_cVdd = ALLTRIM(TmpOpePags.Vends) + " - " + ALLTRIM(TmpOpePags.NVends)
                        ENDIF
                        INSERT INTO crImpressao (Detalhe) VALUES ("  " + loc_cVdd)
                    ENDIF
                ENDIF
            ENDSCAN

            INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("=           TOTAL GERAL : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * PagtoXFpags - Secao Operacoes X Formas de Pagamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE PagtoXFpags()
        LOCAL loc_cVal, loc_lnTot, loc_lnGer

        SELECT Dopes, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            GROUP BY Dopes ;
            ORDER BY Dopes ;
            INTO CURSOR TmpOperacoes

        INSERT INTO crImpressao (Detalhe) VALUES ("==== RESUMO: OPERACOES X PAGAMENTOS ====")
        INSERT INTO crImpressao (Detalhe) VALUES ("")

        loc_lnGer = 0
        SELECT TmpOperacoes
        SCAN
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpOperacoes.Dopes)

            SELECT DetFecCxs, RelFechas, FPags, SUM(ValPagos) AS Valos ;
                FROM crDetalhe ;
                WHERE Dopes = TmpOperacoes.Dopes ;
                GROUP BY DetFecCxs, RelFechas, FPags ;
                ORDER BY FPags ;
                INTO CURSOR TmpFPags

            loc_lnTot = 0
            SELECT TmpFPags
            SCAN
                loc_lnGer = loc_lnGer + IIF(RelFechas=4, 0, TmpFPags.Valos)
                loc_lnTot = loc_lnTot + IIF(RelFechas=4, 0, TmpFPags.Valos)

                loc_cVal = TRANSFORM(TmpFPags.Valos, "999,999,999.99")
                INSERT INTO crImpressao (Detalhe) VALUES ("  " + TmpFPags.FPags + " : " + loc_cVal)

                IF TmpFPags.DetFecCxs = 1 AND TmpFPags.RelFechas = 3
                    SELECT Notas, FPags, SUM(ValPagos) AS ValPagos, ;
                           Vencs, Bancos, Agencias, Contas, Numeros, Outros ;
                        FROM crDetalhe ;
                        WHERE Dopes = TmpOperacoes.Dopes AND FPags = TmpFPags.FPags ;
                        GROUP BY Notas, FPags, Vencs, Bancos, Agencias, Contas, Numeros, Outros ;
                        ORDER BY Notas ;
                        INTO CURSOR TmpOpeChqs

                    SELECT TmpOpeChqs
                    SCAN
                        IF !EMPTY(TmpOpeChqs.Outros)
                            loc_cVal = TRANSFORM(TmpOpeChqs.ValPagos, "999,999.99")
                            INSERT INTO crImpressao (Detalhe) VALUES ("  " + TmpOpeChqs.Notas + ;
                                " " + TmpOpeChqs.Outros + " " + loc_cVal)
                        ENDIF

                        IF !EMPTY(TmpOpeChqs.Numeros)
                            loc_cVal = TRANSFORM(TmpOpeChqs.ValPagos, "99,999,999.99")
                            INSERT INTO crImpressao (Detalhe) VALUES ("  " + TmpOpeChqs.Notas + ;
                                " " + DTOC(TmpOpeChqs.Vencs) + " " + ;
                                TmpOpeChqs.Numeros + " " + loc_cVal)
                        ENDIF
                    ENDSCAN
                ENDIF
            ENDSCAN

            loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
            INSERT INTO crImpressao (Detalhe) VALUES ("      SUBTOTAL : " + loc_cVal)
            INSERT INTO crImpressao (Detalhe) VALUES ("")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnGer, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("  TOTAL GERAL  : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * ResumoPagto - Secao Resumo Por Formas de Pagamento
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResumoPagto()
        LOCAL loc_cVal, loc_lnTot

        SELECT IIF(RelFechas=4, PADR("VALE", 12), FPags) AS FPags, ;
               RelFechas, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            GROUP BY 1, 2 ;
            ORDER BY 1 ;
            INTO CURSOR TmpFPags

        INSERT INTO crImpressao (Detalhe) VALUES ("==== RESUMO POR FORMAS DE PAGAMENTO ====")
        INSERT INTO crImpressao (Detalhe) VALUES ("")

        loc_lnTot = 0
        SELECT TmpFPags
        SCAN
            loc_lnTot = loc_lnTot + TmpFPags.Valos
            loc_cVal = TRANSFORM(TmpFPags.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpFPags.FPags + " : " + loc_cVal)
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("= TOTAL GERAL  : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")

        *-- Subtotal especifico VALE + DINHEIRO + TROCO
        SELECT IIF(RelFechas=4, PADR("VALE", 12), FPags) AS FPags, ;
               RelFechas, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            WHERE RelFechas = 4 OR INLIST(FPags, "DINHEIRO    ", "TROCO       ") ;
            GROUP BY 1, 2 ;
            ORDER BY 1 ;
            INTO CURSOR TmpFPags

        INSERT INTO crImpressao (Detalhe) VALUES ("")

        loc_lnTot = 0
        SELECT TmpFPags
        SCAN
            loc_lnTot = loc_lnTot + TmpFPags.Valos
            loc_cVal = TRANSFORM(TmpFPags.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpFPags.FPags + " : " + loc_cVal)
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("                 --------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("= TOTAL ESPECIE: " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * ResVends - Secao Resumo Por Vendedor
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ResVends()
        LOCAL loc_cVal, loc_lnTot

        SELECT Vends, SUM(ValPagos) AS Valos ;
            FROM crDetalhe ;
            GROUP BY Vends ;
            ORDER BY Vends ;
            INTO CURSOR TmpOperacoes

        INSERT INTO crImpressao (Detalhe) VALUES ("========= RESUMO POR VENDEDOR ==========")

        loc_lnTot = 0
        SELECT TmpOperacoes
        SCAN
            loc_lnTot = loc_lnTot + TmpOperacoes.Valos

            loc_cVal = TRANSFORM(TmpOperacoes.Valos, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("= " + TmpOperacoes.Vends + ;
                "            : " + loc_cVal)

            SELECT Dopes, SUM(ValPagos) AS Valos ;
                FROM crDetalhe ;
                WHERE Vends = TmpOperacoes.Vends ;
                GROUP BY Dopes ;
                ORDER BY Dopes ;
                INTO CURSOR TmpDopes

            SELECT TmpDopes
            SCAN
                loc_cVal = TRANSFORM(TmpDopes.Valos, "999,999,999.99")
                INSERT INTO crImpressao (Detalhe) VALUES ("   " + TmpDopes.Dopes + " : " + loc_cVal)
            ENDSCAN

            INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("= TOTAL GERAL:            " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * AnaFPags - Secao Analitico Por Pagamentos
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE AnaFPags()
        LOCAL loc_cVal, loc_lnTot, loc_lnSub

        INSERT INTO crImpressao (Detalhe) VALUES ("======= ANALITICO POR PAGAMENTOS =======")

        SELECT DISTINCT FPags ;
            FROM crDetalhe ;
            ORDER BY FPags ;
            INTO CURSOR TmpFPags

        loc_lnTot = 0

        SELECT TmpFPags
        SCAN
            SELECT IIF(RelFechas=4, PADR("VALE", 12), FPags) AS FPags, ;
                   RPags, RChqs, RelFechas, Vends, Notas, Parcs, ;
                   ValPagos, Contas, Numeros, Vencs ;
                FROM crDetalhe ;
                WHERE FPags = TmpFPags.FPags ;
                ORDER BY FPags, Vends, Notas, Parcs ;
                INTO CURSOR TmpOpePags

            loc_lnSub = 0

            SELECT TmpOpePags
            SCAN
                loc_lnTot = loc_lnTot + TmpOpePags.ValPagos
                loc_lnSub = loc_lnSub + TmpOpePags.ValPagos

                loc_cVal = TRANSFORM(TmpOpePags.ValPagos, "999,999.99")

                IF TmpOpePags.Parcs = 1
                    INSERT INTO crImpressao (Detalhe) VALUES (PADR(TmpOpePags.FPags, 10) + " " + ;
                        PADR(TmpOpePags.Vends, 9) + TmpOpePags.Notas + ;
                        "/" + PADL(TmpOpePags.Parcs, 2, "0") + " " + loc_cVal)
                ELSE
                    INSERT INTO crImpressao (Detalhe) VALUES ("                    " + ;
                        TmpOpePags.Notas + "/" + PADL(TmpOpePags.Parcs, 2, "0") + " " + loc_cVal)
                ENDIF

                IF !EMPTY(TmpOpePags.Numeros)
                    INSERT INTO crImpressao (Detalhe) VALUES ("         " + ;
                        TmpOpePags.Contas + " / " + TmpOpePags.Numeros + ;
                        "  " + DTOC(TmpOpePags.Vencs))
                ENDIF

                IF !EMPTY(TmpOpePags.RPags)
                    INSERT INTO crImpressao (Detalhe) VALUES ("        " + TmpOpePags.RPags)

                    IF !EMPTY(TmpOpePags.RChqs)
                        INSERT INTO crImpressao (Detalhe) VALUES ("         " + TmpOpePags.RChqs)
                    ENDIF
                ENDIF
            ENDSCAN

            loc_cVal = TRANSFORM(loc_lnSub, "999,999,999.99")
            INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
            INSERT INTO crImpressao (Detalhe) VALUES ("=              SUBTOTAL : " + loc_cVal)
            INSERT INTO crImpressao (Detalhe) VALUES ("")
        ENDSCAN

        loc_cVal = TRANSFORM(loc_lnTot, "999,999,999.99")
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("=           TOTAL GERAL : " + loc_cVal)
        INSERT INTO crImpressao (Detalhe) VALUES ("----------------------------------------")
        INSERT INTO crImpressao (Detalhe) VALUES ("")
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia para impressora
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "RelSigReFec") TO PRINTER PROMPT NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrefecBO.Imprimir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe preview do relatorio
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        TRY
            IF THIS.PrepararDados()
                REPORT FORM (gc_4c_CaminhoReports + "RelSigReFec") PREVIEW NOCONSOLE
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "sigrefecBO.Visualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultimo erro registrado
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao possui chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

ENDDEFINE

