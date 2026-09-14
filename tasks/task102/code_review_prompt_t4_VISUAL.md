# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [LAYOUT-POSITION] Controle 'MarcarOpe' (parent: SIGREFFN): Top original=446 vs migrado 'cmd_4c_DesmarcarOpe' Top=487 (diff=41px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'MarcarDisp' (parent: SIGREFFN): Top original=448 vs migrado 'cmd_4c_DesmarcarDisp' Top=489 (diff=41px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreffn.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (2109 linhas total):

*-- Linhas 9 a 28:
9: *   - Moeda de refer" + CHR(234) + "ncia (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdMoe)
10: *   - Cota" + CHR(231) + CHR(227) + "o (num" + CHR(233) + "rico - auto do BO via BuscarCotacaoAtual)
11: *   - Moeda de lan" + CHR(231) + "amento (c" + CHR(243) + "digo + descri" + CHR(231) + CHR(227) + "o - SigCdMoe)
12: *   - Totaliza Contas (CheckBox)
13: *   - Conciliado (CheckBox)
14: *   - Op" + CHR(231) + CHR(227) + "o NF (Sim/N" + CHR(227) + "o/Ambos)
15: *   - Fluxo / Tipo Impress" + CHR(227) + "o (Di" + CHR(225) + "rio/Semanal/Quinzenal/Mensal)
16: *   - Listar Atrasos (Sim/N" + CHR(227) + "o)
17: *   - Considerar Atrasos (Sim/N" + CHR(227) + "o)
18: *   - Previsto (Sim/N" + CHR(227) + "o/Ambos)
19: *   - Situa" + CHR(231) + CHR(227) + "o (Baixados/Em Aberto/Todos)
20: *   - Saldo (Anterior/Na Data)
21: *   - Empresas selecion" + CHR(225) + "veis (Grid cEmp com CheckBox)
22: *   - Disponibilidades selecion" + CHR(225) + "veis (Grid cDisp com CheckBox)
23: *   - Opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos selecion" + CHR(225) + "veis (Grid crSigOpOpe com CheckBox)
24: *==============================================================================
25: 
26: DEFINE CLASS Formsigreffn AS FormBase
27: 
28:     Height      = 580

*-- Linhas 57 a 65:
57:         loc_lSucesso   = .F.
58:         loc_lContinuar = .T.
59:         TRY
60:             THIS.Caption = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico"
61: 
62:             IF TYPE("gc_4c_CaminhoIcones") = "U"
63:                 gc_4c_CaminhoIcones = ""
64:             ENDIF
65:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 85 a 94:
85:                 THIS.ConfigurarBotoes()
86:                 THIS.ConfigurarPageFrame()
87: 
88:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
89:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
90: 
91:                 THIS.ConfigurarPaginaLista()
92:                 THIS.AlternarPagina(1)
93: 
94:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")

*-- Linhas 116 a 189:
116:     PROTECTED PROCEDURE ConfigurarCabecalho()
117:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
118:         WITH THIS.cnt_4c_Cabecalho
119:             .Top         = 0
120:             .Left        = 0
121:             .Width       = THIS.Width
122:             .Height      = 80
123:             .BackStyle   = 1
124:             .BackColor   = RGB(100, 100, 100)
125:             .BorderWidth = 0
126:             .Visible     = .T.
127: 
128:             .AddObject("lbl_4c_Sombra", "Label")
129:             WITH .lbl_4c_Sombra
130:                 .Top       = 22
131:                 .Left      = 22
132:                 .Width     = THIS.Width
133:                 .Height    = 30
134:                 .Caption   = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico"
135:                 .FontName  = "Tahoma"
136:                 .FontSize  = 14
137:                 .FontBold  = .T.
138:                 .ForeColor = RGB(0, 0, 0)
139:                 .BackStyle = 0
140:                 .Visible   = .T.
141:             ENDWITH
142: 
143:             .AddObject("lbl_4c_Titulo", "Label")
144:             WITH .lbl_4c_Titulo
145:                 .Top       = 20
146:                 .Left      = 20
147:                 .Width     = THIS.Width
148:                 .Height    = 30
149:                 .Caption   = "Relat" + CHR(243) + "rio de Fluxo Financeiro - Sint" + CHR(233) + "tico"
150:                 .FontName  = "Tahoma"
151:                 .FontSize  = 14
152:                 .FontBold  = .T.
153:                 .ForeColor = RGB(255, 255, 255)
154:                 .BackStyle = 0
155:                 .Visible   = .T.
156:             ENDWITH
157:         ENDWITH
158:     ENDPROC
159: 
160:     *--------------------------------------------------------------------------
161:     * ConfigurarBotoes - CommandGroup com 4 bot" + CHR(245) + "es do relat" + CHR(243) + "rio
162:     *   Original: btnReport.Left=530, Top=0
163:     *--------------------------------------------------------------------------
164:     PROTECTED PROCEDURE ConfigurarBotoes()
165:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
166:         WITH THIS.cmg_4c_Botoes
167:             .Top           = 0
168:             .Left          = 529
169:             .Width         = 273
170:             .Height        = 80
171:             .ButtonCount   = 4
172:             .BackStyle     = 0
173:             .BorderStyle   = 0
174:             .BorderColor   = RGB(136, 189, 188)
175:             .SpecialEffect = 1
176:             .Themes        = .F.
177:             .Visible       = .T.
178: 
179:             WITH .Buttons(1)
180:                 .Top             = 5
181:                 .Left            = 5
182:                 .Width           = 65
183:                 .Height          = 70
184:                 .Caption         = "Visualizar"
185:                 .FontBold        = .T.
186:                 .FontItalic      = .T.
187:                 .BackColor       = RGB(255, 255, 255)
188:                 .ForeColor       = RGB(90, 90, 90)
189:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 196 a 208:
196:             ENDWITH
197: 
198:             WITH .Buttons(2)
199:                 .Top             = 5
200:                 .Left            = 71
201:                 .Width           = 65
202:                 .Height          = 70
203:                 .Caption         = "Imprimir"
204:                 .FontName        = "Tahoma"
205:                 .FontBold        = .T.
206:                 .FontItalic      = .T.
207:                 .FontSize        = 8
208:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 217 a 229:
217:             ENDWITH
218: 
219:             WITH .Buttons(3)
220:                 .Top             = 5
221:                 .Left            = 137
222:                 .Width           = 65
223:                 .Height          = 70
224:                 .Caption         = "Excel"
225:                 .FontName        = "Tahoma"
226:                 .FontBold        = .T.
227:                 .FontItalic      = .T.
228:                 .FontSize        = 8
229:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 238 a 250:
238:             ENDWITH
239: 
240:             WITH .Buttons(4)
241:                 .Top             = 5
242:                 .Left            = 203
243:                 .Width           = 65
244:                 .Height          = 70
245:                 .Caption         = "Encerrar"
246:                 .Cancel          = .T.
247:                 .FontName        = "Tahoma"
248:                 .FontBold        = .T.
249:                 .FontItalic      = .T.
250:                 .FontSize        = 8

