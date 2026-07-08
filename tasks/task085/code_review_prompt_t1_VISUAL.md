# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [FONTNAME-ERRADO] Linha 176: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 195: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 214: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.
- [FONTNAME-ERRADO] Linha 233: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\relatorios\FormSIGREEGG.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1395 linhas total):

*-- Linhas 55 a 63:
55:         loc_lSucesso   = .F.
56:         loc_lContinuar = .T.
57:         TRY
58:             THIS.Caption = "Posi" + CHR(231) + CHR(227) + ;
59:                 "o de Estoque por Grande Grupo"
60: 
61:             IF TYPE("gc_4c_CaminhoIcones") = "U"
62:                 gc_4c_CaminhoIcones = ""
63:             ENDIF

*-- Linhas 75 a 84:
75:                 THIS.ConfigurarBotoes()
76:                 THIS.ConfigurarPageFrame()
77: 
78:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
79:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
80: 
81:                 THIS.ConfigurarPaginaLista()
82:                 THIS.ConfigurarPaginaDados()
83:                 THIS.LimparCampos()
84: 

*-- Linhas 102 a 140:
102:     PROTECTED PROCEDURE ConfigurarCabecalho()
103:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
104:         WITH THIS.cnt_4c_Cabecalho
105:             .Top         = 0
106:             .Left        = 0
107:             .Width       = THIS.Width
108:             .Height      = 80
109:             .BackColor   = RGB(100, 100, 100)
110:             .BackStyle   = 1
111:             .BorderWidth = 0
112:             .Visible     = .T.
113:         ENDWITH
114: 
115:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Sombra", "Label")
116:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Sombra
117:             .Top       = 17
118:             .Left      = 12
119:             .AutoSize  = .T.
120:             .Caption   = "Posi" + CHR(231) + CHR(227) + ;
121:                 "o de Estoque por Grande Grupo"
122:             .FontName  = "Tahoma"
123:             .FontSize  = 14
124:             .FontBold  = .T.
125:             .ForeColor = RGB(0, 0, 0)
126:             .BackStyle = 0
127:             .Visible   = .T.
128:         ENDWITH
129: 
130:         THIS.cnt_4c_Cabecalho.AddObject("lbl_4c_Titulo", "Label")
131:         WITH THIS.cnt_4c_Cabecalho.lbl_4c_Titulo
132:             .Top       = 20
133:             .Left      = 10
134:             .AutoSize  = .T.
135:             .Caption   = "Posi" + CHR(231) + CHR(227) + ;
136:                 "o de Estoque por Grande Grupo"
137:             .FontName  = "Tahoma"
138:             .FontSize  = 14
139:             .FontBold  = .T.
140:             .ForeColor = RGB(255, 255, 255)

*-- Linhas 152 a 239:
152:     PROTECTED PROCEDURE ConfigurarBotoes()
153:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
154:         WITH THIS.cmg_4c_Botoes
155:             .Top           = 0
156:             .Left          = 529
157:             .Width         = 273
158:             .Height        = 80
159:             .ButtonCount   = 4
160:             .BackStyle     = 0
161:             .BorderStyle   = 0
162:             .BorderColor   = RGB(136, 189, 188)
163:             .SpecialEffect = 1
164:             .Themes        = .F.
165:             .Visible       = .T.
166:         ENDWITH
167: 
168:         WITH THIS.cmg_4c_Botoes.Buttons(1)
169:             .Top             = 5
170:             .Left            = 5
171:             .Width           = 65
172:             .Height          = 70
173:             .Caption         = "Visualizar"
174:             .Picture         = gc_4c_CaminhoIcones + "ideo.jpg"
175:             .PicturePosition = 13
176:             .FontName        = "Comic Sans MS"
177:             .FontBold        = .T.
178:             .FontItalic      = .T.
179:             .FontSize        = 8
180:             .BackColor       = RGB(255, 255, 255)
181:             .ForeColor       = RGB(90, 90, 90)
182:             .Themes          = .F.
183:             .SpecialEffect   = 0
184:             .MousePointer    = 15
185:         ENDWITH
186: 
187:         WITH THIS.cmg_4c_Botoes.Buttons(2)
188:             .Top             = 5
189:             .Left            = 71
190:             .Width           = 65
191:             .Height          = 70
192:             .Caption         = "Imprimir"
193:             .Picture         = gc_4c_CaminhoIcones + "impressora.jpg"
194:             .PicturePosition = 13
195:             .FontName        = "Comic Sans MS"
196:             .FontBold        = .T.
197:             .FontItalic      = .T.
198:             .FontSize        = 8
199:             .BackColor       = RGB(255, 255, 255)
200:             .ForeColor       = RGB(90, 90, 90)
201:             .Themes          = .F.
202:             .SpecialEffect   = 0
203:             .MousePointer    = 15
204:         ENDWITH
205: 
206:         WITH THIS.cmg_4c_Botoes.Buttons(3)
207:             .Top             = 5
208:             .Left            = 137
209:             .Width           = 65
210:             .Height          = 70
211:             .Caption         = "Excel"
212:             .Picture         = gc_4c_CaminhoIcones + "excel.jpg"
213:             .PicturePosition = 13
214:             .FontName        = "Comic Sans MS"
215:             .FontBold        = .T.
216:             .FontItalic      = .T.
217:             .FontSize        = 8
218:             .BackColor       = RGB(255, 255, 255)
219:             .ForeColor       = RGB(90, 90, 90)
220:             .Themes          = .F.
221:             .SpecialEffect   = 0
222:             .MousePointer    = 15
223:         ENDWITH
224: 
225:         WITH THIS.cmg_4c_Botoes.Buttons(4)
226:             .Top             = 5
227:             .Left            = 203
228:             .Width           = 65
229:             .Height          = 70
230:             .Caption         = "Encerrar"
231:             .Picture         = gc_4c_CaminhoIcones + "otao_encerrar.jpg"
232:             .PicturePosition = 13
233:             .FontName        = "Comic Sans MS"
234:             .FontBold        = .T.
235:             .FontItalic      = .T.
236:             .FontSize        = 8
237:             .BackColor       = RGB(255, 255, 255)
238:             .ForeColor       = RGB(90, 90, 90)
239:             .Themes          = .F.

