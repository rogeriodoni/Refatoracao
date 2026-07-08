# CODE REVIEW - PASS GRID: Grid/Cursor Configuration

## TAREFA OBRIGATORIA
Corrigir TODOS os problemas listados abaixo. Este pass foca em: **Grid/Cursor Configuration**.

## PROBLEMAS DETECTADOS (1)
- [GRID-RECORDSOURCE-AUTOBIND] Linha 487: RecordSource reatribuido mas ControlSource NAO redefinido nas proximas linhas. VFP faz auto-bind pela ordem dos campos do cursor, ignorando ControlSource anterior. CORRIGIR: Re-definir .ControlSource de TODAS as colunas APOS .RecordSource = ...

## INSTRUCOES DE CORRECAO
### Foco deste pass: CORRECOES GRID/CURSOR
- [MADDCOLUNA] mAddColuna com parametro numerico. Assinatura: (campo, mascara, titulo) - TODOS strings
- [GRID-HEADERS] Apos RecordSource, Header1.Caption resetado para nome do campo. REDEFINIR todos os captions
- [SQLEXEC-GRID] SQLEXEC direto no cursor do Grid destroi colunas. Usar cursor temp + ZAP + APPEND
- [CREATE-CURSOR-NULL] SET NULL ON antes de CREATE CURSOR (APPEND de dados com NULL falha)
- [RECORDSOURCE-WITH] RecordSource/ColumnCount FORA do WITH block (dentro causa "Unknown member COLUMN1")
- [CURSOR-DUPLICADO] CREATE CURSOR duplicado com ordem diferente de campos
- [GRID-RECORDSOURCE-AUTOBIND] Apos .RecordSource =, REDEFINIR .ControlSource de TODAS as colunas

## REGRAS OBRIGATORIAS
- Corrigir APENAS os problemas listados, NAO alterar logica de negocio
- NAO remover campos, funcionalidades ou lookups
- **PROIBIDO alterar propriedades visuais** (Width, Height, Top, Left, BackColor, ForeColor, FontName, FontSize) EXCETO se o problema eh especificamente de ALINHAMENTO
- NUNCA juntar linhas com `;` numa linha unica
- Usar Write tool para salvar os arquivos corrigidos nos mesmos caminhos


## CODIGO ATUAL DOS ARQUIVOS

### FORM (C:\4c\projeto\app\forms\relatorios\FormSigReFtp.prg) - TRECHOS RELEVANTES PARA PASS GRID (951 linhas total):

*-- Linhas 367 a 457:
367:                 RETURN
368:             ENDIF
369:         ENDIF
370:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
371:             THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
372:         ENDIF
373:         THIS.Refresh()
374:     ENDPROC
375: 
376:     *--------------------------------------------------------------------------
377:     * BtnAlterarClick - Alterna marca do processo corrente (toggle lMarca)
378:     *   Form REPORT (frmrelatorio): "Alterar" no contexto de selecao significa
379:     *   inverter a marca do registro corrente no grid, refletindo no checkbox.
380:     *--------------------------------------------------------------------------
381:     PROCEDURE BtnAlterarClick()
382:         LOCAL loc_lAtual
383:         TRY
384:             IF !USED("cursor_4c_SelSigReFtp") OR EOF("cursor_4c_SelSigReFtp")
385:                 MsgAviso("Nenhum processo selecionado no grid.", "Aten" + CHR(231) + CHR(227) + "o")
386:                 RETURN
387:             ENDIF
388:             SELECT cursor_4c_SelSigReFtp
389:             loc_lAtual = lMarca
390:             REPLACE lMarca WITH !loc_lAtual IN cursor_4c_SelSigReFtp
391:             IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
392:                 THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
393:             ENDIF
394:             THIS.Refresh()
395:         CATCH TO loc_oErro
396:             MsgErro(loc_oErro.Message, "Erro em BtnAlterarClick")
397:         ENDTRY
398:     ENDPROC
399: 
400:     *--------------------------------------------------------------------------
401:     * BtnExcluirClick - Desmarca TODOS os processos do relatorio
402:     *   Form REPORT (frmrelatorio): "Excluir" no contexto de selecao significa
403:     *   limpar todas as marcas (remover todos da fila de impressao).
404:     *   Equivale a clicar em "Limpar Selecao" (CmdApg.Click do legado).
405:     *--------------------------------------------------------------------------
406:     PROCEDURE BtnExcluirClick()
407:         IF VARTYPE(THIS.this_oRelatorio) = "O"
408:             IF !THIS.this_oRelatorio.DesmarcarTodos()
409:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
410:                 RETURN
411:             ENDIF
412:         ENDIF
413:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
414:             THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
415:         ENDIF
416:         THIS.Refresh()
417:     ENDPROC
418: 
419:     *--------------------------------------------------------------------------
420:     * ConfigurarPaginaLista - Grid de selecao de processos + botoes auxiliares
421:     *   Equivalente a: GrdProc + cmdSel + CmdApg do legado SIGREFTP.
422:     *   Adicionados dentro de cnt_4c_Corpo (criado em ConfigurarPageFrame).
423:     *
424:     *   Posicoes originais (relativas ao form); ajustadas para cnt_4c_Corpo (Top=85):
425:     *     grd_4c_Dados:    top=79  (164-85), left=385, w=318, h=387
426:     *     cmd_4c_SelTodos: top=228 (313-85), left=707, w=100, h=25
427:     *     cmd_4c_LimparSel:top=268 (353-85), left=707, w=100, h=25
428:     *--------------------------------------------------------------------------
429:     PROTECTED PROCEDURE ConfigurarPaginaLista()
430:         LOCAL loc_oCorp, loc_oGrid
431:         TRY
432:             loc_oCorp = THIS.cnt_4c_Corpo
433: 
434:             *-- Grid de processos (GrdProc no legado)
435:             loc_oCorp.AddObject("grd_4c_Dados", "Grid")
436:             loc_oGrid = loc_oCorp.grd_4c_Dados
437:             WITH loc_oGrid
438:                 .Top                = 79
439:                 .Left               = 385
440:                 .Width              = 318
441:                 .Height             = 387
442:                 .ColumnCount        = 4
443:                 .RecordMark         = .F.
444:                 .DeleteMark         = .F.
445:                 .GridLines          = 1
446:                 .ScrollBars         = 3
447:                 .HighlightStyle     = 2
448:                 .HighlightBackColor = RGB(255, 255, 255)
449:                 .HighlightForeColor = RGB(15, 41, 104)
450:                 .FontName           = "Verdana"
451:                 .FontSize           = 8
452: 
453:                 *-- Column1: CheckBox de selecao (lMarca)
454:                 *   Ordem OBRIGATORIO: AddObject ANTES de CurrentControl,
455:                 *   ControlSource SOMENTE apos CurrentControl (Error 1767)
456:                 WITH .Column1
457:                     .Width          = 35