*-- Linhas 272 a 286:
272: 
273:         loc_oPgf.PageCount = 1
274: 
275:         loc_oPgf.Top    = 85
276:         loc_oPgf.Left   = -1
277:         loc_oPgf.Width  = THIS.Width + 2
278:         loc_oPgf.Height = THIS.Height - 85
279:         loc_oPgf.Tabs   = .F.
280: 
281:         loc_oPgf.Page1.Caption   = "Filtros"
282:         loc_oPgf.Page1.FontName  = "Tahoma"
283:         loc_oPgf.Page1.FontSize  = 8
284:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
285:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
286:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)

*-- Linhas 341 a 355:
341:         LOCAL loc_oGrd, loc_oErro
342:         TRY
343:             *-- Label " Empresas " (original top=168, left=309)
344:             par_oPag.AddObject("lbl_4c_LblEmpresas", "Label")
345:             WITH par_oPag.lbl_4c_LblEmpresas
346:                 .Top        = 83
347:                 .Left       = 309
348:                 .Width      = 63
349:                 .Height     = 15
350:                 .Caption    = " Empresas "
351:                 .FontName   = "Tahoma"
352:                 .FontSize   = 8
353:                 .FontBold   = .T.
354:                 .FontItalic = .T.
355:                 .ForeColor  = RGB(90, 90, 90)

*-- Linhas 365 a 374:
365:                 loc_oGrd.RecordSource = "cEmp"
366:             ENDIF
367:             WITH loc_oGrd
368:                 .Top                = 101
369:                 .Left               = 307
370:                 .Width              = 357
371:                 .Height             = 185
372:                 .FontName           = "Tahoma"
373:                 .FontSize           = 8
374:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 389 a 398:
389:                 .Column2.Width = 30
390:                 .Column3.Width = 289
391: 
392:                 .Column1.AddObject("Check1", "CheckBox")
393:                 .Column1.Check1.Caption   = ""
394:                 .Column1.Check1.Value     = 0
395:                 .Column1.Check1.Visible   = .T.
396:                 .Column1.CurrentControl   = "Check1"
397:                 .Column1.Resizable        = .F.
398:                 .Column1.Sparse           = .F.

*-- Linhas 407 a 460:
407:                 .Column2.ControlSource = "cEmp.Cemps"
408:                 .Column3.ControlSource = "cEmp.Razas"
409: 
410:                 .Column1.Header1.Caption = ""
411:                 .Column2.Header1.Caption = ""
412:                 .Column3.Header1.Caption = ""
413: 
414:                 .Visible = .T.
415:             ENDWITH
416: 
417:             *-- Botao Marcar Empresas (original: top=239, left=669)
418:             par_oPag.AddObject("cmd_4c_MarcarEmp", "CommandButton")
419:             WITH par_oPag.cmd_4c_MarcarEmp
420:                 .Top           = 239
421:                 .Left          = 669
422:                 .Width         = 40
423:                 .Height        = 40
424:                 .Caption       = "Sel"
425:                 .FontName      = "Tahoma"
426:                 .FontSize      = 8
427:                 .FontBold      = .T.
428:                 .BackColor     = RGB(255, 255, 255)
429:                 .ForeColor     = RGB(90, 90, 90)
430:                 .SpecialEffect = 0
431:                 .Themes        = .F.
432:                 .ToolTipText   = "Marcar Todas as Empresas"
433:                 .Visible       = .T.
434:             ENDWITH
435:             BINDEVENT(par_oPag.cmd_4c_MarcarEmp, "Click", THIS, "BtnMarcarEmpClick")
436: 
437:             *-- Botao Desmarcar Empresas (original: top=279, left=669)
438:             par_oPag.AddObject("cmd_4c_DesmarcarEmp", "CommandButton")
439:             WITH par_oPag.cmd_4c_DesmarcarEmp
440:                 .Top           = 279
441:                 .Left          = 669
442:                 .Width         = 40
443:                 .Height        = 40
444:                 .Caption       = "Des"
445:                 .FontName      = "Tahoma"
446:                 .FontSize      = 8
447:                 .FontBold      = .T.
448:                 .BackColor     = RGB(255, 255, 255)
449:                 .ForeColor     = RGB(90, 90, 90)
450:                 .SpecialEffect = 0
451:                 .Themes        = .F.
452:                 .ToolTipText   = "Desmarcar Todas as Empresas"
453:                 .Visible       = .T.
454:             ENDWITH
455:             BINDEVENT(par_oPag.cmd_4c_DesmarcarEmp, "Click", THIS, "BtnDesmarcarEmpClick")
456: 
457:         CATCH TO loc_oErro
458:             MsgErro(loc_oErro.Message, "ConfigurarGridEmpresas")
459:         ENDTRY
460:     ENDPROC

*-- Linhas 469 a 483:
469:         LOCAL loc_oGrd, loc_oErro
470:         TRY
471:             *-- Label " Disponibilidades " (original top=412, left=76)
472:             par_oPag.AddObject("lbl_4c_LblDisps", "Label")
473:             WITH par_oPag.lbl_4c_LblDisps
474:                 .Top        = 327
475:                 .Left       = 76
476:                 .Width      = 99
477:                 .Height     = 15
478:                 .Caption    = " Disponibilidades "
479:                 .FontName   = "Tahoma"
480:                 .FontSize   = 8
481:                 .FontBold   = .T.
482:                 .FontItalic = .T.
483:                 .ForeColor  = RGB(90, 90, 90)