*-- Linhas 261 a 282:
261: 
262:         loc_oPgf.PageCount = 2
263: 
264:         loc_oPgf.Top    = 85
265:         loc_oPgf.Left   = -1
266:         loc_oPgf.Width  = THIS.Width + 2
267:         loc_oPgf.Height = THIS.Height - 85
268:         loc_oPgf.Tabs   = .F.
269: 
270:         loc_oPgf.Page1.Caption   = "Filtros"
271:         loc_oPgf.Page1.FontName  = "Tahoma"
272:         loc_oPgf.Page1.FontSize  = 8
273:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
274:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
275:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
276: 
277:         loc_oPgf.Page2.Caption   = "Dados"
278:         loc_oPgf.Page2.FontName  = "Tahoma"
279:         loc_oPgf.Page2.FontSize  = 8
280:         loc_oPgf.Page2.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
281:         loc_oPgf.Page2.BackColor = RGB(255, 255, 255)
282:         loc_oPgf.Page2.ForeColor = RGB(90, 90, 90)

*-- Linhas 317 a 350:
317: 
318:     *--------------------------------------------------------------------------
319:     * ConfigurarPaginaDados - Campos de filtro em Page1
320:     *   Tops ajustados: Top_page = Top_original - 85 (PageFrame.Top=85)
321:     *   Empresa(23), GrEstoque(48), Estoque(75), GGrupo(102),
322:     *   DataPos(129), OptCusto(155), Moeda(158)
323:     *--------------------------------------------------------------------------
324:     PROTECTED PROCEDURE ConfigurarPaginaDados()
325:         LOCAL loc_oPagina
326:         loc_oPagina = THIS.pgf_4c_Paginas.Page1
327: 
328:         *-- EMPRESA (original Say5.top=111->26, getEmpresa.top=108->23, getDesEmpresa.top=108->23)
329:         loc_oPagina.AddObject("lbl_4c_Empresa", "Label")
330:         WITH loc_oPagina.lbl_4c_Empresa
331:             .Top       = 26
332:             .Left      = 214
333:             .AutoSize  = .T.
334:             .Caption   = "Empresa :"
335:             .FontName  = "Tahoma"
336:             .FontSize  = 8
337:             .ForeColor = RGB(90, 90, 90)
338:             .BackStyle = 0
339:             .Visible   = .T.
340:         ENDWITH
341: 
342:         loc_oPagina.AddObject("txt_4c_Empresa", "TextBox")
343:         WITH loc_oPagina.txt_4c_Empresa
344:             .Top       = 23
345:             .Left      = 267
346:             .Width     = 31
347:             .Height    = 23
348:             .MaxLength = 3
349:             .Value     = ""
350:             .FontName  = "Tahoma"

*-- Linhas 356 a 394:
356: 
357:         loc_oPagina.AddObject("txt_4c_DesEmpresa", "TextBox")
358:         WITH loc_oPagina.txt_4c_DesEmpresa
359:             .Top       = 23
360:             .Left      = 300
361:             .Width     = 290
362:             .Height    = 23
363:             .MaxLength = 40
364:             .Value     = ""
365:             .FontName  = "Tahoma"
366:             .FontSize  = 8
367:             .BackColor = RGB(255, 255, 255)
368:             .ForeColor = RGB(90, 90, 90)
369:             .Visible   = .T.
370:         ENDWITH
371: 
372:         *-- GRUPO DE ESTOQUE (Say2.top=138->53, get_Cd_GrEstoque.top=133->48, get_Ds_GrEstoque.top=133->48)
373:         loc_oPagina.AddObject("lbl_4c_GrEstoque", "Label")
374:         WITH loc_oPagina.lbl_4c_GrEstoque
375:             .Top       = 53
376:             .Left      = 169
377:             .AutoSize  = .T.
378:             .Caption   = "Grupo de Estoque :"
379:             .FontName  = "Tahoma"
380:             .FontSize  = 8
381:             .ForeColor = RGB(90, 90, 90)
382:             .BackStyle = 0
383:             .Visible   = .T.
384:         ENDWITH
385: 
386:         loc_oPagina.AddObject("txt_4c_CdGrEstoque", "TextBox")
387:         WITH loc_oPagina.txt_4c_CdGrEstoque
388:             .Top       = 48
389:             .Left      = 267
390:             .Width     = 80
391:             .Height    = 23
392:             .MaxLength = 10
393:             .Value     = ""
394:             .FontName  = "Tahoma"

*-- Linhas 400 a 438:
400: 
401:         loc_oPagina.AddObject("txt_4c_DsGrEstoque", "TextBox")
402:         WITH loc_oPagina.txt_4c_DsGrEstoque
403:             .Top       = 48
404:             .Left      = 349
405:             .Width     = 150
406:             .Height    = 23
407:             .MaxLength = 20
408:             .Value     = ""
409:             .FontName  = "Tahoma"
410:             .FontSize  = 8
411:             .BackColor = RGB(255, 255, 255)
412:             .ForeColor = RGB(90, 90, 90)
413:             .Visible   = .T.
414:         ENDWITH
415: 
416:         *-- CONTA DE ESTOQUE (lbl_estoque.top=165->80, get_cd_estoque.top=160->75, get_ds_estoque.top=160->75)
417:         loc_oPagina.AddObject("lbl_4c_Estoque", "Label")
418:         WITH loc_oPagina.lbl_4c_Estoque
419:             .Top       = 80
420:             .Left      = 216
421:             .AutoSize  = .T.
422:             .Caption   = "Estoque :"
423:             .FontName  = "Tahoma"
424:             .FontSize  = 8
425:             .ForeColor = RGB(90, 90, 90)
426:             .BackStyle = 0
427:             .Visible   = .T.
428:         ENDWITH
429: 
430:         loc_oPagina.AddObject("txt_4c_CdEstoque", "TextBox")
431:         WITH loc_oPagina.txt_4c_CdEstoque
432:             .Top       = 75
433:             .Left      = 267
434:             .Width     = 80
435:             .Height    = 23
436:             .MaxLength = 10
437:             .Value     = ""
438:             .FontName  = "Tahoma"

