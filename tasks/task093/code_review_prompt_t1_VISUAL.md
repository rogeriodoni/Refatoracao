# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_TempMoe' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.
- [NULL-CURSOR] CREATE CURSOR 'cursor_4c_dbRelat' sem SET NULL ON antes. SQL Server retorna NULLs em muitos campos. Sem SET NULL ON, APPEND FROM falha com 'Field XXX does not accept null values'. Adicionar SET NULL ON antes e SET NULL OFF depois.

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

### FORM (C:\4c\projeto\app\forms\relatorios\Formsigreeun.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1604 linhas total):

*-- Linhas 51 a 59:
51:         loc_lSucesso   = .F.
52:         loc_lContinuar = .T.
53:         TRY
54:             THIS.Caption = "Posi" + CHR(231) + CHR(227) + "o de Estoque por Unidade"
55: 
56:             IF TYPE("gc_4c_CaminhoIcones") = "U"
57:                 gc_4c_CaminhoIcones = ""
58:             ENDIF
59:             THIS.Picture = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"

*-- Linhas 70 a 79:
70:                 THIS.ConfigurarBotoes()
71:                 THIS.ConfigurarPageFrame()
72: 
73:                 THIS.cnt_4c_Cabecalho.lbl_4c_Sombra.Caption = THIS.Caption
74:                 THIS.cnt_4c_Cabecalho.lbl_4c_Titulo.Caption = THIS.Caption
75: 
76:                 THIS.ConfigurarPaginaLista()
77: 
78:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(1), "Click", THIS, "BtnVisualizarClick")
79:                 BINDEVENT(THIS.cmg_4c_Botoes.Buttons(2), "Click", THIS, "BtnImprimirClick")

*-- Linhas 100 a 173:
100:     PROTECTED PROCEDURE ConfigurarCabecalho()
101:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
102:         WITH THIS.cnt_4c_Cabecalho
103:             .Top         = 0
104:             .Left        = 0
105:             .Width       = THIS.Width
106:             .Height      = 80
107:             .BackStyle   = 1
108:             .BackColor   = RGB(100, 100, 100)
109:             .BorderWidth = 0
110:             .Visible     = .T.
111: 
112:             .AddObject("lbl_4c_Sombra", "Label")
113:             WITH .lbl_4c_Sombra
114:                 .Top       = 22
115:                 .Left      = 22
116:                 .Width     = THIS.Width
117:                 .Height    = 30
118:                 .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Estoque por Unidade"
119:                 .FontName  = "Tahoma"
120:                 .FontSize  = 14
121:                 .FontBold  = .T.
122:                 .ForeColor = RGB(0, 0, 0)
123:                 .BackStyle = 0
124:                 .Visible   = .T.
125:             ENDWITH
126: 
127:             .AddObject("lbl_4c_Titulo", "Label")
128:             WITH .lbl_4c_Titulo
129:                 .Top       = 20
130:                 .Left      = 20
131:                 .Width     = THIS.Width
132:                 .Height    = 30
133:                 .Caption   = "Posi" + CHR(231) + CHR(227) + "o de Estoque por Unidade"
134:                 .FontName  = "Tahoma"
135:                 .FontSize  = 14
136:                 .FontBold  = .T.
137:                 .ForeColor = RGB(255, 255, 255)
138:                 .BackStyle = 0
139:                 .Visible   = .T.
140:             ENDWITH
141:         ENDWITH
142:     ENDPROC
143: 
144:     *--------------------------------------------------------------------------
145:     * ConfigurarBotoes - CommandGroup: Visualizar / Imprimir / Excel / Encerrar
146:     *   Original btnReport.Left=531, 4 botoes de 60px cada
147:     *--------------------------------------------------------------------------
148:     PROTECTED PROCEDURE ConfigurarBotoes()
149:         THIS.AddObject("cmg_4c_Botoes", "CommandGroup")
150:         WITH THIS.cmg_4c_Botoes
151:             .Top           = 0
152:             .Left          = 529
153:             .Width         = 273
154:             .Height        = 80
155:             .ButtonCount   = 4
156:             .BackStyle     = 0
157:             .BorderStyle   = 0
158:             .BorderColor   = RGB(136, 189, 188)
159:             .SpecialEffect = 1
160:             .Themes        = .F.
161:             .Visible       = .T.
162: 
163:             WITH .Buttons(1)
164:                 .Top             = 5
165:                 .Left            = 5
166:                 .Width           = 65
167:                 .Height          = 70
168:                 .Caption         = "Visualizar"
169:                 .FontBold        = .T.
170:                 .FontItalic      = .T.
171:                 .BackColor       = RGB(255, 255, 255)
172:                 .ForeColor       = RGB(90, 90, 90)
173:                 .Picture         = gc_4c_CaminhoIcones + "relatorio_video_26.jpg"

*-- Linhas 180 a 192:
180:             ENDWITH
181: 
182:             WITH .Buttons(2)
183:                 .Top             = 5
184:                 .Left            = 71
185:                 .Width           = 65
186:                 .Height          = 70
187:                 .Caption         = "Imprimir"
188:                 .FontName        = "Tahoma"
189:                 .FontBold        = .T.
190:                 .FontItalic      = .T.
191:                 .FontSize        = 8
192:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 201 a 213:
201:             ENDWITH
202: 
203:             WITH .Buttons(3)
204:                 .Top             = 5
205:                 .Left            = 137
206:                 .Width           = 65
207:                 .Height          = 70
208:                 .Caption         = "Excel"
209:                 .FontName        = "Tahoma"
210:                 .FontBold        = .T.
211:                 .FontItalic      = .T.
212:                 .FontSize        = 8
213:                 .BackColor       = RGB(255, 255, 255)

*-- Linhas 222 a 234:
222:             ENDWITH
223: 
224:             WITH .Buttons(4)
225:                 .Top             = 5
226:                 .Left            = 203
227:                 .Width           = 65
228:                 .Height          = 70
229:                 .Caption         = "Encerrar"
230:                 .Cancel          = .T.
231:                 .FontName        = "Tahoma"
232:                 .FontBold        = .T.
233:                 .FontItalic      = .T.
234:                 .FontSize        = 8