*-- Linhas 493 a 502:
493:                 loc_oGrd.RecordSource = "cDisp"
494:             ENDIF
495:             WITH loc_oGrd
496:                 .Top                = 343
497:                 .Left               = 74
498:                 .Width              = 196
499:                 .Height             = 111
500:                 .FontName           = "Tahoma"
501:                 .FontSize           = 8
502:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 517 a 526:
517:                 .Column2.Width = 79
518:                 .Column3.Width = 79
519: 
520:                 .Column1.AddObject("Check1", "CheckBox")
521:                 .Column1.Check1.Caption   = ""
522:                 .Column1.Check1.Value     = 0
523:                 .Column1.Check1.Visible   = .T.
524:                 .Column1.CurrentControl   = "Check1"
525:                 .Column1.Resizable        = .F.
526:                 .Column1.Sparse           = .F.

*-- Linhas 535 a 611:
535:                 .Column2.ControlSource = "cDisp.Grupos"
536:                 .Column3.ControlSource = "cDisp.Contas"
537: 
538:                 .Column1.Header1.Caption = ""
539:                 .Column2.Header1.Caption = ""
540:                 .Column3.Header1.Caption = ""
541: 
542:                 .Visible = .T.
543:             ENDWITH
544: 
545:             *-- Botao Marcar Disponibilidades (original: top=448, left=275)
546:             par_oPag.AddObject("cmd_4c_MarcarDisp", "CommandButton")
547:             WITH par_oPag.cmd_4c_MarcarDisp
548:                 .Top           = 446
549:                 .Left          = 275
550:                 .Width         = 40
551:                 .Height        = 40
552:                 .Caption       = "Sel"
553:                 .FontName      = "Tahoma"
554:                 .FontSize      = 8
555:                 .FontBold      = .T.
556:                 .BackColor     = RGB(255, 255, 255)
557:                 .ForeColor     = RGB(90, 90, 90)
558:                 .SpecialEffect = 0
559:                 .Themes        = .F.
560:                 .ToolTipText   = "Marcar Todas as Disponibilidades"
561:                 .Visible       = .T.
562:             ENDWITH
563:             BINDEVENT(par_oPag.cmd_4c_MarcarDisp, "Click", THIS, "BtnMarcarDispClick")
564: 
565:             *-- Botao Desmarcar Disponibilidades (original: top=489, left=275)
566:             par_oPag.AddObject("cmd_4c_DesmarcarDisp", "CommandButton")
567:             WITH par_oPag.cmd_4c_DesmarcarDisp
568:                 .Top           = 487
569:                 .Left          = 275
570:                 .Width         = 40
571:                 .Height        = 40
572:                 .Caption       = "Des"
573:                 .FontName      = "Tahoma"
574:                 .FontSize      = 8
575:                 .FontBold      = .T.
576:                 .BackColor     = RGB(255, 255, 255)
577:                 .ForeColor     = RGB(90, 90, 90)
578:                 .SpecialEffect = 0
579:                 .Themes        = .F.
580:                 .ToolTipText   = "Desmarcar Todas as Disponibilidades"
581:                 .Visible       = .T.
582:             ENDWITH
583:             BINDEVENT(par_oPag.cmd_4c_DesmarcarDisp, "Click", THIS, "BtnDesmarcarDispClick")
584: 
585:         CATCH TO loc_oErro
586:             MsgErro(loc_oErro.Message, "ConfigurarGridDisponibilidades")
587:         ENDTRY
588:     ENDPROC
589: 
590:     *--------------------------------------------------------------------------
591:     * ConfigurarGridOperacoes - Grid de sele" + CHR(231) + CHR(227) + "o de opera" + CHR(231) + CHR(245) + "es de t" + CHR(237) + "tulos
592:     *   Original: top=428, left=380, width=257, height=111 (2 colunas)
593:     *   Page1: top=343 (428-85), left=380
594:     *   Cursor: crSigOpOpe (SeleOp LOGICAL, Dopes)
595:     *--------------------------------------------------------------------------
596:     PROTECTED PROCEDURE ConfigurarGridOperacoes(par_oPag)
597:         LOCAL loc_oGrd, loc_oErro
598:         TRY
599:             *-- Label " Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos " (original top=410, left=381)
600:             par_oPag.AddObject("lbl_4c_LblOper", "Label")
601:             WITH par_oPag.lbl_4c_LblOper
602:                 .Top        = 325
603:                 .Left       = 381
604:                 .Width      = 126
605:                 .Height     = 15
606:                 .Caption    = " Opera" + CHR(231) + CHR(245) + "es de T" + CHR(237) + "tulos "
607:                 .FontName   = "Tahoma"
608:                 .FontSize   = 8
609:                 .FontBold   = .T.
610:                 .FontItalic = .T.
611:                 .ForeColor  = RGB(90, 90, 90)

*-- Linhas 621 a 630:
621:                 loc_oGrd.RecordSource = "crSigOpOpe"
622:             ENDIF
623:             WITH loc_oGrd
624:                 .Top                = 343
625:                 .Left               = 380
626:                 .Width              = 257
627:                 .Height             = 111
628:                 .FontName           = "Tahoma"
629:                 .FontSize           = 8
630:                 .ForeColor          = RGB(90, 90, 90)

*-- Linhas 644 a 653:
644:                 .Column1.Width = 15
645:                 .Column2.Width = 220
646: 
647:                 .Column1.AddObject("Check1", "CheckBox")
648:                 .Column1.Check1.Caption   = ""
649:                 .Column1.Check1.Value     = 0
650:                 .Column1.Check1.Visible   = .T.
651:                 .Column1.CurrentControl   = "Check1"
652:                 .Column1.Resizable        = .F.
653:                 .Column1.Sparse           = .F.

