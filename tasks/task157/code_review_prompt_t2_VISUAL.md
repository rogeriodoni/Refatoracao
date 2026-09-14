# CODE REVIEW - PASS VISUAL: Visual Properties (alinhamento, titulos, tipos)

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Visual Properties (alinhamento, titulos, tipos)**.

## PROBLEMAS DETECTADOS (1)
- [GRID-WITH] Bloco WITH THIS.grd_4c_Dados define .RecordSource E acessa .Column dentro do mesmo WITH. Isso causa 'Unknown member COLUMN1' porque colunas nao sao criadas imediatamente dentro de WITH. SOLUCAO: Mover .RecordSource e .ColumnCount para FORA do WITH (usar referencia explicita: THIS.grd_4c_Dados.RecordSource).

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

### FORM (C:\4c\projeto\app\forms\operacionais\FormSigPrCar.prg) - TRECHOS RELEVANTES PARA PASS VISUAL (1013 linhas total):

*-- Linhas 9 a 29:
9: *   cntSombra   Top=0    Left=0  Width=480 Height=80  (cabecalho cinza)
10: *   Shape1      Top=-3   Left=239 (fundo visual area botoes)
11: *   cmdInserir  Top=3    Left=255 (visivel apenas INSERIR/ALTERAR)
12: *   cmdExcluir  Top=3    Left=330 (visivel apenas INSERIR/ALTERAR)
13: *   cmdSair     Top=3    Left=405 (sempre visivel, Caption="Encerrar")
14: *   grd_4c_Dados Top=103 Left=8  Width=463 Height=411
15: *==============================================================================
16: 
17: DEFINE CLASS FormSigPrCar AS FormBase
18: 
19:     *-- Propriedades visuais identicas ao original (PILAR 1)
20:     this_cMensagemErro = ""
21:     Width       = 480
22:     Height      = 540
23:     AutoCenter  = .T.
24:     BorderStyle = 2
25:     ShowWindow = 1
26:     ControlBox  = .F.
27:     MaxButton   = .F.
28:     MinButton   = .F.
29:     TitleBar    = 0

*-- Linhas 111 a 158:
111:     PROTECTED PROCEDURE ConfigurarPageFrame()
112:         THIS.AddObject("cnt_4c_Sombra", "Container")
113:         WITH THIS.cnt_4c_Sombra
114:             .Top         = 0
115:             .Left        = 0
116:             .Width       = THIS.Width
117:             .Height      = 80
118:             .BackColor   = RGB(100, 100, 100)
119:             .BackStyle   = 1
120:             .BorderWidth = 0
121: 
122:             .AddObject("lbl_4c_LblSombra", "Label")
123:             WITH .lbl_4c_LblSombra
124:                 .Top           = 25
125:                 .Left          = 10
126:                 .Width         = THIS.Width
127:                 .Height        = 40
128:                 .FontBold      = .T.
129:                 .FontName      = "Tahoma"
130:                 .FontSize      = 18
131:                 .BackStyle     = 0
132:                 .AutoSize      = .F.
133:                 .WordWrap      = .T.
134:                 .Alignment     = 0
135:                 .ForeColor     = RGB(0, 0, 0)
136:                 .Caption       = THIS.this_cTituloForm
137:             ENDWITH
138: 
139:             .AddObject("lbl_4c_LblTitulo", "Label")
140:             WITH .lbl_4c_LblTitulo
141:                 .Top           = 24
142:                 .Left          = 10
143:                 .Width         = THIS.Width
144:                 .Height        = 46
145:                 .FontBold      = .T.
146:                 .FontName      = "Tahoma"
147:                 .FontSize      = 18
148:                 .BackStyle     = 0
149:                 .AutoSize      = .F.
150:                 .WordWrap      = .T.
151:                 .Alignment     = 0
152:                 .ForeColor     = RGB(255, 255, 255)
153:                 .Caption       = THIS.this_cTituloForm
154:             ENDWITH
155:         ENDWITH
156:     ENDPROC
157: 
158:     *==========================================================================