*-- Linhas 444 a 482:
444: 
445:         loc_oPagina.AddObject("txt_4c_DsEstoque", "TextBox")
446:         WITH loc_oPagina.txt_4c_DsEstoque
447:             .Top       = 75
448:             .Left      = 349
449:             .Width     = 290
450:             .Height    = 23
451:             .MaxLength = 40
452:             .Value     = ""
453:             .FontName  = "Tahoma"
454:             .FontSize  = 8
455:             .BackColor = RGB(255, 255, 255)
456:             .ForeColor = RGB(90, 90, 90)
457:             .Visible   = .T.
458:         ENDWITH
459: 
460:         *-- GRANDE GRUPO (lbl_codigo.top=192->107, get_cd_ggrupo.top=187->102, get_ds_ggrupo.top=187->102)
461:         loc_oPagina.AddObject("lbl_4c_GGrupo", "Label")
462:         WITH loc_oPagina.lbl_4c_GGrupo
463:             .Top       = 107
464:             .Left      = 188
465:             .AutoSize  = .T.
466:             .Caption   = "Grande Grupo :"
467:             .FontName  = "Tahoma"
468:             .FontSize  = 8
469:             .ForeColor = RGB(90, 90, 90)
470:             .BackStyle = 0
471:             .Visible   = .T.
472:         ENDWITH
473: 
474:         loc_oPagina.AddObject("txt_4c_CdGGrupo", "TextBox")
475:         WITH loc_oPagina.txt_4c_CdGGrupo
476:             .Top       = 102
477:             .Left      = 267
478:             .Width     = 80
479:             .Height    = 23
480:             .MaxLength = 10
481:             .Value     = ""
482:             .FontName  = "Tahoma"

*-- Linhas 488 a 606:
488: 
489:         loc_oPagina.AddObject("txt_4c_DsGGrupo", "TextBox")
490:         WITH loc_oPagina.txt_4c_DsGGrupo
491:             .Top       = 102
492:             .Left      = 349
493:             .Width     = 290
494:             .Height    = 23
495:             .MaxLength = 40
496:             .Value     = ""
497:             .FontName  = "Tahoma"
498:             .FontSize  = 8
499:             .BackColor = RGB(255, 255, 255)
500:             .ForeColor = RGB(90, 90, 90)
501:             .Visible   = .T.
502:         ENDWITH
503: 
504:         *-- DATA DE POSICAO (lbl_periodo.top=219->134, get_datapos.top=214->129)
505:         loc_oPagina.AddObject("lbl_4c_DataPos", "Label")
506:         WITH loc_oPagina.lbl_4c_DataPos
507:             .Top       = 134
508:             .Left      = 232
509:             .AutoSize  = .T.
510:             .Caption   = "Data :"
511:             .FontName  = "Tahoma"
512:             .FontSize  = 8
513:             .ForeColor = RGB(90, 90, 90)
514:             .BackStyle = 0
515:             .Visible   = .T.
516:         ENDWITH
517: 
518:         loc_oPagina.AddObject("txt_4c_DataPos", "TextBox")
519:         WITH loc_oPagina.txt_4c_DataPos
520:             .Top       = 129
521:             .Left      = 267
522:             .Width     = 80
523:             .Height    = 23
524:             .Value     = {}
525:             .FontName  = "Tahoma"
526:             .FontSize  = 8
527:             .BackColor = RGB(255, 255, 255)
528:             .ForeColor = RGB(0, 0, 0)
529:             .Visible   = .T.
530:         ENDWITH
531: 
532:         *-- CUSTO label (Say1.top=246->161)
533:         loc_oPagina.AddObject("lbl_4c_Custo", "Label")
534:         WITH loc_oPagina.lbl_4c_Custo
535:             .Top       = 161
536:             .Left      = 227
537:             .AutoSize  = .T.
538:             .Caption   = "Custo :"
539:             .FontName  = "Tahoma"
540:             .FontSize  = 8
541:             .ForeColor = RGB(90, 90, 90)
542:             .BackStyle = 0
543:             .Visible   = .T.
544:         ENDWITH
545: 
546:         *-- OPT CUSTO (opt_custo.top=240->155; Value=2 = Nao por padrao)
547:         loc_oPagina.AddObject("obj_4c_OptCusto", "OptionGroup")
548:         WITH loc_oPagina.obj_4c_OptCusto
549:             .Top           = 155
550:             .Left          = 268
551:             .Width         = 103
552:             .Height        = 27
553:             .ButtonCount   = 2
554:             .BackStyle     = 0
555:             .BorderStyle   = 0
556:             .Value         = 2
557:             .SpecialEffect = 0
558:             .Themes        = .F.
559:             .Visible       = .T.
560:         ENDWITH
561:         WITH loc_oPagina.obj_4c_OptCusto.Buttons(1)
562:             .Caption   = "Sim"
563:             .Left      = 5
564:             .Top       = 5
565:             .Width     = 34
566:             .Height    = 15
567:             .AutoSize  = .T.
568:             .BackStyle = 0
569:             .FontName  = "Tahoma"
570:             .FontSize  = 8
571:             .ForeColor = RGB(90, 90, 90)
572:         ENDWITH
573:         WITH loc_oPagina.obj_4c_OptCusto.Buttons(2)
574:             .Caption   = "N" + CHR(227) + "o"
575:             .Left      = 57
576:             .Top       = 5
577:             .AutoSize  = .T.
578:             .BackStyle = 0
579:             .FontName  = "Tahoma"
580:             .FontSize  = 8
581:             .ForeColor = RGB(90, 90, 90)
582:         ENDWITH
583: 
584:         *-- MOEDA (lbl_moeda.top=246->161, get_cd_moeda.top=243->158, get_ds_moeda.top=243->158)
585:         loc_oPagina.AddObject("lbl_4c_Moeda", "Label")
586:         WITH loc_oPagina.lbl_4c_Moeda
587:             .Top       = 161
588:             .Left      = 394
589:             .AutoSize  = .T.
590:             .Caption   = "Moeda : "
591:             .FontName  = "Tahoma"
592:             .FontSize  = 8
593:             .ForeColor = RGB(90, 90, 90)
594:             .BackStyle = 0
595:             .Visible   = .T.
596:         ENDWITH
597: 
598:         loc_oPagina.AddObject("txt_4c_CdMoeda", "TextBox")
599:         WITH loc_oPagina.txt_4c_CdMoeda
600:             .Top       = 158
601:             .Left      = 441
602:             .Width     = 31
603:             .Height    = 23
604:             .MaxLength = 3
605:             .Value     = ""
606:             .FontName  = "Tahoma"

*-- Linhas 612 a 621:
612: 
613:         loc_oPagina.AddObject("txt_4c_DsMoeda", "TextBox")
614:         WITH loc_oPagina.txt_4c_DsMoeda
615:             .Top       = 158
616:             .Left      = 474
617:             .Width     = 115
618:             .Height    = 23
619:             .MaxLength = 15
620:             .Value     = ""
621:             .FontName  = "Tahoma"