*-- Linhas 659 a 797:
659:                 .Column1.ControlSource = "crSigOpOpe.SeleOp"
660:                 .Column2.ControlSource = "crSigOpOpe.Dopes"
661: 
662:                 .Column1.Header1.Caption = ""
663:                 .Column2.Header1.Caption = ""
664: 
665:                 .Visible = .T.
666:             ENDWITH
667: 
668:             *-- Botao Marcar Operacoes (original: top=446, left=642)
669:             par_oPag.AddObject("cmd_4c_MarcarOpe", "CommandButton")
670:             WITH par_oPag.cmd_4c_MarcarOpe
671:                 .Top           = 446
672:                 .Left          = 642
673:                 .Width         = 40
674:                 .Height        = 40
675:                 .Caption       = "Sel"
676:                 .FontName      = "Tahoma"
677:                 .FontSize      = 8
678:                 .FontBold      = .T.
679:                 .BackColor     = RGB(255, 255, 255)
680:                 .ForeColor     = RGB(90, 90, 90)
681:                 .SpecialEffect = 0
682:                 .Themes        = .F.
683:                 .ToolTipText   = "Marcar Todas as Opera" + CHR(231) + CHR(245) + "es"
684:                 .Visible       = .T.
685:             ENDWITH
686:             BINDEVENT(par_oPag.cmd_4c_MarcarOpe, "Click", THIS, "BtnMarcarOpeClick")
687: 
688:             *-- Botao Desmarcar Operacoes (original: top=487, left=642)
689:             par_oPag.AddObject("cmd_4c_DesmarcarOpe", "CommandButton")
690:             WITH par_oPag.cmd_4c_DesmarcarOpe
691:                 .Top           = 487
692:                 .Left          = 642
693:                 .Width         = 40
694:                 .Height        = 40
695:                 .Caption       = "Des"
696:                 .FontName      = "Tahoma"
697:                 .FontSize      = 8
698:                 .FontBold      = .T.
699:                 .BackColor     = RGB(255, 255, 255)
700:                 .ForeColor     = RGB(90, 90, 90)
701:                 .SpecialEffect = 0
702:                 .Themes        = .F.
703:                 .ToolTipText   = "Desmarcar Todas as Opera" + CHR(231) + CHR(245) + "es"
704:                 .Visible       = .T.
705:             ENDWITH
706:             BINDEVENT(par_oPag.cmd_4c_DesmarcarOpe, "Click", THIS, "BtnDesmarcarOpeClick")
707: 
708:         CATCH TO loc_oErro
709:             MsgErro(loc_oErro.Message, "ConfigurarGridOperacoes")
710:         ENDTRY
711:     ENDPROC
712: 
713:     *--------------------------------------------------------------------------
714:     * ConfigurarPaginaDados - Controles de filtro do SIGREFFN
715:     *   Posicoes: SCX Top - PageFrame.Top(85) = top na Page1
716:     *--------------------------------------------------------------------------
717:     PROTECTED PROCEDURE ConfigurarPaginaDados(par_oPag)
718:         LOCAL loc_oErro
719:         TRY
720:             *== SECAO PERIODO (original: lbl top=178, get_dt top=175) =========
721: 
722:             par_oPag.AddObject("lbl_4c_Periodo", "Label")
723:             WITH par_oPag.lbl_4c_Periodo
724:                 .Top       = 93
725:                 .Left      = 64
726:                 .Width     = 45
727:                 .Height    = 15
728:                 .Caption   = "Per" + CHR(237) + "odo :"
729:                 .FontName  = "Tahoma"
730:                 .FontSize  = 8
731:                 .ForeColor = RGB(90, 90, 90)
732:                 .BackStyle = 0
733:                 .Visible   = .T.
734:             ENDWITH
735: 
736:             par_oPag.AddObject("txt_4c__dt_inicial", "TextBox")
737:             WITH par_oPag.txt_4c__dt_inicial
738:                 .Top      = 90
739:                 .Left     = 112
740:                 .Width    = 80
741:                 .Height   = 23
742:                 .Value    = {}
743:                 .Format   = "K"
744:                 .FontName = "Tahoma"
745:                 .FontSize = 8
746:                 .Visible  = .T.
747:             ENDWITH
748: 
749:             par_oPag.AddObject("lbl_4c_PeriodoA", "Label")
750:             WITH par_oPag.lbl_4c_PeriodoA
751:                 .Top       = 94
752:                 .Left      = 195
753:                 .Width     = 8
754:                 .Height    = 15
755:                 .Caption   = CHR(224)
756:                 .BackStyle = 0
757:                 .Visible   = .T.
758:             ENDWITH
759: 
760:             par_oPag.AddObject("txt_4c__dt_final", "TextBox")
761:             WITH par_oPag.txt_4c__dt_final
762:                 .Top      = 90
763:                 .Left     = 206
764:                 .Width    = 80
765:                 .Height   = 23
766:                 .Value    = {}
767:                 .Format   = "K"
768:                 .FontName = "Tahoma"
769:                 .FontSize = 8
770:                 .Visible  = .T.
771:             ENDWITH
772: 
773:             *== SECAO MOEDA DE REFERENCIA (original: lbl top=202, get_cd top=199) =
774: 
775:             par_oPag.AddObject("lbl_4c_Moeda", "Label")
776:             WITH par_oPag.lbl_4c_Moeda
777:                 .Top       = 117
778:                 .Left      = 68
779:                 .Width     = 41
780:                 .Height    = 15
781:                 .Caption   = "Moeda :"
782:                 .FontName  = "Tahoma"
783:                 .FontSize  = 8
784:                 .ForeColor = RGB(90, 90, 90)
785:                 .BackStyle = 0
786:                 .Visible   = .T.
787:             ENDWITH
788: 
789:             par_oPag.AddObject("txt_4c__cd_moeda", "TextBox")
790:             WITH par_oPag.txt_4c__cd_moeda
791:                 .Top           = 114
792:                 .Left          = 112
793:                 .Width         = 31
794:                 .Height        = 23
795:                 .Value         = ""
796:                 .MaxLength     = 3
797:                 .Format        = "K"

*-- Linhas 809 a 818:
809: 
810:             par_oPag.AddObject("txt_4c__ds_moeda", "TextBox")
811:             WITH par_oPag.txt_4c__ds_moeda
812:                 .Top       = 114
813:                 .Left      = 145
814:                 .Width     = 115
815:                 .Height    = 23
816:                 .Value     = ""
817:                 .MaxLength = 15
818:                 .Format    = "K"