*-- Linhas 281 a 304:
281:         SET NULL ON
282:         CREATE CURSOR cursor_4c_Dados ;
283:             (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
284:         SET NULL OFF
285: 
286:         THIS.AddObject("grd_4c_Dados", "Grid")
287:         THIS.grd_4c_Dados.ColumnCount  = 2
288:         THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
289:         WITH THIS.grd_4c_Dados
290:             .Top               = 103
291:             .Left              = 8
292:             .Width             = 463
293:             .Height            = 411
294:             .FontName          = "Tahoma"
295:             .FontSize          = 8
296:             .DeleteMark        = .F.
297:             .RecordMark        = .F.
298:             .AllowHeaderSizing = .F.
299:             .AllowRowSizing    = .F.
300:             .RowHeight         = 17
301:             .ScrollBars        = 2
302:             .GridLineColor     = RGB(238, 238, 238)
303:             .AllowCellSelection = .T.
304:             .Panel             = 1

*-- Linhas 311 a 319:
311:                 .Movable       = .F.
312:                 .Resizable     = .F.
313:             ENDWITH
314:             .Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
315:             .Column1.Header1.FontName  = "Tahoma"
316:             .Column1.Header1.FontSize  = 8
317:             .Column1.Header1.Alignment = 2
318:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
319: 

*-- Linhas 325 a 368:
325:                 .Movable       = .F.
326:                 .Resizable     = .F.
327:             ENDWITH
328:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
329:             .Column2.Header1.FontName  = "Tahoma"
330:             .Column2.Header1.FontSize  = 8
331:             .Column2.Header1.Alignment = 2
332:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
333:         ENDWITH
334: 
335:         BINDEVENT(THIS.grd_4c_Dados.Column1.Text1, "KeyPress", THIS, "TxtCodigosKeyPress")
336:         BINDEVENT(THIS.grd_4c_Dados.Column2.Text1, "KeyPress", THIS, "TxtDescrsKeyPress")
337:     ENDPROC
338: 
339:     *==========================================================================
340:     * ConfigurarBotoes - Cria Shape1 e 3 botoes de acao sobrepostos ao cabecalho
341:     * Inserir (Left=255), Excluir (Left=330), Encerrar (Left=405)
342:     * Visibilidade controlada por AjustarVisibilidadeBotoes()
343:     *==========================================================================
344:     PROTECTED PROCEDURE ConfigurarBotoes()
345:         *-- Shape1: fundo visual da area de botoes (BackStyle=0 = transparente)
346:         THIS.AddObject("shp_4c_Shape1", "Shape")
347:         WITH THIS.shp_4c_Shape1
348:             .Top         = -3
349:             .Left        = 239
350:             .Width       = 250
351:             .Height      = 38
352:             .BackStyle   = 0
353:             .BorderStyle = 0
354:             .BorderColor = RGB(136, 189, 188)
355:         ENDWITH
356: 
357:         THIS.AddObject("cmd_4c_Inserir", "CommandButton")
358:         WITH THIS.cmd_4c_Inserir
359:             .Top             = 3
360:             .Left            = 255
361:             .Width           = 70
362:             .Height          = 30
363:             .Caption         = "Inserir"
364:             .Picture         = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
365:             .Themes          = .T.
366:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_inserir_60.jpg"
367:             .FontName        = "Tahoma"
368:             .FontSize        = 8

*-- Linhas 376 a 392:
376:             .WordWrap        = .T.
377:             .AutoSize        = .F.
378:         ENDWITH
379:         BINDEVENT(THIS.cmd_4c_Inserir, "Click", THIS, "CmdInserirClick")
380: 
381:         THIS.AddObject("cmd_4c_Excluir", "CommandButton")
382:         WITH THIS.cmd_4c_Excluir
383:             .Top             = 3
384:             .Left            = 330
385:             .Width           = 70
386:             .Height          = 30
387:             .Caption         = "Excluir"
388:             .Picture         = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
389:             .Themes          = .T.
390:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_excluir_60.jpg"
391:             .FontName        = "Tahoma"
392:             .FontSize        = 8

*-- Linhas 400 a 416:
400:             .WordWrap        = .T.
401:             .AutoSize        = .F.
402:         ENDWITH
403:         BINDEVENT(THIS.cmd_4c_Excluir, "Click", THIS, "CmdExcluirClick")
404: 
405:         THIS.AddObject("cmd_4c_Sair", "CommandButton")
406:         WITH THIS.cmd_4c_Sair
407:             .Top             = 3
408:             .Left            = 405
409:             .Width           = 75
410:             .Height          = 75
411:             .Caption         = "Encerrar"
412:             .Cancel          = .T.
413:             .Picture         = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
414:             .Themes          = .T.
415:             .DisabledPicture = gc_4c_CaminhoIcones + "cadastro_sair_60.jpg"
416:             .FontName        = "Tahoma"

*-- Linhas 425 a 495:
425:             .WordWrap        = .T.
426:             .AutoSize        = .F.
427:         ENDWITH
428:         BINDEVENT(THIS.cmd_4c_Sair, "Click", THIS, "CmdSairClick")
429:     ENDPROC
430: 
431:     *==========================================================================
432:     * AjustarVisibilidadeBotoes - Mostra/oculta Inserir e Excluir conforme modo
433:     * INSERIR/ALTERAR: mostra ambos | CONSULTAR: oculta e ajusta Shape1
434:     *==========================================================================
435:     PROTECTED PROCEDURE AjustarVisibilidadeBotoes()
436:         LOCAL loc_lEdicao
437:         loc_lEdicao = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
438: 
439:         THIS.cmd_4c_Inserir.Visible = loc_lEdicao
440:         THIS.cmd_4c_Inserir.Enabled = loc_lEdicao
441:         THIS.cmd_4c_Excluir.Visible = loc_lEdicao
442:         THIS.cmd_4c_Excluir.Enabled = loc_lEdicao
443: 
444:         IF !loc_lEdicao
445:             THIS.shp_4c_Shape1.Width = THIS.cmd_4c_Sair.Width + 10
446:             THIS.shp_4c_Shape1.Left  = THIS.cmd_4c_Sair.Left - 5
447:         ENDIF
448:     ENDPROC
449: 
450:     *==========================================================================
451:     * CarregarDados - Vincula grid ao cursor_4c_Dados apos BO.Buscar()
452:     * Redefine RecordSource e reconfigura cabecalhos (resetados por RecordSource)
453:     *==========================================================================
454:     PROTECTED PROCEDURE CarregarDados()
455:         IF !USED("cursor_4c_Dados")
456:             RETURN
457:         ENDIF
458: 
459:         WITH THIS.grd_4c_Dados
460:             .ColumnCount           = 2
461:             .RecordSource          = "cursor_4c_Dados"
462:             .Column1.ControlSource = "cursor_4c_Dados.codigos"
463:             .Column2.ControlSource = "cursor_4c_Dados.descrs"
464:             *-- Reconfigurar cabecalhos (reset automatico apos alterar RecordSource)
465:             .Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
466:             .Column1.Header1.FontName  = "Tahoma"
467:             .Column1.Header1.FontSize  = 8
468:             .Column1.Header1.Alignment = 2
469:             .Column1.Header1.ForeColor = RGB(90, 90, 90)
470:             .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
471:             .Column2.Header1.FontName  = "Tahoma"
472:             .Column2.Header1.FontSize  = 8
473:             .Column2.Header1.Alignment = 2
474:             .Column2.Header1.ForeColor = RGB(90, 90, 90)
475:         ENDWITH
476: 
477:         SELECT cursor_4c_Dados
478:         GO TOP
479:         THIS.FormatarGridLista(THIS.grd_4c_Dados)
480:         THIS.grd_4c_Dados.Refresh()
481:     ENDPROC
482: 
483:     *==========================================================================
484:     * CmdInserirClick - Adiciona nova linha vazia ao grid para preenchimento
485:     * Equivale a cmdInserir.Click do legado (Insert Into crSigPrCar + SetFocus)
486:     *==========================================================================
487:     PROCEDURE CmdInserirClick()
488:         LOCAL loc_oErro
489: 
490:         TRY
491:             IF !USED("cursor_4c_Dados")
492:                 RETURN
493:             ENDIF
494: 
495:             THIS.this_lHouveIncl = .T.

*-- Linhas 505 a 526:
505:             ELSE
506:                 *-- Ja existe linha vazia: posicionar nela
507:                 SELECT cursor_4c_Dados
508:             ENDIF
509: 
510:             THIS.grd_4c_Dados.Refresh()
511:             THIS.grd_4c_Dados.SetFocus()
512: 
513:         CATCH TO loc_oErro
514:             MsgErro(loc_oErro.Message, "FormSigPrCar.CmdInserirClick")
515:         ENDTRY
516:     ENDPROC
517: 
518:     *==========================================================================
519:     * CmdExcluirClick - Exclui linha atual do grid
520:     * Para registros persistidos: SQL DELETE via BO.Excluir()
521:     * Reconstroi cursor_4c_Dados sem o registro para atualizar grid imediatamente
522:     *==========================================================================
523:     PROCEDURE CmdExcluirClick()
524:         LOCAL loc_cPkChaves, loc_nRecnoAtual, loc_oErro
525: 
526:         TRY

*-- Linhas 574 a 617:
574:             SELECT cursor_4c_Dados
575:             APPEND FROM DBF("cursor_4c_DadosSwap")
576:             USE IN cursor_4c_DadosSwap
577: 
578:             *-- Rebind do grid
579:             THIS.grd_4c_Dados.ColumnCount  = 2
580:             THIS.grd_4c_Dados.RecordSource = "cursor_4c_Dados"
581:             WITH THIS.grd_4c_Dados
582:                 .Column1.ControlSource = "cursor_4c_Dados.codigos"
583:                 .Column2.ControlSource = "cursor_4c_Dados.descrs"
584:                 .Column1.Header1.Caption   = "Caracter" + CHR(237) + "stica"
585:                 .Column1.Header1.FontName  = "Tahoma"
586:                 .Column1.Header1.FontSize  = 8
587:                 .Column1.Header1.Alignment = 2
588:                 .Column1.Header1.ForeColor = RGB(90, 90, 90)
589:                 .Column2.Header1.Caption   = "Descri" + CHR(231) + CHR(227) + "o"
590:                 .Column2.Header1.FontName  = "Tahoma"
591:                 .Column2.Header1.FontSize  = 8
592:                 .Column2.Header1.Alignment = 2
593:                 .Column2.Header1.ForeColor = RGB(90, 90, 90)
594:             ENDWITH
595:             THIS.FormatarGridLista(THIS.grd_4c_Dados)
596: 
597:             THIS.this_lHouveExcl = .T.
598:             SELECT cursor_4c_Dados
599:             IF !EOF()
600:                 GO TOP
601:             ENDIF
602:             THIS.grd_4c_Dados.Refresh()
603: 
604:         CATCH TO loc_oErro
605:             MsgErro(loc_oErro.Message, "FormSigPrCar.CmdExcluirClick")
606:         ENDTRY
607:     ENDPROC
608: 
609:     *==========================================================================
610:     * CmdSairClick - Persiste alteracoes no SQL Server e fecha o form
611:     * Em INSERIR/ALTERAR: INSERT novas linhas, UPDATE linhas existentes
612:     * Em CONSULTAR: apenas reabilita o form pai e fecha
613:     * Equivale a cmdSair.Click do legado
614:     *==========================================================================
615:     PROCEDURE CmdSairClick()
616:         LOCAL loc_oBO, loc_oErro
617: 

*-- Linhas 676 a 704:
676:         TRY
677:             IF !USED("cursor_4c_Dados") OR EOF("cursor_4c_Dados")
678:                 RETURN
679:             ENDIF
680: 
681:             loc_cValorAtual    = ALLTRIM(NVL(THIS.grd_4c_Dados.Column1.Text1.Value, ""))
682:             loc_cPkChavesAtual = ALLTRIM(NVL(cursor_4c_Dados.pkchaves, ""))
683: 
684:             IF EMPTY(loc_cValorAtual)
685:                 REPLACE codigos WITH "" IN cursor_4c_Dados
686:                 REPLACE descrs  WITH "" IN cursor_4c_Dados
687:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
688:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
689:                 THIS.grd_4c_Dados.Refresh()
690:                 RETURN
691:             ENDIF
692: 
693:             loc_cFiltro = "CGrus IN (" + EscaparSQL(THIS.this_cCGrus) + ", '   ')"
694:             loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
695: 
696:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
697:                 "SigCrRap", "cursor_4c_Busca", "codigos", loc_cValorAtual, ;
698:                 loc_cTitulo, .F., .F., loc_cFiltro)
699: 
700:             IF VARTYPE(loc_oBusca) = "O"
701:                 IF !loc_oBusca.this_lAchouRegistro
702:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
703:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
704:                     loc_oBusca.Show()