*-- Linhas 473 a 510:
473:                     .Width         = 45
474:                     .Resizable     = .F.
475:                     .ControlSource = "cursor_4c_SelSigReFtp.Grupos"
476:                 ENDWITH
477: 
478:                 WITH .Column4
479:                     .Width         = 193
480:                     .Resizable     = .T.
481:                     .ReadOnly      = .T.
482:                     .ControlSource = "cursor_4c_SelSigReFtp.Descrps"
483:                 ENDWITH
484: 
485:                 *-- RecordSource ao final (reset de cabecalhos!)
486:                 IF USED("cursor_4c_SelSigReFtp")
487:                     .RecordSource     = "cursor_4c_SelSigReFtp"
488:                     .RecordSourceType = 1
489:                 ENDIF
490: 
491:                 *-- Redefinir cabecalhos APOS RecordSource (obrigatorio)
492:                 .Column1.Header1.Caption = ""
493:                 .Column2.Header1.Caption = "Ordem"
494:                 .Column3.Header1.Caption = "Grupo"
495:                 .Column4.Header1.Caption = "Descri" + CHR(231) + CHR(227) + "o"
496: 
497:                 .Visible = .T.
498:             ENDWITH
499: 
500:             *-- Botao Selecionar Todos (cmdSel no legado)
501:             loc_oCorp.AddObject("cmd_4c_SelTodos", "CommandButton")
502:             WITH loc_oCorp.cmd_4c_SelTodos
503:                 .Top           = 228
504:                 .Left          = 707
505:                 .Width         = 100
506:                 .Height        = 25
507:                 .Caption       = "Selecionar Todos"
508:                 .FontName      = "Tahoma"
509:                 .FontSize      = 8
510:                 .BackColor     = RGB(255, 255, 255)

*-- Linhas 532 a 552:
532:             ENDWITH
533: 
534:             *-- BINDEVENTs: grid, checkbox da coluna 1, botoes auxiliares
535:             BINDEVENT(loc_oCorp.grd_4c_Dados, "AfterRowColChange", ;
536:                 THIS, "GrdAfterRowColChange")
537:             BINDEVENT(loc_oCorp.grd_4c_Dados.Column1.Check1, "Click", ;
538:                 THIS, "GrdCheckClick")
539:             BINDEVENT(loc_oCorp.cmd_4c_SelTodos,  "Click", THIS, "BtnSelTodosClick")
540:             BINDEVENT(loc_oCorp.cmd_4c_LimparSel, "Click", THIS, "BtnLimparSelClick")
541: 
542:         CATCH TO loc_oErro
543:             MsgErro(loc_oErro.Message + CHR(13) + ;
544:                 "Linha: " + TRANSFORM(loc_oErro.LineNo) + CHR(13) + ;
545:                 "Procedure: " + loc_oErro.Procedure, ;
546:                 "Erro em ConfigurarPaginaLista")
547:         ENDTRY
548:     ENDPROC
549: 
550:     *--------------------------------------------------------------------------
551:     * ConfigurarPaginaDados - Label Produto + textboxes codigo/descricao + imagem
552:     *   Fase 5 - Parte 1: primeiros 50% dos campos do corpo do form.