*-- Linhas 257 a 312:
257: 
258:         loc_oPgf.PageCount = 1
259: 
260:         loc_oPgf.Top    = 85
261:         loc_oPgf.Left   = -1
262:         loc_oPgf.Width  = THIS.Width + 2
263:         loc_oPgf.Height = THIS.Height - 85
264:         loc_oPgf.Tabs   = .F.
265: 
266:         loc_oPgf.Page1.Caption   = "Filtros"
267:         loc_oPgf.Page1.FontName  = "Tahoma"
268:         loc_oPgf.Page1.FontSize  = 8
269:         loc_oPgf.Page1.Picture   = gc_4c_CaminhoIcones + "fundo_cad_1003.jpg"
270:         loc_oPgf.Page1.BackColor = RGB(255, 255, 255)
271:         loc_oPgf.Page1.ForeColor = RGB(90, 90, 90)
272: 
273:         loc_oPgf.Visible    = .T.
274:         loc_oPgf.ActivePage = 1
275:     ENDPROC
276: 
277:     *--------------------------------------------------------------------------
278:     * ConfigurarPaginaLista - Linhas 1-4: Grupo, Conta, Unidade, Data
279:     *   Posicoes relativas ao Page1 (PageFrame.Top=85):
280:     *     Row1 Grupo:    Top=9  (original 95-85=10)
281:     *     Row2 Conta:    Top=34 (original 120-85=35)
282:     *     Row3 Unidade:  Top=59 (original 145-85=60)
283:     *     Row4 Data:     Top=84 (original 170-85=85)
284:     *--------------------------------------------------------------------------
285:     PROTECTED PROCEDURE ConfigurarPaginaLista()
286:         LOCAL loc_oPg
287:         loc_oPg = THIS.pgf_4c_Paginas.Page1
288: 
289:         *-- Linha 1: Grupo de Estoque (SigCdGcr)
290:         loc_oPg.AddObject("lbl_4c_LblGrEst", "Label")
291:         WITH loc_oPg.lbl_4c_LblGrEst
292:             .Top       = 13
293:             .Left      = 225
294:             .Width     = 40
295:             .Height    = 15
296:             .Caption   = "Grupo :"
297:             .FontName  = "Tahoma"
298:             .FontSize  = 8
299:             .ForeColor = RGB(90, 90, 90)
300:             .BackStyle = 0
301:             .Visible   = .T.
302:         ENDWITH
303: 
304:         loc_oPg.AddObject("txt_4c_CdGrestoque", "TextBox")
305:         WITH loc_oPg.txt_4c_CdGrestoque
306:             .Top         = 9
307:             .Left        = 270
308:             .Width       = 80
309:             .Height      = 23
310:             .Value       = ""
311:             .MaxLength   = 10
312:             .Format      = "!"

*-- Linhas 320 a 329:
320: 
321:         loc_oPg.AddObject("txt_4c_DsGrestoque", "TextBox")
322:         WITH loc_oPg.txt_4c_DsGrestoque
323:             .Top         = 9
324:             .Left        = 352
325:             .Width       = 290
326:             .Height      = 23
327:             .Value       = ""
328:             .MaxLength   = 40
329:             .Format      = "!"

*-- Linhas 336 a 361:
336:         ENDWITH
337: 
338:         *-- Linha 2: Estoque/Conta (SigCdCli filtrado por Grupo)
339:         loc_oPg.AddObject("lbl_4c_LblEstoque", "Label")
340:         WITH loc_oPg.lbl_4c_LblEstoque
341:             .Top       = 38
342:             .Left      = 225
343:             .Width     = 40
344:             .Height    = 15
345:             .Caption   = "Conta :"
346:             .FontName  = "Tahoma"
347:             .FontSize  = 8
348:             .ForeColor = RGB(90, 90, 90)
349:             .BackStyle = 0
350:             .Visible   = .T.
351:         ENDWITH
352: 
353:         loc_oPg.AddObject("txt_4c_CdEstoque", "TextBox")
354:         WITH loc_oPg.txt_4c_CdEstoque
355:             .Top         = 34
356:             .Left        = 270
357:             .Width       = 80
358:             .Height      = 23
359:             .Value       = ""
360:             .MaxLength   = 10
361:             .Format      = "!"

*-- Linhas 369 a 378:
369: 
370:         loc_oPg.AddObject("txt_4c_DsEstoque", "TextBox")
371:         WITH loc_oPg.txt_4c_DsEstoque
372:             .Top         = 34
373:             .Left        = 352
374:             .Width       = 290
375:             .Height      = 23
376:             .Value       = ""
377:             .MaxLength   = 40
378:             .Format      = "!"

*-- Linhas 385 a 410:
385:         ENDWITH
386: 
387:         *-- Linha 3: Unidade (SigCdUni)
388:         loc_oPg.AddObject("lbl_4c_LblUnidade", "Label")
389:         WITH loc_oPg.lbl_4c_LblUnidade
390:             .Top       = 63
391:             .Left      = 215
392:             .Width     = 50
393:             .Height    = 15
394:             .Caption   = "Unidade :"
395:             .FontName  = "Tahoma"
396:             .FontSize  = 8
397:             .ForeColor = RGB(90, 90, 90)
398:             .BackStyle = 0
399:             .Visible   = .T.
400:         ENDWITH
401: 
402:         loc_oPg.AddObject("txt_4c_CdUnidade", "TextBox")
403:         WITH loc_oPg.txt_4c_CdUnidade
404:             .Top         = 59
405:             .Left        = 270
406:             .Width       = 31
407:             .Height      = 23
408:             .Value       = ""
409:             .MaxLength   = 3
410:             .Format      = "!"

*-- Linhas 418 a 427:
418: 
419:         loc_oPg.AddObject("txt_4c_DsUnidade", "TextBox")
420:         WITH loc_oPg.txt_4c_DsUnidade
421:             .Top         = 59
422:             .Left        = 303
423:             .Width       = 203
424:             .Height      = 23
425:             .Value       = ""
426:             .MaxLength   = 20
427:             .Format      = "!"

*-- Linhas 434 a 459:
434:         ENDWITH
435: 
436:         *-- Linha 4: Data de referencia
437:         loc_oPg.AddObject("lbl_4c_LblData", "Label")
438:         WITH loc_oPg.lbl_4c_LblData
439:             .Top       = 88
440:             .Left      = 232
441:             .Width     = 30
442:             .Height    = 15
443:             .Caption   = "Data :"
444:             .FontName  = "Tahoma"
445:             .FontSize  = 8
446:             .ForeColor = RGB(90, 90, 90)
447:             .BackStyle = 0
448:             .Visible   = .T.
449:         ENDWITH
450: 
451:         loc_oPg.AddObject("txt_4c_Data", "TextBox")
452:         WITH loc_oPg.txt_4c_Data
453:             .Top         = 84
454:             .Left        = 270
455:             .Width       = 80
456:             .Height      = 23
457:             .Value       = {}
458:             .Format      = "D"
459:             .FontName    = "Tahoma"

*-- Linhas 481 a 506:
481:         loc_oPg = THIS.pgf_4c_Paginas.Page1
482: 
483:         *-- Linha 5: Moeda (SigCdMoe)
484:         loc_oPg.AddObject("lbl_4c_LblMoeda", "Label")
485:         WITH loc_oPg.lbl_4c_LblMoeda
486:             .Top       = 113
487:             .Left      = 222
488:             .Width     = 43
489:             .Height    = 15
490:             .Caption   = "Moeda :"
491:             .FontName  = "Tahoma"
492:             .FontSize  = 8
493:             .ForeColor = RGB(90, 90, 90)
494:             .BackStyle = 0
495:             .Visible   = .T.
496:         ENDWITH
497: 
498:         loc_oPg.AddObject("txt_4c_CdMoeda", "TextBox")
499:         WITH loc_oPg.txt_4c_CdMoeda
500:             .Top         = 109
501:             .Left        = 270
502:             .Width       = 31
503:             .Height      = 23
504:             .Value       = ""
505:             .MaxLength   = 3
506:             .Format      = "!"

*-- Linhas 514 a 523:
514: 
515:         loc_oPg.AddObject("txt_4c_DsMoeda", "TextBox")
516:         WITH loc_oPg.txt_4c_DsMoeda
517:             .Top         = 109
518:             .Left        = 303
519:             .Width       = 115
520:             .Height      = 23
521:             .Value       = ""
522:             .MaxLength   = 15
523:             .Format      = "!"

