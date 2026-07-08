# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (2)
- [TITULO-NAO-PROPAGADO] Form define Caption mas NAO propaga para lbl_4c_Sombra/lbl_4c_Titulo. O titulo na tela ficara incorreto (ex: 'Cadastro de Testes' ao inves do titulo real). CORRIGIR: No InicializarForm, APOS ConfigurarPageFrame, adicionar: THIS.pgf_4c_Paginas.Page1.cnt_4c_Sombra.lbl_4c_Sombra.Caption = THIS.Caption (e idem para lbl_4c_Titulo)
- [FONTNAME-ERRADO] Linha 725: FontName 'Comic Sans MS' encontrado. Botoes devem usar 'Tahoma'. Substituir TODAS as ocorrencias.

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigReJur.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1673 linhas total):

*-- Linhas 99 a 107:
99:             THIS.LockScreen = .T.
100: 
101:             *-- Caption e fundo do form (PILAR 1 - UX fiel ao SIGREJUR)
102:             THIS.Caption = "Lan" + CHR(231) + "amento de Juros"
103:             THIS.Picture = gc_4c_CaminhoIcones + "new_background.jpg"
104: 
105:             *-- Configura aparencia base do form (OPERACIONAL sem PageFrame)
106:             THIS.ConfigurarPageFrame()
107: 