### BO (C:\4c\projeto\app\classes\SIGREEGGBO.prg):
*==============================================================================
* SIGREEGGBO.PRG
* BO do Relatorio: Posicao de Estoque por Grande Grupo
*
* Herda de: RelatorioBase
* Origem: SIGREEGG.SCX (frmrelatorio)
* Relatorio FRX: SigReEgg.frx
*
* Filtros do relatorio:
*   - Empresa (codigo + descricao)
*   - Grupo de Estoque (codigo + descricao via fAcessoContab)
*   - Conta de Estoque (codigo + descricao via fAcessoContas)
*   - Grande Grupo (codigo + descricao via SigCdGpr)
*   - Data de Posicao (data unica)
*   - Opcao de Custo (1=Sim / 2=Nao, default=2)
*   - Moeda (codigo + descricao via SigCdMoe)
*
* Cursores de referencia carregados no Init():
*   cursor_4c_SigCdEmp  - empresas (cemps, razas, ativas)
*
* Cursor de resultado produzido por PrepararDados():
*   cursor_4c_Relatorio - dados agrupados para REPORT FORM SigReEgg
*
* Cursor de cabecalho produzido por GerarCabecalho():
*   CsCabecalho - nomeempresa, titulo1, titulo2, periodo, impetiq, Impcusto
*==============================================================================