*-- Linhas 825 a 850:
825: 
826:             *== SECAO COTACAO (original: lbl top=226, get top=223) =============
827: 
828:             par_oPag.AddObject("lbl_4c_Cotacao", "Label")
829:             WITH par_oPag.lbl_4c_Cotacao
830:                 .Top       = 141
831:                 .Left      = 60
832:                 .Width     = 49
833:                 .Height    = 15
834:                 .Caption   = "Cota" + CHR(231) + CHR(227) + "o :"
835:                 .FontName  = "Tahoma"
836:                 .FontSize  = 8
837:                 .ForeColor = RGB(90, 90, 90)
838:                 .BackStyle = 0
839:                 .Visible   = .T.
840:             ENDWITH
841: 
842:             par_oPag.AddObject("txt_4c_cotacao", "TextBox")
843:             WITH par_oPag.txt_4c_cotacao
844:                 .Top           = 138
845:                 .Left          = 112
846:                 .Width         = 80
847:                 .Height        = 23
848:                 .Value         = 0
849:                 .InputMask     = "999,999.99"
850:                 .Alignment     = 1

*-- Linhas 860 a 885:
860: 
861:             *== SECAO MOEDA DE LANCAMENTO (original: lbl top=250, get top=247) =
862: 
863:             par_oPag.AddObject("lbl_4c_MoeLanc", "Label")
864:             WITH par_oPag.lbl_4c_MoeLanc
865:                 .Top       = 165
866:                 .Left      = 62
867:                 .Width     = 47
868:                 .Height    = 15
869:                 .Caption   = "Moe Lan" + CHR(231)
870:                 .FontName  = "Tahoma"
871:                 .FontSize  = 8
872:                 .ForeColor = RGB(90, 90, 90)
873:                 .BackStyle = 0
874:                 .Visible   = .T.
875:             ENDWITH
876: 
877:             par_oPag.AddObject("txt_4c_cd_moedl", "TextBox")
878:             WITH par_oPag.txt_4c_cd_moedl
879:                 .Top           = 162
880:                 .Left          = 112
881:                 .Width         = 31
882:                 .Height        = 23
883:                 .Value         = ""
884:                 .MaxLength     = 3
885:                 .Format        = "K"