*-- Linhas 715 a 757:
715:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
716:                                  " informada para este produto!", ;
717:                                  "Aten" + CHR(231) + CHR(227) + "o")
718:                         REPLACE codigos WITH "" IN cursor_4c_Dados
719:                         REPLACE descrs  WITH "" IN cursor_4c_Dados
720:                         THIS.grd_4c_Dados.Column1.Text1.Value = ""
721:                         THIS.grd_4c_Dados.Column2.Text1.Value = ""
722:                     ELSE
723:                         REPLACE codigos WITH loc_cCodSel  IN cursor_4c_Dados
724:                         REPLACE descrs  WITH loc_cDescSel IN cursor_4c_Dados
725:                         THIS.grd_4c_Dados.Column1.Text1.Value = loc_cCodSel
726:                         THIS.grd_4c_Dados.Column2.Text1.Value = loc_cDescSel
727:                     ENDIF
728:                 ELSE
729:                     REPLACE codigos WITH "" IN cursor_4c_Dados
730:                     REPLACE descrs  WITH "" IN cursor_4c_Dados
731:                     THIS.grd_4c_Dados.Column1.Text1.Value = ""
732:                     THIS.grd_4c_Dados.Column2.Text1.Value = ""
733:                 ENDIF
734: 
735:                 loc_oBusca.Release()
736:             ENDIF
737: 
738:             IF USED("cursor_4c_Busca")
739:                 USE IN cursor_4c_Busca
740:             ENDIF
741: 
742:             THIS.grd_4c_Dados.Refresh()
743: 
744:         CATCH TO loc_oErro
745:             MsgErro(loc_oErro.Message, "FormSigPrCar.TxtCodigosKeyPress")
746:         ENDTRY
747:     ENDPROC
748: 
749:     *==========================================================================
750:     * TxtDescrsKeyPress - KeyPress no Column2 (Descricao) do grid
751:     * ENTER(13)/TAB(9)/F4(115): abre FormBuscaAuxiliar por descricao na SigCrRap
752:     * Condicao (equivale ao When do legado): so ativo quando Column1 esta vazio
753:     *==========================================================================
754:     PROCEDURE TxtDescrsKeyPress(par_nKeyCode, par_nShiftAltCtrl)
755:         LOCAL loc_oBusca, loc_cValorAtual, loc_cPkChavesAtual
756:         LOCAL loc_cCodSel, loc_cDescSel, loc_cFiltro, loc_cTitulo, loc_oErro
757: 