DEFINE CLASS SIGREEGGBO AS RelatorioBase

    *-- Filtros do relatorio
    this_cEmpresa       = ""
    this_cDesEmpresa    = ""
    this_cCdGrEstoque   = ""
    this_cDsGrEstoque   = ""
    this_cCdEstoque     = ""
    this_cDsEstoque     = ""
    this_cCdGGrupo      = ""
    this_cDsGGrupo      = ""
    this_dDataPos       = {}
    this_nOptCusto      = 2
    this_cCdMoeda       = ""
    this_cDsMoeda       = ""

    *-- Nome do cursor de resultado
    this_cCursorDados   = "cursor_4c_Relatorio"

    *--------------------------------------------------------------------------
    * Init - Configura BO e carrega cursor de empresas para processamento
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult

        loc_lSucesso = .F.
        TRY
            DODEFAULT()

            THIS.this_dDataPos    = DATE()
            THIS.this_nOptCusto   = 2
            THIS.this_cTabela     = "SigMvEst"
            THIS.this_cCampoChave = ""

            *-- Carregar empresas (usadas em Processar/ProcessarEmpresa)
            IF USED("cursor_4c_SigCdEmp")
                USE IN cursor_4c_SigCdEmp
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, ;
                "SELECT cemps, razas, ativas FROM SigCdEmp", ;
                "cursor_4c_SigCdEmp")

            IF loc_nResult >= 1
                SELECT cursor_4c_SigCdEmp
                INDEX ON cemps TAG cemps
                GO TOP
            ELSE
                THIS.this_cMensagemErro = "Falha ao carregar cadastro de empresas"
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SIGREEGGBO.Init")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Orquestra toda a preparacao do relatorio:
    *   1. Valida filtros
    *   2. Gera cabecalho
    *   3. Processa dados por empresa
    * Equivalente aos metodos processamento + processa do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.ValidarFiltros()
                loc_lSucesso = .F.
            ELSE
                IF !THIS.GerarCabecalho()
                    loc_lSucesso = .F.
                ELSE
                    IF !THIS.Processar()
                        loc_lSucesso = .F.
                    ELSE
                        IF USED(THIS.this_cCursorDados)
                            SELECT (THIS.this_cCursorDados)
                            GO TOP
                        ENDIF
                        loc_lSucesso = .T.
                    ENDIF
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "PrepararDados")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Valida os filtros antes de processar
    * Equivalente as validacoes em btnReport.Click do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult, loc_nCount

        loc_lSucesso = .F.
        TRY
            *-- Validar data de posicao (obrigatoria)
            IF EMPTY(THIS.this_dDataPos)
                THIS.this_cMensagemErro = "Data inv" + CHR(225) + "lida!"
                loc_lSucesso = .F.
            ELSE
                loc_lSucesso = .T.
            ENDIF

            *-- Validar Grupo de Estoque (se preenchido)
            IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGcr" + ;
                    " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCdGrEstoque))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGrEst")
                IF loc_nResult >= 1
                    SELECT cursor_4c_ValGrEst
                    loc_nCount = NVL(cursor_4c_ValGrEst.nExiste, 0)
                    USE IN cursor_4c_ValGrEst
                    IF loc_nCount = 0
                        THIS.this_cMensagemErro = "Grupo de Estoque Inv" + ;
                            CHR(225) + "lido."
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    USE IN cursor_4c_ValGrEst
                ENDIF
            ENDIF

            *-- Validar Conta de Estoque (se preenchida)
            IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCdEstoque))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli" + ;
                    " WHERE iclis = " + EscaparSQL(ALLTRIM(THIS.this_cCdEstoque))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValEst")
                IF loc_nResult >= 1
                    SELECT cursor_4c_ValEst
                    loc_nCount = NVL(cursor_4c_ValEst.nExiste, 0)
                    USE IN cursor_4c_ValEst
                    IF loc_nCount = 0
                        THIS.this_cMensagemErro = "Conta de Estoque Inv" + ;
                            CHR(225) + "lida."
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    USE IN cursor_4c_ValEst
                ENDIF
            ENDIF

            *-- Validar Grande Grupo (se preenchido)
            IF loc_lSucesso AND !EMPTY(ALLTRIM(THIS.this_cCdGGrupo))
                loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGpr" + ;
                    " WHERE codigos = " + EscaparSQL(ALLTRIM(THIS.this_cCdGGrupo))
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_ValGGrp")
                IF loc_nResult >= 1
                    SELECT cursor_4c_ValGGrp
                    loc_nCount = NVL(cursor_4c_ValGGrp.nExiste, 0)
                    USE IN cursor_4c_ValGGrp
                    IF loc_nCount = 0
                        THIS.this_cMensagemErro = "Grande Grupo Inv" + ;
                            CHR(225) + "lido."
                        loc_lSucesso = .F.
                    ENDIF
                ELSE
                    USE IN cursor_4c_ValGGrp
                ENDIF
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ValidarFiltros")
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * GerarCabecalho - Cria cursor CsCabecalho para o relatorio FRX.
    * Equivalente ao bloco inicial de PROCEDURE processamento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE GerarCabecalho()
        LOCAL loc_lSucesso, loc_cNomeEmpresa, loc_cTitulo1, loc_cTitulo2
        LOCAL loc_cPeriodo, loc_llImpEtiq, loc_llImpCusto
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cGGrp
        LOCAL loc_ldDataPos

        loc_lSucesso = .F.
        TRY
            loc_cEmpresa  = ALLTRIM(THIS.this_cEmpresa)
            loc_cGrupo    = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cEstoque  = ALLTRIM(THIS.this_cCdEstoque)
            loc_cGGrp     = ALLTRIM(THIS.this_cCdGGrupo)
            loc_ldDataPos = THIS.this_dDataPos

            *-- Nome da empresa logada
            loc_cNomeEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa)
            IF USED("cursor_4c_SigCdEmp")
                SELECT cursor_4c_SigCdEmp
                IF SEEK(go_4c_Sistema.cCodEmpresa, "cursor_4c_SigCdEmp", "cemps")
                    loc_cNomeEmpresa = ALLTRIM(go_4c_Sistema.cCodEmpresa) + ;
                        " - " + ALLTRIM(cursor_4c_SigCdEmp.razas)
                ENDIF
            ENDIF

            *-- Titulos do relatorio
            loc_cTitulo1 = "Posi" + CHR(231) + CHR(227) + "o de Estoque por Grande Grupo"

            loc_cTitulo2 = "Grupo: " + IIF(EMPTY(loc_cGrupo), "Todos", ;
                loc_cGrupo + " - " + ALLTRIM(THIS.this_cDsGrEstoque)) + ;
                " / Estoque: " + IIF(EMPTY(loc_cEstoque), "Todos", ;
                loc_cEstoque + " - " + ALLTRIM(THIS.this_cDsEstoque)) + ;
                " / Grande Grupo: " + IIF(EMPTY(loc_cGGrp), "Todos", loc_cGGrp)

            loc_cPeriodo   = "Estoque Existente em " + DTOC(loc_ldDataPos)
            loc_llImpEtiq  = (loc_ldDataPos = DATE())
            loc_llImpCusto = (THIS.this_nOptCusto = 1)

            *-- Criar cursor CsCabecalho
            IF USED("CsCabecalho")
                USE IN CsCabecalho
            ENDIF

            CREATE CURSOR CsCabecalho ;
                (nomeempresa C(80), titulo1 C(80), titulo2 C(150), ;
                 periodo C(80), impetiq L, Impcusto L)

            INSERT INTO CsCabecalho (nomeempresa, titulo1, titulo2, periodo, impetiq, Impcusto) ;
                VALUES (loc_cNomeEmpresa, loc_cTitulo1, loc_cTitulo2, ;
                        loc_cPeriodo, loc_llImpEtiq, loc_llImpCusto)

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "GerarCabecalho")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processar - Orquestra o processamento por empresa.
    * Se empresa vazia: itera todas as empresas ativas de cursor_4c_SigCdEmp.
    * Se empresa especificada: processa apenas ela.
    * Acumula resultados em cursor_4c_Relatorio.
    * Equivalente ao corpo de PROCEDURE processamento do legado.
    *--------------------------------------------------------------------------
    PROCEDURE Processar()
        LOCAL loc_lSucesso, loc_llInicio, loc_llProcessa
        LOCAL loc_cEmpresa, loc_cGrupo, loc_cEstoque, loc_cGGrp, loc_cCodEmp

        loc_lSucesso = .F.
        loc_llInicio = .T.

        TRY
            loc_cEmpresa = ALLTRIM(THIS.this_cEmpresa)
            loc_cGrupo   = ALLTRIM(THIS.this_cCdGrEstoque)
            loc_cEstoque = ALLTRIM(THIS.this_cCdEstoque)
            loc_cGGrp    = ALLTRIM(THIS.this_cCdGGrupo)

            *-- Fechar cursor de relatorio anterior
            IF USED("cursor_4c_Relatorio")
                USE IN cursor_4c_Relatorio
            ENDIF

            IF EMPTY(loc_cEmpresa)
                *-- Processar todas as empresas ativas (exceto 999 e ESC)
                IF !USED("cursor_4c_SigCdEmp")
                    THIS.this_cMensagemErro = "Cursor de empresas n" + CHR(227) + "o dispon" + CHR(237) + "vel"
                    loc_lSucesso = .F.
                ENDIF
                SELECT cursor_4c_SigCdEmp
                GO TOP
                SCAN
                    loc_cCodEmp = ALLTRIM(cursor_4c_SigCdEmp.cemps)
                    IF cursor_4c_SigCdEmp.ativas = 1 ;
                            AND loc_cCodEmp <> "999" ;
                            AND loc_cCodEmp <> "ESC"
                        loc_llProcessa = THIS.ProcessarEmpresa(loc_cCodEmp, ;
                            loc_cGrupo, loc_cEstoque, loc_cGGrp)
                        IF !loc_llProcessa
                            loc_lSucesso = .F.
                        ENDIF
                        IF loc_llInicio
                            SELECT * FROM CsRel INTO CURSOR cursor_4c_Relatorio READWRITE
                            loc_llInicio = .F.
                        ELSE
                            SELECT CsRel
                            GO TOP
                            SCAN
                                SCATTER MEMO MEMVAR
                                INSERT INTO cursor_4c_Relatorio FROM MEMVAR
                                SELECT CsRel
                            ENDSCAN
                        ENDIF
                    ENDIF
                    SELECT cursor_4c_SigCdEmp
                ENDSCAN
            ELSE
                *-- Processar empresa unica
                loc_llProcessa = THIS.ProcessarEmpresa(loc_cEmpresa, ;
                    loc_cGrupo, loc_cEstoque, loc_cGGrp)
                IF !loc_llProcessa
                    loc_lSucesso = .F.
                ENDIF
                SELECT * FROM CsRel INTO CURSOR cursor_4c_Relatorio READWRITE
            ENDIF

            IF USED("cursor_4c_Relatorio")
                SELECT cursor_4c_Relatorio
                GO TOP
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Processar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ProcessarEmpresa - Executa as queries de estoque/etiquetas para uma empresa,
    * constroi os cursores intermediarios e gera o cursor CsRel agrupado.
    * Equivalente a PROCEDURE processa do legado SIGREEGG.
    *
    * Parametros:
    *   par_cEmpEst  - Codigo da empresa (3 chars)
    *   par_cGruEst  - Grupo de estoque (10 chars, pode ser vazio)
    *   par_cEstEst  - Conta de estoque (10 chars, pode ser vazio)
    *   par_cGGrupo  - Grande grupo (3 chars, pode ser vazio)
    *--------------------------------------------------------------------------
    PROCEDURE ProcessarEmpresa(par_cEmpEst, par_cGruEst, par_cEstEst, par_cGGrupo)
        LOCAL loc_lSucesso, loc_cSQL, loc_nResult
        LOCAL loc_cEmpIni, loc_cEmpFin, loc_cGruIni, loc_cGruFin, loc_cEstIni, loc_cEstFin
        LOCAL loc_cFiltro, loc_cFilEti, loc_cDataPosSQL
        LOCAL loc_ldDataPos, loc_lnCotCus, loc_lnSQtds, loc_lnCot, loc_lnCus
        LOCAL loc_cEGEs, loc_cSQLHis

        loc_lSucesso  = .F.
        loc_ldDataPos = THIS.this_dDataPos

        TRY
            *-- Formatar data/hora SQL: 'YYYY-MM-DD 23:59:59'
            loc_cDataPosSQL = "'" + ;
                PADL(YEAR(loc_ldDataPos),  4, "0") + "-" + ;
                PADL(MONTH(loc_ldDataPos), 2, "0") + "-" + ;
                PADL(DAY(loc_ldDataPos),   2, "0") + " 23:59:59'"

            *-- Cotacao da moeda selecionada na data de posicao
            loc_lnCotCus = 1
            IF !EMPTY(ALLTRIM(THIS.this_cCdMoeda))
                loc_lnCotCus = fBuscarCotacao(ALLTRIM(THIS.this_cCdMoeda), ;
                    loc_ldDataPos, gnConnHandle)
                IF loc_lnCotCus = 0
                    loc_lnCotCus = 1
                ENDIF
            ENDIF

            *-- Faixas de filtro (PADR garante comprimento fixo para BETWEEN/=)
            loc_cEmpIni = IIF(!EMPTY(ALLTRIM(par_cEmpEst)), ;
                PADR(ALLTRIM(par_cEmpEst), 3), SPACE(3))
            loc_cEmpFin = IIF(!EMPTY(ALLTRIM(par_cEmpEst)), ;
                PADR(ALLTRIM(par_cEmpEst), 3), REPLICATE(CHR(254), 3))
            loc_cGruIni = IIF(!EMPTY(ALLTRIM(par_cGruEst)), ;
                PADR(ALLTRIM(par_cGruEst), 10), SPACE(10))
            loc_cGruFin = IIF(!EMPTY(ALLTRIM(par_cGruEst)), ;
                PADR(ALLTRIM(par_cGruEst), 10), REPLICATE(CHR(254), 10))
            loc_cEstIni = IIF(!EMPTY(ALLTRIM(par_cEstEst)), ;
                PADR(ALLTRIM(par_cEstEst), 10), SPACE(10))
            loc_cEstFin = IIF(!EMPTY(ALLTRIM(par_cEstEst)), ;
                PADR(ALLTRIM(par_cEstEst), 10), REPLICATE(CHR(254), 10))

            *-- Filtro principal: empgruests = emp(3) + grupos(10) + estos(10)
            IF !EMPTY(ALLTRIM(par_cEmpEst)) AND ;
               !EMPTY(ALLTRIM(par_cGruEst)) AND ;
               !EMPTY(ALLTRIM(par_cEstEst))
                loc_cFiltro = "a.empgruests = '" + ;
                    PADR(ALLTRIM(par_cEmpEst), 3) + ;
                    PADR(ALLTRIM(par_cGruEst), 10) + ;
                    PADR(ALLTRIM(par_cEstEst), 10) + "'"
            ELSE
                loc_cFiltro = "a.empgruests BETWEEN '" + ;
                    loc_cEmpIni + loc_cGruIni + loc_cEstIni + ;
                    "' AND '" + ;
                    loc_cEmpFin + loc_cGruFin + loc_cEstFin + "'"
            ENDIF

            *-- Filtro etiquetas: usa colunas separadas (empos, grupos, contas)
            loc_cFilEti = "a.empos BETWEEN '" + ;
                    loc_cEmpIni + "' AND '" + loc_cEmpFin + "'" + ;
                " AND a.grupos BETWEEN '" + ;
                    loc_cGruIni + "' AND '" + loc_cGruFin + "'" + ;
                " AND a.contas BETWEEN '" + ;
                    loc_cEstIni + "' AND '" + loc_cEstFin + "'"
            IF loc_ldDataPos <> DATE()
                loc_cFilEti = loc_cFilEti + " AND a.datas <= " + loc_cDataPosSQL
            ENDIF

            *-- Fechar cursor temporario anterior
            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF

            *-- Query principal: SigMvEst com joins SigCdPro, SigCdGrp, SigCdGpr
            loc_cSQL = "SELECT a.cidchaves, a.emps, a.grupos, a.estos, a.cpros," + ;
                " a.sqtds AS saldo," + ;
                " c.mercs AS ggrupo, b.CustoFs, b.MoeCusFs, b.cUnis, d.Descs" + ;
                " FROM SigMvEst a" + ;
                " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                " INNER JOIN SigCdGrp c ON c.cgrus = b.cgrus" + ;
                " LEFT JOIN SigCdGpr d ON d.Codigos = c.Mercs" + ;
                " WHERE " + loc_cFiltro
            IF !EMPTY(ALLTRIM(par_cGGrupo))
                loc_cSQL = loc_cSQL + ;
                    " AND c.mercs = '" + ALLTRIM(par_cGGrupo) + "'"
            ENDIF
            loc_cSQL = loc_cSQL + ;
                " GROUP BY a.cidchaves, a.emps, a.grupos, a.estos, a.cpros," + ;
                " a.sqtds, c.mercs, b.CustoFs, b.MoeCusFs, d.Descs, b.cUnis"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEst")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Erro ao selecionar produtos do estoque"
                loc_lSucesso = .F.
            ENDIF

            *-- Se data diferente de hoje: recalcular saldo historico a partir de SigMvHst
            IF loc_ldDataPos <> DATE()
                SELECT TmpEst
                GO TOP
                SCAN
                    IF EMPTY(TmpEst.emps) OR EMPTY(TmpEst.grupos) OR EMPTY(TmpEst.estos)
                        DELETE
                        LOOP
                    ENDIF

                    loc_lnSQtds = 0

                    *-- Chave composta: emps(3) + grupos(10) + estos(10) = 23 chars
                    loc_cEGEs = PADR(ALLTRIM(TmpEst.emps), 3) + ;
                        PADR(ALLTRIM(TmpEst.grupos), 10) + ;
                        PADR(ALLTRIM(TmpEst.estos), 10)

                    IF USED("TmpHis")
                        USE IN TmpHis
                    ENDIF

                    loc_cSQLHis = "SELECT TOP 1 EmpGruEsts, Cpros, CidChaves, Sqtds" + ;
                        " FROM SigMvHst" + ;
                        " WHERE EmpGruEsts = " + EscaparSQL(loc_cEGEs) + ;
                        " AND CPros = " + EscaparSQL(ALLTRIM(TmpEst.cpros)) + ;
                        " AND Datas <= " + loc_cDataPosSQL + ;
                        " ORDER BY EmpGruEsts ASC, Cpros ASC, CidChaves DESC"

                    IF SQLEXEC(gnConnHandle, loc_cSQLHis, "TmpHis") >= 1
                        SELECT TmpHis
                        GO TOP
                        IF !EOF()
                            loc_lnSQtds = TmpHis.SQtds
                        ENDIF
                    ENDIF

                    SELECT TmpEst
                    REPLACE TmpEst.saldo WITH loc_lnSQtds
                ENDSCAN

                IF USED("TmpHis")
                    USE IN TmpHis
                ENDIF
            ENDIF

            *-- Agrupar TmpEst -> CsEst
            IF USED("CsEst")
                USE IN CsEst
            ENDIF

            SELECT MAX(emps) AS emps, grupos, estos, ggrupo, ;
                PADR(NVL(Descs, ""), 40) AS descs, MoeCusFs, cUnis, ;
                SUM(saldo) AS saldo, SUM(0.000) AS etiqs, ;
                SUM(CustoFs * saldo) AS CustoFs ;
                FROM TmpEst ;
                GROUP BY 2, 3, 4, 5, 6, 7 ;
                INTO CURSOR CsEst READWRITE

            IF USED("TmpEst")
                USE IN TmpEst
            ENDIF

            *-- Se data = hoje: buscar etiquetas de SigOpEtq
            IF loc_ldDataPos = DATE()
                IF USED("TmpEti")
                    USE IN TmpEti
                ENDIF

                loc_cSQL = "SELECT a.cbars, a.empos, a.grupos, a.contas, a.cpros," + ;
                    " a.qtds AS etiqs, c.mercs AS ggrupo," + ;
                    " d.Descs, b.CustoFs, b.MoeCusFs, b.cUnis" + ;
                    " FROM SigOpEtq a" + ;
                    " INNER JOIN SigCdPro b ON b.cpros = a.cpros" + ;
                    " INNER JOIN SigCdGrp c ON c.cgrus = b.cgrus" + ;
                    " LEFT JOIN SigCdGpr d ON d.Codigos = c.Mercs" + ;
                    " WHERE " + loc_cFilEti
                IF !EMPTY(ALLTRIM(par_cGGrupo))
                    loc_cSQL = loc_cSQL + ;
                        " AND c.mercs = '" + ALLTRIM(par_cGGrupo) + "'"
                ENDIF
                loc_cSQL = loc_cSQL + ;
                    " GROUP BY a.cbars, a.empos, a.grupos, a.contas, a.cpros," + ;
                    " a.qtds, c.mercs, d.Descs, b.CustoFs, b.MoeCusFs, b.cUnis"

                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "TmpEti")

                IF loc_nResult >= 1
                    IF USED("CsEti")
                        USE IN CsEti
                    ENDIF
                    SELECT MAX(empos) AS emps, grupos, contas AS estos, ggrupo, ;
                        PADR(NVL(Descs, ""), 40) AS descs, MoeCusFs, cUnis, ;
                        SUM(0.000) AS saldo, SUM(etiqs) AS etiqs, ;
                        SUM(0.000) AS CustoFs ;
                        FROM TmpEti ;
                        WHERE !EMPTY(grupos) AND !EMPTY(contas) ;
                        GROUP BY 2, 3, 4, 5, 6, 7 ;
                        INTO CURSOR CsEti READWRITE
                ENDIF

                IF USED("TmpEti")
                    USE IN TmpEti
                ENDIF
            ENDIF

            *-- Montar TmpRelatorio: UNION ALL CsEst + CsEti (ou apenas CsEst)
            IF USED("TmpRelatorio")
                USE IN TmpRelatorio
            ENDIF

            IF loc_ldDataPos = DATE() AND USED("CsEti")
                SELECT * FROM CsEst ;
                UNION ALL ;
                SELECT * FROM CsEti ;
                INTO CURSOR TmpRelatorio READWRITE
            ELSE
                SELECT * FROM CsEst INTO CURSOR TmpRelatorio READWRITE
            ENDIF

            IF USED("CsEst")
                USE IN CsEst
            ENDIF
            IF USED("CsEti")
                USE IN CsEti
            ENDIF

            *-- Converter custo para moeda selecionada (se opt_custo = 1)
            IF THIS.this_nOptCusto = 1 AND !EMPTY(ALLTRIM(THIS.this_cCdMoeda))
                SELECT TmpRelatorio
                SCAN
                    loc_lnCot = fBuscarCotacao(ALLTRIM(TmpRelatorio.MoeCusFs), ;
                        loc_ldDataPos, gnConnHandle)
                    IF loc_lnCot = 0
                        loc_lnCot = 1
                    ENDIF
                    loc_lnCus = TmpRelatorio.CustoFs * loc_lnCot / loc_lnCotCus
                    REPLACE TmpRelatorio.CustoFs WITH loc_lnCus, ;
                            TmpRelatorio.MoeCusFs WITH PADR(ALLTRIM(THIS.this_cCdMoeda), 3)
                ENDSCAN
            ENDIF

            *-- UNION ALL final com 3 tipos: detalhe(1), total grupo(2), total empresa(3)
            IF USED("CsRel")
                USE IN CsRel
            ENDIF

            IF THIS.this_nOptCusto = 1
                SELECT 1 AS Tps, Emps, Grupos, Estos, GGrupo, ;
                        Grupos AS GrupoI, Estos AS EstoI, GGrupo AS GGrupoI, ;
                        cUnis, Descs, MoeCusFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        SUM(CustoFs) AS CustoFS, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 2 AS Tps, Emps, Grupos, SPACE(10) AS Estos, ;
                        "   " AS GGrupo, SPACE(10) AS GrupoI, ;
                        SPACE(10) AS EstoI, "   " AS GGrupoI, ;
                        cUnis, PADR("Total Grupo", 40) AS Descs, MoeCusFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        SUM(CustoFs) AS CustoFS, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 3 AS Tps, Emps, REPLICATE(CHR(254), 10) AS Grupos, ;
                        SPACE(10) AS Estos, "   " AS GGrupo, ;
                        SPACE(10) AS GrupoI, SPACE(10) AS EstoI, ;
                        "   " AS GGrupoI, cUnis, ;
                        PADR("Total Empresa", 40) AS Descs, MoeCusFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        SUM(CustoFs) AS CustoFS, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                    INTO CURSOR CsRel ORDER BY 2, 3, 1, 5, 9, 11 READWRITE
            ELSE
                SELECT 1 AS Tps, Emps, Grupos, Estos, GGrupo, ;
                        Grupos AS GrupoI, Estos AS EstoI, GGrupo AS GGrupoI, ;
                        cUnis, Descs, " " AS MoeCusFs, 0 AS CustoFs, ;
                        SUM(Saldo) AS Saldo, SUM(Etiqs) AS Etiqs, ;
                        .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 2 AS Tps, Emps, Grupos, SPACE(10) AS Estos, ;
                        "   " AS GGrupo, SPACE(10) AS GrupoI, ;
                        SPACE(10) AS EstoI, "   " AS GGrupoI, ;
                        cUnis, PADR("Total Grupo", 40) AS Descs, " " AS MoeCusFs, ;
                        0 AS CustoFS, SUM(Saldo) AS Saldo, ;
                        SUM(Etiqs) AS Etiqs, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                UNION ALL ;
                SELECT 3 AS Tps, Emps, REPLICATE(CHR(254), 10) AS Grupos, ;
                        SPACE(10) AS Estos, "   " AS GGrupo, ;
                        SPACE(10) AS GrupoI, SPACE(10) AS EstoI, ;
                        "   " AS GGrupoI, cUnis, ;
                        PADR("Total Empresa", 40) AS Descs, " " AS MoeCusFs, ;
                        0 AS CustoFS, SUM(Saldo) AS Saldo, ;
                        SUM(Etiqs) AS Etiqs, .F. AS ImpLinha ;
                    FROM TmpRelatorio ;
                    GROUP BY 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ;
                    INTO CURSOR CsRel ORDER BY 2, 3, 1, 5, 9, 11 READWRITE
            ENDIF

            IF USED("TmpRelatorio")
                USE IN TmpRelatorio
            ENDIF

            *-- Remover linhas com saldo = 0 (e etiqs = 0 se for hoje)
            IF loc_ldDataPos = DATE()
                DELETE FROM CsRel WHERE saldo = 0 AND etiqs = 0
            ELSE
                DELETE FROM CsRel WHERE saldo = 0
            ENDIF

            *-- Marcar ImpLinha: linha anterior a cada "Total ..." recebe .T.
            SELECT CsRel
            GO TOP
            LOCAL loc_nVz, loc_cDescAtual
            loc_nVz = 1
            DO WHILE !EOF()
                IF loc_nVz = 1
                    LOCATE FOR Descs = "Total "
                ELSE
                    CONTINUE
                ENDIF
                IF !EOF()
                    SKIP -1
                    IF !DELETED()
                        REPLACE ImpLinha WITH .T.
                    ENDIF
                    SKIP
                    loc_cDescAtual = Descs
                    DO WHILE Descs = loc_cDescAtual AND !EOF()
                        SKIP
                    ENDDO
                    IF !EOF()
                        SKIP -1
                    ENDIF
                ENDIF
                loc_nVz = 2
            ENDDO

            SELECT CsRel
            GO TOP

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "ProcessarEmpresa")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizar - Prepara dados e exibe relatorio em preview na tela.
    * Equivalente a PROCEDURE visualizacao do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE Visualizar()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEgg"
                REPORT FORM &loc_cRelPath PREVIEW NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Visualizar")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Imprimir - Prepara dados e envia relatorio para impressora com prompt.
    * Equivalente a PROCEDURE impressao do legado SIGREEGG.
    *--------------------------------------------------------------------------
    PROCEDURE Imprimir()
        LOCAL loc_cRelPath, loc_lSucesso

        loc_lSucesso = .F.
        TRY
            IF !THIS.PrepararDados()
                loc_lSucesso = .F.
            ELSE
                loc_cRelPath = IIF(TYPE("gc_4c_CaminhoReports") = "C", ;
                    gc_4c_CaminhoReports, "") + "SigReEgg"
                REPORT FORM &loc_cRelPath TO PRINTER PROMPT NOCONSOLE
                IF USED("CsCabecalho")
                    USE IN CsCabecalho
                ENDIF
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Imprimir")
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - NAO APLICAVEL a Relatorios.
    * Stub para compatibilidade com pipeline de validacao (Fase 2).
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - NAO APLICAVEL a Relatorios.
    * Relatorios sao somente-leitura. Use Imprimir() ou Visualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - NAO APLICAVEL a Relatorios.
    * Relatorios sao somente-leitura. Use Imprimir() ou Visualizar().
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada em relat" + CHR(243) + "rios"
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Relatorio nao tem chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        RETURN ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna mensagem de erro atual
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * LimparCursoresIntermedios - Fecha todos os cursores temporarios
    *--------------------------------------------------------------------------
    PROCEDURE LimparCursoresIntermedios()
        LOCAL loc_aCursores[8], loc_i

        loc_aCursores[1] = "TmpEst"
        loc_aCursores[2] = "TmpEti"
        loc_aCursores[3] = "TmpHis"
        loc_aCursores[4] = "TmpRelatorio"
        loc_aCursores[5] = "CsEst"
        loc_aCursores[6] = "CsEti"
        loc_aCursores[7] = "CsRel"
        loc_aCursores[8] = "CsCabecalho"

        FOR loc_i = 1 TO ALEN(loc_aCursores)
            IF USED(loc_aCursores[loc_i])
                USE IN (loc_aCursores[loc_i])
            ENDIF
        NEXT
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera cursores de referencia e intermediarios
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        THIS.LimparCursoresIntermedios()

        IF USED("cursor_4c_SigCdEmp")
            USE IN cursor_4c_SigCdEmp
        ENDIF
        IF USED("cursor_4c_Relatorio")
            USE IN cursor_4c_Relatorio
        ENDIF

        DODEFAULT()
    ENDPROC

ENDDEFINE