*-- Linhas 897 a 1378:
897: 
898:             par_oPag.AddObject("txt_4c_ds_moedl", "TextBox")
899:             WITH par_oPag.txt_4c_ds_moedl
900:                 .Top       = 162
901:                 .Left      = 145
902:                 .Width     = 115
903:                 .Height    = 23
904:                 .Value     = ""
905:                 .MaxLength = 15
906:                 .Format    = "K"
907:                 .FontName  = "Tahoma"
908:                 .FontSize  = 8
909:                 .Visible   = .T.
910:             ENDWITH
911:             BINDEVENT(par_oPag.txt_4c_ds_moedl, "KeyPress", THIS, "TeclaDsMoedl")
912:             BINDEVENT(par_oPag.txt_4c_ds_moedl, "DblClick", THIS, "TeclaDsMoedlDblClick")
913: 
914:             *== CHECKBOXES (original: Check1 top=271, Conc top=271) ===========
915: 
916:             par_oPag.AddObject("chk_4c_TotalizaContas", "CheckBox")
917:             WITH par_oPag.chk_4c_TotalizaContas
918:                 .Top       = 186
919:                 .Left      = 64
920:                 .Width     = 92
921:                 .Height    = 15
922:                 .Caption   = "Totaliza Contas"
923:                 .Value     = 0
924:                 .FontName  = "Tahoma"
925:                 .FontSize  = 8
926:                 .Alignment = 0
927:                 .BackStyle = 0
928:                 .ForeColor = RGB(90, 90, 90)
929:                 .AutoSize  = .T.
930:                 .Visible   = .T.
931:             ENDWITH
932: 
933:             par_oPag.AddObject("chk_4c_Conciliado", "CheckBox")
934:             WITH par_oPag.chk_4c_Conciliado
935:                 .Top       = 271
936:                 .Left      = 183
937:                 .Width     = 66
938:                 .Height    = 15
939:                 .Caption   = "Conciliado"
940:                 .Value     = 0
941:                 .FontName  = "Tahoma"
942:                 .FontSize  = 8
943:                 .Alignment = 0
944:                 .BackStyle = 0
945:                 .ForeColor = RGB(90, 90, 90)
946:                 .AutoSize  = .T.
947:                 .Visible   = .T.
948:             ENDWITH
949: 
950:             *== SECAO OPCAO NF (original: Say1 top=290, Opt_Opcao top=285) ====
951: 
952:             par_oPag.AddObject("lbl_4c_Opcao", "Label")
953:             WITH par_oPag.lbl_4c_Opcao
954:                 .Top       = 205
955:                 .Left      = 64
956:                 .Width     = 40
957:                 .Height    = 15
958:                 .Caption   = "Op" + CHR(231) + CHR(227) + "o :"
959:                 .FontName  = "Tahoma"
960:                 .FontSize  = 8
961:                 .ForeColor = RGB(90, 90, 90)
962:                 .BackStyle = 0
963:                 .Visible   = .T.
964:             ENDWITH
965: 
966:             par_oPag.AddObject("obj_4c_Opt_opcao", "OptionGroup")
967:             WITH par_oPag.obj_4c_Opt_opcao
968:                 .Top           = 285
969:                 .Left          = 105
970:                 .Width         = 177
971:                 .Height        = 25
972:                 .ButtonCount   = 3
973:                 .BackStyle     = 0
974:                 .BorderStyle   = 0
975:                 .SpecialEffect = 0
976:                 .Visible       = .T.
977:                 .Value         = 3
978:             ENDWITH
979:             WITH par_oPag.obj_4c_Opt_opcao.Buttons(1)
980:                 .Caption   = "Sim"
981:                 .Top       = 5
982:                 .Left      = 5
983:                 .Width     = 34
984:                 .Height    = 15
985:                 .BackStyle = 0
986:                 .FontName  = "Tahoma"
987:                 .FontSize  = 8
988:                 .ForeColor = RGB(90, 90, 90)
989:                 .AutoSize  = .T.
990:             ENDWITH
991:             WITH par_oPag.obj_4c_Opt_opcao.Buttons(2)
992:                 .Caption   = "N" + CHR(227) + "o"
993:                 .Top       = 5
994:                 .Left      = 62
995:                 .Width     = 37
996:                 .Height    = 15
997:                 .BackStyle = 0
998:                 .FontName  = "Tahoma"
999:                 .FontSize  = 8
1000:                 .ForeColor = RGB(90, 90, 90)
1001:                 .AutoSize  = .T.
1002:             ENDWITH
1003:             WITH par_oPag.obj_4c_Opt_opcao.Buttons(3)
1004:                 .Caption   = "Ambos"
1005:                 .Top       = 5
1006:                 .Left      = 117
1007:                 .Width     = 50
1008:                 .Height    = 15
1009:                 .BackStyle = 0
1010:                 .FontName  = "Tahoma"
1011:                 .FontSize  = 8
1012:                 .ForeColor = RGB(90, 90, 90)
1013:                 .AutoSize  = .T.
1014:             ENDWITH
1015: 
1016:             *== SECAO FLUXO / TIPO IMPRESSAO (original: Say4 top=308, opt_tipo top=307) =
1017: 
1018:             par_oPag.AddObject("lbl_4c_Fluxo", "Label")
1019:             WITH par_oPag.lbl_4c_Fluxo
1020:                 .Top       = 223
1021:                 .Left      = 70
1022:                 .Width     = 35
1023:                 .Height    = 15
1024:                 .Caption   = "Fluxo :"
1025:                 .FontName  = "Tahoma"
1026:                 .FontSize  = 8
1027:                 .ForeColor = RGB(90, 90, 90)
1028:                 .BackStyle = 0
1029:                 .Visible   = .T.
1030:             ENDWITH
1031: 
1032:             par_oPag.AddObject("obj_4c_Opt_tipo", "OptionGroup")
1033:             WITH par_oPag.obj_4c_Opt_tipo
1034:                 .Top           = 307
1035:                 .Left          = 105
1036:                 .Width         = 166
1037:                 .Height        = 35
1038:                 .ButtonCount   = 4
1039:                 .BackStyle     = 0
1040:                 .BorderStyle   = 0
1041:                 .SpecialEffect = 0
1042:                 .Visible       = .T.
1043:                 .Value         = 1
1044:             ENDWITH
1045:             WITH par_oPag.obj_4c_Opt_tipo.Buttons(1)
1046:                 .Caption   = "Di" + CHR(225) + "rio"
1047:                 .Top       = 1
1048:                 .Left      = 5
1049:                 .Width     = 45
1050:                 .Height    = 15
1051:                 .BackStyle = 0
1052:                 .FontName  = "Tahoma"
1053:                 .FontSize  = 8
1054:                 .ForeColor = RGB(90, 90, 90)
1055:                 .AutoSize  = .T.
1056:             ENDWITH
1057:             WITH par_oPag.obj_4c_Opt_tipo.Buttons(2)
1058:                 .Caption   = "Semanal"
1059:                 .Top       = 1
1060:                 .Left      = 88
1061:                 .Width     = 58
1062:                 .Height    = 15
1063:                 .BackStyle = 0
1064:                 .FontName  = "Tahoma"
1065:                 .FontSize  = 8
1066:                 .ForeColor = RGB(90, 90, 90)
1067:                 .AutoSize  = .T.
1068:             ENDWITH
1069:             WITH par_oPag.obj_4c_Opt_tipo.Buttons(3)
1070:                 .Caption   = "Quinzenal"
1071:                 .Top       = 17
1072:                 .Left      = 5
1073:                 .Width     = 75
1074:                 .Height    = 17
1075:                 .BackStyle = 0
1076:                 .FontName  = "Tahoma"
1077:                 .FontSize  = 8
1078:                 .ForeColor = RGB(90, 90, 90)
1079:             ENDWITH
1080:             WITH par_oPag.obj_4c_Opt_tipo.Buttons(4)
1081:                 .Caption   = "Mensal"
1082:                 .Top       = 18
1083:                 .Left      = 88
1084:                 .Width     = 61
1085:                 .Height    = 17
1086:                 .BackStyle = 0
1087:                 .FontName  = "Tahoma"
1088:                 .FontSize  = 8
1089:                 .ForeColor = RGB(90, 90, 90)
1090:             ENDWITH
1091: 
1092:             *== SECAO LISTAR ATRASOS (original: Say7 top=342, opt_Lista_Atra top=337) =
1093: 
1094:             par_oPag.AddObject("lbl_4c_ListaAtra", "Label")
1095:             WITH par_oPag.lbl_4c_ListaAtra
1096:                 .Top       = 257
1097:                 .Left      = 85
1098:                 .Width     = 75
1099:                 .Height    = 15
1100:                 .Caption   = "Listar Atrasos :"
1101:                 .FontName  = "Tahoma"
1102:                 .FontSize  = 8
1103:                 .ForeColor = RGB(90, 90, 90)
1104:                 .BackStyle = 0
1105:                 .Visible   = .T.
1106:             ENDWITH
1107: 
1108:             par_oPag.AddObject("obj_4c_Opt_lista_atra", "OptionGroup")
1109:             WITH par_oPag.obj_4c_Opt_lista_atra
1110:                 .Top           = 337
1111:                 .Left          = 174
1112:                 .Width         = 109
1113:                 .Height        = 25
1114:                 .ButtonCount   = 2
1115:                 .BackStyle     = 0
1116:                 .BorderStyle   = 0
1117:                 .SpecialEffect = 0
1118:                 .Visible       = .T.
1119:                 .Value         = 1
1120:             ENDWITH
1121:             WITH par_oPag.obj_4c_Opt_lista_atra.Buttons(1)
1122:                 .Caption   = "Sim"
1123:                 .Top       = 5
1124:                 .Left      = 5
1125:                 .Width     = 34
1126:                 .Height    = 15
1127:                 .BackStyle = 0
1128:                 .FontName  = "Tahoma"
1129:                 .FontSize  = 8
1130:                 .ForeColor = RGB(90, 90, 90)
1131:                 .AutoSize  = .T.
1132:             ENDWITH
1133:             WITH par_oPag.obj_4c_Opt_lista_atra.Buttons(2)
1134:                 .Caption   = "N" + CHR(227) + "o"
1135:                 .Top       = 5
1136:                 .Left      = 62
1137:                 .Width     = 37
1138:                 .Height    = 15
1139:                 .BackStyle = 0
1140:                 .FontName  = "Tahoma"
1141:                 .FontSize  = 8
1142:                 .ForeColor = RGB(90, 90, 90)
1143:                 .AutoSize  = .T.
1144:             ENDWITH
1145:             BINDEVENT(par_oPag.obj_4c_Opt_lista_atra, "InteractiveChange", THIS, "OptListaAtraChange")
1146: 
1147:             *== SECAO CONSIDERAR ATRASOS (original: Say5 top=362, Opt_Consid top=357) =
1148: 
1149:             par_oPag.AddObject("lbl_4c_ConsidAtra", "Label")
1150:             WITH par_oPag.lbl_4c_ConsidAtra
1151:                 .Top       = 277
1152:                 .Left      = 54
1153:                 .Width     = 101
1154:                 .Height    = 15
1155:                 .Caption   = "Considerar Atrasos :"
1156:                 .FontName  = "Tahoma"
1157:                 .FontSize  = 8
1158:                 .ForeColor = RGB(90, 90, 90)
1159:                 .BackStyle = 0
1160:                 .Visible   = .T.
1161:             ENDWITH
1162: 
1163:             par_oPag.AddObject("obj_4c_Opt_consid_atra", "OptionGroup")
1164:             WITH par_oPag.obj_4c_Opt_consid_atra
1165:                 .Top           = 357
1166:                 .Left          = 174
1167:                 .Width         = 109
1168:                 .Height        = 25
1169:                 .ButtonCount   = 2
1170:                 .BackStyle     = 0
1171:                 .BorderStyle   = 0
1172:                 .SpecialEffect = 0
1173:                 .Visible       = .T.
1174:                 .Value         = 2
1175:             ENDWITH
1176:             WITH par_oPag.obj_4c_Opt_consid_atra.Buttons(1)
1177:                 .Caption   = "Sim"
1178:                 .Top       = 5
1179:                 .Left      = 5
1180:                 .Width     = 34
1181:                 .Height    = 15
1182:                 .BackStyle = 0
1183:                 .FontName  = "Tahoma"
1184:                 .FontSize  = 8
1185:                 .ForeColor = RGB(90, 90, 90)
1186:                 .AutoSize  = .T.
1187:             ENDWITH
1188:             WITH par_oPag.obj_4c_Opt_consid_atra.Buttons(2)
1189:                 .Caption   = "N" + CHR(227) + "o"
1190:                 .Top       = 5
1191:                 .Left      = 62
1192:                 .Width     = 37
1193:                 .Height    = 15
1194:                 .BackStyle = 0
1195:                 .FontName  = "Tahoma"
1196:                 .FontSize  = 8
1197:                 .ForeColor = RGB(90, 90, 90)
1198:                 .AutoSize  = .T.
1199:             ENDWITH
1200: 
1201:             *== SECAO PREVISTO (original: Say8 top=380, OptPrev top=376) =======
1202: 
1203:             par_oPag.AddObject("lbl_4c_Previsto", "Label")
1204:             WITH par_oPag.lbl_4c_Previsto
1205:                 .Top       = 295
1206:                 .Left      = 60
1207:                 .Width     = 48
1208:                 .Height    = 15
1209:                 .Caption   = "Previsto :"
1210:                 .FontName  = "Tahoma"
1211:                 .FontSize  = 8
1212:                 .ForeColor = RGB(90, 90, 90)
1213:                 .BackStyle = 0
1214:                 .Visible   = .T.
1215:             ENDWITH
1216: 
1217:             par_oPag.AddObject("obj_4c_Opt_prev", "OptionGroup")
1218:             WITH par_oPag.obj_4c_Opt_prev
1219:                 .Top           = 291
1220:                 .Left          = 112
1221:                 .Width         = 172
1222:                 .Height        = 27
1223:                 .ButtonCount   = 3
1224:                 .BackStyle     = 0
1225:                 .BorderStyle   = 0
1226:                 .SpecialEffect = 0
1227:                 .Visible       = .T.
1228:                 .Value         = 3
1229:             ENDWITH
1230:             WITH par_oPag.obj_4c_Opt_prev.Buttons(1)
1231:                 .Caption   = "Sim"
1232:                 .Top       = 5
1233:                 .Left      = 5
1234:                 .Width     = 57
1235:                 .Height    = 17
1236:                 .BackStyle = 0
1237:                 .FontName  = "Tahoma"
1238:                 .FontSize  = 8
1239:                 .ForeColor = RGB(90, 90, 90)
1240:             ENDWITH
1241:             WITH par_oPag.obj_4c_Opt_prev.Buttons(2)
1242:                 .Caption   = "N" + CHR(227) + "o"
1243:                 .Top       = 5
1244:                 .Left      = 56
1245:                 .Width     = 49
1246:                 .Height    = 17
1247:                 .BackStyle = 0
1248:                 .FontName  = "Tahoma"
1249:                 .FontSize  = 8
1250:                 .ForeColor = RGB(90, 90, 90)
1251:             ENDWITH
1252:             WITH par_oPag.obj_4c_Opt_prev.Buttons(3)
1253:                 .Caption   = "Ambos"
1254:                 .Top       = 5
1255:                 .Left      = 107
1256:                 .Width     = 55
1257:                 .Height    = 17
1258:                 .BackStyle = 0
1259:                 .FontName  = "Tahoma"
1260:                 .FontSize  = 8
1261:                 .ForeColor = RGB(90, 90, 90)
1262:             ENDWITH
1263: 
1264:             *== SECAO SITUACAO (RIGHT - original: Say6 top=379, left=309, opt_situa top=374) =
1265: 
1266:             par_oPag.AddObject("lbl_4c_Situa", "Label")
1267:             WITH par_oPag.lbl_4c_Situa
1268:                 .Top       = 294
1269:                 .Left      = 309
1270:                 .Width     = 50
1271:                 .Height    = 15
1272:                 .Caption   = "Situa" + CHR(231) + CHR(227) + "o :"
1273:                 .FontName  = "Tahoma"
1274:                 .FontSize  = 8
1275:                 .ForeColor = RGB(90, 90, 90)
1276:                 .BackStyle = 0
1277:                 .Visible   = .T.
1278:             ENDWITH
1279: 
1280:             par_oPag.AddObject("obj_4c_Opt_situa", "OptionGroup")
1281:             WITH par_oPag.obj_4c_Opt_situa
1282:                 .Top           = 374
1283:                 .Left          = 361
1284:                 .Width         = 225
1285:                 .Height        = 27
1286:                 .ButtonCount   = 3
1287:                 .BackStyle     = 0
1288:                 .BorderStyle   = 0
1289:                 .SpecialEffect = 0
1290:                 .Visible       = .T.
1291:                 .Value         = 2
1292:             ENDWITH
1293:             WITH par_oPag.obj_4c_Opt_situa.Buttons(1)
1294:                 .Caption   = "Baixados"
1295:                 .Top       = 5
1296:                 .Left      = 5
1297:                 .Width     = 61
1298:                 .Height    = 15
1299:                 .BackStyle = 0
1300:                 .FontName  = "Tahoma"
1301:                 .FontSize  = 8
1302:                 .ForeColor = RGB(90, 90, 90)
1303:                 .AutoSize  = .T.
1304:             ENDWITH
1305:             WITH par_oPag.obj_4c_Opt_situa.Buttons(2)
1306:                 .Caption   = "Pendentes"
1307:                 .Top       = 5
1308:                 .Left      = 78
1309:                 .Width     = 67
1310:                 .Height    = 15
1311:                 .BackStyle = 0
1312:                 .FontName  = "Tahoma"
1313:                 .FontSize  = 8
1314:                 .ForeColor = RGB(90, 90, 90)
1315:                 .AutoSize  = .T.
1316:             ENDWITH
1317:             WITH par_oPag.obj_4c_Opt_situa.Buttons(3)
1318:                 .Caption   = "Todos"
1319:                 .Top       = 5
1320:                 .Left      = 162
1321:                 .Width     = 53
1322:                 .Height    = 17
1323:                 .BackStyle = 0
1324:                 .FontName  = "Tahoma"
1325:                 .FontSize  = 8
1326:                 .ForeColor = RGB(90, 90, 90)
1327:             ENDWITH
1328: 
1329:             *== SECAO SALDO (original: Say3 top=539, OptSaldo top=534) =========
1330: 
1331:             par_oPag.AddObject("lbl_4c_Saldo", "Label")
1332:             WITH par_oPag.lbl_4c_Saldo
1333:                 .Top       = 454
1334:                 .Left      = 81
1335:                 .Width     = 35
1336:                 .Height    = 15
1337:                 .Caption   = "Saldo :"
1338:                 .FontName  = "Tahoma"
1339:                 .FontSize  = 8
1340:                 .ForeColor = RGB(90, 90, 90)
1341:                 .BackStyle = 0
1342:                 .Visible   = .T.
1343:             ENDWITH
1344: 
1345:             par_oPag.AddObject("obj_4c_Opt_saldo", "OptionGroup")
1346:             WITH par_oPag.obj_4c_Opt_saldo
1347:                 .Top           = 449
1348:                 .Left          = 122
1349:                 .Width         = 142
1350:                 .Height        = 25
1351:                 .ButtonCount   = 2
1352:                 .BackStyle     = 0
1353:                 .BorderStyle   = 0
1354:                 .SpecialEffect = 0
1355:                 .Visible       = .T.
1356:                 .Value         = 1
1357:             ENDWITH
1358:             WITH par_oPag.obj_4c_Opt_saldo.Buttons(1)
1359:                 .Caption   = "Anterior"
1360:                 .Top       = 5
1361:                 .Left      = 5
1362:                 .Width     = 57
1363:                 .Height    = 15
1364:                 .BackStyle = 0
1365:                 .FontName  = "Tahoma"
1366:                 .FontSize  = 8
1367:                 .ForeColor = RGB(90, 90, 90)
1368:                 .AutoSize  = .T.
1369:             ENDWITH
1370:             WITH par_oPag.obj_4c_Opt_saldo.Buttons(2)
1371:                 .Caption   = "Na Data"
1372:                 .Top       = 5
1373:                 .Left      = 75
1374:                 .Width     = 57
1375:                 .Height    = 15
1376:                 .BackStyle = 0
1377:                 .FontName  = "Tahoma"
1378:                 .FontSize  = 8