*-- Linhas 767 a 795:
767:             *-- Column2 so e operacional quando Column1 esta vazio (legado: When condition)
768:             IF !EMPTY(ALLTRIM(NVL(cursor_4c_Dados.codigos, "")))
769:                 RETURN
770:             ENDIF
771: 
772:             loc_cValorAtual    = ALLTRIM(NVL(THIS.grd_4c_Dados.Column2.Text1.Value, ""))
773:             loc_cPkChavesAtual = ALLTRIM(NVL(cursor_4c_Dados.pkchaves, ""))
774: 
775:             IF EMPTY(loc_cValorAtual)
776:                 REPLACE codigos WITH "" IN cursor_4c_Dados
777:                 REPLACE descrs  WITH "" IN cursor_4c_Dados
778:                 THIS.grd_4c_Dados.Column1.Text1.Value = ""
779:                 THIS.grd_4c_Dados.Column2.Text1.Value = ""
780:                 THIS.grd_4c_Dados.Refresh()
781:                 RETURN
782:             ENDIF
783: 
784:             loc_cFiltro = "CGrus IN (" + EscaparSQL(THIS.this_cCGrus) + ", '   ')"
785:             loc_cTitulo = "Sele" + CHR(231) + CHR(227) + "o"
786: 
787:             loc_oBusca = CREATEOBJECT("FormBuscaAuxiliar", gnConnHandle, ;
788:                 "SigCrRap", "cursor_4c_Busca", "descrs", loc_cValorAtual, ;
789:                 loc_cTitulo, .F., .F., loc_cFiltro)
790: 
791:             IF VARTYPE(loc_oBusca) = "O"
792:                 IF !loc_oBusca.this_lAchouRegistro
793:                     loc_oBusca.mAddColuna("descrs",  "", "Descri" + CHR(231) + CHR(227) + "o")
794:                     loc_oBusca.mAddColuna("codigos", "", "C" + CHR(243) + "digo")
795:                     loc_oBusca.Show()

