# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (4)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TprMvCab' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [GRID-HEADER] Header Caption 'Emitente / Destinatário' no codigo migrado NAO foi encontrado no fonte legado. Headers legado encontrados: , Número, Série, Emissão, Op, CFOP, Valor Total, Operação, Emitente / Detinatário. Verificar se o caption foi inventado ou abreviado pelo Claude - deve ser IDENTICO ao legado.
- [LAYOUT-POSITION] Controle 'apaga' (parent: SIGREGNF): Top original=561 vs migrado 'cmd_4c_Apaga' Top=476 (diff=85px, tolerancia=30px)
- [LAYOUT-POSITION] Controle 'SelTudo' (parent: SIGREGNF): Top original=561 vs migrado 'cmd_4c_SelTudo' Top=476 (diff=85px, tolerancia=30px)

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigregnf.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1039 linhas total):

*-- Linhas 47 a 67:
47:             THIS.Height       = 700
48:             THIS.AutoCenter   = .T.
49:             THIS.BorderStyle  = 2
50:             THIS.Caption      = "Emiss" + CHR(227) + "o Global de Nota Fiscal"
51:             THIS.FontName     = "Tahoma"
52:             THIS.FontSize     = 8
53:             THIS.MaxButton    = .F.
54:             THIS.MinButton    = .F.
55: 
56:             *-- Configurar elementos visuais
57:             THIS.ConfigurarCabecalho()
58:             THIS.ConfigurarBotoesRelatorio()
59:             THIS.ConfigurarPageFrame()
60: 
61:             THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
62:             THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
63: 
64:             THIS.Visible  = .T.
65:             loc_lSucesso  = .T.
66:         CATCH TO loc_oErro
67:             MsgErro(loc_oErro.Message, "InicializarForm")

*-- Linhas 77 a 151:
77:     PROTECTED PROCEDURE ConfigurarCabecalho()
78:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
79:         WITH THIS.cnt_4c_Cabecalho
80:             .Top         = 0
81:             .Left        = 0
82:             .Width       = THIS.Width
83:             .Height      = 80
84:             .BackStyle   = 1
85:             .BackColor   = RGB(100,100,100)
86:             .BorderWidth = 0
87:             .Visible     = .T.
88: 
89:             .AddObject("lbl_4c_Sombra", "Label")
90:             WITH .lbl_4c_Sombra
91:                 .Top       = 15
92:                 .Left      = 10
93:                 .Width     = THIS.Width
94:                 .Height    = 40
95:                 .FontName  = "Tahoma"
96:                 .FontSize  = 16
97:                 .FontBold  = .T.
98:                 .ForeColor = RGB(0,0,0)
99:                 .BackStyle = 0
100:                 .Caption   = "Emiss" + CHR(227) + "o Global de Nota Fiscal"
101:                 .Visible   = .T.
102:             ENDWITH
103: 
104:             .AddObject("lbl_4c_Titulo", "Label")
105:             WITH .lbl_4c_Titulo
106:                 .Top       = 18
107:                 .Left      = 10
108:                 .Width     = THIS.Width
109:                 .Height    = 46
110:                 .FontName  = "Tahoma"
111:                 .FontSize  = 16
112:                 .FontBold  = .T.
113:                 .ForeColor = RGB(255,255,255)
114:                 .BackStyle = 0
115:                 .Caption   = "Emiss" + CHR(227) + "o Global de Nota Fiscal"
116:                 .Visible   = .T.
117:             ENDWITH
118:         ENDWITH
119:     ENDPROC
120: 
121:     *--------------------------------------------------------------------------
122:     * ConfigurarBotoesRelatorio - CommandGroup com 4 botoes do relatorio
123:     * Geometria EXATA do frmrelatorio framework.vcx (btnReport original):
124:     *   cmg_4c_Botoes: Left=526 (original btnReport.Left=526), Width=273, Height=80
125:     *   Botoes: Width=65, Height=70, PicturePosition=13 (icone acima da legenda)
126:     *   Lefts: Buttons(1)=5, Buttons(2)=71, Buttons(3)=137, Buttons(4)=203
127:     *--------------------------------------------------------------------------
128:     PROTECTED PROCEDURE ConfigurarBotoesRelatorio()
129:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
130:         WITH THIS.cmg_4c_Botoes
131:             .Top           = 0
132:             .Left          = 526
133:             .Width         = 273
134:             .Height        = 80
135:             .ButtonCount   = 4
136:             .BackStyle     = 0
137:             .BorderStyle   = 0
138:             .BorderColor   = RGB(136,189,188)
139:             .SpecialEffect = 1
140:             .Themes        = .F.
141:             .Visible       = .T.
142: 
143:             WITH .Buttons(1)
144:                 .Caption         = "Visualizar"
145:                 .Top             = 5
146:                 .Left            = 5
147:                 .Width           = 65
148:                 .Height          = 70
149:                 .FontBold        = .T.
150:                 .FontItalic      = .T.
151:                 .BackColor       = RGB(255,255,255)

*-- Linhas 158 a 168:
158:             ENDWITH
159: 
160:             WITH .Buttons(2)
161:                 .Caption         = "Imprimir"
162:                 .Top             = 5
163:                 .Left            = 71
164:                 .Width           = 65
165:                 .Height          = 70
166:                 .FontName        = "Tahoma"
167:                 .FontBold        = .T.
168:                 .FontItalic      = .T.

*-- Linhas 177 a 187:
177:             ENDWITH
178: 
179:             WITH .Buttons(3)
180:                 .Caption         = "DocExcel"
181:                 .Top             = 5
182:                 .Left            = 137
183:                 .Width           = 65
184:                 .Height          = 70
185:                 .FontName        = "Tahoma"
186:                 .FontBold        = .T.
187:                 .FontItalic      = .T.

*-- Linhas 196 a 206:
196:             ENDWITH
197: 
198:             WITH .Buttons(4)
199:                 .Caption         = "Sair"
200:                 .Top             = 5
201:                 .Left            = 203
202:                 .Width           = 65
203:                 .Height          = 70
204:                 .FontName        = "Tahoma"
205:                 .FontBold        = .T.
206:                 .FontItalic      = .T.

*-- Linhas 226 a 241:
226:     *
227:     *   Este metodo cria o container cnt_4c_Corpo que hospedara nas fases
228:     *   seguintes: filtros de Serie/Usuario (Fase 5), grid de notas fiscais
229:     *   selecionaveis com CheckBox (Fase 4), botoes Processar/SelTudo/Apaga
230:     *   (Fase 6) e BINDEVENTs com toda logica de selecao e impressao (Fase 7-8).
231:     *--------------------------------------------------------------------------
232:     PROTECTED PROCEDURE ConfigurarPageFrame()
233:         THIS.AddObject("cnt_4c_Corpo", "Container")
234:         WITH THIS.cnt_4c_Corpo
235:             .Top         = 85
236:             .Left        = 0
237:             .Width       = THIS.Width
238:             .Height      = THIS.Height - 85
239:             .BackStyle   = 0
240:             .BorderWidth = 0
241:             .Visible     = .T.