*-- Linhas 530 a 555:
530:         ENDWITH
531: 
532:         *-- Linha 6: Data da Cotacao
533:         loc_oPg.AddObject("lbl_4c_LblDtCotacao", "Label")
534:         WITH loc_oPg.lbl_4c_LblDtCotacao
535:             .Top       = 138
536:             .Left      = 196
537:             .Width     = 68
538:             .Height    = 15
539:             .Caption   = "Dt. Cota" + CHR(231) + CHR(227) + "o :"
540:             .FontName  = "Tahoma"
541:             .FontSize  = 8
542:             .ForeColor = RGB(90, 90, 90)
543:             .BackStyle = 0
544:             .Visible   = .T.
545:         ENDWITH
546: 
547:         loc_oPg.AddObject("txt_4c_DtCotacao", "TextBox")
548:         WITH loc_oPg.txt_4c_DtCotacao
549:             .Top         = 134
550:             .Left        = 270
551:             .Width       = 80
552:             .Height      = 23
553:             .Value       = {}
554:             .Format      = "D"
555:             .FontName    = "Tahoma"

*-- Linhas 561 a 659:
561:         ENDWITH
562: 
563:         *-- Linha 7: Imprimir Cotacao (1=Sim / 2=Nao) - ButtonCount ANTES de Buttons()
564:         loc_oPg.AddObject("lbl_4c_LblImpCotacao", "Label")
565:         WITH loc_oPg.lbl_4c_LblImpCotacao
566:             .Top       = 162
567:             .Left      = 173
568:             .Width     = 92
569:             .Height    = 15
570:             .Caption   = "Imprime Cota" + CHR(231) + CHR(227) + "o :"
571:             .FontName  = "Tahoma"
572:             .FontSize  = 8
573:             .ForeColor = RGB(90, 90, 90)
574:             .BackStyle = 0
575:             .Visible   = .T.
576:         ENDWITH
577: 
578:         loc_oPg.AddObject("opt_4c_ImpCotacao", "OptionGroup")
579:         loc_oPg.opt_4c_ImpCotacao.ButtonCount = 2
580:         WITH loc_oPg.opt_4c_ImpCotacao
581:             .Top         = 157
582:             .Left        = 264
583:             .Width       = 97
584:             .Height      = 23
585:             .BackStyle   = 0
586:             .BorderStyle = 0
587:             .Visible     = .T.
588:         ENDWITH
589:         WITH loc_oPg.opt_4c_ImpCotacao.Buttons(1)
590:             .Caption   = "Sim"
591:             .Left      = 5
592:             .Top       = 5
593:             .Width     = 34
594:             .Height    = 15
595:             .FontName  = "Tahoma"
596:             .FontSize  = 8
597:             .BackStyle = 0
598:             .AutoSize  = .T.
599:             .ForeColor = RGB(90, 90, 90)
600:         ENDWITH
601:         WITH loc_oPg.opt_4c_ImpCotacao.Buttons(2)
602:             .Caption   = "N" + CHR(227) + "o"
603:             .Left      = 51
604:             .Top       = 5
605:             .FontName  = "Tahoma"
606:             .FontSize  = 8
607:             .BackStyle = 0
608:             .AutoSize  = .T.
609:             .ForeColor = RGB(90, 90, 90)
610:         ENDWITH
611:         loc_oPg.opt_4c_ImpCotacao.Value = 1
612: 
613:         *-- Linha 8: Fator de Venda (1=Sim / 2=Nao) - ButtonCount ANTES de Buttons()
614:         loc_oPg.AddObject("lbl_4c_LblFatorVenda", "Label")
615:         WITH loc_oPg.lbl_4c_LblFatorVenda
616:             .Top       = 187
617:             .Left      = 180
618:             .Width     = 85
619:             .Height    = 15
620:             .Caption   = "Fator de Venda :"
621:             .FontName  = "Tahoma"
622:             .FontSize  = 8
623:             .ForeColor = RGB(90, 90, 90)
624:             .BackStyle = 0
625:             .Visible   = .T.
626:         ENDWITH
627: 
628:         loc_oPg.AddObject("opt_4c_FatorVenda", "OptionGroup")
629:         loc_oPg.opt_4c_FatorVenda.ButtonCount = 2
630:         WITH loc_oPg.opt_4c_FatorVenda
631:             .Top         = 182
632:             .Left        = 264
633:             .Width       = 97
634:             .Height      = 23
635:             .BackStyle   = 0
636:             .BorderStyle = 0
637:             .Visible     = .T.
638:         ENDWITH
639:         WITH loc_oPg.opt_4c_FatorVenda.Buttons(1)
640:             .Caption   = "Sim"
641:             .Left      = 5
642:             .Top       = 5
643:             .Width     = 34
644:             .Height    = 15
645:             .FontName  = "Tahoma"
646:             .FontSize  = 8
647:             .BackStyle = 0
648:             .AutoSize  = .T.
649:             .ForeColor = RGB(90, 90, 90)
650:         ENDWITH
651:         WITH loc_oPg.opt_4c_FatorVenda.Buttons(2)
652:             .Caption   = "N" + CHR(227) + "o"
653:             .Left      = 51
654:             .Top       = 5
655:             .FontName  = "Tahoma"
656:             .FontSize  = 8
657:             .BackStyle = 0
658:             .AutoSize  = .T.
659:             .ForeColor = RGB(90, 90, 90)

*-- Linhas 1504 a 1523:
1504:             ENDIF
1505:             loc_oPg = THIS.pgf_4c_Paginas.Page1
1506:             WITH THIS.this_oRelatorio
1507:                 loc_oPg.txt_4c_CdGrestoque.Value = .this_cCdGrestoque
1508:                 loc_oPg.txt_4c_DsGrestoque.Value = .this_cDsGrestoque
1509:                 loc_oPg.txt_4c_CdEstoque.Value   = .this_cCdEstoque
1510:                 loc_oPg.txt_4c_DsEstoque.Value   = .this_cDsEstoque
1511:                 loc_oPg.txt_4c_CdUnidade.Value   = .this_cGrupo
1512:                 loc_oPg.txt_4c_DsUnidade.Value   = .this_cGrupoDesc
1513:                 loc_oPg.txt_4c_Data.Value        = .this_dData
1514:                 loc_oPg.txt_4c_CdMoeda.Value     = .this_cMoeda
1515:                 loc_oPg.txt_4c_DsMoeda.Value     = .this_cMoedaDesc
1516:                 loc_oPg.txt_4c_DtCotacao.Value   = .this_dDtCotacao
1517:                 loc_oPg.opt_4c_ImpCotacao.Value  = .this_nDadosCotacao
1518:                 loc_oPg.opt_4c_FatorVenda.Value  = .this_nOpcFator
1519:             ENDWITH
1520:             THIS.AtualizarEstadoCamposDescricao()
1521:         CATCH TO loc_oErro
1522:             MsgErro(loc_oErro.Message, "Erro")
1523:         ENDTRY