*-- Linhas 806 a 895:
806:                         MsgAviso("Caracter" + CHR(237) + "stica j" + CHR(225) + ;
807:                                  " informada para este produto!", ;
808:                                  "Aten" + CHR(231) + CHR(227) + "o")
809:                         REPLACE codigos WITH "" IN cursor_4c_Dados
810:                         REPLACE descrs  WITH "" IN cursor_4c_Dados
811:                         THIS.grd_4c_Dados.Column1.Text1.Value = ""
812:                         THIS.grd_4c_Dados.Column2.Text1.Value = ""
813:                     ELSE
814:                         REPLACE codigos WITH loc_cCodSel  IN cursor_4c_Dados
815:                         REPLACE descrs  WITH loc_cDescSel IN cursor_4c_Dados
816:                         THIS.grd_4c_Dados.Column1.Text1.Value = loc_cCodSel
817:                         THIS.grd_4c_Dados.Column2.Text1.Value = loc_cDescSel
818:                     ENDIF
819:                 ELSE
820:                     REPLACE codigos WITH "" IN cursor_4c_Dados
821:                     REPLACE descrs  WITH "" IN cursor_4c_Dados
822:                     THIS.grd_4c_Dados.Column1.Text1.Value = ""
823:                     THIS.grd_4c_Dados.Column2.Text1.Value = ""
824:                 ENDIF
825: 
826:                 loc_oBusca.Release()
827:             ENDIF
828: 
829:             IF USED("cursor_4c_Busca")
830:                 USE IN cursor_4c_Busca
831:             ENDIF
832: 
833:             THIS.grd_4c_Dados.Refresh()
834: 
835:         CATCH TO loc_oErro
836:             MsgErro(loc_oErro.Message, "FormSigPrCar.TxtDescrsKeyPress")
837:         ENDTRY
838:     ENDPROC
839: 
840:     *==========================================================================
841:     * FormatarGridLista - Formata fonte das colunas do grid
842:     * Chamado apos rebind de RecordSource para garantir consistencia visual
843:     *==========================================================================
844:     PROTECTED PROCEDURE FormatarGridLista(par_oGrid)
845:         WITH par_oGrid
846:             .FontName = "Tahoma"
847:             .FontSize = 8
848:         ENDWITH
849:     ENDPROC
850: 
851:     *==========================================================================
852:     * BtnIncluirClick - Override do FormBase: delega a CmdInserirClick
853:     * Este form OPERACIONAL usa cmd_4c_Inserir (nao o botao CRUD padrao).
854:     * Override garante que chamadas via FormBase nao disparem comportamento CRUD.
855:     *==========================================================================
856:     PROCEDURE BtnIncluirClick()
857:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
858:             THIS.CmdInserirClick()
859:         ENDIF
860:     ENDPROC
861: 
862:     *==========================================================================
863:     * BtnAlterarClick - Override do FormBase: nao aplicavel neste OPERACIONAL
864:     * Edicao ocorre diretamente nas celulas do grid (inline editing).
865:     * Override previne comportamento CRUD padrao do FormBase.
866:     *==========================================================================
867:     PROCEDURE BtnAlterarClick()
868:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR") AND VARTYPE(THIS.grd_4c_Dados) = "O"
869:             THIS.grd_4c_Dados.SetFocus()
870:         ENDIF
871:     ENDPROC
872: 
873:     *==========================================================================
874:     * BtnVisualizarClick - Override do FormBase: nao aplicavel neste OPERACIONAL
875:     * Form OPERACIONAL nao possui modo VISUALIZAR separado - o grid sempre exibe
876:     * os dados carregados. Override previne comportamento CRUD padrao do FormBase.
877:     *==========================================================================
878:     PROCEDURE BtnVisualizarClick()
879:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
880:             THIS.grd_4c_Dados.Refresh()
881:         ENDIF
882:     ENDPROC
883: 
884:     *==========================================================================
885:     * BtnExcluirClick - Override do FormBase: delega a CmdExcluirClick
886:     * Este form OPERACIONAL usa cmd_4c_Excluir (nao o botao CRUD padrao).
887:     * Override garante que chamadas via FormBase nao disparem comportamento CRUD.
888:     *==========================================================================
889:     PROCEDURE BtnExcluirClick()
890:         IF INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
891:             THIS.CmdExcluirClick()
892:         ENDIF
893:     ENDPROC
894: 
895:     *==========================================================================