*-- Linhas 256 a 282:
256:         loc_oCp = THIS.cnt_4c_Corpo
257: 
258:         *-- Label Serie (original: top=173, left=48 -> corpo: top=88)
259:         loc_oCp.AddObject("lbl_4c_Serie", "Label")
260:         WITH loc_oCp.lbl_4c_Serie
261:             .Top       = 88
262:             .Left      = 48
263:             .AutoSize  = .T.
264:             .FontName  = "Tahoma"
265:             .FontSize  = 8
266:             .FontBold  = .T.
267:             .BackStyle = 0
268:             .ForeColor = RGB(90,90,90)
269:             .Caption   = "S" + CHR(233) + "rie : "
270:             .Visible   = .T.
271:         ENDWITH
272: 
273:         *-- TextBox Serie (original: top=169, left=93, w=34, h=23 -> corpo: top=84)
274:         loc_oCp.AddObject("txt_4c_Serie", "TextBox")
275:         WITH loc_oCp.txt_4c_Serie
276:             .Top                = 84
277:             .Left               = 93
278:             .Width              = 34
279:             .Height             = 23
280:             .Value              = SPACE(3)
281:             .FontName           = "Tahoma"
282:             .FontSize           = 8

*-- Linhas 288 a 314:
288:         ENDWITH
289: 
290:         *-- Label Usuario (original: top=173, left=138 -> corpo: top=88)
291:         loc_oCp.AddObject("lbl_4c_Usuars", "Label")
292:         WITH loc_oCp.lbl_4c_Usuars
293:             .Top       = 88
294:             .Left      = 138
295:             .AutoSize  = .T.
296:             .FontName  = "Tahoma"
297:             .FontSize  = 8
298:             .FontBold  = .T.
299:             .BackStyle = 0
300:             .ForeColor = RGB(90,90,90)
301:             .Caption   = "Usu" + CHR(225) + "rio :"
302:             .Visible   = .T.
303:         ENDWITH
304: 
305:         *-- TextBox Usuario (original: top=169, left=198, w=80, h=23 -> corpo: top=84)
306:         loc_oCp.AddObject("txt_4c_Usuars", "TextBox")
307:         WITH loc_oCp.txt_4c_Usuars
308:             .Top                = 84
309:             .Left               = 198
310:             .Width              = 80
311:             .Height             = 23
312:             .Value              = SPACE(10)
313:             .FontName           = "Tahoma"
314:             .FontSize           = 8

*-- Linhas 342 a 356:
342:         loc_oCp = THIS.cnt_4c_Corpo
343: 
344:         *-- Botao Processar (original: top=96, left=696 -> corpo: top=11)
345:         loc_oCp.AddObject("cmd_4c_Processar", "CommandButton")
346:         WITH loc_oCp.cmd_4c_Processar
347:             .Top             = 11
348:             .Left            = 696
349:             .Width           = 75
350:             .Height          = 75
351:             .Caption         = "P\<rocessar"
352:             .FontName        = "Tahoma"
353:             .FontBold        = .T.
354:             .FontItalic      = .T.
355:             .FontSize        = 8
356:             .BackColor       = RGB(255,255,255)

*-- Linhas 366 a 427:
366: 
367:         *-- Grid de NFs (original: top=195, left=30, w=739, h=364 -> corpo: top=110)
368:         THIS.ConfigurarGridNF(loc_oCp)
369: 
370:         *-- Botao SelTudo (original: top=561, left=30, w=45, h=45 -> corpo: top=476)
371:         loc_oCp.AddObject("cmd_4c_SelTudo", "CommandButton")
372:         WITH loc_oCp.cmd_4c_SelTudo
373:             .Top           = 476
374:             .Left          = 30
375:             .Width         = 45
376:             .Height        = 45
377:             .Caption       = ""
378:             .FontName      = "Verdana"
379:             .FontSize      = 8
380:             .SpecialEffect = 0
381:             .ForeColor     = RGB(36,84,155)
382:             .BackColor     = RGB(255,255,255)
383:             .Themes        = .F.
384:             .MousePointer  = 15
385:             .ToolTipText   = "Selecionar Tudo"
386:             .Visible       = .T.
387:         ENDWITH
388: 
389:         *-- Botao Apaga (original: top=561, left=75, w=45, h=45 -> corpo: top=476)
390:         loc_oCp.AddObject("cmd_4c_Apaga", "CommandButton")
391:         WITH loc_oCp.cmd_4c_Apaga
392:             .Top           = 476
393:             .Left          = 75
394:             .Width         = 45
395:             .Height        = 45
396:             .Caption       = ""
397:             .FontName      = "Verdana"
398:             .FontSize      = 8
399:             .SpecialEffect = 0
400:             .ForeColor     = RGB(36,84,155)
401:             .BackColor     = RGB(255,255,255)
402:             .Themes        = .F.
403:             .MousePointer  = 15
404:             .ToolTipText   = "Desmarcar Tudo"
405:             .Visible       = .T.
406:         ENDWITH
407: 
408:         THIS.VincularEventos()
409:     ENDPROC
410: 
411:     *--------------------------------------------------------------------------
412:     * ConfigurarGridNF - Grid de 9 colunas: CheckBox(Flag), Num, Serie, Emis,
413:     *   Op, CFOP, Valor, Operacao, Emitente. Ordem obrigatoria Column1:
414:     *   AddObject -> Caption -> CurrentControl -> ControlSource (Error 1767)
415:     *   ColumnOrder: Column4.ColumnOrder=5, Column5.ColumnOrder=4 (Op exibe
416:     *   antes de Emissao, replicando ColumnOrder do original SIGREGNF.Grade).
417:     *--------------------------------------------------------------------------
418:     PROTECTED PROCEDURE ConfigurarGridNF(par_oCp)
419:         par_oCp.AddObject("grd_4c_Dados", "Grid")
420:         WITH par_oCp.grd_4c_Dados
421:             .Top                = 110
422:             .Left               = 30
423:             .Width              = 739
424:             .Height             = 364
425:             .ColumnCount        = 9
426:             .RecordSource       = "cursor_4c_TmpNFis"
427:             .DeleteMark         = .F.