### BO (C:\4c\projeto\app\classes\sigreeunBO.prg):
*==============================================================================
* SIGREEUNBO.PRG
* Business Object para Relatorio: Posicao de Estoque por Unidade
*
* Formulario original: SIGREEUN.SCX (frmrelatorio)
* Herda de: RelatorioBase
*
* Filtros do relatorio:
*   - Grupo de Estoque (get_cd_grestoque / get_ds_grestoque)
*   - Estoque        (get_cd_estoque   / get_ds_estoque)
*   - Unidade        (get_grupo        / get_grupo_desc)  -> SigCdUni (cunis/dunis)
*   - Data           (get_data)
*   - Moeda          (get_moeda        / get_moeda_desc)  -> SigCdMoe (cmoes/dmoes)
*   - Data Cotacao   (get_dt_cotacao)
*   - Imprimir Cotacao (opt_dados_cotacao, 1=Sim/2=Nao)
*   - Fator de Venda   (Opc_fator,       1=Sim/2=Nao)
*==============================================================================

DEFINE CLASS sigreeunBO AS RelatorioBase

    *-- Filtro: Grupo de Estoque (empgruests - parte grupo)
    this_cCdGrestoque  = ""
    this_cDsGrestoque  = ""

    *-- Filtro: Estoque (empgruests - parte estoque)
    this_cCdEstoque    = ""
    this_cDsEstoque    = ""

    *-- Filtro: Unidade de Produto (SigCdUni: cunis / dunis)
    this_cGrupo        = ""
    this_cGrupoDesc    = ""

    *-- Filtro: Data de referencia da posicao
    this_dData         = {}

    *-- Filtro: Moeda para conversao de valores (SigCdMoe: cmoes / dmoes)
    this_cMoeda        = ""
    this_cMoedaDesc    = ""

    *-- Filtro: Data da cotacao da moeda
    this_dDtCotacao    = {}

    *-- Filtro: Imprimir tabela de cotacoes? (1=Sim / 2=Nao)
    this_nDadosCotacao = 1

    *-- Filtro: Agrupar por fator de venda? (1=Sim / 2=Nao)
    this_nOpcFator     = 1

    *-- Controle interno
    this_cCursorDados  = "cursor_4c_sigreeunDados"

    *--------------------------------------------------------------------------
    * Init - Configura tabela principal e chave primaria
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        THIS.this_cTabela     = "SigCdPro"
        THIS.this_cCampoChave = "cpros"
        RETURN DODEFAULT()
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarFiltros - Verifica campos obrigatorios antes do processamento
    *--------------------------------------------------------------------------
    PROCEDURE ValidarFiltros()
        IF EMPTY(THIS.this_dData)
            THIS.this_cMensagemErro = "Data " + CHR(233) + " obrigat" + CHR(243) + "ria!"
            RETURN .F.
        ENDIF
        IF EMPTY(ALLTRIM(THIS.this_cMoeda))
            THIS.this_cMensagemErro = "Moeda " + CHR(233) + " obrigat" + CHR(243) + "ria!"
            RETURN .F.
        ENDIF
        IF EMPTY(THIS.this_dDtCotacao)
            THIS.this_cMensagemErro = "Data da Cota" + CHR(231) + CHR(227) + "o " + ;
                CHR(233) + " obrigat" + CHR(243) + "ria!"
            RETURN .F.
        ENDIF
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * RegistrarCotacao - Acumula taxa de cambio de uma moeda em cursor_4c_TempMoe
    * Equivalente ao bloco Seek/Append Blank de TempMoe no processamento original
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE RegistrarCotacao(par_cMoeda, par_dData)
        IF EMPTY(ALLTRIM(NVL(par_cMoeda, "")))
            RETURN
        ENDIF
        SELECT cursor_4c_TempMoe
        SET ORDER TO cmoes
        IF !SEEK(par_cMoeda, "cursor_4c_TempMoe", "cmoes")
            APPEND BLANK
            REPLACE cursor_4c_TempMoe.cmoes   WITH par_cMoeda
            REPLACE cursor_4c_TempMoe.cotacao WITH fBuscarCotacao(ALLTRIM(par_cMoeda), par_dData)
        ENDIF
    ENDPROC

    *--------------------------------------------------------------------------
    * PrepararDados - Prepara cursores para o relatorio de posicao de estoque
    *                 por unidade.
    * Equivalente ao metodo 'processamento' do form legado SIGREEUN.
    *
    * Cria cursores:
    *   dbCabecalho  (NomeEmpresa, Titulo, SubTitulo, Cabecalho) - lido pelo FRX
    *   dbRelatorio  (Detalhe)                                    - lido pelo FRX
    * Cursores intermediarios (sufixo Ru=com unidade, All=sem unidade):
    *   cursor_4c_TempMoe    - cotacoes de moeda acumuladas
    *   cursor_4c_dbRelat    - totais por unidade + fator de venda
    *--------------------------------------------------------------------------
    PROCEDURE PrepararDados()
        LOCAL loc_lSucesso, loc_lFalhou
        LOCAL loc_cNomeEmpresa, loc_cTitulo, loc_cSubTitulo, loc_cCabecalho
        LOCAL loc_lcGrupo, loc_lcEstoque, loc_lcUnid
        LOCAL loc_ldData, loc_lcMoeda, loc_lcDescMoeda, loc_ldDtCotacao
        LOCAL loc_lDadosCotacao, loc_lnFator
        LOCAL loc_llPosAtu
        LOCAL loc_lcGrEstIni, loc_lcGrEstFim, loc_lcEstIni, loc_lcEstFim
        LOCAL loc_lcEGEInis, loc_lcEGEFims
        LOCAL loc_cSQL
        LOCAL loc_lcCodPro, loc_lnValor, loc_lnCusto, loc_lnValFat
        LOCAL loc_lcFatVens, loc_lnSqtds
        LOCAL loc_nTotQtds, loc_nTotCusto, loc_nTotVenda
        LOCAL loc_cDetalhe, loc_cTotal
        LOCAL lcData

        loc_lSucesso = .F.
        loc_lFalhou  = .F.

        TRY
            *-- 1. Validar filtros obrigatorios
            IF !THIS.ValidarFiltros()
                loc_lFalhou = .T.
            ENDIF

            *-- 2. Inicializar variaveis e cursores
            IF !loc_lFalhou
                loc_lcGrupo       = ALLTRIM(THIS.this_cCdGrestoque)
                loc_lcEstoque     = ALLTRIM(THIS.this_cCdEstoque)
                loc_lcUnid        = ALLTRIM(THIS.this_cGrupo)
                loc_ldData        = THIS.this_dData
                loc_lcMoeda       = ALLTRIM(THIS.this_cMoeda)
                loc_lcDescMoeda   = ALLTRIM(THIS.this_cMoedaDesc)
                loc_ldDtCotacao   = THIS.this_dDtCotacao
                loc_lDadosCotacao = THIS.this_nDadosCotacao
                loc_lnFator       = THIS.this_nOpcFator
                loc_llPosAtu      = (loc_ldData = DATE())
                lcData            = fDtoSQL(loc_ldData, "23:59:59")

                *-- Buscar nome da empresa
                loc_cNomeEmpresa = ""
                IF SQLEXEC(gnConnHandle, ;
                    "SELECT razas FROM SigCdEmp WHERE cemps = " + ;
                    EscaparSQL(go_4c_Sistema.cCodEmpresa), ;
                    "cursor_4c_sigEmpReeun") > 0
                    SELECT cursor_4c_sigEmpReeun
                    IF !EOF()
                        loc_cNomeEmpresa = ALLTRIM(razas)
                    ENDIF
                    USE IN cursor_4c_sigEmpReeun
                ENDIF

                *-- Montar textos do relatorio
                loc_cTitulo    = "Posi" + CHR(231) + CHR(227) + ;
                    "o de Estoque p/ Unidade de Produto em " + DTOC(loc_ldData)
                loc_cSubTitulo = IIF(EMPTY(loc_lcMoeda), "", "Valores em " + loc_lcDescMoeda)

                loc_cCabecalho = PADC("Cod", 3, "_") + " "
                loc_cCabecalho = loc_cCabecalho + ;
                    PADC("Descri" + CHR(231) + CHR(227) + "o", 20, "_") + " "
                loc_cCabecalho = loc_cCabecalho + PADC("Fator de Venda", 14, "_") + " "
                loc_cCabecalho = loc_cCabecalho + PADC("Qtde.",          10, "_") + " "
                loc_cCabecalho = loc_cCabecalho + PADC("Vl.Custo",       17, "_") + " "
                loc_cCabecalho = loc_cCabecalho + PADC("Vl.Venda",       17, "_")

                *-- Cursor de cabecalho para o FRX (nome EXATO original: dbCabecalho)
                IF USED("dbCabecalho")
                    USE IN dbCabecalho
                ENDIF
                CREATE CURSOR dbCabecalho ;
                    (NomeEmpresa C(80), Titulo C(80), SubTitulo C(80), Cabecalho C(200))
                INSERT INTO dbCabecalho (NomeEmpresa, Titulo, SubTitulo, Cabecalho) ;
                    VALUES (loc_cNomeEmpresa, loc_cTitulo, loc_cSubTitulo, loc_cCabecalho)

                *-- Cursor de detalhes para o FRX (nome EXATO original: dbRelatorio)
                IF USED("dbRelatorio")
                    USE IN dbRelatorio
                ENDIF
                CREATE CURSOR dbRelatorio (Detalhe C(200))

                *-- Cursor de cotacoes acumuladas por moeda
                IF USED("cursor_4c_TempMoe")
                    USE IN cursor_4c_TempMoe
                ENDIF
                CREATE CURSOR cursor_4c_TempMoe (cmoes C(3), cotacao N(14,4))
                INDEX ON cmoes TAG cmoes

                *-- Cursor de totais por unidade + fator de venda
                IF USED("cursor_4c_dbRelat")
                    USE IN cursor_4c_dbRelat
                ENDIF
                CREATE CURSOR cursor_4c_dbRelat ;
                    (cunis C(3), dunis C(20), qtds N(10,3), ;
                     vends N(15,2), custs N(15,2), fatvens C(3))
                INDEX ON cunis + fatvens TAG cunis
                INDEX ON dunis + fatvens TAG descrs

                *-- Montar ranges de empgruests para filtros
                loc_lcGrEstIni = IIF(!EMPTY(loc_lcGrupo), ;
                    PADR(loc_lcGrupo, 10), SPACE(10))
                loc_lcGrEstFim = IIF(!EMPTY(loc_lcGrupo), ;
                    PADR(loc_lcGrupo, 10), REPLICATE(CHR(254), 10))
                loc_lcEstIni   = IIF(!EMPTY(loc_lcEstoque), ;
                    PADR(loc_lcEstoque, 10), SPACE(10))
                loc_lcEstFim   = IIF(!EMPTY(loc_lcEstoque), ;
                    PADR(loc_lcEstoque, 10), REPLICATE(CHR(254), 10))
                loc_lcEGEInis  = go_4c_Sistema.cCodEmpresa + loc_lcGrEstIni + loc_lcEstIni
                loc_lcEGEFims  = go_4c_Sistema.cCodEmpresa + loc_lcGrEstFim + loc_lcEstFim
            ENDIF

            *-- ==================================================================
            *-- CAMINHO 1: Com filtro de unidade (lcUnid preenchido)
            *-- ==================================================================
            IF !loc_lFalhou AND !EMPTY(loc_lcUnid)

                WAIT WINDOW "Aguarde! Selecionando Produtos..." NOWAIT

                loc_cSQL = "SELECT a.cpros, a.cunis, c.dunis, a.linhas, " + ;
                    "b.tpcustos, a.pesoms, a.pvens, a.moevs, " + ;
                    "a.fvendas, a.moepvs, a.custofs, a.moecusfs " + ;
                    "FROM SigCdPro a " + ;
                    "LEFT JOIN SigCdLin b ON b.linhas = a.linhas " + ;
                    "LEFT JOIN SigCdUni c ON c.cunis  = a.cunis " + ;
                    "WHERE a.cunis = " + EscaparSQL(loc_lcUnid)

                IF USED("cursor_4c_SigCdProRu")
                    USE IN cursor_4c_SigCdProRu
                ENDIF
                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_SigCdProRu") < 1
                    THIS.this_cMensagemErro = "Erro ao consultar SigCdPro (unidade " + ;
                        loc_lcUnid + ")"
                    loc_lFalhou = .T.
                ENDIF

                IF !loc_lFalhou
                    SELECT cursor_4c_SigCdProRu
                    GO TOP
                    SCAN WHILE !loc_lFalhou
                        loc_lcCodPro = cursor_4c_SigCdProRu.cpros

                        IF USED("cursor_4c_TmpSaldoRu")
                            USE IN cursor_4c_TmpSaldoRu
                        ENDIF

                        IF loc_llPosAtu
                            *-- Posicao atual: buscar em SigMvEst
                            loc_cSQL = "SELECT sqtds FROM SigMvEst " + ;
                                "WHERE cpros = " + EscaparSQL(ALLTRIM(loc_lcCodPro)) + ;
                                " AND empgruests BETWEEN " + ;
                                EscaparSQL(loc_lcEGEInis) + ;
                                " AND " + EscaparSQL(loc_lcEGEFims)

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSaldoRu") < 1
                                THIS.this_cMensagemErro = "Erro ao consultar SigMvEst"
                                loc_lFalhou = .T.
                                LOOP
                            ENDIF
                            SELECT cursor_4c_TmpSaldoRu
                            GO TOP
                            IF EOF() OR cursor_4c_TmpSaldoRu.sqtds = 0
                                SELECT cursor_4c_SigCdProRu
                                LOOP
                            ENDIF
                            loc_lnSqtds = cursor_4c_TmpSaldoRu.sqtds
                        ELSE
                            *-- Posicao historica: buscar em SigMvHst
                            loc_cSQL = "SELECT TOP 1 SQtds FROM SigMvHst " + ;
                                "WHERE CPros = " + EscaparSQL(ALLTRIM(loc_lcCodPro)) + ;
                                " AND EmpGruEsts BETWEEN " + ;
                                EscaparSQL(loc_lcEGEInis) + ;
                                " AND " + EscaparSQL(loc_lcEGEFims) + ;
                                " AND Datas <= ?lcData ORDER BY CIdChaves DESC"

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSaldoRu") < 1
                                THIS.this_cMensagemErro = "Erro ao consultar SigMvHst (historico)"
                                loc_lFalhou = .T.
                                LOOP
                            ENDIF
                            SELECT cursor_4c_TmpSaldoRu
                            GO TOP
                            IF EOF() OR cursor_4c_TmpSaldoRu.SQtds = 0
                                SELECT cursor_4c_SigCdProRu
                                LOOP
                            ENDIF
                            loc_lnSqtds = cursor_4c_TmpSaldoRu.SQtds
                        ENDIF

                        *-- Calcular valor de venda convertido para moeda selecionada
                        loc_lnValor = cursor_4c_SigCdProRu.pvens * loc_lnSqtds
                        loc_lnValor = loc_lnValor * ;
                            fBuscarCotacao(cursor_4c_SigCdProRu.moevs, loc_ldData) / ;
                            fBuscarCotacao(loc_lcMoeda, loc_ldData)

                        *-- Calcular custo convertido (tipo 2 = pesoms * custofs)
                        loc_lnCusto = cursor_4c_SigCdProRu.custofs
                        IF NVL(cursor_4c_SigCdProRu.tpcustos, "") = "2"
                            loc_lnCusto = cursor_4c_SigCdProRu.pesoms * cursor_4c_SigCdProRu.custofs
                        ENDIF
                        loc_lnCusto = loc_lnCusto * loc_lnSqtds * ;
                            fBuscarCotacao(cursor_4c_SigCdProRu.moecusfs, loc_ldData) / ;
                            fBuscarCotacao(loc_lcMoeda, loc_ldData)

                        *-- Aplicar fator de venda
                        loc_lnValFat = IIF(cursor_4c_SigCdProRu.fvendas = 0, 1, ;
                            cursor_4c_SigCdProRu.fvendas * ;
                            fBuscarCotacao(cursor_4c_SigCdProRu.moepvs, loc_ldData))
                        loc_lnValor = loc_lnValor * loc_lnValFat

                        *-- Registrar cotacoes das moedas utilizadas
                        THIS.RegistrarCotacao(cursor_4c_SigCdProRu.moevs,    loc_ldData)
                        THIS.RegistrarCotacao(THIS.this_cMoeda,               loc_ldData)
                        THIS.RegistrarCotacao(cursor_4c_SigCdProRu.moecusfs, loc_ldData)
                        THIS.RegistrarCotacao(cursor_4c_SigCdProRu.moepvs,   loc_ldData)

                        *-- Fator de agrupamento por moeda do preco de venda
                        IF loc_lnFator = 1
                            loc_lcFatVens = cursor_4c_SigCdProRu.moepvs
                        ELSE
                            loc_lcFatVens = "   "
                        ENDIF

                        *-- Acumular totais por unidade em cursor_4c_dbRelat
                        SELECT cursor_4c_dbRelat
                        SET ORDER TO cunis
                        IF !SEEK(cursor_4c_SigCdProRu.cunis + loc_lcFatVens, ;
                                 "cursor_4c_dbRelat", "cunis")
                            APPEND BLANK
                            REPLACE cursor_4c_dbRelat.cunis   WITH cursor_4c_SigCdProRu.cunis
                            REPLACE cursor_4c_dbRelat.fatvens WITH loc_lcFatVens
                            REPLACE cursor_4c_dbRelat.dunis   WITH NVL(cursor_4c_SigCdProRu.dunis, "")
                        ENDIF
                        REPLACE cursor_4c_dbRelat.qtds  WITH cursor_4c_dbRelat.qtds  + loc_lnSqtds
                        REPLACE cursor_4c_dbRelat.vends WITH cursor_4c_dbRelat.vends + loc_lnValor
                        REPLACE cursor_4c_dbRelat.custs WITH cursor_4c_dbRelat.custs + loc_lnCusto

                        SELECT cursor_4c_SigCdProRu
                    ENDSCAN
                ENDIF

                WAIT CLEAR

                IF USED("cursor_4c_SigCdProRu")
                    USE IN cursor_4c_SigCdProRu
                ENDIF
                IF USED("cursor_4c_TmpSaldoRu")
                    USE IN cursor_4c_TmpSaldoRu
                ENDIF

            *-- ==================================================================
            *-- CAMINHO 2: Sem filtro de unidade (todos os produtos em estoque)
            *-- ==================================================================
            ELSE
                IF !loc_lFalhou

                WAIT WINDOW "Aguarde! Selecionando Produtos..." NOWAIT

                IF USED("cursor_4c_TmpSaldoAll")
                    USE IN cursor_4c_TmpSaldoAll
                ENDIF

                IF loc_llPosAtu
                    *-- Posicao atual: buscar todos os produtos em SigMvEst
                    loc_cSQL = "SELECT cpros, sqtds, cidchaves FROM SigMvEst " + ;
                        "WHERE empgruests BETWEEN " + ;
                        EscaparSQL(loc_lcEGEInis) + " AND " + EscaparSQL(loc_lcEGEFims) + ;
                        " GROUP BY cidchaves, cpros, sqtds"
                ELSE
                    *-- Posicao historica: buscar produtos distintos em SigMvHst
                    loc_cSQL = "SELECT cpros FROM SigMvHst " + ;
                        "WHERE empgruests BETWEEN " + ;
                        EscaparSQL(loc_lcEGEInis) + " AND " + EscaparSQL(loc_lcEGEFims) + ;
                        " GROUP BY cpros"
                ENDIF

                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpSaldoAll") < 1
                    THIS.this_cMensagemErro = "Erro ao selecionar produtos em estoque"
                    loc_lFalhou = .T.
                ENDIF

                IF !loc_lFalhou
                    SELECT cursor_4c_TmpSaldoAll
                    GO TOP
                    IF !EOF()
                        SCAN WHILE !loc_lFalhou
                            loc_lcCodPro = cursor_4c_TmpSaldoAll.cpros

                            *-- Buscar dados do produto em SigCdPro
                            IF USED("cursor_4c_TmpProAll")
                                USE IN cursor_4c_TmpProAll
                            ENDIF
                            loc_cSQL = "SELECT a.cpros, a.cunis, c.dunis, a.linhas, " + ;
                                "b.tpcustos, a.pesoms, a.pvens, a.moevs, " + ;
                                "a.fvendas, a.moepvs, a.custofs, a.moecusfs " + ;
                                "FROM SigCdPro a " + ;
                                "LEFT JOIN SigCdLin b ON b.linhas = a.linhas " + ;
                                "LEFT JOIN SigCdUni c ON c.cunis  = a.cunis " + ;
                                "WHERE a.cpros = " + EscaparSQL(ALLTRIM(loc_lcCodPro))

                            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpProAll") < 1
                                THIS.this_cMensagemErro = "Erro ao buscar produto " + ;
                                    ALLTRIM(loc_lcCodPro)
                                loc_lFalhou = .T.
                                LOOP
                            ENDIF

                            SELECT cursor_4c_TmpProAll
                            GO TOP
                            IF EOF()
                                SELECT cursor_4c_TmpSaldoAll
                                LOOP
                            ENDIF

                            *-- Quantidade: atual de TmpSaldoAll ou historica de SigMvHst
                            IF loc_llPosAtu
                                loc_lnSqtds = cursor_4c_TmpSaldoAll.sqtds
                            ELSE
                                IF USED("cursor_4c_TmpHisAll")
                                    USE IN cursor_4c_TmpHisAll
                                ENDIF
                                loc_cSQL = "SELECT TOP 1 SQtds FROM SigMvHst " + ;
                                    "WHERE CPros = " + EscaparSQL(ALLTRIM(loc_lcCodPro)) + ;
                                    " AND EmpGruEsts BETWEEN " + ;
                                    EscaparSQL(loc_lcEGEInis) + ;
                                    " AND " + EscaparSQL(loc_lcEGEFims) + ;
                                    " AND datas <= ?lcData ORDER BY CIdChaves DESC"

                                IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_TmpHisAll") < 1
                                    THIS.this_cMensagemErro = "Erro ao consultar historico"
                                    loc_lFalhou = .T.
                                    LOOP
                                ENDIF
                                SELECT cursor_4c_TmpHisAll
                                GO TOP
                                IF EOF()
                                    SELECT cursor_4c_TmpSaldoAll
                                    LOOP
                                ENDIF
                                loc_lnSqtds = cursor_4c_TmpHisAll.SQtds
                            ENDIF

                            *-- Calcular valor de venda convertido
                            loc_lnValor = cursor_4c_TmpProAll.pvens * loc_lnSqtds
                            loc_lnValor = loc_lnValor * ;
                                fBuscarCotacao(cursor_4c_TmpProAll.moevs, loc_ldData) / ;
                                fBuscarCotacao(loc_lcMoeda, loc_ldData)

                            *-- Calcular custo convertido
                            loc_lnCusto = cursor_4c_TmpProAll.custofs
                            IF NVL(cursor_4c_TmpProAll.tpcustos, "") = "2"
                                loc_lnCusto = cursor_4c_TmpProAll.pesoms * cursor_4c_TmpProAll.custofs
                            ENDIF
                            loc_lnCusto = loc_lnCusto * loc_lnSqtds * ;
                                fBuscarCotacao(cursor_4c_TmpProAll.moecusfs, loc_ldData) / ;
                                fBuscarCotacao(loc_lcMoeda, loc_ldData)

                            *-- Aplicar fator de venda
                            loc_lnValFat = IIF(cursor_4c_TmpProAll.fvendas = 0, 1, ;
                                cursor_4c_TmpProAll.fvendas * ;
                                fBuscarCotacao(cursor_4c_TmpProAll.moepvs, loc_ldData))
                            loc_lnValor = loc_lnValor * loc_lnValFat

                            *-- Registrar cotacoes das moedas utilizadas
                            THIS.RegistrarCotacao(cursor_4c_TmpProAll.moevs,    loc_ldData)
                            THIS.RegistrarCotacao(THIS.this_cMoeda,              loc_ldData)
                            THIS.RegistrarCotacao(cursor_4c_TmpProAll.moecusfs, loc_ldData)
                            THIS.RegistrarCotacao(cursor_4c_TmpProAll.moepvs,   loc_ldData)

                            *-- Fator de agrupamento
                            IF loc_lnFator = 1
                                loc_lcFatVens = cursor_4c_TmpProAll.moepvs
                            ELSE
                                loc_lcFatVens = "   "
                            ENDIF

                            *-- Acumular em cursor_4c_dbRelat
                            SELECT cursor_4c_dbRelat
                            SET ORDER TO cunis
                            IF !SEEK(cursor_4c_TmpProAll.cunis + loc_lcFatVens, ;
                                     "cursor_4c_dbRelat", "cunis")
                                APPEND BLANK
                                REPLACE cursor_4c_dbRelat.cunis   WITH cursor_4c_TmpProAll.cunis
                                REPLACE cursor_4c_dbRelat.fatvens WITH loc_lcFatVens
                                REPLACE cursor_4c_dbRelat.dunis   WITH NVL(cursor_4c_TmpProAll.dunis, "")
                            ENDIF
                            REPLACE cursor_4c_dbRelat.qtds  WITH cursor_4c_dbRelat.qtds  + loc_lnSqtds
                            REPLACE cursor_4c_dbRelat.vends WITH cursor_4c_dbRelat.vends + loc_lnValor
                            REPLACE cursor_4c_dbRelat.custs WITH cursor_4c_dbRelat.custs + loc_lnCusto

                            SELECT cursor_4c_TmpSaldoAll
                        ENDSCAN
                    ENDIF
                ENDIF

                WAIT CLEAR

                IF USED("cursor_4c_TmpSaldoAll")
                    USE IN cursor_4c_TmpSaldoAll
                ENDIF
                IF USED("cursor_4c_TmpProAll")
                    USE IN cursor_4c_TmpProAll
                ENDIF
                IF USED("cursor_4c_TmpHisAll")
                    USE IN cursor_4c_TmpHisAll
                ENDIF

                ENDIF
            ENDIF

            *-- ==================================================================
            *-- FORMATACAO FINAL: cursor_4c_dbRelat -> dbRelatorio
            *-- ==================================================================
            IF !loc_lFalhou

                loc_nTotQtds  = 0
                loc_nTotCusto = 0
                loc_nTotVenda = 0

                SELECT cursor_4c_dbRelat
                GO TOP
                SCAN
                    loc_cDetalhe = PADR(cursor_4c_dbRelat.cunis, 3) + " "
                    loc_cDetalhe = loc_cDetalhe + PADR(cursor_4c_dbRelat.dunis, 20) + " "
                    loc_cDetalhe = loc_cDetalhe + PADC(cursor_4c_dbRelat.fatvens, 14) + " "
                    loc_cDetalhe = loc_cDetalhe + ;
                        PADL(TRANSFORM(cursor_4c_dbRelat.qtds,  "999999.999"), 10) + " "
                    loc_cDetalhe = loc_cDetalhe + ;
                        PADL(TRANSFORM(cursor_4c_dbRelat.custs, "99,999,999,999.99"), 17) + " "
                    loc_cDetalhe = loc_cDetalhe + ;
                        PADL(TRANSFORM(cursor_4c_dbRelat.vends, "99,999,999,999.99"), 17)
                    INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)

                    loc_nTotQtds  = loc_nTotQtds  + cursor_4c_dbRelat.qtds
                    loc_nTotCusto = loc_nTotCusto + cursor_4c_dbRelat.custs
                    loc_nTotVenda = loc_nTotVenda + cursor_4c_dbRelat.vends
                ENDSCAN

                *-- Linha separadora de totais
                loc_cTotal = SPACE(40) + ;
                    REPLICATE("_", 10) + " " + ;
                    REPLICATE("_", 17) + " " + ;
                    REPLICATE("_", 17) + " "
                INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cTotal)

                *-- Linha de totais gerais
                loc_cTotal = PADL("Total : ", 40)
                loc_cTotal = loc_cTotal + ;
                    PADL(TRANSFORM(loc_nTotQtds,  "999999.999"), 10) + " "
                loc_cTotal = loc_cTotal + ;
                    PADL(TRANSFORM(loc_nTotCusto, "99,999,999,999.99"), 17) + " "
                loc_cTotal = loc_cTotal + ;
                    PADL(TRANSFORM(loc_nTotVenda, "99,999,999,999.99"), 17) + " "
                INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cTotal)

                *-- Secao de cotacoes (se solicitado e com moeda preenchida)
                IF loc_lDadosCotacao = 1 AND !EMPTY(loc_lcMoeda)
                    SELECT cursor_4c_TempMoe
                    GO TOP
                    IF !EOF()
                        INSERT INTO dbRelatorio (Detalhe) VALUES ("")
                        INSERT INTO dbRelatorio (Detalhe) VALUES ("")

                        loc_cDetalhe = "Cota" + CHR(231) + CHR(227) + ;
                            "es de " + DTOC(loc_ldDtCotacao)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)
                        INSERT INTO dbRelatorio (Detalhe) VALUES ("")

                        loc_cDetalhe = PADC("Moeda", 5) + " " + ;
                            PADC("Cota" + CHR(231) + CHR(227) + "o", 14)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)

                        loc_cDetalhe = REPLICATE("_", 5) + " " + REPLICATE("_", 14)
                        INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)

                        SCAN
                            loc_cDetalhe = PADR(cursor_4c_TempMoe.cmoes, 5) + " "
                            loc_cDetalhe = loc_cDetalhe + ;
                                PADL(TRANSFORM(cursor_4c_TempMoe.cotacao, "999,999,999.99"), 14)
                            INSERT INTO dbRelatorio (Detalhe) VALUES (loc_cDetalhe)
                        ENDSCAN
                    ENDIF
                ENDIF

                SELECT dbRelatorio
                loc_lSucesso = .T.
            ENDIF

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = loc_oErro.Message
            MsgErro(loc_oErro.Message, "Erro")
        ENDTRY

        WAIT CLEAR
        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega filtros do relatorio a partir de um cursor.
    *                    Usado quando se deseja restaurar uma configuracao
    *                    salva de filtros (ex: ultima execucao do relatorio).
    *
    * O cursor passado deve conter as colunas: cdgrestoque, dsgrestoque,
    * cdestoque, dsestoque, cunis, dunis, datafiltro, cmoes, dmoes,
    * dtcotacao, dadoscotacao, opcfator.
    *
    * Como relatorios nao tem registro fixo (sao parametrizados), este
    * metodo opera sobre o registro corrente do cursor de filtros salvos.
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso
        loc_lSucesso = .F.

        IF EMPTY(ALLTRIM(NVL(par_cAliasCursor, "")))
            THIS.this_cMensagemErro = "Cursor de origem n" + CHR(227) + ;
                "o informado."
            RETURN .F.
        ENDIF

        IF !USED(par_cAliasCursor)
            THIS.this_cMensagemErro = "Cursor " + ALLTRIM(par_cAliasCursor) + ;
                " n" + CHR(227) + "o est" + CHR(225) + " aberto."
            RETURN .F.
        ENDIF

        TRY
            SELECT (par_cAliasCursor)
            IF EOF()
                THIS.this_cMensagemErro = "Cursor " + ALLTRIM(par_cAliasCursor) + ;
                    " est" + CHR(225) + " vazio."
                loc_lSucesso = .F.
            ENDIF

            *-- Grupo de Estoque (campos cdgrestoque/dsgrestoque opcionais)
            IF TYPE("cdgrestoque") = "C"
                THIS.this_cCdGrestoque = TratarNulo(cdgrestoque, "C")
            ENDIF
            IF TYPE("dsgrestoque") = "C"
                THIS.this_cDsGrestoque = TratarNulo(dsgrestoque, "C")
            ENDIF

            *-- Estoque (cdestoque/dsestoque opcionais)
            IF TYPE("cdestoque") = "C"
                THIS.this_cCdEstoque = TratarNulo(cdestoque, "C")
            ENDIF
            IF TYPE("dsestoque") = "C"
                THIS.this_cDsEstoque = TratarNulo(dsestoque, "C")
            ENDIF

            *-- Unidade (cunis/dunis opcionais)
            IF TYPE("cunis") = "C"
                THIS.this_cGrupo     = TratarNulo(cunis, "C")
            ENDIF
            IF TYPE("dunis") = "C"
                THIS.this_cGrupoDesc = TratarNulo(dunis, "C")
            ENDIF

            *-- Data de referencia
            IF TYPE("datafiltro") = "D"
                THIS.this_dData = NVL(datafiltro, {})
            ENDIF

            *-- Moeda (cmoes/dmoes opcionais)
            IF TYPE("cmoes") = "C"
                THIS.this_cMoeda     = TratarNulo(cmoes, "C")
            ENDIF
            IF TYPE("dmoes") = "C"
                THIS.this_cMoedaDesc = TratarNulo(dmoes, "C")
            ENDIF

            *-- Data da cotacao
            IF TYPE("dtcotacao") = "D"
                THIS.this_dDtCotacao = NVL(dtcotacao, {})
            ENDIF

            *-- Opcoes numericas (1=Sim / 2=Nao)
            IF TYPE("dadoscotacao") = "N"
                THIS.this_nDadosCotacao = NVL(dadoscotacao, 1)
            ENDIF
            IF TYPE("opcfator") = "N"
                THIS.this_nOpcFator = NVL(opcfator, 1)
            ENDIF

            loc_lSucesso = .T.

        CATCH TO loc_oErro
            THIS.this_cMensagemErro = "Erro ao carregar filtros do cursor: " + ;
                loc_oErro.Message
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - BLOQUEADO: relatorio nao persiste dados
    *--------------------------------------------------------------------------
    PROCEDURE Inserir()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o gravam registros."
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - BLOQUEADO: relatorio nao persiste dados
    *--------------------------------------------------------------------------
    PROCEDURE Atualizar()
        THIS.this_cMensagemErro = "Opera" + CHR(231) + CHR(227) + ;
            "o n" + CHR(227) + "o suportada: relat" + CHR(243) + ;
            "rios n" + CHR(227) + "o alteram registros."
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
    * Destroy - Fecha todos os cursores abertos pelo BO
    *--------------------------------------------------------------------------
    PROCEDURE Destroy()
        IF USED("dbCabecalho")
            USE IN dbCabecalho
        ENDIF
        IF USED("dbRelatorio")
            USE IN dbRelatorio
        ENDIF
        IF USED("cursor_4c_TempMoe")
            USE IN cursor_4c_TempMoe
        ENDIF
        IF USED("cursor_4c_dbRelat")
            USE IN cursor_4c_dbRelat
        ENDIF
        IF USED("cursor_4c_sigEmpReeun")
            USE IN cursor_4c_sigEmpReeun
        ENDIF
        IF USED("cursor_4c_SigCdProRu")
            USE IN cursor_4c_SigCdProRu
        ENDIF
        IF USED("cursor_4c_TmpSaldoRu")
            USE IN cursor_4c_TmpSaldoRu
        ENDIF
        IF USED("cursor_4c_TmpSaldoAll")
            USE IN cursor_4c_TmpSaldoAll
        ENDIF
        IF USED("cursor_4c_TmpProAll")
            USE IN cursor_4c_TmpProAll
        ENDIF
        IF USED("cursor_4c_TmpHisAll")
            USE IN cursor_4c_TmpHisAll
        ENDIF
        DODEFAULT()
    ENDPROC

ENDDEFINE