*-- Linhas 961 a 996:
961:             loc_lEdicao = par_lHabilitar
962:         ELSE
963:             loc_lEdicao = INLIST(THIS.this_cPcEscolha, "INSERIR", "ALTERAR")
964:         ENDIF
965: 
966:         IF VARTYPE(THIS.grd_4c_Dados) = "O"
967:             THIS.grd_4c_Dados.Column1.ReadOnly = !loc_lEdicao
968:             THIS.grd_4c_Dados.Column2.ReadOnly = !loc_lEdicao
969:         ENDIF
970:     ENDPROC
971: 
972:     *==========================================================================
973:     * LimparCampos - Limpa o cursor de dados do grid
974:     * Chamado ao inicializar modo INCLUIR ou ao cancelar uma operacao.
975:     *==========================================================================
976:     PROCEDURE LimparCampos()
977:         IF USED("cursor_4c_Dados")
978:             SELECT cursor_4c_Dados
979:             ZAP
980:             IF VARTYPE(THIS.grd_4c_Dados) = "O"
981:                 THIS.grd_4c_Dados.Refresh()
982:             ENDIF
983:         ENDIF
984:     ENDPROC
985: 
986:     *==========================================================================
987:     * CarregarLista - Carrega caracteristicas do produto via BO.Buscar
988:     * Chamado na inicializacao e sempre que os dados precisam ser recarregados.
989:     *==========================================================================
990:     PROCEDURE CarregarLista()
991:         LOCAL loc_lSucesso
992:         loc_lSucesso = .F.
993: 
994:         IF !EMPTY(THIS.this_cCPros) AND VARTYPE(THIS.this_oBusinessObject) = "O"
995:             IF THIS.this_oBusinessObject.Buscar(THIS.this_cCPros)
996:                 THIS.CarregarDados()