*-- Linhas 446 a 556:
446:                 .Resizable         = .F.
447:                 .ReadOnly          = .F.
448:                 .Sparse            = .F.
449:                 .AddObject("Check1", "CheckBox")
450:                 WITH .Check1
451:                     .Caption   = ""
452:                     .Value     = 0
453:                     .AutoSize  = .T.
454:                     .BackStyle = 0
455:                     .Visible   = .T.
456:                 ENDWITH
457:                 .CurrentControl    = "Check1"
458:                 .ControlSource     = "cursor_4c_TmpNFis.Flag"
459:                 .Header1.Caption   = ""
460:                 .Header1.Alignment = 2
461:                 .Header1.ForeColor = RGB(90,90,90)
462:             ENDWITH
463: 
464:             WITH .Column2
465:                 .Width             = 45
466:                 .Movable           = .F.
467:                 .Resizable         = .F.
468:                 .ReadOnly          = .T.
469:                 .FontBold          = .T.
470:                 .ControlSource     = "cursor_4c_TmpNFis.NFis"
471:                 .Header1.Caption   = "N" + CHR(250) + "mero"
472:                 .Header1.Alignment = 2
473:                 .Header1.ForeColor = RGB(90,90,90)
474:             ENDWITH
475: 
476:             WITH .Column3
477:                 .Width             = 28
478:                 .Movable           = .F.
479:                 .Resizable         = .F.
480:                 .ReadOnly          = .T.
481:                 .ControlSource     = "cursor_4c_TmpNFis.Series"
482:                 .Header1.Caption   = "S" + CHR(233) + "rie"
483:                 .Header1.Alignment = 2
484:                 .Header1.ForeColor = RGB(90,90,90)
485:             ENDWITH
486: 
487:             WITH .Column4
488:                 .Width             = 62
489:                 .Movable           = .F.
490:                 .Resizable         = .F.
491:                 .ReadOnly          = .T.
492:                 .ColumnOrder       = 5
493:                 .ControlSource     = "cursor_4c_TmpNFis.Emis"
494:                 .Header1.Caption   = "Emiss" + CHR(227) + "o"
495:                 .Header1.Alignment = 2
496:                 .Header1.ForeColor = RGB(90,90,90)
497:             ENDWITH
498: 
499:             WITH .Column5
500:                 .Width             = 18
501:                 .Movable           = .F.
502:                 .Resizable         = .F.
503:                 .ReadOnly          = .T.
504:                 .ColumnOrder       = 4
505:                 .ControlSource     = "cursor_4c_TmpNFis.Operas"
506:                 .Header1.Caption   = "Op"
507:                 .Header1.Alignment = 2
508:                 .Header1.ForeColor = RGB(90,90,90)
509:             ENDWITH
510: 
511:             WITH .Column6
512:                 .Width             = 60
513:                 .Movable           = .F.
514:                 .Resizable         = .F.
515:                 .ReadOnly          = .T.
516:                 .ControlSource     = "cursor_4c_TmpNFis.CFis"
517:                 .Header1.Caption   = "CFOP"
518:                 .Header1.Alignment = 2
519:                 .Header1.ForeColor = RGB(90,90,90)
520:             ENDWITH
521: 
522:             WITH .Column7
523:                 .Width             = 75
524:                 .Movable           = .F.
525:                 .Resizable         = .F.
526:                 .ReadOnly          = .T.
527:                 .InputMask         = "999,999,999.99"
528:                 .ControlSource     = "cursor_4c_TmpNFis.TotNotas"
529:                 .Header1.Caption   = "Valor Total"
530:                 .Header1.Alignment = 2
531:                 .Header1.ForeColor = RGB(90,90,90)
532:             ENDWITH
533: 
534:             WITH .Column8
535:                 .Width             = 150
536:                 .Movable           = .F.
537:                 .Resizable         = .F.
538:                 .ReadOnly          = .T.
539:                 .ControlSource     = "cursor_4c_TmpNFis.Operacao"
540:                 .Header1.Caption   = "Opera" + CHR(231) + CHR(227) + "o"
541:                 .Header1.Alignment = 2
542:                 .Header1.ForeColor = RGB(90,90,90)
543:             ENDWITH
544: 
545:             WITH .Column9
546:                 .Width             = 246
547:                 .Movable           = .F.
548:                 .Resizable         = .F.
549:                 .ReadOnly          = .T.
550:                 .ControlSource     = "cursor_4c_TmpNFis.Conta"
551:                 .Header1.Caption   = "Emitente / Destinat" + CHR(225) + "rio"
552:                 .Header1.Alignment = 2
553:                 .Header1.ForeColor = RGB(90,90,90)
554:             ENDWITH
555:         ENDWITH
556:     ENDPROC

*-- Linhas 583 a 604:
583:         BINDEVENT(THIS.cnt_4c_Corpo.txt_4c_Serie, "GotFocus", THIS, "SerieGotFocus")
584:         BINDEVENT(THIS.cnt_4c_Corpo.txt_4c_Serie, "KeyPress", THIS, "TeclaSerieKeyPress")
585:         BINDEVENT(THIS.cnt_4c_Corpo.txt_4c_Usuars, "GotFocus", THIS, "UsuarsGotFocus")
586:         BINDEVENT(THIS.cnt_4c_Corpo.txt_4c_Usuars, "KeyPress", THIS, "TeclaUsuarsKeyPress")
587:         BINDEVENT(THIS.cnt_4c_Corpo.cmd_4c_Processar, "Click", THIS, "BtnProcessarClick")
588:         BINDEVENT(THIS.cnt_4c_Corpo.cmd_4c_SelTudo, "Click", THIS, "BtnSelTudoClick")
589:         BINDEVENT(THIS.cnt_4c_Corpo.cmd_4c_Apaga, "Click", THIS, "BtnApagaClick")
590:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
591:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")
592:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(3), "Click", THIS, "BtnExcelClick")
593:         BINDEVENT(THIS.cmg_4c_Botoes.Buttons(4), "Click", THIS, "BtnSairClick")
594:     ENDPROC
595: 
596:     *--------------------------------------------------------------------------
597:     * SerieGotFocus - Salva valor inicial da serie para deteccao de mudanca
598:     *--------------------------------------------------------------------------
599:     PROCEDURE SerieGotFocus()
600:         THIS.this_cSerieAnterior = PADR(THIS.cnt_4c_Corpo.txt_4c_Serie.Value, 3)
601:     ENDPROC
602: 
603:     *--------------------------------------------------------------------------
604:     * TeclaSerieKeyPress - F4(115)=lookup direto, ENTER(13)/TAB(9)=validar

*-- Linhas 614 a 622:
614:                 THIS.ValidarSerie(loc_cSerie)
615:             ENDIF
616:             IF PADR(THIS.this_cSerieAnterior, 3) # PADR(THIS.cnt_4c_Corpo.txt_4c_Serie.Value, 3)
617:                 THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
618:             ENDIF
619:         ENDIF
620:     ENDPROC
621: 
622:     *--------------------------------------------------------------------------

*-- Linhas 637 a 645:
637:                 SELECT cursor_4c_BuscaSerie
638:                 IF !EOF()
639:                     THIS.cnt_4c_Corpo.txt_4c_Serie.Value = PADR(ALLTRIM(Series), 3)
640:                     THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
641:                 ENDIF
642:                 USE IN cursor_4c_BuscaSerie
643:             ENDIF
644:             loc_oLookup.Release()
645:         ENDIF