*-- Linhas 774 a 832:
774:         LOCAL loc_lNovaMarca, loc_nVal
775:         TRY
776:             IF USED("cursor_4c_SelSigReFtp") AND !EOF("cursor_4c_SelSigReFtp")
777:                 loc_nVal = THIS.cnt_4c_Corpo.grd_4c_Dados.Column1.Check1.Value
778:                 IF VARTYPE(loc_nVal) = "L"
779:                     loc_lNovaMarca = loc_nVal
780:                 ELSE
781:                     loc_lNovaMarca = (loc_nVal = 1)
782:                 ENDIF
783:                 REPLACE lMarca WITH loc_lNovaMarca IN cursor_4c_SelSigReFtp
784:             ENDIF
785:         CATCH TO loc_oErro
786:             MsgErro(loc_oErro.Message, "Erro em GrdCheckClick")
787:         ENDTRY
788:     ENDPROC
789: 
790:     *--------------------------------------------------------------------------
791:     * BtnSelTodosClick - Seleciona todos os processos (cmdSel.Click no legado)
792:     *   Replace All lMarca With .T. -> BO.MarcarTodos()
793:     *--------------------------------------------------------------------------
794:     PROCEDURE BtnSelTodosClick()
795:         IF VARTYPE(THIS.this_oRelatorio) = "O"
796:             IF !THIS.this_oRelatorio.MarcarTodos()
797:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
798:             ENDIF
799:         ENDIF
800:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
801:             THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
802:         ENDIF
803:         THIS.Refresh()
804:     ENDPROC
805: 
806:     *--------------------------------------------------------------------------
807:     * BtnLimparSelClick - Desmarca todos os processos (CmdApg.Click no legado)
808:     *   Replace All lMarca With .F. -> BO.DesmarcarTodos()
809:     *--------------------------------------------------------------------------
810:     PROCEDURE BtnLimparSelClick()
811:         IF VARTYPE(THIS.this_oRelatorio) = "O"
812:             IF !THIS.this_oRelatorio.DesmarcarTodos()
813:                 MsgErro(THIS.this_oRelatorio.ObterMensagemErro(), "Erro")
814:             ENDIF
815:         ENDIF
816:         IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
817:             THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
818:         ENDIF
819:         THIS.Refresh()
820:     ENDPROC
821: 
822:     *--------------------------------------------------------------------------
823:     * BtnEncerrarClick - Fecha o formulario (alias canonico de BtnSairClick)
824:     *--------------------------------------------------------------------------
825:     PROCEDURE BtnEncerrarClick()
826:         THIS.Release()
827:     ENDPROC
828: 
829:     *--------------------------------------------------------------------------
830:     * BtnBuscarClick - N/A para form REPORT com parametros (sem busca livre)
831:     *   Mantido para compatibilidade com pipeline generica de forms.
832:     *--------------------------------------------------------------------------

*-- Linhas 900 a 938:
900:             ENDIF
901: 
902:             *-- Atualiza grid
903:             IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
904:                 THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
905:             ENDIF
906:         CATCH TO loc_oErro
907:             MsgErro(loc_oErro.Message, "Erro em LimparCampos")
908:         ENDTRY
909:     ENDPROC
910: 
911:     *--------------------------------------------------------------------------
912:     * CarregarLista - Recarrega grid a partir do cursor de selecao
913:     *   Para form REPORT: o cursor cursor_4c_SelSigReFtp ja existe;
914:     *   apenas reposiciona no inicio e atualiza o grid.
915:     *--------------------------------------------------------------------------
916:     PROCEDURE CarregarLista()
917:         LOCAL loc_lSucesso
918:         loc_lSucesso = .F.
919:         TRY
920:             IF USED("cursor_4c_SelSigReFtp")
921:                 GO TOP IN cursor_4c_SelSigReFtp
922:                 IF PEMSTATUS(THIS.cnt_4c_Corpo, "grd_4c_Dados", 5)
923:                     THIS.cnt_4c_Corpo.grd_4c_Dados.Refresh()
924:                 ENDIF
925:                 loc_lSucesso = .T.
926:             ENDIF
927:         CATCH TO loc_oErro
928:             MsgErro(loc_oErro.Message, "Erro em CarregarLista")
929:         ENDTRY
930:         RETURN loc_lSucesso
931:     ENDPROC
932: 
933:     *--------------------------------------------------------------------------
934:     * AjustarBotoesPorModo - N/A para form REPORT (sem modos CRUD)
935:     *   Mantido para compatibilidade com pipeline generica de forms.
936:     *--------------------------------------------------------------------------
937:     PROTECTED PROCEDURE AjustarBotoesPorModo()
938:         RETURN