*-- Linhas 120 a 129:
120:             THIS.LockScreen = .F.
121:             loc_lSucesso = .T.
122: 
123:             IF VARTYPE(THIS.cmd_4c_Confirma) = "O"
124:                 THIS.cmd_4c_Confirma.SetFocus
125:             ENDIF
126: 
127:         CATCH TO loc_oErro
128:             THIS.LockScreen = .F.
129:             MsgErro(loc_oErro.Message + CHR(13) + ;

*-- Linhas 181 a 222:
181: 
182:         THIS.AddObject("cnt_4c_Cabecalho", "Container")
183:         WITH THIS.cnt_4c_Cabecalho
184:             .Top         = 0
185:             .Left        = 0
186:             .Width       = 1100
187:             .Height      = 80
188:             .BackStyle   = 1
189:             .BackColor   = RGB(100, 100, 100)
190:             .BorderWidth = 0
191:             .Visible     = .T.
192: 
193:             .AddObject("lbl_4c_Sombra", "Label")
194:             WITH .lbl_4c_Sombra
195:                 .Top       = 18
196:                 .Left      = 10
197:                 .Width     = THIS.Width
198:                 .Height    = 40
199:                 .Caption   = loc_cCaption
200:                 .FontName  = "Tahoma"
201:                 .FontSize  = 18
202:                 .FontBold  = .T.
203:                 .ForeColor = RGB(0, 0, 0)
204:                 .BackStyle = 0
205:                 .WordWrap  = .T.
206:                 .Alignment = 0
207:                 .AutoSize  = .F.
208:                 .Visible   = .T.
209:             ENDWITH
210: 
211:             .AddObject("lbl_4c_Titulo", "Label")
212:             WITH .lbl_4c_Titulo
213:                 .Top       = 17
214:                 .Left      = 10
215:                 .Width     = THIS.Width
216:                 .Height    = 46
217:                 .Caption   = loc_cCaption
218:                 .FontName  = "Tahoma"
219:                 .FontSize  = 18
220:                 .FontBold  = .T.
221:                 .ForeColor = RGB(255, 255, 255)
222:                 .BackStyle = 0

*-- Linhas 237 a 246:
237:     PROTECTED PROCEDURE ConfigurarGrid()
238:         THIS.AddObject("grd_4c_Dados", "Grid")
239:         WITH THIS.grd_4c_Dados
240:             .Top               = 98
241:             .Left              = 59
242:             .Width             = 884
243:             .Height            = 238
244:             .ColumnCount       = 7
245:             .FontName          = "Tahoma"
246:             .FontSize          = 8

*-- Linhas 261 a 269:
261:                 .Movable           = .F.
262:                 .Resizable         = .F.
263:                 .ControlSource     = "TTOD(crTmpJuros.Datas)"
264:                 .Header1.Caption   = "Vencimento"
265:                 .Header1.FontName  = "Tahoma"
266:                 .Header1.FontSize  = 8
267:                 .Header1.Alignment = 2
268:                 .Header1.ForeColor = RGB(0, 0, 0)
269:                 .Text1.BorderStyle = 1

*-- Linhas 279 a 287:
279:                 .Movable           = .F.
280:                 .Resizable         = .F.
281:                 .ControlSource     = "crTmpJuros.Hists"
282:                 .Header1.Caption   = "Hist" + CHR(243) + "rico"
283:                 .Header1.FontName  = "Tahoma"
284:                 .Header1.FontSize  = 8
285:                 .Header1.Alignment = 2
286:                 .Header1.ForeColor = RGB(0, 0, 0)
287:                 .Text1.Margin      = 0

*-- Linhas 295 a 303:
295:                 .Movable           = .F.
296:                 .Resizable         = .F.
297:                 .ControlSource     = "crTmpJuros.Valors"
298:                 .Header1.Caption   = "Valor"
299:                 .Header1.FontName  = "Tahoma"
300:                 .Header1.FontSize  = 8
301:                 .Header1.Alignment = 2
302:                 .Header1.ForeColor = RGB(0, 0, 0)
303:                 .Text1.BorderStyle = 0

*-- Linhas 314 a 322:
314:                 .Movable           = .F.
315:                 .Resizable         = .F.
316:                 .ControlSource     = "crTmpJuros.Moedas"
317:                 .Header1.Caption   = "Moe"
318:                 .Header1.FontName  = "Tahoma"
319:                 .Header1.FontSize  = 8
320:                 .Header1.Alignment = 2
321:                 .Header1.ForeColor = RGB(0, 0, 0)
322:                 .Text1.BorderStyle = 0

*-- Linhas 333 a 341:
333:                 .Movable           = .F.
334:                 .Resizable         = .F.
335:                 .ControlSource     = "crTmpJuros.TaxJuros"
336:                 .Header1.Caption   = "Taxa Juros"
337:                 .Header1.FontName  = "Tahoma"
338:                 .Header1.FontSize  = 8
339:                 .Header1.Alignment = 2
340:                 .Header1.ForeColor = RGB(0, 0, 0)
341:                 .Text1.BorderStyle = 0

*-- Linhas 352 a 360:
352:                 .Movable           = .F.
353:                 .Resizable         = .F.
354:                 .ControlSource     = "crTmpJuros.Dias"
355:                 .Header1.Caption   = "Dias"
356:                 .Header1.FontName  = "Tahoma"
357:                 .Header1.FontSize  = 8
358:                 .Header1.Alignment = 2
359:                 .Header1.ForeColor = RGB(0, 0, 0)
360:                 .Text1.BorderStyle = 0

*-- Linhas 371 a 379:
371:                 .Movable           = .F.
372:                 .Resizable         = .F.
373:                 .ControlSource     = "crTmpJuros.Juros"
374:                 .Header1.Caption   = "Juros"
375:                 .Header1.FontName  = "Tahoma"
376:                 .Header1.FontSize  = 8
377:                 .Header1.Alignment = 2
378:                 .Header1.ForeColor = RGB(0, 0, 0)
379:                 .Text1.BorderStyle = 0

*-- Linhas 396 a 457:
396:         *-- Shape2: borda visual da area debito (Top=346, Left=59, W=438, H=86)
397:         THIS.AddObject("shp_4c_Shape2", "Shape")
398:         WITH THIS.shp_4c_Shape2
399:             .Top         = 346
400:             .Left        = 59
401:             .Width       = 438
402:             .Height      = 86
403:             .BackStyle   = 0
404:             .BorderColor = RGB(90, 90, 90)
405:             .Curvature   = 0
406:             .Visible     = .T.
407:         ENDWITH
408: 
409:         *-- Say3: [D/C] :
410:         THIS.AddObject("lbl_4c_Say3", "Label")
411:         WITH THIS.lbl_4c_Say3
412:             .Top       = 355
413:             .Left      = 78
414:             .Caption   = "[D/C] :"
415:             .FontName  = "Tahoma"
416:             .FontSize  = 8
417:             .ForeColor = RGB(90, 90, 90)
418:             .BackStyle = 0
419:             .Visible   = .T.
420:         ENDWITH
421: 
422:         *-- Say4: Grupo :
423:         THIS.AddObject("lbl_4c_Say4", "Label")
424:         WITH THIS.lbl_4c_Say4
425:             .Top       = 380
426:             .Left      = 75
427:             .Caption   = "Grupo :"
428:             .FontName  = "Tahoma"
429:             .FontSize  = 8
430:             .ForeColor = RGB(90, 90, 90)
431:             .BackStyle = 0
432:             .Visible   = .T.
433:         ENDWITH
434: 
435:         *-- Say5: Conta :
436:         THIS.AddObject("lbl_4c_Say5", "Label")
437:         WITH THIS.lbl_4c_Say5
438:             .Top       = 405
439:             .Left      = 75
440:             .Caption   = "Conta :"
441:             .FontName  = "Tahoma"
442:             .FontSize  = 8
443:             .ForeColor = RGB(90, 90, 90)
444:             .BackStyle = 0
445:             .Visible   = .T.
446:         ENDWITH
447: 
448:         *-- Get_OPER: indicador D/C debito (readonly - sempre "C")
449:         THIS.AddObject("txt_4c_OPER", "TextBox")
450:         WITH THIS.txt_4c_OPER
451:             .Top           = 352
452:             .Left          = 115
453:             .Width         = 15
454:             .Height        = 23
455:             .Value         = ""
456:             .ReadOnly      = .T.
457:             .Format        = "K"

*-- Linhas 467 a 476:
467:         *-- Get_grupo: codigo do grupo debito
468:         THIS.AddObject("txt_4c_Grupo", "TextBox")
469:         WITH THIS.txt_4c_Grupo
470:             .Top           = 377
471:             .Left          = 115
472:             .Width         = 80
473:             .Height        = 23
474:             .Value         = ""
475:             .Enabled       = THIS.this_lAlteraContas
476:             .SpecialEffect = 1

*-- Linhas 484 a 493:
484:         *-- Get_dgrupo: descricao do grupo debito
485:         THIS.AddObject("txt_4c_Dgrupo", "TextBox")
486:         WITH THIS.txt_4c_Dgrupo
487:             .Top           = 377
488:             .Left          = 198
489:             .Width         = 290
490:             .Height        = 23
491:             .Value         = ""
492:             .Enabled       = THIS.this_lAlteraContas
493:             .SpecialEffect = 1

*-- Linhas 501 a 510:
501:         *-- Get_conta: codigo da conta debito
502:         THIS.AddObject("txt_4c_Conta", "TextBox")
503:         WITH THIS.txt_4c_Conta
504:             .Top           = 402
505:             .Left          = 115
506:             .Width         = 80
507:             .Height        = 23
508:             .Value         = ""
509:             .Enabled       = THIS.this_lAlteraContas
510:             .SpecialEffect = 1

*-- Linhas 518 a 527:
518:         *-- Get_dconta: descricao da conta debito
519:         THIS.AddObject("txt_4c_Dconta", "TextBox")
520:         WITH THIS.txt_4c_Dconta
521:             .Top           = 402
522:             .Left          = 198
523:             .Width         = 290
524:             .Height        = 23
525:             .MaxLength     = 50
526:             .Value         = ""
527:             .Enabled       = THIS.this_lAlteraContas

*-- Linhas 542 a 616:
542:         *-- Shape3: borda visual da area credito (Top=345, Left=505, W=438, H=86)
543:         THIS.AddObject("shp_4c_Shape3", "Shape")
544:         WITH THIS.shp_4c_Shape3
545:             .Top         = 345
546:             .Left        = 505
547:             .Width       = 438
548:             .Height      = 86
549:             .BackStyle   = 0
550:             .BorderColor = RGB(90, 90, 90)
551:             .Curvature   = 0
552:             .Visible     = .T.
553:         ENDWITH
554: 
555:         *-- Say11: [D/C] :
556:         THIS.AddObject("lbl_4c_Say11", "Label")
557:         WITH THIS.lbl_4c_Say11
558:             .Top       = 353
559:             .Left      = 524
560:             .Caption   = "[D/C] :"
561:             .FontName  = "Tahoma"
562:             .FontSize  = 8
563:             .ForeColor = RGB(90, 90, 90)
564:             .BackStyle = 0
565:             .Visible   = .T.
566:         ENDWITH
567: 
568:         *-- Say12: Grupo :
569:         THIS.AddObject("lbl_4c_Say12", "Label")
570:         WITH THIS.lbl_4c_Say12
571:             .Top       = 378
572:             .Left      = 521
573:             .Caption   = "Grupo :"
574:             .FontName  = "Tahoma"
575:             .FontSize  = 8
576:             .ForeColor = RGB(90, 90, 90)
577:             .BackStyle = 0
578:             .Visible   = .T.
579:         ENDWITH
580: 
581:         *-- Say13: Conta :
582:         THIS.AddObject("lbl_4c_Say13", "Label")
583:         WITH THIS.lbl_4c_Say13
584:             .Top       = 403
585:             .Left      = 521
586:             .Caption   = "Conta :"
587:             .FontName  = "Tahoma"
588:             .FontSize  = 8
589:             .ForeColor = RGB(90, 90, 90)
590:             .BackStyle = 0
591:             .Visible   = .T.
592:         ENDWITH
593: 
594:         *-- Say15: Cotacao :
595:         THIS.AddObject("lbl_4c_Say15", "Label")
596:         WITH THIS.lbl_4c_Say15
597:             .Top       = 398
598:             .Left      = 661
599:             .Caption   = "Cota" + CHR(231) + CHR(227) + "o : "
600:             .FontName  = "Tahoma"
601:             .FontSize  = 8
602:             .ForeColor = RGB(90, 90, 90)
603:             .BackStyle = 0
604:             .Visible   = .T.
605:         ENDWITH
606: 
607:         *-- Get_SOPER: indicador D/C credito (readonly - sempre "D")
608:         THIS.AddObject("txt_4c_SOPER", "TextBox")
609:         WITH THIS.txt_4c_SOPER
610:             .Top           = 350
611:             .Left          = 561
612:             .Width         = 15
613:             .Height        = 23
614:             .Value         = ""
615:             .ReadOnly      = .T.
616:             .Format        = "K"

*-- Linhas 625 a 634:
625:         *-- Get_SGRUPO: codigo do grupo credito
626:         THIS.AddObject("txt_4c_SGRUPO", "TextBox")
627:         WITH THIS.txt_4c_SGRUPO
628:             .Top           = 375
629:             .Left          = 561
630:             .Width         = 80
631:             .Height        = 23
632:             .Value         = ""
633:             .Enabled       = THIS.this_lAlteraContas
634:             .SpecialEffect = 1

*-- Linhas 642 a 651:
642:         *-- Get_sdgrupo: descricao do grupo credito
643:         THIS.AddObject("txt_4c_Sdgrupo", "TextBox")
644:         WITH THIS.txt_4c_Sdgrupo
645:             .Top           = 375
646:             .Left          = 644
647:             .Width         = 290
648:             .Height        = 23
649:             .Value         = ""
650:             .Enabled       = THIS.this_lAlteraContas
651:             .SpecialEffect = 1

*-- Linhas 659 a 668:
659:         *-- Get_SCONTA: codigo da conta credito
660:         THIS.AddObject("txt_4c_SCONTA", "TextBox")
661:         WITH THIS.txt_4c_SCONTA
662:             .Top           = 400
663:             .Left          = 561
664:             .Width         = 80
665:             .Height        = 23
666:             .Value         = ""
667:             .Enabled       = THIS.this_lAlteraContas
668:             .SpecialEffect = 1

*-- Linhas 676 a 685:
676:         *-- Get_SDCONTA: descricao da conta credito
677:         THIS.AddObject("txt_4c_SDCONTA", "TextBox")
678:         WITH THIS.txt_4c_SDCONTA
679:             .Top           = 400
680:             .Left          = 644
681:             .Width         = 290
682:             .Height        = 23
683:             .MaxLength     = 50
684:             .Value         = ""
685:             .Enabled       = THIS.this_lAlteraContas

*-- Linhas 701 a 731:
701:         *-- Shape1: elemento visual ao redor do botao (sem borda visivel)
702:         THIS.AddObject("shp_4c_Shape1", "Shape")
703:         WITH THIS.shp_4c_Shape1
704:             .Top         = 10
705:             .Left        = 905
706:             .Width       = 90
707:             .Height      = 110
708:             .BackStyle   = 0
709:             .BorderStyle = 0
710:             .BorderColor = RGB(206, 247, 251)
711:             .Curvature   = 0
712:             .Visible     = .T.
713:         ENDWITH
714: 
715:         *-- cmd_4c_Confirma: botao OK que encerra o subformulario
716:         THIS.AddObject("cmd_4c_Confirma", "CommandButton")
717:         WITH THIS.cmd_4c_Confirma
718:             .Top           = 3
719:             .Left          = 928
720:             .Width         = 75
721:             .Height        = 75
722:             .Caption       = "\<Ok"
723:             .Picture       = gc_4c_CaminhoIcones + "cadastro_salvar_60.jpg"
724:             .Cancel        = .T.
725:             .FontName      = "Comic Sans MS"
726:             .FontBold      = .T.
727:             .FontItalic    = .T.
728:             .FontSize      = 8
729:             .ForeColor     = RGB(90, 90, 90)
730:             .BackColor     = RGB(255, 255, 255)
731:             .Themes        = .F.

*-- Linhas 813 a 821:
813:     * BINDEVENT exige metodos PUBLIC (sem PROTECTED)
814:     *==========================================================================
815:     PROTECTED PROCEDURE ConfigurarBINDEVENTs()
816:         BINDEVENT(THIS.cmd_4c_Confirma, "Click",    THIS, "CmdConfirmaClick")
817:         BINDEVENT(THIS.txt_4c_Grupo,    "KeyPress", THIS, "TxtGrupoKeyPress")
818:         BINDEVENT(THIS.txt_4c_Grupo,    "DblClick", THIS, "TxtGrupoDblClick")
819:         BINDEVENT(THIS.txt_4c_Dgrupo,   "KeyPress", THIS, "TxtDgrupoKeyPress")
820:         BINDEVENT(THIS.txt_4c_Conta,    "KeyPress", THIS, "TxtContaKeyPress")
821:         BINDEVENT(THIS.txt_4c_Conta,    "DblClick", THIS, "TxtContaDblClick")

*-- Linhas 1378 a 1387:
1378:         LOCAL loc_oErro
1379:         TRY
1380:             IF !THIS.this_lAlteraJuros
1381:                 IF VARTYPE(THIS.cmd_4c_Confirma) = "O"
1382:                     THIS.cmd_4c_Confirma.SetFocus
1383:                 ENDIF
1384:                 RETURN
1385:             ENDIF
1386: 
1387:             IF VARTYPE(THIS.grd_4c_Dados) = "O"


### BO (C:\4c\projeto\app\classes\SigReJurBO.prg):
*==========================================================================
* SigReJurBO.prg - Business Object para Lancamento de Juros
* Herda de: BusinessBase
* Formulario: FormSigReJur (OPERACIONAL)
* Cursor de trabalho: crTmpJuros (passado pelo form pai via DataSession)
* Tarefa: task133
*==========================================================================

DEFINE CLASS SigReJurBO AS BusinessBase

    this_cTabela     = ""
    this_cCampoChave = ""

    *-- Lado Debito: indicador de operacao, codigo/descricao do grupo contabil e conta
    this_cOper   = ""
    this_cGrupo  = ""
    this_cDGrupo = ""
    this_cConta  = ""
    this_cDConta = ""

    *-- Lado Credito: indicador de operacao, codigo/descricao do grupo contabil e conta
    this_cSOper   = ""
    this_cSGrupo  = ""
    this_cSDGrupo = ""
    this_cSConta  = ""
    this_cSDConta = ""

    *-- Flags de permissao carregadas via fChecaAcesso no Init do form
    this_lAlteraContas = .F.
    this_lAlteraJuros  = .F.

    *-- Campos do cursor compartilhado crTmpJuros (linha de juros sendo editada)
    this_dData     = {}
    this_cHist     = ""
    this_nValor    = 0
    this_cMoeda    = ""
    this_nTaxJuros = 0
    this_nDias     = 0
    this_nJuros    = 0

    *-- Alias do cursor compartilhado (default = crTmpJuros do form pai)
    this_cAliasCursor = "crTmpJuros"

    *--------------------------------------------------------------------------
    PROCEDURE Init
        DODEFAULT()
        THIS.this_cTabela     = ""
        THIS.this_cCampoChave = ""
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Form operacional nao tem chave primaria propria
    *--------------------------------------------------------------------------
    FUNCTION ObterChavePrimaria()
        RETURN ""
    ENDFUNC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir do cursor crTmpJuros
    * par_cAliasCursor = alias do cursor crTmpJuros (lado debito)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cOper  = "C"
                THIS.this_cGrupo = TratarNulo(Grupos, "C")
                THIS.this_cConta = TratarNulo(Contas, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar cursor de juros:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), "SigReJurBO.CarregarDoCursor")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDadosPam - Carrega contabilizacao padrao do cursor crSigCdPam
    * par_cAliasCursor = alias do cursor crSigCdPam (lado credito)
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDadosPam(par_cAliasCursor)
        LOCAL loc_lSucesso, loc_oErro
        loc_lSucesso = .F.

        TRY
            IF USED(par_cAliasCursor)
                SELECT (par_cAliasCursor)
                THIS.this_cSOper  = "D"
                THIS.this_cSGrupo = TratarNulo(GrupoPart, "C")
                THIS.this_cSConta = TratarNulo(ContaPart, "C")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao carregar par" + CHR(226) + "metros de contabiliza" + CHR(231) + CHR(227) + "o:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), "SigReJurBO.CarregarDadosPam")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * BuscarDescricaoGrupo - Retorna descricao do grupo contabil (SigCdGcr.Descrs)
    * par_cCodigo = codigo do grupo (Codigos)
    * Retorna string com descricao ou "" se nao encontrado
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loc_oErro
        loc_cDescricao = ""

        IF EMPTY(ALLTRIM(par_cCodigo))
            RETURN loc_cDescricao
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Descrs FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_GrDescTmp")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_GrDescTmp") > 0
                SELECT cursor_4c_GrDescTmp
                loc_cDescricao = TratarNulo(Descrs, "C")
            ENDIF
            IF USED("cursor_4c_GrDescTmp")
                USE IN cursor_4c_GrDescTmp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o de grupo:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message, "SigReJurBO.BuscarDescricaoGrupo")
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * BuscarDescricaoConta - Retorna descricao da conta corrente (SigCdCli.RClis)
    * par_cGrupo = codigo do grupo (Grupos)
    * par_cConta = codigo da conta (IClis)
    * Retorna string com descricao ou "" se nao encontrada
    *--------------------------------------------------------------------------
    FUNCTION BuscarDescricaoConta(par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_cDescricao, loc_oErro
        loc_cDescricao = ""

        IF EMPTY(ALLTRIM(par_cConta))
            RETURN loc_cDescricao
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 RClis FROM SigCdCli" + ;
                       " WHERE IClis = " + EscaparSQL(par_cConta)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaDescTmp")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_CtaDescTmp") > 0
                SELECT cursor_4c_CtaDescTmp
                loc_cDescricao = TratarNulo(RClis, "C")
            ENDIF
            IF USED("cursor_4c_CtaDescTmp")
                USE IN cursor_4c_CtaDescTmp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao buscar descri" + CHR(231) + CHR(227) + "o de conta:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message, "SigReJurBO.BuscarDescricaoConta")
        ENDTRY

        RETURN loc_cDescricao
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarContaAtiva - Verifica se conta corrente esta ativa em SigCdCli
    * par_cConta = codigo da conta (IClis)
    * Retorna .T. se conta esta ATIVA (Inativas = 0), .F. se inativa ou inexistente
    *--------------------------------------------------------------------------
    FUNCTION VerificarContaAtiva(par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lAtiva, loc_oErro
        loc_lAtiva = .F.

        IF EMPTY(ALLTRIM(par_cConta))
            RETURN loc_lAtiva
        ENDIF

        TRY
            loc_cSQL = "SELECT TOP 1 Inativas FROM SigCdCli" + ;
                       " WHERE IClis = " + EscaparSQL(par_cConta)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_CtaAtivaTmp")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_CtaAtivaTmp") > 0
                SELECT cursor_4c_CtaAtivaTmp
                *-- Inativas NUMERIC(1,0): 0=ATIVA, 1+=INATIVA
                IF VARTYPE(Inativas) = "L"
                    loc_lAtiva = !Inativas
                ELSE
                    IF VARTYPE(Inativas) = "L"
                        loc_lAtiva = !Inativas
                    ELSE
                        IF VARTYPE(Inativas) = "L"
                            loc_lAtiva = !Inativas
                        ELSE
                            loc_lAtiva = (NVL(Inativas, 0) = 0)
                        ENDIF
                    ENDIF
                ENDIF
            ENDIF
            IF USED("cursor_4c_CtaAtivaTmp")
                USE IN cursor_4c_CtaAtivaTmp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao verificar conta inativa:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message, "SigReJurBO.VerificarContaAtiva")
        ENDTRY

        RETURN loc_lAtiva
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarAcessoGrupo - Verifica se grupo contabil existe em SigCdGcr
    * par_cCodigo = codigo do grupo (Codigos)
    * Retorna .T. se grupo existe, .F. caso contrario
    *--------------------------------------------------------------------------
    FUNCTION VerificarAcessoGrupo(par_cCodigo)
        LOCAL loc_cSQL, loc_nResultado, loc_lAcesso, loc_nQtd, loc_oErro
        loc_lAcesso = .F.

        IF EMPTY(ALLTRIM(par_cCodigo))
            RETURN loc_lAcesso
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdGcr" + ;
                       " WHERE Codigos = " + EscaparSQL(par_cCodigo)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcGrpTmp")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_AcGrpTmp") > 0
                SELECT cursor_4c_AcGrpTmp
                loc_nQtd = NVL(nExiste, 0)
                loc_lAcesso = (loc_nQtd > 0)
            ENDIF
            IF USED("cursor_4c_AcGrpTmp")
                USE IN cursor_4c_AcGrpTmp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao verificar acesso ao grupo:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message, "SigReJurBO.VerificarAcessoGrupo")
        ENDTRY

        RETURN loc_lAcesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * VerificarAcessoConta - Verifica se conta existe para o grupo informado em SigCdCli
    * par_cGrupo = codigo do grupo (Grupos)
    * par_cConta = codigo da conta (IClis)
    * Retorna .T. se conta existe no grupo, .F. caso contrario
    *--------------------------------------------------------------------------
    FUNCTION VerificarAcessoConta(par_cGrupo, par_cConta)
        LOCAL loc_cSQL, loc_nResultado, loc_lAcesso, loc_nQtd, loc_oErro
        loc_lAcesso = .F.

        IF EMPTY(ALLTRIM(par_cConta))
            RETURN loc_lAcesso
        ENDIF

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste FROM SigCdCli" + ;
                       " WHERE IClis = " + EscaparSQL(par_cConta)
            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_AcCtaTmp")
            IF loc_nResultado >= 0 AND RECCOUNT("cursor_4c_AcCtaTmp") > 0
                SELECT cursor_4c_AcCtaTmp
                loc_nQtd = NVL(nExiste, 0)
                loc_lAcesso = (loc_nQtd > 0)
            ENDIF
            IF USED("cursor_4c_AcCtaTmp")
                USE IN cursor_4c_AcCtaTmp
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao verificar acesso " + CHR(224) + " conta:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message, "SigReJurBO.VerificarAcessoConta")
        ENDTRY

        RETURN loc_lAcesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Inserir - APPEND BLANK na linha de juros no cursor compartilhado crTmpJuros
    * REGRA: Form OPERACIONAL ? edicao por cursor compartilhado (DataSession do form pai),
    *        NAO ha SQL INSERT em tabela. Persistencia ocorre quando o form pai
    *        consome crTmpJuros (rotina de lancamento de juros do framework SIG).
    * Retorna .T. se sucesso, .F. caso contrario.
    *--------------------------------------------------------------------------
    FUNCTION Inserir()
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        loc_cAlias   = THIS.this_cAliasCursor

        TRY
            IF !USED(loc_cAlias)
                MostrarErro("Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto.", ;
                            "SigReJurBO.Inserir")
            ELSE
                SELECT (loc_cAlias)
                APPEND BLANK

                REPLACE Datas    WITH THIS.this_dData     IN (loc_cAlias)
                REPLACE Hists    WITH THIS.this_cHist     IN (loc_cAlias)
                REPLACE Valors   WITH THIS.this_nValor    IN (loc_cAlias)
                REPLACE Moedas   WITH THIS.this_cMoeda    IN (loc_cAlias)
                REPLACE TaxJuros WITH THIS.this_nTaxJuros IN (loc_cAlias)
                REPLACE Dias     WITH THIS.this_nDias     IN (loc_cAlias)
                REPLACE Juros    WITH THIS.this_nJuros    IN (loc_cAlias)
                REPLACE Grupos   WITH THIS.this_cGrupo    IN (loc_cAlias)
                REPLACE Contas   WITH THIS.this_cConta    IN (loc_cAlias)

                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao inserir linha de juros:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SigReJurBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * Atualizar - REPLACE da linha corrente no cursor compartilhado crTmpJuros
    * REGRA: Forma operacional permite editar apenas Hists (col 2) e Juros (col 7)
    *        diretamente no grid. Este metodo persiste todos os campos da linha
    *        corrente a partir das propriedades do BO ? util quando edicao acontece
    *        fora do grid (formularios secundarios, validacoes complementares).
    * Retorna .T. se sucesso, .F. caso contrario.
    *--------------------------------------------------------------------------
    FUNCTION Atualizar()
        LOCAL loc_lSucesso, loc_cAlias, loc_oErro
        loc_lSucesso = .F.
        loc_cAlias   = THIS.this_cAliasCursor

        TRY
            IF !USED(loc_cAlias)
                MostrarErro("Cursor " + loc_cAlias + " n" + CHR(227) + "o est" + CHR(225) + " aberto.", ;
                            "SigReJurBO.Atualizar")
            ELSE
                SELECT (loc_cAlias)
                IF EOF() OR BOF() OR RECNO() <= 0
                    MostrarErro("N" + CHR(227) + "o h" + CHR(225) + " registro corrente em " + loc_cAlias + " para atualizar.", ;
                                "SigReJurBO.Atualizar")
                ELSE
                    REPLACE Datas    WITH THIS.this_dData     IN (loc_cAlias)
                    REPLACE Hists    WITH THIS.this_cHist     IN (loc_cAlias)
                    REPLACE Valors   WITH THIS.this_nValor    IN (loc_cAlias)
                    REPLACE Moedas   WITH THIS.this_cMoeda    IN (loc_cAlias)
                    REPLACE TaxJuros WITH THIS.this_nTaxJuros IN (loc_cAlias)
                    REPLACE Dias     WITH THIS.this_nDias     IN (loc_cAlias)
                    REPLACE Juros    WITH THIS.this_nJuros    IN (loc_cAlias)
                    REPLACE Grupos   WITH THIS.this_cGrupo    IN (loc_cAlias)
                    REPLACE Contas   WITH THIS.this_cConta    IN (loc_cAlias)

                    THIS.RegistrarAuditoria("ATUALIZAR")
                    loc_lSucesso = .T.
                ENDIF
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao atualizar linha de juros:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message + CHR(13) + ;
                        "Linha: " + TRANSFORM(loc_oErro.LineNo), ;
                        "SigReJurBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDFUNC

    *--------------------------------------------------------------------------
    * RegistrarAuditoria - Sobrescreve auditoria para form operacional
    * Como nao ha persistencia em tabela SQL propria, grava log em LogAuditoria
    * com a chave composta (Grupo + Conta + Data) para rastreabilidade da
    * linha de juros editada/inserida no cursor compartilhado.
    *--------------------------------------------------------------------------
    PROCEDURE RegistrarAuditoria(par_cOperacao)
        LOCAL loc_cSQL, loc_cChave, loc_nResultado, loc_oErro

        TRY
            loc_cChave = ALLTRIM(THIS.this_cGrupo) + "|" + ;
                         ALLTRIM(THIS.this_cConta) + "|" + ;
                         DTOC(THIS.this_dData)

            loc_cSQL = "INSERT INTO LogAuditoria " + ;
                       "(Tabela, ChavePrimaria, Operacao, Usuario, DataHora, Empresa) " + ;
                       "VALUES (" + ;
                       EscaparSQL("crTmpJuros") + ", " + ;
                       EscaparSQL(loc_cChave) + ", " + ;
                       EscaparSQL(par_cOperacao) + ", " + ;
                       EscaparSQL(gc_4c_UsuarioLogado) + ", " + ;
                       "GETDATE(), " + ;
                       EscaparSQL(go_4c_Sistema.cCodEmpresa) + ;
                       ")"

            loc_nResultado = SQLEXEC(gnConnHandle, loc_cSQL)

            IF loc_nResultado < 0
                MostrarErro("Falha ao registrar auditoria de " + par_cOperacao + " em crTmpJuros.", ;
                            "SigReJurBO.RegistrarAuditoria")
            ENDIF
        CATCH TO loc_oErro
            MostrarErro("Erro ao registrar auditoria:" + CHR(13) + ;
                        "Erro: " + loc_oErro.Message, ;
                        "SigReJurBO.RegistrarAuditoria")
        ENDTRY
    ENDPROC

ENDDEFINE