*-- Linhas 690 a 698:
690:                 THIS.ValidarUsuars(loc_cUsuars)
691:             ENDIF
692:             IF PADR(THIS.this_cUsuarsAnterior, 10) # PADR(THIS.cnt_4c_Corpo.txt_4c_Usuars.Value, 10)
693:                 THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
694:             ENDIF
695:         ENDIF
696:     ENDPROC
697: 
698:     *--------------------------------------------------------------------------

*-- Linhas 713 a 721:
713:                 SELECT cursor_4c_BuscaUsuars
714:                 IF !EOF()
715:                     THIS.cnt_4c_Corpo.txt_4c_Usuars.Value = PADR(ALLTRIM(Usuars), 10)
716:                     THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
717:                 ENDIF
718:                 USE IN cursor_4c_BuscaUsuars
719:             ENDIF
720:             loc_oLookup.Release()
721:         ENDIF

*-- Linhas 754 a 762:
754:         ENDIF
755:         THIS.FormParaBO()
756:         IF THIS.this_oBusinessObject.SelecionarDados()
757:             THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .F.
758:         ENDIF
759:         THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
760:         IF USED("cursor_4c_TmpNFis") AND !EOF("cursor_4c_TmpNFis")
761:             THIS.cnt_4c_Corpo.grd_4c_Dados.Column1.Check1.SetFocus()
762:         ENDIF

*-- Linhas 827 a 835:
827:             ENDIF
828:         ENDIF
829:         THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
830:         THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
831:     ENDPROC
832: 
833:     *--------------------------------------------------------------------------
834:     * BtnExcelClick - Exportacao Excel nao disponivel para este relatorio
835:     *--------------------------------------------------------------------------

*-- Linhas 854 a 863:
854:     *--------------------------------------------------------------------------
855:     PROCEDURE BtnIncluirClick()
856:         IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
857:             IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
858:                 THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .T.
859:             ENDIF
860:         ENDIF
861:         THIS.BtnProcessarClick()
862:     ENDPROC
863: 

*-- Linhas 945 a 976:
945:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Usuars", 5)
946:             THIS.cnt_4c_Corpo.txt_4c_Usuars.Enabled = par_lHabilitar
947:         ENDIF
948:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
949:             THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = par_lHabilitar
950:         ENDIF
951:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_SelTudo", 5)
952:             THIS.cnt_4c_Corpo.cmd_4c_SelTudo.Enabled = par_lHabilitar
953:         ENDIF
954:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Apaga", 5)
955:             THIS.cnt_4c_Corpo.cmd_4c_Apaga.Enabled = par_lHabilitar
956:         ENDIF
957:     ENDPROC
958: 
959:     *--------------------------------------------------------------------------
960:     * LimparCampos - Limpa filtros, esvazia grid e reseta botao Processar
961:     *--------------------------------------------------------------------------
962:     PROCEDURE LimparCampos()
963:         IF VARTYPE(THIS.cnt_4c_Corpo) = "O"
964:             IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Serie", 5)
965:                 THIS.cnt_4c_Corpo.txt_4c_Serie.Value  = SPACE(3)
966:             ENDIF
967:             IF PEMSTATUS(THIS.cnt_4c_Corpo, "txt_4c_Usuars", 5)
968:                 THIS.cnt_4c_Corpo.txt_4c_Usuars.Value = SPACE(10)
969:             ENDIF
970:             IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
971:                 THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = .F.
972:             ENDIF
973:         ENDIF
974:         IF VARTYPE(THIS.this_oBusinessObject) = "O"
975:             THIS.this_oBusinessObject.this_cSeries  = ""
976:             THIS.this_oBusinessObject.this_cUsuars  = ""

*-- Linhas 1025 a 1039:
1025:         loc_lTemSerie = !EMPTY(ALLTRIM(THIS.cnt_4c_Corpo.txt_4c_Serie.Value))
1026:         loc_lTemDados = USED("cursor_4c_TmpNFis") AND RECCOUNT("cursor_4c_TmpNFis") > 0
1027: 
1028:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Processar", 5)
1029:             THIS.cnt_4c_Corpo.cmd_4c_Processar.Enabled = loc_lTemSerie
1030:         ENDIF
1031:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_SelTudo", 5)
1032:             THIS.cnt_4c_Corpo.cmd_4c_SelTudo.Enabled = loc_lTemDados
1033:         ENDIF
1034:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "cmd_4c_Apaga", 5)
1035:             THIS.cnt_4c_Corpo.cmd_4c_Apaga.Enabled = loc_lTemDados
1036:         ENDIF
1037:     ENDPROC
1038: 
1039: ENDDEFINE


### BO (C:\4c\projeto\app\classes\sigregnfBO.prg):
*==============================================================================
* SIGREGNFBO.PRG
* Business Object - Emissao Global de Nota Fiscal
*
* Herda de RelatorioBase
* Selecao, verificacao, impressao e visualizacao de NFs
* Form legado: sigregnf.SCX (classe frmrelatorio)
*==============================================================================