### BO (C:\4c\projeto\app\classes\SigPrCarBO.prg):
*==============================================================================
* SigPrCarBO.prg - Business Object para Caracter" + CHR(237) + "sticas do Produto
* Data: 2026-07-01
* Tabela: sigprcar | PK: pkchaves
* Relacionamento: sigprcar JOIN SIGCRRAP (para descrs)
* Filtro lookup: SIGCRRAP.cgrus = produto.cgrus
*==============================================================================

DEFINE CLASS SigPrCarBO AS BusinessBase

    *-- Propriedades persistidas (tabela sigprcar)
    this_cCodigos   = ""    && codigos   CHAR(20) - C" + CHR(243) + "digo da caracter" + CHR(237) + "stica (FK -> SIGCRRAP)
    this_cCPros     = ""    && cpros     CHAR(14) - C" + CHR(243) + "digo do produto (FK)
    this_cPkChaves  = ""    && pkchaves  CHAR(20) - Chave prim" + CHR(225) + "ria

    *-- Propriedades auxiliares (n" + CHR(227) + "o persistidas - carregadas via JOIN)
    this_cDescrs    = ""    && SIGCRRAP.descrs  CHAR(40) - Descri" + CHR(231) + CHR(227) + "o da caracter" + CHR(237) + "stica
    this_cCGrus     = ""    && produto.cgrus    CHAR(3)  - Grupo (filtro do lookup SigCrRap)

    *--------------------------------------------------------------------------
    * Init - Inicializa o Business Object
    *--------------------------------------------------------------------------
    PROCEDURE Init()
        DODEFAULT()
        THIS.this_cTabela     = "sigprcar"
        THIS.this_cCampoChave = "pkchaves"
        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * ObterChavePrimaria - Retorna chave prim" + CHR(225) + "ria para auditoria
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ObterChavePrimaria()
        RETURN THIS.this_cPkChaves
    ENDPROC

    *--------------------------------------------------------------------------
    * CarregarDoCursor - Carrega propriedades do BO a partir de cursor
    *--------------------------------------------------------------------------
    PROCEDURE CarregarDoCursor(par_cAliasCursor)
        IF USED(par_cAliasCursor)
            SELECT (par_cAliasCursor)
            THIS.this_cCodigos  = TratarNulo(codigos, "C")
            THIS.this_cCPros    = TratarNulo(cpros, "C")
            THIS.this_cPkChaves = TratarNulo(pkchaves, "C")
            IF TYPE("descrs") != "U"
                THIS.this_cDescrs = TratarNulo(descrs, "C")
            ENDIF
            RETURN .T.
        ENDIF
        RETURN .F.
    ENDPROC

    *--------------------------------------------------------------------------
    * Buscar - Carrega caracter" + CHR(237) + "sticas de um produto do SQL Server
    * par_cCPros: c" + CHR(243) + "digo do produto (obrigat" + CHR(243) + "rio)
    * Popula cursor_4c_Dados com JOIN em SIGCRRAP para obter descri" + CHR(231) + CHR(227) + "o
    *--------------------------------------------------------------------------
    PROCEDURE Buscar(par_cCPros)
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF USED("cursor_4c_Dados")
                TABLEREVERT(.T., "cursor_4c_Dados")
                USE IN cursor_4c_Dados
            ENDIF

            IF USED("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp
            ENDIF

            loc_cSQL = "SELECT p.codigos, r.descrs, p.cpros, p.pkchaves " + ;
                       "FROM sigprcar p " + ;
                       "LEFT JOIN SIGCRRAP r ON r.codigos = p.codigos " + ;
                       "WHERE p.cpros = " + EscaparSQL(par_cCPros) + " " + ;
                       "ORDER BY r.descrs"

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DadosTemp") > 0
                SET NULL ON
                CREATE CURSOR cursor_4c_Dados ;
                    (codigos C(20) NULL, descrs C(40) NULL, cpros C(14) NULL, pkchaves C(20) NULL)
                SET NULL OFF

                SELECT cursor_4c_Dados
                APPEND FROM DBF("cursor_4c_DadosTemp")
                USE IN cursor_4c_DadosTemp

                SELECT cursor_4c_Dados
                GO TOP
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao carregar caracter" + CHR(237) + "sticas do produto.", "SigPrCarBO.Buscar")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.Buscar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarCaracteristicaDuplicada - Verifica se caracter" + CHR(237) + "stica j" + CHR(225) + " existe
    * para o produto (excluindo o registro atual em edi" + CHR(231) + CHR(227) + "o)
    * Retorna .T. se duplicada (j" + CHR(225) + " existe), .F. se " + CHR(250) + "nica
    *--------------------------------------------------------------------------
    PROCEDURE ValidarCaracteristicaDuplicada(par_cCodigos, par_cCPros, par_cPkChavesAtual)
        LOCAL loc_cSQL, loc_lDuplicado, loc_oErro

        loc_lDuplicado = .F.

        TRY
            loc_cSQL = "SELECT COUNT(*) AS nExiste " + ;
                       "FROM sigprcar " + ;
                       "WHERE codigos = " + EscaparSQL(par_cCodigos) + " " + ;
                       "AND cpros = " + EscaparSQL(par_cCPros)

            IF SQLEXEC(gnConnHandle, loc_cSQL, "cursor_4c_DupCheck") > 0
                SELECT cursor_4c_DupCheck
                loc_lDuplicado = NVL(nExiste, 0) > 0
                USE IN cursor_4c_DupCheck
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.ValidarCaracteristicaDuplicada")
        ENDTRY

        RETURN loc_lDuplicado
    ENDPROC

    *--------------------------------------------------------------------------
    * ValidarDados - Valida dados antes de Inserir/Atualizar
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ValidarDados()
        IF EMPTY(ALLTRIM(THIS.this_cCodigos))
            MsgAviso("Informe o c" + CHR(243) + "digo da caracter" + CHR(237) + "stica.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        IF EMPTY(ALLTRIM(THIS.this_cCPros))
            MsgAviso("C" + CHR(243) + "digo do produto n" + CHR(227) + "o informado.", ;
                     "Valida" + CHR(231) + CHR(227) + "o")
            RETURN .F.
        ENDIF

        RETURN .T.
    ENDPROC

    *--------------------------------------------------------------------------
    * Inserir - Insere nova caracter" + CHR(237) + "stica no SQL Server
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Inserir()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            *-- Gera chave prim" + CHR(225) + "ria se n" + CHR(227) + "o informada
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                THIS.this_cPkChaves = LEFT(SYS(2015) + SYS(2015), 20)
            ENDIF

            loc_cSQL = "INSERT INTO sigprcar " + ;
                       "(codigos, cpros, pkchaves) " + ;
                       "VALUES (" + ;
                       EscaparSQL(THIS.this_cCodigos) + ", " + ;
                       EscaparSQL(THIS.this_cCPros) + ", " + ;
                       EscaparSQL(THIS.this_cPkChaves) + ")"

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("INSERIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao inserir caracter" + CHR(237) + "stica.", "SigPrCarBO.Inserir")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.Inserir")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * Atualizar - Atualiza c" + CHR(243) + "digo da caracter" + CHR(237) + "stica no SQL Server
    * (descrs n" + CHR(227) + "o " + CHR(233) + " persistida - vem de JOIN com SIGCRRAP)
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE Atualizar()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF !THIS.ValidarDados()
                loc_lSucesso = .F.
            ENDIF

            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgAviso("Caracter" + CHR(237) + "stica sem chave prim" + CHR(225) + "ria.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "UPDATE sigprcar " + ;
                       "SET codigos = " + EscaparSQL(THIS.this_cCodigos) + " " + ;
                       "WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("ALTERAR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao atualizar caracter" + CHR(237) + "stica.", "SigPrCarBO.Atualizar")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.Atualizar")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

    *--------------------------------------------------------------------------
    * ExecutarExclusao - Exclui caracter" + CHR(237) + "stica do SQL Server
    *--------------------------------------------------------------------------
    PROTECTED PROCEDURE ExecutarExclusao()
        LOCAL loc_lSucesso, loc_cSQL, loc_oErro

        loc_lSucesso = .F.

        TRY
            IF EMPTY(ALLTRIM(THIS.this_cPkChaves))
                MsgAviso("Nenhuma caracter" + CHR(237) + "stica selecionada para exclus" + CHR(227) + "o.", ;
                         "Valida" + CHR(231) + CHR(227) + "o")
                loc_lSucesso = .F.
            ENDIF

            loc_cSQL = "DELETE FROM sigprcar " + ;
                       "WHERE pkchaves = " + EscaparSQL(THIS.this_cPkChaves)

            IF SQLEXEC(gnConnHandle, loc_cSQL) > 0
                THIS.RegistrarAuditoria("EXCLUIR")
                loc_lSucesso = .T.
            ELSE
                MsgErro("Erro ao excluir caracter" + CHR(237) + "stica.", "SigPrCarBO.ExecutarExclusao")
            ENDIF

        CATCH TO loc_oErro
            MsgErro(loc_oErro.Message, "SigPrCarBO.ExecutarExclusao")
        ENDTRY

        RETURN loc_lSucesso
    ENDPROC

ENDDEFINE