*-- Linhas 1994 a 2017:
1994:             ENDIF
1995:             loc_oPag = THIS.pgf_4c_Paginas.Page1
1996:             WITH THIS.this_oRelatorio
1997:                 loc_oPag.txt_4c__dt_inicial.Value        = .this_dDtInicial
1998:                 loc_oPag.txt_4c__dt_final.Value          = .this_dDtFinal
1999:                 loc_oPag.txt_4c__cd_moeda.Value          = .this_cCdMoeda
2000:                 loc_oPag.txt_4c__ds_moeda.Value          = .this_cDsMoeda
2001:                 loc_oPag.txt_4c_cotacao.Value            = .this_nVlCotacao
2002:                 loc_oPag.txt_4c_cd_moedl.Value           = .this_cCdMoedl
2003:                 loc_oPag.txt_4c_ds_moedl.Value           = .this_cDsMoedl
2004:                 loc_oPag.chk_4c_TotalizaContas.Value     = .this_nTotalizaContas
2005:                 loc_oPag.chk_4c_Conciliado.Value         = .this_nConciliado
2006:                 loc_oPag.obj_4c_Opt_opcao.Value          = .this_nOpcao
2007:                 loc_oPag.obj_4c_Opt_tipo.Value           = .this_nTipoImp
2008:                 loc_oPag.obj_4c_Opt_lista_atra.Value     = .this_nListaAtra
2009:                 loc_oPag.obj_4c_Opt_consid_atra.Value    = .this_nConsidAtra
2010:                 loc_oPag.obj_4c_Opt_prev.Value           = .this_nPrev
2011:                 loc_oPag.obj_4c_Opt_situa.Value          = .this_nSitua
2012:                 loc_oPag.obj_4c_Opt_saldo.Value          = .this_nSaldo
2013:             ENDWITH
2014:             loc_oPag.txt_4c__ds_moeda.ReadOnly      = !EMPTY(ALLTRIM(loc_oPag.txt_4c__cd_moeda.Value))
2015:             loc_oPag.txt_4c_ds_moedl.ReadOnly       = !EMPTY(ALLTRIM(loc_oPag.txt_4c_cd_moedl.Value))
2016:             loc_oPag.obj_4c_Opt_consid_atra.Enabled = (loc_oPag.obj_4c_Opt_lista_atra.Value = 1)
2017:         CATCH TO loc_oErro