DEFINE CLASS sigregnfBO AS RelatorioBase

    *-- Filtros de selecao (preenchidos pelo form antes de SelecionarDados)
    this_cSeries            = ""    && Serie da NF para filtro (C, 3)
    this_cUsuars            = ""    && Usuario para filtro (C, 10 - vazio = todos)

    *-- Estado interno do processamento
    this_lNotasAnt          = .F.   && .T. se existem notas anteriores nao impressas desta serie

    *-- Dados auxiliares carregados no Init
    this_cMascNums          = ""    && Mascara de numeracao de SigCdPam.MascNums

    *-- Nomes dos cursors de trabalho persistentes
    this_cCursorNFis        = "cursor_4c_TmpNFis"     && Dados das NFs selecionadas (usado no grid)
    this_cCursorClientes    = "cursor_4c_Clientes"    && Cache de clientes (Iclis/RClis)
    this_cCursorSeries      = "cursor_4c_SigCdSer"    && Series carregadas no Init (persiste para busca)

    *-- Mensagem de erro para o form exibir
    this_cMensagemErro      = ""

    *--------------------------------------------------------------------------
    * Init - Cria cursors de trabalho e carrega dados auxiliares do banco
    * Equivalente ao Load + Init do legado: fConfigGeral + SigCdPam + SigCdSer
    * Em modo gb_4c_ValidandoUI (.T.) os cursores sao criados vazios sem SQL.
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        LOCAL loc_lSucesso, loc_nResult
        loc_lSucesso = .F.
        TRY
            *-- Cursor principal: equivalente ao TmpNFis do legado
            IF USED(THIS.this_cCursorNFis)
                USE IN (THIS.this_cCursorNFis)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorNFis) ;
                (Flag l, ;
                 Emis d, ;
                 Series c(3), ;
                 Operas c(1), ;
                 CFis c(10), ;
                 NFis c(6), ;
                 TotNotas n(12,2), ;
                 Conta c(40), ;
                 Operacao c(30), ;
                 Emps c(3), ;
                 Dopes c(20), ;
                 Numes n(6))
            INDEX ON NFis TAG NFis

            *-- Cursor auxiliar de clientes: equivalente ao crClientes do legado
            IF USED(THIS.this_cCursorClientes)
                USE IN (THIS.this_cCursorClientes)
            ENDIF
            CREATE CURSOR (THIS.this_cCursorClientes) ;
                (Iclis c(10), RClis c(50))
            INDEX ON Iclis TAG Iclis

            *-- Em modo ValidarUI sem conexao SQL, cursores vazios sao suficientes
            IF TYPE("gb_4c_ValidandoUI") = "L" AND gb_4c_ValidandoUI
                loc_lSucesso = DODEFAULT()
            ELSE
                *-- Carregar mascara de numeracao de SigCdPam
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT MascNums FROM SigCdPam", ;
                    "cursor_4c_SigCdPam")
                IF loc_nResult > 0 AND USED("cursor_4c_SigCdPam")
                    SELECT cursor_4c_SigCdPam
                    IF !EOF()
                        THIS.this_cMascNums = ALLTRIM(NVL(MascNums, ""))
                    ENDIF
                    USE IN cursor_4c_SigCdPam
                ENDIF

                *-- Carregar series para validacao em SelecionarDados (mantido aberto)
                IF USED(THIS.this_cCursorSeries)
                    USE IN (THIS.this_cCursorSeries)
                ENDIF
                loc_nResult = SQLEXEC(gnConnHandle, ;
                    "SELECT EmpCods, TipoNfs FROM SigCdSer", ;
                    THIS.this_cCursorSeries)
                IF loc_nResult > 0 AND USED(THIS.this_cCursorSeries)
                    SELECT (THIS.this_cCursorSeries)
                    INDEX ON EmpCods TAG EmpCods
                    loc_lSucesso = DODEFAULT()
                ELSE
                    THIS.this_cMensagemErro = "Falha ao carregar SigCdSer"
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterMensagemErro - Retorna ultima mensagem de erro do BO
    *--------------------------------------------------------------------------
    PROCEDURE ObterMensagemErro()
        RETURN THIS.this_cMensagemErro
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Hook de RelatorioBase: prepara dados para a tela/relatorio
    * Delega para SelecionarDados que monta filtros (Serie + Usuario opcional)
    * e popula cursor_4c_TmpNFis com as NFs disponiveis para impressao
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso
        loc_lSucesso = .F.
        TRY
            IF EMPTY(ALLTRIM(THIS.this_cSeries))
                THIS.this_cMensagemErro = "S" + CHR(233) + "rie n" + CHR(227) + ;
                                          "o informada"
            ELSE
                loc_lSucesso = THIS.SelecionarDados()
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave primaria do registro corrente em cursor_4c_TmpNFis
    * Formato: Emps + Dopes + Numes (mesmo padrao EmpDopNums do legado)
    *--------------------------------------------------------------------------
    PROCEDURE ObterChavePrimaria()
        LOCAL loc_cChave
        loc_cChave = ""
        IF USED(THIS.this_cCursorNFis)
            SELECT (THIS.this_cCursorNFis)
            IF !EOF() AND !BOF()
                loc_cChave = EVALUATE(THIS.this_cCursorNFis + ".Emps") + ;
                             ALLTRIM(EVALUATE(THIS.this_cCursorNFis + ".Dopes")) + ;
                             STR(EVALUATE(THIS.this_cCursorNFis + ".Numes"), 6)
            ENDIF
        ENDIF
        RETURN loc_cChave
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Registra operacao de emissao/visualizacao de NFs
    * Insere em LogAuditoria via INSERT direto (sem BusinessBase neste fluxo)
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_lSucesso, loc_cSQL, loc_cChave, loc_nResult
        loc_lSucesso = .F.
        TRY
            loc_cChave = THIS.ObterChavePrimaria()
            IF !EMPTY(loc_cChave)
                loc_cSQL = "INSERT INTO LogAuditoria " + ;
                           "(Tabela, ChavePrimaria, Operacao, Usuario, DataHora) VALUES (" + ;
                           EscaparSQL("SigMvNfi") + ", " + ;
                           EscaparSQL(loc_cChave) + ", " + ;
                           EscaparSQL(par_cOperacao) + ", " + ;
                           EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                           "GETDATE())"
                loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL)
                loc_lSucesso = (loc_nResult >= 0)
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * SelecionarDados - Seleciona NFs disponiveis para impressao
    * Filtra por Serie (obrigatorio) e Usuario (opcional)
    * Popula cursor_4c_TmpNFis com NFs nao impressas/canceladas
    *--------------------------------------------------------------------------
    PROCEDURE SelecionarDados()
        LOCAL loc_lSucesso, loc_nResult, loc_nResult2, loc_cSQL, loc_lAbortado
        LOCAL loc_cEmpr, loc_cSeries, loc_cUsuars
        LOCAL loc_lcCli, loc_cDopes, loc_cEmps, loc_cMvSeries, loc_nNumes
        LOCAL loc_dEmis, loc_cOperas, loc_cCFis, loc_cNFis, loc_nTotNotas, loc_cCliFors
        loc_lSucesso = .F.
        TRY
            ZAP IN (THIS.this_cCursorNFis)
            WAIT WINDOW "Aguarde!!! Selecionando Notas Fiscais..." NOWAIT

            loc_cEmpr   = go_4c_Sistema.cCodEmpresa
            loc_cSeries = PADR(THIS.this_cSeries, 3)
            loc_cUsuars = PADR(THIS.this_cUsuars, 10)
            loc_lAbortado = .F.

            *-- Seleciona NFs nao impressas/canceladas da serie indicada
            IF EMPTY(ALLTRIM(THIS.this_cUsuars))
                *-- Sem filtro de usuario: query direta em SigMvNfi
                loc_cSQL = "SELECT a.Emis, a.Series, a.Operas, a.CFis, a.NFis, " + ;
                           "a.TotNotas, a.CliFors, a.Emps, a.Dopes, a.Numes, b.Rclis " + ;
                           "FROM SigMvNfi a " + ;
                           "LEFT JOIN SigCdCli b ON b.Iclis = a.CliFors " + ;
                           "WHERE a.Emps = " + EscaparSQL(loc_cEmpr) + ;
                           " AND a.Series = " + EscaparSQL(loc_cSeries) + ;
                           " AND a.Cancelas = 0 AND a.Impress = 0 " + ;
                           "ORDER BY a.NFis"
            ELSE
                *-- Com filtro de usuario: join via SigMvCab para filtrar por Usuars
                loc_cSQL = "SELECT a.Emis, a.Series, a.Operas, a.CFis, a.NFis, " + ;
                           "a.TotNotas, a.CliFors, a.Emps, a.Dopes, a.Numes, c.Rclis " + ;
                           "FROM SigMvNfi a " + ;
                           "INNER JOIN SigMvCab cab ON cab.EmpDopNums = a.EmpDopNums " + ;
                           "LEFT JOIN SigCdCli c ON c.Iclis = a.CliFors " + ;
                           "WHERE a.Emps = " + EscaparSQL(loc_cEmpr) + ;
                           " AND a.Series = " + EscaparSQL(loc_cSeries) + ;
                           " AND cab.Usuars = " + EscaparSQL(loc_cUsuars) + ;
                           " AND a.Cancelas = 0 AND a.Impress = 0 " + ;
                           "ORDER BY a.NFis"
            ENDIF

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvNfi")
            IF loc_nResult < 1
                THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o ao selecionar NFs"
                loc_lAbortado = .T.
            ENDIF

            IF !loc_lAbortado
                *-- Carrega operacoes para filtragem por tipo
                IF USED("cursor_4c_SigCdOpe")
                    USE IN cursor_4c_SigCdOpe
                ENDIF
                loc_nResult2 = SQLEXEC(gnConnHandle, ;
                    "SELECT Dopes, TipoNfs, Nfiscals, Agrupas FROM SigCdOpe", ;
                    "cursor_4c_SigCdOpe")
                IF loc_nResult2 < 1 OR !USED("cursor_4c_SigCdOpe")
                    THIS.this_cMensagemErro = "Falha na conex" + CHR(227) + "o (SigCdOpe)"
                    loc_lAbortado = .T.
                ELSE
                    SELECT cursor_4c_SigCdOpe
                    INDEX ON Dopes TAG Dopes ADDITIVE
                ENDIF
            ENDIF

            IF !loc_lAbortado
                *-- Scan: aplica filtros de tipo e insere em cursor_4c_TmpNFis
                SELECT cursor_4c_SigMvNfi
                SCAN
                    *-- Captura campos antes de mudar work area
                    loc_lcCli     = ALLTRIM(NVL(cursor_4c_SigMvNfi.Rclis, ""))
                    loc_cDopes    = cursor_4c_SigMvNfi.Dopes
                    loc_cEmps     = cursor_4c_SigMvNfi.Emps
                    loc_cMvSeries = cursor_4c_SigMvNfi.Series
                    loc_nNumes    = cursor_4c_SigMvNfi.Numes
                    loc_dEmis     = cursor_4c_SigMvNfi.Emis
                    loc_cOperas   = cursor_4c_SigMvNfi.Operas
                    loc_cCFis     = cursor_4c_SigMvNfi.CFis
                    loc_cNFis     = cursor_4c_SigMvNfi.NFis
                    loc_nTotNotas = cursor_4c_SigMvNfi.TotNotas
                    loc_cCliFors  = cursor_4c_SigMvNfi.CliFors

                    =SEEK(loc_cDopes, "cursor_4c_SigCdOpe", "Dopes")

                    IF !SEEK(loc_cEmpr + loc_cMvSeries, THIS.this_cCursorSeries, "EmpCods")
                        =SEEK(SPACE(3) + loc_cMvSeries, THIS.this_cCursorSeries, "EmpCods")
                    ENDIF

                    *-- Filtra por tipo de NF (igual ao legado)
                    IF !EOF("cursor_4c_SigCdOpe") AND cursor_4c_SigCdOpe.TipoNfs = 4
                        IF EOF(THIS.this_cCursorSeries) OR ;
                           EVALUATE(THIS.this_cCursorSeries + ".TipoNfs") = 2
                            LOOP
                        ENDIF
                    ELSE
                        IF !EOF("cursor_4c_SigCdOpe") AND cursor_4c_SigCdOpe.TipoNfs = 2
                            LOOP
                        ENDIF
                        IF EOF(THIS.this_cCursorSeries) OR ;
                           EVALUATE(THIS.this_cCursorSeries + ".TipoNfs") = 2
                            LOOP
                        ENDIF
                    ENDIF

                    INSERT INTO (THIS.this_cCursorNFis) ;
                        (Flag, Emis, Series, Operas, CFis, NFis, TotNotas, Conta, ;
                         Operacao, Emps, Dopes, Numes) ;
                        VALUES (.T., ;
                                NVL(loc_dEmis, CTOD("")), ;
                                loc_cMvSeries, ;
                                loc_cOperas, ;
                                loc_cCFis, ;
                                loc_cNFis, ;
                                loc_nTotNotas, ;
                                loc_cCliFors + " " + loc_lcCli, ;
                                loc_cEmps + ALLTRIM(loc_cDopes) + ;
                                    " " + ALLTRIM(fGerMascara(loc_nNumes)), ;
                                loc_cEmps, ;
                                loc_cDopes, ;
                                loc_nNumes)
                ENDSCAN

                IF USED("cursor_4c_SigCdOpe")
                    USE IN cursor_4c_SigCdOpe
                ENDIF
                IF USED("cursor_4c_SigMvNfi")
                    USE IN cursor_4c_SigMvNfi
                ENDIF
                loc_lSucesso = .T.
            ENDIF

            WAIT CLEAR
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            WAIT CLEAR
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * VerificarNf - Verifica se existem NFs anteriores nao impressas da serie
    * Retorna .T. se pode prosseguir, .F. se ha bloqueio por nota anterior
    *--------------------------------------------------------------------------
    PROCEDURE VerificarNf()
        LOCAL loc_lSucesso, loc_nResult, loc_lAbortado
        LOCAL loc_lcEdn, loc_lcSql, loc_lcNota, loc_lcTxt
        LOCAL loc_cVEmps, loc_cVDopes, loc_cVSeries, loc_nVNumes, loc_cVNFis
        loc_lSucesso = .T.
        TRY
            loc_lAbortado = .F.
            SELECT (THIS.this_cCursorNFis)
            SCAN WHILE !loc_lAbortado
                IF !Flag
                    LOOP
                ENDIF
                loc_cVEmps   = Emps
                loc_cVDopes  = Dopes
                loc_cVSeries = Series
                loc_nVNumes  = Numes
                loc_cVNFis   = NFis

                loc_lcEdn = loc_cVEmps + loc_cVDopes + STR(loc_nVNumes, 6)

                loc_lcSql = "SELECT DISTINCT c.Nfis, c.EmpDopNums " + ;
                            "FROM SigMvNfi c, SigCdOpe a " + ;
                            "WHERE c.emps = " + EscaparSQL(loc_cVEmps) + ;
                            " AND c.series = " + EscaparSQL(loc_cVSeries) + ;
                            " AND c.Impress = 0 AND c.cancelas = 0" + ;
                            " AND c.dopes = a.dopes AND a.nfiscals IN (1,2)" + ;
                            " AND a.tiponfs <> 4 AND a.agrupas = 1" + ;
                            " UNION ALL " + ;
                            "SELECT DISTINCT c.Nfis, c.EmpDopNums " + ;
                            "FROM SigMvNfi c, SigCdOpe a, SigCdSer b " + ;
                            "WHERE c.emps = " + EscaparSQL(loc_cVEmps) + ;
                            " AND c.series = " + EscaparSQL(loc_cVSeries) + ;
                            " AND c.Impress = 0 AND c.cancelas = 0" + ;
                            " AND c.series = b.cods AND c.dopes = a.dopes" + ;
                            " AND a.nfiscals IN (1,2) AND a.tiponfs = 4 AND b.impnfs = 1"

                loc_nResult = SQLEXEC(gnConnHandle, loc_lcSql, "cursor_4c_TmpFiscal")
                IF loc_nResult < 0
                    MsgErro("Favor reinicializar o processo.", ;
                            "Falha na Conex" + CHR(227) + "o (TmpFiscal)")
                    loc_lSucesso  = .F.
                    loc_lAbortado = .T.
                ELSE
                    SELECT cursor_4c_TmpFiscal
                    IF RECCOUNT() > 0
                        LOCATE FOR EmpDopNums = loc_lcEdn
                        loc_lcNota = loc_cVNFis

                        SELECT * FROM cursor_4c_TmpFiscal ;
                            WHERE Nfis < loc_lcNota ;
                            INTO CURSOR cursor_4c_Selecao

                        SELECT cursor_4c_Selecao
                        IF RECCOUNT() > 0
                            loc_lcTxt = ""
                            SCAN
                                loc_lcTxt = loc_lcTxt + CHR(13) + ;
                                    "Nota : " + cursor_4c_Selecao.NFis + ;
                                    " - Opera" + CHR(231) + CHR(227) + "o : " + ;
                                    ALLTRIM(SUBSTR(cursor_4c_Selecao.EmpDopNums, 01, 03)) + ;
                                    " / " + ;
                                    ALLTRIM(SUBSTR(cursor_4c_Selecao.EmpDopNums, 04, 20)) + ;
                                    " / " + ;
                                    ALLTRIM(SUBSTR(cursor_4c_Selecao.EmpDopNums, 24, 06)) + ;
                                    SPACE(10)
                            ENDSCAN
                            MsgAviso("Existem Notas Anteriores Desta S" + CHR(233) + ;
                                     "rie Ainda N" + CHR(227) + ;
                                     "o Impressas!!!" + loc_lcTxt, ;
                                     "Aten" + CHR(231) + CHR(227) + "o!!!")
                            loc_lSucesso = .F.
                        ENDIF
                        IF USED("cursor_4c_Selecao")
                            USE IN cursor_4c_Selecao
                        ENDIF
                    ENDIF
                    IF USED("cursor_4c_TmpFiscal")
                        USE IN cursor_4c_TmpFiscal
                    ENDIF
                ENDIF
            ENDSCAN

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            loc_lSucesso = .F.
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Processamento - Verifica sequencia de NFs antes de imprimir
    * Consulta SigCnFn2 e chama VerificarNf para detectar notas anteriores
    * Deve ser chamado pelo form antes de Impressao()
    *--------------------------------------------------------------------------
    PROCEDURE Processamento()
        LOCAL loc_lSucesso, loc_nResult, loc_cSQL, loc_cSeries, loc_cEmps
        loc_lSucesso = .F.

        IF !USED(THIS.this_cCursorNFis) OR EOF(THIS.this_cCursorNFis)
            RETURN .F.
        ENDIF

        TRY
            THIS.this_lNotasAnt = .F.

            loc_cSeries = EVALUATE(THIS.this_cCursorNFis + ".Series")
            loc_cEmps   = EVALUATE(THIS.this_cCursorNFis + ".Emps")

            loc_cSQL = "SELECT Series, Emps, VSeqNota FROM SigCnFn2 " + ;
                       "WHERE Series = " + EscaparSQL(loc_cSeries) + ;
                       " AND Emps = " + EscaparSQL(loc_cEmps) + ;
                       " AND VSeqNota = 1"

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCnFnfT")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (SigCnFnfT)")
            ELSE
                SELECT cursor_4c_SigCnFnfT
                IF !EOF()
                    IF !THIS.VerificarNf()
                        THIS.this_lNotasAnt = .T.
                    ENDIF
                ENDIF

                IF USED("cursor_4c_SigCnFnfT")
                    USE IN cursor_4c_SigCnFnfT
                ENDIF

                SELECT (THIS.this_cCursorNFis)
                GO TOP

                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Impressao - Imprime todas as NFs marcadas (Flag=.T.)
    * Chama SigPrNfs para cada NF marcada e recarrega lista ao final
    *--------------------------------------------------------------------------
    PROCEDURE Impressao()
        LOCAL loc_lSucesso, loc_nResult, loc_nResult2, loc_cSQL, loc_cEdn, loc_lAbortado
        LOCAL loc_lFlag, loc_cEmps, loc_cDopes, loc_nNumes, loc_cNFis
        loc_lSucesso = .F.

        IF THIS.this_lNotasAnt
            RETURN .F.
        ENDIF

        TRY
            IF USED("cursor_4c_TprMvCab")
                USE IN cursor_4c_TprMvCab
            ENDIF
            CREATE CURSOR cursor_4c_TprMvCab ;
                (Emps c(3), Dopes c(20), Numes n(6), ContaOs c(10), ContaDs c(10), ;
                 TpFats c(3), Obses m NULL, ValVars n(12,2))

            GO BOTTOM IN (THIS.this_cCursorNFis)
            GO TOP IN (THIS.this_cCursorNFis)

            loc_lAbortado = .F.
            SELECT (THIS.this_cCursorNFis)
            SCAN WHILE !loc_lAbortado
                loc_lFlag  = Flag
                loc_cEmps  = Emps
                loc_cDopes = Dopes
                loc_nNumes = Numes
                loc_cNFis  = NFis

                IF loc_lFlag
                    WAIT WINDOW "Imprimindo Nota Fiscal n" + CHR(186) + " " + ;
                        loc_cNFis NOWAIT

                    ZAP IN cursor_4c_TprMvCab

                    loc_cEdn = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)

                    *-- Busca cabecalho em SigMvCab
                    loc_cSQL = "SELECT Emps, Dopes, Numes, ContaOs, ContaDs, " + ;
                               "TpFats, Obses, ValVars FROM SigMvCab " + ;
                               "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                    loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCab")
                    IF loc_nResult < 1
                        MsgErro("Favor Reinicializar o Processo!!!", ;
                                "Falha na Conex" + CHR(227) + "o (SigMvCab)")
                        loc_lAbortado = .T.
                    ENDIF

                    IF !loc_lAbortado
                        GO TOP IN cursor_4c_SigMvCab

                        INSERT INTO cursor_4c_TprMvCab ;
                            (Emps, Dopes, Numes, ContaOs, ContaDs, TpFats, Obses, ValVars) ;
                            VALUES (cursor_4c_SigMvCab.Emps, cursor_4c_SigMvCab.Dopes, ;
                                    cursor_4c_SigMvCab.Numes, cursor_4c_SigMvCab.ContaOs, ;
                                    cursor_4c_SigMvCab.ContaDs, cursor_4c_SigMvCab.TpFats, ;
                                    cursor_4c_SigMvCab.Obses, cursor_4c_SigMvCab.ValVars)

                        *-- Busca itens em SigMvNfi
                        loc_cSQL = "SELECT * FROM SigMvNfi " + ;
                                   "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                        loc_nResult2 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvNfi")
                        IF loc_nResult2 < 1
                            MsgErro("Favor Reinicializar o Processo!!!", ;
                                    "Falha na Conex" + CHR(227) + "o (SigMvNfi)")
                            loc_lAbortado = .T.
                        ENDIF
                    ENDIF

                    IF !loc_lAbortado
                        GO TOP IN cursor_4c_SigMvNfi

                        *-- Imprime usando rotina legada SigPrNfs.prg
                        DO SigPrNfs WITH "I", loc_cEmps, loc_cDopes, loc_nNumes

                        SELECT (THIS.this_cCursorNFis)
                        DELETE
                    ENDIF
                ENDIF
            ENDSCAN

            IF !loc_lAbortado
                IF USED("cursor_4c_SigMvCab")
                    USE IN cursor_4c_SigMvCab
                ENDIF
                IF USED("cursor_4c_SigMvNfi")
                    USE IN cursor_4c_SigMvNfi
                ENDIF
                THIS.SelecionarDados()
                WAIT CLEAR
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
            WAIT CLEAR
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Visualizacao - Visualiza a NF do registro corrente do cursor
    * Cursor cursor_4c_TmpNFis deve estar posicionado no registro desejado
    *--------------------------------------------------------------------------
    PROCEDURE Visualizacao()
        LOCAL loc_lSucesso, loc_nResult, loc_nResult2, loc_cSQL, loc_cEdn, loc_lAbortado
        LOCAL loc_cEmps, loc_cDopes, loc_nNumes
        loc_lSucesso = .F.

        IF THIS.this_lNotasAnt
            RETURN .F.
        ENDIF

        SELECT (THIS.this_cCursorNFis)
        IF EOF() OR BOF() OR !Flag
            RETURN .F.
        ENDIF

        TRY
            loc_cEmps  = EVALUATE(THIS.this_cCursorNFis + ".Emps")
            loc_cDopes = EVALUATE(THIS.this_cCursorNFis + ".Dopes")
            loc_nNumes = EVALUATE(THIS.this_cCursorNFis + ".Numes")

            IF USED("cursor_4c_TprMvCab")
                USE IN cursor_4c_TprMvCab
            ENDIF
            CREATE CURSOR cursor_4c_TprMvCab ;
                (Emps c(3), Dopes c(20), Numes n(6), ContaOs c(10), ContaDs c(10), ;
                 TpFats c(3), Obses m NULL, ValVars n(12,2))

            loc_cEdn = loc_cEmps + loc_cDopes + STR(loc_nNumes, 6)
            loc_lAbortado = .F.

            *-- Busca cabecalho em SigMvCab
            loc_cSQL = "SELECT Emps, Dopes, Numes, ContaOs, ContaDs, " + ;
                       "TpFats, Obses, ValVars FROM SigMvCab " + ;
                       "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

            loc_nResult = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvCab")
            IF loc_nResult < 1
                MsgErro("Favor Reinicializar o Processo!!!", ;
                        "Falha na Conex" + CHR(227) + "o (SigMvCab)")
                loc_lAbortado = .T.
            ENDIF

            IF !loc_lAbortado
                GO TOP IN cursor_4c_SigMvCab

                INSERT INTO cursor_4c_TprMvCab ;
                    (Emps, Dopes, Numes, ContaOs, ContaDs, TpFats, Obses, ValVars) ;
                    VALUES (cursor_4c_SigMvCab.Emps, cursor_4c_SigMvCab.Dopes, ;
                            cursor_4c_SigMvCab.Numes, cursor_4c_SigMvCab.ContaOs, ;
                            cursor_4c_SigMvCab.ContaDs, cursor_4c_SigMvCab.TpFats, ;
                            cursor_4c_SigMvCab.Obses, cursor_4c_SigMvCab.ValVars)

                *-- Busca itens em SigMvNfi
                loc_cSQL = "SELECT * FROM SigMvNfi " + ;
                           "WHERE EmpDopNums = " + EscaparSQL(loc_cEdn)

                loc_nResult2 = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigMvNfi")
                IF loc_nResult2 < 1
                    MsgErro("Favor Reinicializar o Processo!!!", ;
                            "Falha na Conex" + CHR(227) + "o (SigMvNfi)")
                    loc_lAbortado = .T.
                ENDIF
            ENDIF

            IF !loc_lAbortado
                GO TOP IN cursor_4c_SigMvNfi

                *-- Visualiza usando rotina legada SigPrNfs.prg
                DO SigPrNfs WITH "V", loc_cEmps, loc_cDopes, loc_nNumes

                IF USED("cursor_4c_SigMvCab")
                    USE IN cursor_4c_SigMvCab
                ENDIF
                IF USED("cursor_4c_SigMvNfi")
                    USE IN cursor_4c_SigMvNfi
                ENDIF

                SELECT (THIS.this_cCursorNFis)
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "Erro")
            THIS.this_cMensagemErro = loc_oErro.Message
        ENDTRY
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * MarcarTodos - Marca todos os registros do cursor TmpNFis (Flag=.T.)
    *--------------------------------------------------------------------------
    PROCEDURE MarcarTodos()
        IF USED(THIS.this_cCursorNFis)
            UPDATE (THIS.this_cCursorNFis) SET Flag = .T.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * DesmarcarTodos - Desmarca todos os registros do cursor TmpNFis (Flag=.F.)
    *--------------------------------------------------------------------------
    PROCEDURE DesmarcarTodos()
        IF USED(THIS.this_cCursorNFis)
            UPDATE (THIS.this_cCursorNFis) SET Flag = .F.
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * Destroy - Libera todos os cursors abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        LOCAL loc_aCursors(10), loc_nI

        loc_aCursors(1)  = THIS.this_cCursorNFis
        loc_aCursors(2)  = THIS.this_cCursorClientes
        loc_aCursors(3)  = THIS.this_cCursorSeries
        loc_aCursors(4)  = "cursor_4c_TmpFiscal"
        loc_aCursors(5)  = "cursor_4c_SigCdOpe"
        loc_aCursors(6)  = "cursor_4c_SigMvNfi"
        loc_aCursors(7)  = "cursor_4c_SigMvCab"
        loc_aCursors(8)  = "cursor_4c_SigCnFnfT"
        loc_aCursors(9)  = "cursor_4c_TprMvCab"
        loc_aCursors(10) = "cursor_4c_Selecao"

        FOR loc_nI = 1 TO 10
            IF USED(loc_aCursors(loc_nI))
                USE IN (loc_aCursors(loc_nI))
            ENDIF
        ENDFOR

        DODEFAULT()
    ENDPROC

ENDDEFINE

