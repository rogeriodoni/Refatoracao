# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (6)
- [LAYOUT-POSITION] Controle 'previsao' (parent: SIGCDPCP.Pagina.Lista): Top original=84 vs migrado 'lbl_4c_SepPrevisao' Top=213 (diff=129px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'previsao' (parent: SIGCDPCP.Pagina.Lista): Left original=133 vs migrado 'lbl_4c_SepPrevisao' Left=681 (diff=548px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Processa' (parent: SIGCDPCP.Pagina.Lista): Top original=84 vs migrado 'cmd_4c_Processar' Top=41 (diff=43px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Processa' (parent: SIGCDPCP.Pagina.Lista): Left original=13 vs migrado 'cmd_4c_Processar' Left=750 (diff=737px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Conta' (parent: SIGCDPCP.Pagina.Dados): Top original=249 vs migrado 'lbl_4c_LblConta' Top=286 (diff=37px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'Conta' (parent: SIGCDPCP.Pagina.Dados): Left original=240 vs migrado 'lbl_4c_LblConta' Left=195 (diff=45px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\cadastros\FormPcp.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1656 linhas total):

*-- Linhas 73 a 113:
73:             loc_oPgf = THIS.pgf_4c_Paginas
74: 
75:             WITH loc_oPgf
76:                 .Top       = -29
77:                 .Left      = 0
78:                 .Width     = THIS.Width
79:                 .Height    = THIS.Height + 29
80:                 .Tabs      = .F.
81:                 .PageCount = 2
82:                 .Themes    = .F.
83:                 .Visible   = .T.
84:             ENDWITH
85: 
86:             loc_oPgf.Pages(1).Caption = "Lista"
87:             loc_oPgf.Pages(2).Caption = "Dados"
88: 
89:             THIS.ConfigurarPaginaLista()
90:             THIS.ConfigurarPaginaDados()
91: 
92:             loc_oPgf.Pages(1).cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
93:             loc_oPgf.Pages(1).cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
94: 
95:             loc_oPgf.ActivePage = 1
96:         CATCH TO loc_oErro
97:             MsgErro("Erro em FormPcp.ConfigurarPageFrame: " + loc_oErro.Message, "Erro")
98:         ENDTRY
99:     ENDPROC
100: 
101:     *==========================================================================
102:     * ConfigurarPaginaLista - Cria Page1 completa (Lista)
103:     *   cnt_4c_Cabecalho  : barra de titulo escura
104:     *   cnt_4c_Botoes     : Incluir/Visualizar/Alterar/Excluir/Buscar
105:     *   cnt_4c_Saida      : Encerrar (canonico Left=917)
106:     *   cmd_4c_Processa   : abre mapa SigPcCpc (Top orig=84 -> 113)
107:     *   cmd_4c_Previsao   : abre relatorio SigRePcp
108:     *   cmd_4c_Prioridade : abre SigPrPcp
109:     *   grd_4c_Lista      : grid Codigos/Titulos/Datas (Top orig=145 -> 174)
110:     *==========================================================================
111:     PROTECTED PROCEDURE ConfigurarPaginaLista()
112:         LOCAL loc_oPage, loc_oCntCab, loc_oCntBot, loc_oCntSai, loc_oGrid, loc_oErro
113: 

*-- Linhas 119 a 156:
119:             loc_oPage.AddObject("cnt_4c_Cabecalho", "Container")
120:             loc_oCntCab = loc_oPage.cnt_4c_Cabecalho
121:             WITH loc_oCntCab
122:                 .Top         = 31
123:                 .Left        = 0
124:                 .Width       = THIS.Width
125:                 .Height      = 80
126:                 .BackStyle   = 1
127:                 .BackColor   = RGB(100, 100, 100)
128:                 .BorderWidth = 0
129:                 .Visible     = .T.
130:             ENDWITH
131: 
132:             loc_oCntCab.AddObject("lbl_4c_Sombra", "Label")
133:             WITH loc_oCntCab.lbl_4c_Sombra
134:                 .Caption   = THIS.Caption
135:                 .Top       = 15
136:                 .Left      = 10
137:                 .Width     = 769
138:                 .Height    = 40
139:                 .FontName  = "Tahoma"
140:                 .FontSize  = 16
141:                 .FontBold  = .T.
142:                 .ForeColor = RGB(0, 0, 0)
143:                 .BackStyle = 0
144:                 .Visible   = .T.
145:             ENDWITH
146: 
147:             loc_oCntCab.AddObject("lbl_4c_Titulo", "Label")
148:             WITH loc_oCntCab.lbl_4c_Titulo
149:                 .Caption   = THIS.Caption
150:                 .Top       = 18
151:                 .Left      = 10
152:                 .Width     = 769
153:                 .Height    = 46
154:                 .FontName  = "Tahoma"
155:                 .FontSize  = 16
156:                 .FontBold  = .T.

*-- Linhas 163 a 187:
163:             loc_oPage.AddObject("cnt_4c_Botoes", "Container")
164:             loc_oCntBot = loc_oPage.cnt_4c_Botoes
165:             WITH loc_oCntBot
166:                 .Top         = 29
167:                 .Left        = 542
168:                 .Width       = 390
169:                 .Height      = 85
170:                 .BackStyle   = 1
171:                 .BackColor   = RGB(53, 53, 53)
172:                 .BorderWidth = 0
173:                 .Visible     = .T.
174:             ENDWITH
175: 
176:             loc_oCntBot.AddObject("cmd_4c_Incluir", "CommandButton")
177:             WITH loc_oCntBot.cmd_4c_Incluir
178:                 .Caption         = "Incluir"
179:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_26.jpg"
180:                 .PicturePosition = 13
181:                 .Top             = 5
182:                 .Left            = 5
183:                 .Width           = 75
184:                 .Height          = 75
185:                 .BackColor       = RGB(255, 255, 255)
186:                 .ForeColor       = RGB(90, 90, 90)
187:                 .FontName        = "Tahoma"

*-- Linhas 194 a 210:
194:                 .MousePointer    = 15
195:                 .Visible         = .T.
196:             ENDWITH
197:             BINDEVENT(loc_oCntBot.cmd_4c_Incluir, "Click", THIS, "BtnIncluirClick")
198: 
199:             loc_oCntBot.AddObject("cmd_4c_Visualizar", "CommandButton")
200:             WITH loc_oCntBot.cmd_4c_Visualizar
201:                 .Caption         = "Visualizar"
202:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_vizualizar_60.jpg"
203:                 .PicturePosition = 13
204:                 .Top             = 5
205:                 .Left            = 80
206:                 .Width           = 75
207:                 .Height          = 75
208:                 .BackColor       = RGB(255, 255, 255)
209:                 .ForeColor       = RGB(90, 90, 90)
210:                 .FontName        = "Tahoma"

*-- Linhas 217 a 233:
217:                 .MousePointer    = 15
218:                 .Visible         = .T.
219:             ENDWITH
220:             BINDEVENT(loc_oCntBot.cmd_4c_Visualizar, "Click", THIS, "BtnVisualizarClick")
221: 
222:             loc_oCntBot.AddObject("cmd_4c_Alterar", "CommandButton")
223:             WITH loc_oCntBot.cmd_4c_Alterar
224:                 .Caption         = "Alterar"
225:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_alterar_60.jpg"
226:                 .PicturePosition = 13
227:                 .Top             = 5
228:                 .Left            = 155
229:                 .Width           = 75
230:                 .Height          = 75
231:                 .BackColor       = RGB(255, 255, 255)
232:                 .ForeColor       = RGB(90, 90, 90)
233:                 .FontName        = "Tahoma"

*-- Linhas 240 a 256:
240:                 .MousePointer    = 15
241:                 .Visible         = .T.
242:             ENDWITH
243:             BINDEVENT(loc_oCntBot.cmd_4c_Alterar, "Click", THIS, "BtnAlterarClick")
244: 
245:             loc_oCntBot.AddObject("cmd_4c_Excluir", "CommandButton")
246:             WITH loc_oCntBot.cmd_4c_Excluir
247:                 .Caption         = "Excluir"
248:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
249:                 .PicturePosition = 13
250:                 .Top             = 5
251:                 .Left            = 230
252:                 .Width           = 75
253:                 .Height          = 75
254:                 .BackColor       = RGB(255, 255, 255)
255:                 .ForeColor       = RGB(90, 90, 90)
256:                 .FontName        = "Tahoma"

*-- Linhas 263 a 279:
263:                 .MousePointer    = 15
264:                 .Visible         = .T.
265:             ENDWITH
266:             BINDEVENT(loc_oCntBot.cmd_4c_Excluir, "Click", THIS, "BtnExcluirClick")
267: 
268:             loc_oCntBot.AddObject("cmd_4c_Buscar", "CommandButton")
269:             WITH loc_oCntBot.cmd_4c_Buscar
270:                 .Caption         = "Buscar"
271:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_procurar_60.jpg"
272:                 .PicturePosition = 13
273:                 .Top             = 5
274:                 .Left            = 305
275:                 .Width           = 75
276:                 .Height          = 75
277:                 .BackColor       = RGB(255, 255, 255)
278:                 .ForeColor       = RGB(90, 90, 90)
279:                 .FontName        = "Tahoma"

*-- Linhas 286 a 315:
286:                 .MousePointer    = 15
287:                 .Visible         = .T.
288:             ENDWITH
289:             BINDEVENT(loc_oCntBot.cmd_4c_Buscar, "Click", THIS, "BtnBuscarClick")
290: 
291:             *-- Encerrar canonico (Left=917 conforme padrao do sistema)
292:             loc_oPage.AddObject("cnt_4c_Saida", "Container")
293:             loc_oCntSai = loc_oPage.cnt_4c_Saida
294:             WITH loc_oCntSai
295:                 .Top         = 29
296:                 .Left        = 917
297:                 .Width       = 90
298:                 .Height      = 85
299:                 .BackStyle   = 0
300:                 .BorderWidth = 0
301:                 .Visible     = .T.
302:             ENDWITH
303: 
304:             loc_oCntSai.AddObject("cmd_4c_Encerrar", "CommandButton")
305:             WITH loc_oCntSai.cmd_4c_Encerrar
306:                 .Caption         = "Encerrar"
307:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
308:                 .PicturePosition = 13
309:                 .Top             = 5
310:                 .Left            = 5
311:                 .Width           = 75
312:                 .Height          = 75
313:                 .BackColor       = RGB(255, 255, 255)
314:                 .ForeColor       = RGB(90, 90, 90)
315:                 .FontName        = "Tahoma"

*-- Linhas 322 a 394:
322:                 .MousePointer    = 15
323:                 .Visible         = .T.
324:             ENDWITH
325:             BINDEVENT(loc_oCntSai.cmd_4c_Encerrar, "Click", THIS, "BtnEncerrarClick")
326: 
327:             *-- Botoes operacionais especificos do PCP
328:             *-- Top original=84; PageFrame.Top=-29 => compensacao +29 => Top=113
329:             loc_oPage.AddObject("cmd_4c_Processa", "CommandButton")
330:             WITH loc_oPage.cmd_4c_Processa
331:                 .Caption       = "\<Mapa"
332:                 .Top           = 113
333:                 .Left          = 13
334:                 .Width         = 120
335:                 .Height        = 45
336:                 .FontName      = "Tahoma"
337:                 .FontSize      = 8
338:                 .BackColor     = RGB(255, 255, 255)
339:                 .ForeColor     = RGB(90, 90, 90)
340:                 .Themes        = .F.
341:                 .SpecialEffect = 0
342:                 .MousePointer  = 15
343:                 .Visible       = .T.
344:             ENDWITH
345:             BINDEVENT(loc_oPage.cmd_4c_Processa, "Click", THIS, "BtnProcessaClick")
346: 
347:             loc_oPage.AddObject("cmd_4c_Previsao", "CommandButton")
348:             WITH loc_oPage.cmd_4c_Previsao
349:                 .Caption       = "\<Previsao"
350:                 .Top           = 113
351:                 .Left          = 133
352:                 .Width         = 120
353:                 .Height        = 45
354:                 .FontName      = "Tahoma"
355:                 .FontSize      = 8
356:                 .BackColor     = RGB(255, 255, 255)
357:                 .ForeColor     = RGB(90, 90, 90)
358:                 .Themes        = .F.
359:                 .SpecialEffect = 0
360:                 .MousePointer  = 15
361:                 .Visible       = .T.
362:             ENDWITH
363:             BINDEVENT(loc_oPage.cmd_4c_Previsao, "Click", THIS, "BtnPrevisaoClick")
364: 
365:             loc_oPage.AddObject("cmd_4c_Prioridade", "CommandButton")
366:             WITH loc_oPage.cmd_4c_Prioridade
367:                 .Caption       = "Priori\<zar"
368:                 .Top           = 113
369:                 .Left          = 251
370:                 .Width         = 120
371:                 .Height        = 45
372:                 .FontName      = "Tahoma"
373:                 .FontSize      = 8
374:                 .BackColor     = RGB(255, 255, 255)
375:                 .ForeColor     = RGB(90, 90, 90)
376:                 .Themes        = .F.
377:                 .SpecialEffect = 0
378:                 .MousePointer  = 15
379:                 .Visible       = .T.
380:             ENDWITH
381:             BINDEVENT(loc_oPage.cmd_4c_Prioridade, "Click", THIS, "BtnPrioridadeClick")
382: 
383:             *-- Grid de lista SigCdPcz
384:             *-- Top original=145; compensacao PageFrame.Top=-29 => Top=174
385:             *-- Width=890 para nao cobrir cnt_4c_Saida (Left=917)
386:             loc_oPage.AddObject("grd_4c_Lista", "Grid")
387:             loc_oGrid = loc_oPage.grd_4c_Lista
388:             loc_oGrid.Top         = 174
389:             loc_oGrid.Left        = 12
390:             loc_oGrid.Width       = 890
391:             loc_oGrid.Height      = 446
392:             loc_oGrid.ColumnCount = 3
393:             WITH loc_oGrid
394:                 .FontName           = "Verdana"

*-- Linhas 411 a 431:
411:             WITH loc_oGrid.Column1
412:                 .Width           = 80
413:                 .Alignment       = 0
414:                 .Header1.Caption = "C" + CHR(243) + "digo"
415:             ENDWITH
416: 
417:             WITH loc_oGrid.Column2
418:                 .Width           = 350
419:                 .Alignment       = 0
420:                 .Header1.Caption = "T" + CHR(237) + "tulo"
421:             ENDWITH
422: 
423:             WITH loc_oGrid.Column3
424:                 .Width           = 150
425:                 .Alignment       = 0
426:                 .Header1.Caption = "Data Gera" + CHR(231) + CHR(227) + "o"
427:             ENDWITH
428: 
429:             BINDEVENT(loc_oGrid, "DblClick", THIS, "BtnVisualizarClick")
430:             BINDEVENT(loc_oGrid, "AfterRowColChange", THIS, "GridListaAfterRowColChange")
431: 

*-- Linhas 451 a 473:
451:             loc_oPage.AddObject("cnt_4c_BotoesAcao", "Container")
452:             loc_oCntAcao = loc_oPage.cnt_4c_BotoesAcao
453:             WITH loc_oCntAcao
454:                 .Top         = 33
455:                 .Left        = 842
456:                 .Width       = 160
457:                 .Height      = 85
458:                 .BackStyle   = 0
459:                 .Visible     = .T.
460:             ENDWITH
461: 
462:             loc_oCntAcao.AddObject("cmd_4c_Confirmar", "CommandButton")
463:             WITH loc_oCntAcao.cmd_4c_Confirmar
464:                 .Caption         = "Confirmar"
465:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
466:                 .PicturePosition = 13
467:                 .Top             = 5
468:                 .Left            = 5
469:                 .Width           = 75
470:                 .Height          = 75
471:                 .BackColor       = RGB(255, 255, 255)
472:                 .ForeColor       = RGB(90, 90, 90)
473:                 .FontName        = "Tahoma"

*-- Linhas 480 a 496:
480:                 .MousePointer    = 15
481:                 .Visible         = .T.
482:             ENDWITH
483:             BINDEVENT(loc_oCntAcao.cmd_4c_Confirmar, "Click", THIS, "BtnSalvarClick")
484: 
485:             loc_oCntAcao.AddObject("cmd_4c_Cancelar", "CommandButton")
486:             WITH loc_oCntAcao.cmd_4c_Cancelar
487:                 .Caption         = "Encerrar"
488:                 .Picture         = gc_4c_CaminhoIcones + "cadastro_cancelar_60.jpg"
489:                 .PicturePosition = 13
490:                 .Top             = 5
491:                 .Left            = 80
492:                 .Width           = 75
493:                 .Height          = 75
494:                 .BackColor       = RGB(255, 255, 255)
495:                 .ForeColor       = RGB(90, 90, 90)
496:                 .FontName        = "Tahoma"

*-- Linhas 503 a 1065:
503:                 .MousePointer    = 15
504:                 .Visible         = .T.
505:             ENDWITH
506:             BINDEVENT(loc_oCntAcao.cmd_4c_Cancelar, "Click", THIS, "BtnCancelarClick")
507: 
508:             *-- Botao Processar (Top orig=12 +29=41, Left=750)
509:             loc_oPage.AddObject("cmd_4c_Processar", "CommandButton")
510:             WITH loc_oPage.cmd_4c_Processar
511:                 .Caption         = "Processar"
512:                 .Top             = 41
513:                 .Left            = 750
514:                 .Width           = 75
515:                 .Height          = 75
516:                 .FontName        = "Tahoma"
517:                 .FontSize        = 8
518:                 .FontBold        = .T.
519:                 .BackColor       = RGB(255, 255, 255)
520:                 .ForeColor       = RGB(90, 90, 90)
521:                 .Themes          = .F.
522:                 .SpecialEffect   = 0
523:                 .MousePointer    = 15
524:                 .Visible         = .T.
525:             ENDWITH
526:             BINDEVENT(loc_oPage.cmd_4c_Processar, "Click", THIS, "BtnProcessarDadosClick")
527: 
528:             *-- Shape1: retangulo principal de parametros (Top orig=157 +29=186)
529:             loc_oPage.AddObject("shp_4c_Shape1", "Shape")
530:             WITH loc_oPage.shp_4c_Shape1
531:                 .Top     = 186
532:                 .Left    = 126
533:                 .Width   = 675
534:                 .Height  = 226
535:                 .Visible = .T.
536:             ENDWITH
537: 
538:             *-- Shape4: retangulo destaque periodo de emissao (Top orig=157 +29=186)
539:             loc_oPage.AddObject("shp_4c_Shape4", "Shape")
540:             WITH loc_oPage.shp_4c_Shape4
541:                 .Top     = 186
542:                 .Left    = 338
543:                 .Width   = 232
544:                 .Height  = 53
545:                 .Visible = .T.
546:             ENDWITH
547: 
548:             *-- Shape2: separador horizontal (Top orig=209 +29=238)
549:             loc_oPage.AddObject("shp_4c_Shape2", "Shape")
550:             WITH loc_oPage.shp_4c_Shape2
551:                 .Top     = 238
552:                 .Left    = 126
553:                 .Width   = 673
554:                 .Height  = 1
555:                 .Visible = .T.
556:             ENDWITH
557: 
558:             *-- Label5 "Codigo :" (Top orig=130 +29=159)
559:             loc_oPage.AddObject("lbl_4c_Codigo", "Label")
560:             WITH loc_oPage.lbl_4c_Codigo
561:                 .Caption   = "C" + CHR(243) + "digo : "
562:                 .Top       = 159
563:                 .Left      = 136
564:                 .Width     = 45
565:                 .Height    = 15
566:                 .FontName  = "Tahoma"
567:                 .FontSize  = 8
568:                 .BackStyle = 0
569:                 .Visible   = .T.
570:             ENDWITH
571: 
572:             *-- GetCodigos: txt_4c_Codigos (Top orig=127 +29=156; apenas em PROCURAR)
573:             loc_oPage.AddObject("txt_4c_Codigos", "TextBox")
574:             WITH loc_oPage.txt_4c_Codigos
575:                 .Value    = 0
576:                 .Top      = 156
577:                 .Left     = 195
578:                 .Width    = 80
579:                 .Height   = 23
580:                 .FontName = "Tahoma"
581:                 .FontSize = 8
582:                 .Enabled  = .F.
583:                 .Visible  = .T.
584:             ENDWITH
585: 
586:             *-- Label8 "Titulo :" (Top orig=130 +29=159)
587:             loc_oPage.AddObject("lbl_4c_LblTitulo", "Label")
588:             WITH loc_oPage.lbl_4c_LblTitulo
589:                 .Caption   = "T" + CHR(237) + "tulo : "
590:                 .Top       = 159
591:                 .Left      = 282
592:                 .Width     = 38
593:                 .Height    = 15
594:                 .FontName  = "Tahoma"
595:                 .FontSize  = 8
596:                 .BackStyle = 0
597:                 .Visible   = .T.
598:             ENDWITH
599: 
600:             *-- Get_Titulo: txt_4c_Titulo (Top orig=127 +29=156; apenas em INSERIR)
601:             loc_oPage.AddObject("txt_4c_Titulo", "TextBox")
602:             WITH loc_oPage.txt_4c_Titulo
603:                 .Value     = ""
604:                 .Top       = 156
605:                 .Left      = 332
606:                 .Width     = 360
607:                 .Height    = 23
608:                 .FontName  = "Tahoma"
609:                 .FontSize  = 8
610:                 .MaxLength = 50
611:                 .Enabled   = .F.
612:                 .Visible   = .T.
613:             ENDWITH
614: 
615:             *-- Label_Titulo: descricao dos parametros (Top orig=160 +29=189)
616:             loc_oPage.AddObject("lbl_4c_TituloParam", "Label")
617:             WITH loc_oPage.lbl_4c_TituloParam
618:                 .Caption   = " Par" + CHR(226) + "metros para Processamento" + ;
619:                              " da Ordem de Produ" + CHR(231) + CHR(227) + "o"
620:                 .Top       = 189
621:                 .Left      = 137
622:                 .Width     = 168
623:                 .Height    = 50
624:                 .FontName  = "Tahoma"
625:                 .FontSize  = 8
626:                 .BackStyle = 0
627:                 .WordWrap  = .T.
628:                 .Visible   = .T.
629:             ENDWITH
630: 
631:             *-- Label1 "Periodo de Emissao" (Top orig=162 +29=191)
632:             loc_oPage.AddObject("lbl_4c_PeriEmissao", "Label")
633:             WITH loc_oPage.lbl_4c_PeriEmissao
634:                 .Caption   = "Per" + CHR(237) + "odo de Emiss" + CHR(227) + "o"
635:                 .Top       = 191
636:                 .Left      = 390
637:                 .Width     = 107
638:                 .Height    = 16
639:                 .FontName  = "Tahoma"
640:                 .FontSize  = 8
641:                 .BackStyle = 0
642:                 .Visible   = .T.
643:             ENDWITH
644: 
645:             *-- GetDataei: txt_4c_Dataei (Top orig=179 +29=208; apenas em INSERIR)
646:             loc_oPage.AddObject("txt_4c_Dataei", "TextBox")
647:             WITH loc_oPage.txt_4c_Dataei
648:                 .Value    = {}
649:                 .Top      = 208
650:                 .Left     = 364
651:                 .Width    = 77
652:                 .Height   = 23
653:                 .FontName = "Tahoma"
654:                 .FontSize = 8
655:                 .Enabled  = .F.
656:                 .Visible  = .T.
657:             ENDWITH
658: 
659:             *-- Label2 "a" separador emissao (Top orig=184 +29=213)
660:             loc_oPage.AddObject("lbl_4c_SepEmissao", "Label")
661:             WITH loc_oPage.lbl_4c_SepEmissao
662:                 .Caption   = CHR(224)
663:                 .Top       = 213
664:                 .Left      = 447
665:                 .Width     = 8
666:                 .Height    = 16
667:                 .FontName  = "Tahoma"
668:                 .FontSize  = 8
669:                 .BackStyle = 0
670:                 .Visible   = .T.
671:             ENDWITH
672: 
673:             *-- GetDataef: txt_4c_Dataef (Top orig=179 +29=208; apenas em INSERIR)
674:             loc_oPage.AddObject("txt_4c_Dataef", "TextBox")
675:             WITH loc_oPage.txt_4c_Dataef
676:                 .Value    = {}
677:                 .Top      = 208
678:                 .Left     = 459
679:                 .Width    = 77
680:                 .Height   = 23
681:                 .FontName = "Tahoma"
682:                 .FontSize = 8
683:                 .Enabled  = .F.
684:                 .Visible  = .T.
685:             ENDWITH
686: 
687:             *-- Label3 "Periodo de Previsao de Entrega" (Top orig=161 +29=190)
688:             loc_oPage.AddObject("lbl_4c_PeriPrevisao", "Label")
689:             WITH loc_oPage.lbl_4c_PeriPrevisao
690:                 .Caption   = "Per" + CHR(237) + "odo de Previs" + CHR(227) + "o de Entrega"
691:                 .Top       = 190
692:                 .Left      = 579
693:                 .Width     = 174
694:                 .Height    = 16
695:                 .FontName  = "Tahoma"
696:                 .FontSize  = 8
697:                 .BackStyle = 0
698:                 .Visible   = .T.
699:             ENDWITH
700: 
701:             *-- GetDatapi: txt_4c_Datapi (Top orig=179 +29=208; apenas em INSERIR)
702:             loc_oPage.AddObject("txt_4c_Datapi", "TextBox")
703:             WITH loc_oPage.txt_4c_Datapi
704:                 .Value    = {}
705:                 .Top      = 208
706:                 .Left     = 599
707:                 .Width    = 77
708:                 .Height   = 23
709:                 .FontName = "Tahoma"
710:                 .FontSize = 8
711:                 .Enabled  = .F.
712:                 .Visible  = .T.
713:             ENDWITH
714: 
715:             *-- Label4 "a" separador previsao (Top orig=184 +29=213)
716:             loc_oPage.AddObject("lbl_4c_SepPrevisao", "Label")
717:             WITH loc_oPage.lbl_4c_SepPrevisao
718:                 .Caption   = CHR(224)
719:                 .Top       = 213
720:                 .Left      = 681
721:                 .Width     = 8
722:                 .Height    = 16
723:                 .FontName  = "Tahoma"
724:                 .FontSize  = 8
725:                 .BackStyle = 0
726:                 .Visible   = .T.
727:             ENDWITH
728: 
729:             *-- GetDatapf: txt_4c_Datapf (Top orig=179 +29=208; apenas em INSERIR)
730:             loc_oPage.AddObject("txt_4c_Datapf", "TextBox")
731:             WITH loc_oPage.txt_4c_Datapf
732:                 .Value    = {}
733:                 .Top      = 208
734:                 .Left     = 693
735:                 .Width    = 77
736:                 .Height   = 23
737:                 .FontName = "Tahoma"
738:                 .FontSize = 8
739:                 .Enabled  = .F.
740:                 .Visible  = .T.
741:             ENDWITH
742: 
743:             *-- TxtPedido "Operacao :" (Top orig=223 +29=252, Left=175)
744:             loc_oPage.AddObject("lbl_4c_TxtPedido", "Label")
745:             WITH loc_oPage.lbl_4c_TxtPedido
746:                 .Caption   = "Opera" + CHR(231) + CHR(227) + "o :"
747:                 .Top       = 252
748:                 .Left      = 175
749:                 .Width     = 62
750:                 .Height    = 16
751:                 .FontName  = "Tahoma"
752:                 .FontSize  = 8
753:                 .BackStyle = 0
754:                 .Visible   = .T.
755:             ENDWITH
756: 
757:             *-- cnt_4c_Operacao (Top orig=215 +29=244, Left=240, Width=553, Height=33)
758:             loc_oPage.AddObject("cnt_4c_Operacao", "Container")
759:             WITH loc_oPage.cnt_4c_Operacao
760:                 .Top         = 244
761:                 .Left        = 240
762:                 .Width       = 553
763:                 .Height      = 33
764:                 .BackStyle   = 0
765:                 .Visible     = .T.
766:             ENDWITH
767: 
768:             loc_oPage.cnt_4c_Operacao.AddObject("txt_4c_Operacao", "TextBox")
769:             WITH loc_oPage.cnt_4c_Operacao.txt_4c_Operacao
770:                 .Value     = ""
771:                 .Top       = 5
772:                 .Left      = 3
773:                 .Width     = 151
774:                 .Height    = 23
775:                 .FontName  = "Tahoma"
776:                 .FontSize  = 8
777:                 .MaxLength = 20
778:                 .Enabled   = .F.
779:                 .Visible   = .T.
780:             ENDWITH
781: 
782:             loc_oPage.cnt_4c_Operacao.AddObject("lbl_4c_OpDe", "Label")
783:             WITH loc_oPage.cnt_4c_Operacao.lbl_4c_OpDe
784:                 .Caption   = "de :"
785:                 .Top       = 10
786:                 .Left      = 189
787:                 .Width     = 24
788:                 .Height    = 16
789:                 .FontName  = "Tahoma"
790:                 .FontSize  = 8
791:                 .BackStyle = 0
792:                 .Visible   = .T.
793:             ENDWITH
794: 
795:             loc_oPage.cnt_4c_Operacao.AddObject("txt_4c_Operacaoi", "TextBox")
796:             WITH loc_oPage.cnt_4c_Operacao.txt_4c_Operacaoi
797:                 .Value    = 0
798:                 .Top      = 5
799:                 .Left     = 214
800:                 .Width    = 55
801:                 .Height   = 23
802:                 .FontName = "Tahoma"
803:                 .FontSize = 8
804:                 .Enabled  = .F.
805:                 .Visible  = .T.
806:             ENDWITH
807: 
808:             loc_oPage.cnt_4c_Operacao.AddObject("lbl_4c_OpA", "Label")
809:             WITH loc_oPage.cnt_4c_Operacao.lbl_4c_OpA
810:                 .Caption   = CHR(224)
811:                 .Top       = 10
812:                 .Left      = 275
813:                 .Width     = 8
814:                 .Height    = 16
815:                 .FontName  = "Tahoma"
816:                 .FontSize  = 8
817:                 .BackStyle = 0
818:                 .Visible   = .T.
819:             ENDWITH
820: 
821:             loc_oPage.cnt_4c_Operacao.AddObject("txt_4c_Operacaof", "TextBox")
822:             WITH loc_oPage.cnt_4c_Operacao.txt_4c_Operacaof
823:                 .Value    = 0
824:                 .Top      = 5
825:                 .Left     = 289
826:                 .Width    = 55
827:                 .Height   = 23
828:                 .FontName = "Tahoma"
829:                 .FontSize = 8
830:                 .Enabled  = .F.
831:                 .Visible  = .T.
832:             ENDWITH
833: 
834:             *-- Label6 "Conta :" (Top orig=257 +29=286, Left=195)
835:             loc_oPage.AddObject("lbl_4c_LblConta", "Label")
836:             WITH loc_oPage.lbl_4c_LblConta
837:                 .Caption   = "Conta :"
838:                 .Top       = 286
839:                 .Left      = 195
840:                 .Width     = 42
841:                 .Height    = 16
842:                 .FontName  = "Tahoma"
843:                 .FontSize  = 8
844:                 .BackStyle = 0
845:                 .Visible   = .T.
846:             ENDWITH
847: 
848:             *-- cnt_4c_Conta (Top orig=249 +29=278, Left=240, Width=553, Height=33)
849:             loc_oPage.AddObject("cnt_4c_Conta", "Container")
850:             WITH loc_oPage.cnt_4c_Conta
851:                 .Top         = 278
852:                 .Left        = 240
853:                 .Width       = 553
854:                 .Height      = 33
855:                 .BackStyle   = 0
856:                 .Visible     = .T.
857:             ENDWITH
858: 
859:             loc_oPage.cnt_4c_Conta.AddObject("txt_4c_Grupo", "TextBox")
860:             WITH loc_oPage.cnt_4c_Conta.txt_4c_Grupo
861:                 .Value     = ""
862:                 .Top       = 5
863:                 .Left      = 3
864:                 .Width     = 80
865:                 .Height    = 23
866:                 .FontName  = "Tahoma"
867:                 .FontSize  = 8
868:                 .MaxLength = 10
869:                 .Enabled   = .F.
870:                 .Visible   = .T.
871:             ENDWITH
872: 
873:             loc_oPage.cnt_4c_Conta.AddObject("txt_4c_Conta", "TextBox")
874:             WITH loc_oPage.cnt_4c_Conta.txt_4c_Conta
875:                 .Value     = ""
876:                 .Top       = 5
877:                 .Left      = 86
878:                 .Width     = 80
879:                 .Height    = 23
880:                 .FontName  = "Tahoma"
881:                 .FontSize  = 8
882:                 .MaxLength = 10
883:                 .Enabled   = .F.
884:                 .Visible   = .T.
885:             ENDWITH
886: 
887:             loc_oPage.cnt_4c_Conta.AddObject("txt_4c_Dconta", "TextBox")
888:             WITH loc_oPage.cnt_4c_Conta.txt_4c_Dconta
889:                 .Value    = ""
890:                 .Top      = 5
891:                 .Left     = 168
892:                 .Width    = 360
893:                 .Height   = 23
894:                 .FontName = "Tahoma"
895:                 .FontSize = 8
896:                 .MaxLength= 60
897:                 .ReadOnly = .T.
898:                 .Enabled  = .F.
899:                 .Visible  = .T.
900:             ENDWITH
901: 
902:             *-- Label7 "Representante :" (Top orig=291 +29=320, Left=146)
903:             loc_oPage.AddObject("lbl_4c_LblResp", "Label")
904:             WITH loc_oPage.lbl_4c_LblResp
905:                 .Caption   = "Representante :"
906:                 .Top       = 320
907:                 .Left      = 146
908:                 .Width     = 91
909:                 .Height    = 16
910:                 .FontName  = "Tahoma"
911:                 .FontSize  = 8
912:                 .BackStyle = 0
913:                 .Visible   = .T.
914:             ENDWITH
915: 
916:             *-- cnt_4c_Responsavel (Top orig=283 +29=312, Left=240, Width=553, Height=33)
917:             loc_oPage.AddObject("cnt_4c_Responsavel", "Container")
918:             WITH loc_oPage.cnt_4c_Responsavel
919:                 .Top         = 312
920:                 .Left        = 240
921:                 .Width       = 553
922:                 .Height      = 33
923:                 .BackStyle   = 0
924:                 .Visible     = .T.
925:             ENDWITH
926: 
927:             loc_oPage.cnt_4c_Responsavel.AddObject("txt_4c_Grupo", "TextBox")
928:             WITH loc_oPage.cnt_4c_Responsavel.txt_4c_Grupo
929:                 .Value     = ""
930:                 .Top       = 5
931:                 .Left      = 3
932:                 .Width     = 80
933:                 .Height    = 23
934:                 .FontName  = "Tahoma"
935:                 .FontSize  = 8
936:                 .MaxLength = 10
937:                 .Enabled   = .F.
938:                 .Visible   = .T.
939:             ENDWITH
940: 
941:             loc_oPage.cnt_4c_Responsavel.AddObject("txt_4c_Conta", "TextBox")
942:             WITH loc_oPage.cnt_4c_Responsavel.txt_4c_Conta
943:                 .Value     = ""
944:                 .Top       = 5
945:                 .Left      = 86
946:                 .Width     = 80
947:                 .Height    = 23
948:                 .FontName  = "Tahoma"
949:                 .FontSize  = 8
950:                 .MaxLength = 10
951:                 .Enabled   = .F.
952:                 .Visible   = .T.
953:             ENDWITH
954: 
955:             loc_oPage.cnt_4c_Responsavel.AddObject("txt_4c_Dconta", "TextBox")
956:             WITH loc_oPage.cnt_4c_Responsavel.txt_4c_Dconta
957:                 .Value    = ""
958:                 .Top      = 5
959:                 .Left     = 168
960:                 .Width    = 360
961:                 .Height   = 23
962:                 .FontName = "Tahoma"
963:                 .FontSize = 8
964:                 .MaxLength= 60
965:                 .ReadOnly = .T.
966:                 .Enabled  = .F.
967:                 .Visible  = .T.
968:             ENDWITH
969: 
970:             *-- lbl_empresa "Empresa :" (Top orig=325 +29=354, Left=187)
971:             loc_oPage.AddObject("lbl_4c_LblEmpresa", "Label")
972:             WITH loc_oPage.lbl_4c_LblEmpresa
973:                 .Caption   = "Empresa :"
974:                 .Top       = 354
975:                 .Left      = 187
976:                 .Width     = 50
977:                 .Height    = 15
978:                 .FontName  = "Tahoma"
979:                 .FontSize  = 8
980:                 .BackStyle = 0
981:                 .Visible   = .T.
982:             ENDWITH
983: 
984:             *-- cnt_4c_Empresa (Top orig=317 +29=346, Left=240, Width=553, Height=33)
985:             loc_oPage.AddObject("cnt_4c_Empresa", "Container")
986:             WITH loc_oPage.cnt_4c_Empresa
987:                 .Top         = 346
988:                 .Left        = 240
989:                 .Width       = 553
990:                 .Height      = 33
991:                 .BackStyle   = 0
992:                 .Visible     = .T.
993:             ENDWITH
994: 
995:             loc_oPage.cnt_4c_Empresa.AddObject("txt_4c__cd_empresa", "TextBox")
996:             WITH loc_oPage.cnt_4c_Empresa.txt_4c__cd_empresa
997:                 .Value     = ""
998:                 .Top       = 4
999:                 .Left      = 4
1000:                 .Width     = 31
1001:                 .Height    = 25
1002:                 .FontName  = "Tahoma"
1003:                 .FontSize  = 8
1004:                 .MaxLength = 3
1005:                 .Enabled   = .F.
1006:                 .Visible   = .T.
1007:             ENDWITH
1008: 
1009:             loc_oPage.cnt_4c_Empresa.AddObject("txt_4c__ds_empresa", "TextBox")
1010:             WITH loc_oPage.cnt_4c_Empresa.txt_4c__ds_empresa
1011:                 .Value    = ""
1012:                 .Top      = 4
1013:                 .Left     = 37
1014:                 .Width    = 282
1015:                 .Height   = 25
1016:                 .FontName = "Tahoma"
1017:                 .FontSize = 8
1018:                 .MaxLength= 60
1019:                 .ReadOnly = .T.
1020:                 .Enabled  = .F.
1021:                 .Visible  = .T.
1022:             ENDWITH
1023: 
1024:             *-- Label9 "Inserir as Operacoes na fabrica a partir do dia :"
1025:             *-- Top orig=355 +29=384, Left=206, Width=276, Height=18
1026:             loc_oPage.AddObject("lbl_4c_LblGeracao", "Label")
1027:             WITH loc_oPage.lbl_4c_LblGeracao
1028:                 .Caption   = "Inserir as Opera" + CHR(231) + CHR(245) + "es na f" + ;
1029:                              CHR(225) + "brica a partir do dia :"
1030:                 .Top       = 384
1031:                 .Left      = 206
1032:                 .Width     = 276
1033:                 .Height    = 18
1034:                 .FontName  = "Tahoma"
1035:                 .FontSize  = 8
1036:                 .BackStyle = 0
1037:                 .Visible   = .T.
1038:             ENDWITH
1039: 
1040:             *-- GetGeracao: txt_4c_Geracao (Top orig=353 +29=382, Left=483, Width=77)
1041:             loc_oPage.AddObject("txt_4c_Geracao", "TextBox")
1042:             WITH loc_oPage.txt_4c_Geracao
1043:                 .Value    = {}
1044:                 .Top      = 382
1045:                 .Left     = 483
1046:                 .Width    = 77
1047:                 .Height   = 23
1048:                 .FontName = "Tahoma"
1049:                 .FontSize = 8
1050:                 .Enabled  = .F.
1051:                 .Visible  = .T.
1052:             ENDWITH
1053:             BINDEVENT(loc_oPage.txt_4c_Geracao, "LostFocus", THIS, "ValidarDataGeracao")
1054: 
1055:             *-- Mensagem: lbl_4c_Mensagem (Top orig=399 +29=428, Left=304)
1056:             loc_oPage.AddObject("lbl_4c_Mensagem", "Label")
1057:             WITH loc_oPage.lbl_4c_Mensagem
1058:                 .Caption   = ""
1059:                 .Top       = 428
1060:                 .Left      = 304
1061:                 .Width     = 600
1062:                 .Height    = 18
1063:                 .FontName  = "Tahoma"
1064:                 .FontSize  = 8
1065:                 .ForeColor = RGB(0, 100, 0)

*-- Linhas 1097 a 1107:
1097:                 loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Titulos"
1098:                 loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Datas"
1099: 
1100:                 loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1101:                 loc_oGrid.Column2.Header1.Caption = "T" + CHR(237) + "tulo"
1102:                 loc_oGrid.Column3.Header1.Caption = "Data Gera" + CHR(231) + CHR(227) + "o"
1103: 
1104:                 THIS.FormatarGridLista(loc_oGrid)
1105:                 loc_lResultado = .T.
1106:             ENDIF
1107:         CATCH TO loc_oErro

*-- Linhas 1308 a 1318:
1308:                     loc_oGrid.Column1.ControlSource = "cursor_4c_Dados.Codigos"
1309:                     loc_oGrid.Column2.ControlSource = "cursor_4c_Dados.Titulos"
1310:                     loc_oGrid.Column3.ControlSource = "cursor_4c_Dados.Datas"
1311:                     loc_oGrid.Column1.Header1.Caption = "C" + CHR(243) + "digo"
1312:                     loc_oGrid.Column2.Header1.Caption = "T" + CHR(237) + "tulo"
1313:                     loc_oGrid.Column3.Header1.Caption = "Data Gera" + CHR(231) + CHR(227) + "o"
1314:                     THIS.FormatarGridLista(loc_oGrid)
1315:                 ENDIF
1316:             ENDIF
1317:         CATCH TO loc_oErro
1318:             MsgErro("Erro em FormPcp.BtnBuscarClick: " + loc_oErro.Message, "Erro")

*-- Linhas 1534 a 1542:
1534:             loc_oPag2.cnt_4c_Empresa.txt_4c__cd_empresa.Value = go_4c_Sistema.cCodEmpresa
1535:             loc_oPag2.cnt_4c_Empresa.txt_4c__ds_empresa.Value = ""
1536:             loc_oPag2.txt_4c_Geracao.Value                    = {}
1537:             loc_oPag2.lbl_4c_Mensagem.Caption                 = ""
1538:         CATCH TO loc_oErro
1539:             MsgErro("Erro em FormPcp.LimparCampos: " + loc_oErro.Message, "Erro")
1540:         ENDTRY
1541:     ENDPROC
1542: 

*-- Linhas 1586 a 1606:
1586:             loc_lModoIncluir    = (THIS.this_cModoAtual = "INCLUIR")
1587:             loc_lModoVisualizar = (THIS.this_cModoAtual = "VISUALIZAR")
1588: 
1589:             loc_oCntAcao.cmd_4c_Confirmar.Enabled = !loc_lModoVisualizar AND !loc_lModoIncluir
1590:             loc_oCntAcao.cmd_4c_Cancelar.Enabled  = .T.
1591:             loc_oPag2.cmd_4c_Processar.Enabled    = loc_lModoIncluir
1592:         CATCH TO loc_oErro
1593:             MsgErro("Erro em FormPcp.AjustarBotoesPorModo: " + loc_oErro.Message, "Erro")
1594:         ENDTRY
1595:     ENDPROC
1596: 
1597:     *==========================================================================
1598:     * TornarControlesVisiveis - Torna controles visiveis recursivamente
1599:     *==========================================================================
1600:     PROTECTED PROCEDURE TornarControlesVisiveis(par_oContainer)
1601:         LOCAL loc_nI, loc_oObjeto, loc_nP
1602: 
1603:         FOR loc_nI = 1 TO par_oContainer.ControlCount
1604:             loc_oObjeto = par_oContainer.Controls(loc_nI)
1605: 
1606:             IF VARTYPE(loc_oObjeto) = "O"


### BO (C:\4c\projeto\app\classes\PcpBO.prg):
*==============================================================================
* PcpBO.prg - Business Object: Planejamento e Controle da Produ??o
* Tabela principal: SigCdPcz
* Criado: 2026-08-22 | Task496
*==============================================================================

DEFINE CLASS PcpBO AS BusinessBase

    *-- Propriedades da tabela SigCdPcz
    this_nCodigos   = 0       && codigos numeric(10,0) - PK
    this_cContas    = ""      && contas  char(10)
    this_cCvens     = ""      && cvens   char(10)
    this_dDatas     = {}      && datas   datetime
    this_cDopes     = ""      && dopes   char(20)
    this_dDtLancs   = {}      && dtlancs datetime
    this_dEmissaoF  = {}      && emissaof datetime
    this_dEmissaoI  = {}      && emissaoi datetime
    this_cEmps      = ""      && emps    char(3)
    this_nNumefs    = 0       && numefs  numeric(6,0)
    this_nNumeis    = 0       && numeis  numeric(6,0)
    this_dPrevfs    = {}      && prevfs  datetime
    this_dPrevis    = {}      && previs  datetime
    this_cTitulos   = ""      && titulos char(50)

    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "SigCdPcz"
        THIS.this_cCampoChave = "Codigos"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria para auditoria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN TRANSFORM(THIS.this_nCodigos)
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de um cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lResultado
        loc_lResultado = .F.

        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_nCodigos  = TratarNulo(Codigos,  "N")
            THIS.this_cContas   = TratarNulo(Contas,   "C")
            THIS.this_cCvens    = TratarNulo(Cvens,    "C")
            THIS.this_dDatas    = TratarNulo(Datas,    "D")
            THIS.this_cDopes    = TratarNulo(Dopes,    "C")
            THIS.this_dDtLancs  = TratarNulo(Dtlancs,  "D")
            THIS.this_dEmissaoF = TratarNulo(Emissaof, "D")
            THIS.this_dEmissaoI = TratarNulo(Emissaoi, "D")
            THIS.this_cEmps     = TratarNulo(Emps,     "C")
            THIS.this_nNumefs   = TratarNulo(Numefs,   "N")
            THIS.this_nNumeis   = TratarNulo(Numeis,   "N")
            THIS.this_dPrevfs   = TratarNulo(Prevfs,   "D")
            THIS.this_dPrevis   = TratarNulo(Previs,   "D")
            THIS.this_cTitulos  = TratarNulo(Titulos,  "C")
            THIS.this_lNovoRegistro = .F.
            loc_lResultado = .T.
        ENDIF

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Lista registros no cursor_4c_Dados
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cFiltro)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Titulos, Datas, Emps" + ;
                       " FROM SigCdPcz" + ;
                       " ORDER BY Codigos"

            IF !EMPTY(par_cFiltro)
                loc_cSQL = "SELECT Codigos, Titulos, Datas, Emps" + ;
                           " FROM SigCdPcz" + ;
                           " WHERE " + par_cFiltro + ;
                           " ORDER BY Codigos"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Dados")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar registros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Buscar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarPorCodigo - Carrega registro pelo codigo (PK)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarPorCodigo(par_nCodigo)
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Codigos, Contas, Cvens, Datas, Dopes," + ;
                       " Dtlancs, Emissaof, Emissaoi, Emps," + ;
                       " Numefs, Numeis, Prevfs, Previs, Titulos" + ;
                       " FROM SigCdPcz" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Carrega")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Carrega") > 0
                loc_lResultado = THIS.CarregarDoCursor("cursor_4c_Carrega")
            ENDIF

            IF USED("cursor_4c_Carrega")
                USE IN cursor_4c_Carrega
            ENDIF
        CATCH TO loException
            MsgErro("Erro em CarregarPorCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere novo registro (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "INSERT INTO SigCdPcz" + ;
                       " (Codigos, Contas, Cvens, Datas, Dopes," + ;
                       "  Dtlancs, Emissaof, Emissaoi, Emps," + ;
                       "  Numefs, Numeis, Prevfs, Previs, Titulos)" + ;
                       " VALUES (" + ;
                       FormatarNumeroSQL(THIS.this_nCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cContas)  + ", " + ;
                       EscaparSQL(THIS.this_cCvens)   + ", " + ;
                       FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       EscaparSQL(THIS.this_cDopes)   + ", " + ;
                       FormatarDataSQL(THIS.this_dDtLancs) + ", " + ;
                       FormatarDataSQL(THIS.this_dEmissaoF) + ", " + ;
                       FormatarDataSQL(THIS.this_dEmissaoI) + ", " + ;
                       EscaparSQL(THIS.this_cEmps)    + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumefs) + ", " + ;
                       FormatarNumeroSQL(THIS.this_nNumeis) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrevfs) + ", " + ;
                       FormatarDataSQL(THIS.this_dPrevis) + ", " + ;
                       EscaparSQL(THIS.this_cTitulos) + ")"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("INSERT")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao inserir registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Inserir: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza registro existente (PROTECTED - chamado por Salvar)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "UPDATE SigCdPcz SET" + ;
                       " Contas    = " + EscaparSQL(THIS.this_cContas)   + ", " + ;
                       " Cvens     = " + EscaparSQL(THIS.this_cCvens)    + ", " + ;
                       " Datas     = " + FormatarDataSQL(THIS.this_dDatas) + ", " + ;
                       " Dopes     = " + EscaparSQL(THIS.this_cDopes)    + ", " + ;
                       " Dtlancs   = " + FormatarDataSQL(THIS.this_dDtLancs) + ", " + ;
                       " Emissaof  = " + FormatarDataSQL(THIS.this_dEmissaoF) + ", " + ;
                       " Emissaoi  = " + FormatarDataSQL(THIS.this_dEmissaoI) + ", " + ;
                       " Emps      = " + EscaparSQL(THIS.this_cEmps)     + ", " + ;
                       " Numefs    = " + FormatarNumeroSQL(THIS.this_nNumefs) + ", " + ;
                       " Numeis    = " + FormatarNumeroSQL(THIS.this_nNumeis) + ", " + ;
                       " Prevfs    = " + FormatarDataSQL(THIS.this_dPrevfs) + ", " + ;
                       " Previs    = " + FormatarDataSQL(THIS.this_dPrevis) + ", " + ;
                       " Titulos   = " + EscaparSQL(THIS.this_cTitulos) + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(THIS.this_nCodigos)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResult >= 0
                THIS.RegistrarAuditoria("UPDATE")
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao atualizar registro: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em Atualizar: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui registro das 4 tabelas relacionadas
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCodigo
        loc_lResultado = .F.

        TRY
            loc_cCodigo = FormatarNumeroSQL(THIS.this_nCodigos)

            *-- Excluir da tabela principal SigCdPcz (1/4)
            loc_cSQL = "DELETE FROM SigCdPcz WHERE Codigos = " + loc_cCodigo
            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
            IF loc_nResult < 0
                MsgErro("Erro ao excluir SigCdPcz: " + CapturarErroSQL(), "Erro SQL")
                loc_lResultado = .F.
            ELSE
                *-- Excluir SigCdPco (2/4)
                loc_cSQL = "DELETE FROM SigCdPco WHERE Codigos = " + loc_cCodigo
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                IF loc_nResult < 0
                    MsgErro("Erro ao excluir SigCdPco: " + CapturarErroSQL(), "Erro SQL")
                ELSE
                    *-- Excluir SigCdPcp (3/4)
                    loc_cSQL = "DELETE FROM SigCdPcp WHERE Codigos = " + loc_cCodigo
                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                    IF loc_nResult < 0
                        MsgErro("Erro ao excluir SigCdPcp: " + CapturarErroSQL(), "Erro SQL")
                    ELSE
                        *-- Excluir SigCdPcg (4/4)
                        loc_cSQL = "DELETE FROM SigCdPcg WHERE Codigos = " + loc_cCodigo
                        loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                        IF loc_nResult < 0
                            MsgErro("Erro ao excluir SigCdPcg: " + CapturarErroSQL(), "Erro SQL")
                        ELSE
                            THIS.RegistrarAuditoria("DELETE")
                            loc_lResultado = .T.
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ExecutarExclusao: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarOperacoes - Carrega cursor TmpOper com operacoes de producao
    *--------------------------------------------------------------------------
    PROCEDURE BuscarOperacoes()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult
        loc_lResultado = .F.

        TRY
            loc_cSQL = "SELECT Dopes, NDopes, Globalizas, Reservas" + ;
                       " FROM SigCdOpe" + ;
                       " WHERE Globalizas IN (1, 2)" + ;
                       " ORDER BY Dopes"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Operacoes")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar opera" + CHR(231) + CHR(245) + "es: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarOperacoes: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarParametros - Carrega parametros do sistema (SigCdPam)
    *--------------------------------------------------------------------------
    PROCEDURE BuscarParametros()
        LOCAL loc_lResultado, loc_cSQL, loc_nResult, loc_cCampos
        loc_lResultado = .F.

        TRY
            loc_cCampos = "DopEmphs, DopReqcs, DopPedcs, DopComps, TransfRes, GrPadClis, DoppPads," + ;
                          " DopTrfCps, GrPadVens, PrevProds, GrupoEsts, ContaEsts, GruReservs," + ;
                          " ConReservs, AgrupEmph, grTrans, DoppServs, mascnums, GruEstps, ConEstps," + ;
                          " transfencs, Ouros, GruConfs, ConConfs, GlobAutos"

            loc_cSQL = "SELECT " + loc_cCampos + " FROM SigCdPam"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Parametros")

            IF loc_nResult >= 0
                loc_lResultado = .T.
            ELSE
                MsgErro("Erro ao buscar par" + CHR(226) + "metros: " + CapturarErroSQL(), "Erro SQL")
            ENDIF
        CATCH TO loException
            MsgErro("Erro em BuscarParametros: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lResultado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCodigo - Verifica se codigo ja existe na base
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCodigo(par_nCodigo)
        LOCAL loc_lExiste, loc_cSQL, loc_nResult
        loc_lExiste = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS Total FROM SigCdPcz" + ;
                       " WHERE Codigos = " + FormatarNumeroSQL(par_nCodigo)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_Valid")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_Valid") > 0
                SELECT cursor_4c_Valid
                loc_lExiste = (cursor_4c_Valid.Total > 0)
            ENDIF

            IF USED("cursor_4c_Valid")
                USE IN cursor_4c_Valid
            ENDIF
        CATCH TO loException
            MsgErro("Erro em ValidarCodigo: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_lExiste
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCodigoUnico - Gera proximo codigo unico (substitui fGerUniqueKey)
    *--------------------------------------------------------------------------
    PROCEDURE GerarCodigoUnico()
        LOCAL loc_nCodigo, loc_cSQL, loc_nResult
        loc_nCodigo = 0

        TRY
            loc_cSQL = "SELECT ISNULL(MAX(Codigos), 0) + 1 AS ProxCodigo FROM SigCdPcz"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ProxCodigo")

            IF loc_nResult >= 0 AND RECCOUNT("cursor_4c_ProxCodigo") > 0
                SELECT cursor_4c_ProxCodigo
                loc_nCodigo = cursor_4c_ProxCodigo.ProxCodigo
            ENDIF

            IF USED("cursor_4c_ProxCodigo")
                USE IN cursor_4c_ProxCodigo
            ENDIF
        CATCH TO loException
            MsgErro("Erro em GerarCodigoUnico: " + loException.Message, "Erro")
        ENDTRY

        RETURN loc_nCodigo
    ENDPROC

ENDDEFINE

